package com.anilkilinc.mactakipci;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by Anil on 17.09.2014.
 */
public class SharedPreferenceManager {

    public static final String MACTAKIPCI_SHARED_PREFERENCES = "com.anil.mactakipci.sp";
    public static final String SP_GCM_ID = "sp_gcm_id";

    public static void spSetGcmId(Context context, String id) {
        SharedPreferences sp = context.getSharedPreferences(MACTAKIPCI_SHARED_PREFERENCES, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.putString(SP_GCM_ID, id).commit();
    }

    public static String spGetGcmId(Context context) {
        SharedPreferences sp = context.getSharedPreferences(MACTAKIPCI_SHARED_PREFERENCES, Context.MODE_PRIVATE);
        return sp.getString(SP_GCM_ID, "");
    }
}
