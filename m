Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAE43E9FB
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817005; cv=none; b=EvpI8KRsH0X9XcOWlqBkGPlucsyltf3y44Wn3wkSgYTKIYk7Si5yxO7Rwf7QdO8RFWDcwSkew4kcrDzehSfUUh7r6D98ioFNwkIqNr+GSoE+LexNbluRFDi1+tJDKcJqg2KJMvFfBDHQdl87uSq99xiGBxVFt+m5zQqxE8Q+PEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817005; c=relaxed/simple;
	bh=SfAyjTdAuEzlOANm8YlGPhf43HZzRwnpi0SyN48lIOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4LpQRN185QOLy705XtndaMaEis/IILtZeV+sd1g/ulLNbG50JqHvRaAjpiRX5g7Zj2AoUnTZS9AVmbkKn0jyHgKHMP6nHc1yXXFNcr/Zg+omz38ByMeYFlDqBgX93IeD8Ecn+01WYPllzd9BHg4H3gqY1ARAdneSgZBd2JanSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4llj3Eo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4llj3Eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA3B1F00AC4;
	Mon,  7 Sep 2026 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788816996;
	bh=rlKzvR4db12+Qukmx6qkTUm7jO7jV/RT++SyiXHeTyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4llj3EoCLmoQSs9zdZHDSsQQRnXuHPwh5PfpZPUACXdFkfMGaRQi0y0Dwn7lLy1C
	 RX4BYFd1wMu4czgIaaaLWH/Qv2rQy9HrXOhrJlINb0r4wH7/dPXpirgzTfYTYy3L2W
	 /PqNReHKTULiJKAL4jARcR1jmdPAyfRGk55prrs40BmwULIOba197bDz/s2NJLLlTt
	 j9frgefnv3b+UJ5Qs8+oxqdZqcaq/B18462TvjKB/K1pKLSSo+m4smomT+3e4n3x5q
	 PM6WVDrQy205Dc2CUmAeq8hFSzU/W/tRCtMVfm8XVnz2cX4iI11rcx0jeFqdZBTA8O
	 Vd2iVpfOqdR3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
Date: Mon,  7 Sep 2026 17:36:33 -0400
Message-ID: <20260907213633.573900-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907213633.573900-1-sashal@kernel.org>
References: <2026090356-tusk-brunt-33b1@gregkh>
 <20260907213633.573900-1-sashal@kernel.org>
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
index a33f33c33d768..f10dea1045d15 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -336,7 +336,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
 	if (ret)
-		return ret;
+		goto out;
 
 	mcp->rxbuf_idx = 0;
 
@@ -358,7 +358,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 			} else {
 				usleep_range(980, 1000);
 				mcp_cancel_last_cmd(mcp);
-				return ret;
+				goto out;
 			}
 		} else {
 			retries = 0;
@@ -368,6 +368,10 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
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

