<template>
  <div>
    <b-container>
      <b-row>
        <b-col>
          <b-form-input v-model="username" placeholder="Nome do usuário" class="my-3"></b-form-input>
          <b-form-input v-model="profileUrl" placeholder="Url do perfil do usuário" class="my-3"></b-form-input>
          <b-button variant="success" class="my-3">Enviar</b-button>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
export default {
  name: 'EditForm',
  props: ['id', 'username', 'profileUrl']
}
</script>

<style>
</style>
