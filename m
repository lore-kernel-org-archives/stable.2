Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46367416878
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757897; cv=none; b=nOMsL2JngFfNWkVK30tHmWq4RawodaF3A4qArhptu9TmNq7Sx+6879rNhd0kbX6sgz7csJvELyfLD4k3LmMZ2CFAnJ3Q+h1IOcWWkQPfTrTHgQvAedTfNyLOgVu8Tls7WzfzYly/g7jQmgn/rRQgUarYYa0MkOf2raatH97YrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757897; c=relaxed/simple;
	bh=RKbBEjp1fUUA/+MSwYnhxzW2//n7EqHPNr2IX5KxNss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlltwOp+Cf2UGO2qr9oSMWkpFWzVOhje/gGFjnG1KwO3KoxoNan0pAdO3FpjnwmgG9sR+VltxsTOqscfrOjTj3s4XJOuR2y/eMn5hQd+Rg3Y+GxfKZ32QsBMCcGsNeFFJQOes5mvYIqX0QP9HXcxXEJOXLJ4q8o5ZPml2STz6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjrxJkbK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjrxJkbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376A91F000E9;
	Wed, 26 Aug 2026 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757895;
	bh=jhynmfT8c1xmd8AgGqPtN+ExwCg6a6DLUssQEzCzges=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjrxJkbKvQRNb6T3MbcpyzZI+gpMXXXWjyXjgbvvYUdXz9ExO/KXOnUC9AmPqKQ5s
	 BLALWOMn3jlAtiODkEFRhrvpm1PHp6q+GSWH71awlNyinE5Hf4eYUY4Y48LC/3xJsI
	 D9LprTf3vc6kKjKLmAhOed0uKZsuepTxmIZ9pkn1fk84i5ME2OvcPrXjxEYy22H98E
	 DCNjABTb3nqntltbCghO9l5zw49SvKN0ymDr+rWgLxqGj1Es+1VhHIIcpHClbFboBs
	 ZH9InmJe+Z9giTwjCwh4SnlgR4o2+bYIr0NDKYoddGJdPSYdKnBclCQo6N3nosgSJH
	 Kb153Yyr8/jOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	=?UTF-8?q?Sebasti=C3=A1n=20Josu=C3=A9=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: ft260: validate i2c input report length
Date: Wed, 26 Aug 2026 11:24:51 -0400
Message-ID: <20260826152452.1119137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082536-gutless-jailbird-051e@gregkh>
References: <2026082536-gutless-jailbird-051e@gregkh>
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
index 333341e80b0ec..70e2eedb465af 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,10 +1068,22 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
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

