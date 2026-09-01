Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6E47FAE7
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290905; cv=none; b=CZDxlv+VYNx4rkTzKUMHYGtaAWo/oPOK2QUoSF2+TxBnKZeMvPgIIQPS1arVMi8KX8ifR0rE2a69iFofYl8RKjeovJgnkPoEdz6v7zRXu1m+EVKRTEzvZiTAM21M8DAPczwE81PQ4rhqQS3S9kaAbdB4st/7qp38BOqej5psus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290905; c=relaxed/simple;
	bh=ZLXGiUH3DPnHRM5LsnDlgYkuOWbtqthYXbs4oeNSY5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUpP0Sa4h0GUaoRiofGfIMIKyDowXRMM8FbioSRgcC+pgrOjYakXqR5GcquztyyKTBypqqvspH1SZAWW5XMoGtsHm0U67HNV+MlPO4rOoDzjKsLSy6WwRTLdCE4Z8uYDk2bg/QPhpXdOo27aYhzVvPDzVpof93OGbs7Ij+zF6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E25YhSrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E25YhSrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D65C1F00A3A;
	Tue,  1 Sep 2026 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290904;
	bh=5rt03fJPgXkyBY+Ae6S9Mp4yTjTH2rBbV7zfRZjQWlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E25YhSrwPTrTiypfT+thf4mOyVcTZblOVsPLPM8HPKcbtRvYCBvHAaiQtVYH8at5G
	 Kbv1zKLSpJ2IzI3VOFnQ/0iahs3f0jCBdZBgXLKf43v3FUhZ+d+DisGl0bVQzLOheL
	 fzPKlOmUTefrFPmK0Q6vmIGp9+sMw9N+59obMJSt5tzVR7bVvsrfd7WDzxJGtCHLZ8
	 fIuyz1Fo3CXEVUnAB00QJIAg+Y69wP0/hN6N1RKy7uZoT1oLZC+PoN3Iol4dQWP+lp
	 scs9i9hRkAmjNf5Y3J+HYjDGJPxvZuvXsEDncng0RnNKykp/tssxW8aiZNvCWLGX9P
	 EsgW7FziarvDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] crypto: iaa - unmap dst before software fallback on decompress
Date: Tue,  1 Sep 2026 15:28:21 -0400
Message-ID: <20260901192821.1439160-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901192821.1439160-1-sashal@kernel.org>
References: <2026083134-rockband-cone-6be0@gregkh>
 <20260901192821.1439160-1-sashal@kernel.org>
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
index 904d9413ba182..cdfe00464fa36 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1058,13 +1058,17 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
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
@@ -1447,19 +1451,9 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
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
@@ -1647,13 +1641,16 @@ static int iaa_comp_adecompress(struct acomp_req *req)
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

