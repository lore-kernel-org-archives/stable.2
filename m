Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11138DC49
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805615; cv=none; b=qGUGkAoWepV5BDY258FKCGv+k16DZw213ZImhwHVur6YhNZyVf/ocN4dT62nMY5aTzKeeuBy24wz6SNlmT8xRUcHQq/XQSoful/DW9GUNjx5O2ztIi0jD2ha3TpWLxKz9OB/Yf4MmOGOl06rpFfaYujBsVOykg1PGE4i3PyjWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805615; c=relaxed/simple;
	bh=ujt1yZpUJTflwkHoefXSnIUdkAF3eqchzFgBftv2sWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7doi0Eazhjx9Y8fT3vqfMoxeBKtO+e+abqBtcdR6AXJIN/ZndzqJxHDXQNcX4jzzCGkoz9Bgp4kpoXEepKO0RhuEvDb/+QtiGefPf6mpwQslNHebNn0T2kbetyj2DT8bT8ortD/2uTMcOwv0pRU4X4jsckLgrbe0MV8d09Y/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAXhdx4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAXhdx4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8E11F000E9;
	Thu, 27 Aug 2026 04:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805614;
	bh=C9gRWlnAFc1Wa58nDSs5oh1xOsSa/dUEj0fytL4Z/rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAXhdx4Jbnq3W7zstb57Jbc68UBv1qlL72j1LNtwFafWz5+1NghgSKpFwaQAW5wS3
	 NYSkoz3SJngCw2ZutFl5IkFD11YvDo0hwZT14LzqXNxZypQdXEWnGwdmjBMvqyKN43
	 Ob30RZ4Bh/XjJC8eUyQA3Wn1yfKCFJYdq2I9nF1IfI5fASlrIdqrkGgMMRnZWAw8wR
	 L6rVJGLpnLuYc1sns2H9My1TCaU2SKNEAwdE1CIAo4INEs63MEknT7tF882QclPTtM
	 A55UIAIZIQSQYwefqe7QYV0VuLTM3jchplX2JZigxIgPqBDEI+PiD4KF9cwzx0lDiv
	 2zCeCkFq8Hwtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	=?UTF-8?q?Sebasti=C3=A1n=20Josu=C3=A9=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 7/8] HID: ft260: validate i2c input report length
Date: Thu, 27 Aug 2026 00:40:05 -0400
Message-ID: <20260827044007.3635916-7-sashal@kernel.org>
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
index 58dacc271a7f1..4c085ede74152 100644
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

