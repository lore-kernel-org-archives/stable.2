Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988D39CD18
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291834; cv=none; b=o3sMYUmr5IQ03eLty0oMr/cuWAEK/Cm67tCD6r8B5cZclh+E+KtrmZvbtTZcdcNzzDA8IfSieVHXY8W/2uYH6Ekh0Vl233Buz9SdfTnkZxmh0twyXZmIKIq5V21lLHqWxMHHRMOg7ZEW3wiglstHyRyOqCeUFWb4l/T/HhNByKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291834; c=relaxed/simple;
	bh=exWUJm53gIAlvOQODd5nmf/aM1apCJrBD/GNApV8gdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmTAj7vvVHy4G5hqdDcbnosF87ILS96IR7xokNE4dutEpeshhkkvK2/bOY53cZPHNV5mflw3vCLsAelCiMzaJOTEwVil2cNLpXLFYDMtTpXrcS0QA7xYajXwY/lVdGrMO2YktwApphvrYIDM1zhcrxushKZ3OdFaIX54NI6xZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP4OnQd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP4OnQd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24181F00A3E;
	Tue,  1 Sep 2026 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788291832;
	bh=sPNU0Y08eBPM8yGifwv6GPz+A1u7YVX97NliF97DTyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WP4OnQd347Ezpc3qboyh3MFvfBrcK24DtZMaWhm+6hCFyea3+UZuvFTzljCBBCN4W
	 imJRDTbUrt0C6xbCmYfOkc5Am3J+WGYxj7g9oEI5acRzE7oPUm2OrFOuyxgkWGT0rD
	 g34ObJ/J/pbM5fxqb89HFyDZ6w2V8kWWbPuYw6d5sUXcskqBGzv8raPY9EYM0hFWkM
	 3Oqwknn0D/ryw1fOU5PniCG1GGNtEp5jgE/R0ix12GgNBMGS/tO3RCTZ6+YCWjY7sh
	 2a35qlXUwlaFKAbYBIpDx4muF5z1YyWUKDxesz0tYUuG3u5zILGBeSJbk2fC5I4jQt
	 QYkqpNK15GVBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] crypto: iaa - unmap dst before software fallback on decompress
Date: Tue,  1 Sep 2026 15:43:49 -0400
Message-ID: <20260901194349.1447018-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901194349.1447018-1-sashal@kernel.org>
References: <2026083134-tightwad-trilogy-bdee@gregkh>
 <20260901194349.1447018-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 94a25930477113730372e0fa2985da4c5ac95c9a ]

On a hardware analytics error, decompress retries through the software
fallback, which writes req->dst with the CPU while it is still mapped
DMA_FROM_DEVICE. With SWIOTLB active the later dma_unmap_sg() copies the
stale bounce buffer over req->dst, corrupting the result.

Unmap before the fallback runs. The async path unmaps inline; the sync
path signals the retry with -EAGAIN so iaa_comp_adecompress() runs the
fallback after unmapping.

Fixes: 2ec6761df889 ("crypto: iaa - Add support for deflate-iaa compression algorithm")
Cc: stable@vger.kernel.org
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ adapted unavailable iaa_unmap_src() calls to single-entry dma_unmap_sg() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 27 ++++++++++------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index ca0790ed4a122..6eabcbe461455 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1063,13 +1063,17 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 			pr_warn("%s: falling back to deflate-generic decompress, "
 				"analytics error code %x\n", __func__,
 				idxd_desc->iax_completion->error_code);
+			dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst),
+				     DMA_FROM_DEVICE);
+			dma_unmap_sg(dev, ctx->req->src, 1, DMA_TO_DEVICE);
+
 			ret = deflate_generic_decompress(ctx->req);
 			if (ret) {
 				dev_dbg(dev, "%s: deflate-generic failed ret=%d\n",
 					__func__, ret);
 				err = -EIO;
-				goto err;
 			}
+			goto out;
 		} else {
 			err = -EIO;
 			goto err;
@@ -1452,19 +1456,9 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
 	if (ret) {
 		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
-		if (idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR) {
-			pr_warn("%s: falling back to deflate-generic decompress, "
-				"analytics error code %x\n", __func__,
-				idxd_desc->iax_completion->error_code);
-			ret = deflate_generic_decompress(req);
-			if (ret) {
-				dev_dbg(dev, "%s: deflate-generic failed ret=%d\n",
-					__func__, ret);
-				goto err;
-			}
-		} else {
-			goto err;
-		}
+		if (idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR)
+			ret = -EAGAIN;
+		goto err;
 	} else {
 		req->dlen = idxd_desc->iax_completion->output_size;
 	}
@@ -1652,13 +1646,16 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 	if (ret == -EINPROGRESS)
 		return ret;
 
-	if (ret != 0)
+	if (ret != 0 && ret != -EAGAIN)
 		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
 
 	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
 	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
 	iaa_wq_put(wq);
 
+	if (ret == -EAGAIN)
+		ret = deflate_generic_decompress(req);
+
 	return ret;
 }
 
-- 
2.53.0

