Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609445;
	b=G0hvo+CFXbOfPAOrvfOspQp/c877XNmbYTl8y2M/wu3Dj1VD16gm3PCvtyVDwLSq6JaD
	 ZHur/Tp/uWt4iiWrgnwBbb3BgMhg2eZBybGiorPeDcoDshjmVzPmdLLx3NiYflfcnNntd
	 bcB8TpsIf6hreGNn9ZJG1ewviCZb67q+Tr0U63r6spoLzCfaGJCOfE6XHD+/Aw5PYfb5x
	 9KSNdw6dAjXMLuJwgBoQMBW+ZRn8nirvz657uWELA00u/M/hjyCAU1s/dBkwdsx85RJCW
	 8zKbF9qUYVulCQKsEvapRHkUkA0ZpnQL2oPS2GLQPgB9e5nMairvRhrURlMAdbuyBZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609445;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5H65TxuiZTFTEeJcJTsmhXMI+9TT4XFEjSNxU4bCL+0=;
	b=ReQ6dNK7RC2C440e9x5+Ng82AG9uXUcM0PtvjSi4X+QZBOOSsIN5BHBk92uedFWdSD33
	 MNWajwavplZ8K3Hse1mBTmyoHYrDKU4pjFbnniR24LUdXQcVZFhruKh5Ug704St0oVdZP
	 56bPrAhrx7R877EMck43aJlJ3NG8iTFgPEleajpsSmr6ApTrubqVT6JY1+S4IkGWS96Px
	 PIOIfhF5gshj0kQ5p/nWUbWW3gPoIMKqiz4yJj3i72WvaLN2pfJLk2TgC06h7ZVzp/9dE
	 xXGJdNyeodyNwlYC03Ld4OxxtTbdHtOb9rRI5H46CbrRQ3SgcXrSfjqmGvQALZbWUcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qH9JdBYK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qH9JdBYK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B2F1F000C4;
	Wed, 25 Nov 2026 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609445;
	bh=5H65TxuiZTFTEeJcJTsmhXMI+9TT4XFEjSNxU4bCL+0=;
	h=Subject:To:Cc:From:Date;
	b=qH9JdBYKNT7H9K5Rr5nUCwhb5XmKBkDZKb4//V560uD9mj9+6d7Wguplo9vjxF7wP
	 YrRdt/jhLKVpT2J3YFYAD6oYJskdvapacs5NS4nx5WnGTDUxIgJF5tV1DtlZGHTEpb
	 YKAE9IAsoIvsviZQIijLfSUbrTHTAEpQzlR2yK6M=
Subject: FAILED: patch "[PATCH] iio: humidity: hid-sensor-humidity: Use per-instance" failed to apply to 6.1-stable tree
To: ch@murgatroid.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:21:45 +0100
Message-ID: <2026112545-squatter-grain-d525@gregkh>
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
git cherry-pick -x bbe4f3f668babc9443fc1f075695e43e17ca7976
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112545-squatter-grain-d525@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

