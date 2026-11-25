Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619236;
	b=2LXxZ8vePabI94uDyltvHuA0fPod2fQtVZZS5q7CZfEoKV3a4ikWDyxNu5MN4h4jnYBt
	 v1KNePBbZMXTERs9E9o3GN7niLbmaZLzRH8sP3+hJj2QFGs1eNt9YDGC8nlZ+4LRTl6jt
	 lKgRKd+D0MLQgxrDQJyCx1Voxyd+5HFWL+XSVq1HXYZubyrxJWZZKDr/JnmMnExTsp97C
	 UAru0vElso7BA2Zf8mCH5KJaZmMWJ3GsDwfoE9cegolcCxpPmYr2owGaCtxDmkAvlcSh+
	 9zvXx9NBaa8zMwLWaktO92z7wY+1QJow1BfKP4DytVvVjurd1uejA7pxaH+jbjwyCnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/xtCutK94zRhLvt0oPROX9eak/mzyWYLy8JBOY8nbNI=;
	b=v128fnURyxNpINxRG/i4+TKXV/nhl5sKb3E3joQ3kYDaFEz0kRgKpU+4/eWYLP0bgfmr
	 wm5u+kj3cUNesIgTHCIILewuaDBXoTVEve+pAphyDvpghbE2Gt/KRkuikzBwJwPwBE9ch
	 3RQeJs2dW1gK2x20MNUcTyAxdTkahg+uFjd4gEF/6p82zo8IhGmXNxqg2l1hsWoGYF1ap
	 awDUxs81zXT6EspLHv9MP+ItmlcEl6kkt7WIYuBXNpnq806MHNqH0+NpqyNAii8uGf5xM
	 MtEd0IXeIHbXtNMRCWWqh6YHrBVoaJjK0/xBCf2Mobjot6h3+x5mtA0vz7WPvYvYNkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0m1+JES;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B639606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B639606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0m1+JES
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1ae58d17cd9so6332930c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619235; x=1796224035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xtCutK94zRhLvt0oPROX9eak/mzyWYLy8JBOY8nbNI=;
        b=C0m1+JESq5aiLfiLdCQvj+Y/j4hCM5eDd6an/7FXSi5abr5KpBOhajLdMjlZ61iD7O
         lvwXGmAXRlQxghAan1y/2V5boZJaycmDjS7JNu0E3/qQY6dhWmhxrVBu8aGFfTGc1BXl
         7KD7o+Tsiieu+eIT8Kw6dscDWWejD5XpmFAseJQZLBnyIFQzw2RZoC7rRiiu36aX4INo
         AqHaS5BHS6qLZ5O+Ii1IXw3Vlxd5XsCjApdL3xnbB7TlznIWZK5HCN1Xb+29Gb+F7yZn
         TSUnL7iXzvCJX6q76/pf1M65cUP4gv2Iw0RpVGEH1/tFEvwMNUQon94xAhRbnB/ztUJF
         /mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619235; x=1796224035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/xtCutK94zRhLvt0oPROX9eak/mzyWYLy8JBOY8nbNI=;
        b=Eh93u2tGI0X/nkbiVHi+rZuAj2cd6YoukskG8Uy+yKTXFwp+ibCE46hyzqz/jCT5Vi
         5y6OxNOhWJsLkkWluHL1qYT0xMhAzjzWprzfxDzxE10+jE2UeQ9qJSaCKqKufhB0BUyN
         YFupGf4PXq7WlysR/Ugt0Zz90KnmokNJ9xfXBF7Nj7jWitFXpqUjgdFFJpUM5uHd/rcg
         9y1ipnFwi6zVcXbsdhbAljuGxKVa2dYqda4VVggXAubiNBXQM1XBIAScjIYCsoZvg3/C
         0+8sQhw/y8Ld7hW5vSWN1jRao0UriTKAH5sKDbdmdyAkdl1RuBQGCc6rYjvQxiWLnI5i
         ZkDQ==
X-Gm-Message-State: APuU4Z9xZgQSGFVhYlAbPr/4AfwPwPO+1nLokEsUSgxctYMIeyfbpodb
	Yqkv0jvRZB55h29G3HPZwUoopTAA9UM5OMBKRYOKOJHEnMlzMh+ykjvTkT1FhDU7
X-Gm-Gg: AZFdTZegqqnH9/1Hk/OSJL0Zla2RBMk2SusVyoy2vvuZIFErKFUOOZjOdZwajqc8LVj
	m3kZ6k1jgz11ypmEHf3Ucq8CmVju7yLqor7HyyzlU5fyXUqgau6DZpCjQ9N2g7xtimF1rk6RsUX
	rt5cuoFVlT6/AmoKEDs9FJ14jz3RdTpUN0zJORSmdcaiWWbkEB3XYmNc6hVSvpOnwpsyEC9NO7A
	c8iDoMLqHJDSDFwOO64vVOJn1b1oJnSqKo4z0NOs91l3cju1H/PzapxNEj6YWmfFTzZx5N+4p23
	nJCPCUtgCcGj/AaQYRMzs2I9mi7PQO65+HeNXpzbFqQhsWHeq0IuQE666fizgCXvZmrrme5n5sC
	JY5MEBblsJSXU/Kr2bQJK6aNPorhqx38N/PHfcKfGfmNJbwRJMQBz/K+uc2M09XGRbmNPNhyQxg
	YyiCr/exJlSFyE6FngVci4MZeUwunU58OeFdLgOog04me+cStcMMxtxrb/VAUg/8YqV+tD0KCS6
	3ZJvroLyrHlt1y2T8kfyBXEDjPjO/LsFjt+9CHW5Lomat/0OMfSgr/HFUgZRtVpADsKMjJytI6M
	zYu4PO3IjmOiX+PjU4psAKSB6lfgJCFlBicM9jdpLxTskxxa6JzqD2NSEO1Dn4o4mqPlJOi2qv7
	4tqVSI99W0dWaU+cEDfNoHm4wleurKTFO5ejcG15J6c8axWqZ9lGdHs2USa00lRX8+OXMUzPBDb
	s/2HpGE2nVz1DLy5yyUR8bLWxiqukz175BcnhsnzTYwObVAbGW
X-Received: by 2002:a05:7022:3a89:b0:1b2:558a:d777 with SMTP id a92af1059eb24-1b5567b459emr18554023c88.2.1795619234894;
        Wed, 25 Nov 2026 07:07:14 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm64201833c88.14.2026.11.25.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:07:14 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.12.y] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Wed, 25 Nov 2026 20:37:06 +0530
Message-ID: <20261125150709.340430-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112528-drastic-whiny-c11c@gregkh>
References: <2026112528-drastic-whiny-c11c@gregkh>
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
[ Context: <linux/acpi.h> and <linux/mod_devicetable.h> are still
included here. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2b90bf45a201..10ab7aa352f9 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -15,11 +15,13 @@
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
 
@@ -45,6 +47,7 @@
 #define SX9360_REG_GNRL_CTRL1_SCANPERIOD_MASK GENMASK(2, 0)
 #define SX9360_REG_GNRL_CTRL2		0x12
 #define SX9360_REG_GNRL_CTRL2_PERIOD_102MS	0x32
+#define SX9360_REG_GNRL_SCANPERIOD_MAX		GENMASK(10, 0)
 #define SX9360_REG_GNRL_REG_2_PERIOD_MS(_r)	\
 	(((_r) * 8192) / (SX9360_FOSC_HZ / 1000))
 #define SX9360_REG_GNRL_FREQ_2_REG(_f)  (((_f) * 8192) / SX9360_FOSC_HZ)
@@ -184,9 +187,9 @@ static const struct {
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
@@ -378,11 +381,25 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
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

