Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB941B8EB
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757898; cv=none; b=Q+8F61TzB2VpXO4XNFdmkSihdBmBiRkztK/fRGFXoGC2OmLpKRRNrmmpQzgPM8xBcYdIy2Ju2R3DhYBCkh+pwz4hrb22LNx5CdXw7Qccrwx2qO4V3/PvRtTO+8p6r9rfWteqs+O1eOrFOC8jsM+INBgfBFiBbvTVQtyuuuApUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757898; c=relaxed/simple;
	bh=+9MqKtzkf2i4VXYCyXbCZQ3W/j6Vif18fYxZFe01zrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AO4cVlD9FwqcjD48B0KYzigjfaByzeDYZGacvlEanBv9oZJFgZuJFnXmpjydSd0t2FWVJA4lhWD5CaNKhMM40iuAhuQu6rPAi9q5BLC6Fn08tLfn3MeQvdQrBsac1Ju+NXWZ2lz50JavxrmCKH3tqo+LJUjUN2aspej1b2xiGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMLwwdEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMLwwdEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E871F00A3D;
	Wed, 26 Aug 2026 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757896;
	bh=8acED0/qv3VzJoiH0dssI0SwgRKlax8isT5WVn9dXEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eMLwwdEJrEzPH7kmS/Y73UStRTDJ1RMhlkWSgZ5XxZGFux3yxChYn1/OVWil2jKPa
	 b3OovoGWSISEkqxBSnBeQZPe0dA1CdRAXbOZ1MazTqLLuW4xHfsQ9bGoMV+nC39MXI
	 AVQGOb05no1V/nzAPofNaZkRUVoG7fjqZi89bjrq/CKNC58whdXBqOrV82xfrOaQgE
	 +fS1p0kX5CxWBFfRMCoB3DJproRtxrZjabFf0Y0iXMuseiGevRvuoi7UHiyrsjgx8E
	 cJakroo6AOKoYyENRX05S/dq5f7jj3su047E03fc9OsnZfFAc8XH+gO+YzqLBfDoqK
	 UxCTHCmLLicAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] HID: ft260: fix stack-use-after-return write in I2C read race
Date: Wed, 26 Aug 2026 11:24:52 -0400
Message-ID: <20260826152452.1119137-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826152452.1119137-1-sashal@kernel.org>
References: <2026082536-gutless-jailbird-051e@gregkh>
 <20260826152452.1119137-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 70e2eedb465af..f479459544aee 100644
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
 
 	if ((flag & FT260_FLAG_START_REPEATED) == FT260_FLAG_START_REPEATED)
@@ -526,9 +529,11 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 		reinit_completion(&dev->wait);
 
+		spin_lock_irqsave(&dev->read_lock, irqflags);
 		dev->read_idx = 0;
 		dev->read_buf = data;
 		dev->read_len = rd_len;
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 		ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
 		if (ret < 0) {
@@ -543,7 +548,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			goto ft260_i2c_read_exit;
 		}
 
+		spin_lock_irqsave(&dev->read_lock, irqflags);
 		dev->read_buf = NULL;
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 		if (flag & FT260_FLAG_STOP)
 			bus_busy = FT260_I2C_STATUS_BUS_BUSY;
@@ -562,7 +569,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	} while (len > 0);
 
 ft260_i2c_read_exit:
+	spin_lock_irqsave(&dev->read_lock, irqflags);
 	dev->read_buf = NULL;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
 	return ret;
 }
 
@@ -1018,6 +1027,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 "FT260 usb-i2c bridge");
 
 	mutex_init(&dev->lock);
+	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
 	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
@@ -1067,6 +1077,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
+	unsigned long irqflags;
 
 	if (size < offsetof(struct ft260_i2c_input_report, data)) {
 		hid_err(hdev, "short report %d\n", size);
@@ -1075,6 +1086,8 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
+		bool complete_read;
+
 		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
 			  xfer->report, xfer->length, size);
 
@@ -1085,8 +1098,15 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -1095,8 +1115,11 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
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

