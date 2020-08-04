<template>
  <div>
    <b-form-input v-model="text" placeholder="Busque um perfil salvo"></b-form-input>
  </div>
</template>

<script>
export default {
  name: 'SearchBar',
  data() {
    return {
      text: ''
    }
  }
}
</script>

<style scoped>
</style>
