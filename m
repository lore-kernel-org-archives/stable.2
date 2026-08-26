Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492D3218BA
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758393; cv=none; b=fDGtIvH640UeCag7qQtY5v5Ugu8gM1N9EY7UFr/GRNqmmuIa5OTR81hTO5HkH/k6/0wG+vCLiPNd6lOcbq5rX0LyZz713EBp0LTJ4yuyV90Uta0tYuzvA1gyVuXitmo7n79oryBDufc1fHfWOd+jUapuD9iRGjXcW1IXIKTpNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758393; c=relaxed/simple;
	bh=RKbBEjp1fUUA/+MSwYnhxzW2//n7EqHPNr2IX5KxNss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xpdpoc+/548GVbQxuRdBkqggCHACYCvqpC3WwQBabGULGs31tYaNUJ66ZDydVmt1Ql95dNdGcjdIrFT0pE8xYfDbkloflBdyhqBTdeaB+MxKy+3zsFdWxPWNNGhCNM5H5+SixUlPG4+IpjFVIzKM5XjDuT7crsVgNAoPDxeiXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCC64xh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCC64xh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F531F00A3A;
	Wed, 26 Aug 2026 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787758390;
	bh=jhynmfT8c1xmd8AgGqPtN+ExwCg6a6DLUssQEzCzges=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCC64xh5uB7sjrPb6ww/0DfElF+FvqOxXulonx0bGNxiPNAnWAI5zGIsGeYpzad1J
	 kRfwyO7EmZ3DiLbvWZf2xZ0mxPTo8r5CFXF6uhWdc19bpHT7eAqW8SnJ9DUjFjlVXp
	 agUs88DqQcMEBOYwTIdS56YWQyS7TMhHAhKDc7t0/D4nQvC/qiipuYoxD7fqupXxRs
	 r4DPPJSf23/TVIAyN9N5iffA8hKJblh/i7pAFMnc2ZdPDwNPTftzPEbUKRodRhxS8T
	 V/mFB1YH0zW5tWsmrr41iusaz+thlUqtZHv32rg53rkX1gL77MTaVs6FT38a/Qio34
	 B26vb3KzoRQFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	=?UTF-8?q?Sebasti=C3=A1n=20Josu=C3=A9=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] HID: ft260: validate i2c input report length
Date: Wed, 26 Aug 2026 11:33:06 -0400
Message-ID: <20260826153307.1183086-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082537-numbing-bronco-2d22@gregkh>
References: <2026082537-numbing-bronco-2d22@gregkh>
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

