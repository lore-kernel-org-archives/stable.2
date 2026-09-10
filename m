Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D93546EC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005559; cv=none; b=G3SoPIlnPQsowras7VlvRXF8wBYWNw+cRNCaYgU67y74dtKS7hnQk70qCEIB+TbFcw7b7xSgWHhKdN1FtuZltWJJUexTcX4tSIRAhMFji+7jNUE2W3rKUOQZ8xTEgvo0L/vnIYMxoZ8oQGemdzbtZ5WQyNZpb75paY8SaDng22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005559; c=relaxed/simple;
	bh=6e6Jv/mRyk1F1A4UU3/UVUYJBGMbdsk0WyndHrhYrwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mICnTxXi0M9kL3VZuMkR3JtE4V6Tfgg2ZLwTIIuvkFYmflphgYOimykm1Ed2xNtrO7LwY2ZUnQ6FCkOEtpjun++T//LmkqMFRfatBgIvod5Z/HVZkUtMVAdRu7T8OEqCXLfTnIuqj679u1gmqADFzlqoXxY2vGJJqklZ9rjM/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izq0uBFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izq0uBFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA03C1F00899;
	Thu, 10 Sep 2026 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005557;
	bh=pubKfdFgYVxTaGWS4R0cLYW7C309G5Cd17CNLoa+Yy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izq0uBFxvTP3qVjJJJdg8PJE5cPOQM/brwvTbtiETOAoPTq5RToEeU2UiIsCZXxvv
	 iC/y7J5PFIDjMi40k2wT1qYEGi3Wxo3fr+v4Axcy959TMhB3/4TExmhASHDQdEu/yw
	 OZgDiBkhLnlh2I6v6pYCuivN20iFoyqoKloFFKQpvz3rc58MA+wDsZ9hR/WxKDYcf4
	 emKheLGBL0REvLd3pT4PF9xzTFe9fKposOdZBbOpljP4HrUovlAFCm17UVtcr8rQxZ
	 tt3jR35CFZLpOXjYHI2cLYSz4MYT/KtpO6N3oKgr2klI+lUUpWhWfCnJaz3+zTJ4OR
	 Lasw9gxuPHfNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
Date: Wed,  9 Sep 2026 21:59:13 -0400
Message-ID: <20260910015914.3948870-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910015914.3948870-1-sashal@kernel.org>
References: <2026090804-handiwork-afford-7887@gregkh>
 <20260910015914.3948870-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 2afd4d267e6dbaec8d3ccd4f5396cb84bc67aa2e ]

Extended the `mi_enum_attr()` function interface with an additional
parameter, `struct ntfs_inode *ni`, to allow marking the inode
as bad as soon as an error is detected.

Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Backport notes for 6.1:
- Thread the inode through the existing record helpers and all stable-tree
  callers while retaining the size_t name length in mi_find_attr().
- Preserve attr_data_get_block()'s existing segment-update control flow,
  resident-name validation, and the function-scope diff variable.
- Use kzalloc() and return -ENOMEM directly for the initial allocation in
  ni_create_attr_list(). This supplies the allocation context expected by
  7c4841e2a627 without folding its attribute-list sizing fix into this dep;
  it also avoids reporting success when that allocation fails.
- Reuse the existing _ntfs_bad_inode() macro; no functions are added.

Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c  | 11 ++++---
 fs/ntfs3/frecord.c | 67 +++++++++++++++++++-------------------
 fs/ntfs3/ntfs_fs.h | 22 +++++++------
 fs/ntfs3/record.c  | 80 +++++++++++++++++++++++++---------------------
 4 files changed, 95 insertions(+), 85 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index f4573d276a2cc..db4f2dffed950 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -815,7 +815,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		if (err)
 			goto out;
 
-		attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len,
+				    &le->id);
 		if (!attr) {
 			err = -EINVAL;
 			goto bad_inode;
@@ -1166,7 +1167,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 				goto out;
 			}
 
-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0,
 					    &le->id);
 			if (!attr) {
 				err = -EINVAL;
@@ -1786,7 +1787,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 				goto out;
 			}
 
-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0,
 					    &le->id);
 			if (!attr) {
 				err = -EINVAL;
@@ -2031,8 +2032,8 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				}
 
 				/* Look for required attribute. */
-				attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL,
-						    0, &le->id);
+				attr = mi_find_attr(ni, mi, NULL, ATTR_DATA,
+						    NULL, 0, &le->id);
 				if (!attr) {
 					err = -EINVAL;
 					goto out;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c6f1059894830..89895ee524440 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -75,7 +75,7 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO))
 		    : NULL;
 }
@@ -89,7 +89,7 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5))
 		    : NULL;
@@ -201,7 +201,8 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 			*mi = &ni->mi;
 
 		/* Look for required attribute in primary record. */
-		return mi_find_attr(&ni->mi, attr, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, attr, type, name, name_len,
+				    NULL);
 	}
 
 	/* First look for list entry of required type. */
@@ -217,7 +218,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 		return NULL;
 
 	/* Look for required attribute. */
-	attr = mi_find_attr(m, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, m, NULL, type, name, name_len, &le->id);
 
 	if (!attr)
 		goto out;
@@ -258,7 +259,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		if (mi)
 			*mi = &ni->mi;
 		/* Enum attributes in primary record. */
-		return mi_enum_attr(&ni->mi, attr);
+		return mi_enum_attr(ni, &ni->mi, attr);
 	}
 
 	/* Get next list entry. */
@@ -274,7 +275,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		*mi = mi2;
 
 	/* Find attribute in loaded record. */
-	return rec_find_attr_le(mi2, le2);
+	return rec_find_attr_le(ni, mi2, le2);
 }
 
 /*
@@ -292,7 +293,8 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (!ni->attr_list.size) {
 		if (pmi)
 			*pmi = &ni->mi;
-		return mi_find_attr(&ni->mi, NULL, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, NULL, type, name, name_len,
+				    NULL);
 	}
 
 	le = al_find_ex(ni, NULL, type, name, name_len, NULL);
@@ -318,7 +320,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (pmi)
 		*pmi = mi;
 
-	attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, mi, NULL, type, name, name_len, &le->id);
 	if (!attr)
 		return NULL;
 
@@ -399,7 +401,8 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	int diff;
 
 	if (base_only || type == ATTR_LIST || !ni->attr_list.size) {
-		attr = mi_find_attr(&ni->mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, &ni->mi, NULL, type, name, name_len,
+				    id);
 		if (!attr)
 			return -ENOENT;
 
@@ -438,7 +441,7 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 
 		al_remove_le(ni, le);
 
-		attr = mi_find_attr(mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len, id);
 		if (!attr)
 			return -ENOENT;
 
@@ -486,7 +489,7 @@ ni_ins_new_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		name = le->name;
 	}
 
-	attr = mi_insert_attr(mi, type, name, name_len, asize, name_off);
+	attr = mi_insert_attr(ni, mi, type, name, name_len, asize, name_off);
 	if (!attr) {
 		if (le_added)
 			al_remove_le(ni, le);
@@ -670,7 +673,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 	if (err)
 		return err;
 
-	attr_list = mi_find_attr(&ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
+	attr_list = mi_find_attr(ni, &ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
 	if (!attr_list)
 		return 0;
 
@@ -692,7 +695,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		if (!mi)
 			return 0;
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr)
 			return 0;
@@ -728,7 +731,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 			goto out;
 		}
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr) {
 			/* Should never happened, 'cause already checked. */
@@ -737,7 +740,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);
 
 		/* Insert into primary record. */
-		attr_ins = mi_insert_attr(&ni->mi, le->type, le_name(le),
+		attr_ins = mi_insert_attr(ni, &ni->mi, le->type, le_name(le),
 					  le->name_len, asize,
 					  le16_to_cpu(attr->name_off));
 		if (!attr_ins) {
@@ -765,7 +768,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		if (!mi)
 			continue;
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr)
 			continue;
@@ -816,11 +819,9 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
-	if (!le) {
-		err = -ENOMEM;
-		goto out;
-	}
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
+	if (!le)
+		return -ENOMEM;
 
 	mi_get_ref(&ni->mi, &le->ref);
 	ni->attr_list.le = le;
@@ -830,7 +831,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	free_b = 0;
 	attr = NULL;
 
-	for (; (attr = mi_enum_attr(&ni->mi, attr)); le = Add2Ptr(le, sz)) {
+	for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
 		sz = le_size(attr->name_len);
 		le->type = attr->type;
 		le->size = cpu_to_le16(sz);
@@ -885,7 +886,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 		u32 asize = le32_to_cpu(b->size);
 		u16 name_off = le16_to_cpu(b->name_off);
 
-		attr = mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
+		attr = mi_insert_attr(ni, mi, b->type, Add2Ptr(b, name_off),
 				      b->name_len, asize, name_off);
 		if (!attr)
 			goto out1;
@@ -908,7 +909,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 			goto out1;
 	}
 
-	attr = mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
+	attr = mi_insert_attr(ni, &ni->mi, ATTR_LIST, NULL, 0,
 			      lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
 	if (!attr)
 		goto out1;
@@ -995,13 +996,13 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		mi = rb_entry(node, struct mft_inode, node);
 
 		if (is_mft_data &&
-		    (mi_enum_attr(mi, NULL) ||
+		    (mi_enum_attr(ni, mi, NULL) ||
 		     vbo <= ((u64)mi->rno << sbi->record_bits))) {
 			/* We can't accept this record 'cause MFT's bootstrapping. */
 			continue;
 		}
 		if (is_mft &&
-		    mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
+		    mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
 			/*
 			 * This child record already has a ATTR_DATA.
 			 * So it can't accept any other records.
@@ -1010,7 +1011,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		}
 
 		if ((type != ATTR_NAME || name_len) &&
-		    mi_find_attr(mi, NULL, type, name, name_len, NULL)) {
+		    mi_find_attr(ni, mi, NULL, type, name, name_len, NULL)) {
 			/* Only indexed attributes can share same record. */
 			continue;
 		}
@@ -1159,7 +1160,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	/* Estimate the result of moving all possible attributes away. */
 	attr = NULL;
 
-	while ((attr = mi_enum_attr(&ni->mi, attr))) {
+	while ((attr = mi_enum_attr(ni, &ni->mi, attr))) {
 		if (attr->type == ATTR_STD)
 			continue;
 		if (attr->type == ATTR_LIST)
@@ -1177,7 +1178,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	attr = NULL;
 
 	for (;;) {
-		attr = mi_enum_attr(&ni->mi, attr);
+		attr = mi_enum_attr(ni, &ni->mi, attr);
 		if (!attr) {
 			/* We should never be here 'cause we have already check this case. */
 			err = -EINVAL;
@@ -1261,7 +1262,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
 		mi = rb_entry(node, struct mft_inode, node);
 
-		attr = mi_enum_attr(mi, NULL);
+		attr = mi_enum_attr(ni, mi, NULL);
 
 		if (!attr) {
 			mft_min = mi->rno;
@@ -1282,7 +1283,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 		ni_remove_mi(ni, mi_new);
 	}
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
 	if (!attr) {
 		err = -EINVAL;
 		goto out;
@@ -1399,7 +1400,7 @@ int ni_expand_list(struct ntfs_inode *ni)
 			continue;
 
 		/* Find attribute in primary record. */
-		attr = rec_find_attr_le(&ni->mi, le);
+		attr = rec_find_attr_le(ni, &ni->mi, le);
 		if (!attr) {
 			err = -EINVAL;
 			goto out;
@@ -3427,7 +3428,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		if (!mi->dirty)
 			continue;
 
-		is_empty = !mi_enum_attr(mi, NULL);
+		is_empty = !mi_enum_attr(ni, mi, NULL);
 
 		if (is_empty)
 			clear_rec_inuse(mi->mrec);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 482958c016444..e0459055eeee5 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -733,23 +733,25 @@ int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi);
 void mi_put(struct mft_inode *mi);
 int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno);
 int mi_read(struct mft_inode *mi, bool is_mft);
-struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr);
-// TODO: id?
-struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
-			    enum ATTR_TYPE type, const __le16 *name,
-			    size_t name_len, const __le16 *id);
-static inline struct ATTRIB *rec_find_attr_le(struct mft_inode *rec,
+struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr);
+struct ATTRIB *mi_find_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr, enum ATTR_TYPE type,
+			    const __le16 *name, size_t name_len,
+			    const __le16 *id);
+static inline struct ATTRIB *rec_find_attr_le(struct ntfs_inode *ni,
+					      struct mft_inode *rec,
 					      struct ATTR_LIST_ENTRY *le)
 {
-	return mi_find_attr(rec, NULL, le->type, le_name(le), le->name_len,
+	return mi_find_attr(ni, rec, NULL, le->type, le_name(le), le->name_len,
 			    &le->id);
 }
 int mi_write(struct mft_inode *mi, int wait);
 int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
 		  __le16 flags, bool is_mft);
-struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
-			      const __le16 *name, u8 name_len, u32 asize,
-			      u16 name_off);
+struct ATTRIB *mi_insert_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			      enum ATTR_TYPE type, const __le16 *name,
+			      u8 name_len, u32 asize, u16 name_off);
 
 bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		    struct ATTRIB *attr);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index d8d43f6a96fd0..f380c8104d9f6 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -31,7 +31,7 @@ static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
  *
  * Return: Unused attribute id that is less than mrec->next_attr_id.
  */
-static __le16 mi_new_attt_id(struct mft_inode *mi)
+static __le16 mi_new_attt_id(struct ntfs_inode *ni, struct mft_inode *mi)
 {
 	u16 free_id, max_id, t16;
 	struct MFT_REC *rec = mi->mrec;
@@ -52,7 +52,7 @@ static __le16 mi_new_attt_id(struct mft_inode *mi)
 	attr = NULL;
 
 	for (;;) {
-		attr = mi_enum_attr(mi, attr);
+		attr = mi_enum_attr(ni, mi, attr);
 		if (!attr) {
 			rec->next_attr_id = cpu_to_le16(max_id + 1);
 			mi->dirty = true;
@@ -189,7 +189,8 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	return err;
 }
 
-struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
+struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
@@ -203,11 +204,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off = le16_to_cpu(rec->attr_off);
 
 		if (used > total)
-			return NULL;
+			goto out;
 
 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
 		    !IS_ALIGNED(off, 8)) {
-			return NULL;
+			goto out;
 		}
 
 		/* Skip non-resident records. */
@@ -237,7 +238,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	 */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
-		return NULL;
+		goto out;
 	}
 
 	if (attr->type == ATTR_END) {
@@ -248,41 +249,41 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
 	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
-		return NULL;
+		goto out;
 
 	/* attributes in record must be ordered by type */
 	if (t32 < prev_type)
-		return NULL;
+		goto out;
 
 	asize = le32_to_cpu(attr->size);
 
 	if (!IS_ALIGNED(asize, 8))
-		return NULL;
+		goto out;
 
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
-		return NULL;
+		goto out;
 
 	/* Can we use the field attr->non_res. */
 	if (off + 9 > used)
-		return NULL;
+		goto out;
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
 		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
-			return NULL;
+			goto out;
 
 		t16 = le16_to_cpu(attr->res.data_off);
 		if (t16 > asize)
-			return NULL;
+			goto out;
 
 		if (le32_to_cpu(attr->res.data_size) > asize - t16)
-			return NULL;
+			goto out;
 
 		if (attr->name_len &&
 		    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len > t16) {
-			return NULL;
+			goto out;
 		}
 
 		return attr;
@@ -290,71 +291,76 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check nonresident fields. */
 	if (attr->non_res != 1)
-		return NULL;
+		goto out;
 
 	/* Can we use memory including attr->nres.valid_size? */
 	if (asize < SIZEOF_NONRESIDENT)
-		return NULL;
+		goto out;
 
 	t16 = le16_to_cpu(attr->nres.run_off);
 	if (t16 > asize)
-		return NULL;
+		goto out;
 
 	t32 = sizeof(short) * attr->name_len;
 	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
-		return NULL;
+		goto out;
 
 	/* Check start/end vcn. */
 	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
-		return NULL;
+		goto out;
 
 	data_size = le64_to_cpu(attr->nres.data_size);
 	if (le64_to_cpu(attr->nres.valid_size) > data_size)
-		return NULL;
+		goto out;
 
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (data_size > alloc_size)
-		return NULL;
+		goto out;
 
 	t32 = mi->sbi->cluster_mask;
 	if (alloc_size & t32)
-		return NULL;
+		goto out;
 
 	if (!attr->nres.svcn && is_attr_ext(attr)) {
 		/* First segment of sparse/compressed attribute */
 		/* Can we use memory including attr->nres.total_size? */
 		if (asize < SIZEOF_NONRESIDENT_EX)
-			return NULL;
+			goto out;
 
 		tot_size = le64_to_cpu(attr->nres.total_size);
 		if (tot_size & t32)
-			return NULL;
+			goto out;
 
 		if (tot_size > alloc_size)
-			return NULL;
+			goto out;
 	} else {
 		if (attr->nres.c_unit)
-			return NULL;
+			goto out;
 
 		if (alloc_size > mi->sbi->volume.size)
-			return NULL;
+			goto out;
 	}
 
 	return attr;
+
+out:
+	_ntfs_bad_inode(&ni->vfs_inode);
+	return NULL;
 }
 
 /*
  * mi_find_attr - Find the attribute by type and name and id.
  */
-struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
-			    enum ATTR_TYPE type, const __le16 *name,
-			    size_t name_len, const __le16 *id)
+struct ATTRIB *mi_find_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr, enum ATTR_TYPE type,
+			    const __le16 *name, size_t name_len,
+			    const __le16 *id)
 {
 	u32 type_in = le32_to_cpu(type);
 	u32 atype;
 
 next_attr:
-	attr = mi_enum_attr(mi, attr);
+	attr = mi_enum_attr(ni, mi, attr);
 	if (!attr)
 		return NULL;
 
@@ -460,9 +466,9 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
  *
  * Return: Not full constructed attribute or NULL if not possible to create.
  */
-struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
-			      const __le16 *name, u8 name_len, u32 asize,
-			      u16 name_off)
+struct ATTRIB *mi_insert_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			      enum ATTR_TYPE type, const __le16 *name,
+			      u8 name_len, u32 asize, u16 name_off)
 {
 	size_t tail;
 	struct ATTRIB *attr;
@@ -482,7 +488,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 	 * at which we should insert it.
 	 */
 	attr = NULL;
-	while ((attr = mi_enum_attr(mi, attr))) {
+	while ((attr = mi_enum_attr(ni, mi, attr))) {
 		diff = compare_attr(attr, type, name, name_len, upcase);
 
 		if (diff < 0)
@@ -500,7 +506,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 		tail = used - PtrOffset(rec, attr);
 	}
 
-	id = mi_new_attt_id(mi);
+	id = mi_new_attt_id(ni, mi);
 
 	memmove(Add2Ptr(attr, asize), attr, tail);
 	memset(attr, 0, asize);
-- 
2.53.0

