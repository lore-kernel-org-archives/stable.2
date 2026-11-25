Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619835;
	b=pbo8WW/tJvn1ChL0p7XmP89DH/r7YfocZaV+AGI7JmH0pIzfzXIFHeNg/8U9wyKrsBjA
	 Cpm5yS6Ykz5HhLeLr0a7YzU54d2U9qnJRYobbIDxY3S7WA4m3Qx8zAM1AjVkCy4fUP1s2
	 f91KfUeDPFwMKQi1WfUNFWXaQP8tiwnNWgoq9jo1BUyUVKDa4Q/BjiXg6LnIU5821uqWK
	 R1E8sKK/7zRrRMaj4tX+0ud76BXNddrnb5oOu7dp7GF+3pz4Hl3XnLR5xcjkzfbazR6iQ
	 SiI3XwVwea21mQD8UFt9FwQzSLHZwui6PT039dzciI9KD6RnKemmV4Deq4dtLmtO+Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
	b=baOZDMY+Uz/U97RyBZ9aicKd9Z++IOPnNbDpzSdZR6jd0/87WfaNM6qEpHUSBtYAZ6uG
	 Jt/JwFbS2JErZ2FhirHp1Rk34JYkNUZYqSfHSBYIimAYuqYDeb4EJGdXsVtjyDUuIenkd
	 UuHPHSKHEv+h3ZaqAogY3mKsAvvUXXbC3/AXGvlXZszbtwsOFkSZeeo0jbieDDsC3cPsC
	 8jIGJZcyi5aCnSvoaKNROi/JkqjJU05BECi93shsqhhgegK2xxCXx8X/JzOmYofglJ5y1
	 1+mI3aAIOgy6JJbM6fHPvW7xsrylVQzPKcEsbhQoT4NbKoPKdnOXBgpzsTBLSn41TMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxRH3eop;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566E606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7566E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxRH3eop
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b4d6981c67so37944497b3.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619834; x=1796224634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
        b=oxRH3eop/1KkYUEoVtdwFSWxFtRIJ+fQdzPdGlW6sA2dR34XfihGCsh+rdWoBj8gWi
         ZxddU+5wb3n9ZN8UVYp520S+7PmyHMgLx+BFDKD7nJ8KL1OfWyH8LXm2ldc+dAEp6hv/
         ql416xaugvn0EQ3pLyxy8xJHzP/Yz4EESu0BdrWsmePJpKayHaf16EqYBOehCIO6n5t8
         qHI2LWiVsLfSt3h3jrt6LNDkblrNTJwcbkO1spiGD93riO/HEEtNALXUoxQhnyJxV2TC
         GMd1Ddr0DjWem7EF6yQGEMn2W0RbaWh8I2NyTpXGISBAhr8cP0qOMIWh2kQxpmEtozAQ
         AN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619834; x=1796224634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
        b=BV0UZP5n+BFrHZA/myIqnkxOUz1si8Xsc6t9ilnh3hqL1/9fdTw5zhIm/+VPQY6t15
         087qFr/5chi30JRu6k9f25YZ+G8pyxnO/1swPFBFDfvKEK15cOxEtUMYIC+n0Ltyj2gp
         XqBYHWZFOqIjFze0XHxVRYnHeu/iilVPogeIh9VTfNQ3eiVrW5u5RQjSNWpsYGWOd269
         hdA2X1j3/1WKYe/0GzBhtu3SmXeRTlvrk8WN3Tz2Dn3NuAr/BXF/jKH7+Ri12Opt5jaD
         5tjxxmMIfJL8VJGN7fCubsG6RVUCsC0WNT4zEuy8ArzaJFnLSfq+5z08nTy9z+Is00+Y
         mmqQ==
X-Gm-Message-State: APuU4Z/9SyDCMS/5LWpoWY35FRU3Q79LRDmO02KpjwwzZoVDA9MWSraS
	Vc/gYpVbDZgXOOXp7R3MnUBxUPtAWn2T1VmgQEbigFXJX8QN3rHNUAhRsT6a0zax
X-Gm-Gg: AZFdTZeyFMD53sM70qYnvllS5JQz2zyp6l7bTLTEZ5I/RuycWi4+n3tsMiS+AXjevme
	vJC9QtOLrKOHerU1VrYNRQSxaBkyDzllueJQ6q8+xZfOgAQjBo20wC800dKr1vH4ZGYEISRu5Bs
	dF+M3cJqawQxd49GHpMcfqMe3EjCkfZeGQ6w/0YQIs97OHO5Y1yQxKxahvqbmKesK90hOOTBXvp
	wvsCGy+RjSIdJo/tGn0tUfEl9mOHBmk/LiONZZ77hrAFWznX37rP3FEs3D3/1+PrUF/z5hYygX2
	gJecHrODnVAq0DAluRRcq+UqZV4zu+XfBCOeYvrZUUzYSpwXbVlWcFvylz2XadTzejXmUMvl1qE
	xeCgGcJhX+jxgC8jUUjp0E4GTVxy+NnruMleJZtS2cw9CnOU0LsBY9AtIZrV/g0nYYRU5NbQaLS
	IJjaftwFOJ5cVwqD9gNc9Kp2/H9/2wO+pLo9IudmWL8J07F2EHoEPJQjdLxH1mVIxM4x5DBptM+
	BlCunuctqoLi5mQmqUzaUS1Pwmd5M+KQDuEnrRBOhYpqfHFEO77o8HCrBrPYtQHn0GEOpAJ+2rz
	86rDmDgVdtiJCVg1jaoFwC06yVEMFAKx24J6xczoEPe+9rDg6+rwVKgS+9ezVt4gwx6FijMLfRe
	3Kbq1QZyLhnDPR+QtdUqgFQV27ISuh89RSgfTIuxN/cf44S1w8NfpZYPujU4UKlMWu39psZXY1c
	/WhcLz8LO085Ffe6Vi2QHsH6Vkq3wWbQjj6upsurDlfw==
X-Received: by 2002:a05:690c:9a0e:b0:8b3:5121:3d57 with SMTP id 00721157ae682-8b5205106f1mr79149477b3.63.1795619834288;
        Wed, 25 Nov 2026 07:17:14 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202dd36dsm72256687b3.26.2026.11.25.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:17:13 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.6.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:47:06 +0530
Message-ID: <20261125151707.342901-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-daylight-datebook-adf1@gregkh>
References: <2026112509-daylight-datebook-adf1@gregkh>
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

commit 043ececf147863fbd253687aa0b9edcac358a711 upstream.

do_div() divides a 64-bit dividend by a 32-bit divisor: the divisor is
stored in a uint32_t on all architectures. The driver passes 64-bit
divisors to it in several places, so they are silently truncated:

- scmi_iio_set_odr_val() divides by uHz, which exceeds 32 bits for
  sampling frequencies above ~4294 Hz.
- convert_ns_to_freq() divides by interval_ns, which exceeds 32 bits
  for update intervals of ~4.29 s and above. If its low 32 bits happen
  to be zero, this is a division by zero.
- scmi_iio_get_odr_val(), scmi_iio_convert_interval_to_ns(),
  scmi_iio_sensor_update_cb() and scmi_iio_get_raw_available() divide
  by int_pow(10, n), which returns u64 and exceeds 32 bits for n >= 10.
  The SCMI exponent fields allow values down to -16.

Truncation results in wrong sampling frequency, timestamp and
raw_available values being reported to userspace.

Use div64_u64() and div64_u64_rem(), which take a 64-bit divisor.

Fixes: f774117c96f9 ("iio/scmi: Adding support for IIO SCMI Based Sensors")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606040245.XfmRpBhA-lkp@intel.com/
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ Use NSEC_PER_SEC instead of HZ_PER_GHZ, which this tree's units.h
doesn't have (same value, and what the old code used). ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 0c2caf3570db..0e931398aa9a 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -14,6 +14,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/scmi_protocol.h>
@@ -71,8 +72,7 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 		tstamp_scale = sensor->sensor_info->tstamp_scale +
 			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
 		if (tstamp_scale < 0) {
-			do_div(time, int_pow(10, abs(tstamp_scale)));
-			time_ns = time;
+			time_ns = div64_u64(time, int_pow(10, abs(tstamp_scale)));
 		} else {
 			time_ns = time * int_pow(10, tstamp_scale);
 		}
@@ -163,7 +163,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
 	sec = int_pow(10, mult) * MICROHZ_PER_HZ;
-	do_div(sec, uHz);
+	sec = div64_u64(sec, uHz);
 	if (sec == 0) {
 		dev_err(&iio_dev->dev,
 			"Trying to set invalid sensor update value for sensor %s",
@@ -238,13 +238,10 @@ static int scmi_iio_read_avail(struct iio_dev *iio_dev,
 
 static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
 {
-	u64 rem, freq;
+	u64 rem;
 
-	freq = NSEC_PER_SEC;
-	rem = do_div(freq, interval_ns);
-	*hz = freq;
-	*uhz = rem * 1000000UL;
-	do_div(*uhz, interval_ns);
+	*hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
+	*uhz = div64_u64(rem * MICROHZ_PER_HZ, interval_ns);
 }
 
 static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
@@ -270,7 +267,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		sensor_update_interval = div64_u64(sensor_update_interval,
+						   sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
@@ -397,9 +395,9 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
 		 */
 		exponent = exponent - scale;
 		if (exponent < 0) {
-			rem = do_div(resolution,
-				     int_pow(10, abs(exponent))
-				     );
+			resolution = div64_u64_rem(resolution,
+						   int_pow(10, abs(exponent)),
+						   &rem);
 			len = sysfs_emit(buf,
 					"[%lld %llu.%llu %lld]\n", min_range,
 					resolution, rem, max_range);
@@ -504,7 +502,8 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
 	mult = SCMI_SENS_INTVL_GET_EXP(val);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		sensor_update_interval = div64_u64(sensor_update_interval,
+						   sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
-- 
2.53.0

