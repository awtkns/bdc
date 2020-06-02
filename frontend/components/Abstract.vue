<template>
  <div class="mt-4">
    <v-row align="center" no-gutters>
      <v-divider/>
      <span class="mx-4 title" v-text="title" />
      <v-divider/>
    </v-row>
    <v-row justify="center">
      <v-col cols="11">
        <p v-html="text" style="text-align: justify" />
        <b>Keywords</b>
        <v-row no-gutters>
          <span  v-for="k in keywords" v-html="k" />
        </v-row>
      </v-col>
    </v-row>

    <v-divider />
  </div>
</template>

<script>
export default {
  name: "Abstract",
  props: { text: String, keywords: Array },
  data: () => ({ title: 'Abstract' })
}
</script>

<style scoped>

</style>
