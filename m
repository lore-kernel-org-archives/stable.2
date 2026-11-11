Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380191;
	b=cYd6PHJTIeZ0KxFRfspzXuo2hSQwu8wo0B8VUf8p+E361zjrQbXNk+FVr635EJA7sOMN
	 EEAyGZRA3HNw58qXNZ9P29Fv34XboXa2QFBFcDaDxR16eh+aJvPbhOyoPnF+I/2wIIOOZ
	 oX62YwKwSHJoeoxzOHxQV0czrFFdctojysfQRfu+HsVTeBFrNi6AKCBHLs4fo3I2Ly345
	 XICaaS4IRy/ZAWzzLywt1kR5i7KC6dmB0Isj+VJfheaFrUTO359y9UXj7pkrD3MkPrtQr
	 IvFzQ+lquRZ3i08/etglcVTwvz/fIz4SyOYs8nugMhsf6MT81htrJ896aJA2+eawwjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xOxTVkJvL5fIfalUxaM9jLKgqHystwJOtIasfX34Vd8=;
	b=JzvKr4ZEuBsuMuSWb+PAkmz2Uo0HYyPd3MCqXbOzjenMiSI7FMtWVNPpvjK355uG3h6u
	 kVWI+4iK6nOI9415SUrM/3vylptiazzQur88qJuUMEQYy4bPKh+xcPxzSudIzEEcJ8+C7
	 DxAs3dXBwjZlFIHcz12k9XXRqmqfv7FWBdpNAS19tSEDqcfiXhK+AIFJ5stS+RDEsp1ug
	 PXOWRcEIiA6T+iNIcAfpOOhTY1yE6rWLLmaSVPUzomzkvnn9xVH6zKV5V7C5U4FSk+wxs
	 MKJGNLg2wReTJ/KpiFha+ticKWO5QOhETfzgGA7d6mSJHzNZMB/x3OJa2D2t+Oh6wRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzJwJ5Ym;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2C60A380E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E2C60A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzJwJ5Ym
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2218894c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380191; x=1794984991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOxTVkJvL5fIfalUxaM9jLKgqHystwJOtIasfX34Vd8=;
        b=WzJwJ5YmEHZmO6+/lyRDLTkXW+QuTGRlhYXjQyaV25nirrsoTvwkfIhe2hDNer6sL3
         7Km2YxEVLKh/VGXGLN5BBRfAd1Hwa3NCQfB8XM4G62wgBLDq/3V0aH92cH09o1p4LKrw
         wj1xObzxF1MJoEJKMZU5ixh1nEsrzfqs7TVDfuDbu5wrQ1BQbKhR9zWv01L6C4rhIMVc
         4/yevFIWoTPnFsoB26REoJO8kOt50jciNW0hpk9ubC5yCKkLd6xHkDZqGptZ2kpyE/SX
         Rgz9AP9gsfR6q49Y8EoPMgR8fDxtuo51pyyY9H6tnzHrtso0WJiWHZXfbq8PLz9sJIJI
         tFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380191; x=1794984991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xOxTVkJvL5fIfalUxaM9jLKgqHystwJOtIasfX34Vd8=;
        b=LeuLXs+tHvyFMaNvH5WMffIKj7Y33Z+pdkgIKk5Y8AETfck1R9v7pHzSO1N7S++XSG
         6dptOpTcEOa1eMpRZbyzgQ41J89eQjeMF5z/XIYKAts0qgleLa1eJ1aFzf7wqElryZ+n
         vKngNEgaEGTwdPODWICNRKLvzDo+IuyONl4dFZcp8W4mA8IjWcht1XjXMhpn9hOashV5
         oPIt1n+RQgq9vXU48SRYcSn/F2XeQBNpxtqNq8nAc0apkFhCGd5nOA7kaxymwB6ptCet
         V9UXkRaV45Q3dr5nZIDJRyhU2lrEb6yvRcMUHbRhKnRXyqJzitCBmHAfeTb0Sarso09T
         GSHg==
X-Forwarded-Encrypted: i=1; AL+hErG+QLIw1j5sgLuyUC5g55njJrNzS/ik+tG3PKY3V36NpMkpzrvU40zo3IpFO3b5EmlvUNF0A3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Pw3rn2OD+MCktLjBs1seMkBamMJnn1k96IeOV/04yz0sbwB6p
	f1YV+eJZH82hf3n1sDerumGP417C82XW6qpYWxY9WWjmkiMpd93p31Ji
X-Gm-Gg: AYBFou3Ts5nH6oFRta6L+s8iLDMbvlvXrAvb8V5W8HQieiwT+CNsk0/PGWrfOdqj9fd
	s3y6MqHBviQYQlYkafygikCkF8P5gDqknr9ntzg7MSSf+pjjYa4bIqfOMtZQbpp4pDO1dIHQzC+
	XJdN/dDW7P+fbf4cwvWjVIK8iK87gx0o8WtIkVC/FDcVZ9sPjyLkZXOnMpPG6J6xr1CljLNWhbG
	ApB227F7+tkJuanxFTQcou5lr/oXw7HKKaIoQnzI063Lk3YfQCRIFEI/FZ2bVm1WWfNl0Ne2NxX
	CEqC7N/rAjCzvsj7Qu6TUCHTqP5qPFaZb6AgpIs5rYjKfr9onoWYqwPYWezipoVlyTV/L6LN2pB
	TXdPoZsMN7R+5J9kGtedKKJXpSc5TlnYE7IF2vEEGIHYsH3GZT9sm2A+7uwpJpfrR72d/xrHERh
	/IqAoiCSednnCG0AmGl6F0I1FSNSfvD02WFWHhF5+lOTTPq4XO7KtRXoDwJVLGeLgv5otZw8CUS
	g4Rzq5TtGOC4klzfsI1f8yxzodYGSUzhvKa+xz0+DJIlaJN3NZgOv+OPT6MJbJrQ+nKzn7/kasj
	7kQaTTFxl0Ys/2o8KAcre1V4//wsssWUyA/XlDUGDHLpgLFA931yYb++FwKp/ShfFtVysKeDajb
	SGVmgYLaomajxG+nXKpI8Zwidc5euuzqyIiokrOM=
X-Received: by 2002:a05:701b:2302:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1b3c024ac28mr1481360c88.1.1794380189133;
        Tue, 10 Nov 2026 22:56:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:28 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:03 -0800
Subject: [PATCH v2 05/33] HID: logitech-hidpp: do not store ERR_PTR in
 battery->ps
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
Message-Id: <20261110-hid-logitech-hidpp-v2-5-30743e91d83b@gmail.com>
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

When power supply registration fails, storing the error pointer directly
in the battery supply field leaves it non-NULL. Callers such as the
connect handler and battery event handlers only check for non-NULL
before notifying the power supply core, causing an error-pointer
dereference oops and blocking retries on subsequent reconnect events.

Capture the registered power supply pointer in a local variable and
publish it to device state only after registration and sysfs linking
succeed.

Fixes: a52ec107fa81 ("HID: logitech-hidpp: create the battery for all types of HID++ devices")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0e1a9fd98faf..6ac41b7d76ee 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4333,6 +4333,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	struct power_supply_desc *desc = &hidpp->battery.desc;
 	enum power_supply_property *battery_props;
 	struct hidpp_battery *battery;
+	struct power_supply *ps;
 	unsigned int num_battery_props;
 	unsigned long n;
 	int ret;
@@ -4413,15 +4414,16 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	desc->use_for_apm = 0;
 
-	battery->ps = devm_power_supply_register(&hidpp->hid_dev->dev,
-						 &battery->desc,
-						 &cfg);
-	if (IS_ERR(battery->ps))
-		return PTR_ERR(battery->ps);
+	ps = devm_power_supply_register(&hidpp->hid_dev->dev,
+					&battery->desc,
+					&cfg);
+	if (IS_ERR(ps))
+		return PTR_ERR(ps);
 
-	power_supply_powers(battery->ps, &hidpp->hid_dev->dev);
+	power_supply_powers(ps, &hidpp->hid_dev->dev);
+	battery->ps = ps;
 
-	return ret;
+	return 0;
 }
 
 /* Get name + serial for USB and Bluetooth HID++ devices */

-- 
2.56.0.542.g3ef89b7020-goog

