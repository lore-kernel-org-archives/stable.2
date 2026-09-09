Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271B534448
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951280; cv=none; b=fe4TPLBQduiMjqxkbICfxeJC0/9nifGjGarMgC3/TLES6UbGIW4NIHCLASwmKabZ4CO+X0ikbmzwyPc0ZVo3CiFlZIJhwwaxQyS4uESoeOEL8sRNE9PlBnR31uYm00AGNzRWkEBBNM+cuK/zsr/VhWMCKJYs9oY9chqnqiMeUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951280; c=relaxed/simple;
	bh=cjoN3kyHUHGx822g9bmA7BJePDL9NT96IX2f7CZsdoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThHUprw6lYCmZ2xsb6Mfyca8wJG7H7F6ZM8MjDb0n1hniCroRcNHoqUdFkxVC9+ZXYz/bY5rzad2OxfpDCgs2kjxRVeRMl7WX8Q6/6qChd0RFYkPV2vzstnE4CxYQUGNn0tUirOSP09eEKHMStwQ0HZfJtxTIFiVGLtVIlz/odo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPJkNX+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPJkNX+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29141F00ADB;
	Wed,  9 Sep 2026 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951276;
	bh=oEhpOoFoJq/bpWDPGu9r/3efVsNQ8HFiimAskACphzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPJkNX+jArFR9tfRiuhu1nQH2CyaYmWMMU7pUPasDEksgFxqBntJoZcbxrzbhFATP
	 9U2CtlUUtep5P5D3wlAccvjSkuGX85Sa6dNo/vDjcg+qTyBOL6CF2MQQP4SwVT8vD/
	 bKwlMjVPvPGQn46yaVqJxiDejyE/UuokjvDKdQxST7zrpYLXdGiF1QaC3MHjZrqlAJ
	 zmmswfprNzawCBjbSCBRAT19CPv1rAQNkz/xbMjVaOLDIlQJFpzPXh6dK5YHgdt2hK
	 X5b7ZdOgkmSxIb5zG0+0t46LWn58Gfw0c44mGta58QdQUDh3U+cwg28gUFYK4JdjSC
	 NmS3M1XqSdsng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruoyu Wang <ruoyuw560@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] i2c: mxs: fix DMA channel leak on probe error
Date: Wed,  9 Sep 2026 06:54:33 -0400
Message-ID: <20260909105433.1622090-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105433.1622090-1-sashal@kernel.org>
References: <2026090301-rope-disprove-ff1d@gregkh>
 <20260909105433.1622090-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruoyu Wang <ruoyuw560@gmail.com>

[ Upstream commit 777979e627115734052b323d2721cdb500e81dcf ]

mxs_i2c_probe() requests an exclusive DMA channel before resetting the
controller and registering the I2C adapter. If either later operation
fails, probe returns without releasing the channel because the remove
callback is not invoked after a failed probe.

Use devm_dma_request_chan() so the device core releases the channel on
probe failure and driver detach. Remove the manual release from the
remove callback because the channel is now device-managed.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 62885f59a261 ("MXS: Implement DMA support into mxs-i2c")
Assisted-by: unnamed:claude-opus-4.8 typestate
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: <stable@vger.kernel.org> # v3.7+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260815151720.3757460-1-ruoyuw560@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-mxs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index e0f3b3545cfe4..d792bcc11a895 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -832,7 +832,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
 	if (IS_ERR(i2c->dmach)) {
 		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
 				     "Failed to request dma\n");
@@ -870,9 +870,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adapter);
 
-	if (i2c->dmach)
-		dma_release_channel(i2c->dmach);
-
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 
 	return 0;
-- 
2.53.0

