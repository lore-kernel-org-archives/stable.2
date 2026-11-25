Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609448;
	b=NRpMNfc1h2ljMKkzBYeVjNoVoHYfCI3/y0qfbMF5S0Rc/EA0kRi1ahv5ZOZyI6moRFpS
	 MntKGQz+E1IF/7VGRdJW2QlygjQKQkvFMjiU+cIGYCUArM/BD6J5xyZRsCUwscbhxKA/4
	 70UJXP3DqjhtRsbr8Aadk0UbjV6p5C+3dC2caDK6BxxqR+R49EqU3wHtLN+gFGqSZ7Ph4
	 dG73AkYU0AJvQl6a2XwOo5bishBOaEqWa5mHCHjos6y1UvjbBI3tUNWzoBSCzhlv/6nZt
	 S7r/6VRCBJa70aQO241mQDBaZvewpEh3GbV1kYnQegKQ88bx8TxUvN2C8kwzpiaaQFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609448;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hli3kMBvdIViTh69x7PrrfJD9y9gtI1HlP/BKZq+mRU=;
	b=jC0vLVooHJD6lSdTzuCQ4X+wVLLY8d83q9d5FxEOaVZpjtk/uCK5VjIwSZhuGeweGaTf
	 /inSMynLibgZXbBba9BIuyfoiW0TAIknkXtc72faws+/YUB1Dm/sngbJn2u0B1S5seTTR
	 MORiQ7TOQZbksWvpll7grOXlTWjnbx1wg/hMiQ3stcugXp+IM32btWOYEzSj5fBNqs5Gt
	 UUUEKfT5llHc80LrCb/uy9SClRYxz2opMTeBe9RWvvFkZIs3bbaWrqoLeccs6mWVGlPmo
	 a88MhRq98lTAyhksL/dYAfLcJE33+qEhCR0pX+EDTLaqZJH0KjIM+DIbN9XePVBzOQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W6HDpsOD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1A606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W6HDpsOD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0300B1F000C4;
	Wed, 25 Nov 2026 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609448;
	bh=hli3kMBvdIViTh69x7PrrfJD9y9gtI1HlP/BKZq+mRU=;
	h=Subject:To:Cc:From:Date;
	b=W6HDpsODqmMKMF+pIJohf3+RxTeGpXLhaxg2xv7iFPhegiChnhzaAc1IGrRODCJel
	 hayHf+E5qcadFp99aDJ7GGjNIp1nEQmJ8VYyk35HOG5vidy0TSoH85i5tCu70+gFe8
	 4tEKEiUDlda99enOPpWYvrvegVzKEvx6YBoksVjI=
Subject: FAILED: patch "[PATCH] iio: humidity: hid-sensor-humidity: Use per-instance" failed to apply to 5.15-stable tree
To: ch@murgatroid.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:21:45 +0100
Message-ID: <2026112545-shining-retake-7d48@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bbe4f3f668babc9443fc1f075695e43e17ca7976
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112545-shining-retake-7d48@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbe4f3f668babc9443fc1f075695e43e17ca7976 Mon Sep 17 00:00:00 2001
From: Christopher Hoover <ch@murgatroid.com>
Date: Sun, 18 Oct 2026 19:34:20 -0700
Subject: [PATCH] iio: humidity: hid-sensor-humidity: Use per-instance
 callbacks

hid-sensor-humidity keeps a single static struct
hid_sensor_hub_callbacks for all instances and overwrites its pdev in
every probe, so with two humidity sensors, input reports for one are
delivered with the other's platform device, and a NULL dereference
follows once that device is removed.  The same bug was found in
hid-sensor-temperature, which shares this code.

Keep the callbacks in struct hid_humidity_state, as the other HID
sensor drivers (accel, gyro, als, ...) do.

Fixes: d7ed89d5aadf ("iio: hid: Add humidity sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 7cec81ff5685..aa7d4f25c393 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -15,6 +15,7 @@
 struct hid_humidity_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info humidity_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 humidity_data;
 		aligned_s64 timestamp;
@@ -184,11 +185,6 @@ static int humidity_parse_report(struct platform_device *pdev,
 	return ret;
 }
 
-static struct hid_sensor_hub_callbacks humidity_callbacks = {
-	.send_event = &humidity_proc_event,
-	.capture_sample = &humidity_capture_sample,
-};
-
 /* Function to initialize the processing for usage id */
 static int hid_humidity_probe(struct platform_device *pdev)
 {
@@ -240,9 +236,13 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	humidity_callbacks.pdev = pdev;
+	humid_st->callbacks = (struct hid_sensor_hub_callbacks) {
+		.send_event = humidity_proc_event,
+		.capture_sample = humidity_capture_sample,
+		.pdev = pdev,
+	};
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
-					   &humidity_callbacks);
+					   &humid_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 

