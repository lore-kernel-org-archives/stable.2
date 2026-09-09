Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CC525A9B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950725; cv=none; b=Pzm+4ypa7pk/5tDdbP85flJXfQ0qPpzUw4nb0T83Yyeuu/X2tuHhuAExxNuWkxbjjQD63PR7qjrIWXsxArB5yG0SLyVKhnkcvp++201ECW+J8ghVrWPzQv7bcNwac00gP61/y4Mwz8G6UyX5VyGl+cGEXPS8Mp4sYBkmuh9czf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950725; c=relaxed/simple;
	bh=qYA88KjL6fFhBG7cKw7LV3/HPQ7PqGFgt2DnFNU8vo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG3ADI3ia4KM5vmJvIPtZc8xBNiAbkYHRjHU7kpK2NP1iyRdOp3AF7m0LLBdYvTxwtScsL66r2EAugW6D24I+8HbG4oIGNk/6iM9qozg0qqrl6fb0iEl/PXG8IzBliCK0p3e1G+2wSQPimy73BFicizSqUMuGJtGVEobiyp6kS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atVP/PV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atVP/PV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1910E1F00AC4;
	Wed,  9 Sep 2026 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950723;
	bh=DALTojoFhUYlD0gxMW48dMg9SBqGbNcAmYC98f8lN9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=atVP/PV90ozGBAHChGAGRvhpzNdIRYRC20Pf80GeFSJLWNpf3pL/yH/dbdrvICoca
	 ayfqgvvp654YC/dtQmSrP3eKf+M12j9A0YHO/SLd8GF+J6H5AFQwExyewjW8JHhAgZ
	 D+xyDbisfFjGlu/MAk2RC2pbNupUO4dLp72yyjV59VPyBZb86ym4rSFAOwB/Q2It6V
	 H7/6mLUqSAEBro+8EaADJpYl6f8wIYoCGSXBLsfLOMYuy2WGLtEFGghg2PZilx2T/L
	 eoeDuIL3dIw3iZcj1jObbr7m3RfKCBRdRjsmqEcfDCKhoeSufaueM4bFXFkV41GsVH
	 p+9FtUffHbcQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruoyu Wang <ruoyuw560@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] i2c: mxs: fix DMA channel leak on probe error
Date: Wed,  9 Sep 2026 06:45:20 -0400
Message-ID: <20260909104520.1561085-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909104520.1561085-1-sashal@kernel.org>
References: <2026090301-luncheon-compactly-c5cc@gregkh>
 <20260909104520.1561085-1-sashal@kernel.org>
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
index 36def0a9c95c4..e3b1ee4c4195f 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -831,7 +831,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
 	if (IS_ERR(i2c->dmach)) {
 		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
 				     "Failed to request dma\n");
@@ -869,9 +869,6 @@ static void mxs_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adapter);
 
-	if (i2c->dmach)
-		dma_release_channel(i2c->dmach);
-
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 }
 
-- 
2.53.0

