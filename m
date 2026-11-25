Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623391;
	b=i0ues1eBDcWfBoXiw4YGuWsSSI74oFGRz5sNhc+UAbQZ8ID41Wh44lwjlZ3/MFLmuG6p
	 dnWF6hJfY+Gdv6q1022mDRGJgdgnwni2tXcXcDmDL4dGURz9tOyNDfIITorDTQNho3fQp
	 DHWWjktYPQ4igX9A06yWJhxSq2CqjCtf6JsS+pETZ/D5Rh/byojnDH4/VE6Kv3T/4v6mP
	 /hKyPzwFngfmAo+y7PGBTG2EUkhMRzUxtG+nGPZKQRMCgXEJldw2ZuNAEvXeGDDPQK8VT
	 PvK0briis60A91/tHu8E2L3gy5aXU696z8zu7UpkluJmP49da2EoQeynk7/rpDxegDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kqSFS27HREDS0qX+lJzP9jYKJF01pS4yUjPYxrpsvEs=;
	b=L9FGT42KzIeRAgKvnPvaezqcxI9zgE38gfP62YB/CSIV4MjyAeiCWi3P8hU1s9XHhVod
	 X8TNTuvOMCVbj6o5UzX3kCCrLVuraxRkYZbKRFEic4JJRjl2biku+pRYA379kk+7ZhKiG
	 1ofyOPqxAgU86ltTBXUVXD5wvp90hEqJzcaNxRKvpHfN/VxEGVXoUccL0zAjorX7QCsu/
	 b+xcHR+AQUqw7hIeOkHXu04woSu0xPqWmwOJvIGl+ul27n4vhXRdeQSwobuMTr4Zutk5F
	 KV/oBNUXOxaUfWrYOr9dsTUfyygvkq0dSQKefWLIADOuV7GmtN9NoyCNt8jTZ+PVS6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzcfXRsP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzcfXRsP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9F71F000CA;
	Wed, 25 Nov 2026 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623391;
	bh=kqSFS27HREDS0qX+lJzP9jYKJF01pS4yUjPYxrpsvEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzcfXRsPW2VKuhT7bjEC8juVuMOd7cC6IOM2Bq8jY/fwmP71Nu8ow/+rv2sCOXQLD
	 RwIPMGrI6huBpItyEW8S1SdmJ6W0QRVeVmb1evTuvcy6utcwwQBGun19ctPFHLu4ZY
	 NY2wnc3lMC25jn7TDqMCdDJ+KQeXE/hTAX6ZyG2S7LJoBU7YabmLbkxFDQhgliT/ZO
	 FUM87uL3cnadujLW0mRiQ+I0DE2PZeiCvzNjDoiZLWK2LdE0qsS4JGGuhgxRJy7RXY
	 TTyEN5nzo11/Xj7gkhTAFT7nDiQMPXjn/kbZUkM72Eu0qjJwZ11bKp6GpfUkviaNxc
	 yE2J9rNIr+Glw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: caam - reject overlong RSA CRT parameters
Date: Wed, 25 Nov 2026 11:16:29 -0500
Message-ID: <20261125161558.746646-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-sixth-timing-9c25@gregkh>
References: <2026112510-sixth-timing-9c25@gregkh>
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

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 828c3b265b6df877dced3dde56ea41daa2e6181e ]

caam_read_rsa_crt() right-aligns dP, dQ, and qInv in buffers sized
from the corresponding prime. rsa_parse_priv_key() only bounds these
integers against n, so a malformed key can provide, for example, a
two-byte dP with a one-byte p. dstlen - nbytes then underflows and
memcpy() writes outside the allocation during set_priv_key(). KASAN
reports a slab-out-of-bounds write in caam_read_rsa_crt().

Reject empty or overlong CRT parameters after stripping leading zeros.
qInv is consumed by CAAM as a p-sized value, so size it from p rather
than q to match the DMA mapping in set_rsa_priv_f3_pdb(). Let the
top-level key cleanup handle partial form-3 allocations and return the
specific error to the caller.

Also test nbytes before dereferencing it while stripping zeros, so an
all-zero integer does not read one byte beyond its input.

Fixes: 4a651b122adb ("crypto: caam - add support for RSA key form 3")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Sahil Malhotra <sahil.malhotra@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ sashal: Dropped the upstream GFP_DMA-less allocations' difference: kept GFP_DMA in kzalloc/kmemdup calls and used raw sizes instead of ALIGN(..., dma_get_cache_alignment()) for tmp1/tmp2 allocations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caampkc.c | 75 ++++++++++++++---------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index b4af79d73ba54..c41ada94c28a0 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -871,7 +871,7 @@ static void caam_rsa_free_key(struct caam_rsa_key *key)
 
 static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
 {
-	while (!**ptr && *nbytes) {
+	while (*nbytes && !**ptr) {
 		(*ptr)++;
 		(*nbytes)--;
 	}
@@ -887,22 +887,22 @@ static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
  * @ptr   : pointer to {dP, dQ, qInv} CRT member
  * @nbytes: length in bytes of {dP, dQ, qInv} CRT member
  * @dstlen: length in bytes of corresponding p or q prime factor
+ * @dst   : pointer to the zero-padded output buffer
  */
-static u8 *caam_read_rsa_crt(const u8 *ptr, size_t nbytes, size_t dstlen)
+static int caam_read_rsa_crt(const u8 *ptr, size_t nbytes, size_t dstlen,
+			     u8 **dst)
 {
-	u8 *dst;
-
 	caam_rsa_drop_leading_zeros(&ptr, &nbytes);
-	if (!nbytes)
-		return NULL;
+	if (!nbytes || nbytes > dstlen)
+		return -EINVAL;
 
-	dst = kzalloc(dstlen, GFP_DMA | GFP_KERNEL);
-	if (!dst)
-		return NULL;
+	*dst = kzalloc(dstlen, GFP_DMA | GFP_KERNEL);
+	if (!*dst)
+		return -ENOMEM;
 
-	memcpy(dst + (dstlen - nbytes), ptr, nbytes);
+	memcpy(*dst + (dstlen - nbytes), ptr, nbytes);
 
-	return dst;
+	return 0;
 }
 
 /**
@@ -981,6 +981,7 @@ static int caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 	struct caam_rsa_key *rsa_key = &ctx->key;
 	size_t p_sz = raw_key->p_sz;
 	size_t q_sz = raw_key->q_sz;
+	int ret;
 
 	rsa_key->p = caam_read_raw_data(raw_key->p, &p_sz);
 	if (!rsa_key->p)
@@ -989,55 +990,37 @@ static int caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 
 	rsa_key->q = caam_read_raw_data(raw_key->q, &q_sz);
 	if (!rsa_key->q)
-		goto free_p;
+		return -ENOMEM;
 	rsa_key->q_sz = q_sz;
 
 	rsa_key->tmp1 = kzalloc(raw_key->p_sz, GFP_DMA | GFP_KERNEL);
 	if (!rsa_key->tmp1)
-		goto free_q;
+		return -ENOMEM;
 
 	rsa_key->tmp2 = kzalloc(raw_key->q_sz, GFP_DMA | GFP_KERNEL);
 	if (!rsa_key->tmp2)
-		goto free_tmp1;
+		return -ENOMEM;
 
 	rsa_key->priv_form = FORM2;
 
-	rsa_key->dp = caam_read_rsa_crt(raw_key->dp, raw_key->dp_sz, p_sz);
-	if (!rsa_key->dp)
-		goto free_tmp2;
+	ret = caam_read_rsa_crt(raw_key->dp, raw_key->dp_sz, p_sz,
+				&rsa_key->dp);
+	if (ret)
+		return ret;
 
-	rsa_key->dq = caam_read_rsa_crt(raw_key->dq, raw_key->dq_sz, q_sz);
-	if (!rsa_key->dq)
-		goto free_dp;
+	ret = caam_read_rsa_crt(raw_key->dq, raw_key->dq_sz, q_sz,
+				&rsa_key->dq);
+	if (ret)
+		return ret;
 
-	rsa_key->qinv = caam_read_rsa_crt(raw_key->qinv, raw_key->qinv_sz,
-					  q_sz);
-	if (!rsa_key->qinv)
-		goto free_dq;
+	ret = caam_read_rsa_crt(raw_key->qinv, raw_key->qinv_sz, p_sz,
+				&rsa_key->qinv);
+	if (ret)
+		return ret;
 
 	rsa_key->priv_form = FORM3;
 
 	return 0;
-
-free_dq:
-	kfree_sensitive(rsa_key->dq);
-	rsa_key->dq = NULL;
-free_dp:
-	kfree_sensitive(rsa_key->dp);
-	rsa_key->dp = NULL;
-free_tmp2:
-	kfree_sensitive(rsa_key->tmp2);
-	rsa_key->tmp2 = NULL;
-free_tmp1:
-	kfree_sensitive(rsa_key->tmp1);
-	rsa_key->tmp1 = NULL;
-free_q:
-	kfree_sensitive(rsa_key->q);
-	rsa_key->q = NULL;
-free_p:
-	kfree_sensitive(rsa_key->p);
-	rsa_key->p = NULL;
-	return -ENOMEM;
 }
 
 static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
@@ -1055,6 +1038,8 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 	if (ret)
 		return ret;
 
+	ret = -ENOMEM;
+
 	/* Copy key in DMA zone */
 	rsa_key->d = kmemdup(raw_key.d, raw_key.d_sz, GFP_DMA | GFP_KERNEL);
 	if (!rsa_key->d)
@@ -1091,7 +1076,7 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 
 err:
 	caam_rsa_free_key(rsa_key);
-	return -ENOMEM;
+	return ret;
 }
 
 static unsigned int caam_rsa_max_size(struct crypto_akcipher *tfm)
-- 
2.53.0

