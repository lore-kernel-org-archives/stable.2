Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5C438470
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819165; cv=none; b=HvwfKomGoLf6D98B1qPPa3LA4zC5nf7/e5KewD5xvjuil7A/9mWNWo9ADh5DNeURn+6a/PTbI3YZA3xniBC/X2HPRJPwqb+vJiHH+h69RxrdeHzd7OzDaCbpdpcpkuNd71igL3sNxM/Ei1uRCPblLUEIxXZCp3Rh1DXqga0wt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819165; c=relaxed/simple;
	bh=tJoWjNcoufSUMa7Ew+vjXF8Z4p8XJdGtM7HBcMDSeic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnXcWLLR4kqfQ03GKLVP1rgFgo3zoSxaLVPNXxWjipH355Rjm9qQZ32iiZWoilx5hnd/8dPsf7EkSXloV40ZZfXZ6z2uLu4BCf9kNJUvDTSiSjfsHP80308mT2hiUXrZo2a8miArIXNO4Zq8cj6tgn0G/CHn7zub5rnsl8xwpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZScoIo/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZScoIo/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEB81F00A3D;
	Mon,  7 Sep 2026 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788819164;
	bh=mbtXrd3+RAJ4Nbe+DVp1B9jSEdzSlYRWNfZwJDJGD2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZScoIo/KlbYjoozuXVVOoGqX6LVXQbvpND7M4CLgcp4J9vdogk1cwtru/crDlVtKV
	 HmpbD6djhTWC+EXjkUi9H2AU2kt/igPKVuuLRZHb7PbMdI9mKay1XuSVb+XQAYFdVZ
	 CGP7/zkYKUttfX9N/mArGK0WsD/OHKn/GM13GvlpWsItTJ0/O+ZapcTkNq8AXBUR6l
	 O1rSvNs1iRGCiTsC2CbSUeH/xWmkV/dYsFgzsotf4Lyq2jGW5n77b/5JZ/dPULVmjt
	 3pz4922vbXD7CeufCxCUMvCWO4mVv89lSHNCpNGhRJsSOieIXQ3s5Rt2faRpyV8mvY
	 U5XPtC+IDTo/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
Date: Mon,  7 Sep 2026 18:12:41 -0400
Message-ID: <20260907221241.650068-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907221241.650068-1-sashal@kernel.org>
References: <2026090357-unleash-dimple-e652@gregkh>
 <20260907221241.650068-1-sashal@kernel.org>
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

