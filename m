Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC753A896
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951846; cv=none; b=O2Ht1hE8Lj7JfSvlbd8DEpHlcsMN1RqK9OTnFRDYQ4av+j2G36vjwgil0u/H8GfmiMNT/OqZiO7T0sTtXbo4mZP/U1Kxt+IVi7Voit9514itCbd3RQ9N2cOW8HzwfDNzFknMQJS8UrqWPzEoUWUyeW5a7jAxbZYvMelpa+wdpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951846; c=relaxed/simple;
	bh=5ItIoS+AgFnhDxWfNZwppmz0zEaqk+xmX3P2N0nOPmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7AxnAp3dAMt+OZxjgaMgQis1vIVJG4E3jppqID/UXSPz0h/uvmiGlBy6ZNjANQ9k59a5V0IyLmZy7A1Nq1DL8qdJlAfB86m6Dk03cdvFCx4Z5T5lRXkTzpNXifZyojloyQsrlQGhYF9aTtMeKt9F6u0lzCDsTUnhsmnbZsEAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqiZM4kr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqiZM4kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259911F00A3E;
	Wed,  9 Sep 2026 11:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951836;
	bh=M744FkcVaGBNFBQ/GEZY/MpIZ0Do45D9OTS/ZC5Cen4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqiZM4krRB03/6k+QmT7UyaOIRK3LAlOsdhieAadhVrnW1u7lL4D8rL7e3iPE9Xu3
	 ZBl2czhxiSS1g6bckkPCWFANIx3o/A3gIAEnszTpiy/4ITCP0t8hkdbBrmgHdfz9cK
	 HEubp0MMKAx0Um31yYOL1OTwWjsywREZLurahWtHzpVxPQNY0uUGFnECQCExeW6kdC
	 /akqcUNU0EycscOjxIOxlZ5bwkUj1NwcAYuvLEPzmBTDzz6hTiCfb1w76hS6bdRjqY
	 ZUoW+AWpHlYRPFWEAZKeyHMrvzvMRmdHzUxkCh+w5SynP10Pyr6O8GoWyXGar63Ox8
	 xB32MoTo8xNFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruoyu Wang <ruoyuw560@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] i2c: mxs: fix DMA channel leak on probe error
Date: Wed,  9 Sep 2026 07:03:53 -0400
Message-ID: <20260909110354.1706356-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909110354.1706356-1-sashal@kernel.org>
References: <2026090302-opposite-tuesday-1dc5@gregkh>
 <20260909110354.1706356-1-sashal@kernel.org>
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
index abad24808e855..cfd81b748ee0f 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -840,7 +840,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
 	if (IS_ERR(i2c->dmach)) {
 		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
 				     "Failed to request dma\n");
@@ -878,9 +878,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adapter);
 
-	if (i2c->dmach)
-		dma_release_channel(i2c->dmach);
-
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 
 	return 0;
-- 
2.53.0

