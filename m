Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376D43A804
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110737; cv=none; b=s5yDFpszerLpJPYS+8Elf+MXnhoGlCROP8wOpUwq/BN8UJwazGDWaC0sW1pKeh3BlhE+nBauv9S0o2ShcUmWq5wmYAkzTi4r4lhLbTjsFzVtGM8+mOcgqYPv20GPes+BJ73DII2jJIDzAQNlhl0mQldGLScoFScOzC+m/DLm0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110737; c=relaxed/simple;
	bh=KbtTLyS/OhZ8AHrr+BfrZPvGnAbG7+PEnrowwKWoVO8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=abuMiiksngqc558HqqbgpFpR2VHk+lk6C6G6H+oPiUgv9FP6qeKhBzj17jW54GmE6QARn/h7Nja8sj2jn81b1+fRBQl9ExrRGCpwtAxn9Xd0EGGyObEXYkeHI9dn0k9qHyGvJe1IuW9uy8I0YbzBaouG01Jch+kD9JVxbk/NZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gV5/c6Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gV5/c6Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90AA1F000E9;
	Wed, 15 Jul 2026 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110736;
	bh=bFvYACIwmYPjlQEbOql6g3gXeOOv7XwYJ/JI0FHNa4M=;
	h=Subject:To:Cc:From:Date;
	b=gV5/c6KdkOgwHhW1rAgnQN3OxcVAi2Uu7TXCi+i4xupeZUqZXpLRFgG4SSRC4ggzY
	 2wVw/EWSFhIephkKsyxdFqIIH/YdtEeIw/zGRsRtAQwxbHxAHdX0qJVhKoAPkFhVYX
	 DKNwI2SA3CC76nhoNpF417SAslsAB4yx96bFBAKg=
Subject: FAILED: patch "[PATCH] crypto: drbg - Fix ineffective sanity check" failed to apply to 6.6-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:18:33 +0200
Message-ID: <2026071533-confined-crimp-70f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 040ad83b0e8aa065fd2fc641cacba8491a8b186d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071533-confined-crimp-70f9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

