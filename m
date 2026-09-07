Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637153B14CC
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820086; cv=none; b=b8kAXX8Fh/7hNVquURzhEJNgXyA5GyvM9bhSr0U+Bfn3+jchvylyqm9vYSKJ8Vr7y3xp57HjHKFm3KL9tUVb2r7ljGf/ayaVetfQb8tjIUG8tXhF8+BqxSlr+FqSSooJzokcoAjasEdhTsM3KMSYbrfRuI0ZtruOfxsAECqsANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820086; c=relaxed/simple;
	bh=tJoWjNcoufSUMa7Ew+vjXF8Z4p8XJdGtM7HBcMDSeic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZAfK2bkRgbJw2rJXQwSetGjZ0rOeitrWMj5ijZIJSbSo+xADy840K12vm38Er9qPaEmgatPDPES3aExMa4rreS1KoHTLiD2xsBQmX05J2t9i5OPBOW0l6gvV1qvcqM9ptOjJvtUJ5fXlo+bxur4o1fJ3K+LbnkzmVobTCN036o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY/UcCKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY/UcCKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F661F00A3D;
	Mon,  7 Sep 2026 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820085;
	bh=mbtXrd3+RAJ4Nbe+DVp1B9jSEdzSlYRWNfZwJDJGD2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BY/UcCKfyBp8befk3dSDvoeOdPkOwGqda8IWZyanbMstdrhw9byBF0Sir/DO0Wg+G
	 9z4OpmvK9vh1cjkPbqZ0sux0UPBalL+uI/3bsnwdu1wEaMvDQByzZlnAeM04npAzyA
	 aL433+4guNUw6Xi/n/RLNhcE3SAYSL1nCpALaezlENUJmqE+Ah3iJ7k1WG1JGuzMXP
	 gIsMBg6ukoZU/aPO0ecTbViSP7z7v3NVb4mtwyQQqAet1tF9kCq2pQUTlU6Etm00Fm
	 SOaRxww6DAkgWMi2bxOxgZWElhHMCVtzZwHKXr/79E65/jaVGQisaCQrU93DOEHwVm
	 ZMk1AePBStDcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
Date: Mon,  7 Sep 2026 18:28:02 -0400
Message-ID: <20260907222802.669668-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907222802.669668-1-sashal@kernel.org>
References: <2026090358-twisting-kangaroo-3039@gregkh>
 <20260907222802.669668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit db2333f88729c8aae062cb171ed058725ff5c901 ]

mcp_i2c_smbus_read() stores the caller-supplied buffer pointer in
mcp->rxbuf for the duration of a transfer but never clears it when the
transfer finishes or times out. Once the caller frees or reuses the
buffer, mcp->rxbuf becomes a dangling pointer. A delayed or spurious
MCP2221_I2C_GET_DATA report can then drive mcp2221_raw_event() to
memcpy device data into the freed memory, causing a write
use-after-free.

Route all return paths through a single exit point that clears
mcp->rxbuf and mcp->rxbuf_size, so that the existing !mcp->rxbuf guard
in the raw_event handler can reject any report arriving after the
transfer has ended.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-mcp2221.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 239efb89490f9..d824e5b945458 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -302,7 +302,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
 	if (ret)
-		return ret;
+		goto out;
 
 	mcp->rxbuf_idx = 0;
 
@@ -324,7 +324,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 			} else {
 				usleep_range(980, 1000);
 				mcp_cancel_last_cmd(mcp);
-				return ret;
+				goto out;
 			}
 		} else {
 			retries = 0;
@@ -334,6 +334,10 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 	usleep_range(980, 1000);
 	ret = mcp_chk_last_cmd_status_free_bus(mcp);
 
+out:
+	mcp->rxbuf = NULL;
+	mcp->rxbuf_size = 0;
+
 	return ret;
 }
 
-- 
2.53.0

