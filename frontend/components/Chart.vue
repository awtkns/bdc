<template>
  <v-row justify="center">
    <v-col cols="12">
      <v-row justify="center" class="title" v-text="title" />
      <BarChart v-if="type == 'bar'" :chart-data="chartData" :options="chartOptions" :height="200" />
      <LineChart v-if="type == 'line'" :chart-data="chartData" :options="chartOptions" :height="200" />
    </v-col>
    <v-row v-if="controls" justify="center">
      <v-col cols="5" :order="this.transpose ? '1': '3'">
        <v-combobox
          v-if="type == 'bar'"
          v-model="selectedVariables"
          :items="variables"
          @change="getChartData"
          label="Dependent Variables"
          multiple
          dense
          outlined
        >
        <template v-slot:prepend-item>
          <v-list-item>
            <v-list-item-action>
              <v-checkbox @change="selectAllVariables" />
            </v-list-item-action>
            <v-list-item-title>
              Select ALL
            </v-list-item-title>
          </v-list-item>
          <v-divider />
        </template>
          <template v-slot:selection="{ item, index }">
            <span v-if="index < 3" v-text="`${item}${index < (selectedVariables.length - 2) ? ',' : ''}`" class="pr-1" />
            <span v-if="index === 3" class="grey--text caption" v-text="otherText">
            </span>
          </template>
        </v-combobox>

        <v-select
          v-if="type == 'line'"
          v-model="selectedVariables[0]"
          :items="variables"
          @change="getChartData"
          label="Dependent Variables"
          dense
          outlined
        />
      </v-col>

      <v-col cols="1" order="2" class="text-center">
        <v-btn @click="swap" icon><v-icon v-text="'mdi-swap-horizontal'" /></v-btn>
      </v-col>

      <v-col cols="5" :order="this.transpose ? '3': '1'">
        <v-combobox
          v-model="selectedCountries"
          :items="countries"
          @change="getChartData"
          label="Countries"
          multiple
          dense
          outlined
        >
          <template v-slot:prepend-item>
          <v-list-item>
            <v-list-item-action>
              <v-checkbox @change="selectAllCountries" />
            </v-list-item-action>
            <v-list-item-title>
              Select ALL
            </v-list-item-title>
          </v-list-item>
          <v-divider />
        </template>
          <template v-slot:selection="{ item, index }">
            <span v-if="index < 3" v-text="`${item}${index < (selectedCountries.length - 2) ? ',' : ''}`" class="pr-1" />
            <span v-if="index === 3" class="grey--text caption" v-text="otherText">
            </span>
          </template>
        </v-combobox>
      </v-col>
    </v-row>
  </v-row>
</template>

<script>
import { getBarChartData, getLineChartData, getDataset } from "~/api";
import BarChart from "~/components/BarChart";
import LineChart from "~/components/LineChart";
import 'chartjs-plugin-colorschemes';

export default {
  name: "Chart",
  components: {BarChart, LineChart},
  props: {
    type: String,
    datasetName: String,
    title: String,
    controls: Boolean
  },
  data: () => ({
    selectedCountries: ['Canada', 'Belize', 'Zimbabwe'],
    countries: [],
    transpose: true,

    selectedVariables: [],
    variables: [],
    
    chartData: undefined,
    chartOptions: {
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
    if (this.datasetName != null) {
      const ds = await getDataset(this, this.datasetName);
      this.countries = ds.indices;
      this.variables = ds.columns;
      if (this.variables[0] == "year") this.variables.shift();
      this.selectedVariables = [this.variables[0]];
      this.getChartData();
    }
  },
  computed: {
    otherText: (ctx) => `(+${ctx.selectedCountries.length - 2} others)`,
    barChartOptions() {
      return {
        responsive: true,
        legend: {
          display: this.barChartData ? this.barChartData.datasets.length < 10 : false,
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
    }
  },
  methods: {
    async getChartData() {
      if (this.type == "bar") this.chartData = await getBarChartData(this, this.datasetName, this.selectedVariables, this.selectedCountries, this.transpose);
      else this.chartData = await getLineChartData(this, this.datasetName, this.selectedVariables, this.selectedCountries, this.transpose);
    },
    swap() {
      this.transpose = !this.transpose;
      this.getChartData();
    },
    selectAllVariables(selected) {
      if (selected) this.selectedVariables = this.variables;
      else this.selectedVariables = [];
      this.getChartData();
    },
    selectAllCountries(selected) {
      if (selected) this.selectedCountries = this.countries;
      else this.selectedCountries = [];
      this.getChartData();
    }
  }
}
</script>
