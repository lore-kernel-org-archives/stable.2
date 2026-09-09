Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87C4B2CBB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951446; cv=none; b=e04uc0A2zoIEPJ/L7BLNfNoC9GHQNn5sZv7RUbWGp4NABARi7u2Didx7+gKLVVdfgFz6kEG6++FKrqHy3TssUpMgJ0OWabah3i65UZgPbOS+KyV6PlyHBQ0DZM0uRZ0+r23YOAgINBGDi13lejHjqi42yzvwiXO0eGPHypDfTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951446; c=relaxed/simple;
	bh=JLq/PzQM/hdI29rl94TJozoG/EpiuPVMmOyeOOQYK4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4US2PN5c1j5uOVhZV22hRY7EEHTEgaAs8Fnju8xjM7ZbrVvNNuCEzc5jRnmN/q4sAxH/Mzi8n5lRrKdvZZw3ljIyyy7ERQaT/oVRxe3U+FKaa/6EmUaUSYhRpg7XeE+s34ukF9u2Ass+bKZoQyVZZD2esb2Ei0BYgkXdo11uMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNV2/z2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNV2/z2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481891F00ADF;
	Wed,  9 Sep 2026 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951443;
	bh=No9PaJtcBD4fcAbHyVeubl0NDYkfYoaklz9Vq7o+IdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hNV2/z2nacN59qF5s8dZfiuljCoKcnhqKaA18dzPZw1/UafsFRPKTYSYqcvTU2aRj
	 Zpcok/bg8VdA4oYok2QtVvZazBjy9j4rYArZfrUaAcVcgXaWjyjDu09Lnu1dkq+3TY
	 X2EX+JQC8Ho1/vAewOKGwGW619wHVFzptGe6qyLr1a00TV74a/BNHfQfDdk36d4+I0
	 8hR+U+4zPwRygI89C8iAPtGeiwJ8yAeCwDWRbhnHyM/z7bv4mWlOfBt4GFt3aGZKQO
	 COmrFtNakN1aGEp7xHT9nRqNVGuW6jNkXaLEGJKCm8vOTAJ/tzTOydp9Tk6tXVltQx
	 LQEQ92zXnnsTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruoyu Wang <ruoyuw560@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] i2c: mxs: fix DMA channel leak on probe error
Date: Wed,  9 Sep 2026 06:57:21 -0400
Message-ID: <20260909105721.1641676-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105721.1641676-1-sashal@kernel.org>
References: <2026090302-showgirl-ongoing-e7b7@gregkh>
 <20260909105721.1641676-1-sashal@kernel.org>
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
index b353732f593b1..fa0b4ce5c2f9a 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -824,7 +824,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
 	if (IS_ERR(i2c->dmach)) {
 		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
 				     "Failed to request dma\n");
@@ -862,9 +862,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adapter);
 
-	if (i2c->dmach)
-		dma_release_channel(i2c->dmach);
-
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 
 	return 0;
-- 
2.53.0

