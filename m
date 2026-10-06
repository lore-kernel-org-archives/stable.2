Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E252F39B5
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272891; cv=none; b=AP3JlgxdbP0IzrxTVd2NiiTe2fTMOBsOi37E0J5t2dJNYh5w7dAuLuT2tysxuTjvMcltUOCg7UYGmEf9F54lID1lcdXGYXbuN3oDQttJXRiP4CiokQ0Aglw/rqgkDedCObMNLOebbDrXnDL5FEuPPguSR/A2TgdQhthPgHBYaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272891; c=relaxed/simple;
	bh=E5dEaHv3YEBEvSU5k7QkARiPZvu1yyc9h820xiNk0sI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bZnvFfPciSf2hVJrlaJJzTqz2UipkKFTwem3aCCh1Ocv5trk5i0pFStU2gc9o75gXCqM+7o9xELyAp1JwrzG+XDepPb60czICuA61fQYQhSNYrTXe8XRDMzyZbXrcqp3+ZjJpinrpH4EMvadf7SiU9xkT4fIKrAPIi0EzWw2NuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/Hvh6Kn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/Hvh6Kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1DC1F000FF;
	Tue,  6 Oct 2026 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272889;
	bh=OZAH7kPsuhSCQm3dykHRTKlyUdCSzKfVDxg+QpYoqhI=;
	h=Subject:To:Cc:From:Date;
	b=s/Hvh6KnB3kpD+3l/fDumD3Lb+ZvRX02ST5TDgsWy6DhUJaf12yH7zHDRPgkK41/Q
	 bG7CFLd5hLw3dPlVljLF0rkczaFLAo+71jGUE3/L5vb2l2nCfJCGsYuZolHv5ViNeM
	 GsVAKfJo+G+Bffns1HHCC2gKsy7wge/adQPDGWv8=
Subject: FAILED: patch "[PATCH] iio: light: rohm-bu27034: Fix infinite delay on error" failed to apply to 6.6-stable tree
To: mazziesaccount@gmail.com,jic23@kernel.org,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:47:59 +0200
Message-ID: <2026100659-encircle-snout-9f76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8065a6c02f629187131f3136bedb26f9080e3cca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100659-encircle-snout-9f76@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8065a6c02f629187131f3136bedb26f9080e3cca Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Wed, 2 Sep 2026 11:48:46 +0300
Subject: [PATCH] iio: light: rohm-bu27034: Fix infinite delay on error

When reading an integration-time fails, the code will use error code to
compute the sleep time.

Fix this by using the smallest integration time as a default if
reading fails.

Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index f9a421618406..92fca33387bb 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -137,6 +137,7 @@ static const struct iio_gain_sel_pair bu27034_gains[] = {
 #define BU27034_MEAS_MODE_200MS		2
 #define BU27034_MEAS_MODE_400MS		4
 
+#define BU27034_INT_TIME_US_MIN (55 * USEC_PER_MSEC)
 static const struct iio_itime_sel_mul bu27034_itimes[] = {
 	GAIN_SCALE_ITIME_US(400000, BU27034_MEAS_MODE_400MS, 8),
 	GAIN_SCALE_ITIME_US(200000, BU27034_MEAS_MODE_200MS, 4),
@@ -296,7 +297,7 @@ static int bu27034_get_gain(struct bu27034_data *data, int chan, int *gain)
 	return 0;
 }
 
-static int bu27034_get_int_time(struct bu27034_data *data)
+static int bu27034_get_int_time(struct bu27034_data *data, int *itime)
 {
 	int ret, sel;
 
@@ -304,24 +305,30 @@ static int bu27034_get_int_time(struct bu27034_data *data)
 	if (ret)
 		return ret;
 
-	return iio_gts_find_int_time_by_sel(&data->gts,
-					    sel & BU27034_MASK_MEAS_MODE);
+	ret = iio_gts_find_int_time_by_sel(&data->gts,
+					   sel & BU27034_MASK_MEAS_MODE);
+	if (ret < 0)
+		return ret;
+
+	*itime = ret;
+
+	return 0;
 }
 
 static int _bu27034_get_scale(struct bu27034_data *data, int channel, int *val,
 			      int *val2)
 {
-	int gain, ret;
+	int gain, itime, ret;
 
 	ret = bu27034_get_gain(data, channel, &gain);
 	if (ret)
 		return ret;
 
-	ret = bu27034_get_int_time(data);
-	if (ret < 0)
+	ret = bu27034_get_int_time(data, &itime);
+	if (ret)
 		return ret;
 
-	return iio_gts_get_scale(&data->gts, gain, ret, val, val2);
+	return iio_gts_get_scale(&data->gts, gain, itime, val, val2);
 }
 
 static int bu27034_get_scale(struct bu27034_data *data, int channel, int *val,
@@ -397,12 +404,10 @@ static int bu27034_try_set_int_time(struct bu27034_data *data, int time_us)
 	int ret, int_time_old, i;
 
 	guard(mutex)(&data->mutex);
-	ret = bu27034_get_int_time(data);
-	if (ret < 0)
+	ret = bu27034_get_int_time(data, &int_time_old);
+	if (ret)
 		return ret;
 
-	int_time_old = ret;
-
 	if (!iio_gts_valid_time(&data->gts, time_us)) {
 		dev_err(data->dev, "Unsupported integration time %u\n",
 			time_us);
@@ -841,7 +846,7 @@ static int bu27034_meas_set(struct bu27034_data *data, bool en)
 static int bu27034_get_single_result(struct bu27034_data *data, int chan,
 				     int *val)
 {
-	int ret;
+	int ret, itime;
 
 	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA1)
 		return -EINVAL;
@@ -850,11 +855,11 @@ static int bu27034_get_single_result(struct bu27034_data *data, int chan,
 	if (ret)
 		return ret;
 
-	ret = bu27034_get_int_time(data);
-	if (ret < 0)
+	ret = bu27034_get_int_time(data, &itime);
+	if (ret)
 		return ret;
 
-	msleep(ret / 1000);
+	msleep(itime / 1000);
 
 	return bu27034_read_result(data, chan, val);
 }
@@ -904,12 +909,10 @@ static int bu27034_calc_mlux(struct bu27034_data *data, __le16 *res, int *val)
 	if (ret)
 		return ret;
 
-	ret = bu27034_get_int_time(data);
-	if (ret < 0)
+	ret = bu27034_get_int_time(data, &meastime);
+	if (ret)
 		return ret;
 
-	meastime = ret;
-
 	d1_d0_ratio_scaled = (unsigned int)ch1 * (unsigned int)gain0 * 100;
 	helper64 = (u64)ch1 * (u64)gain0 * 100LLU;
 
@@ -970,9 +973,9 @@ static int bu27034_read_raw(struct iio_dev *idev,
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
-		*val2 = bu27034_get_int_time(data);
-		if (*val2 < 0)
-			return *val2;
+		ret = bu27034_get_int_time(data, val2);
+		if (ret)
+			return ret;
 
 		return IIO_VAL_INT_PLUS_MICRO;
 
@@ -1157,11 +1160,20 @@ static int bu27034_buffer_thread(void *arg)
 {
 	struct iio_dev *idev = arg;
 	struct bu27034_data *data;
-	int wait_ms;
+	int wait_ms, ret;
 
 	data = iio_priv(idev);
 
-	wait_ms = bu27034_get_int_time(data);
+	/*
+	 * If reading the integration time fails, default to the minimum so we
+	 * don't lose samples. This may waste CPU cycles, but as a hardening
+	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
+	 */
+	wait_ms = BU27034_INT_TIME_US_MIN;
+	ret = bu27034_get_int_time(data, &wait_ms);
+	if (ret)
+		dev_warn(data->dev, "Failed to get integration time\n");
+
 	wait_ms /= 1000;
 
 	wait_ms -= BU27034_MEAS_WAIT_PREMATURE_MS;

