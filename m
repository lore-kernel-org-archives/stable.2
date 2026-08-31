Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E21A3160
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181367; cv=none; b=F0BJQdtHH8/j+9fGz3+x0EfP9n8xFblrSzrWQlZpq/0yMZDsNtjbKAT77Qe+lMBJFUj8cdZHU/qiFGIJqELxUXCzYwenRiIzg0tZv4D63BiBxBrwR9Vzn9CPHqfQMlVfD8Ryif4ESJ2zeAiWz8K2uKhQzk28jAluzJu1eT5hnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181367; c=relaxed/simple;
	bh=7NZ1x183kqpe+3W9QqrNlw/C27keTFoRWf3drPHOH60=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tBmHAZ6wRwdXZWSk9pt+HNAXsWkeusy5T1BGS32hclMyFEiJecHSVWY+pGpg6euAGPvYPEG0wMpmaAwXvppTS7l0Hk4RMhihvvbiKPYDbiI4G7x19ZwORI0AlsBmNuVNumJzdu+n9EmsLGo9cAbrbIpvnFhXWJ1kqmR2dP2dyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Evuoowsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Evuoowsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546D81F00A3D;
	Mon, 31 Aug 2026 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181365;
	bh=wn0hZ1S7nQaMeElkE21E3W/VoISOcvAHTUG675QOeMU=;
	h=Subject:To:Cc:From:Date;
	b=EvuoowslknzRVxW/21LArpmbfzy8LqG6iKMcuGaWezd8egCTEn20hdx2Mc88ej8cT
	 nSx/+zLPoS6VsUnJ6EUWFaa1DU4xCHThSNlwCsZ9Fer+VIXhyStk0lXU9gwEB0MUQ6
	 JRO+yiC+QbBGNNiroEG5UjPSpIcq1wKkJEp+QKo8=
Subject: FAILED: patch "[PATCH] crypto: iaa - unmap dst before software fallback on" failed to apply to 6.18-stable tree
To: vinicius.gomes@intel.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:02:34 +0200
Message-ID: <2026083134-tightwad-trilogy-bdee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 94a25930477113730372e0fa2985da4c5ac95c9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083134-tightwad-trilogy-bdee@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94a25930477113730372e0fa2985da4c5ac95c9a Mon Sep 17 00:00:00 2001
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 5 Aug 2026 14:19:26 -0700
Subject: [PATCH] crypto: iaa - unmap dst before software fallback on
 decompress

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

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 51547c5fcf70..c9ab4b83ae02 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -995,6 +995,11 @@ static inline int check_completion(struct device *dev,
 	return ret;
 }
 
+static bool iaa_error_should_retry(struct idxd_desc *idxd_desc)
+{
+	return idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR;
+}
+
 static void iaa_unmap_src(struct device *dev, struct acomp_req *req)
 {
 	struct iaa_req_ctx *req_ctx = acomp_request_ctx(req);
@@ -1082,18 +1087,21 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
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
+			iaa_unmap_src(dev, ctx->req);
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
@@ -1477,19 +1485,9 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
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
 
@@ -1722,13 +1720,16 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 	if (ret == -EINPROGRESS)
 		return ret;
 
-	if (ret != 0)
+	if (ret != 0 && ret != -EAGAIN)
 		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
 
 	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
 	iaa_unmap_src(dev, req);
 	iaa_wq_put(wq);
 
+	if (ret == -EAGAIN)
+		ret = deflate_generic_decompress(req);
+
 	return ret;
 }
 

