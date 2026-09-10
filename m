Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC246D2BA
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038519; cv=none; b=eHZm7vdpxoiEJWikwVFwTp/YorW6N3G8aOqOKp+U8W+9k2Ugpo3bMoHaZo3cNNsFrvh4liauzZSYtmvGM7wzfe68yDvJMf8rTD6irwNT1EqEAfJSrn16qMaZJcP+oUUF5pyIHmJnVKQr1UfscM041YtLtr1HNQMSPNNsza8kDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038519; c=relaxed/simple;
	bh=tUWhJxcRRj0nf2+5uKO9iFywZmWQ4q/7S5sxpzbChVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYYw0yl5UwzPraj4f9BTx9XlUndCWPzHiRZ04ZLyFP/LFOy5WzAvHTrHAEMTjJyuONunGsldMooAfyFV+MxS0y9x82cBro/3/K13c2nYpgDm0Mf9G5o6HKR5WXbOrX3DUyhrQP7RcE2RM4R88+SkhBlWVPexDqZwh7+VzrqR9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyfRRVuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyfRRVuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444181F0089A;
	Thu, 10 Sep 2026 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038517;
	bh=ePDnz4fSqThgbSzkslyEsqBq2Gfflv0xAA1fTwVtCjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyfRRVukVMsr6yGZw0/yaLTgyxIrIGsY03jJrhcd+m9cIA1m3d196UvhPZunMdpxe
	 eUDOP/RowMtQ1ot6CMwsYzO8IW2/w0maYHrWnsZ3EkIJpPTJPC+KgIo8A4Qn4OJL59
	 vtY0+1Pm4voVwx2IlT9rgH5A6Is4CtPxFvavAs6tn63ew6r4oi3w115K3h7TaxvZk3
	 jlg+9DlL0Y6Q39KbCZ9/uM2i7s5IIz71XBhUz4Zxj4SLtsej6y3wKt7bIZhdVITQnu
	 vRytohQlfz8DFqfk2DKIqtczDEmhz+wb9X91tM91HTix8/oM72XOzsyTCdpK28juJF
	 kb7CWox/pVYTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lei lu <llfamsec@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/7] ntfs3: Add bounds checking to mi_enum_attr()
Date: Thu, 10 Sep 2026 07:08:30 -0400
Message-ID: <20260910110835.4144700-2-sashal@kernel.org>
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

From: lei lu <llfamsec@gmail.com>

[ Upstream commit 556bdf27c2dd5c74a9caacbe524b943a6cd42d99 ]

Added bounds checking to make sure that every attr don't stray beyond
valid memory region.

Signed-off-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Stable dependency adaptation for 7c4841e2a627:

The stable tree does not have the old advance-time overflow check removed
by upstream. Remove only the guards present here, and retain the upstream
ordering that validates the header before reading attr->size and rejects
attributes smaller than SIZEOF_RESIDENT before inspecting further fields.

Prepare ni_create_attr_list() for the unchanged target patch by using
kzalloc() and returning -ENOMEM directly on allocation failure. Extend the
existing mi_enum_attr() declaration, definition and callers to its newer
three-argument interface. The inode argument is intentionally unused here
to retain stable's existing corruption handling; callers without an inode
pass NULL. No functions are added. The target still supplies the exact
attribute-list sizing fix.

Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 22 ++++++++++------------
 fs/ntfs3/ntfs_fs.h |  3 ++-
 fs/ntfs3/record.c  | 28 +++++++++++++++-------------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 62874e7f8d8f1..c0fd457069210 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -257,7 +257,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		if (mi)
 			*mi = &ni->mi;
 		/* Enum attributes in primary record. */
-		return mi_enum_attr(&ni->mi, attr);
+		return mi_enum_attr(ni, &ni->mi, attr);
 	}
 
 	/* Get next list entry. */
@@ -791,11 +791,9 @@ int ni_create_attr_list(struct ntfs_inode *ni)
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
@@ -805,7 +803,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	free_b = 0;
 	attr = NULL;
 
-	for (; (attr = mi_enum_attr(&ni->mi, attr)); le = Add2Ptr(le, sz)) {
+	for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
 		sz = le_size(attr->name_len);
 		le->type = attr->type;
 		le->size = cpu_to_le16(sz);
@@ -970,7 +968,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		mi = rb_entry(node, struct mft_inode, node);
 
 		if (is_mft_data &&
-		    (mi_enum_attr(mi, NULL) ||
+		    (mi_enum_attr(ni, mi, NULL) ||
 		     vbo <= ((u64)mi->rno << sbi->record_bits))) {
 			/* We can't accept this record 'cause MFT's bootstrapping. */
 			continue;
@@ -1134,7 +1132,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	/* Estimate the result of moving all possible attributes away. */
 	attr = NULL;
 
-	while ((attr = mi_enum_attr(&ni->mi, attr))) {
+	while ((attr = mi_enum_attr(ni, &ni->mi, attr))) {
 		if (attr->type == ATTR_STD)
 			continue;
 		if (attr->type == ATTR_LIST)
@@ -1152,7 +1150,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	attr = NULL;
 
 	for (;;) {
-		attr = mi_enum_attr(&ni->mi, attr);
+		attr = mi_enum_attr(ni, &ni->mi, attr);
 		if (!attr) {
 			/* We should never be here 'cause we have already check this case. */
 			err = -EINVAL;
@@ -1236,7 +1234,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
 		mi = rb_entry(node, struct mft_inode, node);
 
-		attr = mi_enum_attr(mi, NULL);
+		attr = mi_enum_attr(ni, mi, NULL);
 
 		if (!attr) {
 			mft_min = mi->rno;
@@ -3307,7 +3305,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		if (!mi->dirty)
 			continue;
 
-		is_empty = !mi_enum_attr(mi, NULL);
+		is_empty = !mi_enum_attr(ni, mi, NULL);
 
 		if (is_empty)
 			clear_rec_inuse(mi->mrec);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a03dce278221e..ce7f349c2bd20 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -726,7 +726,8 @@ int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi);
 void mi_put(struct mft_inode *mi);
 int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno);
 int mi_read(struct mft_inode *mi, bool is_mft);
-struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr);
+struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr);
 // TODO: id?
 struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
 			    enum ATTR_TYPE type, const __le16 *name,
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index a1be5af740d34..dbf1d520e21e6 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -52,7 +52,7 @@ static __le16 mi_new_attt_id(struct mft_inode *mi)
 	attr = NULL;
 
 	for (;;) {
-		attr = mi_enum_attr(mi, attr);
+		attr = mi_enum_attr(NULL, mi, attr);
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
@@ -217,24 +218,19 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
-		/* Check if input attr inside record. */
+		/*
+		 * We don't need to check previous attr here. There is
+		 * a bounds checking in the previous round.
+		 */
 		off = PtrOffset(rec, attr);
-		if (off >= used)
-			return NULL;
 
 		asize = le32_to_cpu(attr->size);
-		if (asize < SIZEOF_RESIDENT) {
-			/* Impossible 'cause we should not return such attribute. */
-			return NULL;
-		}
 
 		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
 
-	asize = le32_to_cpu(attr->size);
-
 	/* Can we use the first field (attr->type). */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
@@ -255,6 +251,12 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if (t32 < prev_type)
 		return NULL;
 
+	asize = le32_to_cpu(attr->size);
+	if (asize < SIZEOF_RESIDENT) {
+		/* Impossible 'cause we should not return such attribute. */
+		return NULL;
+	}
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;
@@ -341,7 +343,7 @@ struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
 	u32 atype;
 
 next_attr:
-	attr = mi_enum_attr(mi, attr);
+	attr = mi_enum_attr(NULL, mi, attr);
 	if (!attr)
 		return NULL;
 
@@ -469,7 +471,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 	 * at which we should insert it.
 	 */
 	attr = NULL;
-	while ((attr = mi_enum_attr(mi, attr))) {
+	while ((attr = mi_enum_attr(NULL, mi, attr))) {
 		diff = compare_attr(attr, type, name, name_len, upcase);
 		if (diff > 0)
 			break;
-- 
2.53.0

