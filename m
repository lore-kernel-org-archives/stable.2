Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A42A1B2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110740; cv=none; b=Mcsi/GnN+6plKxqTYuUcjUbJyrc1u9uQxmlEP2YoJrOTgM513CD4Z9ShXlf5Nc48Pls0huRg1oU9P9wX1SzjzTZKtEfWlVMZ8jMW0u+E23gi5VktAush4gcx9NaSNuD2yQQoLDzRDgiTpl2P0N+7zaQDUwLuWhHfsew8cAm8kRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110740; c=relaxed/simple;
	bh=OgKdsRwyKKo1QxQrsVvF6rOHyb3JAs3WnavFYXnH87o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sw/GUN872Tl7AN7f241NOlnAmCs0XxhQgOf/vg6vSENqb2biakUJ3kguY5rqwhz86PuLDVaXL5amXB9r16AHFVHbIg0lLFuyMVFMiCVGWK71lPObV3N3+V+KV6MDLKOdLRDAOgWdiFvOQOjHXoxx9c7wO1kAG9715tRvgX4+Pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kODIdK3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kODIdK3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED461F000E9;
	Wed, 15 Jul 2026 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110738;
	bh=DCK9OU5JBMiMwynD6J5UinqoaXbDTCGVFipyA16QDSU=;
	h=Subject:To:Cc:From:Date;
	b=kODIdK3Uhmejbm5BNLLI/P8oHbxl/7nPaMElLREUp3N0nxA7jg7ZmwW12xJqWxH5f
	 SAdrs/MDUM8zttdwVWTgF8BPZNbq4Wmr6PxjoTvYcZSvCRJHJtOSXyUDpKEB0mydCj
	 CbhpSZDx9aiEqG42t4qUt2GnTfCo79z+8gJOxzkQ=
Subject: FAILED: patch "[PATCH] crypto: drbg - Fix ineffective sanity check" failed to apply to 6.1-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:18:33 +0200
Message-ID: <2026071533-jailbird-astride-6371@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 040ad83b0e8aa065fd2fc641cacba8491a8b186d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071533-jailbird-astride-6371@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

