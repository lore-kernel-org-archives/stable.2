Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA243A7E2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110726; cv=none; b=FiCLh6pEhvll4BGPJhXu+9WU2POvGyL04b+M8hr4eDs3BveOcZQoK6TYOuEb08Yr/PiQ+kx7gUQd9wdzlIeVloPFBf+SF4RF0T8Uu8Nxd/U5oao0x0IFc0FaRaA+mwPj6q3W1Qt2GW4tfBzTb4mWeyysZsgDWB/2KMx9K7vRoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110726; c=relaxed/simple;
	bh=zlx/2VcECxfIZ0By6oDhErnIn2JKGFUWUL+pOix0AWM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dXMZX/xQCJITTHwHGxFmnI/VwiQPlfd7R9+pjx6vY242I7hEnoSMQ8E5rZOG9nsRywWK1xYjDLtIVR2xezCWcQ8NBPTjbveuoMyMwixhMqpFDfZjntpu3WMGVSfdr142x9EUi1uW5GUWRDo7yiEou8t5ewhfNsY3OJRcrQlcM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdxSC+HQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdxSC+HQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC1C1F000E9;
	Wed, 15 Jul 2026 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110725;
	bh=uG4DztZiFZ3A4H9e7zohwtrbDEosybDWH3J2XCw2tNs=;
	h=Subject:To:Cc:From:Date;
	b=qdxSC+HQekHaCJGSdXum55WKSG7WDQgS5+YXwj4s9GJJ3qFF6k/dULHz9OwrzyqHW
	 cKt/H71hNK4lXy363RRJRADN2iYEj9Kk9NoaHdDOQjBFY7L+f2YZ5mvMJSecburIN5
	 EYIN7Xo63jopD2Fh9HWCFObQkXH6P1jy+MikI+K0=
Subject: FAILED: patch "[PATCH] crypto: drbg - Fix misaligned writes in CTR_DRBG and" failed to apply to 6.6-stable tree
To: ebiggers@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:18:23 +0200
Message-ID: <2026071523-twentieth-repave-20b3@gregkh>
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
git cherry-pick -x ddc4dedb9ba3c8eecbc8c050fffd46d1b7e75c21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071523-twentieth-repave-20b3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

