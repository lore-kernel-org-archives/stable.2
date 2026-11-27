Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806598;
	b=rRKL8FwvVIjfyAu7ofg6qzuoO8AwzkprxYpyvMcYTgo4n94o7flehPvIcPcGdpPQwLMM
	 xvX1pHs+PJ6Ki9EoMBKCz92AgsYVmw92yNrz+cvfvMAyxscFW3IQXnjasRhFCiIwOU9c5
	 alYU0oC/NJ0INIJoY1FdrA8jqK5m+Hzb3s7xszxXXpRzJjVK5hXjUDoxbYbrHbsLyFQDD
	 3mIFCezp4s730BF7XHgv2xlG5lHwjMv6eHstfL/eJDcSgMgjK8xToiiborDUmqtbxYqGq
	 4OEYxbm7JqgfKbVV8VY/YGZdczSst9gijQsOeX6G8OieKqRhmOG8LpUHbiA9FgsWC0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jnEBKmIjlMDJzz7/vlO75PN6QRpLxAhezHtALAyCDMU=;
	b=0WvYkRFUigOB4FKBZcqgsp2D/Ip0lK4dLP8MyXWEuwPEwoqVwg/fCpsnSViRU35onBRf
	 YKF1HZBf3P8gemBh313dqDwXUblU1b47ZsFVokdDOQkWxcOO7bS37zkflnKczFeNzAYQY
	 b+hd1/1/8tLycIIOgGO4HM1JKyWOxe949fV2NcyqL5JmE8rY0Vapo04xOgAs8njItTba8
	 m64nPY9EKbi3PFxP/19RPb9gSctv4NJH/ZyQL8Lq0cqxj7py0jCI0CXHmei+yKwII0ASQ
	 DNyQXjR0Khi8A81FKT7Qheww/4dCn4tURbp+SMprja3uCNVEsEyqEg+3ZdBHmMec3ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q6nMvkMS;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC100606A33A
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC100606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q6nMvkMS
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c516a194350so362883166b.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806596; x=1796411396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jnEBKmIjlMDJzz7/vlO75PN6QRpLxAhezHtALAyCDMU=;
        b=Q6nMvkMS/6xOHo8tE/uE7YyMfPdgwFb3iQHYfy7BS9+nniOwVyvXwLl7Gc+Y8gOBEp
         0xEWlBwnjHE1USHlsTzxhx1IVyxw8fN6u/S5+m/LVu3nkAFdbjnNP/macFHfBr1XHPJp
         DRqz7Y/njOVaLTmYQwOxAqzDAjOqV8+9JSJ/D5Y9F567spN+79C3nBx78HIl4iO4BHZe
         smXyOxA1OjQ37FA6Oj2ObUtFNBLWWOqyJTROPMq6v9lfnfYX2jvGP5vVOG/yUCgbIjn1
         hM0EN3tkLvA4ftyqUk4PF2f8H+cLRRuHqQSlGHEa1tb3KOInDPPxBm7xXGf2rYFGbB61
         whlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806596; x=1796411396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jnEBKmIjlMDJzz7/vlO75PN6QRpLxAhezHtALAyCDMU=;
        b=bM7AfvNo3kj0KSGTPIsJtx/nSWBDL3Buixk7G3Q39fEhdzLFv6zZ2XfaZaWb8E8r4o
         3nsoetjAiRD3JtjikqvS8CtKhNanit5JrscgYchOwQIqujypiWoDeLg1R7Zljz4RQ7hA
         74iAbVWkaDtOAPu6TgHbe3XajsDjAFCk7xjLjpaCCDhWKQE93yHuBmTnrxRHwp7ZwB8P
         6d56HfrF5u1y9Xj1nLJYKZg15R3iUaszlCdnk7oM4hZotUnKlYH8eIrQ67WLFi/9Afgu
         zUGo56kfKqNGA2uDUNIPjk9gNv4bPkC0SbOJVeXdhoz8Cqqmu1jbrm80tBUnyq9XbMVS
         zzXA==
X-Forwarded-Encrypted: i=1; AL+hErHosweJPMbyUEv4PojOjCbPiCqNYEyrXnhVjs1ZwSPq8dMX2kBZ1tL6zGpE0B1mqtLqITqnjUA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vacQdGw2VQZwwPAMZu87M0eeF5aWd5Pdm7aV/tTqT+ttnqCjS
	ZaLAz7D2XrXtEHtciyz0XbjJzsrumMqVe9aI1oumYzz8Qkn7vSKsMxYJxAQ6gUFJHGc=
X-Gm-Gg: AZFdTZf/JrbkHww2OItcLAi4V6WQesmxz4uE9fF7b8WKruWUSxsvPqaYcZnOJRlnp+J
	q07P4h/oh4fmgFG2dqbslTk4j/5xq05Ll2WO0FVwlvtJI4Jbh1kOnC+yeMeBHMCwqA0ORMwMrwd
	pVVAtAOYRZ5s7T+oU2Qd5JLxEzbN4DA/BJ59lOM2tfqNJ/XaB5ctme51e7sCvH+8X3p7KQLzbKQ
	r1i6XCsMw4pWpuKXQDPLCvPsTAJ41H8UDpg0PzRfga9RYNJIMEj+6IsHVoehaKMz0cv9RDuk2ZR
	dmO47uX9R/ml7ksf4SIAvdxX0ndRo0eh8rxL6iAOj0mCKRkf4ey3gaqZXv+XX8TtGb3/BDrl9u5
	g4FhhiJr0YTdU9gHf7WjDhy/XTPklt+22v7YVWEH+VTNW8Vl9X2tqgdScvA5CQD5QnJnvCkPDmr
	yQP9V8Pie2P/5WauL0qIwlC3XlmhOToAPZQOI8ow2slm8oCpGbMXtcOWCAcfZT4SZ7lRckvlWnu
	SGmnO9KR63Jqo5rb6q3AE4aKSZwwZBFDGkCwbi0uXemMLcGcTcBvpRleB2CzsDDrHtVT7sstXYJ
	Ls+qQxRPcVZvxkWgPV1jXiHeb6kvjV5YtoWxtihtRLN62v3SCazpx0k3hepN47Ji1LaOEBTTHRO
	MDMxIF+sIXPK5BKjzkA==
X-Received: by 2002:a17:907:1187:b0:c49:903e:1e19 with SMTP id a640c23a62f3a-c513a8595d0mr1656720366b.26.1795806596148;
        Fri, 27 Nov 2026 11:09:56 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:55 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:53 +0000
Subject: [PATCH 2/6] power: supply: max77759: report charge voltage in uV
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-max77759-charger-fixes-v1-2-b364a0862d72@linaro.org>
References: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
In-Reply-To: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

The max77759 charger power supply reports constant_charge_voltage_max
in millivolts instead of microvolts (for example
POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=4300 instead of 4300000 in
sysfs), violating the power_supply ABI.

POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX is defined in microvolts,
but chg_cv_prm_ranges, CHG_FV_DEFAULT_MV, get_float_voltage(), and
set_float_voltage_limit() operate in millivolts, and
max77759_charger_init() divides constant_charge_voltage_max_uv by 1000.

Convert chg_cv_prm_ranges and the float-voltage helpers to microvolts
so the driver reports and programs CONSTANT_CHARGE_VOLTAGE_MAX in uV.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index a75005c0b582..6876ae0a8188 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -25,7 +25,7 @@
 
 /* Default values for Fast Charge Current & Float Voltage */
 #define CHG_CC_DEFAULT_UA			2266770
-#define CHG_FV_DEFAULT_MV			4300
+#define CHG_FV_DEFAULT_UV			4300000
 
 #define MAX_NUM_RETRIES				3
 #define PSY_WORK_RETRY_DELAY_MS			10
@@ -60,10 +60,10 @@ static const struct linear_range chgcc_limit_ranges[] = {
 	LINEAR_RANGE(200000, 0x3, 0x3C, 66670),
 };
 
-/* Charge Termination Voltage Limits (in mV) */
+/* Charge Termination Voltage Limits (in uV) */
 static const struct linear_range chg_cv_prm_ranges[] = {
-	LINEAR_RANGE(3800, 0x38, 0x39, 100),
-	LINEAR_RANGE(4000, 0x0, 0x32, 10),
+	LINEAR_RANGE(3800000, 0x38, 0x39, 100000),
+	LINEAR_RANGE(4000000, 0x0, 0x32, 10000),
 };
 
 /* USB input current limits (in uA) */
@@ -310,14 +310,14 @@ static int get_float_voltage(struct max77759_charger *chg)
 	return ret ? ret : val;
 }
 
-static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_mv)
+static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_uv)
 {
 	u32 regval;
 	bool found;
 
 	linear_range_get_selector_high_array(chg_cv_prm_ranges,
 					     ARRAY_SIZE(chg_cv_prm_ranges),
-					     fv_mv, &regval, &found);
+					     fv_uv, &regval, &found);
 	if (!found)
 		return -EINVAL;
 
@@ -555,10 +555,10 @@ static int max77759_charger_init(struct max77759_charger *chg)
 		return ret;
 
 	if (power_supply_get_battery_info(chg->psy, &info)) {
-		fv = CHG_FV_DEFAULT_MV;
+		fv = CHG_FV_DEFAULT_UV;
 		fast_chg_curr = CHG_CC_DEFAULT_UA;
 	} else {
-		fv = info->constant_charge_voltage_max_uv / 1000;
+		fv = info->constant_charge_voltage_max_uv;
 		fast_chg_curr = info->constant_charge_current_max_ua;
 	}
 

-- 
2.56.1.839.g22a8290db9-goog

