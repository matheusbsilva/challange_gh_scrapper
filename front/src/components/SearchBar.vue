<template>
  <div>
    <b-row>
      <b-col lg="12">
        <b-form-input v-model="text" placeholder="Busque um perfil salvo"></b-form-input>
      </b-col>
      <b-col lg="12">
        <div v-if="show" class="results-wrapper">
          <b-col v-for="result in results" :key="result.username" lg="12">
            <b-col class="text-left  my-3">
              <router-link :to="{ name: 'profile', params: { id: result.id } }">
                <img :src="result.profile_img" alt="">
                <span class="ml-3">{{ result.username }}</span>
              </router-link>
            </b-col>
          </b-col>
        </div>
      </b-col>
    </b-row>
  </div>
</template>

<script>
export default {
  name: 'SearchBar',
  data() {
    return {
      text: '',
      results: [
        {'username': 'matz', 'profile_img': 'https://avatars3.githubusercontent.com/u/14370340', id: 1},
        {'username': 'matz', 'profile_img': 'https://avatars3.githubusercontent.com/u/14370340', id: 10}
      ]
    }
  },
  computed: {
    show() {
      return this.results.length !== 0
    }
  }
}
</script>

<style scoped>
.results-wrapper {
  background: #fff;
  color: #000;
  z-index: 3;
  overflow-y: scroll;
  position: absolute;
  right: 0.75rem;
  left: 0.75rem;
  box-shadow: 0 1px 20px 0 rgba(69,90,100,.08);
  border: 1px solid rgb(166, 165, 175, 0.2);

}
.results-wrapper img {
  height: 50px;
}
</style>
