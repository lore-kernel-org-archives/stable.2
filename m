Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204676;
	b=4Y2IFUx2R/5KOvXMvdVt3LdFHju8N1/R+9IQFGrBVh/4uOSck2LhjJAbyuYvM+FeVp+f
	 3RQlM2Im1FDB5mez+aHn7h6BJ69YXzSDGg9sp4taFnS6fxpiVv7IrC4Vfpio0nUt5Mm/g
	 TfIo12vLh1kniUMObE2amAkW6S3IFtbcp2wKWF23NarofcSB8y3NkT6f28mPHIXT8UeNB
	 N8QtS/19sV7A8j20t9EndRnFtG03SXlectL/TPd2AkW8Yoa3yyrbN5MzeEC4rzbvk2k/j
	 GSIH0YUsj6mF40bZPzTNWvcO023QCBMIGvTQ2Wrh3KlQudJFiAyBSqJiHErv1xyCy8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gRO41KkPTWNlu6Ttf4a7LMDPUy2i6YOIbXNUx5+ygKg=;
	b=jGjtw3w2n/HR60oqx465iQzqdS+vWou6j7R1vmScZ9NCcR2BESdppIW0r+wymzXLQHXy
	 A4PK/oTny88Q0tkF7Soqxngb4m+xu1MMthOfwCqGeODy+f6EiXWPn1cdCwNQRZEKdAffp
	 m4edoB/X+z96aBpRHduTUuAaHuJmNDXJ2yTeqBBDifkt7czdoo++7JaxjVokOfaXey1wO
	 Sb+YXnlAwKftaFUv9g+DATpUH+qvfdsQP3DXqfRKGM4BBQeynYn6WCBZbAZeB/D9d4q3s
	 cYKieXPqLLZodXzpzRDlW4g3ab/LIZXnln1mANKeQMgbQt2aTE68RWtR77IHBBnoOlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s78dRQHK;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196A606D814
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6196A606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s78dRQHK
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3712b6d9843so146043eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204675; x=1794809475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRO41KkPTWNlu6Ttf4a7LMDPUy2i6YOIbXNUx5+ygKg=;
        b=s78dRQHKrmGkbkFTEGhJa1F7eP8rMbI5fU+ouoXkgaEJKTNID9Ltx7lleGGcQfz1Hr
         lNEYRrkWukUStXb6nCVOzsk4Ug7wkf7D7nWxfCZTt6H+RR3RAbVfEm3lR4yvEQ/HHpcB
         TZH5vOqyvv2OQoC7NGEEhQ5F5U3dzslZCQMK+f90XhvbOxgPdKUV2fTSJ0k1DaraO1TA
         kzI3XJCj5C6Bu9CGpxX0DklMj/L4nMLkT6IOXjedx5Zk1DhW1qSUUnuDZybmXBsQmNCB
         r/vOQF1THKWLJsC2Et2H1fcP5JqHnGRF65dAbzYrOEdn6IlwyModH9Qx3LftIY4UxtwQ
         DOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204675; x=1794809475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRO41KkPTWNlu6Ttf4a7LMDPUy2i6YOIbXNUx5+ygKg=;
        b=latwSiDJKsWraMysHnU0uFrC0u/p19OPYc4ZXhyA+VRhNcYX/uevaZChmsekxVs2bO
         dDgTO2Zlb8LCejRdVnuFXL01J5SaNJezbdgkUHHC3ok9s57BNvk4kknoMV92hS+85i8x
         lDpiSDVW8L2v0LOIhiCnwDwie+bz9dqGDFeoeeZ/meEWJoprnVfBSSjqTpAx1bsXRAoF
         AJq9s6fUjFL0b4gf2LT49ZWju8pW753TMtHshimWCvCCe+4qykZ8EL3xVxKcaIvlm32g
         0SU0Qc63LKdjXUQpp2u7gK01x6lKLt86kNrQvA4gkHKz+Jii9UrUaC6zrPNiS/1jYXW4
         42aQ==
X-Forwarded-Encrypted: i=1; AL+hErEa+w0Bthqir8tYPxUy7GWOLRoCBMya8lPtZizJ8F7kQIjGy/uydfLCWGzXMgciP+Ez17gswkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NMmDiCmcSvfTYmQlBXTiBCYWdqSdK16/ydcgrO0bW4wPv1a7Y
	k4fNXVQATp5Y0w4h/jv0OoDZiSXvi8ypJhuTnvA5lRAiUL3tGrceOJqv
X-Gm-Gg: AYBFou3/LwonxKgIZR5IITTPcLpTnswBCdRfEuX2/qTxxDsj9gAIsVTV8rKx8EPyqEf
	NXftzCaGbFRHVUN7Tcg4B96gj+qrD/1Z0X4MGDp/Uj0aKuMrA2/Nikat6dDhIx2/rHRXMqYajdl
	uchItzt1xmIYQ0rb0817vO/A6VZkVRiqN4PKRfamSshI1XzGCTW97bvtM5nOGIHqBo/m4RiMf8o
	cm4E2CAUNEd+vEDwLfevFiMvhFPzZqSZKyk8fWEsJNshNfJGH0qsMRUGzPPA8aJ4IhZayTQElBd
	Kg9/fQVc3bYKgAKX/uOd8CkDpnlT8i7nG7hSlB7wja4O03dQNqkO1QhZudLUz5txKN+JlCKLzBI
	7WkgDHwSh0BP2/Ae7EAdYNGCkhHA1goxTOAYq2gQMe2FI89N/ThEEON2+PNDJRV6bS9aTEPAX9W
	qbRBPmCZ+BAkZzGQE72fWsZ7roieW7NOyM9wXQYGe5Bpl240LAwySKszeTtPMaRqsPq4KLOyeCx
	tmsTwIwTLpOHoLbP8v4MSra+PCN0FCGY7hpBZ6LXaMTQy/El1/awNeruitt6i9trbx0Z7QwGFPR
	geDIv8nmMEg2q7L4HSahBE9eAiy53toH/P4S3E8NHXCVDo1iRJdIfsQyG96n1vjz0vUCjP6u7o9
	bwDIFo0fCbf9IoXcO
X-Received: by 2002:a05:693c:42dc:b0:36f:4981:da16 with SMTP id 5a478bee46e88-37255a514c7mr6461633eec.25.1794204675440;
        Sun, 08 Nov 2026 22:11:15 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:14 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 05/18] HID: logitech-hidpp: do not store ERR_PTR in battery->ps
Date: Sun,  8 Nov 2026 22:10:49 -0800
Message-ID: <20261109061103.2887636-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When power supply registration fails, storing the error pointer directly
in the battery supply field leaves it non-NULL. Callers such as the
connect handler and battery event handlers only check for non-NULL
before notifying the power supply core, causing an error-pointer
dereference oops and blocking retries on subsequent reconnect events.

Capture the registered power supply pointer in a local variable and
publish it to device state only after registration and sysfs linking
succeed.

Fixes: a52ec107fa81 ("HID: logitech-hidpp: create the battery for all types of HID++ devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4e0758cdae64..9f3ae8724dd2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4327,6 +4327,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	struct power_supply_desc *desc = &hidpp->battery.desc;
 	enum power_supply_property *battery_props;
 	struct hidpp_battery *battery;
+	struct power_supply *ps;
 	unsigned int num_battery_props;
 	unsigned long n;
 	int ret;
@@ -4407,15 +4408,16 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
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
2.56.0.506.g506a7eabc5-goog

