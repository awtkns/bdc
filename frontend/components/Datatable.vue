<template>
  <v-row justify="center">
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
import {getDataset, getSlugs} from "../api";

export default {
  props: {
    slugs: []
  },
  data: () => ({
    selected: undefined,
    dataset: undefined,
  }),
  methods: {
    async getDataset() {
      if (this.selected) {
        this.dataset = await getDataset(this, this.selected.slug)
      }
    }
  }
}
</script>
