Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C4353A93
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110748; cv=none; b=DrRzbLPW9U0iiwc8TvFLkybXKzCEioWeC5d+V2FilGVNaxCnH2/lB71j1YZ3qqDHgyyBufITlP17ZAA1kn6k64EfU2qtHr2654PkGzxMPg2T0Zn3Hgcohzxx6yOCt1wQvTvGmIxI0UR6Ok4C8dsLPWd6ppBiyf7TnIDSRLDDeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110748; c=relaxed/simple;
	bh=Mt+2PyBpG2kSA9aHgqEsn8uCRMKHuNZb/g/c0SVxTWo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DJiRZyN3/Z6uUQ3TbvPaynWzp5YyNra6k3pxDoz2RbZtgzkIIu/lbeOR47+c4JMpDMQcKRn+Kr8ZR25O8xfTaLmfGdwTHHRDxEWro08dIPXbD8+2SQgpvZV09dYanYBQ5PR1dyrmkd9xf3sE1k0SvjZRghqku24c/ligox+zSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cY1+tW8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cY1+tW8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B951F00A3A;
	Wed, 15 Jul 2026 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110746;
	bh=jQ2TKjtNZTB8s3wdJuefqN3ngD4/1cH57nEYSG82xv0=;
	h=Subject:To:Cc:From:Date;
	b=cY1+tW8+IMaUBXFFl0xaTSRIwvtWo/xPsqWGyu9MDwchi/jQMi+mDvBa4K2y3VFiG
	 0lHFAOO4xBi2isop7RI6hZHBofY+Evs3wWy/emy21edEKYknlfP+39P7BZQzR3HeMU
	 rie/gdWpqI1aQ44Jv1ZN+HYwgDl8fgQMIv+nP8Io=
Subject: FAILED: patch "[PATCH] crypto: drbg - Fix ineffective sanity check" failed to apply to 5.10-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:18:34 +0200
Message-ID: <2026071534-recital-french-6f6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 040ad83b0e8aa065fd2fc641cacba8491a8b186d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071534-recital-french-6f6d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 040ad83b0e8aa065fd2fc641cacba8491a8b186d Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 19 Apr 2026 23:33:47 -0700
Subject: [PATCH] crypto: drbg - Fix ineffective sanity check

Fix drbg_healthcheck_sanity() to correctly check the return value of
drbg_generate().  drbg_generate() returns 0 on success, or a negative
errno value on failure.  drbg_healthcheck_sanity() incorrectly assumed
that it returned a positive value on success.

This didn't make the sanity check fail, but it made it ineffective.

Fixes: cde001e4c3c3 ("crypto: rng - RNGs must return 0 in success case")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/drbg.c b/crypto/drbg.c
index de4c69032155..f23b431bd490 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1737,7 +1737,6 @@ static int drbg_kcapi_seed(struct crypto_rng *tfm,
  */
 static inline int __init drbg_healthcheck_sanity(void)
 {
-	int len = 0;
 #define OUTBUFLEN 16
 	unsigned char buf[OUTBUFLEN];
 	struct drbg_state *drbg = NULL;
@@ -1782,11 +1781,11 @@ static inline int __init drbg_healthcheck_sanity(void)
 	max_request_bytes = drbg_max_request_bytes(drbg);
 	drbg_string_fill(&addtl, buf, max_addtllen + 1);
 	/* overflow addtllen with additional info string */
-	len = drbg_generate(drbg, buf, OUTBUFLEN, &addtl);
-	BUG_ON(0 < len);
+	ret = drbg_generate(drbg, buf, OUTBUFLEN, &addtl);
+	BUG_ON(ret == 0);
 	/* overflow max_bits */
-	len = drbg_generate(drbg, buf, (max_request_bytes + 1), NULL);
-	BUG_ON(0 < len);
+	ret = drbg_generate(drbg, buf, max_request_bytes + 1, NULL);
+	BUG_ON(ret == 0);
 
 	/* overflow max addtllen with personalization string */
 	ret = drbg_seed(drbg, &addtl, false);

