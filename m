Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805447010E
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663762; cv=none; b=b8ogbnzFqwIkkGz/T4h/iZLdvifNgvVP3khGraEYP0ApsYdJEabuMEie1PiH1p5L1pYMk8ovmyUx+UkjlKe4WIhEW0p+VcLo3zeXQwqa+DEvVcqHAiRTp3SbcDsxw3ps8DvnxsBynyW3DJPMeRpkJnH6ZROwpMvy/qkvv0btd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663762; c=relaxed/simple;
	bh=OPdmzTjbrdnQzHeNNlq0982esusLfwX+xZhhpi+hA1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YAY72irRtahK4T4YMJh5/wWcqBOXxq9gyEu9jebW5sPo0nn0OFLFY+lqm7WldNAvDlwxLoFmkRJ/iMMGzlmgbcMnSe4g61+wifH+C2JiYbOwcIQoxlDy7gZrhW41iFTEDT1Q0evfNRcXSkuYohfk3Ghb8SYGxj0siGw14zorz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W2dJUsyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W2dJUsyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F2F1F000E9;
	Tue, 25 Aug 2026 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663760;
	bh=OcKmMxyfrEypXx+dcxED1hTcaSzI3S43JDZZu0Yj9N8=;
	h=Subject:To:Cc:From:Date;
	b=W2dJUsyUpqkt+CpwRoI1jHN9BwvH1vLY6rwuDeYK0oZTUBEzI1Rt5IBxGf2uVNNhi
	 HbZoLsxTc19SRsjimbIZuOFyYVxJeE3fxDc/ZOn2sIjQRKSWPUaSej3gPTCxhYxhKq
	 ryOeeyoYptEHTbBqfE1kfKF1eTb9PzCk/hgvBuTc=
Subject: FAILED: patch "[PATCH] HID: ft260: fix stack-use-after-return write in I2C read race" failed to apply to 5.15-stable tree
To: kernel-linux-20260610-80b7ab08@raman.v1.sg,jkosina@suse.com,michael.zaidman@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:15:38 +0200
Message-ID: <2026082538-obstacle-cogwheel-cfc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x bf3e39df3a397fd82967a31d17c4e02c7feab221
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082538-obstacle-cogwheel-cfc1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf3e39df3a397fd82967a31d17c4e02c7feab221 Mon Sep 17 00:00:00 2001
From: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
Date: Wed, 10 Jun 2026 22:29:52 +0800
Subject: [PATCH] HID: ft260: fix stack-use-after-return write in I2C read race

ft260_i2c_read() points dev->read_buf at a caller-supplied buffer
(often an on-stack variable), arms a completion and waits up to five
seconds for the device to return the data. The HID input callback
ft260_raw_event() runs in the input/IRQ path, independent of the
dev->lock mutex held by the read path, and copies the device-supplied
payload into dev->read_buf after a plain NULL check.

These two paths share read_buf, read_idx and read_len with no
serialization. If the device delays its response until the read
times out, ft260_i2c_read() resets the controller, clears read_buf
and returns, unwinding the stack frame the buffer lived in. A
response that arrives at that moment lets ft260_raw_event() pass the
NULL check and then memcpy() the device-controlled payload into the
now-freed stack location, a bounded but attacker-influenced
stack-use-after-return write triggerable by malicious or
malfunctioning hardware.

Add a dedicated spinlock that serializes every access to read_buf,
read_idx and read_len. ft260_raw_event() now holds it across the
NULL check, the memcpy and the index update, while the read path
takes it when arming and when clearing the buffer, so the teardown
can no longer slip between the check and the copy.

Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
Reviewed-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 946ed0c6fc39..64c9c940db46 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -240,6 +240,8 @@ struct ft260_device {
 	struct mutex lock;
 	u8 write_buf[FT260_REPORT_MAX_LENGTH];
 	unsigned long need_wakeup_at;
+	/* Protects read_buf, read_idx and read_len against ft260_raw_event() */
+	spinlock_t read_lock;
 	u8 *read_buf;
 	u16 read_idx;
 	u16 read_len;
@@ -501,6 +503,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	int timeout, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
+	unsigned long irqflags;
 	u8 bus_busy = 0;
 	/*
 	 * STOP terminates the last chunk; clear means hold the bus so a
@@ -534,9 +537,11 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 		reinit_completion(&dev->wait);
 
+		spin_lock_irqsave(&dev->read_lock, irqflags);
 		dev->read_idx = 0;
 		dev->read_buf = data;
 		dev->read_len = rd_len;
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 		ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
 		if (ret < 0) {
@@ -551,7 +556,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			goto ft260_i2c_read_exit;
 		}
 
+		spin_lock_irqsave(&dev->read_lock, irqflags);
 		dev->read_buf = NULL;
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 		if (flag & FT260_FLAG_STOP)
 			bus_busy = FT260_I2C_STATUS_BUS_BUSY;
@@ -570,7 +577,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	} while (len > 0);
 
 ft260_i2c_read_exit:
+	spin_lock_irqsave(&dev->read_lock, irqflags);
 	dev->read_buf = NULL;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
 	return ret;
 }
 
@@ -1053,6 +1062,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 "FT260 usb-i2c bridge");
 
 	mutex_init(&dev->lock);
+	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
 	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
@@ -1102,6 +1112,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
+	unsigned long irqflags;
 
 	if (size < offsetof(struct ft260_i2c_input_report, data)) {
 		hid_err(hdev, "short report %d\n", size);
@@ -1110,6 +1121,8 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
+		bool complete_read;
+
 		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
 			  xfer->report, xfer->length, size);
 
@@ -1120,8 +1133,15 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			return -1;
 		}
 
+		/*
+		 * Hold read_lock so a timed-out ft260_i2c_read() cannot
+		 * clear read_buf between the NULL check and the memcpy.
+		 */
+		spin_lock_irqsave(&dev->read_lock, irqflags);
+
 		if ((dev->read_buf == NULL) ||
 		    (xfer->length > dev->read_len - dev->read_idx)) {
+			spin_unlock_irqrestore(&dev->read_lock, irqflags);
 			hid_err(hdev, "unexpected report %#02x, length %d\n",
 				xfer->report, xfer->length);
 			return -1;
@@ -1130,8 +1150,11 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
 		       xfer->length);
 		dev->read_idx += xfer->length;
+		complete_read = dev->read_idx == dev->read_len;
 
-		if (dev->read_idx == dev->read_len)
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
+
+		if (complete_read)
 			complete(&dev->wait);
 
 	} else {

