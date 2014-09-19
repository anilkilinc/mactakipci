package com.anilkilinc.mactakipci;

import android.content.Context;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.NetworkError;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONObject;

import java.net.URL;

/**
 * Created by Anil on 18.09.2014.
 */
public class NetworkManager {

    public static final String ROOT = "";
    public static final String REGISTER_PUSH_TOKEN = "";

    public static void registerPushToken(Context context, final NetworkCallback callback, String deviceToken) {

        StringBuilder parameters = new StringBuilder(ROOT);
//        parameters.append(REGISTER_PUSH_TOKEN).append("push_token=" + deviceToken).append("&platform=android");
        parameters.append(REGISTER_PUSH_TOKEN);

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.POST, parameters, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {

                if (response.optBoolean("error") == true) {
                    GongError e = new GongError(response);
                    if (callback != null) {
                        callback.onError(e);
                    }
                } else if (callback != null)
                    callback.onResponse(response);


            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                if (callback != null)
                    callback.onError(new GongError(error));
            }
        }
        );
        jsonObjectRequest.setRetryPolicy(getRetryPolicy());
        Pyramid.getInstance().getRequestQueue().add(jsonObjectRequest);
    }

    /**
     * timeout 30 saniye olarak ayarlanıyor. Volley'de default 3 saniye geliyor.
     * Bunu her metod için ayarlamak gerek.
     */
    public static DefaultRetryPolicy getRetryPolicy() {

        DefaultRetryPolicy p = new DefaultRetryPolicy(10 * 1000, 1, 1.0f);
        return p;
    }
}
