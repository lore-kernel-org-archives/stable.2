Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817B3FBB5A
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413763; cv=none; b=HTd8OCCS7sBUXJkMGbtbzDhznA0QMV6mZX76qF51OCXjXvdnvEn3psF56mjxaayh6EuFRdyI7CBHa+zIEfZvG7Y17F4jWTElmvViJHmQkdDcTjozEjGXYYuwFKGdKAunJvnQIbJ5a/me47yY7DQh9s9llWGnO2HREOq8YJ3CAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413763; c=relaxed/simple;
	bh=SVaa5DXjuSV0crbMw9iLKYrmAp03OqJDYohRWuMeNR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW7a9eVxhK+pjI3KyKuwWQAZkxB7OdnYEh6nJeFtrkKZGMpahjGvz7Pwqa6hihs5Shaggn9od2wCijHvl55K0FnxSzGks1Orp7HNniNNN9yp1WRsdiwXor0hDazgZIofs6YldQuXwIaw1sd8E5ii0/CJiW9xISFgyKX566ZfFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc3RnwRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc3RnwRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296341F00ACA;
	Thu, 30 Jul 2026 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413756;
	bh=qajtR7W1gKDNoGKdiaQ+4qE46tx12xUpHLM1eHswNb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kc3RnwRzcuPAWLgbX3iP/qMsC/az0tgvVnJwIla8QBlDlRmxW5qdwbGO4DTJtw36w
	 +L98Jws9UnBWH0zBTT9X7JgMTq/l9f0hfLmBYuJNMiU7r5r8I5dL6CUTgBkNMgV9+z
	 5Yd1ouXCW/7up3DUM9WcOH+ohoSD/u73Tw/tzlj5goOQlvrddqsT26oAnXXRrA+trE
	 e2ZgErG6P2/SXZ97mRKCIkUfLKWUwKpxTR8dIdBi4BALETyS0HRMsuyDWrfjjGOWlk
	 a3Yrh4ElPMhQTni3tM0wiCf4nYvIWHFNg6yd7/5IOICYUZMobcOCfF41nOvt5wbU+0
	 3CTFgvhXwTw0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] usb: musb: omap2430: clean up probe error handling
Date: Thu, 30 Jul 2026 08:15:53 -0400
Message-ID: <20260730121554.2211933-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072752-stoning-canister-689f@gregkh>
References: <2026072752-stoning-canister-689f@gregkh>
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

