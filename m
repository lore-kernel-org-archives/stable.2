Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E1470E91
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038522; cv=none; b=YNHM194jZUv+yvAdrAKVtATL0uJaK/feEo5Bgi+pyxZG2U1tV35AZpRsDNZjxpLpI1czsp9YlW2CcDDU1LmgvgSnTDMATXpu/FNvgHX39nSbz+xTym+1JPMkGxd2iT14BAujzeuvnun1gafQfyykD0g2phKzOE6CHItsVqHUB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038522; c=relaxed/simple;
	bh=gfw2DJ2q8GIBC4zv24hoNqVpwsLKs9xbXSkyO0qBfT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C65uDqSOfw4yRhz3JOyPeVMYL9RLX3NyMuyC2OUmkN+Ww+HA68Tt+JKFY6qGPSYvLdG7peDu7LWycr6HNsrT8YxquzOuI7YIn8TDrNKDyWwpbKG+2TqOvXIoFEJ+C1n4kp27h/C5UCayZ4b7bycVVDCK1pqhcQnHd1Aa4h6g1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYhCbjqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYhCbjqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376401F000FF;
	Thu, 10 Sep 2026 11:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038520;
	bh=OwY3wepxYmdJCVh0Ca0cRytkWEj1Rtjg0tEGj1Ctb5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYhCbjqh4d9zkeI/8205Y4AFMgRrGqQo6Qgn7KSVZM3/foCCqM9VZ5A3Zfu0lnavw
	 te0wUgxgbNtyXD3llqTulCEa05pp5kdHyk7WhymMqFvAr2gsi8xFzJwf0BoODFYc/I
	 pUW1IdChETMjmkA1GB94p/IV3BEIxkuQ5c6w5rj/WnowRGR2nTUPdpa02QSGH1opw3
	 7RXPkkHggBvpCJ69YottVD7Cm2xQICLfMPgJm8OeakbMsNxutqmjDByxJr3NdQ2dun
	 MSIL81FiZEywzfmLtHGVLQLeuuj3xI1Z28AQ7S7ZE3iLB9eD8J1nHozbr9yNWFqF+7
	 qXIeuykuEeMqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/7] fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
Date: Thu, 10 Sep 2026 07:08:34 -0400
Message-ID: <20260910110835.4144700-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110835.4144700-1-sashal@kernel.org>
References: <2026090804-parakeet-recolor-7d74@gregkh>
 <20260910110835.4144700-1-sashal@kernel.org>
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

Stable dependency adaptation for 7c4841e2a627:

An earlier dependency already added the three-argument mi_enum_attr()
interface. Complete the inode propagation through the existing lookup,
insertion and attribute-id helpers, and mark the inode bad on validation
failures. Preserve normal end-of-enumeration and unused-record returns.

Keep stable's size_t lookup name length, attribute segment control flow,
combined attribute move/remove loop and insertion ordering. The upstream
call-site hunk in the separate subrecord-removal loop has no counterpart
here and is omitted.

This tree lacks _ntfs_bad_inode(). Use the existing ntfs_inode_err() and
make_bad_inode() calls directly, without adding any functions. Do not copy
the helper's ntfs_set_state() call: stable's volume-state path performs
attribute lookup while holding the volume inode lock, so reporting an
invalid volume attribute that way can recursively acquire that lock.

Keep ni_create_attr_list()'s existing allocation and enumeration context
so the unchanged target patch applies and supplies the exact sizing fix.

Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c  |  8 ++---
 fs/ntfs3/frecord.c | 40 ++++++++++++------------
 fs/ntfs3/ntfs_fs.h | 19 +++++------
 fs/ntfs3/record.c  | 78 +++++++++++++++++++++++++---------------------
 4 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 872586e9598a7..4d5b25322f200 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -761,7 +761,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		if (err)
 			goto out;
 
-		attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len, &le->id);
 		if (!attr) {
 			err = -EINVAL;
 			goto out;
@@ -1021,7 +1021,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 				goto out;
 			}
 
-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0,
 					    &le->id);
 			if (!attr) {
 				err = -EINVAL;
@@ -1640,7 +1640,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 				goto out;
 			}
 
-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0,
 					    &le->id);
 			if (!attr) {
 				err = -EINVAL;
@@ -1891,7 +1891,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				}
 
 				/* Look for required attribute. */
-				attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL,
+				attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL,
 						    0, &le->id);
 				if (!attr) {
 					err = -EINVAL;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c0fd457069210..d21d003775b62 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -74,7 +74,7 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO))
 		    : NULL;
 }
@@ -88,7 +88,7 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5))
 		    : NULL;
@@ -200,7 +200,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 			*mi = &ni->mi;
 
 		/* Look for required attribute in primary record. */
-		return mi_find_attr(&ni->mi, attr, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, attr, type, name, name_len, NULL);
 	}
 
 	/* First look for list entry of required type. */
@@ -216,7 +216,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 		return NULL;
 
 	/* Look for required attribute. */
-	attr = mi_find_attr(m, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, m, NULL, type, name, name_len, &le->id);
 
 	if (!attr)
 		goto out;
@@ -273,7 +273,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		*mi = mi2;
 
 	/* Find attribute in loaded record. */
-	return rec_find_attr_le(mi2, le2);
+	return rec_find_attr_le(ni, mi2, le2);
 }
 
 /*
@@ -291,7 +291,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (!ni->attr_list.size) {
 		if (pmi)
 			*pmi = &ni->mi;
-		return mi_find_attr(&ni->mi, NULL, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, NULL, type, name, name_len, NULL);
 	}
 
 	le = al_find_ex(ni, NULL, type, name, name_len, NULL);
@@ -317,7 +317,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (pmi)
 		*pmi = mi;
 
-	attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, mi, NULL, type, name, name_len, &le->id);
 	if (!attr)
 		return NULL;
 
@@ -398,7 +398,7 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	int diff;
 
 	if (base_only || type == ATTR_LIST || !ni->attr_list.size) {
-		attr = mi_find_attr(&ni->mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, &ni->mi, NULL, type, name, name_len, id);
 		if (!attr)
 			return -ENOENT;
 
@@ -437,7 +437,7 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 
 		al_remove_le(ni, le);
 
-		attr = mi_find_attr(mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len, id);
 		if (!attr)
 			return -ENOENT;
 
@@ -485,7 +485,7 @@ ni_ins_new_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		name = le->name;
 	}
 
-	attr = mi_insert_attr(mi, type, name, name_len, asize, name_off);
+	attr = mi_insert_attr(ni, mi, type, name, name_len, asize, name_off);
 	if (!attr) {
 		if (le_added)
 			al_remove_le(ni, le);
@@ -668,7 +668,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 	if (err)
 		return err;
 
-	attr_list = mi_find_attr(&ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
+	attr_list = mi_find_attr(ni, &ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
 	if (!attr_list)
 		return 0;
 
@@ -690,7 +690,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		if (!mi)
 			return 0;
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr)
 			return 0;
@@ -720,7 +720,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 			goto bad;
 		}
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr) {
 			/* Should never happened, 'cause already checked. */
@@ -729,7 +729,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);
 
 		/* Insert into primary record. */
-		attr_ins = mi_insert_attr(&ni->mi, le->type, le_name(le),
+		attr_ins = mi_insert_attr(ni, &ni->mi, le->type, le_name(le),
 					  le->name_len, asize,
 					  le16_to_cpu(attr->name_off));
 		if (!attr_ins) {
@@ -858,7 +858,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 		u32 asize = le32_to_cpu(b->size);
 		u16 name_off = le16_to_cpu(b->name_off);
 
-		attr = mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
+		attr = mi_insert_attr(ni, mi, b->type, Add2Ptr(b, name_off),
 				      b->name_len, asize, name_off);
 		if (!attr)
 			goto out1;
@@ -881,7 +881,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 			goto out1;
 	}
 
-	attr = mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
+	attr = mi_insert_attr(ni, &ni->mi, ATTR_LIST, NULL, 0,
 			      lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
 	if (!attr)
 		goto out1;
@@ -974,7 +974,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 			continue;
 		}
 		if (is_mft &&
-		    mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
+		    mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
 			/*
 			 * This child record already has a ATTR_DATA.
 			 * So it can't accept any other records.
@@ -983,7 +983,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		}
 
 		if ((type != ATTR_NAME || name_len) &&
-		    mi_find_attr(mi, NULL, type, name, name_len, NULL)) {
+		    mi_find_attr(ni, mi, NULL, type, name, name_len, NULL)) {
 			/* Only indexed attributes can share same record. */
 			continue;
 		}
@@ -1255,7 +1255,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 		ni_remove_mi(ni, mi_new);
 	}
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
 	if (!attr) {
 		err = -EINVAL;
 		goto out;
@@ -1371,7 +1371,7 @@ int ni_expand_list(struct ntfs_inode *ni)
 			continue;
 
 		/* Find attribute in primary record. */
-		attr = rec_find_attr_le(&ni->mi, le);
+		attr = rec_find_attr_le(ni, &ni->mi, le);
 		if (!attr) {
 			err = -EINVAL;
 			goto out;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index ce7f349c2bd20..35d7b3c51f2b0 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -728,22 +728,23 @@ int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno);
 int mi_read(struct mft_inode *mi, bool is_mft);
 struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 			    struct ATTRIB *attr);
-// TODO: id?
-struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
-			    enum ATTR_TYPE type, const __le16 *name,
-			    size_t name_len, const __le16 *id);
-static inline struct ATTRIB *rec_find_attr_le(struct mft_inode *rec,
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
index 76b12444633c5..50dadd776667f 100644
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
-		attr = mi_enum_attr(NULL, mi, attr);
+		attr = mi_enum_attr(ni, mi, attr);
 		if (!attr) {
 			rec->next_attr_id = cpu_to_le16(max_id + 1);
 			mi->dirty = true;
@@ -204,11 +204,11 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
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
@@ -238,7 +238,7 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 	 */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
-		return NULL;
+		goto out;
 	}
 
 	if (attr->type == ATTR_END) {
@@ -249,41 +249,41 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
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
@@ -291,71 +291,77 @@ struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 
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
+	ntfs_inode_err(&ni->vfs_inode, "%s", __func__);
+	make_bad_inode(&ni->vfs_inode);
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
-	attr = mi_enum_attr(NULL, mi, attr);
+	attr = mi_enum_attr(ni, mi, attr);
 	if (!attr)
 		return NULL;
 
@@ -461,9 +467,9 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
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
@@ -483,7 +489,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 	 * at which we should insert it.
 	 */
 	attr = NULL;
-	while ((attr = mi_enum_attr(NULL, mi, attr))) {
+	while ((attr = mi_enum_attr(ni, mi, attr))) {
 		diff = compare_attr(attr, type, name, name_len, upcase);
 		if (diff > 0)
 			break;
@@ -502,7 +508,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 		tail = used - PtrOffset(rec, attr);
 	}
 
-	id = mi_new_attt_id(mi);
+	id = mi_new_attt_id(ni, mi);
 
 	memmove(Add2Ptr(attr, asize), attr, tail);
 	memset(attr, 0, asize);
-- 
2.53.0

