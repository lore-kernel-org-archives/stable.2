Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8721356743
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673472; cv=none; b=kQoPcvq7blFpkskHBrScKT7bpAg6LOsJc5AmfpVLMB25WozsYC4vV/d5RmMpJ5NHaMopQjxZySgRS/NFNFwfoJcVWr831diKJA+oQAQIkjjWjKht47J5mXHz5UXWYj50gao58gsocZ/1pvcqRymz8MadHTEqcmR4Lw+UFbVKrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673472; c=relaxed/simple;
	bh=SnODujV3XXPyXs3eVUSGArAiOmH6SaZ+iXeHo7PPjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksDmQ/B4IYWnXAi+suwM9Hv5E5hUyZy3CnDXDgOf+Ltpuj1fW4qyEFijh87Fg8K7P0DfP2zm9bO1K7GUnvFFx8ItoMLVM79djRug2C5aymzSgaf4qgygevSd8B45fxizJBiiqK0lbbnt2qQ+NGfsDISQiqIEGFG7tVD3vuhT0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKQTcu6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKQTcu6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10EB1F0089A;
	Fri,  5 Jun 2026 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780673470;
	bh=s8XnnIW6Bv+syaObhYh1/T5DkWXuk/GyLQqPC9tlMjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HKQTcu6upDZW+2rJ+P+UwpnFd7Ep2QYMNQqhWVuBwh1z5+1oLllFQKtFz4KDTsIaI
	 bqvaF6IiVgVOw0Pzjsn0j9FlKV9y3eGI/+qOaniWq1UTxiB6eRq/9tpUmXu/PZi5/G
	 5APx2/2q4KUdp9cbuP+pOv89VaVezl0uzSStTPKrHZqbyCdqOGxrWYvtuXFKngSHz4
	 DhX3883JbPDJC51GauoTMRXp/WrfQ7gEo57OL4ei9dbK8fFoNzxim6jxLv3TOQAnOh
	 b9kXHP/14dSGoi8JwngwqqiFLpXnos8R0erbZgRz126D9Z0c8zOOql7hylVkioZFCk
	 Wm0lS04vpHPTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: musb: omap2430: Fix use-after-free in omap2430_probe()
Date: Fri,  5 Jun 2026 11:31:07 -0400
Message-ID: <20260605153108.1929169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060438-hedging-paycheck-ec7a@gregkh>
References: <2026060438-hedging-paycheck-ec7a@gregkh>
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

