<template>
  <v-row justify="center">
    <v-col lg="8" >
      <n-link :to="{path: 'sources', hash: 'yes'}">here</n-link>
      <a href="sources#yes">here</a>
      <div v-text="attributes.subtitle" class="subtitle text-center" />
      <div v-text="attributes.title" class="title font-weight-bold mb-2 text-center" />
      <div class="subtitle text-center mb-2">
        <span v-for="a in attributes.authors" v-html="a" />
      </div>
      <div v-for="a in attributes.affiliations" class="subtitle text-center" v-text="a" />
      <Abstract :text="attributes.abstract" :keywords="attributes.keywords" class="mb-8"/>
      <Manuscript class="text-justify" />
    </v-col>
  </v-row>
</template>

<script>
import Chart from "../components/Chart";
import fm from '~/articles/main.md'
import {getDatasetNames} from "../api";
import Abstract from "../components/Abstract";
import Table1 from "../components/Table1";
import Table2 from "../components/Table2";
import ImageFigure from "../components/ImageFigure";

export default {
  name: 'Blog',
  components: {
    Abstract,
    Chart,
    Table1,
    Table2,
    ImageFigure,
    Manuscript: {
      extends: fm.vue.component,
      components: { Chart, Table1, Table2, ImageFigure }
    }
  },
  layout: 'homepage',
  data: () => ({
    attributes: fm.attributes,
    body: undefined,
    datasetNames: []
  }),
  async created() {
    this.datasetNames = await getDatasetNames(this)
  },
}
</script>

<style scoped>
* {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}
</style>
