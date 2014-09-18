package com.anilkilinc.mactakipci;

import android.content.Context;

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


    public static void registerPushToken(Context context, final RequestCallBack callback, String deviceToken) {

        StringBuilder parameters = new StringBuilder(URL);
        parameters.append(REGISTER_PUSH_TOKEN).append("push_token=" + deviceToken).append("&platform=android");
        String urlWithFullParameters = addDefaultParameters(context, parameters.toString());
        if(urlWithFullParameters == null) {
            callback.onRequestError(null);
        }

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, urlWithFullParameters, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {

                if (response.optBoolean("error") == true) {
                    GongError e = new GongError(response);
                    if (callback != null) {
                        callback.onRequestError(e);
                    }
                } else if (callback != null)
                    callback.onRequestComplete(response);


            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

                if (callback != null)
                    callback.onRequestError(new GongError(error));
            }
        }
        );
        jsonObjectRequest.setRetryPolicy(getRetryPolicy());
        Pyramid.getInstance().getRequestQueue().add(jsonObjectRequest);
    }

}
