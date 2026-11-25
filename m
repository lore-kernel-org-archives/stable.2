Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619449;
	b=t0FYGTh5WFQMGR9zPqDVAXT+1fX8hHfwcHWwcymUTg5le3bpuqOYTHPT33b8uswUTUPT
	 5x4TnwNf9b1JioIUuVigS3Gm2Sk0gloCQuXXvoRn2R5oYdBtCn0MpGRepS2bQ2dDeZxyA
	 TnJ7P/tI9eEc/nmC7WS7xL0Ri5ffATSxZUWme8MpZ2Bqtj7nB9GBrGQtHlMTkk4717Cy2
	 ajcIZXe/tuDqXCCf3tDmWNYFi6tvT2KIWEyH1Rmyz2Tk+w4ioW5j/ElGLO32uZTnmJ8cm
	 ah/MpvbO6a+4klUkPNNaXHsAuPeLra7QKG/OOx1GGIo8EL2CC44XnTyCTqnHb8kQCVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hinY9idTFGPg7JyaqW57B0jUrAxNuZWzw1QcM40xXDM=;
	b=T8/eVXfHt57O8aB3usgenuHzcY9pDv1pdW0IYAMcYGpgzTt9T5duoEkRqwim4nLGCata
	 rwN3dUCz9j4Dm8x5mpzrS6jO7WvcjEdUh276Hizuw8ebw+iX6GFddNSNt9KH8LmDtPjNd
	 oybKPK7Ch55tWb2jAYvBMENU8QpYnPD3UHw/wWsB47flPEYSmv1gUys5u4PcsUHrrBgth
	 +6tu74JJfrDU4hk6CmiKnrwOmcJThg2cVWThtJzj48Nd0p8tYNZk2tYp5De0DAeT7Nv53
	 aC/2LVFm0CDnwuR9zz7FY1X86Z+Gy93j9FjS2BnQJ3sG/imrATvZ0oimOI35ac85DJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIJrqEgh;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D5606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB2D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIJrqEgh
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso2354857b3a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619448; x=1796224248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hinY9idTFGPg7JyaqW57B0jUrAxNuZWzw1QcM40xXDM=;
        b=IIJrqEgh/0LKGroC0iN8nB6op8tpReflceBA/YlqbgTsPQAz6m+6U0VszS6ynGZWBF
         ywrzJVclqUN9Rsbpj6rb+PZdDhkTN0R8VPHQ+d5EOh4tr368k1o3R1YmyGtK/rFouqGs
         JTdyuQIVDMw12pEUD20VB3RDIUNLg5Kdex89hcG7IqYLzwFR8mTHeJN/gEbdc4FUQ0E0
         43rGIqIaLMirNRTpKqPuThndijONof9/sHvBLSrcsLeodbrBj89TV5jn269iR2aDB1KL
         ttu9naf5ughq4tiWZxil3Y+5ucETJ/OJ8t0TPr2NVpG7npollKYJsNUumamWpAtKm9sT
         WTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619448; x=1796224248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hinY9idTFGPg7JyaqW57B0jUrAxNuZWzw1QcM40xXDM=;
        b=1LyozvLueZudNzpgiN0WOdh/gDmPIuX5XW1oaKFtLrC72UKsR4Vk7Ep3D3S0GKgxQm
         eAzVEN3VgbDAyaeO1UWVhsQ9S/vnGt/IsOESyBj21axTgGlnL7QuAg7CvbmkWKchsKpC
         dkQfBEhpgbaM0teMcUBP40yTz1D22sejvnUfgeZV0WJi2sV6g2nx9q0fR8+ZtkFkYObp
         DiJfTVet77J6HlO9dWCoHDzSqO817yjgj7vn7dqdNWY3REwOWOBbJbTwrA4SEH97HhEi
         ME9ifbnGtGg/0pDSN9o/lymo7/xHO8QW+bpFXaoTeNy7AdTnH8LRfgVRuxGE9MRJ49Th
         qimQ==
X-Gm-Message-State: APuU4Z8PHJiNgr1nOzIqk09aVQTjsuqAXEXnxgwq3Eky4cXr9PVoGxa8
	yQF228oglJqG4ZPwo7gjapwbzHHevF2vG2YXCHpO7ND8W+1eiV+rN2jZ2PdJO+Wr
X-Gm-Gg: AZFdTZfsXcChpz+PIVrHniqzfk00xXYI5yq1ish/ILwMV5jDJYar9IYq6OAeQySnZdf
	eBbSKy37pesemKuMgyTJcdFNb2tDPegoco4V2HdKrWGD3p35Er15xLvYQbVbI4ZhTFjIFtnfSBz
	kWAOicq7OYJju4hdPkL9mwbs1qXpZFJNqeTl/ABMGpS5A59++eFC3EEWcFEfBfdLteO7aW52gA0
	Ft60nIBXlFtgyEiZk98ziUoYcMWuwsOT18H2rqkTODHfe2LsDHqUWSOoJT5etXLdmVXHY4tTVEx
	hxqyEU326p/FA+RFc76b5+WhHHCJSzpBFqQg8qKj/lJSKMIDEvNxWDX4QRFISAjgOTvKYwkaXYT
	vRLFHYHZSZnw3YYRSYkhzXtW7tAo19iGV9iyVD6hcq9lu1brz6caLV/89Bfg2kAsCrLpyMteWHG
	MJSyvOiO5WJ/kqae0zy6UzHN04IFIXJAlCcRjk3UWXULqmaHP/SB1/df/QdgDzW6AX3i688/6nz
	pf+hBpsfb7zj+WC63MllSd8Gi6EyY2Dp2kPgSxMB34Wwd2WH6w3qLyS8tpFlF2uvRz2XcZ/TxWk
	JlxARUSmyF/HfElI0P00oo2+SWH+aIDKkEBETAtGAlyzcodEg9LFM395dKP2/UslBqASM1wx0dN
	lKMALbrl1MDHP9cUVf+jZyKDuBjQNnBs0ABBE6yOdnLdCrltkYwEzaCX5Zdzo9kAxqu3oB6weuM
	sFBsGfOnAbbpt/h2oRmu0/Tvl+oPQzZi8TcSdy9v3REw==
X-Received: by 2002:a05:6a00:17a3:b0:874:706d:962a with SMTP id d2e1a72fcca58-8c87c38b7bbmr17356682b3a.28.1795619448079;
        Wed, 25 Nov 2026 07:10:48 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45756sm9134019b3a.27.2026.11.25.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:10:47 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 5.15.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:40:41 +0530
Message-ID: <20261125151042.341153-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-goliath-flatten-7ee7@gregkh>
References: <2026112504-goliath-flatten-7ee7@gregkh>
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
doesn't have (same value, and what the old code used); keep 1000000UL as
there is no MICROHZ_PER_HZ either; resolve context conflicts
(const_ilog2() timestamp scale, scnprintf()). ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..f2404ccc643e 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -14,6 +14,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 #include <linux/time.h>
@@ -67,8 +68,7 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 		tstamp_scale = sensor->sensor_info->tstamp_scale +
 			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
 		if (tstamp_scale < 0) {
-			do_div(time, int_pow(10, abs(tstamp_scale)));
-			time_ns = time;
+			time_ns = div64_u64(time, int_pow(10, abs(tstamp_scale)));
 		} else {
 			time_ns = time * int_pow(10, tstamp_scale);
 		}
@@ -160,7 +160,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
 	sec = int_pow(10, mult) * UHZ_PER_HZ;
-	do_div(sec, uHz);
+	sec = div64_u64(sec, uHz);
 	if (sec == 0) {
 		dev_err(&iio_dev->dev,
 			"Trying to set invalid sensor update value for sensor %s",
@@ -234,13 +234,10 @@ static int scmi_iio_read_avail(struct iio_dev *iio_dev,
 
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
+	*uhz = div64_u64(rem * 1000000UL, interval_ns);
 }
 
 static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
@@ -266,7 +263,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		sensor_update_interval = div64_u64(sensor_update_interval,
+						   sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
@@ -339,9 +337,9 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
 		 */
 		exponent = exponent - scale;
 		if (exponent < 0) {
-			rem = do_div(resolution,
-				     int_pow(10, abs(exponent))
-				     );
+			resolution = div64_u64_rem(resolution,
+						   int_pow(10, abs(exponent)),
+						   &rem);
 			len = scnprintf(buf, PAGE_SIZE,
 					"[%lld %llu.%llu %lld]\n", min_range,
 					resolution, rem, max_range);
@@ -445,7 +443,8 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
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

