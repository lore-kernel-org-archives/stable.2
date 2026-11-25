Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609436;
	b=23sazxPqvnI53MVmE4DiE5IiluozIP2TKbhVwr5/kiV1aq38/l7OFMpir56VMR5zir4G
	 +d1k1qKIP6IHN51NktG5W6t56XOa4WePQkyo02/NN9ppRqWZ/S4YDHLY4fn09tVTOKz1F
	 Hpm60zX8RsAL/OBmMDr9EoT8pS4c/EoZ7uNNTV2ldOfWnhf0obrcpXzw0XKJfWS5RXvta
	 r8VigM/Vpf7TEyzOkZCZrRXE0ohekKqPViowrcBWryIU2Th3e1Sjubft2JWbVVdrHg02z
	 wIT3nZ/aZuSsszyDgk8TPXIiCAtcSrIRq5kODM73xrt1sjOSB7TmVe7SIoTn54dhMPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609436;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vemmZuKjaIts6lU7hTTbY2qtzJEg5iju+Py5heUgfDo=;
	b=ySAioMybiI3mkY0d8k0zeNoMAf4Qa1fupalz2m2WTPYIN63ESOfSNslsQ/KsEjGsbXH1
	 1kvnMZIBmCx4xk1ws1brx7IRhEvgtmU9ddNgNPNLm7oE1pAIX6F3DGuQA4pMRwqplyupr
	 TksRds5WZg1WvRNQbHviGlT5LFdJyYupSEIAji5DWVbRRFdlS63yUhBpBlAgbAvO0j8JO
	 kY3x61HV97rdVR+g07uOVs/wF7tK0MX4vWbHOW4RjF9bJcLgWHRN/GuPqGDDfq9LxH/wo
	 oyxqdgTNKMrnL/UemD/y4ui+XMnx7E95tzMKVTwrVQpEiO0Z6mCXODIyc31qen+pvMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qnaLzFc6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DB606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qnaLzFc6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1032E1F000D0;
	Wed, 25 Nov 2026 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609435;
	bh=vemmZuKjaIts6lU7hTTbY2qtzJEg5iju+Py5heUgfDo=;
	h=Subject:To:Cc:From:Date;
	b=qnaLzFc6PQSYDgKCbjA1DUGYjX5aOuIPuQ3CwpNgdwiuo27NCpLF/LR6wv1AreOdH
	 GTIgwKMoQFBKLnOqesjv5xYlOQrPIg9lpmCCDaFZ+d9RdR2n1eB+W9optZxyDGxxUC
	 TDGT05DnKPAyTZntWY1QpjsKenkROksbfPHi7euQ=
Subject: FAILED: patch "[PATCH] iio: common: scmi_sensors: fix truncating 64-bit divisions" failed to apply to 6.1-stable tree
To: kapoorarnav43@gmail.com,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:21:04 +0100
Message-ID: <2026112504-enquirer-implicate-8f46@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 043ececf147863fbd253687aa0b9edcac358a711
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112504-enquirer-implicate-8f46@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 043ececf147863fbd253687aa0b9edcac358a711 Mon Sep 17 00:00:00 2001
From: Arnav Kapoor <kapoorarnav43@gmail.com>
Date: Tue, 6 Oct 2026 10:22:41 +0530
Subject: [PATCH] iio: common: scmi_sensors: fix truncating 64-bit divisions

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

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 442b40ef27cf..659a2f888ac9 100644
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
@@ -70,8 +71,7 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 		 */
 		tstamp_scale = sensor->sensor_info->tstamp_scale + 9;
 		if (tstamp_scale < 0) {
-			do_div(time, int_pow(10, abs(tstamp_scale)));
-			time_ns = time;
+			time_ns = div64_u64(time, int_pow(10, abs(tstamp_scale)));
 		} else {
 			time_ns = time * int_pow(10, tstamp_scale);
 		}
@@ -162,7 +162,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
 	sec = int_pow(10, mult) * MICROHZ_PER_HZ;
-	do_div(sec, uHz);
+	sec = div64_u64(sec, uHz);
 	if (sec == 0) {
 		dev_err(&iio_dev->dev,
 			"Trying to set invalid sensor update value for sensor %s",
@@ -237,13 +237,10 @@ static int scmi_iio_read_avail(struct iio_dev *iio_dev,
 
 static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
 {
-	u64 rem, freq;
+	u64 rem;
 
-	freq = NSEC_PER_SEC;
-	rem = do_div(freq, interval_ns);
-	*hz = freq;
-	*uhz = rem * 1000000UL;
-	do_div(*uhz, interval_ns);
+	*hz = div64_u64_rem(HZ_PER_GHZ, interval_ns, &rem);
+	*uhz = div64_u64(rem * MICROHZ_PER_HZ, interval_ns);
 }
 
 static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
@@ -269,7 +266,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		sensor_update_interval = div64_u64(sensor_update_interval,
+						   sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
@@ -395,9 +393,9 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
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
@@ -491,7 +489,8 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
 	mult = SCMI_SENS_INTVL_GET_EXP(val);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		sensor_update_interval = div64_u64(sensor_update_interval,
+						   sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =

