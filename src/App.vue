<script>
const baseURL = window.VUE_APP_API_BASE_URL;
export default {
  data() {
    return {
      newTodo: "",
      hideCompleted: false,
      todoData: null,
    };
  },
  computed: {
    filteredTodos() {
      return this.hideCompleted
        ? this.todoData.filter((todo) => !todo.done)
        : this.todoData;
    },
    remaining() {
      if (this.todoData !== null && typeof this.todoData !== "undefined") {
        return this.todoData.filter((todo) => !todo.done).length;
      } else {
        return 0;
      }
    },
  },
  methods: {
    async addTodo() {
      const res = await fetch(baseURL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ text: this.newTodo }),
      });
      const data = await res.json();
      this.todoData.push(data);
      this.newTodo = "";
    },
    async removeTodo(todo) {
      await fetch(baseURL + todo.id, {
        method: "DELETE",
      });
      this.todoData = this.todoData.filter((t) => t !== todo);
    },
    async toggleStatus(todo) {
      await fetch(baseURL + todo.id, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ done: !todo.done }),
      });
    },
    async deleteCompleted() {
      this.todoData.filter((t) => t.done).forEach((d) => this.removeTodo(d));
    },
    async fetchData() {
      this.todoData = null;
      const res = await fetch(baseURL);
      this.todoData = await res.json();
    },
  },
  mounted() {
    this.fetchData();
  },
};
</script>

<template>
  <h1>Todo App</h1>
  <div class="container">
    <div style="flex: 1">
      <div class="input__div">
        <div class="input__wrapper">
          <input
            type="text"
            placeholder="What's next?!"
            v-model="newTodo"
            @keyup.enter="addTodo"
          />
        </div>
        <div class="border"></div>
      </div>

      <p v-if="!todoData">Loading data from {{ baseURL }}...</p>
      <div class="todo-list" v-else>
        <div v-if="filteredTodos.length==0" class="text">empty list</div>
        <div v-else>
          <div v-for="todo in filteredTodos" :key="todo.id" class="list">
            <label class="material-checkbox">
              <input
                type="checkbox"
                v-model="todo.done"
                @click="toggleStatus(todo)"
              />
              <span></span>
            </label>
            <div class="text" :class="{ done: todo.done }">{{ todo.text }}</div>
            <button @click="removeTodo(todo)">X</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <footer>
    <span class="text">{{ remaining }} items left.</span>
    <button
      class="summaryButton"
      @click="deleteCompleted()"
      style="float: right"
    >
      Delete completed
    </button>
    <button class="summaryButton" @click="hideCompleted = !hideCompleted">
      {{ hideCompleted ? "Show all" : "Hide completed" }}
    </button>
  </footer>
</template>

<style>
* {
  box-sizing: border-box;
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
}
body {
  -moz-osx-font-smoothing: grayscale;
  -webkit-font-smoothing: antialiased;
  color: #2c3e50;
  font-family: Karla, sans-serif;
  font-size: 16px;
  margin: 0;
}
h1 {
  text-align:center;
}
span.text {
  color: antiquewhite;
}
#app {
  max-width: 510px;
  margin: 50px auto;
  padding: 0 10px;
}
.container {
  min-height: 300px;
  display: flex;
  flex-direction: column;
}
footer {
  padding: 8px 15px;
  background: #3882c7;
  border-radius: 3px;
}
.summaryButton {
  float: right;
  margin-left: 10px;
  margin-right: 10px;
}
.todo-list {
  padding: 8px 0;
}
.todo-list .list:hover {
  background: #68a8e3;
}
.todo-list .list {
  display: flex;
  align-items: center;
  padding: 0 15px;
}
.todo-list .list .text {
  padding: 0 8px;
  height: 35px;
  line-height: 35px;
  margin: 6px 0;
  cursor: default;
  flex: 1;
}
.todo-list .list .text.done {
  text-decoration: line-through;
}
.input__div {
  margin: 6px 0;
  position: relative;
  border: 1px solid #68a8e3;
  flex: 1;
}
.input__div:focus-within .input__wrapper {
  background: #fff;
}
.input__div .input__wrapper {
  background: #bfe0ff;
  padding: 0 15px;
  transition: background 0.3s;
}
.input__div .input__wrapper input {
  height: 35px;
  background: 0 0;
  border: none;
  color: #2c3e50;
  display: block;
  font-family: inherit;
  font-size: 16px;
  line-height: 16px;
  outline: 0;
  padding: 0;
  position: relative;
  width: 100%;
  z-index: 1;
}
.input__div .border {
  background: #0e60ad;
  transition: all 0.18s;
  bottom: -1px;
  height: 2px;
  left: 30%;
  opacity: 0;
  pointer-events: none;
  position: absolute;
  right: 30%;
}
.input__div:focus-within .border {
  left: 0;
  right: 0;
  opacity: 1;
}
.material-checkbox {
  position: relative;
  display: inline-block;
  color: rgba(0, 0, 0, 0.87);
  cursor: pointer;
  font-size: 14px;
  line-height: 18px;
}
.material-checkbox > input {
  appearance: none;
  -moz-appearance: none;
  -webkit-appearance: none;
  position: absolute;
  z-index: -1;
  left: -5px;
  top: -5px;
  display: block;
  margin: 0;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  background-color: rgba(0, 0, 0, 0.42);
  outline: none;
  opacity: 0;
  transform: scale(1);
  -ms-transform: scale(0); /* Graceful degradation for IE */
  transition: opacity 0.5s, transform 0.5s;
}
.material-checkbox > input:checked {
  background-color: #2196f3;
}
.material-checkbox > input:disabled {
  opacity: 0;
}
.material-checkbox > input:disabled + span {
  cursor: initial;
}
.material-checkbox > span::before {
  content: "";
  display: inline-block;
  margin-right: 15px;
  border: solid 2px rgba(0, 0, 0, 0.42);
  border-radius: 2px;
  width: 14px;
  height: 14px;
  vertical-align: -4px;
  transition: border-color 0.5s, background-color 0.5s;
}
.material-checkbox > input:checked + span::before {
  border-color: #3882c7;
  background-color: #3882c7;
}
.material-checkbox > input:active + span::before {
  border-color: #3882c7;
}
.material-checkbox > input:checked:active + span::before {
  border-color: transparent;
  background-color: rgba(0, 0, 0, 0.42);
}
.material-checkbox > span::after {
  content: "";
  display: inline-block;
  position: absolute;
  top: 0;
  left: 0;
  width: 5px;
  height: 10px;
  border: solid 2px transparent;
  border-left: none;
  border-top: none;
  transform: translate(5.5px, 1px) rotate(45deg);
  -ms-transform: translate(5.5px, 2px) rotate(45deg);
}
.material-checkbox > input:checked + span::after {
  border-color: #fff;
}
</style>
