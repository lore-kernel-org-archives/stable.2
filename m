Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA084468C38
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766512; cv=none; b=NXwdRNVTfOIF/S1esK34IM0Skt9XFS5lqwRV+eLqKKtolY1CKojulMA+dZhjVz/D0xkYf5S2CwsEGzAWIz/myXr47vFRfb8sZPt8KCkRQKeCgVnrOru3mGbjsyHL+nTt+XE5gtN3YKEmbCXhTX9gMLdM1Hg/jcxmjOk6QAFdLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766512; c=relaxed/simple;
	bh=ZZcWR+dvTRt9Xquqe3xQ7Ucagmk9rnUBwueHhGn8+ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxxDY2+Os/i4BG4utr+YoC+1yEgfh1NqEVNMqCx4/34Ij87F+8lEqUMP9SiKwlIrr4Hi/fnZNwJXp1GoGcHkMte2OT/gEHe2HngOiEyvv1Bl7l3SfKIGsutgyhMsMHp7C/a0Sx7VDADR4fbdya2w5xUEQ3veIeCGRsGe/HiH424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlCdMkAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlCdMkAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2BF1F00A3E;
	Wed, 26 Aug 2026 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766495;
	bh=zx6XYOxpoGEebO77IuyFS5ra2ZanTXFp0s2aMIOlKHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlCdMkAjOGzbq/XG6+V7qCNEwidm52Lrpkr+JPZrEfjm8bFtAPYBWFrBREeK+eWWR
	 Pg4sUP0VK7EITIkDC8/TvbD6YyUt6+WF8p0HcEI1h7HHRsrkjtvFbjj6O4cdnVlsd1
	 wigKL240U8EONqzpw9f+mbiKde0vxkvi041fI6+U/JeyiR5irLHIqaA51+wk5STH0V
	 AMm4pnfzH3Wl3ZruwLqEzkMxQyjSWqzr5yzjUB+0722a5Tog4YMKYAcV5NKb1SqVc8
	 +iDmAmeP9+CS18wwAuPfFVymFs6a4JPOhKxTuohW2GrPbqIO49ioG0Cl/LypwqfiVS
	 SF1ZfxUcGpDJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 7/7] HID: ft260: fix stack-use-after-return write in I2C read race
Date: Wed, 26 Aug 2026 13:48:08 -0400
Message-ID: <20260826174808.2489782-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174808.2489782-1-sashal@kernel.org>
References: <2026082538-overhaul-surging-7a4a@gregkh>
 <20260826174808.2489782-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>

[ Upstream commit bf3e39df3a397fd82967a31d17c4e02c7feab221 ]

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
[ adapted per-iteration locking to the flat single-shot `ft260_i2c_read()` body (no chunking loop), dropping one indentation level. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 2b8db682fa4a9..c9e5e65fa032c 100644
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
@@ -500,6 +502,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 {
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
+	unsigned long irqflags;
 	u8 bus_busy = 0;
 	int timeout;
 	int ret = 0;
@@ -519,9 +522,11 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 	reinit_completion(&dev->wait);
 
+	spin_lock_irqsave(&dev->read_lock, irqflags);
 	dev->read_idx = 0;
 	dev->read_buf = data;
 	dev->read_len = len;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 	ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
 	if (ret < 0) {
@@ -537,7 +542,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		goto ft260_i2c_read_exit;
 	}
 
+	spin_lock_irqsave(&dev->read_lock, irqflags);
 	dev->read_buf = NULL;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 	if (flag & FT260_FLAG_STOP)
 		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
@@ -550,7 +557,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	}
 
 ft260_i2c_read_exit:
+	spin_lock_irqsave(&dev->read_lock, irqflags);
 	dev->read_buf = NULL;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
 	return ret;
 }
 
@@ -1019,6 +1028,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 ((struct hidraw *)hdev->hidraw)->minor);
 
 	mutex_init(&dev->lock);
+	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
 	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
@@ -1068,6 +1078,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
+	unsigned long irqflags;
 
 	if (size < offsetof(struct ft260_i2c_input_report, data)) {
 		hid_err(hdev, "short report %d\n", size);
@@ -1076,6 +1087,8 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
+		bool complete_read;
+
 		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
 			  xfer->report, xfer->length, size);
 
@@ -1086,8 +1099,15 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -1096,8 +1116,11 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
 		       xfer->length);
 		dev->read_idx += xfer->length;
+		complete_read = dev->read_idx == dev->read_len;
+
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
-		if (dev->read_idx == dev->read_len)
+		if (complete_read)
 			complete(&dev->wait);
 
 	} else {
-- 
2.53.0

