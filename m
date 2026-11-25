Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619428;
	b=Pq8g6teNe3+Jm4KHYKJ6Zz18vgksCRQQy2BQr13wDyxRA0s6y/hKiQFuQxr4WQFD3WyW
	 r2dFOplYyN6m5AovRJGXOX8z7WrtSHBo14ynTJ1rT00f7aZzbThG/N0v7I24RpcGzILKu
	 fif1YQX9oL8kQ7kZDJp1Q5f0y4qX0D3VGWu2P5ypncsuB5OrBu6zc0eEZDBim05YmwzJ6
	 rI4e1eUWStA060JSrlJsDojg2V+NVJCcRY5fYrKkiUZ1JauX7ZWZ50QW3R7cN1tlx6fXm
	 6rQDiDMzo4wnibI1ZWEOhmrJrBoHuFsfhfgkmZXs3i4a30DYId/K3f8ZZNjk4632LTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sb42sheNCVeNiabVVLw6a3Tt5zHfbORuSGpVsMtZHE8=;
	b=FP0803sAAWNQEoMPmSo+ggJCkqmz/7g8zYRRKzx7OMxJoFivEZ4jGYXGiUOTCAJIQ75D
	 iFjWFbcH5j8Wd5y8fFIHQwk7kUVRf+d09rrF7hrHb8X2f1Fmf0QWsWJqi1PtxJILTk5NJ
	 mg4y7qdNEVFLSHHnPB2IIfYqbOBvVO6jm37DHHGTV+ZgokJulF+nQs9yX9GmREedJAYS6
	 N/9kcPy4pxIOGejcXlPRO3hhK/1gMuEI1yehgAPTJVS/PDsguWj59JAdTU6fb9vklOxkb
	 gI/ClYACO2uPS4QS8NSLq/hCSMfUch9cH+3iZppFtNkIEzoMmmkF/PtGgjQ2a6iarUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vGY52Z+s;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320E9606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320E9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vGY52Z+s
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f05bc71e01so24809185ad.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619428; x=1796224228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sb42sheNCVeNiabVVLw6a3Tt5zHfbORuSGpVsMtZHE8=;
        b=vGY52Z+swM0l4zcN5jEIBOvGDl6K7I1GjCH9SRkM4kRnWjjSZE2SjPg12hU5E7GrMx
         01X16asbNJyAaviujjJdwtH4f8O3yy5FUmZ60n6QMsTaE3Eno7FTGvZ6SSD9aWPHQUu0
         4P1JXajsqze6cJyajxogHW4CyHbRhk+sXiewfd1GmY0vaNA+/oKshZMnJ+NeGpptQxqZ
         vyMEGk3j+0Y4Q82B5xpuAq2dUzOnZUF8usHxk7HZPG/1R8+tTtrcRr4znY900duNFu8a
         L6i8uNlkE4aQ6lBLRUMfJADJ5SO4e1tVMU4688+NGrQpHejXaEbz0APJ0bQ/3ewlA3Nm
         6bPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619428; x=1796224228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sb42sheNCVeNiabVVLw6a3Tt5zHfbORuSGpVsMtZHE8=;
        b=tUdzucvo1zQI4Q9JZCMdz0yS0n7VQ2fLhgVqf/gMuMm8DKeJoY9eHn4qECw5pijJV1
         /LpGMmJT5V8vN8AoZ/dmWem6T78EbpKPUioSKCcxKkkUuGcap0P2a/MC3tVjNOsKzhYa
         PWW2zUtPnAu7vZliSPNVuApg+uHZD7/Czs3xGEH++rZvw9S1rZJsPcAKR+qHVRKLl4+d
         D1vEzpXj83AyQQddF+2V3UITxZ4KKpKtsng9JxMyaVQ75RmXY7B0NNXt9dpGHhpI3iG8
         2WzS1OtV069EZDtUWZjzTZd+0fIJ8xjBTl84pCj1oA00lW4uekHlH06/aCWnjxaSwmyv
         P1Qw==
X-Gm-Message-State: APuU4Z8rqYiBg5/SYYWi5WN2RXhCN/cbKmAsCz/X8vi01qByoxG8isT4
	iapzcgaSeo+ZsFDuqy/pVLk23YXPMwyMvbWq+HIfII5EsFaLZAW3MQ+ClaZvKw==
X-Gm-Gg: AZFdTZdW/ShC3HYLXxDdP8v8Dt9htdqkCd8cE/7Ht6/8ezYvfEp8PpoI74t3rn3euWZ
	TrL5DOLWw33jOR0GYUf4qXwmQ3rbsTGIkVjVMcE+zNiSFa3mGLZCSTE/IkAzdqkWyYaPsWrQkLN
	BxlWjBeyV1Y8EdBaLUlQU2UNqQD0RLmxoA+4SuLuorbign/vf5sWtjDsSf/XrUmyd9fETdH6klY
	3L8oheDKVLiuhsf8wdjpOLjnCJwkAlccHUaqEfMN0d1d1qBAsJ6xpckbrq3Q8F/vls1yb5NcPQ4
	AiP034JTaIYpdngujLtZg/OmxbCDiXouTkC5HkXgCNm9civrEM9Lt1bDieWoRIw1ehdFY8s0r+W
	i7Q8G4Jii9VwLHch0iB+3HeVHNtr2vzfp3foouOwMuevvQR9IGBKLslxoVkGwYOBfPH4J+VSlt5
	tUNbRW4rMVzJ4qBsY+n8aACtDxSDFizVql+L70tS87LeRAFmD0cBO9TAHCZEyRx8htJNPRo59fk
	wfc+nx6LxtCym+sKwJECCofr8jbN7iYeG6/29kuIyPbZk6LGIBeKkVgRzvpkIDRIjUvkabkW2Nu
	nV3swqnZPd+90UXTPES70ED6UH8rO+v6lDwm0GmBjN1PHT71O10KUq27z87+vvf5Edg+dFBYQx5
	QqJbcfpVmR8V7LuQHzg+kxM2IjpZu4KSjT027dpAGdOMAD8BIXlHnwqG5B9Vk2K6lgCf7njrkkG
	TSkEcTk2c+GGcaXfCb6+Bx+HNUlTRXv4pQ3Ru+pQy3XQ==
X-Received: by 2002:a17:902:da48:b0:2ef:ddd6:716d with SMTP id d9443c01a7336-2f03f18fcf8mr184227565ad.24.1795619427484;
        Wed, 25 Nov 2026 07:10:27 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee85466sm85923705ad.4.2026.11.25.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:10:27 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.1.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:40:20 +0530
Message-ID: <20261125151022.341087-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-enquirer-implicate-8f46@gregkh>
References: <2026112504-enquirer-implicate-8f46@gregkh>
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
doesn't have (same value, and what the old code used); resolve context
conflicts (const_ilog2() timestamp scale, scnprintf()). ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 54ccf19ab2bb..43cef5f97f2c 100644
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
@@ -68,8 +69,7 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
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
 
 	sec = int_pow(10, mult) * MICROHZ_PER_HZ;
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
+	*uhz = div64_u64(rem * MICROHZ_PER_HZ, interval_ns);
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
@@ -393,9 +391,9 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
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
@@ -500,7 +498,8 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
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

