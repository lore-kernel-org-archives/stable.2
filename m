Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA73CB2DC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580286; cv=none; b=BsB39xVFvqmeC2862mge10WYV48ta2NoaRIRauMBkSRxmOdyoD6MiIxfoe8/KVYik+zVWlYps5cWZ0DCZL+Akcxat5mL3JYMZDPATGAD2B9esn/jB/PKMDVBGB1okasRZrvIPv0HubSxjWrMnnFYJHibmvkkA+buex4y13IoFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580286; c=relaxed/simple;
	bh=rqs2woQGU4CbfWKESyVMi5BCJ0IoOT6sr9fLCPDiCHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7/6rvCgheNO5dLNBmM/GTunch8WKsBnI3H0XxJOcI4I7aVErfkYu/7PIchRIUitm0pYQdm/9u0IXwsNoz44H0aOICu6QnT0HO1uS50RqE3WvDnLkPDy3errSCJDcUv5w804Ci6kPvS0JwYHID3WaoUUubHmgkPu9Xjb30mbYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJCXSaCq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJCXSaCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071031F00A3A;
	Mon, 20 Jul 2026 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580284;
	bh=xN0oMcuAE2vi7HkBZOUG8Ttb1Hegf/AZALaW57EeKiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJCXSaCqQTLJ+/t6uo5YRLjX/UVOKxCwDhZCkCTQ0AjmuSX47ATBd2DNNhvvXrwT6
	 jlcnSbA2LphZ9EaLyQef28sKg0niDEJBfb62u9RuKEIxUFfe03LiF5LtytGVp1AQbf
	 ZJkI6/YTN4TuYpB1fmbmV3dlLE1AH7kBwPG+Ph2kniu03o+0I+ycVkibWCSU84+CT5
	 W08KvJ0MFQW5fPA2JwuPIIs6NKh4WecGM1EJJY9EDt/hXBJtz5T1YBD0tyZRdhnxLa
	 qqIt7/NPoXNYSaSqSaLywKucKC6uvGinkE9Q9JA+bToE7UyMHa4TndbT4Ka72nskDb
	 k6alHW9mLHBjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Laurent M Coquerel <laurent.m.coquerel@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] crypto: qat - validate RSA CRT component lengths
Date: Mon, 20 Jul 2026 16:44:41 -0400
Message-ID: <20260720204441.3339249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071549-wrinkly-pogo-6277@gregkh>
References: <2026071549-wrinkly-pogo-6277@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit b3ac78756588059729b9195fcc9f4b37d54057a5 ]

The generic RSA key parser (rsa_helper.c) bounds each CRT component (p,
q, dp, dq, qinv) by the modulus size n_sz, but qat_rsa_setkey_crt()
allocates half-size DMA buffers (key_sz / 2) and right-aligns each
component with:

    memcpy(dst + half_key_sz - len, src, len)

When a CRT component is larger than half_key_sz the subtraction
underflows and memcpy writes past the DMA buffer, causing memory
corruption.

Add a len > half_key_sz check next to the existing !len check for each
of the five CRT components so the driver falls back to the non-CRT path
instead of writing out of bounds.

Fixes: 879f77e9071f ("crypto: qat - Add RSA CRT mode")
Cc: stable@vger.kernel.org
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Laurent M Coquerel <laurent.m.coquerel@intel.com>
Tested-by: Laurent M Coquerel <laurent.m.coquerel@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 4128200a903293..4437c3a5c6dd73 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -1032,7 +1032,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->p;
 	len = rsa_key->p_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto err;
 	ctx->p = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_p, GFP_KERNEL);
 	if (!ctx->p)
@@ -1043,7 +1043,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->q;
 	len = rsa_key->q_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_p;
 	ctx->q = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_q, GFP_KERNEL);
 	if (!ctx->q)
@@ -1054,7 +1054,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->dp;
 	len = rsa_key->dp_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_q;
 	ctx->dp = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_dp,
 				     GFP_KERNEL);
@@ -1066,7 +1066,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->dq;
 	len = rsa_key->dq_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_dp;
 	ctx->dq = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_dq,
 				     GFP_KERNEL);
@@ -1078,7 +1078,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->qinv;
 	len = rsa_key->qinv_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_dq;
 	ctx->qinv = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_qinv,
 				       GFP_KERNEL);
-- 
2.53.0

