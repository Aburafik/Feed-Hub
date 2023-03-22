importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: 'AIzaSyBo5XLxO6SeTzm9ySX2Vrqg1xCq89iFBOY',
    appId: '1:483352088089:web:19997432737416b81da488',
    messagingSenderId: '483352088089',
    projectId: 'feedhub-f42a9',
    authDomain: 'feedhub-f42a9.firebaseapp.com',
    storageBucket: 'feedhub-f42a9.appspot.com',
    measurementId: 'G-HJBFN6E89N',
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});