Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96853C8C46
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930116; cv=none; b=P5d2eG3CTH/BAm5xlKpyjKYtmbIu2twaJCj4r6OZxsH02VeLoUs0uDIItkgTwQOB0cufiOxUO5oN6O7GDtFy00eIS4hVfirghVwtE2sPGXQaAmNnOldRaz+53CxS5A38cYfVE77F++Ml2AvcWN4dbppL++icC8qoSsA4C2YpCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930116; c=relaxed/simple;
	bh=Op4MnaDIFLh4LSMVeAWQqfhcHwrrRRT5wjUvsnJ8G00=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=slnKsvS3aAbcZjS/I/3Ik3Ma2mEqCZTZaQPNPx8Yhs6Xv6cSDpiJSDSC+yXiyxltkig6/Rvgrbg6aQuuTCSiOtGlTvvsTRZqCwaL+hH1XrZPv8qRQUQ8qW59pOGC9ZVLiQtpr9+d7PMPGYW7Zov9FTOHxh+estcrRPlKcgHEt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KIMwxuZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KIMwxuZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFCB1F000E9;
	Wed,  5 Aug 2026 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930114;
	bh=cAFPMb3TzxElay0EkEjac9Ffh6mQ1+G3y6NFPg/WC68=;
	h=Subject:To:Cc:From:Date;
	b=KIMwxuZCcqxn0GlbI5WKcKa/sSFxV7A/9Wz/8bsrcbiZ//IoX8EPjG1G3tjIYUjD4
	 SBZwIaXh7Q1Zldsn1lSzMBidRZ+85FyYN6M3mpS8eg7YvTtMiVW66E/4u5vATfAKnP
	 sFDL277dV3EaDBldFCTk7yDZTgaRhhymtyMxdK+c=
Subject: FAILED: patch "[PATCH] s390/zcrypt: Fix buffer over-read in cca_cipher2protkey" failed to apply to 5.15-stable tree
To: freude@linux.ibm.com,gor@linux.ibm.com,ifranzki@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:41:22 +0200
Message-ID: <2026080522-available-anatomy-75bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 36b230835b8a008266aad22168ca52afacc8a58d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080522-available-anatomy-75bd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36b230835b8a008266aad22168ca52afacc8a58d Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:40:09 +0200
Subject: [PATCH] s390/zcrypt: Fix buffer over-read in cca_cipher2protkey

Add validation of both the actual key buffer size and token length
fields in all the cca_check_sec*token() functions. Additionally check
in cca_gencipherkey() for possible underflow with returned key size.

The CCA token structures contain user-controlled len fields that
were used in operations without proper validation against both the
actual buffer size and minimum token structure size. An attacker
could set this field larger than the actual buffer size, leading to
reading beyond buffer boundaries. This may result in a kernel crash or
exposure of memory via sending this as part of a request down to the
crypto card. Also an attacker could have used a very small len value
and thus enforce a buffer under-run which may produce similar effects
as a over-read.

So now a key must
- key buf length must be at least sizeof the token struct
- the key len field inside the token must fit into the range of
  sizeof key token struct ... key buf length

Fixes: 4bc123b18ce6 ("s390/zcrypt: Add low level functions for CCA AES cipher keys")
Cc: stable@vger.kernel.org
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index 4bc47952324e..e8dc2f77c137 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -236,22 +236,16 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (hdr->type == TOKTYPE_CCA_INTERNAL &&
 	    hdr->version == TOKVER_CCA_AES) {
 		/* CCA AES data key */
-		if (keylen < sizeof(struct secaeskeytoken))
-			return -EINVAL;
-		if (cca_check_secaeskeytoken(pkey_dbf_info, 3, key, 0))
+		if (cca_check_secaeskeytoken(pkey_dbf_info, 3, key, keylen, 0))
 			return -EINVAL;
 	} else if (hdr->type == TOKTYPE_CCA_INTERNAL &&
 		   hdr->version == TOKVER_CCA_VLSC) {
 		/* CCA AES cipher key */
-		if (keylen < hdr->len)
-			return -EINVAL;
 		if (cca_check_secaescipherkey(pkey_dbf_info,
-					      3, key, 0, 1))
+					      3, key, keylen, 0, 1))
 			return -EINVAL;
 	} else if (hdr->type == TOKTYPE_CCA_INTERNAL_PKA) {
 		/* CCA ECC (private) key */
-		if (keylen < sizeof(struct eccprivkeytoken))
-			return -EINVAL;
 		if (cca_check_sececckeytoken(pkey_dbf_info, 3, key, keylen, 1))
 			return -EINVAL;
 	} else {
@@ -484,7 +478,7 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 	    hdr->version == TOKVER_CCA_AES) {
 		struct secaeskeytoken *t = (struct secaeskeytoken *)key;
 
-		rc = cca_check_secaeskeytoken(pkey_dbf_info, 3, key, 0);
+		rc = cca_check_secaeskeytoken(pkey_dbf_info, 3, key, keylen, 0);
 		if (rc)
 			goto out;
 		*keytype = PKEY_TYPE_CCA_DATA;
@@ -512,7 +506,8 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 		   hdr->version == TOKVER_CCA_VLSC) {
 		struct cipherkeytoken *t = (struct cipherkeytoken *)key;
 
-		rc = cca_check_secaescipherkey(pkey_dbf_info, 3, key, 0, 1);
+		rc = cca_check_secaescipherkey(pkey_dbf_info, 3,
+					       key, keylen, 0, 1);
 		if (rc)
 			goto out;
 		*keytype = PKEY_TYPE_CCA_CIPHER;
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 322677a8d320..f797786107b9 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -62,12 +62,18 @@ static DEFINE_MUTEX(dev_status_mem_mutex);
  * also checked. Returns 0 on success or errno value on failure.
  */
 int cca_check_secaeskeytoken(debug_info_t *dbg, int dbflvl,
-			     const u8 *token, int keybitsize)
+			     const u8 *token, u32 keysize, int keybitsize)
 {
 	struct secaeskeytoken *t = (struct secaeskeytoken *)token;
 
 #define DBF(...) debug_sprintf_event(dbg, dbflvl, ##__VA_ARGS__)
 
+	if (keysize < sizeof(*t)) {
+		if (dbg)
+			DBF("%s keysize %u < min token size %zu\n",
+			    __func__, keysize, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->type != TOKTYPE_CCA_INTERNAL) {
 		if (dbg)
 			DBF("%s token check failed, type 0x%02x != 0x%02x\n",
@@ -101,14 +107,20 @@ EXPORT_SYMBOL(cca_check_secaeskeytoken);
  * Returns 0 on success or errno value on failure.
  */
 int cca_check_secaescipherkey(debug_info_t *dbg, int dbflvl,
-			      const u8 *token, int keybitsize,
-			      int checkcpacfexport)
+			      const u8 *token, u32 keysize,
+			      int keybitsize, int checkcpacfexport)
 {
 	struct cipherkeytoken *t = (struct cipherkeytoken *)token;
 	bool keybitsizeok = true;
 
 #define DBF(...) debug_sprintf_event(dbg, dbflvl, ##__VA_ARGS__)
 
+	if (keysize < sizeof(*t)) {
+		if (dbg)
+			DBF("%s keysize %u < min token size %zu\n",
+			    __func__, keysize, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->type != TOKTYPE_CCA_INTERNAL) {
 		if (dbg)
 			DBF("%s token check failed, type 0x%02x != 0x%02x\n",
@@ -121,6 +133,18 @@ int cca_check_secaescipherkey(debug_info_t *dbg, int dbflvl,
 			    __func__, (int)t->version, TOKVER_CCA_VLSC);
 		return -EINVAL;
 	}
+	if (t->len > keysize) {
+		if (dbg)
+			DBF("%s token check failed, len %d > keysize %u\n",
+			    __func__, (int)t->len, keysize);
+		return -EINVAL;
+	}
+	if (t->len < sizeof(*t)) {
+		if (dbg)
+			DBF("%s token check failed, len %d < min token size %zu\n",
+			    __func__, (int)t->len, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->algtype != 0x02) {
 		if (dbg)
 			DBF("%s token check failed, algtype 0x%02x != 0x02\n",
@@ -195,6 +219,12 @@ int cca_check_sececckeytoken(debug_info_t *dbg, int dbflvl,
 
 #define DBF(...) debug_sprintf_event(dbg, dbflvl, ##__VA_ARGS__)
 
+	if (keysize < sizeof(*t)) {
+		if (dbg)
+			DBF("%s keysize %u < min token size %zu\n",
+			    __func__, keysize, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->type != TOKTYPE_CCA_INTERNAL_PKA) {
 		if (dbg)
 			DBF("%s token check failed, type 0x%02x != 0x%02x\n",
@@ -207,6 +237,12 @@ int cca_check_sececckeytoken(debug_info_t *dbg, int dbflvl,
 			    __func__, (int)t->len, keysize);
 		return -EINVAL;
 	}
+	if (t->len < sizeof(*t)) {
+		if (dbg)
+			DBF("%s token check failed, len %d < min token size %zu\n",
+			    __func__, (int)t->len, sizeof(*t));
+		return -EINVAL;
+	}
 	if (t->secid != 0x20) {
 		if (dbg)
 			DBF("%s token check failed, secid 0x%02x != 0x20\n",
@@ -443,7 +479,8 @@ int cca_genseckey(u16 cardnr, u16 domain,
 
 	/* check secure key token */
 	rc = cca_check_secaeskeytoken(zcrypt_dbf_info, DBF_ERR,
-				      prepparm->lv3.keyblock.tok, 8 * keysize);
+				      prepparm->lv3.keyblock.tok,
+				      seckeysize, 8 * keysize);
 	if (rc) {
 		rc = -EIO;
 		goto out;
@@ -582,7 +619,8 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 
 	/* check secure key token */
 	rc = cca_check_secaeskeytoken(zcrypt_dbf_info, DBF_ERR,
-				      prepparm->lv3.keyblock.tok, 8 * keysize);
+				      prepparm->lv3.keyblock.tok,
+				      seckeysize, 8 * keysize);
 	if (rc) {
 		rc = -EIO;
 		goto out;
@@ -842,6 +880,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 		} kb;
 	} __packed * prepparm;
 	struct cipherkeytoken *t;
+	u32 keybuflen;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -936,23 +975,28 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	}
 
 	/* and some checks on the generated key */
+	t = (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
+	if (prepparm->kb.tlv1.len < 2 * sizeof(uint16_t) + sizeof(*t)) {
+		rc = -EIO;
+		goto out;
+	}
+	keybuflen = prepparm->kb.tlv1.len - 2 * sizeof(uint16_t);
 	rc = cca_check_secaescipherkey(zcrypt_dbf_info, DBF_ERR,
 				       prepparm->kb.tlv1.gen_key,
-				       keybitsize, 1);
+				       keybuflen, keybitsize, 1);
 	if (rc) {
 		rc = -EIO;
 		goto out;
 	}
 
 	/* copy the generated vlsc key token */
-	t = (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
 	if (keybuf) {
-		if (*keybufsize >= t->len)
-			memcpy(keybuf, t, t->len);
+		if (*keybufsize >= keybuflen)
+			memcpy(keybuf, t, keybuflen);
 		else
 			rc = -EINVAL;
 	}
-	*keybufsize = t->len;
+	*keybufsize = keybuflen;
 
 out:
 	free_cprbmem(mem, PARMBSIZE, false, xflags);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 07bbb1c20022..a4534f8b2f1d 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -136,7 +136,7 @@ struct eccprivkeytoken {
  * also checked. Returns 0 on success or errno value on failure.
  */
 int cca_check_secaeskeytoken(debug_info_t *dbg, int dbflvl,
-			     const u8 *token, int keybitsize);
+			     const u8 *token, u32 keysize, int keybitsize);
 
 /*
  * Simple check if the token is a valid CCA secure AES cipher key
@@ -146,8 +146,8 @@ int cca_check_secaeskeytoken(debug_info_t *dbg, int dbflvl,
  * Returns 0 on success or errno value on failure.
  */
 int cca_check_secaescipherkey(debug_info_t *dbg, int dbflvl,
-			      const u8 *token, int keybitsize,
-			      int checkcpacfexport);
+			      const u8 *token, u32 keysize,
+			      int keybitsize, int checkcpacfexport);
 
 /*
  * Simple check if the token is a valid CCA secure ECC private

