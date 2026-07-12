Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8E367B67
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783823304; cv=none; b=W2H5ElOxJINHIA1axw1aNEVgLoJSJblY+HjvMXVAg40UpKdMnqsTw+ddwDIfNdg86DNVC7RZjjGIDxwlKELKGW2Il/f4stPjzl+6rO+rDLL6ECvWgizfx4+O5Rao6cmrBqpyDE5kT6cWvEPYmj7u0SbdjP2E+G2Erm4m9VMhVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783823304; c=relaxed/simple;
	bh=ZpMFLJiqrhcFSt8yy5JXsEr01RNW+/tA3fnjzKWxS0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf4d2oESmHvXah3t3o1ZbVMI6reSLRrgHRbBSC9GdwgTA6xF3EEarm4fuesEPPgeFlAv+dzyBrwTOCDLe0T7nAI9e8Zxp7SD6lc7B9lgLVAkPPWrULdcroAZHMscEYF+i8pEIftK9it4QUQDFHFH26JUPC0I6LDW5PisJ69+Pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shhcpt0O; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shhcpt0O"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c19bad03so18012405e9.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783823302; x=1784428102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7I3scjHBFy/O665lusuBOf3dhgU5aJvBdDuTYr3CQ4U=;
        b=shhcpt0OqBfBU4TLtKD2G9YBKGl19ey5golK30I0b0C/jU9lrMk61yOS5N1BmHHFAA
         zmTQYSEc1Nk+h2Re0pYo2dV5tb9kSDEle2x01dfX+p9S/IN5hJDlzKa3w/Cpgv1fKKvP
         +XbdilKK2fL2C5qF1TL3HCTO12eSBomOcI6zz2p5U6r2Ze3phhD1BbSkcbn4nD/mXpE9
         qygMBe7mveEVRmzT9qDXQDaxT6y7yCE9sLII1CfPfXuG/C/4XJyoAHfZ83YzsMJEk1kW
         dTKOol4pkwkM05jPMXrAfxSHmg0BMKvWrzxbOrLal9U6XIcdb1X9Wy/8Y2kzzr2m75sm
         AO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823302; x=1784428102;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7I3scjHBFy/O665lusuBOf3dhgU5aJvBdDuTYr3CQ4U=;
        b=eTqgR52Y1novzFGhtJzyKfTFE9YW/dkDJ3g4ujtXKy+n/ugjnRY95Cep83vvBmCYtd
         zdd8iMnH9u0aolNhjVgIWQjEe14D3VASBLDndXDsW/RN8S4CVoBXVkUJeC1Dlt3RsBh6
         pondKhlVZO5NE8qRCi8aa8/xWMydkE6hXWGmUPIS9llFmqtGQJ5kOlSUWhsyCKvR3WjL
         n+JFQcYHTH8/Dg6W9qqNpb1XEuODSPlaqyzMW5ziyBWIt9casZkld4Sphj4qkguDRmTq
         67GJW7ia5QH2LoAm6COTZvQbwJBBw6XmHeiZfyU4m1/Nbvz56gSQfQ/EEge0koygeACE
         6r6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJeeoMQDIE9ofpD6TZNl9qPPzi6BcpxQJevr0U+OR5u2dSCy7CuINZ2kan/b9fiyFgzUz++g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqHu0CxHP03TCnDIUfZ00XW3veB0NErvCU7zy6o5/PFs5MteS
	EVBdj4aJgORUI93C/vtvP6/oPPY6pGRPeJnv+uh772xXAqmjYulkgV1kjKYi6JeG
X-Gm-Gg: AfdE7cluVbiBWsXThyILc993ZCaTdiSsZFy8d6LhiDgtbCdrVeiXNEmuA0aIsZjdN8h
	JSLR5rfsrL6S9utfaJl9H12an4LnrReN3tVcg2soR0yfj5CTl1c/1Y82dJ8ZY6+UIqjlsKF5U7Q
	1upQA10JL/4ypQJwEOnvpWNbcSZPNSEjJVYZ1FNbTXqlA2gcCy00s/TRd/T7j3J9hLo0Ri5nNSr
	MDG11EeG11XvrTMDYM0HTHE18fsfXyUa7xsWom8gae0/PvPMSG6gZ9EAATsIa/WKQK9mhUfA1nl
	HrhuxPsJm2yCNPQlsKS3KCdX0ZOjf+SkaGW3agtdYfhE1HhaWqDVLxXDpLZjWUClvnXEnDqa182
	w6x92XGFK3zdtrVfcsTMxEtpAU4Z9LJucWh9qSUMNbGHpnzTLlvJJ5yNfQdHmHbXo9fNlyi5rvn
	fDVPlh6xUNNw8OF9t12aCQwKVCJA==
X-Received: by 2002:a05:600c:608e:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-493f8820806mr38379845e9.19.1783823301653;
        Sat, 11 Jul 2026 19:28:21 -0700 (PDT)
Received: from tt.. ([31.223.44.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d5055sm252027875e9.5.2026.07.11.19.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:28:21 -0700 (PDT)
From: =?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
To: sashal@kernel.org,
	herbert@gondor.apana.org.au,
	ebiggers@kernel.org
Cc: linux-crypto@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
Subject: [PATCH v2 2/2] crypto: algif_skcipher - force synchronous processing on trees without ctx->state
Date: Sun, 12 Jul 2026 02:26:17 +0000
Message-ID: <20260712022618.1665-3-muhammetkaankilinc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712022618.1665-1-muhammetkaankilinc@gmail.com>
References: <20260705220112.2522-1-muhammetkaankilinc@gmail.com>
 <20260712022618.1665-1-muhammetkaankilinc@gmail.com>
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

Newer trees snapshot ctx->iv per request and rely on ctx->state
(crypto_skcipher_import/export) to carry the chained IV. These trees lack
ctx->state and chain the IV in-place, so a per-request snapshot alone
would break MSG_MORE chaining, and a snapshot plus completion-time
writeback would reintroduce a race on ctx->iv outside the socket lock.

Make the operation synchronous instead, which removes both the IV race and
any writeback race. This mirrors the upstream resolution, commit
fcc77d33a34c ("net: Remove support for AIO on sockets"), which removed the
AIO socket path entirely. io_submit() now completes synchronously; AF_ALG
async is rarely used in practice.

Tested on 6.6.y: attacker IV injection dropped from 2296/200000 to 0/200000
after the change; MSG_MORE chunked CTR output bit-identical to single-shot.

Reported-by: Muhammet Kaan KILINÇ <muhammetkaankilinc@gmail.com>
Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory management")
Cc: <stable@vger.kernel.org>
Signed-off-by: Muhammet Kaan KILINÇ <muhammetkaankilinc@gmail.com>
---
v2: No functional change from v1. Independent of patch 1: patch 1
    targets trees with ctx->state (6.12.y/6.19.y) and uses a per-request
    IV snapshot; this patch targets trees without ctx->state (6.1.y/6.6.y)
    and removes the async path entirely. There is no shared code path or
    state-detection logic between the two, so patch 1's v2 change (snapshot
    scope) does not affect this patch.
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

