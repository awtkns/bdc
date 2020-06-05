<template>
  <v-img :src="src" />
</template>

<script>
export default {
  name: "ImageFigure",
  props: {
    src: String
  }
}
</script>
