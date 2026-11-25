Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619491;
	b=fiP+1gWY19UIobCVDp82fZmZ19gHrGUZeFu2Fgg29Mmd0YelKIK9QHnYDp7v+wz1Cbf0
	 Ci5T0dvnj7IdM+PBL8x7Wqq28PuGSCCg2x+ORh0JR8DJWKj48yD2VDNmzos6jxNm173kW
	 Pl6ZNIQ+AjnTVishtp+wqI0bCodd+N7y+HK8nYJq1dTPPPk8Dp8eontvi0KoI0H129P2d
	 nLJSBdu+CVvFXfsUqmrDe3Nb19ZmFNw5M7f58elvNGd051jniiPsn6ElXs9wcjww+ZM+T
	 PTZI5R7t9n2JwiecSeSFxlXFN25qPOxujWEbMrTO1Kk1HgjA9Ggr42pp9n9zoC67G7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S4Gr1BpsBaaOTn0gg/ejDHt6kh8RADBHEWTGJKbPPbg=;
	b=kj9BtvVBVv7DqgZHv/dforx7Dndmraeh631yazdTZuPRmL7s7hPZ+FmN57shrKp9SOgM
	 FwR8utDKwZ7Gs2wz69MSE648RJFDRLY2NGGNQhW9JT5FqYmmqFMb7PpBaxWpNU6Hdg9yB
	 33Qzg32hHC4yhWx2pDrb4goAlZTLGwUAxSsfiqQXg7c5gxuYI/4/jd7SSZLc5zl2RUp14
	 YxQ3zFUWAPK8kYEodKITyIpQ6lrEe2W1UgRHc6RDxMSsWAybOpen6sa4XZKEWCHz35CCA
	 SCHYtSBeAhck4lF2pTctq72ZMJH6Oj1N/piZiwmQj3igU+bBUwseT/NMDPWlnwL0GKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nah4Izgq;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82036606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82036606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nah4Izgq
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b24f4b15c4so2526393c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619491; x=1796224291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4Gr1BpsBaaOTn0gg/ejDHt6kh8RADBHEWTGJKbPPbg=;
        b=nah4IzgqPqRNde0D6SQETf/UVH/dYIO+kjK+D/ZxPOHUllMl5YqkARaJn4/23L6Vxd
         fWjsVy4at7sIIToMSBPT96zY+pFDJVTp3P0lVrdWHqPX4LDup8YVO8GV44qqim4jdGCi
         eIL0srxbmsICbojJoqZYpY79rGB8FOQhxrP/bqOhGhQpuTxa/RbRv7/aFg78YHAPNedd
         AcNl8xwx7iVcYgiEOCVt3Kg0obqNUF2saixP3TcvelkTeaOMvbxEtDS6eKI4AU+zYt7U
         pn6IRauhgl4fVzr59eHIIYcMjJjrFvkcaCNUDaji/0WLHElm6CJ0DjaUZF8dzloymUNP
         K3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619491; x=1796224291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4Gr1BpsBaaOTn0gg/ejDHt6kh8RADBHEWTGJKbPPbg=;
        b=V1w31kTA55zfTyxPsFOYKDkRGB1BZiJJUrxUf7nLAyd1TABFr6DxDg1ACS7WZxdGJt
         Vp4G4jpb5kHCH8O18V9QNlKhQV4jAicUigDP/FnytgxewJ2XOdwgJgVLSv+dJ/rO0Y1L
         i6XeNXYPgKiPPdNn0v+qHl2TdEdQ/dFH6Ef/I1IiEmxR746PcWDujJ/JSw5PCWLMxzw2
         dtYnIFyAmjg9aA+mQmKXRrQi8022E9S4CmUk5VviMH4a28zNxkKVUiUfe6H3KgkgmDVY
         atvmHoZJvMohKPcaJhpQMlH26jlo9dSeSq88HCA7401gJgYapZKJTRLM54uGK+QTzkc6
         Uy1w==
X-Gm-Message-State: APuU4Z/otyqIANqSrDAN36TdcS6b06ljckmze3gPmzSKz8BVxwqIwGFi
	AmaU2j9Zw7Id2mWeekPzc01++5ZGAGfSlt40WwJ9PRR3wIH71W4KdoPeU8t6g35U
X-Gm-Gg: AZFdTZcN7Ij0V1rdFxi42LqO/1VtV/rjkqAGXkWxwzdEPuCBOV+mnBagZkY7cUfWzcT
	9geYssgMjtJfTF6eaOValauehlyje3fWXKXZoFNRyLpspnzcFdSyfhe3N3UTqFKpQDklJM2Ia9K
	z+lu325vSXF+SELoddtviQHIl5GoRDD4HD3gTFKa3kzC/xi3UW6cCcHBC4ArAW1Aas+vQDSz5rQ
	sbMyKdn0y84jDN46afG7RaXRpZYGij9lEJXxW3Ej5Q6U5ejKW3pTpsh6oVfjtxwlZi+veCeJvt8
	YWv8/4xp+MDqLHmYOYLtTxUP3cSnnOCuHqU50+tqk8dFLkWe800R3JcimfV7sI6oSgRXQaQH2Y3
	jVXC8fun3yGloAWkNVFUeYgOaaiPUaVZl76lB9p4tliKEBV3GVv9EngpA4maFXVLg9d+isyI21j
	aWQVSRIDnJvQ2HHJtjizBd6jivHrXoTFEzooYLaB/W0V0O0p5EiPjlz2oCKJDAT9qyMCwE6tP65
	WbO4IpKj3VhJ5ahxV89He5ZQ+r+OqNf8vcTIfLyS5p3lKSSzWexXxcq0IH5gRx08YHIxB5yA/y0
	E8DGNRdA2W5V7KPFuf1zcMZuUSE8/WVBGDOHWbUXxpmx/wPczrLATOqjUzf4ztCpjsnJub0vzGD
	+xDbKtk6l5Q0SL/gPutxtYLxElRhjOXR2FKf4z/srbEjHvN267y9DYbvNRbdfTuJg+0IeV/Co5e
	Xa2HcH3DNrnBHkRSiwbuv5BK+c/fGkJrH4+Euzj6/FKw==
X-Received: by 2002:a05:701b:428a:20b0:1ad:1574:aa9d with SMTP id a92af1059eb24-1b5566e0ecemr18379748c88.0.1795619490100;
        Wed, 25 Nov 2026 07:11:30 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm51061215c88.7.2026.11.25.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:11:29 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.18.y] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Wed, 25 Nov 2026 20:41:23 +0530
Message-ID: <20261125151125.341506-1-kapoorarnav43@gmail.com>
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

