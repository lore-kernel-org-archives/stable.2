Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619411;
	b=GWxhLg4D9kaCVdDRiPJjdANlswn46QWn7f89ChMVW+rKpCacD7LfycMU/PO1mxxRFmhJ
	 gw7MVo3aDDjIj39YYJBjA4HCoxqmRmzH2yeYyButTLR40Qbw2+iu6LVvFdd+Bzru91zm8
	 VarMSqjeRRKlVxNU+6x88xZOEb6mOL6jVLuNB6pWNn6HhvdqAS/W2bJD6FTIGGZvbSYWk
	 ImhpH0AECiEFPESAeZro+oNcmCtEYyio4YzXNkzBDpGeOQBz+CCwKR6JKr0vXKdjrW34h
	 GqYGHQTAJi62Rk1ngROfGvie98u9ZLzTgV6enj/TCkZbuJYSiUdrNBEtxiUckTBk7Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
	b=UIuL7rcMwrB6+hAaRI/u6m+PD5HwYzBYlnq1l4Afc6BsQllX8rHL+4tyPXQzRSBdvqkR
	 nURdSTTQtYuYXpydm9AcrzqlT6Bn1d2eADmReXWbpfLENcj22Y5aXR0hgtn89r9slTNrO
	 ioW/zn1PdB+2mgM5UEng8fobuv5/iu65WiPP8Lg8xPFT3ZOW7CbeTgySaU/XAMWqKVLkl
	 iotxQ679X8cmbXYI3GxUQEJJHllzNphiRWuHnt6A3x+r3AwTJAnmTmJYhJQGKts2iuUZk
	 ZJfVuOt9Wi2iftazbq7MGXHRWfWWxwwrOuDa4LoMW7L2pHngpXiZMgNa+2wd1hRYYFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSYJjEP7;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB5606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9FB5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSYJjEP7
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b5786e099cso4190759c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619410; x=1796224210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
        b=xSYJjEP7IaolPN5EGSOByl4nMO1XZzmUK+VKe6c9WTdvPBpq607rK11sHwMJ4ICIVn
         FN6LpcUGDyGjIGX+uPzGFLrvXZ+6w5eeZjVDnb1O8GLAy0PQ+yv6admkoDW5nYCFcPir
         cw3EKnKjcg+A8glCFkrOVBHGDbbL430MXsS8KdCDe01s1dXxwCZB13IvbK5X5qcb6d3c
         laXywJJE2tmLG0ov1TbYgtasks2tvHpxd79pTW8BVoJwIXh6M9uZ7QtUpa0lqKvAfs9V
         It3zzHrS3idyxgjirwQxyRwC6I8iFf4Nejj8zd8LYjVu40+bc5QlVmRvQblqN5OgGHmW
         Bgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619410; x=1796224210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF+OC6SrmcJN9bb1oTr6rcm/IGNnY94IzvBUEr43paY=;
        b=zsuR/BKqs1aFnlxTJXwqlZVXvOj9q1GAtOTy1QvPps/hchuadF8gCg64UBlH9AGuMD
         np51Nu78UH827PTu9ibOIX2G1w/3ngGBz5YtWNtrg4N4jTxdAA66cbjGJL1e9+lZrYlh
         bZOKgvg67xAgykvitpN3k0rOTh95255brjxeYvanwSwhl1eRCT43kJUiB+OXXRZvwUOq
         OSZcQGcHIxwz1+ApDrNQEH/hAcWJpTiFQxnIU2xR7R7cAR+miNuQmsmDi4Nrud6BFP94
         He4RRfJWJe+bGpm4RON5JfyUT7bGKiFIjvp2RVlIN8Jkfkp8nuPQ7QY15ebhI62fbnrJ
         5JwA==
X-Gm-Message-State: APuU4Z/JLNrBLXo/9F/Hshh6BiTXMFJ85JvF1SiROaJvE36fyU+2blbJ
	xPMMwsI2+pJfddgmNJNG1HAH3/ebZlAfkjjvEuDKUjN47Yx7Jnr4woYR8Aqu0pEV
X-Gm-Gg: AZFdTZfJbzadrbuLK1ib8tMjtKqH4JX26UxWnj1kU+7r8BrD5f4fr4sEe9BL/BSV5a9
	jll2VxO1Pi+x1t0SKQL5I3x5jHM1tlU6OxzeuHBlSvoouMRhgnmGWqRrjM7x+G6xuW66p/YQr/D
	ctTGDN2B6szwh1TxY+gCHEiaZwos2n/eJRm7HhHwxwuqO+cUzdsAlcnaJocTpkfF6vm1eyWuvoq
	ZsL8IutSwb2ape5/aZeizXOEXrQbQNtrq2uwEXHPG2SuqzJr2hJ2txgkit9GhmlkfsGJy2sYBke
	ca7cT1FrHVaIeWGFhZYumqmY2JuJCkcyxo6CfVAVczEcExs8rV/EVnhPOcmXGJB5zSnxQA10SUG
	/F7Ng0QyYywz1IIrcVRs83nOPt+dXQitYad14OW+sVu+8TrMUOPGIZzLJViL1TcZu824RPRS25z
	0vTCx6B7oDk8jIGWNAKnvZYSekcI4XG3ta4cdWRHgCcM9ReVgzPIxQYwB7VKwS3RUaisPk5cJLO
	hJqMycnpkYwgUUBxGTBuEKaolQryua2jJHIjZgoaFxC5X5We38gtJlX+0mAwJEW+x7aCkpfQZe5
	V9rD+ugAFNzy3qKPQyBYf/KM51YSJTSlkNkjNEuB+IV3UMkjU4P4tMSgfDpMTYfZbnb5VnC2xBy
	GHnTh5pEgi/JGKJXBMb4YU1bwgCebQ8NW4IMwcEuXm6Z1hifViGJL+s6wt+Nu4MPKhIS/nwVdAN
	mIT03ma+AapR0bIWwvLbkwxXnQGyfKmnaSzctcHqFDxQ==
X-Received: by 2002:a05:7022:3a83:b0:184:992:c9ec with SMTP id a92af1059eb24-1b55693aaabmr24334832c88.38.1795619409694;
        Wed, 25 Nov 2026 07:10:09 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm48240676c88.6.2026.11.25.07.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:10:09 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.6.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Wed, 25 Nov 2026 20:40:02 +0530
Message-ID: <20261125151004.341015-1-kapoorarnav43@gmail.com>
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

