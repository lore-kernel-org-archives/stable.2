Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FD369208
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817669; cv=none; b=A1Z8sjP94u98+Y/w5XI28HW6zJNmB/c52JEFuJBuUkX81wquTZrESJiQCCm5avctU1wR1lQ4TwNOf8ushvIUUOL64buX8ViEWrvdPBqooHdqJ/4jmVSpFUkeL+gVwB4ksNM3+0bEh6oKYnkw+nf0d4FCFXMWtlur+0zDHaHC7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817669; c=relaxed/simple;
	bh=mUUKNBX7t5evEAVkGpVhIUQRT6Nw752eshgaxV8twUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=altakjVLV4XoMb0RN8HynI3ZARVNoAlE5lh+hCvoCZtd34mpfFKzV4zUtAxPAopEUAiTmi8SNf7Nti/cX7LqcL4JCPq9oa737fh1jLkeDam+MN0uBHTarF0pIgo1IK44eiTmaOPhGrdlXvCsvuiVRDZSYjcPTAp8SKrNSaQcvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmo8cbD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmo8cbD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4791F00A3E;
	Mon,  7 Sep 2026 21:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817667;
	bh=ecH/v4CL5nx2vZtVedw7xPCET/ONF4jiUtuFqbIqAws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lmo8cbD1l17dAIrIjqxSxKG4ms0gxzy5dAZ+ONGQNIil2bueSOoMrb5W8NcRyqzZi
	 84mDQ2gdKgQgT6oCQuE1zxY0XSoHQo6PNftHblcimNQ9JRmDWv+OL93Md55JGDqhBM
	 BBtOB+473CgTx+0MZZ6Ih8hucISu/0W0yLZgcBRJUtHP1TWqTfvoOwwh5biqUFzcPc
	 uoGyguzi+OKVO6qRXHZyNUyMsctUP0a3AFdEpc2rM5olL1ss2LOD448D51uhYBPdN1
	 RSweYcQyitqzo9eE65wrgfUrbaWs09W0ADGT9mEOUM0TTwbqQ70dibNaWjxn24NoeP
	 POeiVCTZMevDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
Date: Mon,  7 Sep 2026 17:47:44 -0400
Message-ID: <20260907214744.595721-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907214744.595721-1-sashal@kernel.org>
References: <2026090356-sacrifice-semisoft-7d7f@gregkh>
 <20260907214744.595721-1-sashal@kernel.org>
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
index 4ebdf215f3576..f9cbbcec2da96 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -320,7 +320,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
 	if (ret)
-		return ret;
+		goto out;
 
 	mcp->rxbuf_idx = 0;
 
@@ -342,7 +342,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 			} else {
 				usleep_range(980, 1000);
 				mcp_cancel_last_cmd(mcp);
-				return ret;
+				goto out;
 			}
 		} else {
 			retries = 0;
@@ -352,6 +352,10 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
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

