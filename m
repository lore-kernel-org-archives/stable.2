Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0F466AEF
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766513; cv=none; b=RI8Yt7ynG9scGfMNHFk6ccM9S3w38Om+JVwOPGx59Wp7X5xYPE8fSOXQc+2b+qZErlbetmAJdPgk66kasB2aqmLcu1De9EH44FHBRPDrcIZtVCaVF/Wk7fOuqEdjjCgnKtdgxIL3/vqP1pf8GK2iKOBt0VX3bjyPz1NABYarcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766513; c=relaxed/simple;
	bh=5bzhaob4bUvN5ZduRBTljGaASqDBgY4MjDFZ2XZ9FeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehRUQuTuGdsb167ASZ4t9Anw9CQbhvHo6038zjlihAYO5NV7fVr7lkKkuboZGZllbpF4tg0k4h5EbEPx8pwVcL0QREgEgWim8qq6vqMDC+0L13nfSLoJDz/U1Hcz4bDsrZ7IDPu0rL1moH2kXz5OdlbjOEi7RfeLpZ5nS2X7aeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYN9DCP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYN9DCP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB371F01559;
	Wed, 26 Aug 2026 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766494;
	bh=zm97+8ftTo1Lwx46+LkA50Zf8I5DXR/6avIpxpNElkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cYN9DCP+IwAFV2K+1Ov1zMUHX7z8bT3bLX3AOdRiSqzut4OZWAgKGsZzeQ1RBO/PP
	 jzxNwllbRSLr2CYcB8Kfl/j6R9PGPX7fuM2K7EFnQ7Aau1GAmOuiN14xq5sQvTs2xW
	 oc2veZRrUfr+s/u69Sy/Xqw1cW7cKsH12sua5X/H59xwCgGN959L2UOuoFGuJlumec
	 xdSH3IthPRRCQgWWy+VmeTfhdnqfMopwW7yFidXoUAKbS73QUcloV9H7aKtfN7PikI
	 llihZUIj6CWPJI1/He6tscT9432sTHIfduFMKHQXTMZXT799Ig1OqTu6fhs4EEHKFC
	 jwsSNwzgSV0SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	=?UTF-8?q?Sebasti=C3=A1n=20Josu=C3=A9=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/7] HID: ft260: validate i2c input report length
Date: Wed, 26 Aug 2026 13:48:07 -0400
Message-ID: <20260826174808.2489782-6-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Zaidman <michael.zaidman@gmail.com>

[ Upstream commit 80c4bbb2b38513e9c3d84805fa61a0ee16d79c45 ]

Add two checks to ft260_raw_event() to prevent out-of-bounds reads
from malicious or malfunctioning devices:

First, reject reports shorter than the 2-byte header (report ID +
length fields). Without this, even accessing xfer->length on a
1-byte report is an OOB read.

Second, validate xfer->length against the actual data capacity of
the received HID report. Each I2C data report ID (0xD0 through
0xDE) defines a different report size in the HID descriptor, so the
available payload varies per report. A corrupted length field could
cause memcpy to read beyond the report buffer.

Reported-by: Sebastián Josué Alba Vives <sebasjosue84@gmail.com>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: bf3e39df3a39 ("HID: ft260: fix stack-use-after-return write in I2C read race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 30d7f014df05c..2b8db682fa4a9 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1069,10 +1069,22 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	if (size < offsetof(struct ft260_i2c_input_report, data)) {
+		hid_err(hdev, "short report %d\n", size);
+		return -1;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-			  xfer->length);
+		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
+			  xfer->report, xfer->length, size);
+
+		if (xfer->length > size -
+		    offsetof(struct ft260_i2c_input_report, data)) {
+			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
 
 		if ((dev->read_buf == NULL) ||
 		    (xfer->length > dev->read_len - dev->read_idx)) {
-- 
2.53.0

