Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35539419304
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417220; cv=none; b=UuzE5hFw1luqnJR/RW/b1unMWasYWYAJJJ3liliFma+je8w7acduRdzxDIu2bsRnANU26+FAKQyTn+rFqeV46uvHCim5EH00M2u5NR8o01cZm3S1EUCmL/B+YyMUZjpmFBQtNWGz2Qgmi0Dyi+dmVhNsjlkIcwJtDEu3hMKZmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417220; c=relaxed/simple;
	bh=SVaa5DXjuSV0crbMw9iLKYrmAp03OqJDYohRWuMeNR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4vMePLzAIkTApf3oRuooQYMkeh3GDnnQ80nfxtg2wbbgGpiQM8X02tbp2cO/H9D1SDc8fAoOAf0Eu7VSz5l3QTGlZ4VPCHy/agdWdPrAnq2RvlErxvfkT1LFAOjz7kXjGS0Y8TEyg+f7WFcB5F6OqG98No9Pdb3oL3PwsKZab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgbvghdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgbvghdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5231F000E9;
	Thu, 30 Jul 2026 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417218;
	bh=qajtR7W1gKDNoGKdiaQ+4qE46tx12xUpHLM1eHswNb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OgbvghdHovL6F/CpxaTOk/YjbGBPlAbWtIbcJNvYEUEEsEEZCHIUNBiIL+gNoD5YT
	 ZpmgRma2yff4pUB71B5lK8psQT1Ncu+jyRVrUKzHM7ZON4nHcMYB0hktcH8sePTT46
	 sONm1fA8iuyyVq6BkCQ4hGv0QIYgh6ge8biNoR1NfAy5tweNXKdSto9yuZ8lDKk6FA
	 9pGWd4gWEQcki2Ojy6kdT10ZXjNbJjbqSo9SOBFQAnGX8LOqYMuYB/rukmlMdtwujW
	 uuPwenJGrUMx5oBj9mMle1be0QLcEjXRKr7VEMJD3ynQEZhQQ+66XHJ+gcN03uyiwF
	 ap44PbHN0zhbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: musb: omap2430: clean up probe error handling
Date: Thu, 30 Jul 2026 09:13:35 -0400
Message-ID: <20260730131336.2345145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072753-washstand-wasp-7982@gregkh>
References: <2026072753-washstand-wasp-7982@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 51d4b0a44c82e5eff056ef76acd2c3c605a8eb74 ]

Using numbered error labels is discouraged (e.g. as it requires
renumbering them when adding a new intermediate error path).

Rename the error labels after what they do.

While at it, drop the redundant platform allocation failure dev_err()
as the error would already have been logged by the allocator.

Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724091910.21092-6-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c947360ae63e ("usb: musb: omap2430: Do not put borrowed of_node in probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 22d91f9f138e09..fcfc024e3288d0 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -318,13 +318,11 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue)
-		goto err0;
+		return -ENOMEM;
 
 	musb = platform_device_alloc("musb-hdrc", PLATFORM_DEVID_AUTO);
-	if (!musb) {
-		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err0;
-	}
+	if (!musb)
+		return -ENOMEM;
 
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &omap2430_dmamask;
@@ -348,15 +346,15 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		goto err2;
+		goto err_put_musb;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-		goto err2;
+		goto err_put_musb;
 
 	config = devm_kzalloc(&pdev->dev, sizeof(*config), GFP_KERNEL);
 	if (!config)
-		goto err2;
+		goto err_put_musb;
 
 	of_property_read_u32(np, "mode", (u32 *)&pdata->mode);
 	of_property_read_u32(np, "interface-type",
@@ -379,7 +377,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		if (!control_pdev) {
 			dev_err(&pdev->dev, "Failed to get control device\n");
 			ret = -EINVAL;
-			goto err2;
+			goto err_put_musb;
 		}
 		glue->control_otghs = &control_pdev->dev;
 	}
@@ -455,22 +453,21 @@ static int omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err3;
+		goto err_disable_rpm;
 	}
 	of_node_put(np);
 
 	return 0;
 
-err3:
+err_disable_rpm:
 	pm_runtime_disable(glue->dev);
 err_put_control_otghs:
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
-err2:
+err_put_musb:
 	of_node_put(np);
 	platform_device_put(musb);
 
-err0:
 	return ret;
 }
 
-- 
2.53.0

