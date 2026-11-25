Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622900;
	b=OIP5/2wOeaB/8R0+isnw3gUdZQgK2RZZ3wwoPe5GNrgVYdXHqboUedF5orO33+xuuWNt
	 PekIB0LEN4kSa3O0W8VYx7pUiJW2taXeyL3UMpbPm/HeygOBPjBh1s9S+yuP0bDTfXZt7
	 woIZWrSscUXofwV7R5vcr/juJkCoMq8BwsgO6OAAULPgcY7Yf+HrZz1S6VAcm7wsMP2Vz
	 pvk6XG/a+7gwTXzsOrWm809fvtlNnwbJKZ0pxnAKdbpzi0qSHJVIjKQwYysQgugKa8ApG
	 mIL/BlN528LXHonkonejECthIl1Zxk4XnaUtNvuhX4KxSSjaCR89c2KCsdRcISYoURw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wFdJRd9O0gZ3UP8wwYnshg6AxKChQp0/3vsxxXLCM7s=;
	b=jXCJ+GsBZEMbxLyUNiRXpI//UVTZIEIiKBc/UKOYaAr+KsOBS0Tp5McOBNvk5mURQTPL
	 1nLBkSq8rhLRaabEMJj8cfLcKjrgMU7HcpVp2UNzrdH9alaLEwmCv7oLKJDkpqwH51Xw0
	 E/LFcAeo2Q+R9kH5upE/WidAlLaIcMgV3mHOXfUEWt0YKT3oabEBtF4xDyU0VgsKDnxi4
	 9uuUMv1W7KrWeiSD7KAzPAgiXLQIcW8IPzmxTH4sfaH+vgfTCaV+hTIRugJZeeOE8tz1h
	 bjqce6FuE5oot6S/elQzeHURTRA0aGwvaPe7dY+E5+TKyij7q3P8XVmnnc1hAJQ59sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJNW8Ars;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F0606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJNW8Ars
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0500E1F000C0;
	Wed, 25 Nov 2026 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622899;
	bh=wFdJRd9O0gZ3UP8wwYnshg6AxKChQp0/3vsxxXLCM7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJNW8Ars8ztsWieSK5K5fpDahoL2pJqEGo06Fqh9T9Qdhdo6XLnsYG930KmccBFlB
	 nsy7ZdpKXP99JwgeO2qyBE+RVFfVHjx9kIq3iU/ckwXkcvhB93Pe2XUWCfilwHSElA
	 QxC3qH/i2UoUt6xOzNLcekAFsm3aeyn/m08HiIAfHF9Gf8TEJt7MZkdG3kSnM51l/U
	 Tq255nRKSVR2jxZTlpbowOUml1lvTzCbUTtHljzma9wiatxFVeOqVr1N6WELymmg8a
	 1PyLWWX7upodRub4g3/rbRjbCey1qx1mI0shIPGNruO6qtNbICxDkMmBnm0nTwQolk
	 2z9Ur5YslIjag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] crypto: caam - reject overlong RSA CRT parameters
Date: Wed, 25 Nov 2026 11:08:17 -0500
Message-ID: <20261125160752.680134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-flatterer-oak-94c4@gregkh>
References: <2026112509-flatterer-oak-94c4@gregkh>
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
[ sashal: adapted caam_read_rsa_crt() fix to keep GFP_DMA allocations and omit aligned_size handling, which this tree lacks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caampkc.c | 75 ++++++++++++++---------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 677e0860aeec8..f7d5c8d6aeaf9 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -875,7 +875,7 @@ static void caam_rsa_free_key(struct caam_rsa_key *key)
 
 static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
 {
-	while (!**ptr && *nbytes) {
+	while (*nbytes && !**ptr) {
 		(*ptr)++;
 		(*nbytes)--;
 	}
@@ -891,22 +891,22 @@ static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
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
@@ -985,6 +985,7 @@ static int caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 	struct caam_rsa_key *rsa_key = &ctx->key;
 	size_t p_sz = raw_key->p_sz;
 	size_t q_sz = raw_key->q_sz;
+	int ret;
 
 	rsa_key->p = caam_read_raw_data(raw_key->p, &p_sz);
 	if (!rsa_key->p)
@@ -993,55 +994,37 @@ static int caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 
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
@@ -1059,6 +1042,8 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 	if (ret)
 		return ret;
 
+	ret = -ENOMEM;
+
 	/* Copy key in DMA zone */
 	rsa_key->d = kmemdup(raw_key.d, raw_key.d_sz, GFP_DMA | GFP_KERNEL);
 	if (!rsa_key->d)
@@ -1095,7 +1080,7 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 
 err:
 	caam_rsa_free_key(rsa_key);
-	return -ENOMEM;
+	return ret;
 }
 
 static unsigned int caam_rsa_max_size(struct crypto_akcipher *tfm)
-- 
2.53.0

