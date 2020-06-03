<template>
  <v-row justify="center">
    <v-col cols="9">
      <v-select
          v-model="selected"
          :items="Object.values(datasetNames)"
          @change="getDataset"
          label="Dataset"
          dense
          outlined
        />
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
import {getDataset, getDatasetNames} from "../api";

export default {
  props: {
    datasetNames: []
  },
  data: () => ({
    selected: undefined,
    dataset: undefined,
  }),
  methods: {
    async getDataset() {
      if (this.selected) {
        this.dataset = await getDataset(this, this.selected);
      }
    }
  }
}
</script>
