<template>
  <v-row justify="center">

    <v-col cols="9">
      <v-select v-model="barChartSelectedVariable" :items="barChartVariables" @change="getBarChartData" label="Independent Variable" />
    </v-col>

    <v-col cols="9">
      <v-combobox
        v-model="selectedCountries"
        :items="countries"
        @change="getBarChartData"
        label="Countries"
        multiple
      ></v-combobox>
    </v-col>

    <div class="container">
      <bar-chart :chart-data="barChartData" :options="barChartOptions" :height="200" />
    </div>

    <v-col cols="9">
      <v-select v-model="selected" :items="slugs" item-text="title" return-object @change="getDataset" label="Dataset" />
    </v-col>

    <v-card outlined>
      <v-data-table v-if="dataset" :items="dataset.table.items" :headers="dataset.table.headers" dense>
        <template v-slot:top>
          <v-toolbar class="text-center display-1" flat>
            <v-spacer/>
            {{ dataset.title }}
            <v-spacer/>
          </v-toolbar>
        </template>
      </v-data-table>
    </v-card>
  </v-row>
</template>

<script>
import BarChart from '~/components/BarChart'
import LineChart from '~/components/LineChart'

export default {
  components: {
    BarChart,
    LineChart
  },

  data: () => ({
    slugs: [],
    selected: undefined,
    dataset: undefined,

    selectedCountries: ['Canada', 'Belize', 'Zimbabwe'],
    countries: [],

    barChartSelectedVariable: ['Computed tomography'],
    barChartVariables: [],
    barChartData: undefined,
    
    barChartOptions: {
      responsive: true,
      legend: {
        display: false,
      },
      title: {
        display: false,
        text: ''
      },
      scales: {
        yAxes: [
          {
            ticks: {
              beginAtZero: true
            }
          }
        ]
      }
    }
  }),

  async mounted() {
    const response = await this.$axios.get('/');
    this.slugs = response.data.slugs;
    this.selected = this.slugs[2];
    await Promise.all([
      this.getDataset(),
      this.getBarChartData()
    ])
    this.countries = this.dataset.indices
    this.barChartVariables = this.dataset.columns
  },

  methods: {
    async getDataset() {
      this.dataset = (await this.$axios.get(`/dataset/${this.selected.slug}`)).data
    },

    async getBarChartData() {
      this.barChartData = (await this.$axios.get(`/barChartData/${this.selected.slug}`, {headers: {
        'col': `${this.barChartSelectedVariable}`,
        'countries': JSON.stringify(this.selectedCountries)
      }})).data
    }
  }
}
</script>
