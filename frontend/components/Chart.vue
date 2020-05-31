<template>
  <v-row justify="center">
    <v-col cols="12">
      <v-row justify="center" class="title" v-text="title" />
      <BarChart :chart-data="barChartData" :options="barChartOptions" :height="200" />
    </v-col>
    <v-col v-if="controls" cols="5" :order="this.transpose ? '1': '3'">
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
    <v-col v-if="controls" cols="1" order="2" class="text-center">
       <v-btn @click="swap" icon><v-icon v-text="'mdi-swap-horizontal'" /></v-btn>
    </v-col>
    <v-col v-if="controls" cols="5" :order="this.transpose ? '3': '1'">
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
import 'chartjs-plugin-colorschemes';

export default {
  name: "Chart",
  components: {BarChart},
  props: {
    slug: {
      type: String,
      default: null
    },
    controls: Boolean,
    title: String
  },
  data: () => ({
    selectedCountries: ['Canada', 'Belize', 'Zimbabwe'],
    countries: [],
    transpose: true,

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
      plugins: {
        colorschemes: {
          scheme: 'brewer.SetOne9'
        }
      },
      scales: {
        yAxes: [{
            scaleLabel: {
              display: true,
              labelString: 'Units per Million People'
            },
            ticks: {
              beginAtZero: true
            }
          }]
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
    otherText: (ctx) => `(+${ctx.selectedCountries.length - 2} others)`
  },
  methods: {
    async getChartData() {
      this.barChartData = await getBarChartData(this, this.slug, this.barChartSelectedVariable, this.selectedCountries, this.transpose);
    },
    swap() {
      this.transpose = !this.transpose;
      this.getChartData()
    }
  }
}
</script>
