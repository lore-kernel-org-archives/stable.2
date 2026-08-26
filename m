Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D31456DE2
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766503; cv=none; b=H1j8Gkz6SCcDTNtiHBhXV6aQia3qKWWrNFqkKvxkdVdlTV64InsHaBN0yfTqGxW4hAQi6g4Z+1P4xXZDj9/Icdt9zxS0+SvEwfnjvTqaPZoVqA9S4nzS23HekqxyODifP5uFf/eg3o06o3bdSWc1x18HLCGqXO2aupPVqFliiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766503; c=relaxed/simple;
	bh=8stgrRqQC0e7dtHzpwFstcQKVDc+tw67CefjZZunPfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNa0ZMtGstii7dvjzRYyc+T0gKnnOIq+GHnR3dHCBcLiX6ptEhCCT2rmm/UhTTiObLKu87N78+US9uww0JfFiOjeDhpToCqbST7npKYnfSADi4XtTyHJPp8c5WQjnOEgCjHv0uG+0+NnpK8/sB4NSi+SuXJ67CpDVeIGDixUz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O17jL9pc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O17jL9pc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415621F00AC4;
	Wed, 26 Aug 2026 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766491;
	bh=2TwbUhh0+fpxySfrcGwGe2y6bWfsmy+Vs2afw2LIPRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O17jL9pcT93ZrWthXIRPdPUZPe1BAj5Hhe6wHe/XThz+nMUY3rqkGbLjBTXlwY6f6
	 cRDA526d0+9q2Y/YXLmUPCVsEVO1b0RnSkHXy6aKsOWBjoEPVDLhw4ryzAVoFM22wB
	 C/K3GXnuZv5Fkg0bEGlBF/H4cFRE+T/G19G5BdloiUT3CSl3wdXlapCXK4/bOSYdiN
	 H/BTT3GxvHKy5tsEtH1yIpS3Sw0bD8Tvhetl9En1vhcXISt41PJzbffUPtfs34i3Uy
	 mK62CZoaIvroSSQnCXWbkZEXvMMTJzpYzGWj+R/hdxBY1MKB/fXMj7j2oeJTebts7W
	 KIOJOcetKmmRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Enrik Berkhan <Enrik.Berkhan@inka.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] HID: ft260: skip unexpected HID input reports
Date: Wed, 26 Aug 2026 13:48:04 -0400
Message-ID: <20260826174808.2489782-3-sashal@kernel.org>
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

[ Upstream commit b7121e3c04440cc2af9cabbabb24efd23741294a ]

The FT260 is not supposed to generate unexpected HID reports. However,
in theory, the unsolicited HID Input reports can be issued by a specially
crafted malicious USB device masquerading as FT260 when the attacker has
physical access to the USB port. In this case, the read_buf pointer points
to the final data portion of the previous I2C Read transfer, and the memcpy
invoked in the ft260_raw_event() will try copying the content of the
unexpected report into the wrong location.

This commit sets the Read buffer pointer to NULL on the I2C Read
transaction completion and checks it in the ft260_raw_event() to detect
and skip the unsolicited Input report.

Reported-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: bf3e39df3a39 ("HID: ft260: fix stack-use-after-return write in I2C read race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 854876b16880d..4c6c7dfdd6a71 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -471,17 +471,13 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
 	int timeout;
-	int ret;
+	int ret = 0;
 
 	if (len > FT260_RD_DATA_MAX) {
 		hid_err(hdev, "%s: unsupported rd len: %d\n", __func__, len);
 		return -EINVAL;
 	}
 
-	dev->read_idx = 0;
-	dev->read_buf = data;
-	dev->read_len = len;
-
 	rep.report = FT260_I2C_READ_REQ;
 	rep.length = cpu_to_le16(len);
 	rep.address = addr;
@@ -492,25 +488,36 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 	reinit_completion(&dev->wait);
 
+	dev->read_idx = 0;
+	dev->read_buf = data;
+	dev->read_len = len;
+
 	ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
 	if (ret < 0) {
 		hid_err(hdev, "%s: failed to start transaction, ret %d\n",
 			__func__, ret);
-		return ret;
+		goto ft260_i2c_read_exit;
 	}
 
 	timeout = msecs_to_jiffies(5000);
 	if (!wait_for_completion_timeout(&dev->wait, timeout)) {
+		ret = -ETIMEDOUT;
 		ft260_i2c_reset(hdev);
-		return -ETIMEDOUT;
+		goto ft260_i2c_read_exit;
 	}
 
+	dev->read_buf = NULL;
+
 	ret = ft260_xfer_status(dev);
-	if (ret == 0)
-		return 0;
+	if (ret < 0) {
+		ret = -EIO;
+		ft260_i2c_reset(hdev);
+		goto ft260_i2c_read_exit;
+	}
 
-	ft260_i2c_reset(hdev);
-	return -EIO;
+ft260_i2c_read_exit:
+	dev->read_buf = NULL;
+	return ret;
 }
 
 /*
@@ -1033,6 +1040,13 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
 			  xfer->length);
 
+		if ((dev->read_buf == NULL) ||
+		    (xfer->length > dev->read_len - dev->read_idx)) {
+			hid_err(hdev, "unexpected report %#02x, length %d\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
+
 		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
 		       xfer->length);
 		dev->read_idx += xfer->length;
@@ -1041,10 +1055,9 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			complete(&dev->wait);
 
 	} else {
-		hid_err(hdev, "unknown report: %#02x\n", xfer->report);
-		return 0;
+		hid_err(hdev, "unhandled report %#02x\n", xfer->report);
 	}
-	return 1;
+	return 0;
 }
 
 static struct hid_driver ft260_driver = {
-- 
2.53.0

