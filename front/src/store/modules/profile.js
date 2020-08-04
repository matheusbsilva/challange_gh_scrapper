import { http } from '../http.common.js'

const state = () => ({
  profileList: [],
  profile: {},
  profileSearch: []
})

const getters = {

  getSearchResults: (state) => {
    return state.profileSearch
  }
}

const mutations = {
  SET_SEARCH_RESULTS(state, payload) {
    state.profileSearch = payload
  }
}

const actions = {

  async searchProfiles({ commit }, query) {
    try {
      const response = await http.get(`/profile?q=${query}`)
      const payload = response.data

      commit('SET_SEARCH_RESULTS', payload)

    } catch (err) {
      console.log(err)
      return
    }
  }


}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
