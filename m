Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317166;
	b=NNplKX+H+sIsDrGO9ZQi1J1R8vLP9KIBYoT15y/8w0lt2aay3tGMxR9EGhMZPwiRh8hA
	 ymuqeyQZMoMyIpq3c1IJBZMS0nOtHyLqx1xk5KL9HC3xCKQB6ynkDJjtlls8CUDfWLCc7
	 ZibZgDp1kWvHzDIHg8IssljuLYSciZvfiXBHlBIFlyYQm1WWo4gFY5EuNka8jvyE/QngX
	 8MxumBdZPvAX1ahKr7c5HoG8wcR4KfbOv2vbG9b1zkWGripurnCTXns8WUhdIsQH/WdC2
	 EoenVsJpoBUHnrVHmm4zBMi5ENJzmtwnZYHVQ1LoHU46l3xTsVYgmaOAWdPNGqb5wjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cE/0I+S/kjsFQb8qbnbmx7nBlJlMy9VDY882XBbWEhQ=;
	b=N6vAafI2nxXKw9LfcivCqFaVpeNU5+MMSyRpVjGWXXQ7vhqbMkcDwD/ElVG5NJ8OmUnX
	 /vvDbDU6EJcnbZH0e7i7fNnLfXJwbBLeVpWBX5ZEWge0LwzbeG3qgEsJFydoAHlHQg3MJ
	 BHRjhwyqyDezdI+S+8BZFxSroibGE/htJB4sLYbe+DFhL+4jfRy+4oRtQEKZ2ucxdH/QB
	 62jqccWiVzGrKtHRaAVv3jJoZlbu+p5icdohbv8IYt881gWGtIadHDiqGJtLCHeWBwL3O
	 lVTQdWtEaFJI0Kl5c+O/agB1Pl943m/ZsnbAwYwHb1O3gklo/YX8cSQypNdH/yWulPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdTF+BUg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21A6072A3F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdTF+BUg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517211F008A2;
	Tue, 10 Nov 2026 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317165;
	bh=cE/0I+S/kjsFQb8qbnbmx7nBlJlMy9VDY882XBbWEhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdTF+BUguJylaBxBV/QIF+5CW1TycWf36kTl/Oz8wyZSO4zJ9HfkFc8Ql9JNDwFR+
	 D6lJGddA0MSc1TTdB7SwVILX4aiUpfQAhXYBJKomn+is2TG+Xp7A9gwhNUUa7xMGbo
	 5o00osiHVD8SO/je4esOCvcq67un2EUMRdi4GoAzq9I8YiR/DeDjrzUxKPqhdh4uTY
	 Dcc4+KUeni13Fc0cQYR0huF5SgRBnT3T1/fXK34UlYDXsSp/raG9KGZniha4L50ET4
	 DcUO4K4GSrkluQ6kWBlijwYY0srZMx6wFRPwJuEzVoUVYR/kNBPw+UAaUStoU5OwpA
	 JLGWaQts7Kqeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] crypto: omap-sham - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 08:26:03 -0500
Message-ID: <20261110132556.1723904-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110132556.1723904-1-sashal@kernel.org>
References: <20261107054212-failed-6.1-be51ea091c65@kernel.org>
 <20261110132556.1723904-1-sashal@kernel.org>
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

[ Upstream commit be51ea091c6563158531e8c74e040552fdb1e28c ]

omap_sham_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: 133c3d434d91 ("crypto: omap-sham - convert to use crypto engine")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-sham.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index cc11bcc10e279..c57d6bb5c4aba 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2223,6 +2223,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
 	omap_sham_unregister_algs(dd->pdata);
+	crypto_engine_exit(dd->engine);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

