<template>
  <v-row justify="center">

    <div class="container">
      <bar-chart :data="barChartData" :options="barChartOptions" :height="100" />
    </div>

    <v-col cols="4">
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

    barChartVariable: 1,
    barChartData: undefined,
    barChartOptions: undefined
  }),

  async created() {
    const response = await this.$axios.get('/');
    this.slugs = response.data.slugs;
    this.selected = this.slugs[0];
    await Promise.all([
      this.getDataset(),
      this.getBarChartData()
    ])
  },

  methods: {
    async getDataset() {
      this.dataset = (await this.$axios.get(`/${this.selected.slug}`)).data
    },

    async getBarChartData() {
      this.barChartData = (await this.$axios.get(`/${this.selected.slug}`, {headers: {'col': `${this.barChartVariable}`}})).data
    }
  }
}
</script>
