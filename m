Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311928;
	b=0otLwRcRMv7sXUm3w523/lpJJadwB8gHMVQSG1CJhhPGeTmJYs9PqESb582DnzFnLWKG
	 UUnVFplZaBOumMw/AJiScnMi5kYsWtacTVe6d9LpQlNF3Ao7rdRdzqvVFSVd6zmB+r335
	 irUE+tCNEqTCKN6fd+JuWe0+Ra3v/47MIpjaoa/BRqYP6PQdK/PdA0PlhOWf+OcpkNpS+
	 PfgpIlBpgEbb54/eEs7ElqYp6OHB1Ws//N3H9R/5Huo7CrxYb2p2hy64srxtGxDQgPyJd
	 2AvdW283OGX2FsnkQLBGp+a1uZGFjZPTe7JC+K3spTEaoWYY0Ttx7Tg6D43J/yEbEEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311928;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cORxNMhEeK8gnJMzl2tUHpFMY/7fDlTozOFx/XIhuh4=;
	b=NJfm+2ZLDgDieYcfVH3qZnd5DqF3FKbhFOrpgn1Jiq8AHGwKVVrtih9swBvdG0UxpmQ3
	 SaefwVEQr/1QW77TvYfcokJzmkx4WPXlhn4fYdUSFWfSpjnFISwCUmnzC+EPX3D/1io+a
	 4rWMDRJjxvIvXfhDRmyZCXEfxO6uapLvwqEYzccTwKGXvEfw1oMnh470J+zEZXrDLXCrj
	 jMmqdFmBAF30CRuAFq4G5DGX3yAZ+4lNAavY0+AEivm/Gsyu+cGTFfGYsubJeAWUSy8EO
	 VA/Dvj42TpTZGG1qmHEU5yxin0IxPJaZFm7IBH/h+fJ9W+Z4nAEkHgVyHgvQz5o9zpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksgqvjrl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3360A260E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksgqvjrl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4311F008A5;
	Tue, 10 Nov 2026 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311927;
	bh=cORxNMhEeK8gnJMzl2tUHpFMY/7fDlTozOFx/XIhuh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksgqvjrl/vPigYbM/GOsmrin5/AWh/Azn3VHrWJiehSqEO9M9FCw34K7ndsNrpVlR
	 ZeJaXTo8iY3aQT3LLwo2GyBCHPV1xre+MNw/n1Z6TYpuotBNHB9rR6rjnwLJxP4HjS
	 Ei0Jda6EidcD9M2s8w2KnwQnYRfJ/z4IvZITxH/ILTeLadBbcX7hFQ203SNQej+pD7
	 4YRcshZqKTAbqpO5wYSsCsYoeZU3ghnUWHnBZuJCVITYSy1XhhA+leEF+zicXT1LJR
	 j5crXHXfciniwtxSFFhmrA39ip3Rf3Ih0rWnnMSy2v/699dgnx4SzdVPbZDAimAU69
	 yZmLks1tvT20g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] crypto: omap-des - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 06:58:45 -0500
Message-ID: <20261110115837.921428-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115837.921428-1-sashal@kernel.org>
References: <20261107051710-failed-6.12-5d69ed4cd4f9@kernel.org>
 <20261110115837.921428-1-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e ]

omap_des_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: f1b77aaca85a ("crypto: omap-des - Integrate with the crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 096df577fe127..cccd275ace675 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1093,6 +1093,8 @@ static void omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0

