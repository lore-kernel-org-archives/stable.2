Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794014808;
	b=P4r8LMhcns6TjTEW5abuKFjsoKGTmiegPENW7UAstnAq5xxPMzMcCuKqUjrpLmFQIB6C
	 jMUFbzRhRq5FNutJhVN+VWXOhvsGgnT+hi2cUKfyMYGDA12iDxRLcW+1wgI+Ljpx6pgoH
	 pB5/2HqmYK+v/6OzZ7FXq3/wS/FncJrzB2MhEl5CM/t0b1CuVhqQI+sYZV8QfSQBiijJd
	 FfTOXTMVO37Mb4SbJQQtGxCKXH9/gV5voLEDEl2QrzAfEl63cUZbKHeugxXHxyqUG6d3N
	 TzJE9t8s8wIh2sjSIAu9ETHUL1ia3Yz7zeh9LRTexv1zQUbYbjZBdolihcHIt/l5VUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794014808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wlXk6HYre5osGueEzlFOqp7fwiA8+1yEGjyN3cM9QVU=;
	b=w2g+uE39g00x2RLrxIVnn1LEz93wSGZwT5b9c0mZQnVFbR8ER6+g/tW1DXyiWopNYyjs
	 8tyD0+t1RDXKnm6zXO72iHLjbwOzXDzZqgRDacSIXN5FZrxLLBeszQ06OYW6qz5CfX22j
	 g9Fg3DfUL6TFGoJkrVpFGWnsR1EzjBgJwsjeLJ+s47kkxry2Zgr0Jsqy2P3Tai1tJsiJk
	 24I8I6YPqnNlaZJm6HXzwlb4j/pJO6axI+6cXuA9zZhrw04N3a0iezuahRUoSfOo0pjBD
	 y/USKLK5D0uJ7Ttexvmk1Uiv2m3B4rdcHOkssswE0yT9ak0D/Es2XUlP9RbKZBgE9bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhgaWgwd;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 01:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E37D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhgaWgwd
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so11620895e9.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794014807; x=1794619607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlXk6HYre5osGueEzlFOqp7fwiA8+1yEGjyN3cM9QVU=;
        b=EhgaWgwdErraFHP2TfEO3j2VLtOc9jTnlpqMvMk9e4xm8Rg3dfkoUOFnStr7CAHL3r
         9ASP/OzoJtz363Fn5iQ3S5HtI7QzGV6U2Kl+R+zSTR0Yq/FbQYSGfYcBg+TayNYjDUVy
         i2grb49jxpLX2BmhxhhPocm1vxflVuDEsfSAGHSzGaJ7kuoJwamRaiBUaafu5Ko/qops
         3QvJ9jATcicC8RJlPQG8d0/xw//LDKWkpqn3iQ1ynFwVHvJFr2OSQeVFhswaaXXNLWJg
         0/XV7SfDdOFZRhmLCbPmA2gzhB38bSnMNWPWjDMn0w5RB7WLrdsryj4kSx+eYHPsZM/l
         PZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794014807; x=1794619607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlXk6HYre5osGueEzlFOqp7fwiA8+1yEGjyN3cM9QVU=;
        b=w58VMWa26sRnAs5P5kjef0MkoC3331FpR6OZPoMNS5AnnFgswIwdDVuKY1qLiyD3nS
         BjAJvISLoEjnBUyM/0rQks49YEk+KfmokEaBVntrLykIG8clq4e+s6RySAt8lSPlWjZe
         9sps9MSiHJMpXl0igx58yQjZGYzvjjC39hBg8ZVapfMoeGdOTXK9Wv5ar7ux3KJAUDcA
         YcUm8GgGdxmWlTjbfW5xtrgRDgZhcAtHX7YeU1gsOkdYEKaJX9cRC8kS05hH/CnPyqUI
         u7S7bIcAt8zHNiH01/z1inzOFlIQU1OD0LM2gzLLt1q8mKU5JP48rxLmXzTN/ehAwbil
         zBbg==
X-Forwarded-Encrypted: i=1; AKwUvBxH0qNdIewhl0SdX78eW01CW8pWuRBhblyi58h4WmqffQYQbrfz4FDG0AfFDkUysISkBtqZNiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zz4yOKMe1mQu3xEDXulhy396hJJ5CdoBZFb/LhQu8fqmatZZK
	eBFnw1v9kSoxC9JKRUUXzanKOnsimHOkgeH3bP2jMf4hNT1rDXoOLwke
X-Gm-Gg: AYBFou1QrZUlZX9dioNji4FfCng1z8AtleFySXLt6vrumurUwFxcRn04uh//4HOYHwa
	yj344E0cSFrM7bpLrsfyGJj8AqJ3/13IL+1d9LgSHC2Dzv0IbBvQQR5FulUsV8K/83gfw4aOQ1T
	s2QHWBmec9j8vEN5xH8vG0PuOzJRNfBLd8ZEpTuOPuWItoHT97DQLxK7FPlP2Ee47sSZG2IqE4u
	GvdmxS0B6ZKlGFQBswwOUhInhYpSm+x/7Iwwf6XmgOXmG1ujlMdQNZOTw2R19571In+U23VQgD9
	F3jPHPnd6DUczNwJEnd+gg2MegoaAuA46PGKa6RMyIq+BciSxePemXwfkOaDpMZQThouizXl6xb
	co1FOtwFpNm4lsA3orsURtF/Yx/5rllOanbN78NkfqKDb9jFpRAMt3rUslAvWuL39hZ+suvr3mk
	RuAnRS+XyFSpzynq+Gz47b0rdWmuBsQmLDmzxOPKwK046dfaUZ5wqnl49gJydjMxfffxLMpvQRx
	R4nyHKfrESR/ayx9F6noN1xzY4lRNhHFUyS8TSehgBB115wYnETVkARtElpvzLQdOPHL6NtrioU
	EPGW7dJtelNvPgd9IJ5eZoFRpANWnpU03I3xCjuh9A==
X-Received: by 2002:a05:600c:3f06:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4b6dc6ded37mr61622705e9.1.1794014806720;
        Fri, 06 Nov 2026 17:26:46 -0800 (PST)
Received: from beelink ([187.13.199.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271abasm22773105e9.4.2026.11.06.17.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:26:46 -0800 (PST)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] HID: wacom: validate battery range before scaling
Date: Fri,  6 Nov 2026 22:26:36 -0300
Message-ID: <20261107012636.1008932-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106213526.3393779-1-qwe.aldo@gmail.com>
References: <20261106213526.3393779-1-qwe.aldo@gmail.com>
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

Battery events divide by the difference between the logical maximum
and minimum without validating the range.  A malformed HID descriptor
with equal limits can therefore trigger a divide-by-zero exception.

Move percentage conversion to a helper that rejects non-positive
ranges and accounts for a nonzero logical minimum.  Clamp the result
to [0, 100] as an additional safeguard against out-of-range
percentages.

Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measurements to percentages")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v4:
- Reword commit message: describe clamp as a defensive safeguard
  rather than claiming it handles a specific ADC scenario.  The
  caller already filters out-of-range values.  Code unchanged.

Changes in v3:
- Drop s64 widening and div64_s64 as requested by Jason Gerecke.
  Use __s32 range with a <= 0 guard instead. Keep the clamping.

Changes in v2:
- Clamp the computed percentage to [0, 100] instead of returning
  false, so that slightly out-of-range ADC values do not prevent
  battery registration or silently drop updates.

 drivers/hid/wacom_wac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 361738b..36bab07 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1960,6 +1960,16 @@ static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 	return;
 }

+static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32 value)
+{
+	__s32 range = field->logical_maximum - field->logical_minimum;
+
+	if (range <= 0)
+		return 0;
+
+	return clamp_val((value - field->logical_minimum) * 100 / range, 0, 100);
+}
+
 static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -1973,7 +1983,7 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 			wacom_wac->hid_data.bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
 		}
 		else {
-			value = value * 100 / (field->logical_maximum - field->logical_minimum);
+			value = wacom_wac_battery_percentage(field, value);
 			wacom_wac->hid_data.battery_capacity = value;
 			wacom_wac->hid_data.bat_connected = 1;
 			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
@@ -1981,7 +1991,7 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_LEVEL:
-		value = value * 100 / (field->logical_maximum - field->logical_minimum);
+		value = wacom_wac_battery_percentage(field, value);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
--
2.53.0

