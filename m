Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E42D1913
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300374; cv=none; b=B1EhlWImETOGlfJOi+JMrUYhkBhRro8taKd3tkttFya/bMTXPN3Vy+4M6v6Xf5AfoVisr9MG60+4u5S1o4mTXG6XtEQbeidsz/++wHoiGySw/pNDO8tadZ4AliHhh6kOM6CuafP+8Lx5daap4s/nhoO8fPf3CvG0Xs8p/O8atog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300374; c=relaxed/simple;
	bh=xBmg/ylad0hIfwRi09Ex3mvIGnVRKKqBJc77sDvea7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKYI8SIeUve2efDHFqvu4hdIKeo33U4+uXz+gusD2n3/aoP+pk0I/UxW1pauFY6EhjOw6V1sebeMzSbMohDJZOsB2d6D2lUwCQYCJcoqEXLOwYGl44gltHWpPGUDDG2l/4d4RNxHmtFGoNu4NIalaHDvD5Odgov+5DtzSBp24Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHxqr+BK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHxqr+BK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03131F00A3A;
	Tue,  1 Sep 2026 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788300373;
	bh=63ekbytaCVO4tFkofUsqTRXqgB1BMDox7jUT8DmqAU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHxqr+BKk17V69t1EbVuyVXLo7su40VxSPA9Mv4Z8dyES/b5W+ytXLJCxe79BdT62
	 MxfTRDzcgOBXJTuNshMxWodKb4P/aL3+fp8iTWwvcDutmM72YVlnSzUcYA1nQRsL5k
	 gcVqy+k2tikINNVTJfo2MKN/dh5CvWGGmbI4InfAA8/nSoZ5ekfSrGK1jTeJ4UXbps
	 5S/DdIAKhwJZL9yf1Lwa7woxvdcKKO/hdXGJ5c5gSGOhPGwtY2Xe+eZnnuYN75tn3J
	 KgilwhxGiJxGec8JAQgayJKJhbMHzDuD8RH5C5HefL++QglLHa1teV9PMS+593EsZX
	 sNKKpaBpmM0EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] crypto: iaa - unmap dst before software fallback on decompress
Date: Tue,  1 Sep 2026 18:06:10 -0400
Message-ID: <20260901220610.1681251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083134-playing-sixties-bc6e@gregkh>
References: <2026083134-playing-sixties-bc6e@gregkh>
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
[ replaced unavailable iaa_unmap_src() calls with direct source scatterlist unmapping ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 36 ++++++++++++----------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index e40dd6afc76ca..ef86706f0e5e6 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -987,6 +987,11 @@ static inline int check_completion(struct device *dev,
 	return ret;
 }
 
+static bool iaa_error_should_retry(struct idxd_desc *idxd_desc)
+{
+	return idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR;
+}
+
 static int deflate_generic_decompress(struct acomp_req *req)
 {
 	void *src, *dst;
@@ -1050,18 +1055,22 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 			       ctx->compress, false);
 	if (ret) {
 		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
-		if (!ctx->compress &&
-		    idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR) {
+		if (!ctx->compress && iaa_error_should_retry(idxd_desc)) {
 			pr_warn("%s: falling back to deflate-generic decompress, "
 				"analytics error code %x\n", __func__,
 				idxd_desc->iax_completion->error_code);
+			dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst),
+				     DMA_FROM_DEVICE);
+			dma_unmap_sg(dev, ctx->req->src, sg_nents(ctx->req->src),
+				     DMA_TO_DEVICE);
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
@@ -1446,19 +1455,9 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
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
+		if (iaa_error_should_retry(idxd_desc))
+			ret = -EAGAIN;
+		goto err;
 	} else {
 		req->dlen = idxd_desc->iax_completion->output_size;
 	}
@@ -1650,7 +1649,7 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 	if (ret == -EINPROGRESS)
 		return ret;
 
-	if (ret != 0)
+	if (ret != 0 && ret != -EAGAIN)
 		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
 
 	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
@@ -1659,6 +1658,9 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 out:
 	iaa_wq_put(wq);
 
+	if (ret == -EAGAIN)
+		ret = deflate_generic_decompress(req);
+
 	return ret;
 }
 
-- 
2.53.0

