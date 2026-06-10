Received: from mail.raman.v1.sg (mail.raman.v1.sg [5.223.73.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606233F36B;
	Wed, 10 Jun 2026 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.223.73.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101812; cv=none; b=de6Z2bMQgERvSg2Ae0wRyGQpizOi+mT4pNYL4Cf0Fdb8N0HBt8HsE74hW+HyS8z6Qo59q/9t9sgH1UXYIU5HBM53n+xA3V3+ko6nV0IIJJUByozKLrsNf5UN+PBKRv4vc6jrrRulr4Isal7l6y14luAhKXrDHXd7LA2i3CdmXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101812; c=relaxed/simple;
	bh=kHsfSW0aDsYxa1RyPM6D5JXiMJ37O0DA8FuT3YrIAKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l25mbv7Uq4XHvnGjSB85cyV+4MPyCAVHRlPZtFfvg9yIdPxhd23jJUtTxx9siRHH5KsUjdkuEw20UyqGjHHTXxY4fz8zNSxPXuC6uBB7G7QDKC8d4KPDDMHS0Zyd5M7eFT545w9AxRV2ellMxUrycQpKCXpq6E2NzHza7c2ZL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raman.v1.sg; spf=pass smtp.mailfrom=raman.v1.sg; dkim=pass (2048-bit key) header.d=raman.v1.sg header.i=@raman.v1.sg header.b=JFcdjPt1; arc=none smtp.client-ip=5.223.73.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raman.v1.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raman.v1.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raman.v1.sg header.i=@raman.v1.sg header.b="JFcdjPt1"
DKIM-Signature: a=rsa-sha256; bh=cslNbBHuPP0M+4Sy7JBIv85F6PWj9XMqbK/ctJTaeb8=;
 c=relaxed/relaxed; d=raman.v1.sg;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@raman.v1.sg; s=default; t=1781101802; v=1; x=1781533802;
 b=JFcdjPt1h+Sr/8cQ6uz1bKOl8jGFdeROYN1/z0MNMr3Ns522m3G+/cyxtZxoZZzHY9MgJvC7
 n5ANfhddm7nN2KuL7fjVY7k/MuJS30ZVxh+oVEYqbfSF46RFsyK4cJyajjcJyWvwUxZMtnvf5KL
 1CLOtMmEyO0kJAuN68Q75ufKfBX+AoYssGjoc6ykZ+1wDv2x2MKnpgbeYXhE6N0XM5pcQaRJwdk
 UEdUy54wdWS2OiuAIAiaZNnS1yqKBAShRHY9DLkA1Gn1CRMQCfBwTgkd9yZAG9Ym7kBbyWW1xWk
 wbeqfWRePhsFj7OzMIe2j49VRCdTrqpMUuZWsaYS3TnNQ==
Received: from cyberarch.tail8ae6a2.ts.net (localhost [127.0.0.1]) by
 mail.raman.v1.sg (envelope-sender
 <kernel-linux-20260610-80b7ab08@raman.v1.sg>) with ESMTP id 69cbe6f3; Wed,
 10 Jun 2026 14:30:02 +0000
From: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
To: michael.zaidman@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	stable@vger.kernel.org
Subject: [PATCH] HID: ft260: fix stack-use-after-return write in I2C read race
Date: Wed, 10 Jun 2026 22:29:52 +0800
Message-ID: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/hid/hid-ft260.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 70e2eedb4..f47945954 100644
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
2.54.0

