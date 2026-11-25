Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598780;
	b=Rp30XYJrBqOYhj3tO5sCe6/5R5oSsqo0iHAeYmWmsoMW95m36t1i3sYVf9g56zRdupOf
	 JHoVwc+OZSu7NgWlA4Xx6F7aViLA+7qcpFY5Dc9Am8QbdGDKNZYizIzazrOinatlpMG6S
	 +t0SLFTDY0mJYZHDbYVg8OFf+n8zMotp0w2HThtYzvC6vcvW83WRTDeplryMcQBM/4unD
	 64zyde6AKAq1Oeik/t9QrzoZFH0SMzuiKod2tbjaKjXDv+F0fNUEBpRFf9TTq75AqYeve
	 DKdY4Dl874afhQmINFHzVXfkQl6ha25QrvJbv3EmlZl9CLl8N+l1fxSV4yuHSzrTn6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598780;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ngiEoYt8a24mimq8m1ftgGeWw1mWHRTmVD3nOuvJOrA=;
	b=cz6RiZg757+hcic51Au/ld3nbirYvFlAXUqUh8gcQPDyMRKhx5JZBI2a5WjXpOaONwdu
	 baeTi1DH/U06Ii4X69SKcFVPzhrSlEqFDICayDfvPkqpAJMMtDqHPwVHiZfDvG8GDuxj9
	 l6A2dS0LvsrHqgjeu09/M1FIuH8NSJD3ksjDP0f3ngChRfmyTcRXPNoGeb1PQzeURSG5w
	 4mMtMg1fkJuIqJnOOrDNx1VNZLs0Bsr1QgYfV7v3ra6YtqISoxgUUthXdge0cNzRBdUhv
	 occ1x5LlKgmWWe2GTiXW0tbZg+Br3SilvuLEa8o8ayymVL2n2PwNQT3Z0CvCitQ34eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=y9E11Yap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=y9E11Yap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269EB1F000C4;
	Wed, 25 Nov 2026 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598779;
	bh=ngiEoYt8a24mimq8m1ftgGeWw1mWHRTmVD3nOuvJOrA=;
	h=Subject:To:Cc:From:Date;
	b=y9E11YapHtLvaVzlKIOaDU1cFvjtRed6LMQTZgql1tALs/VXZtOuO2TJH1bYek07w
	 KRP+jRkrWn9lzV3xU4WTfoI97EmG/AxCTsj/YdIeCfHkTNirbRTppqWwUQN4hh8uPt
	 aEqufp3V6lR8RDlDHq6LybQCdGHMC4K04WlBdAVk=
Subject: FAILED: patch "[PATCH] crypto: caam - reject overlong RSA CRT parameters" failed to apply to 5.15-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,herbert@gondor.apana.org.au,sahil.malhotra@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:19:10 +0100
Message-ID: <2026112509-confused-dispersed-efe4@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 828c3b265b6df877dced3dde56ea41daa2e6181e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112509-confused-dispersed-efe4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 828c3b265b6df877dced3dde56ea41daa2e6181e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 8 Oct 2026 09:35:53 +0000
Subject: [PATCH] crypto: caam - reject overlong RSA CRT parameters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index ac515ed8c575..2082adaae585 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -880,7 +880,7 @@ static void caam_rsa_free_key(struct caam_rsa_key *key)
 
 static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
 {
-	while (!**ptr && *nbytes) {
+	while (*nbytes && !**ptr) {
 		(*ptr)++;
 		(*nbytes)--;
 	}
@@ -896,22 +896,22 @@ static void caam_rsa_drop_leading_zeros(const u8 **ptr, size_t *nbytes)
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
 
-	dst = kzalloc(dstlen, GFP_KERNEL);
-	if (!dst)
-		return NULL;
+	*dst = kzalloc(dstlen, GFP_KERNEL);
+	if (!*dst)
+		return -ENOMEM;
 
-	memcpy(dst + (dstlen - nbytes), ptr, nbytes);
+	memcpy(*dst + (dstlen - nbytes), ptr, nbytes);
 
-	return dst;
+	return 0;
 }
 
 /**
@@ -991,6 +991,7 @@ static int caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 	size_t p_sz = raw_key->p_sz;
 	size_t q_sz = raw_key->q_sz;
 	unsigned aligned_size;
+	int ret;
 
 	rsa_key->p = caam_read_raw_data(raw_key->p, &p_sz);
 	if (!rsa_key->p)
@@ -999,57 +1000,39 @@ static int caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 
 	rsa_key->q = caam_read_raw_data(raw_key->q, &q_sz);
 	if (!rsa_key->q)
-		goto free_p;
+		return -ENOMEM;
 	rsa_key->q_sz = q_sz;
 
 	aligned_size = ALIGN(raw_key->p_sz, dma_get_cache_alignment());
 	rsa_key->tmp1 = kzalloc(aligned_size, GFP_KERNEL);
 	if (!rsa_key->tmp1)
-		goto free_q;
+		return -ENOMEM;
 
 	aligned_size = ALIGN(raw_key->q_sz, dma_get_cache_alignment());
 	rsa_key->tmp2 = kzalloc(aligned_size, GFP_KERNEL);
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
@@ -1067,6 +1050,8 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 	if (ret)
 		return ret;
 
+	ret = -ENOMEM;
+
 	/* Copy key in DMA zone */
 	rsa_key->d = kmemdup(raw_key.d, raw_key.d_sz, GFP_KERNEL);
 	if (!rsa_key->d)
@@ -1103,7 +1088,7 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 
 err:
 	caam_rsa_free_key(rsa_key);
-	return -ENOMEM;
+	return ret;
 }
 
 static unsigned int caam_rsa_max_size(struct crypto_akcipher *tfm)

