<template>
  <v-row justify="center">
    <v-col lg="8" >'
      <div v-text="this.attributes.subtitle" class="subtitle text-center" />
      <div v-text="this.attributes.title" class="title font-weight-bold mb-2 text-center" />
      <div class="subtitle text-center">
        <span v-for="a in this.attributes.authors" v-html="a" />
      </div>
      <component v-bind:is="body" class="text-left" />
    </v-col>
  </v-row>
</template>

<script>
export default {
  name: 'Blog',
  layout: 'homepage',
  data: () => ({
    attributes: undefined,
    body: undefined
  }),
  created() {
    const fm = require(`~/articles/test.md`)
    this.body = fm.vue.component
    this.attributes = fm.attributes
  }
}
</script>

<style scoped>
* {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}
</style>
