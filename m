Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F920DD51
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181358; cv=none; b=eClOMKTCsgln3bghIVTvJw5LPHrk+Q+Bn2KOcPK5XsfvheP2SdtdHTAR8E1jLJ13tXeEPpuJHzl8Z7KXWTqSQhiXmXj5f5X87Zr9x831d/xQknRqk8eciRZCN4+Yc/6QyRVNqOTiQoBZs9HiwbFBLEskmU16uwnu0rmOAugNICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181358; c=relaxed/simple;
	bh=7JhOVsaDqF0dq5z3y/A2wYu5beHTcw6FyqTReMUfg3w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OjN/yXVHD2bZqIY2PECXyjSUjehBmLdDqI6OBzXMsjPKG1n3UTAgLigGbZPQRwLLWdNv2dT7m13gYqijhtmMPutmJWqdkoLEKSrKKR82seZw8PUqz8ILVZsm3/ctriD59HHcIJvUBhLMr1JENfKirBe02mOnSMa/QM0miu78Sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FNM8YyAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FNM8YyAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0050E1F000E9;
	Mon, 31 Aug 2026 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181357;
	bh=Zu5p8+oT1VYQ9xFUx6LPAkiTLh8XZN7prOwW9jMCnh0=;
	h=Subject:To:Cc:From:Date;
	b=FNM8YyAkC/Jp2pR7VNaGWbirkGFc55yFzbvL+VEV0j8BBhKKpALgBgYHP0oh09YoV
	 ElpK+YkLxDNV9DbC2dS2DrWynyN/YdNYEZ23ro/DZFpTNzdikTpHmaGczIfRexjBOO
	 sZfEeD0JU4mL6new8aDlyBroJlweEJecz7vwMjgs=
Subject: FAILED: patch "[PATCH] crypto: iaa - unmap dst before software fallback on" failed to apply to 7.2-stable tree
To: vinicius.gomes@intel.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:02:33 +0200
Message-ID: <2026083133-salvation-murky-0b4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 94a25930477113730372e0fa2985da4c5ac95c9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083133-salvation-murky-0b4c@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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
 

