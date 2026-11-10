Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313825;
	b=Qwis5Kh/UUdjP8gpIH4dSGJO5mDezqIwzAl/c8y2THlkHgsUynV+ZPsZcZ39x2GA6fmx
	 2w1RKWCA5F05eKXDs8ad7giBo9nSeD1Bl5EHFB1+6bFKF7jq0o+GLbkS9RB2CwxsQdssA
	 KdS58CUAmizUoTmqTtwLIvLn4eDjegLlCEGuzXT15c7+7NLt/bIPixHABXfrJx8IZThfz
	 i/ivnXr1jHNIOYo+pORGKenVM06VFBj7B9mz4RkxGVGusSIrscnAEH3qRdTA6WqtPLHCN
	 1nC8fwKPbRmc1hP77uqtS5D5/tckjVKg2xrV/U/7WpvaDV1AWCyM+77qGlUowDQxwZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UEcWfbhl/3fvZaeBiDjyI/3x9738nBL31r7oCNWDdiM=;
	b=Ri4v3ovf54gZZLQiLOxG3rQOScWOq3aNOzqAHGspIRc7kEwaGcf9Xqs6hQGASyACsuDx
	 Evu9ZGt+EvMesksiRGzVYPkSZ+CdvuCp4hjAdoYFZ/zGPAHlcmUUN9Diut8yBBUfgjbWe
	 jANwct9o1zHIFWy7M4fAG4j6DAQlOFWGlYjOp18oItKjgo2cNWURGTDENn+rEVw3qVz0B
	 Y4s4G4cfCnp3QHMu5IqKZivrIugOTCh8HXwDXPKC23RTOk6rJDDU9LE+Img2FIjfDc3Mh
	 FFnskt3T7hOfeN4MurAvU6ynC1EUkqYSaqR5O39o9OGK/KKgKPqmZM0hArgzr0KbvQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTKAFDFW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74137606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTKAFDFW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AC41F008A1;
	Tue, 10 Nov 2026 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313825;
	bh=UEcWfbhl/3fvZaeBiDjyI/3x9738nBL31r7oCNWDdiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTKAFDFWOUQVRrC7LuLDrgFfqZvByKDO498B+G+aTZ1yb/knuL7rM6CPsI5cdUnbv
	 bcMqQ//V5Y842hiWUBQAslRDgy4I53CjcQB7/zuQq4RISfKkKT2/kBZ/TwQ5FkH9nB
	 hkz7HmOIOLgZGq5l3NwRuL0laH/3oG3eoqsa4ymIfny8bHNksUOH88az/BXiWHDMSi
	 j4jKHcAlnT/pRQe7X8PW28Q4F4C9uQPWDkmgAf5dO7682UOXusFXoVH0ITf3wXH5vq
	 CNNoI3NrKT/U55OfZXBq/SNr9EiqGGCFU/KjnkHxDn8CKVwA/Ymz6wC/0lGDXlQqi3
	 ViicQfl4JtGxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: omap-des - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 07:30:23 -0500
Message-ID: <20261110122957.1214291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061609-failed-5.10-5d69ed4cd4f9@kernel.org>
References: <20261107061609-failed-5.10-5d69ed4cd4f9@kernel.org>
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
[ sashal: Adjusted insertion context for inline algorithm unregistration followed by tasklet cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 7fdf38e07adf8..01a1f5ee64c40 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1105,6 +1105,8 @@ static int omap_des_remove(struct platform_device *pdev)
 			crypto_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
+	crypto_engine_exit(dd->engine);
+
 	tasklet_kill(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0

