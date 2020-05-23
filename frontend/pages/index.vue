<template>
  <v-row justify="center">
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
export default {
  data: () => ({
    slugs: [],
    selected: undefined,
    dataset: undefined
  }),
  async created() {
    const response = await this.$axios.get('/');
    this.slugs = response.data.slugs;
    this.selected = this.slugs[0];
    await this.getDataset()
  },
  methods: {
    async getDataset() {
      this.dataset = (await this.$axios.get(`/${this.selected.slug}`)).data
    }
  }
}
</script>
