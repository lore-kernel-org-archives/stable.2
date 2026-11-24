Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545472;
	b=cYyCZZFA+9E2adLWO8sGD8KuRDlmBHqYkco20bM3l369Wfev5gvhW6J2O/UvsBSY69+e
	 sjpruytuoH7QWgf7Rda+skeNEglqjYanOOVokwfzs6/2aFrAZQJsZ79Ih71qu6b5fPn76
	 D6YxKmB+p6sHvKcmhtzd7EVawqxZLHl5Rjsufetb2WCwcba76C0GUtHPcb8AiAlfiqVga
	 eAqsBv9rqmdbdV9uNh2ApeeFRLm2mmtrbuiu+KmK7BgnTrG1R+BfQxImZxXbjwnFlOTTy
	 KLMnzYPtIkjZyrkjX+PzZImDCehiHP7cFEAHRFCzxkm1eLod3xaTGkjPoVeWIq/HFiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545472;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gQGC+FBgiW8OgSyXBh0rVn3zHzue2QO/rFXrkqlznlo=;
	b=5D9qPBjwjBfLOJsFzwubw3wNFHRPTWG0aSAzuaZYBOCIgCXgFnaYVve7dM+ePxRthZ41
	 TBldT7u2AsO39EFW5/c3H2SXApVQ9+BPKxWNBITIbo+RU9XXvnLccZn5mf4CZDH2aA67u
	 0CGi5h77K2JkLTNzQkjet3sZEoIcQ5v19YVsCVuPfxsFhbnFrZxD+zTAnDrCgtHIQtCaE
	 OtoTED28ArdG/VEoZJecC6rCW4SbyvBQemi2MI62dS+2KjF2ctTL36Z2jdz4CXcOWPX6p
	 ftsUs7jkrdKFlPtLg22nUpVW8FkqudyrWLOQmYzzveg88qC4PA1ACCPQx6ZVeZMhHPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhopyZ1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225F606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhopyZ1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664941F000CA;
	Tue, 24 Nov 2026 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545472;
	bh=gQGC+FBgiW8OgSyXBh0rVn3zHzue2QO/rFXrkqlznlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhopyZ1yrRVs0vu8vvpXair18rFQxvKLReVjs6vNw9xWjpIMTas0lN1X7bnX5jV9j
	 glFwXt8eXwd0aaaYQmlPlPpo+nmMl2QQkgua3LlDQFTvq9hNNllCrsY1FalH9XA8oq
	 I+0F9ZTOYmtDz0xrTI2PkjNMPgx3L/baaBhohPS1qUxBfVZd3tRF8c7hjZ1gj5GnrN
	 WjmbpvFcsSjrDw4M8YRjIXTQyfEwvDRfMNqpj6ZZSNo9AvaTDRWYGHhSIwck+rL6Zn
	 ZIUrhEHfSopnvfVMGc/mRBCGt4UiXLwv9wdSzk0hi1e9bJXBlNFC7zSMxZwbJ3DFWH
	 PGtihFiMN7IXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] mmc: sunxi: Convert to platform remove callback returning void
Date: Tue, 24 Nov 2026 13:37:47 -0500
Message-ID: <20261124183704.2394957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112400-clumsy-mobile-79f3@gregkh>
References: <2026112400-clumsy-mobile-79f3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit 805946a2ce31241299a725adef8debce56069495 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20230727070051.17778-1-frank.li@vivo.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: e35e360bd668 ("mmc: sunxi: fix clock and runtime PM leaks on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sunxi-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b834fde3f9eda..67e05d7000991 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1453,7 +1453,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sunxi_mmc_remove(struct platform_device *pdev)
+static void sunxi_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host	*mmc = platform_get_drvdata(pdev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -1466,8 +1466,6 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	}
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1521,7 +1519,7 @@ static struct platform_driver sunxi_mmc_driver = {
 		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
-	.remove		= sunxi_mmc_remove,
+	.remove_new	= sunxi_mmc_remove,
 };
 module_platform_driver(sunxi_mmc_driver);
 
-- 
2.53.0

