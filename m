Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610804;
	b=FZqWm2KUeACuBBcvF60pRqyIvm3ABIkjvfyg2pMnhfso4fYtbIdUnlGRm7PqaptLteXL
	 Oj18WC4/amZaV1niRVT0fOVozjdqXe1W1CEvDK/gP43OZ95SOF35v+knHFVL06o0oBfW2
	 OVrTBdIccPmdmWSb2oSCm1Jafwq3otr3Rzjo+mcCDl0AZJ2PdOMxh8N0slou3oooXb3Rw
	 imzkLdzjlNrPZcMyBEr+Nd+Y+QS25FaudN0YNrj8ATl4uRMhGumfL8UpVHUl8nN/Nz87j
	 uFCe0KXv1PCnV36XZ5e0dLhL/zIZfsKrdAUfJpduHxxNOsfTEDtorzkXs1/MSoUsk0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610804;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KY4ManuWMmkk04wPFsSFRr2IT16RZ+zso9zoSZCarrI=;
	b=zH1f5snKpQa9Et/y0hnJB8TxHzBzCWfQrB8DD9ZxBu7EMNUjLL++BEHH0apXEhqOTVB/
	 ipvLj5uF9kH8OnLU4vbaeVSEo/mJhqYYXDC6rKHipVlNdlKoGPnVb7PtKz/cXfBsA49jz
	 VINB1VM8gY2QER55QEM+5oOfaBUacwdaPVBUXChkFXtVIG2CEOS0Q+18uBcIQAfxEsWDK
	 9PL1m/8FEOdwCZH1eZl7UVIf3YAthxmdJJk4tCE9z62cHM7dWMt+nnLfPasbqj/D219RR
	 wPSe+Bk4pkfepagkXJQ05hkMHDd2llJbD8EN10vLDHZk+G3MSKrEjXA0a6wUzfIGJRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="qy/zmhcT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC66606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qy/zmhcT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3691F000C6;
	Wed, 25 Nov 2026 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610804;
	bh=KY4ManuWMmkk04wPFsSFRr2IT16RZ+zso9zoSZCarrI=;
	h=Subject:To:Cc:From:Date;
	b=qy/zmhcToE001DK1emLQoL2z9HLgwTXZBY0/lQPe0LQtDmpC7SnmAEPaUwOiD30HV
	 H6KxqmtRGvNlrHOXZvDdWXsaGQ8JXBtcWD0+nTn5pOdJDAeVzyk4vj10br88//CJZQ
	 tw8oQn8JQz9g8F6rp2KcEHhUJWW690JiHD9SMMyw=
Subject: FAILED: patch "[PATCH] iio: temperature: hid-sensor-temperature: Use per-instance" failed to apply to 6.6-stable tree
To: ch@murgatroid.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:50 +0100
Message-ID: <2026112550-kindly-shone-5215@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 36eeb26031e90eeb81bbac3d3acad61d23fcbdf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112550-kindly-shone-5215@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36eeb26031e90eeb81bbac3d3acad61d23fcbdf3 Mon Sep 17 00:00:00 2001
From: Christopher Hoover <ch@murgatroid.com>
Date: Sun, 18 Oct 2026 19:34:19 -0700
Subject: [PATCH] iio: temperature: hid-sensor-temperature: Use per-instance
 callbacks

hid-sensor-temperature keeps a single static struct
hid_sensor_hub_callbacks for all instances and overwrites its pdev in
every probe.  With two temperature sensors, input reports for one are
delivered with the other's platform device; once that device is
removed, platform_get_drvdata() returns NULL and
temperature_capture_sample() dereferences it:

  BUG: kernel NULL pointer dereference, address: 00000000000003a8
  RIP: 0010:temperature_capture_sample+0xd/0x50 [hid_sensor_temperature]

The oops happens in sensor_hub_raw_event() with the hub's spinlock
held, so the hub's removal then hangs.  It reproduces with two uhid
devices that each declare a temperature sensor, one destroyed while
the other still sends input reports.

Keep the callbacks in struct temperature_state, as the other HID
sensor drivers (accel, gyro, als, ...) do.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 5e3262e461f4..ae67daff6df5 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -15,6 +15,7 @@
 struct temperature_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info temperature_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 temperature_data;
 		aligned_s64 timestamp;
@@ -181,11 +182,6 @@ static int temperature_parse_report(struct platform_device *pdev,
 	return ret;
 }
 
-static struct hid_sensor_hub_callbacks temperature_callbacks = {
-	.send_event = &temperature_proc_event,
-	.capture_sample = &temperature_capture_sample,
-};
-
 /* Function to initialize the processing for usage id */
 static int hid_temperature_probe(struct platform_device *pdev)
 {
@@ -237,9 +233,13 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	temperature_callbacks.pdev = pdev;
+	temp_st->callbacks = (struct hid_sensor_hub_callbacks) {
+		.send_event = temperature_proc_event,
+		.capture_sample = temperature_capture_sample,
+		.pdev = pdev,
+	};
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE,
-					   &temperature_callbacks);
+					   &temp_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 

