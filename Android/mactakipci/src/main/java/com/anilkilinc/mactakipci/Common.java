package com.anilkilinc.mactakipci;

import android.content.Context;
import android.content.Intent;

/**
 * Created by Anil on 10.09.2014.
 */
public class Common {

    //genel uygulama tag'i
    static String TAG = "mactakipci";

    // give your server registration url here
    static final String SERVER_URL = "http://192.168.1.69/gcm/register.json";

    // Google project id
    static final String GCM_APP_ID = "810790313874";

    static final String DISPLAY_MESSAGE_ACTION =
            "com.anil.mactakipci.DISPLAY_MESSAGE";

    static final String EXTRA_MESSAGE = "message";

    /**
     * Notifies UI to display a message.
     * <p>
     * This method is defined in the common helper because it's used both by
     * the UI and the background service.
     *
     * @param context application's context.
     * @param message message to be displayed.
     */
    static void displayMessage(Context context, String message) {
        Intent intent = new Intent(DISPLAY_MESSAGE_ACTION);
        intent.putExtra(EXTRA_MESSAGE, message);
        context.sendBroadcast(intent);
    }

}
