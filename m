Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164066;
	b=38aNoI0FcbGeU0v1UxS+a3GZH854yZjuhCj77t97wy8UdtgDTinPE9qafELEammQlFys
	 nDFfGFd25nfIONW1OOO2jjHE4ICHma9zsl909Edl9CCq3sNMuq7ljzB3RKtc3N+QJrjYD
	 om8goGGjZO49fSq8VVuAVDMLi/AbDyplzjv+FJ3SbFyFeFoaoyIiro6bfz06E8v3J3iJe
	 YB8NKqaLFzzgvEb8v9dQ++kdnpXhb6rvbu8TxNWPJjmQZ3DJOYA7kfgmy5nGSuRFRqqBu
	 iY/O++UuIJcZv3lN5c32xX8vcRusp3IXYG8zGsiYSTAaZPd+XtU7sxlkq4FWYWTVAWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3EGbLc76XrKp/CthZWQqfcemDv7vxiole5kdBmE56sw=;
	b=vsPemKOqFhqndmejAGPEdJZHdb8gYhDZ+FaS4C/Q4ABBypIelXsPUqptPwb6GJx6rh3Q
	 Z9MQDWVIaOQzfs5DvIP5R6I93YzlpYhXj3tHlBSA1HZMAmF30+qPp/6Q0GBGtTNAIaWbe
	 bPcMdtkJCjhgQWi2RTKwwwt6r1xhqe8TTmgfNLGYeZnrKtQ2wfFvRsbtrKO1/ZWm7nWUl
	 7l6AEscp0mT19JuuKAy4x/mjDuaiJjmaD8H8ihCCBzTbZDy1QDD0fo7BF/xpcRFmY3qOC
	 kzRS2ySQIXoUc7r/r5zD5KJTQlVpRvWlVWxteCpHnRHfhTG2ZAdIpnTuLcpYTmqv3iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kM5EbDcV;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056E60A381C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4056E60A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kM5EbDcV
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-385c497bf94so916732eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164065; x=1795768865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3EGbLc76XrKp/CthZWQqfcemDv7vxiole5kdBmE56sw=;
        b=kM5EbDcVcZMLd7lIvskBnnQ3pIxZwJ5CBHjmuAiFJgxGvi83QxL4RBozep8LuN4n0z
         dwpzTYHj8xhU1tJzP3UKQC9sxKlAEhP2UI3LgBzqHUo5XPc8NWxib1c4Ip1QjkYbKGX7
         k65pQEJ9ocDn9XUN+yyqzpQ261Ss/hosesm5G/HSVzc1pjy0Ay050LozP0C2DAm5xqxp
         74CXQX3uICrJK1w1aqKehM9SYGb0/wvzDI2DCnXlfIeUtSfHWaSOa3bSeQxu2nAw3dDT
         mMi1YhHqvRs5uQglsLHmSQzNmNEKbzgCUcph2gvaZ5ldtjDjMW+ftDLxd4TB0n4swD0p
         /Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164065; x=1795768865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EGbLc76XrKp/CthZWQqfcemDv7vxiole5kdBmE56sw=;
        b=s9S3OdCq5Z+aOYYsxzT3ytMHmjh85f8pseuzjM6wlDAJJ0Y7cIyp7M1Ck4gVxhqd/B
         G1LbcUo87m2lwmRAI43mrXObGQ9GV4aKyqoS5VxGqbUY+Rf28ifHzIoomftKkEC5JxoV
         ZHLzv530BKqML3n9tQh1JM3i0V3l5XSl516GZ/U2TxQdZnJ1Ojb/xCjsYkVGEnyiqONp
         wZNh4m8n3vuS02upb5ZmTpO5nS5zhG6OCtOaF4NoCCKRyU0enh8ZG9pquoqzHnnS/Dc1
         ++p3QD6nenS4jyPmLk8x5G7OocWTO8hO1Q/SQEX9Sh8SV6jnJAOWnNx1e22aU8+ydtcA
         ZmCA==
X-Forwarded-Encrypted: i=1; AL+hErHbAXYbn0inWd/AYwSJPzaM7T0LnKecDbVrac6pPsZ+eC6swxW8WNsgecQ3Fsu99QdzWPTevLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZMmPOK3CceET/XApFr5lpaRofSSsfIzXHmH5r8/KiRy+plU3C
	oQXoEAs2w8CbW/hUmEhg90ww666w8hSxquJE6RNpymShBC0k8IY00lsZ
X-Gm-Gg: AZFdTZeVUUFaEr/7oXbQSmtscKg38MPIC5rHGwOtVl8AZN3J3CO0Y37Fs87uyJlfTia
	4YdoSkhQ/4ulJGLgOzQyJfypxFIfRw1aWjrEZX/VDngy21VJ72wnKilG/xbwmDiP2gHVOIIAC+H
	fyzm062JzRK97bjPny37YtowfiQZdzckWxda7WoGriEnrtA2NCeSmLlORiyBwKEUSmQdSFksddj
	d2m6ibMaTrtzo2zvG7STZghctF2LsZbcKuB0o8qn6JZZoD6dADhK05LxV2YpwNdd0+VircyIigU
	P2Y/8d2xK9PPh1P97lxcDHV4elG0HJtTLjNcuU9mqTpTKeJSOtvxqGha65EQrWGQRGD8OzqvMd1
	5cQtZtW9dCIxe9sXMdnswzVL2ZWFpnzFhsugaSo56AnZKZLkNiS2XBVWX3Jdug/iAz2jea2O8kV
	wsHTLBl5SF7TA2cIWbrsTlqssS5ozruTD4NUMEPMaD3QpQF9aAe1nzeiTkoNderVmsB9WGzYTLC
	+tHZnZsvtCqvUa/RX/0xfkfXi2JlCwhWjy1ZrW5wjIpDbx1/+utbdoXdWyuo9w1bBluxDYHaWym
	U7ZIieUuBLK/+j6L044qFa47+WPAQZCKvT/W0eQrI0FPp/qUwahqPK2Vsfr+xEsWPrzGZUrTv7T
	CGDLZ92mfoO2x/vNqeQ==
X-Received: by 2002:a05:693c:87cc:20b0:358:3426:d601 with SMTP id 5a478bee46e88-3856c0d0961mr2156455eec.2.1795164065159;
        Fri, 20 Nov 2026 00:41:05 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:04 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:53 -0800
Subject: [PATCH v3 05/14] HID: logitech-hidpp: do not store ERR_PTR in
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
Message-Id: <20261120-hid-logitech-hidpp-v3-5-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
2.56.1.750.gf70dc682cf-goog

