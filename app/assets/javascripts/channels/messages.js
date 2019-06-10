App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    const messagediv = this.renderMessage(data);
    if (messagediv === 42) {
      return;
    }
    // const notification = new Audio('http://onj3.andrelouis.com/phonetones/unzipped/Huawei/Huawei%20Ascend%20P6/notifications/Hand_Drum.ogg');
    // notification.play();
    return $('.message-box').prepend(messagediv);
  },

  renderMessage: function(data) {
    const groupName = document.querySelector('#groupname').innerText;
    const userName = document.querySelector('#username').innerText;

    if (groupName !== data.groupName) {
      return 42;
    }
    
    const messageDiv = document.createElement('div');
    
    if (userName === data.user) {
      messageDiv.classList.add('message-right');
    } else {
      messageDiv.classList.add('message-left');
    }
    
    const userNameP = document.createElement('p');
    userNameP.classList.add('user-name');
    userNameP.innerText = data.user;
    const textP = document.createElement('p');
    textP.innerText = data.message;

    messageDiv.append(userNameP);
    messageDiv.append(textP);

    return messageDiv;
  }
});