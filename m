Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380186;
	b=LIzMoZz5YEy0LL6hFF1fsfaXYbjKQeNIJu13uV+w10+5ncLLJnq7ydIpMuGxElX1cfAV
	 kwD8xlANk9mPmAKXXdbD/PA8jdU1hYQ1sbk5+O5+VUilboLAxa4UyIm1x1fFlIn3og47M
	 pTk+bxNqIhDnaW5/NUEyamdFQJ29GN1RDpawR3qr3SEcUCqAtoUr1nBQIw6Dx2fsATkqT
	 BqOi1rTgW+cZAUT2568rziH6vdAUXxy/kbaP+Edw4vuXBmhWzrIlMVm4p2FjUbkhG5jL3
	 /2DT4G/gT0uskKZrauCaYvb6EZmymv50Vv8xp8yaG4cS2GNnNTcB104fubdus/tO+Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nx9IOLprpQSMfjypqpoQZ6anLGigCDf2bUI7iUAOQmY=;
	b=fnb9WI14Va7a6y7JCIuy2A+QNHFgZSMjGG6C6QrB0Xpr5ExYWY6L7OkUDW37PRSuA0Ai
	 GaH1Mu4Mcb4qHNK61hrtPNZdUrG8AozWo8WRblfiXxF4Nid6OYPCo5/pi7vI3YbBisXuq
	 wNZdkuRJ8iTJRlWAMtZmOoNlDrcFd3llj66gKXbBxcefxuG102dEUUW9H1oChdAvIGWYB
	 QqJnsv7M5Jzk46Zop4LaE5com2SxM8mWcxpso+tWuvop37wPXM4My9cnNyaaxvgQ0P6/2
	 nwalogfGM5fLPW31E4KFC/ZIxFuP2jVbYHhD4QZW2dF254LF+wSFHePnybTSjWQ00wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LLA/ZYD9";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77675606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77675606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLA/ZYD9
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3acec6677so4468542c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380186; x=1794984986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nx9IOLprpQSMfjypqpoQZ6anLGigCDf2bUI7iUAOQmY=;
        b=LLA/ZYD9fn/oCUqdGap+MTcTC+l5+kwkINjy3EWCM69xGKD5cSNPwlYSzTfP8iNY2b
         bnSaFWy+nxAxyqNwkxqRaFs9A2DRCrDV5WC4b9NB/MkD412k0Lm0Q0T8U/R4zKXilqW2
         6vAgtzciaIKIUzngXJsysCYUcX7fGYeWhtVnFMgq8Q3BRHkhDCuzQHX3hZZbfgjQ+gf+
         YEanGuejwqEl1HR7vFCCq7Iff0YpOKZMcOMhEC8k5bi/AeOMHSfiF0PEvM8Dkkj4kDp1
         H2kRMvrwnOkxvW1C/xMCSx+C8YfglHmvWIfznHJyJkImIIsDxUMCbYHXCA0fsTMYVM4Y
         yb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380186; x=1794984986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nx9IOLprpQSMfjypqpoQZ6anLGigCDf2bUI7iUAOQmY=;
        b=IROBpqerbzZjKzBYAoiGeu3LePLBv5wo7+DFeeec6L2w7Bf1XpRc7lYq1Z1FRyZpJW
         XfdKfkKzrjM7ax4Nqc/b2W6wyRSqJWBPTbVZc+7H5kxTDI39S2mdKWKg27c0YEJbATb6
         kx+KgF7rVBJ84fsZ7raCKxalDPV7CbcAJ2BD8pA5Xfdz/D5RauZtbpEVV/5AZmEhDTmc
         czSFxSDvKOkjW5eA+DK7PH9yKfqBLWvF1thmwhxlnAmDO4fvO9k2FBCgFRtT0w4QYv0r
         A+U0pm1QaelC5Ek3PqOR0x8Pmo551DQ5hgPnxknLt7bzxIxFgBceC+Kua7ks75Ht29l8
         0l7A==
X-Forwarded-Encrypted: i=1; AL+hErHcthFImJ+jS8eUiSVfWGdFC7d8sEE2IfjZ6wnNqULFEaHJpzHWi1gBKLjX0LXWEJSutqAfwcY=@vger.kernel.org
X-Gm-Message-State: APuU4Z94pL67OOXEaJUfxLafD5UEK7FUKN5cJPTh52ezQN3ugnxekF8p
	HLARAFqQ5lXebwx/XDQ8UgNNDhqN8bQ6ZyxKILITYWPk3g8OFQ/I3Zdy
X-Gm-Gg: AYBFou0Rs/rbBuNksTf/aXbaOvebSa7BHh18UHzkZMr373qELgHnHAwTSjaqTOgIuIx
	xLS78NTlzcuPpltCI1Oh8mJDg0pHuWWMK4SHpuhnv0SeBY+Zapb7dbwSu01kLBAj1wmVg+tbK6D
	f87fwJoMsBrb87GYgyoRNyiv4wXO+C5igZXd/Yz49Q1+4agMHZNErxDesWuXMQCutFY3fQRd7Nj
	A/j7fzUsKPN6AxZ8mGaqdkSb+MpGr0zoEv4haP5b5kpUOd2ycmvRhPQjqy3JvP9h0sFf2YbP/lk
	hJSDK0xuCW74GqBRwH5WOM9WNfCAzrizAymgkQiI03KqNknAhF5Q3DyYPUUV/fHCIb3LXkHZ/bI
	Tb10dCoegEAsEidFB2+ecKaRwpAhIE6e0CvpmIFmU0tNyO8ihz/eSv5KCTaJZY7PYs1TLwhEx/A
	7JbrtkQ3s1L0fVQv4gjO0oHXwPPOxwvd/Ii+mQPpGDLSTpQuVoD985vwwL0MAZFjXFGOwexaK6K
	iNChqvnPhI6vbEerruVjAaXTe+gsMDPlwgIfVV2v1SRf2GNVZD0sknpbRPeTeI/6TX/IEoY7L+P
	IfWe9G0XWD7JifdCqp6BGg/4Jb80O8kPhxj5yaC/3lRJnURFc0Pd3F9WMUtXjq5Ms4syUXehmTJ
	4Lzkc6VaetiORJC3YHw==
X-Received: by 2002:a05:701b:20ce:20b0:1a4:3169:cb with SMTP id a92af1059eb24-1b3c0311b8dmr1605411c88.17.1794380185575;
        Tue, 10 Nov 2026 22:56:25 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:23 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:01 -0800
Subject: [PATCH v2 03/33] HID: logitech-hidpp: drain G920 FF workqueue
 before closing transport
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
Message-Id: <20261110-hid-logitech-hidpp-v2-3-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Probe no longer keeps the HID transport open indefinitely, so the
underlying USB interrupt IN endpoint only stays active while the HID
transport is held open. When the last input user closes the device
after input core flushes active effects, or when the device is
inhibited with commands still queued, releasing the HID transport
shuts down transport I/O unless another client holds it open. Queued
force-feedback commands then fail to receive their HID++ replies,
causing command timeouts and leaving stale slot mappings behind.

Override the input open and close callbacks once G920 force feedback is
initialized so the force-feedback send queue drains completely before
closing the HID transport.

Fixes: 91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d9342a3e8122..d5f53b35ac6f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2815,6 +2815,22 @@ static void hidpp_ff_destroy(struct ff_device *ff)
 	kfree(data->effect_ids);
 }
 
+static int g920_input_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	return hid_hw_open(hid);
+}
+
+static void g920_input_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct hidpp_ff_private_data *data = dev->ff->private;
+
+	flush_workqueue(data->wq);
+	hid_hw_close(hid);
+}
+
 static int hidpp_ff_init(struct hidpp_device *hidpp,
 			 struct hidpp_ff_private_data *data)
 {
@@ -2897,6 +2913,9 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	ff->set_autocenter = hidpp_ff_set_autocenter;
 	ff->destroy = hidpp_ff_destroy;
 
+	dev->open = g920_input_open;
+	dev->close = g920_input_close;
+
 	/* Create sysfs interface */
 	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
 	if (error)

-- 
2.56.0.542.g3ef89b7020-goog

