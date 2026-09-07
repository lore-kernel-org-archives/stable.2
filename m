Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386F3546C1
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818845; cv=none; b=o4Mk/gnd8kwpKUC5hrYXvqLwrOvDjZ4ULdya3bv5fWw9WFuRgQ1xnEpKcGog3X8zJ98tEJPOLhYoSxNWv+03/HoL1UyJgc7MSWZq3QFnkrq+fhl5N1bH5CP2lKo7lhbRwAI0WYuH4ScaUgjfGOohkKc0NPzivPxr5vWMHnV6vpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818845; c=relaxed/simple;
	bh=y8R91NqxziWrSYcBTpRJQsjckvg81+i3yriWO78DF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9d/hBmi4eMaIDzNRZ00LWPBE3BHhWk9M0kFBhm5vsag5F8x1FfP8drDcSv4ofKYo2l9P/zlg1GZdUjCm6II6aslFjEr3Rdc1C4g0G/h3oS0s+FcI3Tpw0J8RJDa+K/Jw6bRoRFm8oizbMBR0bPmDmVW+/Wt/YP8iTplyXSNCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE5XU4xJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE5XU4xJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D001F00A3D;
	Mon,  7 Sep 2026 22:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788818844;
	bh=JtXREQJdWDy6KnOyMuznLFHne316ueGPWeFi2TEi0sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nE5XU4xJoC9pflk9ecNWPkF7my6WKXC24ZzQJWZomSbBb2PyP9+hxnckcdvgzsqtI
	 bkfwm2/n76hUmSyNBAI7GSekuze56L19QkusUO1FBHyktSzaktQBDm4ohirw/a27cR
	 u13r8ZTEulSaobrVaHFl3UMA5fhbCY62XTd9GWl2oUr7RQBKJSq8T8zezOEbqhD1yY
	 OhKcOmwF5j+Ruihs6u+5lLzKWEnDlj8eNGCudrIvkqNQQ447tW4+AtBh/2tfM5ZI7U
	 kI4SJNF2fAAv/9I7pka2v1x0z4z8HVvbgd6mJWjx4vrc9Of7rF5SntyKluw4jSOoYe
	 ZRX/VPe7ks/xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
Date: Mon,  7 Sep 2026 18:07:21 -0400
Message-ID: <20260907220721.641617-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907220721.641617-1-sashal@kernel.org>
References: <2026090357-reference-varied-a710@gregkh>
 <20260907220721.641617-1-sashal@kernel.org>
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
index f041e47ffba1e..2332ce6cf5cc5 100644
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

