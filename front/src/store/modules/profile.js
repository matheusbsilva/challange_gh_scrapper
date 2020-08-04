import { http } from '../http.common.js'

const state = () => ({
  profileList: [],
  profile: {},
  profileSearch: []
})

const getters = {

  getSearchResults: (state) => {
    return state.profileSearch
  },

  getProfile: (state) => {
    return state.profile
  }
}

const mutations = {
  SET_SEARCH_RESULTS(state, payload) {
    state.profileSearch = payload
  },
  SET_PROFILE(state, payload) {
    state.profile = payload
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
  },

  async fetchProfile({ commit }, id) {
    try {
      const response = await http.get(`/profile/${id}`)
      const payload = response.data

      commit('SET_PROFILE', payload)

    } catch (err) {
      console.log(err)
      return
    }
  },

  async createProfile(_, data) {
    try {
      await http.post('/profile', data)
    } catch(err) {
      console.log(err)
      return
    }
  },

  async updateProfile(_, data) {
    try {
      await http.put(`/profile/${data.id}`, data.body)
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
