Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610813;
	b=0n1bNa17sIk12Qy000rOvMiXcwllINK17AXIZTGzie3fr4gZEjp8rqshiqG4C0NrlB3B
	 E+wC/xWpYQinYrvekKg7HIk3HIelBfK5Rv86JCZirGRv7uOKVPqTHFA69LfDyUxI/cqOf
	 uPWoL8+7MzhYKOo52nXPisJJaRMnYfwT++DJp9x/XOj/8JZ5nSdnmp+2uNaZtVrr7lJV2
	 4l+nl1aWavZOxwZfUcw1SGYgXoD2D31lTWAcEG3YYxJZn31/eJ3Dme4IP7QOHcJ3s11Qr
	 9298SMblGr0e5WG1lF90UXdisBS3ThDRDpdxtPcPjflt+sT3B3mFs6ID1pp9pgjgXmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610813;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3/1EX1pmuuxZJ0tpzgdf0bNfwrSREFP/Dr4qb7QfSVg=;
	b=jTvR4Cxxss61jzf6vPl07gO2niL1xnrRixZ679iy0qGu5eI4RXjHQYslLexN/XrxVaDD
	 ztl7jZE1Nal0NI48UThzra6qF6jM6DlTPqbl4dEDtBkqemBmTiZFGKhjiK02sIKQHjA5Q
	 W67XfmH3weiwmY6KkKkztAXcLZgVVMSJ3mImhx4oBuwuqk3W3696EXRO8xtnlhBjn34FJ
	 UAU52yiLEROmIimNnSF6qh6bwqBRB2soDophQuG6VUGXuXHAAhIbJYVPS9o7WfKbG7IiJ
	 Ohu5HS+aZdG0HC9beuZf6wUKSIOoX2/77iTPIr9OAaZGd+cSclTWtu3MsZ0WIa95Xkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zyZhE986;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C65606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zyZhE986
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EEF1F000C0;
	Wed, 25 Nov 2026 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610812;
	bh=3/1EX1pmuuxZJ0tpzgdf0bNfwrSREFP/Dr4qb7QfSVg=;
	h=Subject:To:Cc:From:Date;
	b=zyZhE986OgQWw0QIOrkyt5f0E3gOJQxhJurN2qBfH7W4Bd6xoa/nMVJ5suV/ZWl2L
	 3cKdH63y+E+zYIorjBcPy5RBmD+oX5Kxf4HjKV1DMaDwiciy+XKY06kOMV0bZ/+MWZ
	 zMDldPyl3Aielt7UZx3e4AJYzx3PzsOAPtc+nwHc=
Subject: FAILED: patch "[PATCH] iio: temperature: hid-sensor-temperature: Use per-instance" failed to apply to 6.1-stable tree
To: ch@murgatroid.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:44:51 +0100
Message-ID: <2026112551-dawdler-operator-d4db@gregkh>
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
git cherry-pick -x 36eeb26031e90eeb81bbac3d3acad61d23fcbdf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112551-dawdler-operator-d4db@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

