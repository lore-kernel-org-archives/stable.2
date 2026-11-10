Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312285;
	b=tm9rNKZ5WlzrlKsTb81KfOtzPvg5WQ9vg+QgR+nvdOBsm8sK0X+V/+uAuZOinrEs8IAm
	 ivntvAPDzG5t+jmVBvNMDKsiqc/H6zWUocLrT9P3SQXwmAtYCd91M4emP/x/43+4nEU7V
	 RdHVJASWTLySBZAt1lI4aPddOZdlC7ZSirQjqZsEaBQEvX9x4pANQBKUdG+5Bz+N3ZEa6
	 m6uSK6IANoaSgJ/fwChIeuQCm8S3HOny/w13O67l+wsbtDKVGTOuV+D9D2o9JnztRrizu
	 RKZObK52JdFa+oZJ4nqN3Y+FCZtDcO+qiwC4GTKcg9O9d5RDHBB7UC1Rw1syMhLcnaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TaGeUcMRWawKwzfxpnhk01CPeu1bcMplJ+oAQ7hO+QQ=;
	b=WgkJbY1V7vhEx81yMtRyfpDPZivKhLArjp8wHgDONdQIzVwAAlc9itObU0POjPfFOEWn
	 4dSHhJnaFjvHt6msV5PEuibCZUilOJEsJTGL5gSAysZBbnmMV0qKDBOYrfA8jOf9/LGR+
	 mw0SyCfSqBxCF66iNN55vJeMvvEe/mvofm6kQ83qz+IdnEogHzarPYa2suaYOBTax6wLG
	 Rfy0Z0Axqtzu28kY91sd1pZqbJ64LzwYh2jFsGGFY5ClAe+4Tbn7rEuhbUYyjQ6ZtxNjF
	 X8xVzDhcpCnKJ1bqqQ6tpAtlh2SG86fL4VGsZpKvwHozQj35VXguklIvphAlRDkL4Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2taFamE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815660A2602
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2taFamE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93CB1F008A1;
	Tue, 10 Nov 2026 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312285;
	bh=TaGeUcMRWawKwzfxpnhk01CPeu1bcMplJ+oAQ7hO+QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2taFamEQlKG0/oV4mLZFNDwg8COnx5due7bIvS8S82Fv0tP6s2678O4i54ssg15i
	 yotK49jSBcwOzIbDdNxfVEbnCkrmS60tSku+w/el+BbSjUMVMqOgmtMC5W4Vj2AS1v
	 O4wUkyWKcENk6jHg8IdbmEo7fx0lOhemDdfBsgqmKO7sK61A5YcJqFTWhIQijEffkM
	 VMKxwPKEtwsgFDcXeQ1/4OkkIcf8MGgqUMsEcpBOHqt4O+RwdH9EtoLuYpSW+kpcYw
	 2AK/u6rYQqw8qWLI4r7yiZAKte9jBdaqeuaolTLQsG+cGbH1GHGRbXQbIUlo7xMMXq
	 zGCHNr3gmyu3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] crypto: omap-des - fix crypto engine cleanup
Date: Tue, 10 Nov 2026 07:04:42 -0500
Message-ID: <20261110120434.957099-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110120434.957099-1-sashal@kernel.org>
References: <20261107052926-failed-6.6-5d69ed4cd4f9@kernel.org>
 <20261110120434.957099-1-sashal@kernel.org>
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
index 375d756efbfba..8200ff0be297e 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1093,6 +1093,8 @@ static int omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0

