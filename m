Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C5468C2F
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766510; cv=none; b=N9KPbgYTioGzrsFYJ6sLONCfTORSgWRWnwVa/9p1z4YOGvVAITN0EzGnij75tMHy12cdfrA7xFsMZQRj1RN6Xgoy3hHo9/nrcvDlfVq+/IDCDkUSrWT6FODruuedUSjBlDj3D2GkzyqtDMyELVLqRIrNcIaADEJnSZCYcvoIFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766510; c=relaxed/simple;
	bh=dWudcGZJ5gVPRjuyN1g/DtnOw5AMT3VayYFaTqg8T+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihh7vs//DbqJU5eDX0LPMtbBt2b5ImHmlswprNRk4OpAEXHfyX4U2Wt0PpwvF/e/rJxZaWKMAdA/gdEbZ14fAIBC+c5RMSbgag+CMzKCqk3coEAj9KXTWiZfZ2Gz08wxTqjt3IPSjGx8gFE3BY8ivoIo8FGFBT09rzvyAfsBrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbs9N77z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbs9N77z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5BD1F00ADE;
	Wed, 26 Aug 2026 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766493;
	bh=eW7mU65si6RDcXBzUaFnykfX6LHd6mEIyk0FQxg81Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbs9N77zcwKbNZzq4TKuPovy4BgFRw59ekKFKCmQpbtDymnbuQ9Um2xHqyu1kgq83
	 TMWsJmqp7G1+M4vZRYUhhCBh06W/UyvoN6ipQfkHGlPtJK8NOA0XOPy4+TjcgbykB9
	 oQmRre1ykqgROHsnTf6PXF0fL+/9Q5mQkavASCFUxfEv6QETF5YRu2S0VL/ehCRAOS
	 xlvB9etd31L10GHHXjEIdyZHXrDEUCApBLDj+dttwiMgsX7CDHjyKt62xdViLgNhvI
	 8FRRrK0FfX4cu90vnitlglOzegoq2A/Hxgh2tLkjAZIcVJejjIkjQ/WPqISXt129mK
	 euvvXPQJpD/aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/7] HID: ft260: missed NACK from busy device
Date: Wed, 26 Aug 2026 13:48:06 -0400
Message-ID: <20260826174808.2489782-5-sashal@kernel.org>
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
 drivers/hid/hid-ft260.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 3c4ca0016659b..30d7f014df05c 100644
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
@@ -487,6 +500,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 {
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
+	u8 bus_busy = 0;
 	int timeout;
 	int ret = 0;
 
@@ -525,7 +539,10 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 	dev->read_buf = NULL;
 
-	ret = ft260_xfer_status(dev);
+	if (flag & FT260_FLAG_STOP)
+		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+
+	ret = ft260_xfer_status(dev, bus_busy);
 	if (ret < 0) {
 		ret = -EIO;
 		ft260_i2c_reset(hdev);
@@ -1004,7 +1021,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mutex_init(&dev->lock);
 	init_completion(&dev->wait);
 
-	ret = ft260_xfer_status(dev);
+	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
 	if (ret)
 		ft260_i2c_reset(hdev);
 
-- 
2.53.0

