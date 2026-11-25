Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619320;
	b=AGVpE8Jwx0C7Mf1hAlSUnoyOrK+XNFdaJBgjkJtUep2yEG6zLl4AjOaEbGTZsTsgFoMA
	 nVWJ6nTVGVPsTntSe5JE0DaYX41Ji6iFFQhqMfEGB9H3J6+alAdgyhFMi1BVwg6PEUiZH
	 m9LKvLhvdLQ1pkpC8WKwVh8bdGZT2avR0a1cIQncZj9GllT9kvlgfBcJSHhSL6LNrea66
	 laG5Sy3iaYp60hFy1XIxewotZZuj3iLsFVlBoKeVakiH5y8r7bdSc1kQIUlzJw29kHF2Q
	 LEhVN7zXdPQmPQljlh8gp06KwlkX8nh6EDC1LzaV8siQjO5dihJV3ALNq6Bov7/THeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S4Gr1BpsBaaOTn0gg/ejDHt6kh8RADBHEWTGJKbPPbg=;
	b=3bd7RqsLSpeCAs0U8toF1FWMzAxHk3gUwckFgven8vcOLxptvtmXcrjKkAD1GlxJMxfN
	 WDKlQrOMnmoMPJyNdQ9v2Vve0o4STRBvkSSDEaKpPHQmUA+iReu8rKKatzdoHEE9FqNm6
	 QItUzWfDGJbTM/J6c5mkZneWV7tkobF+LilACeeodVLM57nrOmwcq7jDQG52+kVvbNVGF
	 roFf8RhcQl0RKQZzHRLucCnIvn+Isjxr59ns0fkRas9UHz80clPowE3vqb04FHPOO4RcB
	 OaiJZGxLv24m7AIVeoWmLcF1MsssQ7zQKBjUDa4QnN+wRNJlgIaTY1+PJ9oOgGJ5hAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GXvIvO3M;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1587606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1587606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GXvIvO3M
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38699cf08dfso6961321eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619319; x=1796224119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4Gr1BpsBaaOTn0gg/ejDHt6kh8RADBHEWTGJKbPPbg=;
        b=GXvIvO3MK9fE9mqqvO1Zgr8Y11Vl30vYXw3gXTKB1c8FOb3lzWGlQH1c5vufnSYeDJ
         Ayjn7WArVLlqtjPwU06M2Ob5THqZRlvxbACMErJb9KoLGZVQOzSJfQKb16c2EGkTJlxc
         +WJKwQXzuQqXMO3Ox8nWd2HYyFhDUN5ezigbEYJjFAPET2iz4pOL5qhMi+63kRovTOce
         2LwgWZol5Ez6e5xfp4gtxwgry5ngq+e7CKftzAk4P6xTOF0fg0vse3Ru8mCwplGs2Gdb
         tWQCqoCytYCnDWUaJu+h+u2kyN6h7S7kG4vvw0bvxIhWdRslMrQBhc4yFC0lomKd7Dmi
         5oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619319; x=1796224119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4Gr1BpsBaaOTn0gg/ejDHt6kh8RADBHEWTGJKbPPbg=;
        b=IId4Wv0/b2zWACLHzeTAXLF0dYXv3dkt6murtmizTueBXWeLRIvDbXx89GgQ98jWU6
         5RbpnkEluxg1pCG4vWU4xOsElvN5ETpxO29L57gowi+y4WZSHZevYe/0VVNy373Fej4x
         Fr6fyV7oUBKrw1l4GX1syPYHsE7VRvtiQDl6MPGqeO1Q531VEHzHmI96nO71QaLcRAYj
         94Z8h0ORLU0Jzk2p2oz631WHTvhqO6JeKLT4jz3D8IpVMKPZG2pSqvR0F/lsMlMv+jOW
         vHat7o0bE60zxw1KY5zLoZ2JcEbKeaNcMqN0nKxivk34YyFNzqVe3I0jAvNb4gilpSz7
         V8Kg==
X-Gm-Message-State: APuU4Z/W4Jv9adK4a8n3eduj9qZc4bD+JHmbwuohWPMwO0MItMYwpygW
	P5meZXpd1iwtTRQpzFVQu+fQRkZSnh9iNGPhNSR490ZjFJRjoxoDk2YkT7FaW2ec
X-Gm-Gg: AZFdTZdHOr/UZ6DS6/X3NcpZGAFU9LIdHuJxUA+gwrp5XakB5+wxEwGJ/+lDWnOiMRV
	sVbmd5ExzXTyYUOuz0OlimzWcesvl1rof3kka5eudOU04FOucQ/mDuT0nB20wHmimavEIzFDKDj
	P+9RBnHiJjmDLV1cidaW3sIPE96PDmGFhy/9nSs43hgAqOrt6y0fm6GXnHi76Vwe3hVP10HIhwK
	t7Ag63Z3LDhaw7lHLDu4ZPUVPiMnbgx9VBqksXRG1zFQpEzfl5874o8Y6vaDrlfVoMzY4WV5rTS
	4rbWte+TEKZxNLus4YBdlsbkcq6o0LTzhiUda3kTlwi+UxiwhMU+tr75WgXL+0nPNYp0Iv6BvYU
	nlQ5rwU1cuZ5mxiSQLXfmv3TjW+PaV0E7BJxJBG06DUjagKLzdPaNgFiHBvmCdeyNOIsJiu2wE+
	Mo7KUY+JYpSNsvecrINQ0ifI2HPP8sreAPOHE76Cu+QcR4sI+IyfGaqPDVmJK1+Tx0djWemJx1J
	p8pUL3LqnPVmZ7Hh8hVXTLFe+h6Vjrq4SZdoBGaM8KXLcYiN1fH49n6mQCgXMK5P9SKKbvB7xAZ
	qkJZpWApNtQtWxYbd//6NaPYNWpYTlfLO5i6ojGIarznq7tz6obS/zPL3gciI9QLWWmx/emi5q6
	jWIjiXQMVbM5eOYtu4hfwW9sSUjBxMYx3P5l2x+DNgH5nMmok/ArZm3xtPvTgDUTNGDl5BeUZ6n
	96aVbVXvaZx1/OiKI1XmGPPZ7Z/LV3B9ZeIfFIk4vSFg==
X-Received: by 2002:a05:7300:e9d9:10b0:386:ce20:31c6 with SMTP id 5a478bee46e88-386ce20334emr3410906eec.29.1795619318324;
        Wed, 25 Nov 2026 07:08:38 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm65846957eec.10.2026.11.25.07.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:08:37 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.18.y] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Wed, 25 Nov 2026 20:38:30 +0530
Message-ID: <20261125150833.340764-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112527-recast-imitation-3111@gregkh>
References: <2026112527-recast-imitation-3111@gregkh>
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

commit d252425c1533bfacd5940faa3371af82196bff5b upstream.

GNRL_CTRL1/2 hold the scan period in units of 8192 / FOSC, but
sx9360_set_samp_freq() computes freq * 8192 / FOSC and mis-scales val2,
which is in micro units. Any integer frequency then programs a period
of 0, and fractional parts above ~0.26 Hz overflow the int, writing
0x10 to GNRL_CTRL1 outside the SCANPERIOD field.

Compute FOSC / (freq * 8192), rounded to the closest value, and reject
frequencies outside the 1..2047 period range.

The available range doesn't match the limits in the comments next to it
either: 4 MHz / 8192 is 488.28125 Hz, not 448.28125 Hz,
4 MHz / (8192 * 2047) is 0.238535 Hz, and (max - min) / 2047 is
0.238419 Hz. Use those values.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ Context: <linux/mod_devicetable.h> is still included here and the ID
tables carry driver data. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 4448988d4e7e..7bb54eb7b1c8 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -14,11 +14,13 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 
@@ -44,6 +46,7 @@
 #define SX9360_REG_GNRL_CTRL1_SCANPERIOD_MASK GENMASK(2, 0)
 #define SX9360_REG_GNRL_CTRL2		0x12
 #define SX9360_REG_GNRL_CTRL2_PERIOD_102MS	0x32
+#define SX9360_REG_GNRL_SCANPERIOD_MAX		GENMASK(10, 0)
 #define SX9360_REG_GNRL_REG_2_PERIOD_MS(_r)	\
 	(((_r) * 8192) / (SX9360_FOSC_HZ / 1000))
 #define SX9360_REG_GNRL_FREQ_2_REG(_f)  (((_f) * 8192) / SX9360_FOSC_HZ)
@@ -183,9 +186,9 @@ static const struct {
 	int val;
 	int val2;
 } sx9360_samp_freq_interval[] = {
-	{ 0, 281250 },  /* 4MHz / (8192 * 2047) */
-	{ 0, 281250 },
-	{ 448, 281250 },  /* 4MHz / 8192 */
+	{ 0, 238535 },  /* 4MHz / (8192 * 2047) */
+	{ 0, 238419 },
+	{ 488, 281250 },  /* 4MHz / 8192 */
 };
 
 static const struct regmap_range sx9360_writable_reg_ranges[] = {
@@ -384,11 +387,25 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
 static int sx9360_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int reg;
+	unsigned int period_ticks;
+	u64 freq_uHz;
 	__be16 buf;
 
-	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
-	buf = cpu_to_be16(reg);
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	freq_uHz = (u64)val * MICROHZ_PER_HZ + val2;
+	if (!freq_uHz)
+		return -EINVAL;
+
+	/* The register holds the scan period in ticks of 8192 FOSC cycles. */
+	period_ticks = DIV64_U64_ROUND_CLOSEST((u64)SX9360_FOSC_HZ * MICROHZ_PER_HZ,
+					       freq_uHz * 8192);
+	if (!period_ticks || period_ticks > SX9360_REG_GNRL_SCANPERIOD_MAX)
+		return -EINVAL;
+
+	buf = cpu_to_be16(period_ticks);
+
 	guard(mutex)(&data->mutex);
 
 	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
-- 
2.53.0

