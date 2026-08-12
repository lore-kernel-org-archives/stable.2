Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6B21D5B0
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497527; cv=none; b=gzDE2c8Il0iWimSVQkSaqmdKTrzIzouuhQIt8C3qX25UGPfQLNc0pJRhFVcHTPKQLEb+X4y53FkeB89zJ8H/r/bBhCVa/NFgrt3L7CdN6D5F/a8eQUpCIeB1wMpwBUUpOjlMx3JDnPN+1ww4o6tr0Q/AEORMMPeO83HuMgOXtTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497527; c=relaxed/simple;
	bh=E1IF0nGEJlQ+l2YasRzEi6A2Ad+Z6JGT/4ZKZ+PKPJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcB/9JmuW3ma3X9BuF3YgmCurHAatROyZlltRDpJkUW56B3Nyy4FrVu+q+Cilc1nHKyH4r9JhujLcvvPd7HZQ9DdxL4XXVIXCvZ6OpDa6LHt9xSRDzE7upRmGgMI4D9pZBpksurBzWZ6GFbBHMePwUCSaD6OQ7ZVMWPnpVGVzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhguPmRQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhguPmRQ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso722758a91.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786497524; x=1787102324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8WFozyc+Pq5LHiAu5nVVicgUQ29ypSSwcy50yQVDB38=;
        b=DhguPmRQhPUw2M/D5ebkWcEqvD5saPYJD3xsfu1R7M29qbckAQbKrxxZdUaE4gKW/t
         sVijd3ToBi2108e9b35udp+epuOxCBQxRnEprl+K66jE3JhQYFVhVwwBN2v6rMl273mk
         2Lv2sScTOSYLQPFYmyICa5RdZj8kyH0m4BJd/IP09LcOEBVy74JT+z7NG8dj4ZjTQ9md
         7k8vqeTjR3IQZ8eb9autypruZlpkDkP/fr70o0f1zD/sm7dCDjQ06/H7hkADFjBjYLu4
         PBriUzW3qcEWXuXbG5AS5G+xkTcTB4CwL9rWmuy5l4EbHv9pgJUB1htaJtsgXnAigMuk
         ls3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497524; x=1787102324;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8WFozyc+Pq5LHiAu5nVVicgUQ29ypSSwcy50yQVDB38=;
        b=n8JyBXoXDZjk1X3/M63L0EvDOQJYRuAOuIvk7y6N8Xmzaey6u0qeedALa0q/nhXiTT
         H7TAiU4tR23X85gY/kkGWinxaKmgF+/cM7SLrDTSu7O50YzMnavqtT5Z6XC/rcwMS182
         C/TuZFZ/pvLZWxhSNciW33VCWixIJi2EW6HYuiRjvqXwBuuTyjkIxAqAAjoDhQSgVonQ
         VkUohtgizCkEmkb0XMt+68ULD3xq1VbRz7resZC5I5es0fH3CO5vMiz1Ny6unuLYNHL5
         46RlOfy/1ElXyK58WzW+wsRV0SWzHPsZsCj/A9ctUf6O473U2tv4d44OyWC2YssAz5q4
         JOew==
X-Forwarded-Encrypted: i=1; AHgh+RrYId8YPAEnINcQplwk9lisDjfVpvF2zaMJvQ+QM0sJg4SL5tEsI2uIcgI3BK6+7DOmYWzbVrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYv2gCg+RfusXTF1D9v9CWEQExBfGrJpI8YwuT/6v3yzYO2fdy
	UK7OaGU0jOSSi5+j32MvMSh++4nuO+VW8aSeQQPc53B25CN6gZ8qzAOX
X-Gm-Gg: AR+sD12REXBn2EJ3KVnBhJxLogtqe88yOSfikUfiiPzY+lRuwimGPCYqnlBAfPMwk7e
	A3Vq6AnAMSS5yOc67af0EvG8wkvcrQYiwUSpGwIrHpPHIvWGch7TsCV0Rk4y4kzlEKew5nIgw7U
	5KZaxSglr9z3UPgz5yTeQ7NRyX/MDdgfESBsNA9987sEaCsw3LOcaAsoLoofGeVNd/fnvB/V5vB
	B0/TXRNE5HnwWnGolGOavsdcAFOQtAJT341xCz14GpWbEs7vFtd/xO7q/0efAzM90qaAttft7Ft
	Gzg50wU1o72SRrx3QrGJuhdwi1Z/MxRFDdMK85+EFFNBLdAMSQY9h4asJwRECz68xCJXU0zkDbN
	MlTI/9zNuL2o2f7PlN7KXPQaEnLd3BNFf2RKcupAe57fYtGUjR8Wn/NVcXiDjWOco76/4EPuwLz
	JhTAqNi6DewPKWSTK7DBu7RhDZJczckPgqTctdbzn2NM0oDaPwrS/Na+yOxD7ufRfLEVQ=
X-Received: by 2002:a17:90b:51c6:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-39301474d7cmr1434843a91.18.1786497524001;
        Tue, 11 Aug 2026 18:18:44 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8901c1bsm1549721a91.8.2026.08.11.18.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 18:18:43 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	Copilot <223556219+Copilot@users.noreply.github.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 1/4] ntfs: replace raw ctx->al_entry with restartable attr-list locators
Date: Wed, 12 Aug 2026 10:18:09 +0900
Message-ID: <20260812-topic-attr-list-lock-v6-v7-1-2f35e0a38bfb@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812-topic-attr-list-lock-v6-v7-0-2f35e0a38bfb@gmail.com>
References: <20260812-topic-attr-list-lock-v6-v7-0-2f35e0a38bfb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
Content-Transfer-Encoding: 8bit

ntfs_attr_search_ctx kept a raw al_entry pointer into the in-memory
$ATTRIBUTE_LIST buffer. Any insertion or removal reallocates the
whole buffer, so that pointer becomes stale while the context is still
alive across extent mapping, record moves, and mapping-pair rebuilds.

Replace the raw pointer with three generation-checked locators:

 - al_cursor: resume position for ntfs_external_attr_find()
 - al_insert: insertion point captured on -ENOENT
 - al_exact: identity snapshot used by writers to re-find an entry

Add attr_list_lock (rw_semaphore) and attr_list_gen to protect the
in-memory list and detect stale locators. ntfs_external_attr_find()
takes the lock for read. Writers re-locate under the lock for write
via ntfs_attrlist_find_exact_locked() before mutating.

Reported-by: Cen Zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.com/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Tested-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c   | 377 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/ntfs/attrib.h   |  44 ++++++-
 fs/ntfs/attrlist.c |  23 ++--
 fs/ntfs/index.c    |   3 +-
 fs/ntfs/inode.c    |  34 +++--
 fs/ntfs/inode.h    |   6 +
 6 files changed, 391 insertions(+), 96 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index c62c8ca8b987..0f48dd923b72 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -30,6 +30,97 @@
 
 __le16 AT_UNNAMED[] = { cpu_to_le16('\0') };
 
+void ntfs_attrlist_reset_locators(struct ntfs_attr_search_ctx *ctx)
+{
+	ctx->al_cursor = (struct ntfs_attrlist_cursor){ 0 };
+	ctx->al_insert = (struct ntfs_attrlist_anchor){ 0 };
+	ctx->al_exact = (struct ntfs_attrlist_exact){ 0 };
+}
+
+void ntfs_attrlist_capture_exact(struct ntfs_attr_search_ctx *ctx,
+				 struct ntfs_inode *base_ni,
+				 struct attr_list_entry *ale, u8 *al_start)
+{
+	ctx->al_exact.off = (u8 *)ale - al_start;
+	ctx->al_exact.gen = base_ni->attr_list_gen;
+	ctx->al_exact.valid = true;
+	ntfs_attrlist_exact_key_from_ale(&ctx->al_exact.key, ale);
+}
+
+static void ntfs_attrlist_capture_insert(struct ntfs_attr_search_ctx *ctx,
+					 struct ntfs_inode *base_ni,
+					 struct attr_list_entry *ale,
+					 u8 *al_start, u8 *al_end)
+{
+	ctx->al_insert.off = (u8 *)ale - al_start;
+	ctx->al_insert.gen = base_ni->attr_list_gen;
+	ctx->al_insert.valid = true;
+	ctx->al_insert.at_end = ((u8 *)ale == al_end);
+}
+
+void ntfs_attrlist_exact_key_from_ale(struct ntfs_attrlist_exact_key *key,
+				      const struct attr_list_entry *ale)
+{
+	key->type = ale->type;
+	key->lowest_vcn = ale->lowest_vcn;
+	key->mft_reference = ale->mft_reference;
+	key->instance = ale->instance;
+	key->name_len = ale->name_length;
+}
+
+bool ntfs_attrlist_exact_key_eq(const struct attr_list_entry *ale,
+				const struct ntfs_attrlist_exact_key *key)
+{
+	if (ale->type != key->type)
+		return false;
+	if (ale->lowest_vcn != key->lowest_vcn)
+		return false;
+	if (ale->mft_reference != key->mft_reference)
+		return false;
+	if (ale->instance != key->instance)
+		return false;
+
+	return ale->name_length == key->name_len;
+}
+
+static struct attr_list_entry *ntfs_attrlist_find_exact_locked(struct ntfs_inode *base_ni,
+							       struct ntfs_attrlist_exact *exact)
+{
+	struct attr_list_entry *ale;
+	u8 *al_end;
+
+	if (!exact->valid || !base_ni->attr_list)
+		return NULL;
+
+	al_end = base_ni->attr_list + base_ni->attr_list_size;
+	if (exact->gen == base_ni->attr_list_gen &&
+	    exact->off < base_ni->attr_list_size) {
+		ale = (struct attr_list_entry *)(base_ni->attr_list + exact->off);
+
+		if (ntfs_attr_list_entry_is_valid(ale, al_end) &&
+		    ntfs_attrlist_exact_key_eq(ale, &exact->key))
+			return ale;
+	}
+
+	for (ale = (struct attr_list_entry *)base_ni->attr_list;
+	     ntfs_attr_list_entry_is_valid(ale, al_end);
+	     ale = (struct attr_list_entry *)((u8 *)ale +
+					      le16_to_cpu(ale->length))) {
+		if (ntfs_attrlist_exact_key_eq(ale, &exact->key))
+			return ale;
+	}
+
+	return NULL;
+}
+
+static struct ntfs_inode *ntfs_attr_ctx_base_ni(struct ntfs_attr_search_ctx *ctx)
+{
+	if (ctx->ntfs_ino->nr_extents == -1)
+		return ctx->base_ntfs_ino;
+
+	return ctx->ntfs_ino;
+}
+
 /*
  * Maximum size allowed for reading attributes by ntfs_attr_readall().
  * Extended attribute, reparse point are not expected to be larger than this size.
@@ -1156,6 +1247,7 @@ static int ntfs_external_attr_find(const __le32 type,
 	u32 al_name_len;
 	u32 attr_len, mft_free_len;
 	bool is_first_search = false;
+	bool attr_list_locked = false;
 	int err = 0;
 	static const char *es = " Unmount and run chkdsk.";
 
@@ -1171,10 +1263,16 @@ static int ntfs_external_attr_find(const __le32 type,
 	if (type == AT_END)
 		goto not_found;
 	vol = base_ni->vol;
+	down_read(&base_ni->attr_list_lock);
+	attr_list_locked = true;
 	al_start = base_ni->attr_list;
 	al_end = al_start + base_ni->attr_list_size;
-	if (!ctx->al_entry) {
-		ctx->al_entry = (struct attr_list_entry *)al_start;
+	if (!ctx->al_cursor.valid ||
+	    ctx->al_cursor.gen != base_ni->attr_list_gen ||
+	    ctx->al_cursor.off >= base_ni->attr_list_size) {
+		ctx->al_cursor.off = 0;
+		ctx->al_cursor.gen = base_ni->attr_list_gen;
+		ctx->al_cursor.valid = true;
 		is_first_search = true;
 	}
 	/*
@@ -1182,7 +1280,7 @@ static int ntfs_external_attr_find(const __le32 type,
 	 * or the entry following that, if @ctx->is_first is 'true'.
 	 */
 	if (ctx->is_first) {
-		al_entry = ctx->al_entry;
+		al_entry = (struct attr_list_entry *)(al_start + ctx->al_cursor.off);
 		ctx->is_first = false;
 		/*
 		 * If an enumeration and the first attribute is higher than
@@ -1195,14 +1293,14 @@ static int ntfs_external_attr_find(const __le32 type,
 			goto find_attr_list_attr;
 	} else {
 		/* Check for small entry */
-		if (((al_end - (u8 *)ctx->al_entry) <
-		      (long)offsetof(struct attr_list_entry, name)) ||
-		    (le16_to_cpu(ctx->al_entry->length) & 7) ||
-		    (le16_to_cpu(ctx->al_entry->length) < offsetof(struct attr_list_entry, name)))
+		al_entry = (struct attr_list_entry *)(al_start + ctx->al_cursor.off);
+		if (((al_end - (u8 *)al_entry) < (long)offsetof(struct attr_list_entry, name)) ||
+		    (le16_to_cpu(al_entry->length) & 7) ||
+		    (le16_to_cpu(al_entry->length) < offsetof(struct attr_list_entry, name)))
 			goto corrupt;
 
-		al_entry = (struct attr_list_entry *)((u8 *)ctx->al_entry +
-				le16_to_cpu(ctx->al_entry->length));
+		al_entry = (struct attr_list_entry *)((u8 *)al_entry +
+						      le16_to_cpu(al_entry->length));
 
 		if ((u8 *)al_entry == al_end)
 			goto not_found;
@@ -1218,15 +1316,18 @@ static int ntfs_external_attr_find(const __le32 type,
 		 * attribute list attribute from the base mft record as it is
 		 * not listed in the attribute list itself.
 		 */
-		if ((type == AT_UNUSED) && le32_to_cpu(ctx->al_entry->type) <
-				le32_to_cpu(AT_ATTRIBUTE_LIST) &&
-				le32_to_cpu(al_entry->type) >
-				le32_to_cpu(AT_ATTRIBUTE_LIST)) {
+		if ((type == AT_UNUSED) &&
+		    le32_to_cpu(((struct attr_list_entry *)(al_start +
+							    ctx->al_cursor.off))->type) <
+		    le32_to_cpu(AT_ATTRIBUTE_LIST) &&
+		    le32_to_cpu(al_entry->type) > le32_to_cpu(AT_ATTRIBUTE_LIST)) {
 find_attr_list_attr:
 
 			/* Check for bogus calls. */
-			if (name || name_len || val || val_len || lowest_vcn)
-				return -EINVAL;
+			if (name || name_len || val || val_len || lowest_vcn) {
+				err = -EINVAL;
+				goto unlock_list_attr;
+			}
 
 			/* We want the base record. */
 			if (ctx->ntfs_ino != base_ni)
@@ -1248,28 +1349,33 @@ static int ntfs_external_attr_find(const __le32 type,
 			 * Setup the search context so the correct
 			 * attribute is returned next time round.
 			 */
-			ctx->al_entry = al_entry;
+			ctx->al_cursor.off = (u8 *)al_entry - al_start;
+			ctx->al_cursor.gen = base_ni->attr_list_gen;
+			ctx->al_cursor.valid = true;
 			ctx->is_first = true;
 
-			/* Got it. Done. */
 			if (!err)
-				return 0;
+				goto unlock_list_attr;
 
 			/* Error! If other than not found return it. */
 			if (err != -ENOENT)
-				return err;
+				goto unlock_list_attr;
 
 			/* Not found?!? Absurd! */
 			ntfs_error(ctx->ntfs_ino->vol->sb, "Attribute list wasn't found");
-			return -EIO;
+			err = -EIO;
+			goto unlock_list_attr;
 		}
 	}
 	for (;; al_entry = next_al_entry) {
+scan_ale:
 		/* Out of bounds check. */
 		if ((u8 *)al_entry < base_ni->attr_list ||
 				(u8 *)al_entry > al_end)
 			break;	/* Inode is corrupt. */
-		ctx->al_entry = al_entry;
+		ctx->al_cursor.off = (u8 *)al_entry - al_start;
+		ctx->al_cursor.gen = base_ni->attr_list_gen;
+		ctx->al_cursor.valid = true;
 		/* Catch the end of the attribute list. */
 		if ((u8 *)al_entry == al_end)
 			goto not_found;
@@ -1333,6 +1439,9 @@ static int ntfs_external_attr_find(const __le32 type,
 			if (rc)
 				continue;
 		}
+		if (type != AT_UNUSED &&
+		    le64_to_cpu(al_entry->lowest_vcn) > (u64)lowest_vcn)
+			goto not_found;
 		/*
 		 * The names match or @name not present and attribute is
 		 * unnamed.  Now check @lowest_vcn.  Continue search if the
@@ -1355,8 +1464,19 @@ static int ntfs_external_attr_find(const __le32 type,
 			continue;
 
 is_enumeration:
-		if (MREF_LE(al_entry->mft_reference) == ni->mft_no) {
-			if (MSEQNO_LE(al_entry->mft_reference) != ni->seq_no) {
+		/*
+		 * The extent mapping below takes extent_lock.  Keep only a
+		 * stable copy of this ALE while taking it, so the attr-list
+		 * read lock never nests outside extent_lock.
+		 */
+		ntfs_attrlist_capture_exact(ctx, base_ni, al_entry, al_start);
+		if (attr_list_locked)
+			up_read(&base_ni->attr_list_lock);
+		attr_list_locked = false;
+
+		if (MREF_LE(ctx->al_exact.key.mft_reference) == ni->mft_no) {
+			if (MSEQNO_LE(ctx->al_exact.key.mft_reference) !=
+			    ni->seq_no) {
 				ntfs_error(vol->sb,
 					"Found stale mft reference in attribute list of base inode 0x%llx.%s",
 					base_ni->mft_no, es);
@@ -1368,21 +1488,22 @@ static int ntfs_external_attr_find(const __le32 type,
 			if (ni != base_ni)
 				unmap_extent_mft_record(ni);
 			/* Do we want the base record back? */
-			if (MREF_LE(al_entry->mft_reference) ==
-					base_ni->mft_no) {
+			if (MREF_LE(ctx->al_exact.key.mft_reference) ==
+			    base_ni->mft_no) {
 				ni = ctx->ntfs_ino = base_ni;
 				ctx->mrec = ctx->base_mrec;
 				ctx->mapped_mrec = ctx->mapped_base_mrec;
 			} else {
 				/* We want an extent record. */
-				ctx->mrec = map_extent_mft_record(base_ni,
-						le64_to_cpu(
-						al_entry->mft_reference), &ni);
+				ctx->mrec =
+					map_extent_mft_record(base_ni, le64_to_cpu(
+								ctx->al_exact.key.mft_reference),
+							      &ni);
 				if (IS_ERR(ctx->mrec)) {
 					ntfs_error(vol->sb,
-							"Failed to map extent mft record 0x%lx of base inode 0x%llx.%s",
-							MREF_LE(al_entry->mft_reference),
-							base_ni->mft_no, es);
+						   "Failed to map extent mft record 0x%lx of base inode 0x%llx.%s",
+						   MREF_LE(ctx->al_exact.key.mft_reference),
+						   base_ni->mft_no, es);
 					err = PTR_ERR(ctx->mrec);
 					if (err == -ENOENT)
 						err = -EIO;
@@ -1392,7 +1513,6 @@ static int ntfs_external_attr_find(const __le32 type,
 				}
 				ctx->ntfs_ino = ni;
 				ctx->mapped_mrec = true;
-
 			}
 		}
 		a = ctx->attr = (struct attr_record *)((u8 *)ctx->mrec +
@@ -1424,8 +1544,19 @@ static int ntfs_external_attr_find(const __le32 type,
 
 		mft_free_len = le32_to_cpu(ctx->mrec->bytes_in_use) -
 			       ((u8 *)a - (u8 *)ctx->mrec);
-		if (mft_free_len >= sizeof(a->type) && a->type == AT_END)
-			continue;
+		if (mft_free_len >= sizeof(a->type) && a->type == AT_END) {
+			down_read(&base_ni->attr_list_lock);
+			attr_list_locked = true;
+			al_start = base_ni->attr_list;
+			al_end = al_start + base_ni->attr_list_size;
+			al_entry = ntfs_attrlist_find_exact_locked(base_ni,
+								   &ctx->al_exact);
+			if (!al_entry)
+				goto corrupt;
+			al_entry = (struct attr_list_entry *)((u8 *)al_entry +
+							      le16_to_cpu(al_entry->length));
+			goto scan_ale;
+		}
 
 		attr_len = le32_to_cpu(a->length);
 		if (!attr_len ||
@@ -1434,23 +1565,38 @@ static int ntfs_external_attr_find(const __le32 type,
 		    attr_len > mft_free_len)
 			break;
 
-		if (al_entry->instance != a->instance)
+		if (ctx->al_exact.key.instance != a->instance)
 			goto do_next_attr;
 		/*
 		 * If the type and/or the name are mismatched between the
 		 * attribute list entry and the attribute record, there is
 		 * corruption so we break and return error EIO.
 		 */
-		if (al_entry->type != a->type)
+		if (ctx->al_exact.key.type != a->type)
 			break;
 		if (a->name_length && ((le16_to_cpu(a->name_offset) +
 			       a->name_length * sizeof(__le16)) > attr_len))
 			break;
-		if (!ntfs_are_names_equal((__le16 *)((u8 *)a +
-				le16_to_cpu(a->name_offset)), a->name_length,
-				al_name, al_name_len, CASE_SENSITIVE,
-				vol->upcase, vol->upcase_len))
+		/*
+		 * al_entry's name isn't carried across the attr_list_lock
+		 * drop above; re-take the lock just long enough to re-locate
+		 * the same attr-list entry (same pattern as the AT_END case
+		 * above) and compare @a's on-disk name against it.  The
+		 * corrupt/unlock_list_attr labels below drop the lock again
+		 * via attr_list_locked on the not-found/mismatch paths.
+		 */
+		down_read(&base_ni->attr_list_lock);
+		attr_list_locked = true;
+		al_entry = ntfs_attrlist_find_exact_locked(base_ni, &ctx->al_exact);
+		if (!al_entry)
+			goto corrupt;
+		if (!ntfs_are_names_equal((__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+					  a->name_length, al_entry->name,
+					  al_entry->name_length, CASE_SENSITIVE,
+					  vol->upcase, vol->upcase_len))
 			break;
+		up_read(&base_ni->attr_list_lock);
+		attr_list_locked = false;
 
 		ctx->attr = a;
 
@@ -1480,6 +1626,11 @@ static int ntfs_external_attr_find(const __le32 type,
 		goto do_next_attr_loop;
 	}
 
+unlock_list_attr:
+	if (attr_list_locked)
+		up_read(&base_ni->attr_list_lock);
+	return err;
+
 corrupt:
 	if (ni != base_ni) {
 		if (ni)
@@ -1491,20 +1642,31 @@ static int ntfs_external_attr_find(const __le32 type,
 	}
 
 	if (!err) {
-		u64 mft_no = ctx->al_entry ? MREF_LE(ctx->al_entry->mft_reference) : 0;
-		u32 type = ctx->al_entry ? le32_to_cpu(ctx->al_entry->type) : 0;
+		u64 mft_no = ctx->al_exact.valid ?
+			MREF_LE(ctx->al_exact.key.mft_reference) :
+			0;
+		u32 ale_type = ctx->al_exact.valid ?
+			le32_to_cpu(ctx->al_exact.key.type) :
+			0;
 
 		ntfs_error(vol->sb,
-			"Base inode 0x%llx contains corrupt attribute, mft %#llx, type %#x. %s",
-			(long long)base_ni->mft_no, (long long)mft_no, type,
-			"Unmount and run chkdsk.");
+			   "Base inode 0x%llx contains corrupt attribute, mft %#llx, type %#x. %s",
+			   (long long)base_ni->mft_no, (long long)mft_no,
+			   ale_type, "Unmount and run chkdsk.");
 		err = -EIO;
 	}
 
+	if (attr_list_locked)
+		up_read(&base_ni->attr_list_lock);
 	if (err != -ENOMEM)
 		NVolSetErrors(vol);
 	return err;
 not_found:
+	if (attr_list_locked) {
+		ntfs_attrlist_capture_insert(ctx, base_ni, al_entry, al_start,
+					     al_end);
+		up_read(&base_ni->attr_list_lock);
+	}
 	/*
 	 * If we were looking for AT_END, we reset the search context @ctx and
 	 * use ntfs_attr_find() to seek to the end of the base mft record.
@@ -1634,11 +1796,11 @@ static bool ntfs_attr_init_search_ctx(struct ntfs_attr_search_ctx *ctx,
 	ctx->attr = (struct attr_record *)((u8 *)mrec + le16_to_cpu(mrec->attrs_offset));
 	ctx->is_first = true;
 	ctx->ntfs_ino = ni;
-	ctx->al_entry = NULL;
 	ctx->base_ntfs_ino = NULL;
 	ctx->base_mrec = NULL;
 	ctx->base_attr = NULL;
 	ctx->mapped_base_mrec = false;
+	ntfs_attrlist_reset_locators(ctx);
 	return true;
 }
 
@@ -1662,11 +1824,7 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
 		/* Sanity checks are performed elsewhere. */
 		ctx->attr = (struct attr_record *)((u8 *)ctx->mrec +
 				le16_to_cpu(ctx->mrec->attrs_offset));
-		/*
-		 * This needs resetting due to ntfs_external_attr_find() which
-		 * can leave it set despite having zeroed ctx->base_ntfs_ino.
-		 */
-		ctx->al_entry = NULL;
+		ntfs_attrlist_reset_locators(ctx);
 		return;
 	} /* Attribute list. */
 	if (ctx->ntfs_ino != ctx->base_ntfs_ino && ctx->ntfs_ino)
@@ -2626,13 +2784,12 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	 * update of attribute list.
 	 */
 	ntfs_attr_reinit_search_ctx(ctx);
-	err = ntfs_attr_lookup(type, name, name_len, CASE_SENSITIVE,
-				lowest_vcn, NULL, 0, ctx);
+	err = ntfs_attr_lookup(type, name, name_len, CASE_SENSITIVE, lowest_vcn,
+			       NULL, 0, ctx);
 	if (err) {
 		pr_err("%s: attribute lookup failed\n", __func__);
 		ntfs_attr_put_search_ctx(ctx);
 		return err;
-
 	}
 	offset = (u8 *)ctx->attr - (u8 *)ctx->mrec;
 	ntfs_attr_put_search_ctx(ctx);
@@ -3396,6 +3553,8 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	int err;
 	struct mft_record *ni_mrec;
 	struct super_block *sb;
+	struct ntfs_inode *base_ni;
+	struct attr_list_entry *ale;
 
 	if (!ctx || !ctx->attr || !ctx->ntfs_ino || !ni) {
 		ntfs_debug("Invalid arguments passed.\n");
@@ -3411,7 +3570,7 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	if (ctx->ntfs_ino == ni)
 		return 0;
 
-	if (!ctx->al_entry) {
+	if (!ctx->al_exact.valid) {
 		ntfs_debug("Inode should contain attribute list to use this function.\n");
 		return -EINVAL;
 	}
@@ -3465,9 +3624,24 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	mark_mft_record_dirty(ni);
 
 	/* Update attribute list. */
-	ctx->al_entry->mft_reference =
+	a = (struct attr_record *)nctx->attr;
+	base_ni = ntfs_attr_ctx_base_ni(ctx);
+
+	down_write(&base_ni->attr_list_lock);
+	ale = ntfs_attrlist_find_exact_locked(base_ni, &ctx->al_exact);
+	if (!ale) {
+		up_write(&base_ni->attr_list_lock);
+		unmap_mft_record(ni);
+		err = -EIO;
+		goto put_err_out;
+	}
+
+	ale->mft_reference =
 		MK_LE_MREF(ni->mft_no, le16_to_cpu(ni_mrec->sequence_number));
-	ctx->al_entry->instance = nctx->attr->instance;
+	ale->instance = nctx->attr->instance;
+	base_ni->attr_list_gen++;
+	ntfs_attrlist_capture_exact(ctx, base_ni, ale, base_ni->attr_list);
+	up_write(&base_ni->attr_list_lock);
 	unmap_mft_record(ni);
 put_err_out:
 	ntfs_attr_put_search_ctx(nctx);
@@ -3707,6 +3881,23 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
  * call to this function. Vice-versa @na->compressed_size will be calculated and
  * set to correct value during this function.
  */
+static bool ntfs_attr_ctx_matches_ni(const struct ntfs_attr_search_ctx *ctx,
+				     const struct ntfs_inode *ni)
+{
+	const struct attr_record *a = ctx->attr;
+	const __le16 *name;
+
+	if (a->type != ni->type || a->name_length != ni->name_len)
+		return false;
+	if (!a->name_length)
+		return true;
+
+	name = (const __le16 *)((const u8 *)a + le16_to_cpu(a->name_offset));
+	return ntfs_are_names_equal(name, a->name_length, ni->name,
+				    ni->name_len, CASE_SENSITIVE,
+				    ni->vol->upcase, ni->vol->upcase_len);
+}
+
 int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 {
 	struct ntfs_attr_search_ctx *ctx;
@@ -3715,11 +3906,12 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	struct attr_record *a;
 	s64 stop_vcn;
 	int err = 0, mp_size, cur_max_mp_size, exp_max_mp_size;
-	bool finished_build;
+	bool finished_build, attrlist_changed = false;
 	bool first_updated = false;
 	struct super_block *sb;
 	struct runlist_element *start_rl;
 	unsigned int de_cluster_count = 0;
+	bool first_lookup = true;
 
 retry:
 	if (!ni || !ni->runlist.rl)
@@ -3748,11 +3940,24 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	/* Fill attribute records with new mapping pairs. */
 	stop_vcn = 0;
 	finished_build = false;
+	first_lookup = true;
 	start_rl = ni->runlist.rl;
-	while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				CASE_SENSITIVE, from_vcn, NULL, 0, ctx))) {
+	while (1) {
 		unsigned int de_cnt = 0;
 
+		err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, CASE_SENSITIVE, 0,
+				       NULL, 0, ctx);
+		if (err)
+			break;
+		if (!ntfs_attr_ctx_matches_ni(ctx, ni))
+			continue;
+		if (first_lookup) {
+			if (le64_to_cpu(ctx->attr->data.non_resident.lowest_vcn) <
+					from_vcn)
+				continue;
+			first_lookup = false;
+		}
+
 		a = ctx->attr;
 		m = ctx->mrec;
 		if (!a->data.non_resident.lowest_vcn)
@@ -3878,15 +4083,40 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			}
 		}
 
-		/* Update lowest vcn. */
-		a->data.non_resident.lowest_vcn = cpu_to_le64(stop_vcn);
-		mark_mft_record_dirty(ctx->ntfs_ino);
-		if ((ctx->ntfs_ino->nr_extents == -1 || NInoAttrList(ctx->ntfs_ino)) &&
+		/*
+		 * al_cursor.valid is true here exactly when this iteration's
+		 * ntfs_attr_lookup() went through ntfs_external_attr_find()
+		 */
+		if (ctx->al_cursor.valid &&
 		    ctx->attr->type != AT_ATTRIBUTE_LIST) {
-			ctx->al_entry->lowest_vcn = cpu_to_le64(stop_vcn);
-			err = ntfs_attrlist_update(base_ni);
-			if (err)
+			struct attr_list_entry *ale;
+
+			down_write(&base_ni->attr_list_lock);
+			ale = ntfs_attrlist_find_exact_locked(base_ni,
+							      &ctx->al_exact);
+			if (!ale) {
+				up_write(&base_ni->attr_list_lock);
+				err = -EIO;
 				goto put_err_out;
+			}
+			ale->lowest_vcn = cpu_to_le64(stop_vcn);
+			base_ni->attr_list_gen++;
+			ntfs_attrlist_capture_exact(ctx, base_ni, ale,
+						    base_ni->attr_list);
+			ctx->al_cursor.off = (u8 *)ale - base_ni->attr_list;
+			ctx->al_cursor.gen = base_ni->attr_list_gen;
+			ctx->al_cursor.valid = true;
+			attrlist_changed = true;
+			up_write(&base_ni->attr_list_lock);
+
+			/* Update lowest vcn in attr record after ALE is fixed. */
+			a->data.non_resident.lowest_vcn = cpu_to_le64(stop_vcn);
+			mark_mft_record_dirty(ctx->ntfs_ino);
+
+		} else {
+			/* Update lowest vcn. */
+			a->data.non_resident.lowest_vcn = cpu_to_le64(stop_vcn);
+			mark_mft_record_dirty(ctx->ntfs_ino);
 		}
 
 		/*
@@ -3937,12 +4167,21 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 		}
 	}
 
+	if (attrlist_changed) {
+		err = ntfs_attrlist_update(base_ni);
+		if (err)
+			goto put_err_out;
+	}
+
 	/* Deallocate not used attribute extents and return with success. */
 	if (finished_build) {
 		ntfs_attr_reinit_search_ctx(ctx);
 		ntfs_debug("Deallocate marked extents.\n");
-		while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-				CASE_SENSITIVE, 0, NULL, 0, ctx))) {
+		while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0,
+						CASE_SENSITIVE, 0, NULL, 0,
+						ctx))) {
+			if (!ntfs_attr_ctx_matches_ni(ctx, ni))
+				continue;
 			if (le64_to_cpu(ctx->attr->data.non_resident.highest_vcn) !=
 					NTFS_VCN_DELETE_MARK)
 				continue;
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index e2224fbfaabe..a39719f75d06 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -15,6 +15,34 @@
 
 extern __le16 AT_UNNAMED[];
 
+struct ntfs_attrlist_cursor {
+	u32 off;
+	u64 gen;
+	bool valid;
+};
+
+struct ntfs_attrlist_anchor {
+	u32 off;
+	u64 gen;
+	bool valid;
+	bool at_end;
+};
+
+struct ntfs_attrlist_exact_key {
+	__le32 type;
+	__le64 lowest_vcn;
+	__le64 mft_reference;
+	__le16 instance;
+	u8 name_len;
+};
+
+struct ntfs_attrlist_exact {
+	u32 off;
+	u64 gen;
+	bool valid;
+	struct ntfs_attrlist_exact_key key;
+};
+
 /*
  * ntfs_attr_search_ctx - used in attribute search functions
  * @mrec: buffer containing mft record to search
@@ -22,10 +50,12 @@ extern __le16 AT_UNNAMED[];
  * @attr: attribute record in @mrec where to begin/continue search
  * @is_first: if true ntfs_attr_lookup() begins search with @attr, else after
  * @ntfs_ino: Inode owning this attribute search
- * @al_entry: Current attribute list entry
  * @base_ntfs_ino: Base inode
  * @mapped_base_mrec: true if @base_mrec was mapped by the search
  * @base_attr: Base attribute record pointer
+ * @al_cursor: Restartable attr-list enumeration cursor
+ * @al_insert: Insert-before anchor used on -ENOENT
+ * @al_exact: Exact ALE identity for writer-side updates
  *
  * Structure must be initialized to zero before the first call to one of the
  * attribute search functions. Initialize @mrec to point to the mft record to
@@ -45,11 +75,13 @@ struct ntfs_attr_search_ctx {
 	struct attr_record *attr;
 	bool is_first;
 	struct ntfs_inode *ntfs_ino;
-	struct attr_list_entry *al_entry;
 	struct ntfs_inode *base_ntfs_ino;
 	struct mft_record *base_mrec;
 	bool mapped_base_mrec;
 	struct attr_record *base_attr;
+	struct ntfs_attrlist_cursor al_cursor;
+	struct ntfs_attrlist_anchor al_insert;
+	struct ntfs_attrlist_exact al_exact;
 };
 
 enum {                  /* ways of processing holes when expanding */
@@ -89,6 +121,14 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx);
 struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
 		struct mft_record *mrec);
 void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx);
+void ntfs_attrlist_reset_locators(struct ntfs_attr_search_ctx *ctx);
+void ntfs_attrlist_capture_exact(struct ntfs_attr_search_ctx *ctx,
+				 struct ntfs_inode *base_ni,
+				 struct attr_list_entry *ale, u8 *al_start);
+void ntfs_attrlist_exact_key_from_ale(struct ntfs_attrlist_exact_key *key,
+				      const struct attr_list_entry *ale);
+bool ntfs_attrlist_exact_key_eq(const struct attr_list_entry *ale,
+				const struct ntfs_attrlist_exact_key *key);
 int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol,
 		const __le32 type, const s64 size);
 int ntfs_attr_can_be_resident(const struct ntfs_volume *vol,
diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index be3086d34338..b8594037df40 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -182,15 +182,16 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 			0 : le32_to_cpu(attr->data.resident.value_length), ctx);
 	if (!err) {
 		/* Found some extent, check it to be before new extent. */
-		if (ctx->al_entry->lowest_vcn == lowest_vcn) {
+		if (ctx->al_exact.key.lowest_vcn == lowest_vcn) {
 			err = -EEXIST;
 			ntfs_debug("Such attribute already present in the attribute list.\n");
 			ntfs_attr_put_search_ctx(ctx);
 			goto err_out;
 		}
 		/* Add new entry after this extent. */
-		ale = (struct attr_list_entry *)((u8 *)ctx->al_entry +
-				le16_to_cpu(ctx->al_entry->length));
+		entry_offset = ctx->al_exact.off +
+			le16_to_cpu(((struct attr_list_entry *)(ni->attr_list +
+								ctx->al_exact.off))->length);
 	} else {
 		/* Check for real errors. */
 		if (err != -ENOENT) {
@@ -199,13 +200,11 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 			goto err_out;
 		}
 		/* No previous extents found. */
-		ale = ctx->al_entry;
+		entry_offset = ctx->al_insert.off;
 	}
 	/* Don't need it anymore, @ctx->al_entry points to @ni->attr_list. */
 	ntfs_attr_put_search_ctx(ctx);
 
-	/* Determine new entry offset. */
-	entry_offset = ((u8 *)ale - ni->attr_list);
 	/* Set pointer to new entry. */
 	ale = (struct attr_list_entry *)(new_al + entry_offset);
 	memset(ale, 0, entry_len);
@@ -261,7 +260,7 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 	struct ntfs_inode *base_ni;
 	struct attr_list_entry *ale;
 
-	if (!ctx || !ctx->ntfs_ino || !ctx->al_entry) {
+	if (!ctx || !ctx->ntfs_ino || !ctx->al_exact.valid) {
 		ntfs_debug("Invalid arguments.\n");
 		return -EINVAL;
 	}
@@ -270,12 +269,14 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 		base_ni = ctx->base_ntfs_ino;
 	else
 		base_ni = ctx->ntfs_ino;
-	ale = ctx->al_entry;
+	if (ctx->al_exact.off >= base_ni->attr_list_size)
+		return -EIO;
+	ale = (struct attr_list_entry *)(base_ni->attr_list + ctx->al_exact.off);
 
 	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, lowest_vcn %lld.\n",
-			(long long)ctx->ntfs_ino->mft_no,
-			(unsigned int)le32_to_cpu(ctx->al_entry->type),
-			(long long)le64_to_cpu(ctx->al_entry->lowest_vcn));
+		   (long long)ctx->ntfs_ino->mft_no,
+		   (unsigned int)le32_to_cpu(ctx->al_exact.key.type),
+		   (long long)le64_to_cpu(ctx->al_exact.key.lowest_vcn));
 
 	if (!NInoAttrList(base_ni)) {
 		ntfs_debug("Attribute list isn't present.\n");
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 409759eab55d..082fe9226c72 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1346,7 +1346,8 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 	 * When there is no space to build a non-resident
 	 * index, we may have to move the root to an extent
 	 */
-	if ((ret == -ENOSPC) && (ctx->al_entry || !ntfs_inode_add_attrlist(icx->idx_ni))) {
+	if ((ret == -ENOSPC) &&
+	    (ctx->al_cursor.valid || !ntfs_inode_add_attrlist(icx->idx_ni))) {
 		ntfs_attr_put_search_ctx(ctx);
 		ctx = NULL;
 		ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 39c7fd8c1149..38206e2009e2 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -475,6 +475,8 @@ void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 	ni->folio = NULL;
 	ni->folio_ofs = 0;
 	ni->mrec = NULL;
+	init_rwsem(&ni->attr_list_lock);
+	ni->attr_list_gen = 0;
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
 	ni->itype.index.block_size = 0;
@@ -3327,19 +3329,25 @@ static int ntfs_attr_position(__le32 type, struct ntfs_attr_search_ctx *ctx)
 		if (atype == AT_END)
 			return -ENOSPC;
 
-		/*
-		 * if ntfs_external_attr_lookup return -ENOENT, ctx->al_entry
-		 * could point to an attribute in an extent mft record, but
-		 * ctx->attr and ctx->ntfs_ino always points to an attibute in
-		 * a base mft record.
-		 */
-		if (ctx->al_entry &&
-		    MREF_LE(ctx->al_entry->mft_reference) != ctx->ntfs_ino->mft_no) {
-			ntfs_attr_reinit_search_ctx(ctx);
-			err = ntfs_attr_lookup(atype, NULL, 0, CASE_SENSITIVE, 0, NULL,
-					       0, ctx);
-			if (err)
-				return err;
+		if (ctx->al_insert.valid && !ctx->al_insert.at_end &&
+		    ctx->al_insert.off < ntfs_inode_base(ctx->ntfs_ino)->attr_list_size) {
+			struct ntfs_inode *base_ni =
+				ntfs_inode_base(ctx->ntfs_ino);
+			struct attr_list_entry *ale =
+				(struct attr_list_entry *)(base_ni->attr_list +
+							   ctx->al_insert.off);
+
+			if (MREF_LE(ale->mft_reference) != ctx->ntfs_ino->mft_no) {
+				ntfs_attr_reinit_search_ctx(ctx);
+				err = ntfs_attr_lookup(atype, NULL, 0,
+						       CASE_SENSITIVE, 0, NULL,
+						       0, ctx);
+				if (err)
+					return err;
+			} else {
+				ntfs_attrlist_capture_exact(ctx, base_ni, ale,
+							    base_ni->attr_list);
+			}
 		}
 	}
 	return 0;
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index c6d065aaecd5..ed00e06c5d14 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -10,6 +10,8 @@
 #ifndef _LINUX_NTFS_INODE_H
 #define _LINUX_NTFS_INODE_H
 
+#include <linux/rwsem.h>
+
 #include "debug.h"
 
 enum ntfs_inode_mutex_lock_class {
@@ -66,6 +68,8 @@ enum ntfs_inode_mutex_lock_class {
  * Attribute list support (only for use by the attribute lookup
  * functions). Setup during read_inode for all inodes with attribute
  * lists. Only valid if NI_AttrList is set in state.
+ * @attr_list_lock: Protects in-memory attribute list state.
+ * @attr_list_gen: Generation of the in-memory attribute list state.
  * @attr_list_size: Length of attribute list value in bytes.
  * @attr_list: Attribute list value itself.
  *
@@ -118,6 +122,8 @@ struct ntfs_inode {
 	int folio_ofs;
 	s64 mft_lcn[2];
 	unsigned int mft_lcn_count;
+	struct rw_semaphore attr_list_lock;
+	u64 attr_list_gen;
 	u32 attr_list_size;
 	u8 *attr_list;
 	union {

-- 
2.43.0

