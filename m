Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52129B766
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820085; cv=none; b=MDPfMywCdGWtFCVDrvO36G8jrZUynrHJC35sHUZRxIssxsuF6B9LJVqsLEnn40nGbnAA5LDuqzrSIJdrPPGsXsl4ut7GLjfYysTYZOSf+4jVJ/H1ztBOkkfqXb3A2pFCT33Rjo5zkNaMnK6H7UqeVgfczSt3MEXa7Zdx79/r7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820085; c=relaxed/simple;
	bh=tugY/PAXEYwGPWERXaK/QV/fN5HAPMBg+EUlT+9EDhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKorhoE2k1pofkVxLvEORzpUqKQVKcn6FKw1PKFx0tVyyI1xTjWXIoCJPXPyE35mZ2WcVTfZRCzjn/UxjuWYsPsfgJqd5X+J2WljC7Uw74TOaD/lqQNoS9CpqFhtmzEhQrQyZzdTE9hnkXxv/sXvCOaU+YJPbbhY43WPuCB7KWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZevGQLoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZevGQLoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58EE1F00A3A;
	Mon,  7 Sep 2026 22:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820084;
	bh=Qkt2UfqpD1xhjC7Ina8fvjdMSKUjW+nDfFd6840eah0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZevGQLoQNCaTyRL36HXWgn/kl2TOqIc4MiUALGwiUVks/qpoSrQBhGqOMKdauHAld
	 xMUYvj28dpDWP2QqikdPTpYpsXXGvdMIKmBeVY0VXiC66WFuFg0Ef4MdIOzRyIVrcb
	 k71sguZs8CnAUvEsCi0TxRFGWhjmSLDwtonEGYvW5YGhQGi3em3XZvHyKLX6hkGc/U
	 Qzeu5leRI/IbLUWNgchxuYah3NzA0cDxHroUytFPWfEA4qEa8MUgvyvEO0eaD7Dv/s
	 lEoOoCqPrsxHMWyY2F32W6a5KHhC3ojgYE81klsXdVvkW0JOinI756CmV/OeQSzfn3
	 vLnS5+ZI6wXeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Pradines <florian.pradines@gmail.com>,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] HID: mcp2221: fix OOB write in mcp2221_raw_event()
Date: Mon,  7 Sep 2026 18:28:01 -0400
Message-ID: <20260907222802.669668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-twisting-kangaroo-3039@gregkh>
References: <2026090358-twisting-kangaroo-3039@gregkh>
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
index 9fb98c8e1ffb7..239efb89490f9 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -93,6 +93,7 @@ struct mcp2221 {
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
+	int rxbuf_size;
 	int status;
 	u8 cur_i2c_clk_div;
 	struct gpio_chip *gc;
@@ -289,12 +290,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
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
@@ -797,6 +800,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
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

