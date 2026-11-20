Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164080;
	b=SALnjTPkWjdPQX6ySHbcta10WcIlfPXccEZGD4BLSVsJh2H98+gC2Bad1vEGR24koMjl
	 ZnLVI6tNWqmxhS7ApLl7Lyn+oM7IJFdaA67JtFXkXq2TFxckgr4fJGlLwIC7rv+gy2n65
	 OvVf8h5EEyJon9U4kSwtZpaCeFJ++oghwL/7h2duVn7JQBtH1tSd/iQMQJDmLmKDCWiM4
	 GNhh0v+zeTbyz6pD0DMJoLQtNwO4peNyftGtfqksvlNqH8n4W7/ibq9UxYkpHmvJO79RY
	 Tp1DmoLes0NIdPf1t7bqID8b+HfFCOOImpHrb4qT7DgVFuphY9Ww7DBVRMddAWBQrOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=B3S7G7b9bye8TH3pDQ6FGxRtNzK8TEwIHow/DDgOdOU=;
	b=ZcVN1WowjrimJbLo/Lk0aZnK1E9+WzcqIYz8kQOnOuPAgrhs6VXUX1S5vWbKv398RSu4
	 RxLIUTZ4FJm5B75isR9fasn9PQIH31aYcKPz9lrtk/7fh103VI004pA0CTW3pKIJpNtBA
	 QhBbMkP5gqsJ08pgZhzsUbf+ugPU0VFf+DLMcOXAb6f7ICmF+7F2GAlzKC7ab6RsiA4Xe
	 b+IfKi9Egt2FIHjrpnulJSR9ZE0WiEx3CGvd91YE4ZbgoGkSW84I4UO5XVuY9QmznZGex
	 yDf641FAyNHD2WbGR8XmpcVabzLbD736UeebLedcRSxNk/gVElZF/EJ+XsVtZVXkc/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okn6srFl;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7860A262A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C7860A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okn6srFl
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-372bdb942dbso825334eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164079; x=1795768879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3S7G7b9bye8TH3pDQ6FGxRtNzK8TEwIHow/DDgOdOU=;
        b=okn6srFlkBXzTrb8uFg8Vx6Xl4YtwxPNpldaWNYmjndNTscTMmdlFfzchYc7kU5ms4
         DgGqbDtgYS+D3Wvp8sYZ088ENqY1DRJ8ummDicwi5+SQQlVUQYwqZA3dcRnHNAfi21iF
         X0Dtd3kwKZHPltw2BZlD+sOoHR5Mpo8EfhK45EWoYxRzxR9/YCdpR4ZrEaeQKQhOKuxC
         4j4gH/37z6fo5eConjfUkbMa4W37bjUwmjc3wLlSmmtq8/7hpZ/+Vfe9ICBg8o0XOwbp
         TqHfiS1X/oIM5hZpV4eYW7g+6D9NMIfYqIYNdr6iQ+LZbCGqWST18TGjIslO48oKTzpl
         d9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164079; x=1795768879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3S7G7b9bye8TH3pDQ6FGxRtNzK8TEwIHow/DDgOdOU=;
        b=uHayUzJEzAZiQAGhP3xuS1eoQs/Z9FiL7l47ZCp2tP56eSmzE6D8LO3Nyj/VTCpR+y
         iK6taLy52GXY5vfmfdkVoRTBZ8Du2p5nBan96TRwLhjRkOnQaHD/Giv0/a4RqNSnTHvI
         BiFz09TZrUfY072aa+x7MDsQVXUiAFBCIonpudpTNV8GG4bczzHWaUzzk4okTMveD5U2
         BfOFyjvLFx6o9U0RS22f2IQBxwwDdXuSVT3MQbvCeVe5s8YmM9n39kn/yEf3MUjYrpvw
         2xOqcOVQWQORrlTC/11cQf890A0rl8cK6oq2WWS7Qlq4fQHoKI2QfIjJqxqoziiL2jRs
         shKw==
X-Forwarded-Encrypted: i=1; AL+hErHXzLbX8voUB56rSzHFApczvU4NUy7bANeQR+SV3M36p39/WDkrXAdgB9CXHjs0pCGeXhgBuLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b9bWutBL92Hzgd+UCB/B8a0jTiBpsfxmz32HaWaokruZnQLBb
	w8VYAtQV6v9M0853JaVoVFRT9IPqnvBpsxV+GLJAwcu9J+o55/MhZ+SI
X-Gm-Gg: AZFdTZcPbye4hgaAPnvxvt4sOC1cLXPBHTVQIrfihUoivKbYqsK1jf2NTUKBrYCUFnv
	3wyFaU85xD3EyGQ8j8PfK2Lf3JRg+oKum/15kn3wQrRTLGvl9mKMNKTnRZCsCDG2H0oYmc1RqGL
	Y5klDoW4R5e7V3k8P5w1WzyaK2A/nXbO99XnAnBL/EgwCHWBclrmerxTZ/Kd9KS+AwGxAB4WH0T
	VrMGkBdRXethyCltnJMC8SXmvsVCOOakapXLRGqwmLCOklvJCFqL1xUrGOlg1xbfcTC4gggVOSz
	Uq/usS8/xQPZMMszgjrqVUpWeBNE2ABHMefiLqeSK+P1v+G6+cOJZDXSSwXCf+/58oyTAV54IZN
	EHxaEpaLcawRgbJciEJR8ND0SP4oRsztR1ICVrk6QZ84PwJVWjr0gDJj1QAxJ+9csjsevwgQIMD
	129aF3OofziWjHuTzmQFpHMHk2fQNE8hOrH8Vmd0Nt9KNnye7RbU8Ng1zVlsPedPi7bzIKEdiS/
	U4fuNw3wnQZI+ss2YnCrBU1kydbXeEIBvGZg3V35DF0wt0KsthpV0u8ci23avi6YcX8IUeDHpKM
	56fPgLkFUcfYAZ0t76Duoxc0R2BeA7NDpWr6cSHvfE/S+3p0Vo6b/WKq4QGJqEoQxafygtLMoQQ
	EpxgYwuqQn1aWNxaQGg==
X-Received: by 2002:a05:7301:6285:b0:369:f182:8e99 with SMTP id 5a478bee46e88-38570554684mr2335097eec.35.1795164078916;
        Fri, 20 Nov 2026 00:41:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:18 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:41:02 -0800
Subject: [PATCH v3 14/14] HID: logitech-hidpp: expose charge_type property
 for battery voltage feature
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
Message-Id: <20261120-hid-logitech-hidpp-v3-14-cfe2caa1d0eb@gmail.com>
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

Commit be281368f297 ("hid-logitech-hidpp: read battery voltage from
newer devices") added support for the 0x1001 battery voltage feature,
populated battery->charge_type, and handled POWER_SUPPLY_PROP_CHARGE_TYPE
in hidpp_battery_get_property(). However, it did not add a placeholder
slot in hidpp_battery_props[] or register POWER_SUPPLY_PROP_CHARGE_TYPE
in hidpp_initialize_battery() when HIDPP_CAPABILITY_BATTERY_VOLTAGE is
set. Consequently, the charge_type attribute was never exposed via
sysfs. Furthermore, hidpp20_battery_voltage_event() only checked
whether voltage or status changed before updating cached battery values
and notifying user space, ignoring changes in level and charge_type.

Additionally, hidpp20_battery_map_status_voltage() unconditionally set
charge_type to standard (or fast/trickle) charging even when the device
was discharging, full, not charging, or in an unknown status, and
hidpp_connect_event() left charge_type stale on wireless disconnect.

Add a placeholder slot to hidpp_battery_props[], update the fixed
property count in hidpp_initialize_battery(), append
POWER_SUPPLY_PROP_CHARGE_TYPE when HIDPP_CAPABILITY_BATTERY_VOLTAGE is
set, and include level and charge_type in the change detection condition
in hidpp20_battery_voltage_event(). In
hidpp20_battery_map_status_voltage(), map charge_type to unknown when
status is unknown, to none when discharging, full, or not charging, and
to standard, fast, or trickle only when charging. Reset charge_type to
unknown on wireless disconnect in hidpp_connect_event().

Fixes: be281368f297 ("hid-logitech-hidpp: read battery voltage from newer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index dbf8f15f5a5b..966c5932528d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1428,12 +1428,17 @@ static int hidpp20_battery_map_status_voltage(u8 data[3], int *voltage,
 	else
 		status = POWER_SUPPLY_STATUS_DISCHARGING;
 
-	*charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
-	if (test_bit(3, &flags)) {
-		*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
-	}
-	if (test_bit(4, &flags)) {
-		*charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+	if (status == POWER_SUPPLY_STATUS_CHARGING) {
+		if (test_bit(4, &flags))
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		else if (test_bit(3, &flags))
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		else
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+	} else if (status == POWER_SUPPLY_STATUS_UNKNOWN) {
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	} else {
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_NONE;
 	}
 	if (test_bit(5, &flags)) {
 		*level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
@@ -1553,7 +1558,10 @@ static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
 
 	hidpp->battery.online = status != POWER_SUPPLY_STATUS_NOT_CHARGING;
 
-	if (voltage != hidpp->battery.voltage || status != hidpp->battery.status) {
+	if (voltage != hidpp->battery.voltage ||
+	    status != hidpp->battery.status ||
+	    level != hidpp->battery.level ||
+	    charge_type != hidpp->battery.charge_type) {
 		hidpp->battery.voltage = voltage;
 		hidpp->battery.capacity = hidpp20_map_battery_capacity(hidpp->hid_dev,
 								       voltage);
@@ -1795,6 +1803,7 @@ static enum power_supply_property hidpp_battery_props[] = {
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY, */
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY_LEVEL, */
 	0, /* placeholder for POWER_SUPPLY_PROP_VOLTAGE_NOW, */
+	0, /* placeholder for POWER_SUPPLY_PROP_CHARGE_TYPE, */
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -4398,7 +4407,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (!battery_props)
 		return -ENOMEM;
 
-	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 3;
+	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 4;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE ||
 	    hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE ||
@@ -4416,6 +4425,10 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		battery_props[num_battery_props++] =
 			POWER_SUPPLY_PROP_VOLTAGE_NOW;
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		battery_props[num_battery_props++] =
+				POWER_SUPPLY_PROP_CHARGE_TYPE;
+
 	battery = &hidpp->battery;
 
 	n = atomic_inc_return(&battery_no) - 1;
@@ -4511,6 +4524,7 @@ static void hidpp_connect_event(struct work_struct *work)
 			hidpp->battery.online = false;
 			hidpp->battery.status = POWER_SUPPLY_STATUS_UNKNOWN;
 			hidpp->battery.level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+			hidpp->battery.charge_type = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
 			power_supply_changed(hidpp->battery.ps);
 		}
 		return;

-- 
2.56.1.750.gf70dc682cf-goog

