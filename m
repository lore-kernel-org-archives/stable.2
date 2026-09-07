Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819A3F0765
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818256; cv=none; b=XMWMqFcO93BaLtxatHmnC0SfmZj6afadh6fdaJOKNvuxssGbvVvNEyCsiWPxW+qmMAfjIxRYS1Ca6lZ/fOMwg3OFQ86G8a/afUPRVnFri06HukvIVVkjRZ/LYUJSSGoXCGFQDr559E60Q49VkY2r15jXFXH89dzxmwR/DGCf+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818256; c=relaxed/simple;
	bh=Blt9qCSxvicxDYr73N+dnwnFBZsVPo5RE3dvvQ03G1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCNva9o4jCLgrMcVoLAA/KmYDyt4HTwZphVCeaLad2PiXyZKimzhgYqajWMOiGyn24FeqQN5g8AJ3b7FyTzQLrific9pWc55tssBmdRIjkSEh0lMRBrEZhIpxAQdCBK4ukoM5qwWIiTz0e0EuJRD8372uIhdeZraFcMFZSY2DxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpxarYz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpxarYz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00651F00A3A;
	Mon,  7 Sep 2026 21:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788818255;
	bh=6YRqHmsMX8BVkkLO/4fTe1NGe6RWAZ36DhJzAr29ODU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NpxarYz6Z//2k2zsI0gDkWnKi7Py679VgzERYn48/8xo7Pxa94rHUcoOdGHHUIFzZ
	 GMtZ7FREua+XCbqnZhTebcorJ8RPOB30h96rzNBSau2t/qwnVYA3RDRD4ixdgcaNYa
	 sI1U6EbkQQN9p62kbmaivq1L6xx04XYT4t0Yat0d5Xy27SDAUqcllPLQcdfixL0N41
	 sV0Oc1t5zV1+jlhDF8ARf3L7PE2qzDOr+2UBACZfvk8T79yrgVeKAJcjWdYm6x7O2+
	 u9iOvc73mCtJzGVpCuxOYQhdtfCBMsByCFy2lenipobd1ojhir3K17GRvg/+SOjdwk
	 FcIKLejmdaSVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Pradines <florian.pradines@gmail.com>,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] HID: mcp2221: fix OOB write in mcp2221_raw_event()
Date: Mon,  7 Sep 2026 17:57:32 -0400
Message-ID: <20260907215733.613838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-ramble-footing-c350@gregkh>
References: <2026090356-ramble-footing-c350@gregkh>
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
index 99af0b541316b..c0003e5481aa6 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -99,6 +99,7 @@ struct mcp2221 {
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
+	int rxbuf_size;
 	int status;
 	u8 cur_i2c_clk_div;
 	struct gpio_chip *gc;
@@ -307,12 +308,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
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
@@ -820,6 +823,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 					mcp->status = -EINVAL;
 					break;
 				}
+				if (mcp->rxbuf_idx + data[3] > mcp->rxbuf_size) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
-- 
2.53.0

