Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619816;
	b=Jan4gyzH4G12AkxCGZjGWTegCn07UUZXCYZzXTBt6UP6VSsJ6tBbOEorrDE11qf9b4wt
	 NI+4KOAuUK7/KDWYH/1wudt8c/wao8kCuftvV55gbOAaueiQqfw/S6kYc9myxaQQy4HME
	 zVHFVCPGB+c33OdI5rHgI6RcuNetu5X7jGVXa05tNtupIPx+8glAUSOtmmSwvnL/2XwvT
	 aJwAelw/x11bVoji28cnkKFkGFLXl6ej9FHNruDRoJ43nYCcI/UlSJoo6z98WFrxDCuYw
	 gbPyY7sqs/pT7DydSGj/MSba8NNEawj8/kx37B6xgRYbCZm7vqoVRCZDaBuK3ZCSTIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
	b=HKqMSyHVuQ0ElwvldNsCIDkvQHnAyrcMF5uoshvElzO4ru5AtKzM90+jdPFhtJsXFSSh
	 qRr2ktowqFZMhHTVB3Tlcuq1EwxjHCxlRO2cqPreYBl8vzgshevqye1gCd4+o2/59xCok
	 mKHzvg+E4VlnCPUvjo5+kPI+DxgE7nvOEeZNQIrA+d0gpFr2j6svHyvxMrltc+frOEEL0
	 +0BGmRAj9v0PtRiDr0cKyraaBWzDcDlOldK/7imtHNesvYLtPAAIYfENps0Ruk+eEIqWE
	 t+dtOQwjuojcOs290fpRNBzBn58Q7nQ5IpcYpDbgzPX0v4yKokcbtwzMYLq/89Jjo2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEI6J4n6;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC2606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAEC2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEI6J4n6
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-92100b756b0so46981886d6.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619814; x=1796224614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
        b=KEI6J4n6ADx6x1JTdAFcNekf9LS5mYxJ67d1BzhVokoNlWsteW8wBTIagZIL1UDkig
         iNrRUk0fvbmLFX/28zMZn4QEOd/JPiPqn7fRH14qEY2dmF6kOeOw8IDeGTyUpZf4qe/P
         Q2SHu06ZdGST3w++NiNKNScN+tINW7cXoW/n1yOEhaMLW6rcQUuOCR1xFad+iEg/YxTD
         Wx2n49HOdHUV/dm2/X0qCIJXyXWjA/j09CB5Qn0z0DXsFDMGYcRt5qKpat95ofo6Qb4Z
         UVxtyPCCgPpribj83zjyhTDiTPPOhRdN1DNnuyVpLgH75L5papJhgA1beL50AVJ85aLV
         WMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619814; x=1796224614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
        b=xfxDaxBPDMWRDsR5Td4PMLdKep/d4FXDilAqbXpoFafHIM6PicuyTzq9+H4hzyzEAF
         H+bXrqEq5U7BKmTWCmmQZcIOsAf5g5bfjk6DZp9xE3kNStdfaBaJ+yjlwv3RG5xohEbK
         wKJDvTrVClco3Dui4NOP+k9gOYWRYfLmv0uTtH69LFysxgBWLYRLWPxArwCGuxI7WBlD
         hxnJ8JiUmGSrxFvev2NvjzylfMgcgmauzE8w013rkYF1bhN4nx1QG24E1Vmo1ARUXH+d
         1Q4F55gk8tU2CBS1LVCPl8ivdX4H2nqZfS1Fm+SmdM6U00/0PsollDvVNR2NEf4ElkYm
         Ihig==
X-Gm-Message-State: APuU4Z89NqCrGKVYChuzxKBuI2XXc59qtVTpWPmhKD14HIPimvr+Ln9V
	0SVjiI4vk+cGhVQtX/NqD+NxYNlnpMPsYLDmM9SiBTea20jzRTHqVNnXsV5S0G4M
X-Gm-Gg: AZFdTZdb7DITkTZ8Juvy+mOEsbETP8bQNHlT/mBLxnL7mGyG3Ev7xl1zYeqe+cdEgfw
	IGJTFlmLMo7VX3U0eONyRTM6AbGVKBc78+gFbxlEnbiQS16yFoQ+M1iFkDB0wveX6B3hYhdQeoH
	JF8CIzhnWgr7bPpE98Zy5q4hqiohtxUyahnVBKYZsYmFDHmobPkG+hG4DKdpgXDSB0L4EFLjI7b
	UwkYxDsq2dDIutx+n0W3jrhHbHvVw6JbLn+4D+sdy11BXx+6bQK33IX0OgiAxwKSPlFZks1SkOG
	wm9ZcxNvFiNbemzGED05mAT4aWQ85LLHvB/ADZXcOZCJEFKbkmTbobUbdkfKRyUFJK15CA0A1XE
	K6Zb79mTG0bwVpJ/GPEZ3Sy88ZQt0p3qpx1D+ApnnEGyk3li0Sm5jHLRtshp8RSIkv9G6BDTzge
	r9kt4CVAxQU5PshA0ekuCdogbxkmTdkHUtDdnutmzAylO4AW1cfpqWI8k6UNmbSGR+UHdTpXbZw
	n2jR4iEbii4jHhlkLZ5UC2hKyBvdqbCqSWjDW10+d0LcVbUxODSt9PLquE9b5OlT851IvOsuZEh
	1TpAhSzqPT4Elor85tHRUD8/bnCc3ZKdtXQT4FADRrkU9S2rnbTQlWRyFcwCdk74Eixl/LgW9x8
	ZvLNfRf2w4FLiUim+QgIdI+Nngla7jkQcQm0j96oLrqBNk+y1HkJcME9I9cBw3wPYc1woClfTeB
	IAlgZEVfnW6rSmRdmGQSLY7NKzD56DpF09BePiAXGpzA==
X-Received: by 2002:ad4:5941:0:b0:921:550b:bf70 with SMTP id 6a1803df08f44-921550bbfb5mr190017326d6.26.1795619814142;
        Wed, 25 Nov 2026 07:16:54 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d383asm163866836d6.22.2026.11.25.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:16:53 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.12.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:46:47 +0530
Message-ID: <20261125151648.342825-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-mulled-wreckage-c4e0@gregkh>
References: <2026112509-mulled-wreckage-c4e0@gregkh>
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
index ed15dcbf4cf6..bcd85bdaebbe 100644
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

