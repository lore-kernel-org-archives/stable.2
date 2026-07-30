Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C284357D10
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387423; cv=none; b=lQxKRmofHSEqRZf7Jr1hFJyiFequl0mzB3u1EwVGf3Av5oYa3vFKnG0J1V64DYn6NxN85OOTWPMsWWcdGft4W5fgTWUcsBOZin0SkN/swt2+pdpUieT3i3KMMwqktpQcaNZXGYbDYnT2/wqW2hoWktybb3M2zR3Y8S9LHT7R0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387423; c=relaxed/simple;
	bh=/DpGDKCRNSwOJ4e2gjj/6+GU0xi1Pg9BwTXEz7fudl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVGc4cZCFf3Ls3yNUUUQJhKvIf+n72vL23wKbUGiC9kutskE684gi0ImP0l3oCEA/59ju3jAQGzdKC554KmeqUQAOJsT6Bd271OWkmMDmIBQTJ7AAw5DMUchTYNQFYma3mPsKHNoarK4NuCQjBYEomOdphLZwy7xjIOllY5e3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL0hlkqY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL0hlkqY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceb096e675so21909085ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785387420; x=1785992220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z2fD/BYJJrUW26O8wgfb03QEcJj9OH1ct1jtdbfBvvw=;
        b=OL0hlkqYWX3QDbO0bs3EfbaOvZViA9UjKdNsOZOmwqIUyIQMFvmzP14E2AmV/shAKL
         5Vgny83edGHw2kVdUylZd5Ue+0AodEE+HSkFRuu4QdP+aasKORo8lWHUKLLjHG2pYgry
         OqMKeVLUqiRVBTVT38WCMVgL9T3e54Bs3SoOD0FfJOasZthFCTbXnAvaNOIENOl0pvg2
         z6x2uCMZOM/KebNoIzos/VwGTI/n61Hbi96SjKoZ9EmNH9RNgGJAe8YhsxBwxH5w6KVR
         OBioYM61iHnPTOihacknwBTWC/Te9P+kdx4KEkMBElv4C2XXAN8MEDAaoh8T82RSH0Yj
         GmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785387420; x=1785992220;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2fD/BYJJrUW26O8wgfb03QEcJj9OH1ct1jtdbfBvvw=;
        b=E2QsEoNRh/2+aRbGTA7ASw7DAF/ETHmk+WOhrbjLvYT03nefJP6qTXtKqa9qTCnDdc
         ejq7UIrT61kGqjufq0wRuU3uUcpr2kHrKLev5G72JfidF1/zBn2IjjXgH3OINePWLbye
         1hV1f1kbY2A91SXp9V2Jq7kjq9IsW5MRkMWm1Fl/YvmZaq6XX+Bx+gPN6UhKjpx6RpgY
         AGxOE3NXVEQFSP3oXvTthd1jtcptDGEjfJKrfAtyCVyVnVBJ7jCx3twZpPlKZfzf2RGd
         9u8AitM/SEMJuru7Q9lEBzOz9e6IvN7eTnk2yN1W9VUcqYJJaKSbGNmSNX2aR7Syfb95
         kOQw==
X-Forwarded-Encrypted: i=1; AHgh+Rqd7t4NRrNbFNfA+L6SSlzJhsHmJ/62MqTe1sJUcmGSdzzipbHXdFmkVhO9hsIkG5300eycTcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGTpfQQqbSCIG/xcveQEEuMUPrd3YSpziBpSw1MdMY8J7KbSJ
	fqukPh+oyWHF9XalrMx3e/02e2gkpdc78dHcCVvZS5FEwfa00a0SDyiq+bDg6Q==
X-Gm-Gg: AR+sD11i1hLpMQcw44UrYV+EgdfpmpfC8PgFCThxG74u/cUQAhKXjsYphYa/Wz3Rdd7
	piap98PopC7BhFDZcR7soCxdCItNYFhnep31aVu1HYqsByzdkzBQ1IVW/FR/jEUggGUHn/3IUvF
	eQsqx3zYEJl0T8OUny19tvqzZr9D6BmOI+5LkaAZYMOc3vvFRkerkXSdThO7Vzn6YX9/OaFaHdk
	lh+aPuE4L1H5grUe7EeVxIbJusqoD8EqfyUNbgFSZ5IgLF4VlsFlvCmskZMNj5NKLlSVcu5FNTT
	IDIz9lUrf4qbWxcq9Q9clF7MaxPhZqCrPOGFmTQ2/MAL+Q4Vcyz+bO6aNxu5ckyt7DsxqoGKiu6
	aq2QVTcaww1aQXqmQ+5/jdvGSQZJdEFiGgpYpzYOSOd2GQ7yxQYjj0cazxC7wZ4UiMiNux0D85+
	M3RCo+ri88IQnZyjK1Exz7hVSxDf2RMVzCQxGcAkoJ+6zR3k0DPxsK3fpM2IEpWrhE0BzPBpDhn
	sCBrRZzj9VnhQ==
X-Received: by 2002:a17:903:b90:b0:2cf:7882:a444 with SMTP id d9443c01a7336-2d035bbb37dmr13048785ad.16.1785387420245;
        Wed, 29 Jul 2026 21:57:00 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46969sm19875325ad.25.2026.07.29.21.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:56:59 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/4] ntfs: replace raw ctx->al_entry with restartable attr-list locators
Date: Thu, 30 Jul 2026 13:56:12 +0900
Message-ID: <20260730-topic-attr-list-lock-v6-v4-1-80d5fe0a6951@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730-topic-attr-list-lock-v6-v4-0-80d5fe0a6951@gmail.com>
References: <20260730-topic-attr-list-lock-v6-v4-0-80d5fe0a6951@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785387323; l=32695; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=/DpGDKCRNSwOJ4e2gjj/6+GU0xi1Pg9BwTXEz7fudl4=; b=v432BktsLbWQkRE2o07MAJ2uZVMCyCgxds9MFUn6a8hVDpIjmoTSZRCiqFLThYpnr60teuTdS ocDnYHyLktIC6ZeoPf3IPkfYHQ8YjLnz83FopFGibichrepbIN+Xpca
X-Developer-Key: i=hyc.lee@gmail.com; a=ed25519; pk=XjFN8PRLk/ZCdNmwABbNomUbzLtXDFRX8iJkKn3fgGc=
Content-Transfer-Encoding: 8bit

ntfs_attr_search_ctx kept a raw al_entry pointer into the in-memory
$ATTRIBUTE_LIST buffer.  Any insertion or removal reallocates the
whole buffer, so that pointer becomes stale while the context is still
alive across extent mapping, record moves, and mapping-pair rebuilds.

Replace the raw pointer with three generation-checked locators:

 - al_cursor: resume position for ntfs_external_attr_find()
 - al_insert: insertion point captured on -ENOENT
 - al_exact: identity snapshot used by writers to re-find an entry

Add attr_list_lock (rw_semaphore) and attr_list_gen to protect the
in-memory list and detect stale locators.  ntfs_external_attr_find()
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
index 239b7bcbaedf..6b932feb1a36 100644
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
@@ -1129,6 +1220,7 @@ static int ntfs_external_attr_find(const __le32 type,
 	u32 al_name_len;
 	u32 attr_len, mft_free_len;
 	bool is_first_search = false;
+	bool attr_list_locked = false;
 	int err = 0;
 	static const char *es = " Unmount and run chkdsk.";
 
@@ -1144,10 +1236,16 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1155,7 +1253,7 @@ static int ntfs_external_attr_find(const __le32 type,
 	 * or the entry following that, if @ctx->is_first is 'true'.
 	 */
 	if (ctx->is_first) {
-		al_entry = ctx->al_entry;
+		al_entry = (struct attr_list_entry *)(al_start + ctx->al_cursor.off);
 		ctx->is_first = false;
 		/*
 		 * If an enumeration and the first attribute is higher than
@@ -1168,14 +1266,14 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1191,15 +1289,18 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1221,28 +1322,33 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1306,6 +1412,9 @@ static int ntfs_external_attr_find(const __le32 type,
 			if (rc)
 				continue;
 		}
+		if (type != AT_UNUSED &&
+		    le64_to_cpu(al_entry->lowest_vcn) > (u64)lowest_vcn)
+			goto not_found;
 		/*
 		 * The names match or @name not present and attribute is
 		 * unnamed.  Now check @lowest_vcn.  Continue search if the
@@ -1328,8 +1437,19 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1341,21 +1461,22 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1365,7 +1486,6 @@ static int ntfs_external_attr_find(const __le32 type,
 				}
 				ctx->ntfs_ino = ni;
 				ctx->mapped_mrec = true;
-
 			}
 		}
 		a = ctx->attr = (struct attr_record *)((u8 *)ctx->mrec +
@@ -1397,8 +1517,19 @@ static int ntfs_external_attr_find(const __le32 type,
 
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
@@ -1407,23 +1538,38 @@ static int ntfs_external_attr_find(const __le32 type,
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
 
@@ -1453,6 +1599,11 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1464,20 +1615,31 @@ static int ntfs_external_attr_find(const __le32 type,
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
@@ -1607,11 +1769,11 @@ static bool ntfs_attr_init_search_ctx(struct ntfs_attr_search_ctx *ctx,
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
 
@@ -1635,11 +1797,7 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
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
@@ -2599,13 +2757,12 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
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
@@ -3369,6 +3526,8 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	int err;
 	struct mft_record *ni_mrec;
 	struct super_block *sb;
+	struct ntfs_inode *base_ni;
+	struct attr_list_entry *ale;
 
 	if (!ctx || !ctx->attr || !ctx->ntfs_ino || !ni) {
 		ntfs_debug("Invalid arguments passed.\n");
@@ -3384,7 +3543,7 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	if (ctx->ntfs_ino == ni)
 		return 0;
 
-	if (!ctx->al_entry) {
+	if (!ctx->al_exact.valid) {
 		ntfs_debug("Inode should contain attribute list to use this function.\n");
 		return -EINVAL;
 	}
@@ -3438,9 +3597,24 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
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
@@ -3680,6 +3854,23 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
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
@@ -3688,11 +3879,12 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -3721,11 +3913,24 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -3851,15 +4056,40 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -3910,12 +4140,21 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
index faa7ee920a3a..92d180c9f5c4 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1335,7 +1335,8 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
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
index 7381a18cfadd..72d8b6c9016b 100644
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
@@ -3328,19 +3330,25 @@ static int ntfs_attr_position(__le32 type, struct ntfs_attr_search_ctx *ctx)
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
index 9aacd5787ffe..a99c228184ce 100644
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

