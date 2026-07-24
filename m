Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D65421230
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890145; cv=none; b=Kgln5iY4C9DiWjgd0F8m4ZTC7wukdRwlt7FVwfzhD6pLa3fsX1guKrS+8qtRCoNNU7xWop7Jvy4W2wbGETvtxlsk3Z2y7YcEmO5Z2hvFztOS6jOYnxWV9+8QQO78jZy6kM96pPB0mvW5Eccg5NW/GYbLh8mdqi+T4vZgpbZncB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890145; c=relaxed/simple;
	bh=I0OwDOb//At1CBFLgxJFO1bBErAHA1tIDr/EHFqqGzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etloY3fF1QdjKzJjUdxSNnyyym2CkG7grio9k27QErZ94Y7P7LHL1MQQlfo0+2ciEhHaBYeFkxKhmMKllLc5rZWsvtEHogC/1Cb9FG+0rP0/xgl1ywS10GZ34zyN7odNIreslunJB29NAEqNRFFZdt6nX9V3SKWP1EX3wucK+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1M22Iwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1M22Iwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9072C1F00A3D;
	Fri, 24 Jul 2026 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890144;
	bh=nZPtwXVhC1cXCU/wn+dmhAzRpe9sujAHOiSNjE8gfQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O1M22IwgxXfdBO5cPgbt4wwYoe/JYOKb0yvZL3xW/HfKnSyqz4SmCu19tTBhUTT8U
	 TI1V9irZ23DP1VkZx4kfX5b6wCB2x8kelyS/aXTx1YMvUd7AJmpZ2LJzEG0Dq0PbLi
	 pSlIlCLBb58aHOtGPG4svCCFkbUJ4IweW/WWnE9pDMK1rbGjPVWuWUKH1UWcQWJv0q
	 Ru3iH3yJLySCreKvBmuvIPd/B4U1OMmira7mauNhopz+HfiGkNvpJk79RoG7MUeAhB
	 xiu4qY1TTBbkm19YrCHpC9Ebv0OKv1cfL0V3IR26j5WNgFjqH9si4D3mqJv1ELyj+n
	 ewQC9qChoDJ0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] fs/ntfs3: extend ni_insert_nonresident to return inserted ATTR_LIST_ENTRY
Date: Fri, 24 Jul 2026 06:48:58 -0400
Message-ID: <20260724104900.3973962-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724104900.3973962-1-sashal@kernel.org>
References: <2026072042-litter-retold-6915@gregkh>
 <20260724104900.3973962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c1e0ab3789215a3dfbe95f226955e93ea4803391 ]

Fixes xfstest generic/300
Fixes: 4534a70b7056 ("fs/ntfs3: Add headers and misc files")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 5e7b598660cf ("fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c  | 33 ++++++++++++++++++++-------------
 fs/ntfs3/frecord.c |  4 ++--
 fs/ntfs3/fslog.c   | 25 +++++++++++++++++++------
 fs/ntfs3/index.c   |  2 +-
 fs/ntfs3/ntfs_fs.h |  5 +++--
 fs/ntfs3/run.c     |  9 +++++++--
 6 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 872586e9598a77..ca496499db71cb 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -327,7 +327,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 
 	err = ni_insert_nonresident(ni, attr_s->type, attr_name(attr_s),
 				    attr_s->name_len, run, 0, alen,
-				    attr_s->flags, &attr, NULL);
+				    attr_s->flags, &attr, NULL, NULL);
 	if (err)
 		goto out3;
 
@@ -644,7 +644,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		/* Insert new attribute segment. */
 		err = ni_insert_nonresident(ni, type, name, name_len, run,
 					    next_svcn, vcn - next_svcn,
-					    attr_b->flags, &attr, &mi);
+					    attr_b->flags, &attr, &mi, NULL);
 		if (err)
 			goto out;
 
@@ -862,7 +862,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		goto out;
 	}
 
-	asize = le64_to_cpu(attr_b->nres.alloc_size) >> sbi->cluster_bits;
+	asize = le64_to_cpu(attr_b->nres.alloc_size) >> cluster_bits;
 	if (vcn >= asize) {
 		err = -EINVAL;
 		goto out;
@@ -1054,7 +1054,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	if (evcn1 > next_svcn) {
 		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
 					    next_svcn, evcn1 - next_svcn,
-					    attr_b->flags, &attr, &mi);
+					    attr_b->flags, &attr, &mi, NULL);
 		if (err)
 			goto out;
 	}
@@ -1673,7 +1673,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	if (evcn1 > next_svcn) {
 		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
 					    next_svcn, evcn1 - next_svcn,
-					    attr_b->flags, &attr, &mi);
+					    attr_b->flags, &attr, &mi, NULL);
 		if (err)
 			goto out;
 	}
@@ -1840,18 +1840,12 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				err = ni_insert_nonresident(
 					ni, ATTR_DATA, NULL, 0, run, next_svcn,
 					evcn1 - eat - next_svcn, a_flags, &attr,
-					&mi);
+					&mi, &le);
 				if (err)
 					goto out;
 
 				/* Layout of records maybe changed. */
 				attr_b = NULL;
-				le = al_find_ex(ni, NULL, ATTR_DATA, NULL, 0,
-						&next_svcn);
-				if (!le) {
-					err = -EINVAL;
-					goto out;
-				}
 			}
 
 			/* Free all allocated memory. */
@@ -1969,9 +1963,10 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, vcn, len, end, alen, dealloc;
+	CLST svcn, evcn1, vcn, len, end, alen, dealloc, next_svcn;
 	u64 total_size, alloc_size;
 	u32 mask;
+	__le16 a_flags;
 
 	if (!bytes)
 		return 0;
@@ -2034,6 +2029,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 
 	svcn = le64_to_cpu(attr_b->nres.svcn);
 	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
+	a_flags = attr_b->flags;
 
 	if (svcn <= vcn && vcn < evcn1) {
 		attr = attr_b;
@@ -2081,6 +2077,17 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 			err = mi_pack_runs(mi, attr, run, evcn1 - svcn);
 			if (err)
 				goto out;
+			next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+			if (next_svcn < evcn1) {
+				err = ni_insert_nonresident(ni, ATTR_DATA, NULL,
+							    0, run, next_svcn,
+							    evcn1 - next_svcn,
+							    a_flags, &attr, &mi,
+							    &le);
+				if (err)
+					goto out;
+				/* Layout of records maybe changed. */
+			}
 		}
 		/* Free all allocated memory. */
 		run_truncate(run, 0);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 62874e7f8d8f17..81fc99f20c1169 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1420,7 +1420,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			  const __le16 *name, u8 name_len,
 			  const struct runs_tree *run, CLST svcn, CLST len,
 			  __le16 flags, struct ATTRIB **new_attr,
-			  struct mft_inode **mi)
+			  struct mft_inode **mi, struct ATTR_LIST_ENTRY **le)
 {
 	int err;
 	CLST plen;
@@ -1453,7 +1453,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	}
 
 	err = ni_insert_attr(ni, type, name, name_len, asize, name_off, svcn,
-			     &attr, mi, NULL);
+			     &attr, mi, le);
 
 	if (err)
 		goto out;
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 9b12d5a7ac8d5e..09048409fe981d 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3367,7 +3367,10 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		memmove(Add2Ptr(attr, aoff), data, dlen);
 
 		if (run_get_highest_vcn(le64_to_cpu(attr->nres.svcn),
-					attr_run(attr), &t64)) {
+					attr_run(attr),
+				        le32_to_cpu(attr->size) - 
+				                le16_to_cpu(attr->nres.run_off),	
+					&t64)) {
 			goto dirty_vol;
 		}
 
@@ -4544,11 +4547,21 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		 * whole routine a loop, case Lcns do not fit below.
 		 */
 		t16 = le16_to_cpu(lrh->lcns_follow);
-		for (i = 0; i < t16; i++) {
-			size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
-					    le64_to_cpu(dp->vcn));
-			dp->page_lcns[j + i] = lrh->page_lcns[i];
-		}
+                t32 = le32_to_cpu(dp->lcns_follow);
+                if (le64_to_cpu(lrh->target_vcn) < le64_to_cpu(dp->vcn)) {
+                        err = -EINVAL;
+                        goto out;
+                }
+
+                for (i = 0; i < t16; i++) {
+                        size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
+                                            le64_to_cpu(dp->vcn));
+                        if (j >= t32 || i >= t32 - j) {
+                                err = -EINVAL;
+                                goto out;
+                        }
+                        dp->page_lcns[j + i] = lrh->page_lcns[i];
+                }
 
 		goto next_log_record_analyze;
 
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index b0aa5cc63b5079..9f2a1d41dfb5a0 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1460,7 +1460,7 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out;
 
 	err = ni_insert_nonresident(ni, ATTR_ALLOC, in->name, in->name_len,
-				    &run, 0, len, 0, &alloc, NULL);
+				    &run, 0, len, 0, &alloc, NULL, NULL);
 	if (err)
 		goto out1;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a03dce278221e8..85abc99a1e3bda 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -533,7 +533,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			  const __le16 *name, u8 name_len,
 			  const struct runs_tree *run, CLST svcn, CLST len,
 			  __le16 flags, struct ATTRIB **new_attr,
-			  struct mft_inode **mi);
+			  struct mft_inode **mi, struct ATTR_LIST_ENTRY **le);
 int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
 		       enum ATTR_TYPE type, const __le16 *name, u8 name_len,
 		       struct ATTRIB **new_attr, struct mft_inode **mi,
@@ -802,7 +802,8 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 #else
 #define run_unpack_ex run_unpack
 #endif
-int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn);
+int run_get_highest_vcn(CLST vcn, const u8 *run_buf, size_t run_buf_size, 
+		       u64 *highest_vcn);
 
 /* Globals from super.c */
 void *ntfs_set_shared(void *ptr, u32 bytes);
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 10b1a2b08723b3..672115481fb07e 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1105,18 +1105,23 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
  * Return the highest vcn from a mapping pairs array
  * it used while replaying log file.
  */
-int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
+int run_get_highest_vcn(CLST vcn, const u8 *run_buf, size_t run_buf_size, 
+		       u64 *highest_vcn)
 {
+	const u8 *run_last = run_buf + run_buf_size;
 	u64 vcn64 = vcn;
 	u8 size_size;
 
-	while ((size_size = *run_buf & 0xF)) {
+	while (run_buf < run_last && (size_size = *run_buf & 0xF)) {
 		u8 offset_size = *run_buf++ >> 4;
 		u64 len;
 
 		if (size_size > 8 || offset_size > 8)
 			return -EINVAL;
 
+		if (run_buf + size_size + offset_size > run_last) 
+			return -EINVAL;
+
 		len = run_unpack_s64(run_buf, size_size, 0);
 		if (!len)
 			return -EINVAL;
-- 
2.53.0

