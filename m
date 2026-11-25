Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619730;
	b=INcU/42cKjZkr/WRRDOsjjF9nLtsQERiE6TJrC91+t4EiP6yPIQehJh3t/xFsc3ngo/d
	 NV912KJXQr1HId+3sJ5veOGGLBPK2+yEsQAjdQxLhWVu6lm2SvSD4Zb0jjXOXritlctZw
	 YH6fIrdeAvBnnZBBsEw5i6oDtPQaAxNy1iqNl938kMlTVo24xdwE9M57QSjUEOcCyCT77
	 Aia+BcIvmvS+r/3dFQ/ZJwIiSc/22red48SxhoCheATFAA0USeTJtKec2A1ULZSUWRvj4
	 2rucLFp1bTDIaw09QscrKZ4lr+TMw9U4GPW9pbp3XUosgP6WcczV1WWHiyeI4/IrYhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
	b=VJQw7MuU7JTKqX0VD0HmtZDCnFzNhFdYOCRYi5BSWyxyoucB+jCx6ZxxyHuJYg9c3JaF
	 wnMlXCQMC15JJ+QoebeVCNwtC9ZJXkMOxYzek9r9v/tC6LGv90a41Hbx9Ks39Ewi/JIMu
	 m/Ga/tB9DYaBDK5MYMr0MKaAd3qXh9sNyS+byR2/wnFrkX8bt4P3rVZc8YRhFlMnHJKdQ
	 jq+vMRlh9uq1p/ClrswuOcj6FaFIxsDJXpAzTbmc1A8OJED0FQ6GCQNlQ4o0X1VMttHNq
	 G7LFON/3UDWrXtw6rTkuwHNW8ndvaW7eI6gUxwCjW4KSbq9dzaS7PCIFI43wj7Wot9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k735ezXl;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA00606A33F
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA00606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k735ezXl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99e0082c434so1507836241.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619729; x=1796224529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
        b=k735ezXlpdLtR7dMCL30W8+kWGe9WAteBnpt4CtMYhP6K18pO0OCOA1+F/ECoLftjG
         jrKb5mxMrwP6gKbM4lnyXMaScEzajih2p7QHVt+upa7FBSW9zwyb2o/nd262JhEcHXgB
         +XgvcGuFSBqF1FnwyeC/uVfNTB0CNTI7eRU0U1gg4EzE6+LREQOJ393iHn4n2y0LR3pf
         I9Ddfx7Bm6emNdhjhHXEpBt/7HJOEnd8sqeU7S+6ryxQKmIRrM2UTOWPcmL8yfGkFZnJ
         XuC1sTf1fBn05wNwphZ4G7LGsRv2u+FxOfZSODD1LU1ITymTSYz6MYVbc9O0Knp0gw5k
         ffWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619729; x=1796224529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
        b=dfz1wFxQr/KIEg99WELSaoIGxAdvOQ3AKGPsDZ7QCGhBs1NWAWxTdzon0BJZde+pdl
         kQ2XX5pIeajDKUVd2aWMtswX3W/ygZ7IPKKE74tonjbypAeFPZT5bRbh4Iz4xvdhFNru
         8eA2aAdQvpL+zJEXXfTavAGpv00PxeMJOwnC6UwG6JHE/Gl7KLoCnHpnEnMM9y4npWRH
         4XLJDs6UrnIJocw0iygl+DV4jSKh5+lGZ4pjS+xEwBPJOlXkHUPKBhBXr0i7ybFPllps
         z3Z9XoWTJ6VqatKqKihNIqyw1TQw+WtA0qIg7XXVj5x4yj65YKbfqW9+jK74xOJoa5IF
         KyyA==
X-Gm-Message-State: APuU4Z/PNRp0p93dMr/zQxgtF4AX2qGf5j08y2eDzRsd1Ku85PoqKEaH
	Pe5Y/xkEyCrjx9pVkeONDZaPziQJFhuHgXyhQIkQRiSrHZoeXXX/54PH/7gVbL1t
X-Gm-Gg: AZFdTZfijfF5DrVkUu37Y6mlfgAx+uy1vTLp5QAgFrgckmbbApK3WvD4Vn56BpEwznd
	QqkkkRcJ/cufX35UsxZfLuhi+GA/PqZHJn1ErKyS4pn+JCutW33nt9DOqxc5L2tNcXlYXHa/G9L
	vF4WMooVsPhh+hqlaoBW+OWCzz4RdfyK/5fLjkcMiuMW2Nx207tZtlP6tTaS8ALCiwqvdiAUO8w
	GS/UM3YktHa8i56kK7jn6AnJQhwFdHOJ58qhxUlIoKKTxNoF7c+n4YdS2cM2KRfXiOBKOgxyLhg
	HrNRX4HKBrkrsAKiLWSzVS+hOBS/GEMEeJCsjrkQZIkQh/Z1W82AwMWnOrFdS+RBcYxD/jnm1il
	C0kIrmEvQBGS0ZnbmSpRG7FNaxC7FucIrI2tNxXI3uZ6jme/ceNQlkkFSiai5yWLSWUGl4QmBmV
	HyjwibmaQqod4oBkZxibfdh1G/WnCJzI6cwDoSfFf1APYPEk3+9MJNVuhwBT/hd7D8XWwFyZzrM
	YCZ2kUdN+WNDLxCkRkEUP3iVa5RHzbGI/e45+roP68c8oR9MpXfv7Y9B0ZOUmOyxyv+9AGlbMlH
	OMmGE8jJHtGtalY//UDMT802glzxTRUuRJ0Eiwq2lgyWAuhl5QHwdTR9ID6/zjOSOP8OO+4cv0q
	xSZSkOiXrFp7rcd+ClpDcGjs+/c5UGKf5VkGyrq6YhPQyF1/XQavb0xTpEfxxGnnV4io74HKE49
	rhGOu+Cf02uzhiGTc+pOVzjQzE0C2vPqXKdZirlNmzGA==
X-Received: by 2002:a05:6102:a214:10b0:7d7:6b70:8923 with SMTP id ada2fe7eead31-7d76b70b07bmr6930596137.14.1795619728678;
        Wed, 25 Nov 2026 07:15:28 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213479655asm164767006d6.4.2026.11.25.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:15:28 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.6.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:45:20 +0530
Message-ID: <20261125151523.342435-1-kapoorarnav43@gmail.com>
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

