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
import { mapGetters }  from 'vuex'
export default {
  name: 'SearchBar',
  data() {
    return {
      text: '',
      results: [
      ]
    }
  },
  computed: {
    show() {
      return this.results.length !== 0
    },
    ...mapGetters({
      getSearchResults: 'profile/getSearchResults'
    })
  },
  methods: {
    clearResults() {
      this.results = []
    }
  },
  watch: {
    async text(val) {
      if(!val) {
        this.clearResults()
        return
      }

      try {
        await this.$store.dispatch('profile/searchProfiles', val)
        this.results = this.getSearchResults
      } catch (err) {
        console.log(err)
      }
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
