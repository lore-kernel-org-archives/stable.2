Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380203;
	b=y0DwzYtYoMTVn8ME40DbMrTXGjqG2FdIBeNAK2xVX0qfRFxVin2O4OZbft2hcwQHcmf8
	 fYBmMdSAPaMSedWVSbAUPJHPfdZ93w52ghLsZ1h4/A6uv+Y/e6J7tWvJ5vCle2tPi1R6J
	 IdxMT+WNGnycF9edyl1IYjG+th6u9X1aJ9ep0UydnMyWPe3ivBJl2lesQ+lmYzK0FjHId
	 RvU6YdBjwubsxAcL+skFDV3/FkwBken6fbgf8dKMJk74UP8OKsdpHP1O0r0GnmMa6jW07
	 t+5ugB+9B20lMQu5+D/tTXCitlMNoiqCpf/gW00Wlg3iq4A2OvmZHSwldPc3M9ihayQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=s142rQGIYqwFuKUkekSLUqq2un/ylJfkIxejVPS7Jqg=;
	b=GyqDngA1SC5IYAfZoVPr9MqhOmx46aT5xtJminCkBLS+Luc8XbJqmVeOjNou7tUXD8/G
	 y9Fcj6Nu4XHydHRyF08ghdQXGh+k35VZVWdIk8uQLTpvH4DhtTjNIPRS2Zwki59hdevmH
	 ea7kHHCfGTvJsXqJQrLngBD8fT3J4v5S8+cOW0zqdh7tYUNt/11BtqKLVCn/q2maVy1X2
	 pNeUWQIICySD2o++G0ClPPIDSyqEMu7NQZvcr/PYd7qga45Gmrt7zzTCnQLr+kfEPQUH/
	 wPayBXqFlGtPhEAbwRNO6qvtAxZyaXlOtTZUYG7Yvs5SLXt3zetqGgBmbor2gMoqn1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv6oAtCV;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA260A2627
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96AA260A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv6oAtCV
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2253813c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380203; x=1794985003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s142rQGIYqwFuKUkekSLUqq2un/ylJfkIxejVPS7Jqg=;
        b=Jv6oAtCVj+V0OSEebtHUvH7w1tD2PVnjPhlkv+6C6YHxE9JtzJgPnXBEate9YhmSTm
         XXBJCttF+EVZZOcLor92H9uk4QI0X4I6DbkadxKU+zPhjIISmVwzCU9nl1MFO/q76BsX
         m8nVl3qY8Dj0tDi0ZbIyeKef/1rztkeMkspKt+62Eu9OOL0pSfzP4vAhjBgyi5m9lYCG
         h0p2qCf6rHmHJkZU3i+ae4zEfXTOvr+6S2W0xCsfPV3VchXQyIsdshSA7HSkkmAOONR1
         oB0Yfwq0Q3jTOwVHroCiAPEkAHXDBF1P0MtuRHRwgPKd3nOPFUf4JqJrnwHRjpUa/5TF
         KKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380203; x=1794985003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s142rQGIYqwFuKUkekSLUqq2un/ylJfkIxejVPS7Jqg=;
        b=hNrBLIsm2NgEHxJshUBZI1Wc+edP0PgttvO2likyU2uxlgUPG0GOfHSrU1i+OrelLq
         QI4H8zM7LkdyeuWPe0uOP1w9vEUAQobjAdPeggOB96bJV63lpGjZcEx0vNCxyWAWyMAf
         FH+4ijYLk1KhrjiYfQ2mTy6+H/Sb76aNpMUjTbTZ9uy31VW/nC1n9GMhn+2Ju1xxaUId
         ZTOhQkuJf1lMXtiHo9cG6WNP73Jb1kfLmx7i2Ro5p3ZOgcG+wVqvzUTUFZFKhUTzGEYc
         QepzGvIdaicCEU0Hy2iD5uJbez+X79NxhgzuFrAA5jitVlTbae1KPC3H0ZK1Q6iwK/7h
         hEMg==
X-Forwarded-Encrypted: i=1; AL+hErHsAjrsRGYXF5SsLBUKBSPjE4UOMg6ecH+YmMnCpWUQZkMmhGkkf0qeLRRW+jL65PXA5u5djTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3/Z9IJG/h+Atk8VSgVGcubFXOJtBsgBqp75Q9WBiSXhe0oTFv
	i3AqjR9YM2K191wK+tGkJ/UwyLLg8+TosI36VJWQyfS5ntpskC6smofM
X-Gm-Gg: AYBFou1KVZDQISWhWyNXuTwKrja6XFTvey1EVcVT+lmha8i/iWjdRyoInkkZ30XzhYy
	gXF8nkRhBIXKwmSQljNy+sNXDAXPlOXDPt3t5FGRDkoP5Kxq+lrDcUXpjxaDDm/eJQcOdXC+G1Z
	7QFHszcITYuQ7YS5tiaRuLOqkzNO2UxCtMRhOXlJ/aRWUj8fwo9wxLXRWWm6Litx79FWBKcDTZf
	1d2ijvM8MBoc2UMAy2lWD0DY9/yERAYufps/sIsnYOOdsQV99nFu+S2nh1WX5+9L7r5J1YTYbh/
	IUDJ5JyvyV+z8drpivtyRA1i23BwWp06I5BO1lwsF4XKw+SwtpIUSP4ZxSPnU/BKYsGaR7DjmqO
	BWXiMq42yHVsxVcX6P+nNcGnf9Iq3VLQ/e019CFpnoa1HGbJrNRlo4w5SAfO+5HUurhdAy2srPQ
	uls4BjzHX5nzWcTYjjnDBM6Wwfw33p/qVY0m/1uGKYkw7L803ctC9kOQHM7YzKTmYLxQI7vi7AP
	F8H3TY5shgJr+fRdQ8iECwg5/cgr4VBF159wlmzN497j9y7ljTm5mfp7cOAOlHw17awYG8GUJv2
	2DAk+IQ7bz98FIX4JT+N6ZczuC3dvTyVgpTFRzbJjTHUI9npcQnQJIV6f4hbMEDvZ07gx13UrSK
	GFbENu/cVIkMCToXDDg==
X-Received: by 2002:a05:7022:f519:b0:1ab:faad:cba with SMTP id a92af1059eb24-1b3c034e284mr1319869c88.34.1794380202584;
        Tue, 10 Nov 2026 22:56:42 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:41 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:11 -0800
Subject: [PATCH v2 13/33] HID: logitech-hidpp: fix K750 solar battery
 feature lookup and reconnect
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
Message-Id: <20261110-hid-logitech-hidpp-v2-13-30743e91d83b@gmail.com>
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

In hidpp_solar_request_battery_event(), the driver checked whether
hidpp->battery.feature_index == 0xff instead of checking
solar_feature_index, causing it to re-query the root feature table
unnecessarily or misidentify whether the solar feature was resolved.

Furthermore, in hidpp_connect_event(), the HIDPP20_BATTERY block lacked
a branch for HIDPP_QUIRK_CLASS_K750, causing wireless reconnects of a
K750 keyboard to fall through to hidpp20_query_battery_info_1000() which
fails because the K750 does not implement feature 0x1000.

Check solar_feature_index in hidpp_solar_request_battery_event() and
re-enable solar battery reporting via the solar request helper on K750
reconnects.

Fixes: 696ecef9b587 ("HID: logitech-hidpp: add support for battery status for the K750")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f717f0308454..cdeb1b3c2f21 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2122,7 +2122,7 @@ static int hidpp_solar_request_battery_event(struct hidpp_device *hidpp)
 	u8 params[2] = { 1, 1 };
 	int ret;
 
-	if (hidpp->battery.feature_index == 0xff) {
+	if (hidpp->battery.solar_feature_index == 0xff) {
 		ret = hidpp_root_get_feature(hidpp,
 					     HIDPP_PAGE_SOLAR_KEYBOARD,
 					     &hidpp->battery.solar_feature_index);
@@ -4582,7 +4582,9 @@ static void hidpp_connect_event(struct work_struct *work)
 		else
 			hidpp10_query_battery_status(hidpp);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
-		if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		if (hidpp->quirks & HIDPP_QUIRK_CLASS_K750)
+			hidpp_solar_request_battery_event(hidpp);
+		else if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
 			hidpp20_query_battery_voltage_info(hidpp);
 		else if (hidpp->capabilities & HIDPP_CAPABILITY_UNIFIED_BATTERY)
 			hidpp20_query_battery_info_1004(hidpp);

-- 
2.56.0.542.g3ef89b7020-goog

