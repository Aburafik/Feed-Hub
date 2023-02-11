importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: 'AIzaSyBMtACai6PpiB29tWVibWdl3y0dbWirdGM',
    appId: '1:944602773348:web:c356e6bc510494b9342c71',
    messagingSenderId: '944602773348',
    projectId: 'feed-hub-5dab3',
    authDomain: 'feed-hub-5dab3.firebaseapp.com',
    storageBucket: 'feed-hub-5dab3.appspot.com',
    measurementId: 'G-0CJB4H2HG1',
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});