Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F7239E80
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574875; cv=none; b=YKBZMBwMSY3BWrAh99QmfoC3KhsRkbifu1a1dCmQ5OLGQlF1d2mIWJicBsXth1eVBg5KvEAO6SmCr4XkcaUDkqSFWB+VTzC4NGSlb1/gANKznmrWSpIzeQrL+8ydjgXs6Iq3SnBwqRjXvChjBRjqSvLKWqo3Vq1R4sIXSuY/KsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574875; c=relaxed/simple;
	bh=k5bSgFKS/PZNFOlfq5mHouOLUQRelgze4GSfEZLmQYQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PT+9T1wcGyOY0kU4co0HtXsdYs5Mywzk3AqsRoCwaeGT54sMIlA7c2YF4kwTDizfYQHbuWkNOmCMop8woq7x7Wo2BZEkBCf8yCNaaDiGXhPOk+MA2Gjl8ebFvzRNbb7ZwZEt5C6nyn3t7Gub4n44upEA8k30CQDbsOyoxJGgFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1OPQB/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1OPQB/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C4B1F000FF;
	Wed, 16 Sep 2026 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574873;
	bh=WWc07NApX9xBJA9sUnN+zM+Nu/U7o1gpydFkry4u3Ag=;
	h=Subject:To:Cc:From:Date;
	b=w1OPQB/rekjTsXjPrWx8W05iIRyfLjsgT4ZPE15F9yygohxhVESpF6peuGDexPJgP
	 Vjyor77ZTBZxzbytpXBr8It2iVXJdLE8bbB6j3BSiNbNjZ+tUkGzy3FwM605FVY8Jg
	 BchZmZL09yMktiH93kQpkGH1fdBO2NwJ5hkb+f1A=
Subject: FAILED: patch "[PATCH] s390/crypto: Fix handling of EBUSY in PAES when req is pushed" failed to apply to 7.2-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:50:37 +0100
Message-ID: <2026091637-esteemed-mortally-8096@gregkh>
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
git cherry-pick -x 3fec882c33d9b61983ee31456777f623dccd1a35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091637-esteemed-mortally-8096@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3fec882c33d9b61983ee31456777f623dccd1a35 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:38:34 +0200
Subject: [PATCH] s390/crypto: Fix handling of EBUSY in PAES when req is pushed
 to crypto engine

When a request is transferred to the engine via
crypto_transfer_skcipher_request_to_engine() there are two return
codes signaling a successful transfer: EINPROGRESS and EBUSY. However
the correct handling of EBUSY was missing and has been added as a
return code indicating a successful transfer to the crypto engine.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 5b7664031ea3..93e0e54ba2e8 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -463,6 +463,7 @@ static int ecb_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -494,15 +495,17 @@ static int ecb_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;
@@ -723,6 +726,7 @@ static int cbc_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -754,15 +758,17 @@ static int cbc_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;
@@ -1047,6 +1053,7 @@ static int ctr_paes_crypt(struct skcipher_request *req)
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -1077,15 +1084,17 @@ static int ctr_paes_crypt(struct skcipher_request *req)
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;
@@ -1477,6 +1486,7 @@ static inline int xts_paes_crypt(struct skcipher_request *req, unsigned long mod
 	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk *walk = &req_ctx->walk;
 	bool tested = crypto_skcipher_tested(tfm);
+	bool cleanup = true;
 	int rc;
 
 	/*
@@ -1508,15 +1518,17 @@ static inline int xts_paes_crypt(struct skcipher_request *req, unsigned long mod
 	if (rc == 0 || rc == -EKEYEXPIRED) {
 		atomic_inc(&ctx->via_engine_ctr);
 		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
-		if (rc != -EINPROGRESS)
+		if (rc == -EINPROGRESS || rc == -EBUSY)
+			cleanup = false;
+		else
 			atomic_dec(&ctx->via_engine_ctr);
 	}
 
-	if (rc != -EINPROGRESS && walk->nbytes)
+	if (cleanup && walk->nbytes)
 		skcipher_walk_done(walk, rc);
 
 out:
-	if (rc != -EINPROGRESS)
+	if (cleanup)
 		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
 	pr_debug("rc=%d\n", rc);
 	return rc;

