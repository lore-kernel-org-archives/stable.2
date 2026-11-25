Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619699;
	b=wxmmuH8YBvNI+nD/MxBp/P8qgFdNi1MobgPDA2E/xHdFGfJB246+0Yzk6Yr8lU2+nVuc
	 aASU0g/uE4Cpktdf32O+AZiSYSbP7MkQIKXVdAvdBdMklkQOUy6bSDzeOdl0T2aoYFHTZ
	 rduKebtEqgcPziQCXxrGSrTfTR+JAgrlAGNGonqjHUXEyOQdEK+TzwceHZWOnpGuBYyIm
	 PEiDKk5s60UKPoWI0g3syMHZHU8qLDLPGBKQ7ikVong3TRK/HK745662GVzg/HwDLEwts
	 JlJAeQ+S62ERRxU9tzAhTRmgR/ZNugHwyHTNmwznUDKfezd2tC3RLH8RwCzt0cnwzpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
	b=rJzZ4qwEYnlTEnKMxjC+Sz0H92RwOfCktTEapWz6OFK+jx5MT9V/CQ3ODPhIa/IfUSAL
	 jjQ/dviDDX7lGrl6uWUxUYnyrvMRZ1JkGvUp6vLUzuwhtfBvZUmluM+iYyg63j9wRk7uw
	 E0qQla0o+Cj5mqCDtJauM73VfUM2wo+O/jHHyScao38MJnKcw0/j5kx070Xfa7YSmtp82
	 owgwEHMw3e5o2qe6M53DmsdqGQ+eK1qBfcw3nCxwcLlYhU5i2r137rWBY/yD4kzevSiWJ
	 Qq1YlroPocAxGXa+lf4PK7RzxK+4dhHoTjSX41BVr3lL5HF1m+3YhIInSOqAD4C8EaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+ibXCCk;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6F606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F6F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+ibXCCk
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9495f083657so653891785a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619697; x=1796224497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
        b=c+ibXCCkDLJKdunr/JjIoHM7y1jL1+cofhxEpTQs9JDZJJzuCv3b5TMWUjwu4U1O0y
         Zd5DidERtzzx/c0/+pFa0PXx0LOKxtPirvZy7JRdmvbV8ktbn86ea/lI1jV93iD05rLx
         w6N2MMeBFqIFLoF39a5AeYDIyGD4usxmx2dAPgHVi0zaLQZ87Z6eoCbZP7CdjL25E1dy
         zzYthm84Sv5t0Gl56Q1RtfEtAta9bEa+4Pgn1FINZrbqYid9uqK0ZRcLKkoE6zhuoeTN
         /9cF0hUt3PU+7/IavwQ/pfJki8YKKmCtBeNpyO5QGvTkQiswVpoxgZ0I2sA1WTL/jMeP
         o/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619697; x=1796224497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
        b=IXBa515KpAUHGi8ixdDmwt7yDLkX5cWxI4oer3G2R9vrIVNnGjHj9jdutl/j6nb29x
         199ThDPXgwU21eedoBDSAxpayGjZbQaTbEVOblN2QDADCSAJjhwIEps273dlfGmyNfKr
         rQEpB6T7gsosyKmgHw7CFcvnFCv4NuoPhfgivfDrNx1avFYvXPVyZORjpA3pRzQikduO
         0Cu+ViBqBB9TQOn96z/XPl822C469d9JYAbk9g4vK+GPOLMZ2ZOs/Te0nxeC2AVtQC7N
         iafrf7kK01O4sAjX3QMdlBft3RHKHnnLVigxQBXSrsVrgEUsn0KSbT/w2u2ZQ5FV/xKA
         8hKA==
X-Gm-Message-State: APuU4Z+OpSjVOOCFtf/W02UOUo5soziElMSvG/cVVcIyA2pY6NP+YC9g
	Ibg7caOd/dgd43S0qsu2zjW2GQmoSuvEMuvnUeQg0Zp444dzZfZdYid9gFhooj1D
X-Gm-Gg: AZFdTZfOiBtXPb8K/IjLrZciOSwhJY/4Wz9Z5sIN4GvApsbWC9BrFQUyBTuV8JEA8bw
	ypBSOeNoNJZSAESJplsrs/3E+yuCqWvA/uLM+j5WX31gnBodf3WV2R9vGgkEU7B+O65ANM6dh+z
	53ENspTcKCTXCwDVqmqeCT4B4VHVShCV/knwx3zdLegr+hwKCxV2lumyV9ybUoT2CjW8OJFbUsD
	j4TPzGKHNpa2dD0IeWMiaOPYUqNyEyP7Oo60/DLJKcQteCX+YdCpVe9HJz1tozDZaIA+xrPHQcy
	S8keTgdnv21iErcotA/tvgjQ2mczKD+FPJETv+FcfY4nQMMqxkS7p9gQjsIjNli1VFq5HFBhpau
	W2bn+/40c+jEocnfhD50YZNtjl8i/IgANy3PGEGljCuTittWVuqvGsZ5HA1Cjla+bDe3xPQMXvC
	M6IBAzouYeJY1l+2dTeexIJ9eVIapPoi6j2yQPq8ZZ4euC/uEsA4eZw/3ofX5iO6vqxvOupsMj+
	Ep7zqNAGbOlNHT35BTWbyogEC4PmmUy2n+UnWXl083dtsZRX00aCpuZuM/zg5uEnvwhLd/l2bCL
	ZTl4MQxF3zhJrEUpomrjAavSBAqWnW/JBI0O/b/OQOeF5uJkS+pbOzBqzMSVUm1rHVo+FHSBCQj
	UxUjlaKioBMQNXObT1IEmnr0xoVkkne/ZLjc43uK2suHblslzGk987CVwKZsLpshTcl13dt75Xw
	zwZnpN0eviCe6iQAATIEVLK7RL1ENtQ6l58ic6bxg90w==
X-Received: by 2002:a05:620a:450e:b0:949:6fb1:b422 with SMTP id af79cd13be357-949ba9b7194mr3342186585a.16.1795619697334;
        Wed, 25 Nov 2026 07:14:57 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949ca846322sm1155836785a.34.2026.11.25.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:14:56 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.12.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:44:49 +0530
Message-ID: <20261125151451.342303-1-kapoorarnav43@gmail.com>
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

