Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98C3644C5;
	Sun, 11 Oct 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715178; cv=none; b=uLhYOfGCjEYDbPXTMd70+aeJlCx82pDVXzLtYPVJbFzh+sk1Pmm+dT9HbUCR5UYjeBTfEiLtZgyPZ/vIXgJAI0mi9nA59zWWucP5fJdd09xBbnH6RlXkPCs4gGnMiJ8CSO/JwmGvyIb/XktxLNtvDCxpPmDGPwX2615aRuRrctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715178; c=relaxed/simple;
	bh=dq2uRwaWaBCyZaA4A2Gdwx6/roF+o0ak4opGpKjb2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKWPmMiFXEfKr6onIjoqkCZ0yHWJLDUGDakQgmpvrQZ6vo4nF8A//EaUqskXsKSR8RWxfHV8hZHjhTm+J5gobQBy4zpU76D74rXP+cBmWNmzghb13uSuWDd5PQcv9EPIRvg9WYhvi7jPa35If6v2Yb2/uOgcWmCL0gpO6mkdYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdgEB6hY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdgEB6hY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFDE1F0089B;
	Sun, 11 Oct 2026 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715177;
	bh=ZL9KIMSdbV0EcIhr4EDGe+4L3wL6AbD7/c30rndewF4=;
	h=From:To:Cc:Subject:Date;
	b=fdgEB6hYMgRWPq4hMXWSzcQKIrs+p9t+YPECUC3l4kSFnjbcXUHF4Cq1nE4/rfPVk
	 VUKdaVxAbny1nUPPv6yhgP9c+zxh4wGjqIhMx6D7Cz+WAZQEzfEuAlWvPIh4CadmsD
	 rJtC+g6rvr862KIN8ZIGQFovsBFRaAOya7yir8jlMhxjGr6XLSTvxOMPJlmUdVa6R2
	 WhkToY2jgRpTHPR3IrctKPF82cMNqcKsm2BfOIMo5wPxzkLvMWpL8WxznRZ3aVS2tn
	 bqQH2BVOBTVGu0WDlB9p/s4MhqQLbm9IZb4hFf2m+FaxKfOyfXKykB4K0TQT7ASK1D
	 kgcQpxEND0GFw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	David Rheinsberg <david@readahead.eu>,
	Sasha Levin <sashal@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Kenny Levinsen <kl@kl.wtf>,
	Ai Chao <aichao@kylinos.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.6-v6.1 1/2] HID: core: introduce hid_safe_input_report()
Date: Sun, 11 Oct 2026 10:38:56 +0000
Message-ID: <20261011103900.2201441-1-lee@kernel.org>
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
      HID low level functions") is not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c             | 26 ++++++++++++++++++++++++--
 drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++++---
 drivers/hid/usbhid/hid-core.c      | 11 ++++++-----
 include/linux/hid.h                |  2 ++
 4 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 446ed394dc48..9981346d23aa 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2082,14 +2082,36 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  * @interrupt: distinguish between interrupt and control transfers
  *
  * This is data entry for lower layers.
+ * Legacy, please use hid_safe_input_report() instead.
  */
 int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data,
 		     u32 size, int interrupt)
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
+int hid_safe_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
 	struct hid_report *report;
-	size_t bufsize = size;
 	int ret = 0;
 
 	if (!hid)
@@ -2140,7 +2162,7 @@ int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data
 	up(&hid->driver_input_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hid_input_report);
+EXPORT_SYMBOL_GPL(hid_safe_input_report);
 
 bool hid_match_one_id(const struct hid_device *hdev,
 		      const struct hid_device_id *id)
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index b36284e2d5cb..1760f2693d31 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -544,9 +544,10 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		if (ihid->hid->group != HID_GROUP_RMI)
 			pm_wakeup_event(&ihid->client->dev, 0);
 
-		hid_input_report(ihid->hid, HID_INPUT_REPORT,
-				ihid->inbuf + sizeof(__le16),
-				ret_size - sizeof(__le16), 1);
+		hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
+				      ihid->inbuf + sizeof(__le16),
+				      ihid->bufsize - sizeof(__le16),
+				      ret_size - sizeof(__le16), 1);
 	}
 
 	return;
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 415d44ac1480..f8287774c697 100644
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
index f560ae891d7e..079fe5a304f0 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -976,6 +976,8 @@ extern void hidinput_disconnect(struct hid_device *);
 int hid_set_field(struct hid_field *, unsigned, __s32);
 int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
 		     int interrupt);
+int hid_safe_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
-- 
2.56.0.385.gd3acb90ef8-goog

