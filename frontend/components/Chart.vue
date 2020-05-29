<template>
  <v-row justify="center">
    <v-col cols="12">
      <v-row justify="center" class="title">{{ barChartSelectedVariable }} per Country</v-row>
      <BarChart :chart-data="barChartData" :options="barChartOptions" :height="200" />
    </v-col>
    <v-col cols="5">
      <v-select
        v-model="barChartSelectedVariable"
        :items="barChartVariables"
        @change="getChartData"
        label="Independent Variable" />
    </v-col>
    <v-col cols="5">
      <v-combobox
        v-model="selectedCountries"
        :items="countries"
        @change="getChartData"
        label="Countries"
        multiple
      />
    </v-col>
  </v-row>
</template>

<script>
import { getBarChartData, getDataset } from "../api";
import BarChart from "~/components/BarChart";

export default {
  name: "Chart",
  components: {BarChart},
  props: {
    slug: {
      type: String,
      default: null
    }
  },
  data: () => ({
    selectedCountries: ['Canada', 'Belize', 'Zimbabwe'],
    countries: [],

    barChartSelectedVariable: 'Computed tomography',
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
  async created() {
    if (this.slug) {
      const ds = await getDataset(this, this.slug);
      this.countries = ds.indices;
      this.barChartVariables = ds.columns;
      this.getChartData()
    }
  },
  methods: {
    async getChartData() {
      this.barChartData = await getBarChartData(this, this.slug, this.barChartSelectedVariable, this.selectedCountries);
    }
  }
}
</script>
