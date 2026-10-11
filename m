Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2A37DEA1;
	Sun, 11 Oct 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715179; cv=none; b=GT+Wn0dOdhSCLQwi0WQkNbJlda68CfPjXuA3jf6IuOutCEy1N4obUdleq8n/QLATlvLTNYJc/zzyK+1/XSTM9e+z4sZcq29BZHpeCEOPmYQukAENqmBUX5c/4GXru9+TzvB9cwmZZ5KH5UfzLYoratOUAArXPM9KCuDTln3IHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715179; c=relaxed/simple;
	bh=cjTI91F3JFWsX2fUhuCc20zR8cNgJdW2uxBSX62m7YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOFXnTuVAEPt+phkImwU28M9V0mxjkmK8xjATWlZ9TJLakjj/Zc+fPkvrOZ2CYJkShvbRUGcb+m+am+SWA+UOKpvTfHUGFFKuG+XL46M9o2hSpkygJnE9/PVsjgat1eVV3gdAjiA7TxSaDAq/VYs1gx+JP2kDp9xsbFTBg4P0Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJQNJDTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJQNJDTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11571F0089C;
	Sun, 11 Oct 2026 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715177;
	bh=UVf5eO+/LLupPl5UJxyGE59loQOB2TZ5Bgr6UcDrPS0=;
	h=From:To:Cc:Subject:Date;
	b=QJQNJDTZepyc7PmFBurBue3YOWCBwFoqflTpL/mZYq1ReWwm+g2T+AQQvkVEsCePl
	 XC+G5tg2IHVIChQc0YSWnlPxRCUcTUAN7XIioNvXUGUv+BlGZbAika/jBRX0IU2eZr
	 4zB+4Mj7M1Z5LtZ9AHuol8uostw1Uir4lRnIeTA/4hLoQ27vNjF3y4ha6A0XvJfrZA
	 zO6iGjDHqD3XcRBZKV6CRwadl1eje7SNjoZcp/PUkfFkbf5nDMDlvggkOrHlWhke/3
	 OOVTt9WgCFjJXQlLY8MKG8QyNdRfm/oj1dyBVdZxfkL/Px4XedbPAwutcJhYirmJaq
	 y8ypv+qS0eJmA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	David Rheinsberg <david.rheinsberg@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ai Chao <aichao@kylinos.cn>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.15-v5.10 1/2] HID: core: introduce hid_safe_input_report()
Date: Sun, 11 Oct 2026 10:39:09 +0000
Message-ID: <20261011103912.2201634-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Tissoires <bentiss@kernel.org>

[ Upstream commit 206342541fc887ae919774a43942dc883161fece ]

hid_input_report() is used in too many places to have a commit that
doesn't cross subsystem borders. Instead of changing the API, introduce
a new one when things matters in the transport layers:
- usbhid
- i2chid

This effectively revert to the old behavior for those two transport
layers.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit a9527c32cc9d98252dc975d6fcb29f2013d0f63a)
[Lee: Implement hid_safe_input_report() directly and wrap it from
      hid_input_report() as 67eccf151d76 ("HID: add source argument to
      HID low level functions") is not present.  Use int for report type
      and literal 2 in i2c_hid_get_input() as 56fc4f7bc114 and
      1bdbe0dcff2f are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c             | 26 ++++++++++++++++++++++++--
 drivers/hid/i2c-hid/i2c-hid-core.c |  5 +++--
 drivers/hid/usbhid/hid-core.c      | 11 ++++++-----
 include/linux/hid.h                |  2 ++
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 783f55a259cd..b94106ae9b1c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1873,13 +1873,35 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  * @interrupt: distinguish between interrupt and control transfers
  *
  * This is data entry for lower layers.
+ * Legacy, please use hid_safe_input_report() instead.
  */
 int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int interrupt)
+{
+	return hid_safe_input_report(hid, type, data, size, size, interrupt);
+}
+EXPORT_SYMBOL_GPL(hid_input_report);
+
+/**
+ * hid_safe_input_report - report data from lower layer (usb, bt...)
+ *
+ * @hid: hid device
+ * @type: HID report type (HID_*_REPORT)
+ * @data: report contents
+ * @bufsize: allocated size of the data buffer
+ * @size: useful size of data parameter
+ * @interrupt: distinguish between interrupt and control transfers
+ *
+ * This is data entry for lower layers.
+ * Please use this function instead of the non safe version because we provide
+ * here the size of the buffer, allowing hid-core to make smarter decisions
+ * regarding the incoming buffer.
+ */
+int hid_safe_input_report(struct hid_device *hid, int type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
 	struct hid_report *report;
-	size_t bufsize = size;
 	int ret = 0;
 
 	if (!hid)
@@ -1924,7 +1946,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int i
 	up(&hid->driver_input_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hid_input_report);
+EXPORT_SYMBOL_GPL(hid_safe_input_report);
 
 bool hid_match_one_id(const struct hid_device *hdev,
 		      const struct hid_device_id *id)
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 6edfbfab55d3..93f7dfde6d29 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -518,8 +518,9 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 	i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
 
 	if (test_bit(I2C_HID_STARTED, &ihid->flags))
-		hid_input_report(ihid->hid, HID_INPUT_REPORT, ihid->inbuf + 2,
-				ret_size - 2, 1);
+		hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
+				      ihid->inbuf + 2, ihid->bufsize - 2,
+				      ret_size - 2, 1);
 
 	return;
 }
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b182b288991a..114aa5b6d396 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -281,9 +281,9 @@ static void hid_irq_in(struct urb *urb)
 			break;
 		usbhid_mark_busy(usbhid);
 		if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
-			hid_input_report(urb->context, HID_INPUT_REPORT,
-					 urb->transfer_buffer,
-					 urb->actual_length, 1);
+			hid_safe_input_report(urb->context, HID_INPUT_REPORT,
+					      urb->transfer_buffer, urb->transfer_buffer_length,
+					      urb->actual_length, 1);
 			/*
 			 * autosuspend refused while keys are pressed
 			 * because most keyboards don't wake up when
@@ -480,9 +480,10 @@ static void hid_ctrl(struct urb *urb)
 	switch (status) {
 	case 0:			/* success */
 		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
-			hid_input_report(urb->context,
+			hid_safe_input_report(urb->context,
 				usbhid->ctrl[usbhid->ctrltail].report->type,
-				urb->transfer_buffer, urb->actual_length, 0);
+				urb->transfer_buffer, urb->transfer_buffer_length,
+				urb->actual_length, 0);
 		break;
 	case -ESHUTDOWN:	/* unplug */
 		unplug = 1;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ab088e77742c..68ace4850ac9 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -937,6 +937,8 @@ extern void hidinput_disconnect(struct hid_device *);
 
 int hid_set_field(struct hid_field *, unsigned, __s32);
 int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
+int hid_safe_input_report(struct hid_device *hid, int type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt);
 int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
-- 
2.56.0.385.gd3acb90ef8-goog

