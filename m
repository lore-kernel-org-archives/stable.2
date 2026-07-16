Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E833372A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170772; cv=none; b=aFlHRU+mTjHkVioIi1lnfKRY4LQ30AhxcDiDo/1W21Do4wrknjt4lY12MiRdSlVqofP5KsE/rQ5DNEdG2b3WhPO9gnBixJLB1qQl6RZuwvx1OH9TZbwRIStLE1//u7+CBIQtLotCniG+ypN1VTTcZQCOyh/+lHqbbZOQMqACPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170772; c=relaxed/simple;
	bh=w7j+Vm3kZqMczU8ZHtd0epQoAcD/4BZM+sBCeTyPK3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3Os5Jdq/yni/Iis4kiZBrDHShBv1JIEDUwKrra1zkEVXL2ezOSjrIxGVklozY5QpI2I8EDzBgpjUUv6w5wx5ofIWMEsQHhaRMyHc/J6HNY/SCrhWtrWQdDQDLdVF0QT9lwWC6lNzzBVCGNZXW5VFT6v8O01d52/aBE3J4m+a7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkCihjtp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkCihjtp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f365afc5aso2416971f8f.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 19:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784170769; x=1784775569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1nOKM+Rfi7StoXhPr4qCYyTxDdt5ZD1sUwH98ej3Ong=;
        b=OkCihjtpyeULUITV0uyciLR3d0X9wB4h7k7gVa7J/g6XJCtTmzEuhpCBh4PGBQI5ih
         M2s4uvHes8Bcy4E4hbcR6UiyoSk71rB53ewkGz4JHjmFLjq5YuBHLfOX31RZpcN5oXHU
         To4T15rMAIGoMO1HBDxhMA3i7mJnSoc+jLwuwtq73/D610Iv7D29UD+QMO4B39hBXcnJ
         sLHlxHCIQD49Nhx9JC5zTfxnu2s90YeN0rRJXdBr9peXD/CCNYahKcXuILgRG9mmyQyL
         1I9VQkqHqKVZZAEAphzefZyrexkgC8sVlLMaKXqQAORTPao+cxnlmn+mQlDWXHOhKuX7
         1RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784170769; x=1784775569;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nOKM+Rfi7StoXhPr4qCYyTxDdt5ZD1sUwH98ej3Ong=;
        b=M7Ee5T6Y+LNAVUlh7C7BpdA94rnTypuXG7UILq1Ksy8Ob+xmR5ff2rDJGEueljXTpn
         cDUiB+ujCoX0em6DSJGa5ubfsFpzktbnqpqNLxV4Hxz1u82CxobF5GCbZZWPVcPP+LmU
         1fICwPnW9ZHVpSNOG95cEMuuNpGABwsXQmoKyFzR3YxPFKs4Sq++xuPmqOtxOHImEkXX
         tjz0AvWdNnwvah2SGymnkYZRXRgAxIO+mxJdi1pfJilybEb/h0KpueK4JjHGbzDwYXtz
         8oiMgbJ4WPIgU6W6mvnR+hvuGfhLaYthbq6Y30kjfcQBXj0EbGXryRasiWKntiXHoAX9
         CRYw==
X-Gm-Message-State: AOJu0YxHyKRH9XIfNmLJK+sfJ0RD3GSHvK5c3i0PCNYBSF5XyiXcOFkt
	ybjnllj7mVaHgMTXZlacpcbLweOqge9wmFEVTouVEpj24kjcx+UcOLwTK8k5X4uy
X-Gm-Gg: AfdE7cl5IhRfVPYDUpuzVL97nwxu7Shglsz69ksi7LN4mZJRSUyJZ/Qc0J9Zg900LeW
	35xPGdQIf1vCWO5Oi5/qSzqia7Rg1Dz2EMGIrM5IiF1/fZ3owXt5XPX8zcqDwojaN/k3flN2CWc
	hFo97g5HRDduPB15MZhBUY0Su4mZdrX4cuU6ePsNNnRzM0jF70P/7xYjFlE1B7kpyzAHzUB7xY7
	hATycG6roQ77IKEDRu1LkHA+XxSYG9BbUUz/OyGLSTFZFWOxzGevgQPSRGnbMai/BnvvalrxbCU
	cVi8LjZX8TXVpc7UMx1IgLkk5rimhxjYpBuVZZA3wzWeAyrwFxRQZwCikAQhfE1Tg5USRl2pxiu
	KyslYrtKSsf1La0MOPiDUJBYqhktsdq8RiGQAaenaSuPEQHxy4qfK2LBSQLY+t4DinjCk4yl1Kt
	J9X+VtodS5syp/lRjqoY/IhZPJ3w==
X-Received: by 2002:a05:6000:40cc:b0:472:aaba:faed with SMTP id ffacd0b85a97d-47f488b2472mr11522349f8f.31.1784170769025;
        Wed, 15 Jul 2026 19:59:29 -0700 (PDT)
Received: from tt.. ([31.223.44.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a940sm19511108f8f.12.2026.07.15.19.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:59:27 -0700 (PDT)
From: =?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	ebiggers@kernel.org,
	=?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
Subject: [PATCH v3 2/2] crypto: algif_skcipher - force synchronous processing on trees without ctx->state
Date: Thu, 16 Jul 2026 02:58:37 +0000
Message-ID: <20260716025838.2672-3-muhammetkaankilinc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716025838.2672-1-muhammetkaankilinc@gmail.com>
References: <20260716025838.2672-1-muhammetkaankilinc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AIO/async path in skcipher_recvmsg() passes the socket-wide ctx->iv
directly into the skcipher request. After io_submit() the socket lock is
dropped and the request is processed asynchronously, so a concurrent
sendmsg(ALG_SET_IV) can overwrite ctx->iv and make the in-flight request
run under an attacker-controlled IV. For CTR/stream modes this is
IV/keystream reuse and lets an unprivileged user recover the plaintext of
a concurrent operation.

Snapshotting ctx->iv into per-request storage for the async path is not
sufficient. For ciphers with statesize == 0 - which includes cbc and ctr -
the MSG_MORE inter-chunk IV chaining is carried solely by the in-place
req->iv writeback, which a snapshot redirects into per-request memory that
af_alg_free_resources() releases on completion, silently producing wrong
output. Writing the IV back from the completion callback instead is not
possible either: that would require lock_sock() there, but the callback can
run in softirq/atomic context, so it must not sleep.

Make the operation synchronous instead, which removes both the IV race and
any writeback race. This is equivalent to the upstream resolution, commit
fcc77d33a34c ("net: Remove support for AIO on sockets"), which removed the
AIO socket path across net/ entirely and so produces the same end state for
this file. This patch deviates from that commit deliberately: rather than
removing AIO socket support tree-wide, which would be far too invasive for
stable, it removes only the AIO branch in crypto/algif_skcipher.c.
io_submit() now completes synchronously; AF_ALG async is rarely used in
practice.

The -EIOCBQUEUED check in skcipher_recvmsg() is now dead but harmless,
and is left alone to keep the fix minimal.

Tested on 6.6.y: attacker IV injection dropped from 2296/200000 to 0/200000
after the change; MSG_MORE chunked CTR output bit-identical to single-shot.

Reported-by: Muhammet Kaan KILINÇ <muhammetkaankilinc@gmail.com>
Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory management")
Cc: <stable@vger.kernel.org>
Signed-off-by: Muhammet Kaan KILINÇ <muhammetkaankilinc@gmail.com>
---
v3: No functional change to this patch. Patch 1 now uses the same
    force-sync approach after Sasha Levin pointed out that the v2
    snapshot silently breaks MSG_MORE IV chaining for statesize == 0
    ciphers. The two patches remain separate only because the
    surrounding code differs: 7.1.y, 6.18.y and 6.12.y have ctx->state,
    cflags and algif_skcipher_export(); 6.6.y, 6.1.y, 5.15.y and 5.10.y
    do not, so the diffs do not apply across both.

No Closes: tag: the underlying vulnerability was reported privately to
security@kernel.org (2026-06-07), so there is no public report URL.
 crypto/algif_skcipher.c | 49 +++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index e31b1da58..b12df4544 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -109,33 +109,20 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 
-	if (msg->msg_iocb && !is_sync_kiocb(msg->msg_iocb)) {
-		/* AIO operation */
-		sock_hold(sk);
-		areq->iocb = msg->msg_iocb;
-
-		/* Remember output size that will be generated. */
-		areq->outlen = len;
-
-		skcipher_request_set_callback(&areq->cra_u.skcipher_req,
-					      CRYPTO_TFM_REQ_MAY_SLEEP,
-					      af_alg_async_cb, areq);
-		err = ctx->enc ?
-			crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
-			crypto_skcipher_decrypt(&areq->cra_u.skcipher_req);
-
-		/* AIO operation in progress */
-		if (err == -EINPROGRESS)
-			return -EIOCBQUEUED;
-
-		sock_put(sk);
-	} else {
-		/* Synchronous operation */
-		skcipher_request_set_callback(&areq->cra_u.skcipher_req,
-					      CRYPTO_TFM_REQ_MAY_SLEEP |
-					      CRYPTO_TFM_REQ_MAY_BACKLOG,
-					      crypto_req_done, &ctx->wait);
-		err = crypto_wait_req(ctx->enc ?
-			crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
-			crypto_skcipher_decrypt(&areq->cra_u.skcipher_req),
-						 &ctx->wait);
-	}
+	/*
+	 * Force synchronous processing.  The async (AIO) path passed the
+	 * socket-wide ctx->iv into the request, which the worker
+	 * dereferenced after the socket lock was dropped, letting a
+	 * concurrent sendmsg(ALG_SET_IV) inject an attacker IV.  Mainline
+	 * removed the AIO socket path in commit fcc77d33a34c ("net: Remove
+	 * support for AIO on sockets"); these stable trees lack the
+	 * per-request ctx->state used by newer kernels, so the minimal safe
+	 * fix is to always complete synchronously.
+	 */
+	skcipher_request_set_callback(&areq->cra_u.skcipher_req,
+				      CRYPTO_TFM_REQ_MAY_SLEEP |
+				      CRYPTO_TFM_REQ_MAY_BACKLOG,
+				      crypto_req_done, &ctx->wait);
+	err = crypto_wait_req(ctx->enc ?
+		crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
+		crypto_skcipher_decrypt(&areq->cra_u.skcipher_req),
+				      &ctx->wait);
 
-- 
2.43.0

