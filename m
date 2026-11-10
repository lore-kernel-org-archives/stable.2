Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312856;
	b=PPgol1Y2IBopbr4gY7edxkj5B4A80PrSyFasQyy3Pucz9A2khq7TmtfZgkn3OqfwfyZm
	 FMyKZ9JOnEU/RqCaq3Z6MRsQqZullrXCTO0CRMqqjDaQAvuX+gCfeiCmg/J0QasIzPjNy
	 wEsRs/U8g2Mzzs0axCN5TM5hoixbxQfaR+dj/Zyokgxw6F94FqySLD8qfGSKJ1F1fORkH
	 h5fxOerkCRhA7h24zWzzIOyMumeO6zJC9S7gJog5Ldzmt+EFOCIzVcmOWn/K667qnU0MV
	 s6qt09i35EjWh6OZGKYCTMP1Tc6vjh6zrhW0O3tprZRfseIM79LjX0ZHdLH1yNPuelQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312856;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h8F1oKJNKqZ/OMArAbaLejoZ2v2KRsiZuFydFZ6oN2I=;
	b=sRvTAof/ioDbPw86o0C851fcFwMLbAvQneRavlMSvXZ7JkvAl7F2z6pf6Wg0FR7mfBK0
	 YgaHqbYTVVybBpGmxhUIX+DibDAYGF9wpLO+IIapuefqv9c72rgYAitD8SL9CR8++bmwz
	 Iv3SA+yVeC7f55ETBaJN9GjF0+/QmzpXxOoBYCZM5fKX0+VZh18nGsLUZ6XI+dumOMMGH
	 7OVqoWtnTy0L4Eg5ZFdP8LH0n2uvHLWHyZEELWw/2hPG0BVynmfvp4Hyp5Ks3oqoeDT/m
	 6Avv0P7DPQ/7iQBTJo1p7YljF+GKAq+tYQNvBwO/3mWHVeEq7LGtalIoY4tpXIf7OxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtTirbRB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B10606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtTirbRB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BFE1F008A5;
	Tue, 10 Nov 2026 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312855;
	bh=h8F1oKJNKqZ/OMArAbaLejoZ2v2KRsiZuFydFZ6oN2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YtTirbRBcFheE0UTvnsfbniq+ATs/mmgsvfQsFoUF0WiOElgpKCg8iAm7U4pLt6ev
	 BuCESuSHnPviecrgLEYL46lYv7JlbSWidpEpvNR8lIPctGqsx2MXrdtekr2frMX37O
	 hWonpEmTGfKlwvw6n7+2Kn9W71vmDt4uerfIby5F5GyqZqFk0walYAnoG2snglXuO9
	 3k89alcXHCUEtGVrntxS3tzeUgTyLhxuSib5p5GXIAqxZ0p1QzSVWcymfUMlo0I53l
	 uutHIHJZmKtd9jNQDKjLW1nfM5Lkr7CO2eeRdvYMdVjlO8EhzbgK/8ls9513hZeoBS
	 ni2JuEB6c28QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] crypto: omap-des - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 07:14:10 -0500
Message-ID: <20261110121355.981467-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121355.981467-1-sashal@kernel.org>
References: <20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org>
 <20261110121355.981467-1-sashal@kernel.org>
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
index 63785adde7a06..fdb5e6137cf60 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1095,6 +1095,8 @@ static int omap_des_remove(struct platform_device *pdev)
 			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0

