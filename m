Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487492FFDEA
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110710; cv=none; b=vAFLqQPwjX3Awbwkb6k/V73TU7faQm/+ksYX1dFfgmp+YLrK524P2/XbnTW6kyXhStYH/2Rzr0sWalnTsCRQd2WPxcpBc+Rl2BZp4qQheO4IS0tB9qPs9hN945IJ+mXQ7FVx6YGMWbymDP6PTnFGJtWEBZewW2t8ZLpruFA02AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110710; c=relaxed/simple;
	bh=7EV++EEYG8QOrl9PjKqhk6o/GYpqFPSiQwk/9urn4RE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BZNl/vM2UlS/u2kmACwtSZLONr7bCJay6/E3mRG6hP8sVBpRH/sdwAPwUw0GfLD/wa+A2/MkRcF+tqPjbJw+aBbcpDHpjgC326+t+HCgsFw8hCJ6DpZ9bVOHY/RhdN6de3XF2wkMk8P/sWntLQQXNcRJYEVfgBBRxgerAbKw5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xa+CMquG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xa+CMquG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEA71F000E9;
	Wed, 15 Jul 2026 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110709;
	bh=uwYg4PEGoN9csvVRTU629Q36i3zh+vSBO3Td6gQC6Fc=;
	h=Subject:To:Cc:From:Date;
	b=xa+CMquGYhNarWiASBzOxSkM40IHrO6CPE3VFj58OWg3nLlk7oPPIW1Ey5zMousky
	 D42GbiJhpHZUwmQQhfKoiClPo9LAIcZtkK1BtRUKLRuEQYykjD6k1NKHfxUTm69tpg
	 WKYHQ587/ngFWWi0tBFjKABRo38qWFb3OxAZzDC8=
Subject: FAILED: patch "[PATCH] crypto: drbg - Fix misaligned writes in CTR_DRBG and" failed to apply to 6.18-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:18:22 +0200
Message-ID: <2026071522-shape-broadways-fe6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ddc4dedb9ba3c8eecbc8c050fffd46d1b7e75c21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071522-shape-broadways-fe6c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ddc4dedb9ba3c8eecbc8c050fffd46d1b7e75c21 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 19 Apr 2026 23:33:46 -0700
Subject: [PATCH] crypto: drbg - Fix misaligned writes in CTR_DRBG and
 HASH_DRBG

drbg_cpu_to_be32() is being used to do a plain write to a byte array,
which doesn't have any alignment guarantee.  This can cause a misaligned
write.  Replace it with the correct function, put_unaligned_be32().

Fixes: 72f3e00dd67e ("crypto: drbg - replace int2byte with cpu_to_be")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/df_sp80090a.c b/crypto/df_sp80090a.c
index b8134be6f7ad..f4bb7be016e8 100644
--- a/crypto/df_sp80090a.c
+++ b/crypto/df_sp80090a.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/unaligned.h>
 #include <crypto/aes.h>
 #include <crypto/df_sp80090a.h>
 #include <crypto/internal/drbg.h>
@@ -141,10 +142,10 @@ int crypto_drbg_ctr_df(struct aes_enckey *aeskey,
 	/* 10.4.2 step 2 -- calculate the entire length of all input data */
 	list_for_each_entry(seed, seedlist, list)
 		inputlen += seed->len;
-	drbg_cpu_to_be32(inputlen, &L_N[0]);
+	put_unaligned_be32(inputlen, &L_N[0]);
 
 	/* 10.4.2 step 3 */
-	drbg_cpu_to_be32(bytes_to_return, &L_N[4]);
+	put_unaligned_be32(bytes_to_return, &L_N[4]);
 
 	/* 10.4.2 step 5: length is L_N, input_string, one byte, padding */
 	padlen = (inputlen + sizeof(L_N) + 1) % (blocklen_bytes);
@@ -175,7 +176,7 @@ int crypto_drbg_ctr_df(struct aes_enckey *aeskey,
 		 * holds zeros after allocation -- even the increment of i
 		 * is irrelevant as the increment remains within length of i
 		 */
-		drbg_cpu_to_be32(i, iv);
+		put_unaligned_be32(i, iv);
 		/* 10.4.2 step 9.2 -- BCC and concatenation with temp */
 		drbg_ctr_bcc(aeskey, temp + templen, K, &bcc_list,
 			     blocklen_bytes, keylen);
diff --git a/crypto/drbg.c b/crypto/drbg.c
index e4eb78ed222b..de4c69032155 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -103,6 +103,7 @@
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/string_choices.h>
+#include <linux/unaligned.h>
 
 /***************************************************************
  * Backend cipher definitions available to DRBG
@@ -601,7 +602,7 @@ static int drbg_hash_df(struct drbg_state *drbg,
 
 	/* 10.4.1 step 3 */
 	input[0] = 1;
-	drbg_cpu_to_be32((outlen * 8), &input[1]);
+	put_unaligned_be32(outlen * 8, &input[1]);
 
 	/* 10.4.1 step 4.1 -- concatenation of data for input into hash */
 	drbg_string_fill(&data, input, 5);
diff --git a/include/crypto/internal/drbg.h b/include/crypto/internal/drbg.h
index 371e52dcee6c..b4e5ef0be602 100644
--- a/include/crypto/internal/drbg.h
+++ b/include/crypto/internal/drbg.h
@@ -9,24 +9,6 @@
 #ifndef _INTERNAL_DRBG_H
 #define _INTERNAL_DRBG_H
 
-/*
- * Convert an integer into a byte representation of this integer.
- * The byte representation is big-endian
- *
- * @val value to be converted
- * @buf buffer holding the converted integer -- caller must ensure that
- *      buffer size is at least 32 bit
- */
-static inline void drbg_cpu_to_be32(__u32 val, unsigned char *buf)
-{
-	struct s {
-		__be32 conv;
-	};
-	struct s *conversion = (struct s *)buf;
-
-	conversion->conv = cpu_to_be32(val);
-}
-
 /*
  * Concatenation Helper and string operation helper
  *

