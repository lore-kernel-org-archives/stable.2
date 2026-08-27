Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B211DB95E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805613; cv=none; b=VWi1eI0DyyTd1ZIekVatoQZhsNdSpdd3G9sKi2Q7/S8azs0SY55TCxghiGOPV7NU+ABNjcW2t+E1Cv6itr0PvFwOyREugNZZ2b13UXqecBQ5miZX5jlugmlKDnSsiz/sXhxZ6mVb/BVx5oF0YBAO/Ola0BQ3Nu37P18koRBO0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805613; c=relaxed/simple;
	bh=DUGLZI8faqPhmDu++grlLR3snMkKLTneNz0K3wLHcGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvIPC4W+AJ7Sq40XyZrFB7e99gzzI85OtsQxEaoVs77/mkIDFR6DeHAFmIj54RRycCyg+jCR9SRKvSmrreRZSmW2PUSOU/FpBNoqo9xTpMzZ2xtzg3MIMYgZjJyfexhySGy0uxxVCEVINLVUvn0hMIMy2XT3oJkPOXC9kTDJF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsKMUNEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsKMUNEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C6D1F000E9;
	Thu, 27 Aug 2026 04:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805611;
	bh=jQ4u4GpMRD2ps1oxPn5u6CFaTc4OREu7YfjTHFY5pi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EsKMUNEYdvqpZJ47yMig6UYjfsAFqOTNKUfQv1BFBAUS0z57qx7PKpUa0lszu6+Ga
	 XyqJgdY8+KQ/+ixK2LItA92+VvTbZV7Eeh0IXvYZCDoXD8UnNMf/EX7W7uRh1i9D+0
	 ParhfoRiqayN6DBVb/aJsXcf2MNKOE1ZZnU5OJdaIppCSZ/QKrZr8stLTOYqQIlWY6
	 eBbGMRabSw+76h/KzZH/4atx3K7cALu8EcERxBKoXP41WY+9BKe2pCdLuq0azOY7Ty
	 bVxnlaU4oMbnsnPzWWeqgtSPjZTN5NBvr0/WhYn5mP4Hf4wIH8O7iZDlcSrWaGihbq
	 DlaS5TWYBxp4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Enrik Berkhan <Enrik.Berkhan@inka.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/8] HID: ft260: skip unexpected HID input reports
Date: Thu, 27 Aug 2026 00:40:02 -0400
Message-ID: <20260827044007.3635916-4-sashal@kernel.org>
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
 drivers/hid/hid-ft260.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 854876b16880d..6f6bfd305e229 100644
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
-- 
2.53.0

