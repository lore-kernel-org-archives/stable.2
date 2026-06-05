Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B140E8D4
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667868; cv=none; b=T6TUV2VmBhjlSmYgvdZ4pAWF5E6k7AEA7MtPmJVvpiEn/bLWzJiFKRJdCVMRnysTNE177VcOUeAHwRv0cLVSN5X/DkkgJaU6TJHyEXFqrgKPbsksaCgdL/k0ByGc+gpUdLn3kXmmRBs5hPlATTloPsNevp+OXGc7FUe1/lKGlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667868; c=relaxed/simple;
	bh=SnODujV3XXPyXs3eVUSGArAiOmH6SaZ+iXeHo7PPjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxRiljzFiMf9ADkSTvdH0YKbLs3ahqgQsLZEjxkH3Hxwem4D5Hath0YtPBiB62+opWIbkbfNqqKc6uEuHDHA5HKFf5KaCXXLIVH2G67pvIhwW4XB5brm3suCQ/8/d36UK/NUw/mNlhjtnKvkeNvD67hMUQtpIL6IWu+FV6K4Bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG2M9VMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG2M9VMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37CA1F00893;
	Fri,  5 Jun 2026 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667867;
	bh=s8XnnIW6Bv+syaObhYh1/T5DkWXuk/GyLQqPC9tlMjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RG2M9VMgYwF7KmV33vbFNy4ZSc/7GDvTL4PUSVsWKT9MNHMe3o5RvxAkJfq1Rb5En
	 lET2QD84n44ZMBW6nDWACWL0I7ixEppXdpcuR8KJuJF+nVDGIDaSE1jaRbeUMFjR16
	 c2q3d5xSLdzBVf+YPPYKH4dRxzakpsf2nO1MFPRknAOrCeJE3VbXSVk6ms0pzCRv2E
	 a7LSuDDXgra2xViaN7f8efwgy+oWsusTZKFpHObuiscAZ82l//mD8C3XAxQtfM2uBc
	 X9HVaFvrJtUNjbZOTtZ7PlZJkqKdovwL6GjZUF+TLVgTIqsAvtW7myJmrvG2/r8WeG
	 Xp0PAxupbkfTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: musb: omap2430: Fix use-after-free in omap2430_probe()
Date: Fri,  5 Jun 2026 09:57:44 -0400
Message-ID: <20260605135745.975090-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060437-sharper-renter-2852@gregkh>
References: <2026060437-sharper-renter-2852@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit e194ce048f5a6c549b3a23a8c568c6470f40f772 ]

In omap2430_probe(), of_node_put(np) is called prematurely before the
last access to np, leading to a use-after-free if the node's reference
count drops to zero. Move the of_node_put() calls after the last use of
np in both the success and error paths.

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
Cc: stable <stable@kernel.org>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260409101104.480623-1-vulab@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index a4668c6d575dcf..22d91f9f138e09 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -340,7 +340,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	} else {
 		device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 	}
-	of_node_put(np);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
@@ -458,6 +457,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err3;
 	}
+	of_node_put(np);
 
 	return 0;
 
@@ -467,6 +467,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err2:
+	of_node_put(np);
 	platform_device_put(musb);
 
 err0:
-- 
2.53.0

