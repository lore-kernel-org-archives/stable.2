Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F123EB0E1
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930124; cv=none; b=siw6LdW34GO+OLN0rfCSiNPuqiMTeXdL92BVuLw1NgmqzPvzHFDcoPY9nf9JzMYbL2+6sbe/1jetQ4jz9WQorUnlyGYS6oLjhFvLO8P6G+E9kL5Ye+NLpwSsvQvYDViDE5VCMa+KaeG6POMWt3mirfAyInMOPYyXgG4i8V7dI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930124; c=relaxed/simple;
	bh=qOpado5FV1aFd54wT5KrUiTN3CP5esu9f4ceGaPLPHE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AvimtDsxrPS+7HKLHspKjcZK00riV/KBKgwZ5bL/gPnrzNQYl+VHyWntQX64Y8Ij7R7GVBH2DnCopxg/KRp3Y+0ZNBHG7nAndo5S7XtTsLiCltvpVw+avLx2aoiNPMfKnxkBBgI/cvAH/qaQEkdHPKyY1NCBpY6jwg0kapylCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rgbq9JWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rgbq9JWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5971F000E9;
	Wed,  5 Aug 2026 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930123;
	bh=04x30FJxV3FWoaXZnjEGvfdH1SDuLumQCqwZ+rbpvHs=;
	h=Subject:To:Cc:From:Date;
	b=Rgbq9JWNd8y1OUJFLyehFGMI6VM+fEKQ5ZzqlzJ0+e6VQl2Q+Z6HqHwnRxcSA/JKr
	 JKDUHu25LJ/d5BgFNzG9I3i5uQidflo3wU8GFbkg1Yv3drxvFrAuZQYX2/L5uiS/ru
	 Q0LXKvJMxcu+FAdrRs2MOmMvHOudE8IxARbx0EZw=
Subject: FAILED: patch "[PATCH] s390/zcrypt: Fix missing mem scrub at clear key import in" failed to apply to 6.6-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,gor@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:41:33 +0200
Message-ID: <2026080533-smashing-unease-48ae@gregkh>
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
git cherry-pick -x 01476391aecef36a3b789ee844357b22fbc90665
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080533-smashing-unease-48ae@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01476391aecef36a3b789ee844357b22fbc90665 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 29 Jul 2026 16:01:34 +0200
Subject: [PATCH] s390/zcrypt: Fix missing mem scrub at clear key import in
 cca_clr2cipherkey()

The helper function _ip_cprb_helper() uses internal buffer memory for
building and processing CPRBs. After use this buffer was never
scrubbed which could lead to leaving for example clear key material in
memory which could be exposed via tricky reuse of this same memory.

Extend the _ip_cprb_helper() function with another parameter 'scrub'
used to steer scrubbing of this buffer. So now the caller has the
opportunity to decide if scrubbing is needed or not.

Extend the clear key to secure key token import process in function
cca_clr2cipherkey() to tell the helper function from above to scrub
the cprb buffer when the clear key value is part of the request data.

Add explicit scrubbing on return from function cca_clr2cipherkey() for
the random EXOR buffer and the cprb buffer.

Overall this cleans the internal used buffer in case of clear key
import to prevent sensitive data to get exposed.

Fixes: 4bc123b18ce6 ("s390/zcrypt: Add low level functions for CCA AES cipher keys")
Cc: stable@vger.kernel.org
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index f797786107b9..86d2ee78c9f4 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1015,7 +1015,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   int clr_key_bit_size,
 			   u8 *key_token,
 			   int *key_token_size,
-			   u32 xflags)
+			   u32 xflags,
+			   bool scrub)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1155,7 +1156,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, false, xflags);
+	free_cprbmem(mem, PARMBSIZE, scrub, xflags);
 	return rc;
 }
 
@@ -1206,28 +1207,32 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize, xflags);
+			     exorbuf, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize, xflags);
+			     clrkey, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize, xflags);
+			     exorbuf, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize, xflags);
+			     NULL, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
@@ -1244,6 +1249,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	*keybufsize = tokensize;
 
 out:
+	memzero_explicit(exorbuf, sizeof(exorbuf));
+	memzero_explicit(mem, CPRB_MEMPOOL_ITEM_SIZE);
 	mempool_free(mem, cprb_mempool);
 	return rc;
 }

