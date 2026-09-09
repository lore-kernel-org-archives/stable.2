Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F751E45D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950260; cv=none; b=t1tSVKYkPHjVLTucAUN5486QXZvaqk93+32O/VxvNoquky9m0witRQD5bzxXPOAoKQTLMiHQJzklTdeeB7fH6ZMD0cwJZGdhvU1Q+v8FDz32P36MVzdFjVQAURVyiiHc41q4uGmz/Ia9epi29vxg4BZA/2hTVoy/DhFXcrqAQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950260; c=relaxed/simple;
	bh=qYA88KjL6fFhBG7cKw7LV3/HPQ7PqGFgt2DnFNU8vo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g43Bxb71BbZJ1s8wunwOVCVoBMMupqCCZf52wl3aFkXUEv+nxu3qo69qb2h2h44haLAP9H89TwWP//GIC/D9dxSVQqMuqFF6ePS27PTTZU6fAaJGbD2Rwvrs4zmoejSqs7YR2vd1ZDiYcJdK2lUXk38Yi2q/R4TumoRtVIz4JB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8kIFUJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8kIFUJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEB61F00A3F;
	Wed,  9 Sep 2026 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950259;
	bh=DALTojoFhUYlD0gxMW48dMg9SBqGbNcAmYC98f8lN9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8kIFUJ0zyRzdunG8dC7MkHnCScDIWxWzjFH3wggg2Mm0ZHFcl+7I9AgflvUNtlva
	 smIO4+puj3Twn9VHEv3fJTIEyBHX5Qke53dAyKJIEb5vKt1pcob4C7w4gwsqtLUMz5
	 eykm5G8OTI8tbhYx7jx41mZH+q64w22EW/4zMSJqGvEryzQSiB/MqPXgBnYoXz0gBm
	 3d7tGEav0RUnGKT9nQekeNzf+S+zBgNmYZv892HyDtST+t2pJ/lvTHED580Bx/QmWJ
	 GFZqM5yoBKNt27ZPc190gjMquQ9xjXBA/kNa8/MuGHHVuwrmUyqY4a8ehYLLu9f0Vm
	 t2BKR1TFJXyiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruoyu Wang <ruoyuw560@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] i2c: mxs: fix DMA channel leak on probe error
Date: Wed,  9 Sep 2026 06:37:36 -0400
Message-ID: <20260909103736.1550307-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909103736.1550307-1-sashal@kernel.org>
References: <2026090301-stream-storage-7d41@gregkh>
 <20260909103736.1550307-1-sashal@kernel.org>
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

