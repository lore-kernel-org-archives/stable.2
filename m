Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619384;
	b=G2PpLHvh74KG0WI6zHj9STLWAFVu5i6vUc6IoPdrsAi8+UyNAM3KleVy6EbNIlu/p63i
	 ONSTD/0T+Jh8Id+VgU6KPuDpOJwq0HmqJzlFvxUpuGIBNAjaWA1cTULmJnl/9RLITHRx6
	 ifu5jRv2kVHCw6f5Nph9cQHzJr/P0GDPbuWTklr81BpAaat2U2M+c7stDT5L/uow0vLj9
	 KPJ80zqYFt0R3a1MTZwM9hzsIiZvcLBoeC6dP0SEIx6xhTkbn4FgM6YhuByJCoa1458vV
	 ZlzZAIl8p2aabhaWx/BSHEkIBSoqRM3NGcY3wve2rnOyvpPeN1myNTObEVEaZk2i6JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
	b=OEMGzUCYmR7ASgFClrEpgr7xLweVoYSxpU9NSZ3PLJMCGo8FTiWkkkRw2XQJ38zGUG3h
	 pDKJebQ0H0FGPoHs8SkYf9SURYaYdLgEDeHEpiz+nJETCS1fgfSmq4IyjhetCda6D22aa
	 YI0yJw+cqj/cSFN6IikApjmnVl96iHFud9sRqBZ6I6StMSgpxey7N30a6BrGa6Kr3guJi
	 cih32ey5/rAGEzZQ91S3rp1Rha/co40XE1i7oSa63EbI98xHbAp4tYmo4GApnGSdnHC1Q
	 BzPKoLKJuto/L6BEbyYim+k8VKlDKrRwpGff46DZnjnxeQjp7O752HGI4RwoEZ+RLMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n9KK1t1a;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A2606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172A2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n9KK1t1a
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a3c08d6928so8630398c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619383; x=1796224183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
        b=n9KK1t1aIC/fiAic+1yCiwnVukbaNDdSHCgA1NnVwawKG4rW1zVbqLCNbHfIX2BBiw
         PotsJmL2MpzIgXLHMl4HQ6078oepuSw2TkPdYcU2z7iRhT6o3yAE/1bONN3PLYCuGLMi
         nb6vWJpHpRmSciGC02e+u83RAOzoAKRgm6ZefY9FQi+SEeXYGPTaUvyX2PnFluwMLLHo
         rxdlh/Pw1Vim95b+D8iGJN+lPnyyT8DVgc5Dsr90VDWMCLX4l5+GnP263uzMbxu25/Ki
         dsDHEqIZtJ6FiNhI7WNUVDmpINQr82bThqWuitmkYdKy935Y4RY49bTet0ueoeKwSx+K
         9U/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619383; x=1796224183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/PyKRlpY9PuBs7hLyuJjpaim11kXeksZXbjngRJ7y4=;
        b=WXzTUSE3HDGgr4fdczY9LTRrkH+1R8rRqEDu18+Mb+dC4d4FeVUusHQaxbFMgnP/zQ
         xpoMqgSapEb24nAtM4GePmwd8PVZ0eCqTEyPTtM924U4ucdQvwMHoVFJJd6i9LY2yzou
         wzDc0SjUIzVuqJz7DZXTqID2FL/58NlfSfu5RpkC70P1sxwZ4iJCkDrMygj86NOVAKI9
         +W6KYKkfINjcmWNqkx4hJ5/Sqgqd0917beqLnZpxS6bDqUH9ZxubIYvVRLDRy1CUu/f1
         /gJPNo32d/lOeQXO63N+ugZlaUxjqSTsemFyR5+NPkd9PSq8yy/6mzC9e15oEzF7Zveo
         jZnw==
X-Gm-Message-State: APuU4Z8i2/N7BVkiKZuOlTTpmdnqlVIDlw2FuwgLOsWA7Yns/CG0XrMU
	LkMBxg52ly6GKEx7DPfmOrl+J5CjOoHleU9cD9OiRZW1bwuWRwq686Ot3PpQtcC9
X-Gm-Gg: AZFdTZdm9ZZctnN5Qrzbvkm+JpfdoZ0xPd7TjWds/yGKnhlxokDh1AxRyfkTYKEXr/S
	Cqff6jU9OoNPWKxeOxqzS9Q1744CX2gJrLI2VUG8oKihH12PkAAYbgwKh0KOjAbN3ctVHl0wioi
	bLDHwGxwE6bwJAsGMr4CVt1+Kshzmo1Uc0Hp4kCR+fdWCUE0ZIgOP0xMIwHTXBpxKJxG7CYwGYo
	VZRMSmfcOL0s0W2QlVss06TUZFlGh+QDXS0iH1gTla9/r30PTSOqGJPdmxHuHBvMqOjhLxQTa0m
	A97X6rOlRg/uiobZFHZU1OnmLLy5JPKyc/YvWzAEvR+0vu9ceCzv754YmEbpMWW2xyyu1Au6Agh
	5J744ijt7Mv/OK2c6YFrCk7lUU72bFu8sHrl1BBC/5rGhy0UUhutAZF6OTsVkBeDsuhD1xX23a+
	iY53vIoFWyXjkMpNU1EacVLd56TrtYG7mmdPQBJILi6o0HBsPnP98dsP9LyH/zA9aL3KYsFfqHo
	mo95SGKxDf6uIbSCNU1mQMUV25SbWSkWzCQEcHNHTzraVXm2XQPZmi8P0vKKQPGEn9oruKVcjVx
	2sKFNL7uK68ZLsEZIymcDTBOd9kZ6pNrmwzNtv5vJPWXhIoyf8JXlhbFGZ7RQt9AV7uAdCr3rcG
	J2sO/HbdjOjH6E555Yuy2aqzqesnunzlXVruRlKedpDYjWQ2d7tLt9qsI09oHhQZkrxR24MRLvf
	wV6m3QdQHYMI1gwtRk9/L4tN9HVHvfoMJBbiu6vmL8n+8=
X-Received: by 2002:a05:7300:e91e:b0:384:2780:8757 with SMTP id 5a478bee46e88-38570a3e793mr20725777eec.22.1795619382902;
        Wed, 25 Nov 2026 07:09:42 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm58552130eec.14.2026.11.25.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:09:42 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.12.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:39:35 +0530
Message-ID: <20261125150937.340910-1-kapoorarnav43@gmail.com>
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

