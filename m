Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619616;
	b=WfL/tV7W3wHGg2uFzX46Zj3KW4ZJxMKV+JQ3kHuHLe2dRCsGHdmQ6IwKZPy+O6BS+9km
	 J7Es5It33mg/CzAeT1rvBda6XVju61EaR9lNgcII2YqjZ+8DDa6GDQoIav6G3LNbHOLvn
	 ak5hAxSnwV0keIUY9IS4TtP3aP3CwVIdDuQ9q10AwOB5OlLty7Z+G9NM9/re1xlA5YvGA
	 9dp8Ajh+hL9NB1F7q34u6MAGa919Q6RRdLLBMWkB+Y8wQx3T+wv8UdLHoP0aAiC8geqNP
	 AGtfSq/wuvivpLR6BYsm8f36mKuuvTkAAqCBV7tn92OabG3IneS3MgdwDSSbMQEAqew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xGFOqQDypXW4Op4pVpiGIW3/6HDp2wc/vSFDiWUZpl0=;
	b=wfs3Im6Zix0NkqlMsPRQML1Ed2hwW1gr6Xcx0yRgCq+EeJjntnLzsp/bqIX546iS2HB5
	 9/4zAv/FwpA652uR7z8tsoYvPeKfd0IIIvUjtPBAGhbv609jblCt4G/QMv6HGGkZ3hXn9
	 vsxPeeBY5RwvCpPjqR7OdDct2Af6VHsfs6ZZ9G1hxSM4XIDRYJxl726e8lV2q/ZbXxGy1
	 CL8/OW5MeakrQyApjHK/124MJdhPDW41Bie3ATHQCyx+Uunres55erAPMFgUDc3M0sHYJ
	 07XfRtxcBIWFz7UFxVWHbce8FqhBP/YHmdVhrgIypr195nFjonxHyrBWf8VmMvkUvYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQA2X7iJ;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F6606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E3F6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQA2X7iJ
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5363c8de563so62330351cf.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619615; x=1796224415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGFOqQDypXW4Op4pVpiGIW3/6HDp2wc/vSFDiWUZpl0=;
        b=bQA2X7iJ/8dTITa6WYmjpxmcvtc2qSZL6gyA0YWqyBQyeL9JFsQ6A/ecP04enxZUcm
         AeFNA27FrznvVfTaYCQbGBcQZQqLCqtaxZhzoftnbQ/h768RluoX/xnq2ONcneao9E9p
         P9ye+56HjUgYcRt6cTezr/CHc7HLfIxP+3cZbICbyvJK6DUaX9hBy5bXVIlUHHz4qnet
         eY1Vm4yTxf7F3GuEaMDLYw/fv4FPzWPNVPm+xquroiK+gMMraRMJWGibhfPUoZ72eBf2
         XX9KCR2tlHyHIZMsESK6MH1fFTVcxkghjuW2I+DgvwCj9vDprpKLeRpyW/2MQw92Qeep
         YVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619615; x=1796224415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGFOqQDypXW4Op4pVpiGIW3/6HDp2wc/vSFDiWUZpl0=;
        b=otAO6sEhDynUwB3HLtoDCtrRsyYNu56YcAntJEqUK5V2TWRYRaqGz7Jt0BLxMChVFo
         lkNOLM15Y1mimGA4B1Sg8MwyfhJwYY4zsm9DKSQ6v0p9Ii/gkYSIAHoi3I362BgoLGLV
         FjCj98Sixdqce7QtgBuvIUqcZMkFGzJt6EEs+kNlH8p+UKf8VwDZlA25EJICD3KjIH8u
         N02jTZzWL9MIUH6K5O9FbFd2vZKcLKhoKVymPqJPIk22gney59L58zeSiueM2go+1EoG
         /FmPfOl+YNq2/nM4/xxn7YX9wyzvgBNpUu2HPUAacBWHHlcaalaMdbcZ2SVzjVvbbxCh
         6/OQ==
X-Gm-Message-State: APuU4Z9E1peB8PzazwzFDMjWgsKjwilLOL0+VFsm8Rzijf9ogFhV6nhu
	5hRXJa2NxZ6v/5yrI7LGEP461Srpli5dnbh3OzyMDSafb9dlJzuI+pne/VkBo+za
X-Gm-Gg: AZFdTZfckP/4O90OPdKjoZ9zeE8w8DS9SYwPzawdvGd7m22g0v4/xJiB7fITM1zKGTJ
	bvzt/QVK67XKpsd2+ymBA5TfzHLOB4LB+/eFvXnP8cYKyPvLtIP9A61JYLvJPh4Z35F3wn49M3q
	RALr/V2vQ7R19aCLY9swjtNE09iVMqpFJX3muVgNstJCcobjHf2FA32b73TeX1fSwWU3TdgZB2M
	Jrdh/MfCJO1hl9rEX+BuotHRGaqy/dBjZ2VO+w8FiE+9VyPddgQy63SEgRyxA6FPBmo8I3lgMtV
	rW5AkQoioSwQKAzkWorEvQs+nojGJp5mYW3Ys45BclCRKxmAk04qdJm7CGvismsqeOyomVW4QAf
	lEBG4J/dCpzaX07JacfFvQRhHSPSoc4ajHu65q0ibmwhjWsbZ7eykdhf8U1/B+ZPIWHzp4dkpHQ
	r3SNmvQbPBTptD7AHRPsDNMaC4EjGc/y6yDfgnRJSRDU58/2AQlGscps+AhlZLlmwPueYuIMZiZ
	zckH10cajjb3jAWhodYRG4A0KnXQbndfbiYcRP5dq6fdr08XzL+o6YGZ4gwqmLBrlKJCQnv52O1
	94ta+P8fQTFQrQheHo+JY5HpinJo1NJ6nWZRqPYuWOxXiVVL+1z9tuwYDPsRojm3e70yb9B+Tnq
	UJcBCQ6EaLfXKG8K8AGpT1MuaOd0C2W/Km6kHrlXwpj6nf10Nfx1yjTTFfxfmlNdit0CDYaO1FY
	oFxCr9YtjWFFZuEwrhIjUYPt7JyDdCvYnhw166SMGkceE=
X-Received: by 2002:a05:622a:1a89:b0:536:8bb3:ee45 with SMTP id d75a77b69052e-55d76a38dadmr329174351cf.30.1795619614963;
        Wed, 25 Nov 2026 07:13:34 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7887bec2sm158560251cf.22.2026.11.25.07.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:13:34 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.1.y] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Wed, 25 Nov 2026 20:43:28 +0530
Message-ID: <20261125151329.341991-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112530-uncommon-jaundice-fa9d@gregkh>
References: <2026112530-uncommon-jaundice-fa9d@gregkh>
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
[ sx9360_set_samp_freq() still uses mutex_lock()/mutex_unlock() here,
not guard(); keep that and add the new checks before taking the lock. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 7fa2213d23ba..91b184b8c6ba 100644
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
@@ -387,11 +390,26 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
 static int sx9360_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int ret, reg;
+	unsigned int period_ticks;
+	u64 freq_uHz;
 	__be16 buf;
+	int ret;
+
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
 
-	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
-	buf = cpu_to_be16(reg);
 	mutex_lock(&data->mutex);
 
 	ret = regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
-- 
2.53.0

