Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380195;
	b=D7sPCOcEUuMFoUweU0GQ4MyeP7czZQmJkGY4y65P22jqjWjwVzBTUVDRp5oBPjbjxXfV
	 I87XoMnQ+kuCL28UCOn7b3h6P8EF1d9N3PY8feFgt3w2iagqLAe0fpUGIG3Ef++N2Cm8O
	 Uwz2GZux1e9gxzCPjleYVHHcfr5mEahBHdR68Q9MpKTzif/nNBCSFXriyIbZpHLHnWn/q
	 drMhJjrOfISPNLb/okrIOvNdvP6DyQ9CKyNN+Uawd3OxtytNSehwcUzdq08IP2MTvFO95
	 g9jJkmLvau+BlyfYsxFctHxEmuOCZkFTlTw9KHoJlFToAfaAg7um0E30A+9tuzbBY2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=slgCBSKFKl7Q/LA8mzeyeTKZo/SbrLrfaAT37+Tkw8w=;
	b=5DBLUuKSJPh8OaJ8Ot3H0PukBVwCL8LhA+KgaGkqvjZmGW0mHGRi9nAg8q5XzgmkbCMA
	 VALdBXWKR7p3tNykyyKTc76RR8qRpdwzL2GrBrx2NhvGnNBNegxkjzzeVVH1B8WgkXH4V
	 9csAFlkAzO1bAyn5dydzbP1RNTw9AYqA2w6Y1GKtamCdTYqIS/ngA0f6ZrpqEvZJpuV/X
	 oWbsO0xvsUVEWiM2JRfvAFFhAUwfOh9P0Hl9aNGAApMhew99NFvKeOxl/xezsvuKGV3/m
	 fi5lN8aKdRC/HJI7Dn2I4+cFSSxved42pXk+2a4NnYY9879mhv2IGSzzI9zc98N9ySQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgH4CO1L;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49C60A382A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA49C60A382A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgH4CO1L
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15dd124bbe7so4047810c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380194; x=1794984994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slgCBSKFKl7Q/LA8mzeyeTKZo/SbrLrfaAT37+Tkw8w=;
        b=NgH4CO1L6/IdLdAq0+9WpBqbnVs+8tX53Goq7wZ14nOpJL7byez5VZqqvA+zNRd1hQ
         4ArsNOTRtWHBsUTyvuXab50p19fxL0ehexshnh9DgpdmXtqIGwiXXEHyYHX+I5LxsjHs
         Dlc/xcqKjvKZ3k7EGSa961+Dx9x/r1tDBNsPrx15DoqCOTGZPwf/ttLG1ZNx0q+p40+C
         p2xkHz53ea3MZYUYoFX4qOUHokWfk7VHolb6p9O4I6o60lPLuLtvCMpMYkNuBFRYFT9O
         AdpLrMH9/aoXuD4mG7e0BqUqZ8flktAuOTElJzJdKFfmrCiWT7quxKw6TMtW2G9YqMAS
         t2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380194; x=1794984994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slgCBSKFKl7Q/LA8mzeyeTKZo/SbrLrfaAT37+Tkw8w=;
        b=p+SxWg1mzPzOrCxis1ry7P9aDCwVjQ/SVU0yiuXvlzLhDkrKIM7OUfqQtuWZ6zshov
         mw/lP/pm7aSWzOjckEqB5OeM288JSacqS5X55/HYGZ+5/2pGEFETDkv5WCWXr7vHQhVB
         tjomXW53jSy3UsHdQFxOSkeJrCDaBuMTrt0LGMQ24ZbGiLuszZKYyQv7IdEMRJTZUESQ
         P8ddQxXMHdTLZm36J63kaiMqxX9B5NFWg3LUU2CD5WoAwo7Dd4mzzQQP/3/2msptqfah
         lXxgK9VxgK+PWZpE45Sroiojli63AoLqZvT1JP3vQbasPRKBXdpfmOfxRW73IneoEAW/
         EqAQ==
X-Forwarded-Encrypted: i=1; AL+hErGTIiIHMvrt+ktgQjs/o//1TsesSXpIEDPBzjgncNF3HdwUzA9TploA894PY7Pg3m+udRpssJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6DcCziadJc+c+yuj9NmyGYXOUlZXAOvYm5QGOenR23r9r5ioX
	NznqhVL0yQw9c/iKvd4SgasyiHxYWXi559LHpdHDlvum/6ZdM3xCTz/H
X-Gm-Gg: AYBFou3QfNN1PnB3o6tUz4gMOmB6ZiKTMBJ8XlEFmAvh2b827tS3ALQAZ+B/sU7m9bG
	quy5ZUj57SKJAjIupOHBftqJ/ACks95ODhyNzOfHnngGOF2Vy1bdqYbj9QYJMRxUW8A651IzZEV
	bzMLE3ER2cu2s7RJ6vOgGkptmESviAOstSmO6PqYnoXvd77EB+5ppmZf0wa2IyVtdEfJLHeDnVg
	3zwHUf9vZOPLbZb1XQshGQf9HF9383zFZBwpC+nCKgKN+qiECLDZmlhJQAqt9t9DP12WdvM9hG1
	yhMmOUo/T+OlVINmIT5YFUiZmwCDQTXkw6OLLnDRfbygkrnY7eQdOD0wje/mqpc5UxzAevgbEz/
	9H/gZQFVn3j3NRjxb3AkVz7TSw5AoRyt5uJFbs/ryqdgki20jP9XM0+DYQexaGsTZB3qzVl6Xgg
	gWPLf5Dhl7835jYdWbpmV0wJOpn2dUknUttvx0owSt0ryUErbA3lFSblcnNn17IhtY9xtRuDyXB
	vQAMReW5AHtynoa7ICjDhewQw9JoE8I/6h/P3mpK2OmpRhNsNAa1IxvV0xIOywoUMh8nE488dZi
	Mb9Ov35xOgoeNjRU++SYfSER1Yy/fZv88xTEqnqJSo1d3E5Ck8YFRHVowulNP9Tyt2hO1sx48wE
	L1yNmDkN+4MrSZBdEWQ==
X-Received: by 2002:a05:701b:4587:b0:1b3:b6d3:b91c with SMTP id a92af1059eb24-1b3c02ec7b3mr1467863c88.7.1794380192368;
        Tue, 10 Nov 2026 22:56:32 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:31 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:05 -0800
Subject: [PATCH v2 07/33] HID: logitech-hidpp: fix off-by-one in G920
 force-feedback slot tracking
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
Message-Id: <20261110-hid-logitech-hidpp-v2-7-30743e91d83b@gmail.com>
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

Logitech G920 firmware reports 64 total 1-based hardware effect slots,
reserving one slot for the built-in autocenter spring while allocating
the remaining 63 user effects across 1-based slots 2 through 64. Because
the driver subtracts the reserved slot count upfront before sizing and
bounds-checking its slot mapping table, the 63rd concurrent user effect
is assigned hardware slot 64 and exceeds the stored limit, so its slot
mapping is never recorded or released and remains leaked in wheel memory
across device close and reopen.

Keep the full hardware slot count for table sizing, lookups, and slot
bounds checks, and withhold the reserved slot count only when creating
the input force-feedback device.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 53c171dfcf96..0264e4541edf 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2872,7 +2872,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
 			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
-	error = input_ff_create(dev, num_slots);
+	error = input_ff_create(dev, num_slots - HIDPP_FF_RESERVED_SLOTS);
 
 	if (error) {
 		hid_err(dev, "Failed to create FF device!\n");
@@ -3486,7 +3486,7 @@ static int g920_get_config(struct hidpp_device *hidpp,
 		return -EPROTO;
 	}
 
-	data->num_effects = response.fap.params[0] - HIDPP_FF_RESERVED_SLOTS;
+	data->num_effects = response.fap.params[0];
 
 	/* reset all forces */
 	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,

-- 
2.56.0.542.g3ef89b7020-goog

