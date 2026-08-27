Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764D2F747A
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805614; cv=none; b=HSIPypTg1orC6auQ4W302gAeEm03vYA6M68nrImJ6CbXSpCNxqRcpBQtr0huLZ7dx+EUN2LaYlFd9iIxRwloLwltOr5TfFkVl6Vj+2otm9QDKfKKvkC3e8wObjMU+s+8tzj1k1ny/4QMozrgNP0HRaikLyrpOYJ0JRNebgliy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805614; c=relaxed/simple;
	bh=7U3lnMJTh7kwzGVpipqn88ywnyRo8O+bzOz3x5HCjtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R08ozHZXlNUKEWyOcj+lekF8LkF6R+3PGiVT+3xajxGVNBzRlVJyPSEyaAudYg9wLwoT+DBJFnAPOGLuOr0kS8QZwvN9a3QvdMfx7WTwIKL0wTHIvqz7lciNotZy7sZ8m3AcubXRBSrAd7m8PIdpdYsDPaVnX1tw/7Gd0BMYGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnQAUISl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnQAUISl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1581F00A3F;
	Thu, 27 Aug 2026 04:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805613;
	bh=K/0pRm0DJFSZDBw90mGz7P6alGvWOh6+DhIDiK93qW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nnQAUISlYflHJE6/sOeiCfqe1AkP8LzoRRWRz0kOlLjGsvbbaloEAqlLIrpRyeI0c
	 7JXEphe5wVrfgAMyGCv5DHDmq1/OHjNfX+jNB4s6M6+KMLpfvXBpXa0Z7FbKqedwW8
	 gPuGBTDhn2VUcK79WltqNqSQ/aUgZ9aRvASsfIj3O8COkUL2K6mDz7QoHTkBEAKoDX
	 soPgp/S91YS+/nCIzEJC+lfceo0W0KaOIWb4BX4FTByjo68CayTr4cPRQe5QyDaE1k
	 TIrLDbsqOxcO6dMF/XJYzsYnnnrpakS27pbE99sZ8D+PgrTawEJ1mb+lAoqILICafA
	 QwGvHFxRapZWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/8] HID: ft260: missed NACK from busy device
Date: Thu, 27 Aug 2026 00:40:04 -0400
Message-ID: <20260827044007.3635916-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827044007.3635916-1-sashal@kernel.org>
References: <2026082538-obstacle-cogwheel-cfc1@gregkh>
 <20260827044007.3635916-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Zaidman <michael.zaidman@gmail.com>

[ Upstream commit 5afac727defa0b2a3dffb2abd5fb5f594b98d217 ]

When writing into a slow device like an EEPROM chip, the
controller may exit the busy state before the device releases
the bus. In this case, the ft260_xfer_status returns success
before the data transfer completion.

The patch fixes it by returning from the ft260_xfer_status()
with the "-EAGAIN" on both controller and bus busy status when
appropriate.

It does not apply to the i2c combined transactions when after
the write IO, the controller keeps the bus busy until the read
IO and then between reading IOs to ensure an atomic operation.

Co-developed-by: Germain Hebert <germain.hebert@ca.abb.com>
Signed-off-by: Germain Hebert <germain.hebert@ca.abb.com>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: bf3e39df3a39 ("HID: ft260: fix stack-use-after-return write in I2C read race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index d3c33c1b130c9..58dacc271a7f1 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -303,7 +303,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	return ret;
 }
 
-static int ft260_xfer_status(struct ft260_device *dev)
+static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 {
 	struct hid_device *hdev = dev->hdev;
 	struct ft260_get_i2c_status_report report;
@@ -334,7 +334,7 @@ static int ft260_xfer_status(struct ft260_device *dev)
 	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
 		  dev->clock);
 
-	if (report.bus_status & FT260_I2C_STATUS_CTRL_BUSY)
+	if (report.bus_status & (FT260_I2C_STATUS_CTRL_BUSY | bus_busy))
 		return -EAGAIN;
 
 	if (report.bus_status & FT260_I2C_STATUS_BUS_BUSY)
@@ -379,8 +379,11 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 						u8 *data, int len)
 {
+	u8 bus_busy;
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
+	struct ft260_i2c_write_request_report *rep =
+		(struct ft260_i2c_write_request_report *)data;
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
@@ -398,8 +401,18 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		ft260_dbg("wait %d usec, len %d\n", usec, len);
 	}
 
+	/*
+	 * Do not check the busy bit for combined transactions
+	 * since the controller keeps the bus busy between writing
+	 * and reading IOs to ensure an atomic operation.
+	 */
+	if (rep->flag == FT260_FLAG_START)
+		bus_busy = 0;
+	else
+		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+
 	do {
-		ret = ft260_xfer_status(dev);
+		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret != -EAGAIN)
 			break;
 	} while (--try);
@@ -485,10 +498,10 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			  u16 len, u8 flag)
 {
+	int timeout, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
-	int timeout;
-	int ret = 0;
+	u8 bus_busy = 0;
 
 	if (len > FT260_RD_DATA_MAX) {
 		hid_err(hdev, "%s: unsupported rd len: %d\n", __func__, len);
@@ -525,7 +538,10 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 	dev->read_buf = NULL;
 
-	ret = ft260_xfer_status(dev);
+	if (flag & FT260_FLAG_STOP)
+		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+
+	ret = ft260_xfer_status(dev, bus_busy);
 	if (ret < 0) {
 		ret = -EIO;
 		ft260_i2c_reset(hdev);
@@ -1004,7 +1020,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mutex_init(&dev->lock);
 	init_completion(&dev->wait);
 
-	ret = ft260_xfer_status(dev);
+	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
 	if (ret)
 		ft260_i2c_reset(hdev);
 
-- 
2.53.0

