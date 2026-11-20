Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164077;
	b=HWJ2OZwVqkOEc+72KTb7wTJHhJ2UnwuZT1K4xUmpIVX8O0TeemZcy4eq+Vx/Re1tEEBp
	 ckqhzoHZlwh+OiL4RpNLrAP7pZOaWsLu+9sqbtOOdVk3WcPuL7EB+0rSchj4Y37OAewai
	 +mMrEuzrFa0n1DyalSDR+BKqdH4u4bop3quo7fvB7axyd9NH/nMfysrFPYsaj3Z69corq
	 jBlDBifpxHpolon+FSU/SipZRxsxUIL9sfMAo++9NZYAEULsPe+tHazk0S8XDhoZ6Zb2I
	 qM0qja7q7AfkwpQQTLm0YNeafoc0iELTkYeKGjtnuPAI+bT2pgNFll6mjGJrfjJ+/NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=eakGv17JCMk0nAPgz+YpjcrUUEGyOYJEafBX4gfQmKo=;
	b=tUDK8SX3D0kZ8UmM0NWJpFccvADcArgxDcNGWLJ5ZujXnofPErUCPtaz7uQe7BE6MOIS
	 r9yO5LmDot0DjR2YeuZ4xVnC790OErERuCNXty6Rn08hiG29cCudSo+QL8n+ZXFNl4TmT
	 7u8f3agEVZ/0s/xZtoD+GVyb9n5CmszHsB6cRfBHzOqBG3acSaseuQTHPV+mKRPxP1LRT
	 vERDA0HFdh8kY548D8XPCFgdgpoKiOMedfUxyInEqDHlG4ToKf5zln/HnMd3QY1jMDOPE
	 XotR8/j5JQZp/+tYf5Otf9NS2SryP5XXqWsLZJEycFFGV+bFt6SVYkvvlIIYFLBHjXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bdPYE9ai;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAD606A883
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDFAD606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bdPYE9ai
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a315ed211so689237eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164076; x=1795768876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eakGv17JCMk0nAPgz+YpjcrUUEGyOYJEafBX4gfQmKo=;
        b=bdPYE9aiVRydFu3htQdbcm3SSeRg0s2d487qMGOc21hs/5ORfzVPIBeDeOnIUNEqLa
         WOOTe+7dTC7wLN7x7RPOWn3uuo8JkVtSCFyRbOPm0ElgnC0UhCdecYj1nQqnw3PPf/tQ
         1bVx7tuQNZbFDQsbgQnjXasdmUkQvV8lY57sNmkc1JRVy9QT2u8wmzmUzINNDGuRmXyw
         TuXeDDLzPfSz7VUHyzP3VUtl31Sx6s+289t678najQ2deQ7ZfndQ9PpGVZw3qHmQtDZu
         EECjGd4CzFALSP/OzgCQxT2SQXwLo8ItSefNfaDanU7Gz/pBmN+1zAZUTKA8nOabRWds
         Y7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164076; x=1795768876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eakGv17JCMk0nAPgz+YpjcrUUEGyOYJEafBX4gfQmKo=;
        b=Hg22CX/7HcsI6OrN/FdFGrEEHwY7B85RjH0p7dTjJcI78ainPz+/ZW6UyETsWEDYEN
         4F6+wblrXi4I7+ITyoQDsmkkgZViUsENtVLcmExj1kaXD1fxZ+QFpIHl/TWzYOGCwM8q
         Xrh8Gd1W2M733jdF4RsPnhCWdkwINdJCR4IruX3N/ThCyTrpTJR/w6llEDs2AGqw12/I
         ObnZbOtAv9sAYWupiyyf41oL75Lh9LNzfx9u7uCbM/0GeGtPUQGxLDLKYWI2daquMxcV
         AW2MgKYWdTwgT5PS5MkD7KE9o/Aalj/cK4G4Th5moi61cJqoYcSxyuh1oBAa4Ql1igAG
         +TFQ==
X-Forwarded-Encrypted: i=1; AL+hErFnGkEikhFgNNbjHL6faWD3Om0+bO/0zaY9nomDS3Lv3vDXqCE262oyXofwJ7FgAaLsRABgiMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nxMQpJ5iNExsrAwT7p0/WYEe9nTY+pCm+Lg2mDCxwR27JKpBz
	RKjiuKiL/JDqyCej64WP0YAWWUSS5dz5l1FPYbb16cNCNdvq1Y1NeDh/
X-Gm-Gg: AZFdTZf7SkgEaYEYmTyUbcYkYR9j9OwrvesqMmeh6Fsjjt4krBu2C1VH06nqQ+jYWLX
	nP0bQEYE/oBvYXdzr84FPnqof+j8IvCMgXR2mtRUZ+Qsl/I3hFqkLnInqtjycyu34ff2URP0t/l
	V6VLCvnj7sKoclGJ1yUNKLv3tVNQeadcMRf90ikindTqQObGj1PMzCPiw2374CTxHEkMd4pYp/r
	y2KQ8ueArzk9tndHItW61P7WQKXAwfObEsrmEwkw/1wD4woePrGA0G1ypqE3IK5l2hvNoidEL9b
	FZxNSMXlmROb/PplzsJpciFSfbjJp0K4SHvUFrPqld7DY4sdBC6lDb5j8r/VXyuX0iA53FKqGpm
	GV2YoTTAup4+7qLSk/sJa87NtbkmQjMUKqpQR/MluLOYg0DRRm1eBipYKQTcvd0I4tjNtj9REvp
	kbLFQh/M/XNL5MCDtrzaKA6EojKBbA91HHUqQaPAo/bTJK9a+rVktzr3ET8EhqW/VnKm4ZvgiYg
	OA8VtPVPWhkFASeWBBpZTX93iy3JtNbV49RxJy6R+NOYy7+9ZuDGjFcjB1ER4hkZKmeJ9YVYs/J
	fX+JGyKXR4nymkFbZ1DDiD9lmG60tyl3Il6gk6rphr8XS8/8hP8X9CuABgDJkOOzbFQbVsmeAb3
	+PZ27LsrFxp4j5oVnfA==
X-Received: by 2002:a05:693c:414c:10b0:37a:15c:b8c5 with SMTP id 5a478bee46e88-384b11ebf27mr4053020eec.2.1795164076070;
        Fri, 20 Nov 2026 00:41:16 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:15 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:41:00 -0800
Subject: [PATCH v3 12/14] HID: logitech-hidpp: mark device online on
 unified battery 0x1004 events
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
Message-Id: <20261120-hid-logitech-hidpp-v3-12-cfe2caa1d0eb@gmail.com>
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

When a wireless device disconnects, its battery state is marked offline.
However, when the device reconnects and sends an unsolicited unified
battery status event (feature 0x1004), hidpp20_battery_event_1004()
never updated hidpp->battery.online to true and did not include the
online state in the changed check.

As a result, sysfs POWER_SUPPLY_PROP_ONLINE stayed 0, power supply
listeners were not notified of the online transition, and the 0 to 1
online transition check in hidpp_raw_hidpp_event() failed to schedule
reset_hi_res_work to reconfigure high-resolution scrolling on reconnect.

Furthermore, both feature 0x1000 and feature 0x1004 share the same
hidpp->battery.feature_index, event ID 0x00, and return 0 from their
event handlers. Because hidpp_raw_hidpp_event() previously called both
handlers unconditionally, an event on a 0x1000 device also matched
hidpp20_battery_event_1004(), corrupting the online state and decoded
battery status.

Include !hidpp->battery.online in the changed check and mark
hidpp->battery.online true when receiving a 0x1004 status event.
Gate the event dispatch in hidpp_raw_hidpp_event() on
HIDPP_CAPABILITY_UNIFIED_BATTERY so 0x1000 and 0x1004 events are routed
to their respective handlers.

Fixes: e037acf0b1ae ("HID: logitech-hidpp: add support for Unified Battery (1004) feature")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 28402baf04fb..c960d26a41dd 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1761,12 +1761,15 @@ static int hidpp20_battery_event_1004(struct hidpp_device *hidpp,
 	status = hidpp20_unifiedbattery_map_status(hidpp, params[2], params[3]);
 	level = hidpp20_unifiedbattery_map_level(hidpp, params[1]);
 
-	changed = status != hidpp->battery.status ||
+	changed = !hidpp->battery.online ||
+		  status != hidpp->battery.status ||
 		  (state_of_charge != hidpp->battery.capacity &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE) ||
 		  (level != hidpp->battery.level &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS);
 
+	hidpp->battery.online = true;
+
 	if (changed) {
 		hidpp->battery.capacity = state_of_charge;
 		hidpp->battery.status = status;
@@ -4200,10 +4203,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 
 	last_online = hidpp->battery.online;
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
-		ret = hidpp20_battery_event_1000(hidpp, data, size);
-		if (ret != 0)
-			return ret;
-		ret = hidpp20_battery_event_1004(hidpp, data, size);
+		if (hidpp->capabilities & HIDPP_CAPABILITY_UNIFIED_BATTERY)
+			ret = hidpp20_battery_event_1004(hidpp, data, size);
+		else
+			ret = hidpp20_battery_event_1000(hidpp, data, size);
 		if (ret != 0)
 			return ret;
 		ret = hidpp_solar_battery_event(hidpp, data, size);

-- 
2.56.1.750.gf70dc682cf-goog

