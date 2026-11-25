Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619635;
	b=bjiw68gnLlYDft2Sm/dVITEwfV3NH4XpKntHQiejEM1jPZrSJj4V2cvwN0R6fzvRDJy6
	 uwVOce8I6XY+QjKaoxD+pBvKfxJGKqU2dotf3eXG84EUU3h5hC7ZVn8nTjd69YNMtPnJP
	 FbgbrOTZIcLshEvaMEgMv/8HpMhkr4KRrdXKDYthzC48BaIv3Lpnvn7JcAFgrEUYRDYg1
	 4SoE7mo0rM3CDZnTFYNPTL5KgtliRo8I4svwWKhYUFhvkeQum2u1S6lyQFzr/e2LlGN6G
	 Zq30Xl9gASbcgWTDkgjei3uVb2uWXcMKBSEK7UD9c7/TIbJlz4ayYSwQgqB5NyQX12Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rJDvbLGU5y2moegEFtErxclKO9wClpc5tbMew8fM/qg=;
	b=WiT6zvlmPMqmn269AtG4fNDZyUb/Ht/zbxj207vSbEMxYPNft/OsEknoiutilMZyhmam
	 D0Ucx1nUzGNXWG6ZIJcy5GhFwQugIDKO4h2i9VB2dqol4k1DA9ultqJ0axKS0aAORXu8g
	 Cy75MoHDiZ9v2qZCoAhzxwFp7zLQKlJO9hIYVM7Qjd/Zrj7eoQYAULjMWOtkG1c146/Tr
	 Lcf/8JrKYmASzKPbpudjVW+WNkubQWT0a50HVaULGbaueowRtOqcjUZ9t+9TggJzCrG1C
	 O3kiMcDNb2bsNm08JfvYH4uMVx+NbgQ9cW00hP+D4vPUL4ZNDf21BJ/YopNHiD3z95Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=msKTnP2i;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A85606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39A85606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=msKTnP2i
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9495e8ae23aso493706985a.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619634; x=1796224434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJDvbLGU5y2moegEFtErxclKO9wClpc5tbMew8fM/qg=;
        b=msKTnP2iRvdZgzzIRFYu/cx0X1dAn6GA5bC9TJORAg7DyurJpNMcve5aFN2DooufPH
         7P9X/t3fLGlTpKV3FosngghvYgOGZ84fZvgRGcTgilKu5b+9/bZCPGFsZOv38HxN/3HK
         vG02HHx7rVm86dgbpBOKD1VPenGaS8xBDq4U3E531cnNwth/+WntW5sOh42J44IRqYye
         JaVOZkBiTvH4VQcw4FLN+w2DgSSb/t2VBw6GqThz54PxHCEdAS/oij/CSLy6ya0+v8VP
         /ghzd4IwJgRKlVFg860OMEoLMTkxtvKPYWDGA2VlLyVY17qW+7aitvSKoXUJn/88xeMI
         eekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619634; x=1796224434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJDvbLGU5y2moegEFtErxclKO9wClpc5tbMew8fM/qg=;
        b=DzWulYsAQXKE1x9a8JR2uvpHFkLYY0eOOfz/mVJJ+Eh0T+35u2lSo/WXma3Uy/xgx4
         S6rTDu9OLgTWJ1IFs3ZhvLD7ua4gcQc9uicOlUhgMfn4cgt/DrygfNBcTFztcFFX/fx1
         iT79o0E2WToIpbzAmIJ0Q5MvPffOs/xYnnNkH2GBCzscgBw3anrOm2G20/gyaNHLRjf3
         jUAsNYECSOtZGnT98tqt0R1e1FdkJ03oaOu3h2U4TgtFoQ8Iv7Graeha/Kvm19i0EzZx
         wQY0rqWZMZhoxaBen6oNn0yarxx7OIYMINY0pICeLMftU79aITE6wED+dBKzvLK7K965
         yCgg==
X-Gm-Message-State: APuU4Z8qp5mNypLpP2lR0L+adFZgRJ4JHlo5y539lpsGEaJ9r+aZYsNv
	FdNoKQ69dHsQqNpP/PuArsO5k0fpEONMukp/dIMvT8HXJoHGWWvi/3RFhj4y14xw
X-Gm-Gg: AZFdTZfjNK5TV6rV7k6mxVGWQCwbt/qO2Rkk6NFyaQ41M8a8/Kq3X6LCUqdMfATsJVG
	/iXUphrnx4Rzb/fHA3BVnIYYlv3JIIQwlYEBEUMHfyjU44wZEZkVr7xDHhPhHancO6G0q2/3/ni
	yW2QY+clvqI/afTPF2sC4PNo2FRBk0C20ibM5IL5hTDmbxr+nYBGWvTcCOhSYAe5mlAsgzWlWa3
	JFuxCjG/0aCrF/y3XdqVpE/EqawEZ5qJGNNh7Dvzj8aTfAh/YpmVeI4PpWDbjykFZlqIEQuo8Oa
	XhoS0wmsLcmw4tTacISBfQSUoLsgbqcocvbgG/XTQx/7sRCApqF78k+XLNj9r9wT+sm6zoY6zBM
	njr8CWnFNkSaE172KaErrII+scq7TrPLs92tz9hPhalA0ZMofJUkBWzAOIOv1OKsqk+cCYQ8us8
	K4Yy6PqM2ixITZtV7pxrUHky9LbGcQnX4p/DQ8mVSEjo4a0w5Zukjy8J1zOQLUBRKfBr1cc9ZTN
	NyqPzDo/7cplA0GvbfBLqdkgCyftK05NuVGYO4WXRk5t09Gw14xaqzCIeVT+ravBnPE+Wa6yFhB
	2e2IW4XfYTJr828Ann6/X8HuXkvBcMyH42C3yuQr/Jz5n7zx1+HLUTDIfLd41nRsh1vnLESY3fM
	69//1RB0c8o8wQJRGunWzlXVamlXj6EIH16KcfHygOrmajl3R6vYQg/vFbAjgp15Rlrh22FH8hR
	37bvejJfTB7yR8nFEZXCyBCo6vAD/6/ojtdasCPWIBcQ==
X-Received: by 2002:a05:620a:4443:b0:949:6193:acc5 with SMTP id af79cd13be357-949bac79da8mr3277275185a.74.1795619633959;
        Wed, 25 Nov 2026 07:13:53 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a09477acfsm118556785a.32.2026.11.25.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:13:53 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.6.y] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Wed, 25 Nov 2026 20:43:46 +0530
Message-ID: <20261125151347.342048-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-defeat-example-b448@gregkh>
References: <2026112529-defeat-example-b448@gregkh>
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
index 2c4e14a4fe9f..55031cec7270 100644
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

