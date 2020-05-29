<template>
  <v-row justify="center">
    <v-col lg="8" >'
      <div v-text="this.attributes.subtitle" class="subtitle text-center" />
      <div v-text="this.attributes.title" class="title font-weight-bold mb-2 text-center" />
      <div class="subtitle text-center">
        <span v-for="a in this.attributes.authors" v-html="a" />
      </div>
      <Manuscript class="text-left" />
    </v-col>
  </v-row>
</template>

<script>
import Chart from "../components/Chart";
import fm from '~/articles/manuscript.md'

export default {
  name: 'Blog',
  components: {
    Chart,
    Manuscript: {
      extends: fm.vue.component,
      components: { Chart }
    }
  },
  layout: 'homepage',
  data: () => ({
    attributes: fm.attributes,
    body: undefined
  }),
}
</script>

<style scoped>
* {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}
</style>
