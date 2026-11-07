Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050200;
	b=z1tJkN3AtJLihM6VYRqVb3aJbqEECUfAh88rWhajRJmvqjdg13n+x/SevKssjh+MmwfP
	 jwtZ9zTjHK6/02VR7+zWs45BJFlIj7crBbbgpxfAdw7qLziajOI0Q33fLkrMyiEXQ591H
	 9mJKnpjMO5RwPEYeR4tGggcnWxgYthtDrY1iOtywiePDfX4n3o73l3rj+U71iqIby0EdH
	 4ak8rAkFqgcS0oDrrlpst02NHMFM/rwcTTlydGVrHWx078p+OFzwhimpGIxd486o93aYW
	 IttIsIeG3W86fEJYODvGqk2TSdHz5TiYPrd2uQQk6Jn+FiZWav1bPolQi7TQiJmaS7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xlTnBAmzSjVTaF7xwgl7wnXgBAMby87wsO7QxP8M4hQ=;
	b=gw2AC7Axo3ZR9YkP28EMuJZtsWX8F+1rhR7Omueq0Wpx+i1qxW/GVo038CNIkjuTeeBn
	 1aIYDlqpxRCacwH10I7Dt3zmbLuTIKMn4e5HDMRxIAe715/O4UrQCdlMH92vde85h/Stz
	 2H5qmELWEK19AxEHkf/KJFlzazy8myLtTwhiehPIfVOysA9kp1Iheo0cdcUgdauErRKIv
	 vJCLpSgxDTSsUrWgcA1FJxvZuLdUURMs+Hid6NmP11S9j2m+4eHG1xkICBgzwayDw1SzN
	 DprDih8iwZVvENd1iuwZTplpzaxVDwfSFCi26P+lpop3zaGL+YYMDeuSMXPUjWe6Gwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXw4hEZu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7191606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXw4hEZu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AC31F0089F;
	Sat,  7 Nov 2026 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050199;
	bh=xlTnBAmzSjVTaF7xwgl7wnXgBAMby87wsO7QxP8M4hQ=;
	h=From:To:Cc:Subject:Date;
	b=CXw4hEZuABOSk6T8q5toCVjWCfCNw7oJOxkUifcCG2BGHEqGES1FUiSTWC4oDmj98
	 QpkHo3QjtBZBssT8NnK37iUWVjEH41qYo6CBrWnXyBK0E1sE8wXhGPc1ZTUSsCVt0t
	 RlOFaagJ5RXynHQqcMLgVz3arugCxnWy0AALB4wpuRuZxjdSIkvGm0VpE9H95PVjSZ
	 ZdPatgoHuRQCpXvfejKAZsvu/eAwkdrgbNBzGJ/YVdCd7jwBSP5Kkw6D/8IVkugpzf
	 lhc1wT6udejm+kTe1vsKi1nxI2NwEDv784Dt+hdAOgTwDqswBAcKx7xUvi2b6SJ8xL
	 yHiKgvbfkXwIw==
From: Sasha Levin <sashal@kernel.org>
To: qianweili@huawei.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:37 -0500
Message-ID: <20261107061637-failed-5.10-40ec9605cb19@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 40ec9605cb195e065470f8f23ef94b1b541411a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061637-failed-5.10-40ec9605cb19@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 40ec9605cb195e065470f8f23ef94b1b541411a3 Mon Sep 17 00:00:00 2001
From: Weili Qian <qianweili@huawei.com>
Date: Fri, 18 Sep 2026 20:27:24 +0800
Subject: [PATCH] crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent

The HPRE driver hard-codes GFP_ATOMIC for RSA/DH and GFP_KERNEL for
ECDH. This may cause "scheduling while atomic" in atomic context or
unnecessary allocation failures under memory pressure.

Select GFP flags dynamically based on CRYPTO_TFM_REQ_MAY_SLEEP and
store them in hpre_asym_request::flags. The areq field is a union of
rsa/dh/ecdh request pointers; reading base.flags through any union
member other than the one that was written would be type-punning, so
a dedicated flags field avoids that.

Fixes: 98dfa9343f37 ("crypto: hisilicon/hpre - don't use GFP_KERNEL to alloc mem during softirq")
Cc: stable@vger.kernel.org
Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index f77c318caa358..6ca34f3bf9ffc 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -138,6 +138,7 @@ struct hpre_asym_request {
 	int err;
 	hpre_cb cb;
 	struct timespec64 req_time;
+	u32 flags;
 };
 
 static inline unsigned int hpre_align_sz(void)
@@ -186,6 +187,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
 				struct scatterlist *data, unsigned int len,
 				int is_src, dma_addr_t *tmp)
 {
+	gfp_t gfp = hpre_req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 	struct hpre_ctx *ctx = hpre_req->ctx;
 	struct device *dev = ctx->dev;
 	void *ptr;
@@ -195,7 +197,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
 	if (unlikely(shift < 0))
 		return -EINVAL;
 
-	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, GFP_ATOMIC);
+	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, gfp);
 	if (unlikely(!ptr))
 		return -ENOMEM;
 
@@ -419,6 +421,7 @@ static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
 		h_req = PTR_ALIGN(tmp, hpre_align_sz());
 		h_req->cb = hpre_rsa_cb;
 		h_req->areq.rsa = akreq;
+		h_req->flags = akreq->base.flags;
 		msg = &h_req->req;
 		memset(msg, 0, sizeof(*msg));
 	} else {
@@ -433,6 +436,7 @@ static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
 		h_req = PTR_ALIGN(tmp, hpre_align_sz());
 		h_req->cb = hpre_dh_cb;
 		h_req->areq.dh = kreq;
+		h_req->flags = kreq->base.flags;
 		msg = &h_req->req;
 		memset(msg, 0, sizeof(*msg));
 		msg->key = cpu_to_le64(ctx->dh.dma_xa_p);
@@ -1457,6 +1461,7 @@ static int hpre_ecdh_msg_request_set(struct hpre_ctx *ctx,
 	h_req = PTR_ALIGN(tmp, hpre_align_sz());
 	h_req->cb = hpre_ecdh_cb;
 	h_req->areq.ecdh = req;
+	h_req->flags = req->base.flags;
 	msg = &h_req->req;
 	memset(msg, 0, sizeof(*msg));
 	msg->in = cpu_to_le64(DMA_MAPPING_ERROR);
@@ -1475,6 +1480,7 @@ static int hpre_ecdh_msg_request_set(struct hpre_ctx *ctx,
 static int hpre_ecdh_src_data_init(struct hpre_asym_request *hpre_req,
 				   struct scatterlist *data, unsigned int len)
 {
+	gfp_t gfp = hpre_req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 	struct hpre_sqe *msg = &hpre_req->req;
 	struct hpre_ctx *ctx = hpre_req->ctx;
 	struct device *dev = ctx->dev;
@@ -1488,7 +1494,7 @@ static int hpre_ecdh_src_data_init(struct hpre_asym_request *hpre_req,
 	if (unlikely(shift < 0))
 		return -EINVAL;
 
-	ptr = dma_alloc_coherent(dev, ctx->key_sz << 2, &dma, GFP_KERNEL);
+	ptr = dma_alloc_coherent(dev, ctx->key_sz << 2, &dma, gfp);
 	if (unlikely(!ptr))
 		return -ENOMEM;
 
-- 
2.53.0




