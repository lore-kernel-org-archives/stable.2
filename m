Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B942D5925
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817668; cv=none; b=D48FslJnH+hibNwEaeZstN6GVtFbhmCXYaRI09btmeEkselPdicIdrTUPb+EfHm6eSDrj+fIln80mNuo5vrKEYvc8Ovt007nc2cK453MF2WF1Js11AaTvD3nwUOmpgvXNmMpnWfPNNtSamHdoBLfCy9Mri6sNojspAeLB+9cppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817668; c=relaxed/simple;
	bh=/9oUP/SsNXIFCB8ePTsrAI/LqABq05tKSENomlRKJCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVEa8RYhL6J0TyTK3ZGTSeu4P2zxR6xCuHzq0Ewz97sJZaHXz6OJTw/FpwEXBR8rdt/Pyzlo49PuggqbGMXuio4Oe9+RPQ6lITJqRFnwstjT9QyhQemYstKtlm4BDuD5IwhMbRG/b04DZSrpb+cGgMvsWxJ1LA9WgTALKRxnw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekjMONio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekjMONio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B41F00A3A;
	Mon,  7 Sep 2026 21:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817667;
	bh=fm5mr+VAw6g1qVUw82pKLpdtEYN7spGrnHyqiRFJ8pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekjMONiopaoe/kLSyKo4FocUrjN2NVdP6sg9uWBVUoW8ZL1H68/Kaqdh8uI3ynFq1
	 SMOKuebTk98OQQYbMmjQ3JwBirtxYfXCz+XLTmlHcKzs6qPQJObBbWuGXUW/kEupcT
	 RTEuRHYzyWqTnu/HxBCs/9qSyrxPvfbaF+zqDBoaBf8EkkbqpulA5zxpKN+AdYkT04
	 RNSrjTNLud7w/D9qdMmWFxgxXy9EgpvKl7/iY2jLQpcO7p3+Q4FWAa5s1qDO7TQWn3
	 hQUQHvr60Um0loG6bR+FP/N5f9wmQdlZCyaaYTfM98x0gNX8ys5Eh9IQZfH+PeqMt1
	 tHfVNqaQDhyOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Pradines <florian.pradines@gmail.com>,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: mcp2221: fix OOB write in mcp2221_raw_event()
Date: Mon,  7 Sep 2026 17:47:43 -0400
Message-ID: <20260907214744.595721-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-sacrifice-semisoft-7d7f@gregkh>
References: <2026090356-sacrifice-semisoft-7d7f@gregkh>
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
index 862ff999bb4f6..4ebdf215f3576 100644
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
@@ -823,6 +826,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
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

