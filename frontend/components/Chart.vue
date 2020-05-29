<template>
  <v-row justify="center">
    <v-col cols="12">
      <v-row justify="center" class="title" v-text="chartTile" />
      <BarChart :chart-data="barChartData" :options="barChartOptions" :height="200" />
    </v-col>
    <v-col cols="5">
      <v-combobox
        v-model="barChartSelectedVariable"
        :items="barChartVariables"
        @change="getChartData"
        label="Independent Variable"
        multiple
        dense
        outlined
      >
        <template v-slot:selection="{ item, index }">
          <span v-if="index < 3" v-text="`${item}${index < (selectedCountries.length - 2) ? ',' : ''}`" class="pr-1" />
          <span v-if="index === 3" class="grey--text caption" v-text="otherText">
          </span>
        </template>
      </v-combobox>
    </v-col>
    <v-col cols="5">
      <v-combobox
        v-model="selectedCountries"
        :items="countries"
        @change="getChartData"
        label="Countries"
        multiple
        dense
        outlined
      >
        <template v-slot:selection="{ item, index }">
          <span v-if="index < 3" v-text="`${item}${index < (selectedCountries.length - 2) ? ',' : ''}`" class="pr-1" />
          <span v-if="index === 3" class="grey--text caption" v-text="otherText">
          </span>
        </template>
      </v-combobox>
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

    barChartSelectedVariable: ['Computed tomography'],
    barChartVariables: [],
    barChartData: undefined,

    barChartOptions: {
      responsive: true,
      legend: {
        display: true,
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
  computed: {
    chartTile: (ctx) => {
      if (ctx.barChartSelectedVariable.length === 1) return `${ctx.barChartSelectedVariable[0]} per Country`;
      else if (ctx.barChartSelectedVariable.length === 2) return `${ctx.barChartSelectedVariable[0]} and ${ctx.barChartSelectedVariable[1]} per Country`
      else return `Multiple factors per Country`
    },
    otherText: (ctx) => `(+${ctx.selectedCountries.length - 2} others)`
  },
  methods: {
    async getChartData() {
      this.barChartData = await getBarChartData(this, this.slug, this.barChartSelectedVariable, this.selectedCountries);
    }
  }
}
</script>
