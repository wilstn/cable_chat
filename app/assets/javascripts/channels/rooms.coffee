jQuery(document).on 'turbolink:load', ->
  messages = $('#messages')
  if $('#messages').length > 0

    App.global_chat = App.cable.subscriptions.create {
      channel: "ChatRoomsChannel"
      chat_room_id: ''
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        # Data received

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id  # '@perform' in coffeescript refers to this. => this.perform


    $('#new_message').submit(e) ->
      $this = $(this) # '$this' vs '$(this)' is to distinguish jQuery objects stored in variables from other variables.
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false
