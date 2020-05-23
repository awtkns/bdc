<template>
  <v-row justify="center">
    <v-data-table v-if="msg" :items="msg.items" :headers="msg.headers" dense>
      <template v-slot:top>
        <span class="text-center display-1">{{ msg.title }}</span>
      </template>
    </v-data-table>
  </v-row>
</template>

<script>
export default {
  data: () => ({
    msg: undefined
  }),
  async created() {
    const response = await this.$axios.get('/');
    this.msg = response.data;
    console.log(this.msg)
  }
}
</script>
