Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603226;
	b=nKDRH+qgZ9VCMy77LtF7WgqknBLleslUKvrwohzwxzmTcfIUriDw9vaXQc2zOBdFQMq6
	 NAvJ1UpMqFQPl10WohoWteyau0Pd4j8WNJfVnysc5mh0uiQb1M5Xa1dEwLY3sHvYKjE5F
	 xdBSPdYEY00NUrmITlXj8NruIOy0lrVp/kfJc+2n8QE5OdDeILmioxS/3CguXirS47RXE
	 LrruvOQUGMlcJ9Sn7GBlXSGAlDAoCBnQfYt0ReMZBazJVjIZwHHd0eV0sRhu6N5dEdKKn
	 N21uwmCfxQChYmngMixtxYGwTNzkhrzbsxASstqIzJ3mBW7ixR4nHtgQK9lJSxuT9yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NZipUcVcHdBknGUjkGG12XLaDn9eCMRayIr3W6ZIRCM=;
	b=HlErKIXXSFbN3NsyNUF+wSBEG9jTWKNq7IPPQFfNZt2gYvVgc4Ee9XxgkFW9kClwAk39
	 eULk4oR1BEvmc2oOyC6TE3Etws7mYriOsyXtXUvhsLH7VJo+adoNw/uSt6dZOENrzIZlm
	 UQ2CT/yc/bVUY7Gf1RtysmpzxDUqUcRLklberN2TGI1wyxCMK0wzSPYJA69ODVq0VhRlp
	 CbLIMF4SQnz3kfFVo1cuo/J3LtlC6Girq9/NuW0Vo1ILvLfMwE/hWFHv7Osxs74yBo9Mc
	 zp/ucCwXi5V4HrzRlRQlZdkuVVw+jo1pC2tSaU2J+Ly/mCMFqt9jvxqaC0yTD6ypNhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bLKCsdEr;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EC606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 735EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bLKCsdEr
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so53166525e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795603225; x=1796208025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZipUcVcHdBknGUjkGG12XLaDn9eCMRayIr3W6ZIRCM=;
        b=bLKCsdErWzJ9jYGeHEu6N9jIXtfIdUs81THE41qS9IDVV2RKL4LKXvlfdJOy0KR2c2
         sDyXgmN1W3x8UKItAcM7NynnFysGUWXA27frAxdheCRHzSdW5w9cdbFi4H4LuHv8RjQ+
         JTZnbFz2k1UqMJ27XPrnRLBoa43WcPtdxgOa0YdDcoX+zMerwgz+LAzkJcZc5iLd1Xo5
         Jo89P9a5qjzfrRxGLAHr4Ywq6yy2M6rZCVxwA5G4AkGNWALsnZWS8Y1O/PL615+o3Yr6
         RprHL2jbp3T7t2wusdqEMrN+E04TAvvXychyP4vTHywdUS5ViQnK/mLgiyEBjdfCJn8S
         n4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603225; x=1796208025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZipUcVcHdBknGUjkGG12XLaDn9eCMRayIr3W6ZIRCM=;
        b=Lp4dEAsngKB4cRmIKrxKlcSavTlw8q0uSawgoNgj1W7ewM5klbKOrm7JJ5eBy4fTvL
         2IpRL6Zfumb45g3JNQxU9318CRYr9NuY9ipRI/mbL7ehwxOCjIXzX22GfoZ5Ndzo8f7v
         Jw8Nr0vVInTyK5lfswoUfwxYXVDRUAicAucWE6RCe0vrS+/hl5NkgPDzUjX/KKenLncu
         MIm8R+wUBMCAZKpFEmvbvymxkcseKD1SS1BW0Xb2dG7oqu1sR2oTbnIJzbNP3LHPxbmq
         T5CRxZo/qK7ZjGcFYUpCPkI0Q3PAqWugiegsef3ff+dgD5PbdrGMO31BqNhAaeyVrM8o
         LliQ==
X-Forwarded-Encrypted: i=1; AL+hErGOJ7Tjzu1yjNlIt40zThOR5uvTH87coJ4eNje1+7Zt/tpJWGsxnFxdo7IKV+V00PgOJ72rUmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aRyKoa0Afa1gZLoOoRzrXcMpZZwRXNUG83/aQ9T6gc+73dq9x
	vOqovzi7EJa7qOJaKmznU6lGOvzqVwUqPf2YsQTScCMP/UZSayEBsUCA5W6kPPi/9Vc=
X-Gm-Gg: AZFdTZeGGjLMnO2HPpjVtd5vxTFW3QkC/cA9CAGS7DbxzSqZ5JN97x4rNHhsFTmuHVC
	qVri+07/csxC/lqpDFjeUC9Kn5WqLh8/uqv3rWCr6l/ivWrd4fyKuI1qSfhkLglvJ8d27fzk4Bf
	yhY2mPLa2vI7NLtz/17AUjgcIMPdcUE5KDaGPnq0ZPST4QAQ1+ZMBm/llRDgwh36+pPE6NEtgSZ
	iiTRncF+blp5FefWxFMpL9wpGbaIYi0ozoJHsxAlcjmP2iUE+rmwhNoPjEx2lQt+dVQdA2fbR5W
	W1uJtvbQCYBYTmOPETkQAEJ1/Ii0KGLELaA1Lp4w/gebmKxLzOQiUHCffpDecSr2wcsjLzxwpcs
	DctcNT3SCi7APKZ2HOMsF0MGJ4DJJg4+OpaxW9d7fRB8vsTdUfOMzl+bEs44FfgAJTPbf6HyEk7
	EMvT+Dxb3PZv7iDcUbfHxWjp/Yc2jueF7bosf/42r+JIXG9Y66kCYMjPlwR03qsHLAys7ZGZs0H
	npV7STfM22oeXzdZl2W2DvwoZZFSM+Chae9LxBXl886KX8Q7UKPXW1QyZJAaGiL4vvHx8ZeXXlM
	Qx4geD+ISeRiMfk15GvR0HzSMds8bXGLV7jaeeRXnZ1CyyNHzA==
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb88824a5bmr351028555e9.13.1795603224592;
        Wed, 25 Nov 2026 02:40:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm527792685e9.2.2026.11.25.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:40:24 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 25 Nov 2026 11:40:18 +0100
Subject: [PATCH v2 2/3] usb: typec: tcpm: unregister stale partner sink
 capabilities
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-topic-tcpm-core-fixes-v2-2-aede2a3471f4@linaro.org>
References: <20261125-topic-tcpm-core-fixes-v2-0-aede2a3471f4@linaro.org>
In-Reply-To: <20261125-topic-tcpm-core-fixes-v2-0-aede2a3471f4@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <groeck@chromium.org>, Igor Paunovic <royalnet026@gmail.com>
Cc: linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=07EBmlzjWFz7CQysUew3EdpbM6jzq//b4VdC+IUafRE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrBrsVTjlFXTwyIa/88RmT/8Oft7pgmvbnEtdCiEKN
 EdTnAS2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawa7FQAKCRB33NvayMhJ0cVaEA
 C9hJ0BZ8J34QldTFCJpP+6LsaDNNn1J/qKTLhtuw1vNht9CRYRfYdRLAhHwO+sJ2yP6Mv7Q7GfBi/d
 wpKSR553XEvhLBX2B5dh+i9OiPpGcNfNF3Sb+7XWwwTSg9Mxjk8zv9cFPi2KWXI8ULXOLHHt89a6Om
 HKmHF/dj98/z2p7x5HFeiV92G3jPMuNojDdGLdRpNs+jtfxBJ/dsd8oN4xE1yyjts0jEcqXqGIQTma
 ii5J4jrIeM+jYNkQlnkZkJdTWM35/2YFXwJ4ksjcAruvO/Akil7WwJ2zGco1G2pqVKhKm4cILEQjrG
 5smjMZWZWovh5TVI3PKp1Ms4YYmTTeba2SNDiNFuqdN7IqR+NEaRVMbUn3DPsXalJqgQFTGbzGkMIm
 ROIkc7ytdY7HMf/PbDyK3TQo51RKwDrxrOW2obWOkD/pFyzq16CE8m0IKm8yww5LrU2+hbxOGZ3+o0
 FMEXKhPwqnW8KXPqy4WwgRExFb+nFIMmN1+kQlAO6zTFgvse8CSDWoUgHWx8+a3cOe8OH3KXNPFmqW
 383oNbqNDFXJE0XZeygZ6qwovp7oACpw6v8FbnEsoFYp7ahNz9SBsqSqc6ZQZYFQCvYTaPyoibacvI
 fSpYs5FjWs7AAgyfA+z4EMmWTQe8h4rPfeDWS6lNkVgv3pmNw+cQvx/GlSAg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

tcpm_register_sink_caps() registers a new "sink-capabilities" device
under the partner USB PD object every time a Sink_Capabilities message
is received, but the previously registered one is only removed on
detach.

sink_cap_done is cleared on Hard Reset, so the sink capabilities are
queried and registered again on the same partner: registering a second
device with the same name under the same parent fails, and the stale
capabilities stay exposed in sysfs.

Unregister the previous capabilities before registering the new ones.

Cc: stable@vger.kernel.org
Fixes: 8203d26905ee ("usb: typec: tcpm: Register USB Power Delivery Capabilities")
Assisted-by: LLM
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 20e18bca649e..d0abe8100742 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3559,6 +3559,11 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 	struct usb_power_delivery_capabilities_desc caps = { };
 	struct usb_power_delivery_capabilities *cap;
 
+	if (port->partner_sink_caps) {
+		usb_power_delivery_unregister_capabilities(port->partner_sink_caps);
+		port->partner_sink_caps = NULL;
+	}
+
 	if (!port->partner_pd)
 		port->partner_pd = usb_power_delivery_register(NULL, &desc);
 	if (IS_ERR(port->partner_pd))

-- 
2.34.1

