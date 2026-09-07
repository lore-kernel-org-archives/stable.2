Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995143C05B
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816997; cv=none; b=uBqXQ3WnSPFfRRjfElL9VYmfhfcqkw7TibfPjZ8A9Uirggp4lcBBCguCkuGm5Zv1skYf95B3+eHPbiE3CSIEIienj2lMOIFwf0jL7aqgFh4mCLfM29K+Ly0CmTiNyrS/TmYcuNyfHDKV4p0pPTX27+kAd091Ds49frGmg4ze1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816997; c=relaxed/simple;
	bh=0R0TVuFBg91URqgEUWMh0tR+UL1GaNk8ZXMTWNcXv2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQQXHmjKAy8h7I0BfYMvpplkaMMLRezJepvYRryyewNpWHICTa5tZcJ1zBv6LczmN181J95/nYKQKVyvUZ+w4VYgPhuBPiXaS/e/RkvcocEK+PWXXdLT/6vtDaOYjhyj9987bAVPwyLkhwoLse8/hAWO31jG8GRf/GcQKsQlJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+t/SLDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+t/SLDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFD61F00A3A;
	Mon,  7 Sep 2026 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788816995;
	bh=CcR4AGmL45PyAOUSUUykifd2WG1Tt1sxxuacvvHKoZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+t/SLDauYJKUb/h8FWOOwHj8JRyjGr4jLKxO4sADBduR4q/zU1lePAqNU5N9ZWJT
	 JgbPQNobBvgk9PIuRoE7od1tz2UkyJiZz02CQ1aSVnvC//y6KNCaOCuYA9JqYIByaD
	 9z9dmRVG2s1kzAGZhDHLZDf6WLIgxqStYfZN6l8lnp6wQ7ChVteGyaX5AaoxvJ2yvP
	 eFf21x4bdCQda/D9GfopBHjZKrsbTdpqp24q5aqSzd/NYQa2B7zGNeYKxYZgIsMn17
	 DJa2BjieNEC6gPUMZgzELl8Q0MnRuyD8zAA7537VOsBHJVpSOtDBSkOtqia4r9HuuE
	 zftgE2VzV83/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Pradines <florian.pradines@gmail.com>,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] HID: mcp2221: fix OOB write in mcp2221_raw_event()
Date: Mon,  7 Sep 2026 17:36:32 -0400
Message-ID: <20260907213633.573900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-tusk-brunt-33b1@gregkh>
References: <2026090356-tusk-brunt-33b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Pradines <florian.pradines@gmail.com>

[ Upstream commit f097d246677b03db814c5862f368cea341b76a00 ]

mcp2221_raw_event() copies device-supplied data into mcp->rxbuf at
offset rxbuf_idx without checking that the copy fits within the
destination buffer. A device responding with up to 60 bytes to a
small I2C/SMBus read can overflow the buffer.

Add a rxbuf_size field to struct mcp2221, set it alongside rxbuf in
mcp_i2c_smbus_read(), and check rxbuf_idx + data[3] <= rxbuf_size
before the memcpy.

Reported-by: Benoît Sevens <bsevens@google.com>
Signed-off-by: Florian Pradines <florian.pradines@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: db2333f88729 ("HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-mcp2221.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index faebe95b4eb04..a33f33c33d768 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -121,6 +121,7 @@ struct mcp2221 {
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
+	int rxbuf_size;
 	int status;
 	u8 cur_i2c_clk_div;
 	struct gpio_chip *gc;
@@ -323,12 +324,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 		mcp->txbuf[3] = (u8)(msg->addr << 1);
 		total_len = msg->len;
 		mcp->rxbuf = msg->buf;
+		mcp->rxbuf_size = msg->len;
 	} else {
 		mcp->txbuf[1] = smbus_len;
 		mcp->txbuf[2] = 0;
 		mcp->txbuf[3] = (u8)(smbus_addr << 1);
 		total_len = smbus_len;
 		mcp->rxbuf = smbus_buf;
+		mcp->rxbuf_size = smbus_len;
 	}
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
@@ -915,6 +918,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 					mcp->status = -EINVAL;
 					break;
 				}
+				if (mcp->rxbuf_idx + data[3] > mcp->rxbuf_size) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				if (4 + data[3] > size) {
 					mcp->status = -EINVAL;
 					break;
-- 
2.53.0

