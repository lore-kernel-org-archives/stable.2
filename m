Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282323;
	b=Ui7xTBISHQxL5Jou5g3WKxOknO3o7h6hdJjs/lkeQq3GBxtmZLGoWibafkQu8jTZax91
	 HEYd++X3G2QyD6kgskY+QtMic9090ieOPIYDdkmind/AeuJYeX7+tXhqLq1F5PaI//9yD
	 /JbO+dmg6JiqR5/4oIrdK1OY+0PTuYspS2aiTgygrkfkbFSVVbFQGl6KKdmW6gN8rNQSS
	 3ejjJi3BNweNa9VMb94tufoFIN7N3rpbMT77IUllYWbFzbe2ZwPkexo4kCbdpbFHvSyAS
	 VtMBpSeVfb9A+J93Fr99rytG7/ZyvCqBK2OmimpzlCOAp2Kvvc/4WiUSq+2w5wTWW2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282323;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p35/GqrNtzowvNEbfh7w7G0Py621QLYznnTTS15sWLE=;
	b=Bxh27na4SZBZsaYf4B1N4A4u7un4a8x2yNGo3jlvNdtVGhmmLFM2RYx4ydT/97U94xux
	 PpDOx4MKY5hWBHoZSq6G/Klx8WhllAes0N5s7DSbBHDk+EnqKHC9wePWLOR5R0M+TQ30e
	 peV4CnPM/RCZHQvpoTpEAFuJ8mnropPaNhThoPqWZgrVzgZug/E+lJRudH304+2C73Fg6
	 JWP6nqgbIKR/7p3odQT18+rQelXh5kidx6p369h4Cuanktfv/1pOKCNyPks3jmfhR0Rym
	 ksIEiWdoB+ByApftJ90N7MdNXjMbT0aLc0aHos3jI78ewC9V3BnW6XOm6q/JQGJhVOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDamwry1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BC606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDamwry1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C67E1F008A2;
	Tue, 10 Nov 2026 03:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282323;
	bh=p35/GqrNtzowvNEbfh7w7G0Py621QLYznnTTS15sWLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDamwry1cxNdhjYtjVryc5h9s+s/XqQ5u8rfQQqOhsA1B+r0JqF0VTg4iTwQgeont
	 /AUTaG3P+Tp9MqG8I8mq/Xi6JBkVcaG8L/ktuP0Dy8dcPwKw9Hct4f55uaunJ2ZhKa
	 xaN1poRgH9glRK9R57GUNe8Qa/d5Qc/z5V4/xzwgIOA02z6nvW4AK3Qu+Lsa6Xvig5
	 NKEA5Q6aaWM98zxhfMQ/a5MlfQFjCRPaWsRr55PUYmo58XmrC7pdu0nOEtQFmVugIN
	 SefnhaIEp4FXZOouE98Ja1/e06aGp2A4tutWcN2yzFWIyJczftN1h4wMmvHawz88ZE
	 oxKAk8TlAgqRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weili Qian <qianweili@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent
Date: Mon,  9 Nov 2026 22:45:18 -0500
Message-ID: <20261110034443.239021-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110034443.239021-1-sashal@kernel.org>
References: <20261107061637-failed-5.10-40ec9605cb19@kernel.org>
 <20261110034443.239021-1-sashal@kernel.org>
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

From: Weili Qian <qianweili@huawei.com>

[ Upstream commit 40ec9605cb195e065470f8f23ef94b1b541411a3 ]

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
[ sashal: Omitted ECDH changes because the driver lacks ECDH support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 7501092463354..89bc8b164e74a 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -96,6 +96,7 @@ struct hpre_asym_request {
 	int req_id;
 	hpre_cb cb;
 	struct timespec64 req_time;
+	u32 flags;
 };
 
 static int hpre_alloc_req_id(struct hpre_ctx *ctx)
@@ -201,6 +202,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
 				struct scatterlist *data, unsigned int len,
 				int is_src, dma_addr_t *tmp)
 {
+	gfp_t gfp = hpre_req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 	struct hpre_ctx *ctx = hpre_req->ctx;
 	struct device *dev = HPRE_DEV(ctx);
 	void *ptr;
@@ -210,7 +212,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
 	if (unlikely(shift < 0))
 		return -EINVAL;
 
-	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, GFP_ATOMIC);
+	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, gfp);
 	if (unlikely(!ptr))
 		return -ENOMEM;
 
@@ -455,6 +457,7 @@ static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
 		h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
 		h_req->cb = hpre_rsa_cb;
 		h_req->areq.rsa = akreq;
+		h_req->flags = akreq->base.flags;
 		msg = &h_req->req;
 		memset(msg, 0, sizeof(*msg));
 	} else {
@@ -469,6 +472,7 @@ static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
 		h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
 		h_req->cb = hpre_dh_cb;
 		h_req->areq.dh = kreq;
+		h_req->flags = kreq->base.flags;
 		msg = &h_req->req;
 		memset(msg, 0, sizeof(*msg));
 		msg->key = cpu_to_le64(ctx->dh.dma_xa_p);
-- 
2.53.0

