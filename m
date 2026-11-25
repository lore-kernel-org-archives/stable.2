Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626493;
	b=2pKYKGR/M8TRGn7Uofzc54mC9u9PYrfOn0+0TnEyF9wPW6PZcvWKZ+h6bPkW9J43bbXP
	 MZbuwms6u3/fM+uuj6Z/oCAf1tStBgtMRekuN05++l3kg24NYqCYJnRZj32RRVylCOs06
	 RVfw2I8/Q+eWbtKOMIAakgA4BZzIB3pdPVZOd7On8r+C3WMcAk2Vc8/0CYkgRPjthET36
	 ZpgZ4joGD+4WT1PwUbm99e8LYS4iGiE/wbZHx3HRBq+p0EqbpkFkNrsf64ARJ4NZYkyuI
	 B7Wg4PSNGMuET3SGdemUuN/+bXXr0in0n4iSKfLOEuvBPj5Gd6g05PyQy39LpeNpXUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JAHpPCacXPAOWggr3T4PEA0eSawDqItRACFSha58e4A=;
	b=2xdkyb9/86j/FThlWx4nGIv5hSCBSbQHcQaGkYDID4yMdda4aQQunv/4UVxvwygMHJJk
	 26xJJFEktNWp1vG3IP0B5ZcYtFSXt1TKThhofDmEGkP2L2KAxLhuVOKK4Nm3m7igsAcSf
	 1fTnlGFZ3vPpeQIRRetrTD8oecaXMAqQH23vCEBrOcABkcSNd0OXEVyZQd1N2NEsUGYx5
	 Ixjqil3ftXrucpOK2Wj+P5h6d7/PmP9BjCalNchr+/rOsUWja/vT71ZngNYOnLb4PNQQ/
	 01AYgyQz63luKnN05X/1nu4yoxJVTKEfB9VnUSfzs1Sc2joEAQC7gTU3YE1zZYSaj/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ARJ/QCiH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARJ/QCiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408451F000C4;
	Wed, 25 Nov 2026 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626492;
	bh=JAHpPCacXPAOWggr3T4PEA0eSawDqItRACFSha58e4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARJ/QCiHaAyET9aRJRa/PxxfFNGmq/JxJ86SZkoXW4stVWc6AaReRN/Btf72cjK96
	 ijjyxkcWOu1avbiHuImEVsh8bJ+Zf95DkcgXJ4JsmDhR99rTezJxAVV1s//xvoxfqQ
	 KKjZhqM2oA2GSCNtL7/RY4T60V7eLD727Pr7M+T0Dml3OQ37m3DIDXV7N9+xEifznN
	 IF7mkoX7oPaZoyBQ1Iz3MeTl57aKtR3NjXK6wB+J8VSRUxFdHv4CJr9hy+w+ImBB8m
	 1ZKO7rGKXDpGjHhYPm33D1A7f2GDiJpzFP1q9HHgqYzhIGcfzUP6WS9OUwNlzUktPx
	 4Nx/ZfFL13Y7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] watchdog: rzv2h: Drop runtime PM handling from WDTDCR init
Date: Wed, 25 Nov 2026 12:08:10 -0500
Message-ID: <20261125170804.924361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112542-lushness-factor-b18f@gregkh>
References: <2026112542-lushness-factor-b18f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit f00afd5d8d5dc03994cb67246543d5c70571ebbe ]

WDTDCR is located in the CPG region, outside the watchdog module, and is
accessible regardless of the watchdog's clocks and reset state.

Drop the unnecessary runtime PM handling from WDTDCR initialization and
access the register directly.

Fixes: f6febd0a30b6e ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20261001165201.763882-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261125170724.923268-1-sashal@kernel.org>

 drivers/watchdog/rzv2h_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 057b890de0b05..537c62c18a935 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -256,20 +256,12 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
-	int ret;
-
 	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->wdtdcr))
 		return PTR_ERR(priv->wdtdcr);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put_sync(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.53.0

