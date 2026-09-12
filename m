Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1723368B6
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176749; cv=none; b=hE46Jzts8LuOwsUmmGkR/UUb636yRZUtgnVoNilxr86qFfF7zjCxzOrnN0fWaZ5MVUL0Cq6dvNTc8yoGhz5BWZo3x+xLwbTbstyiuZEGCF50hqucrDdoBJPl2R9KG0lsro7f//MFLAqVBupu0IYOyTPmcEEUNoS7zVMRBmHsqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176749; c=relaxed/simple;
	bh=RZMSWGWEBKNnn46i1GYcq2tnIxUyUsj7NhUC978Ehnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFCRYbUBh6sSFmGX4UnLKi4WddxHlgkhOBRLNWKoqwhzrOBjl4cwLnFLzb6x2GaSNqofhrfViVhilZjs9bFDD72rMbPEQZvLIYX0O3PqlSUHK1eacbeiq0rYjVK/AO+Qbo0XEvjQJf1pfqLCR070JhmL/JSXQvLOOqyxhAC2XC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzm3I5M3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzm3I5M3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EC61F00898;
	Sat, 12 Sep 2026 01:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176748;
	bh=Ctf3cZATpGYhSnrfc9HsrP2t7l4EVree7UBBqjrfiKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzm3I5M3csWpCVK6c+ZHT8qnaKy+Q5pzMg2m4BPXm2UoIcvFT8TOkmZE5wp23aRfO
	 v1CBpB1JCyFlUnpi3aekuOEga5aPXd9K9mgaJqlSgij6Q9jgZpFqKhdjRsbqfexITr
	 SdZfsFKtVAb44I7LNAvCRONFwlIIfVOD5VFws/pVNxyiizu9DG8CxpqIyed3pqiQ7N
	 mx1IyNqVVdMQOXfWqY9vP6Y/xTlHFdJ5KHNqjbjLR9IgOAtB8x0cMQ5/HG+q4AFnTv
	 Yge6Ey/i+snUXREbTs5diSvQ1MXc4OITLUDaT6j0kDfd9b24P+XZ1/fh9hKGLQTDdf
	 cyrdEsNSCzV9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/7] f2fs: introduce is_{meta,node}_folio
Date: Fri, 11 Sep 2026 21:32:21 -0400
Message-ID: <20260912013222.1762882-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013222.1762882-1-sashal@kernel.org>
References: <2026090957-stoke-condense-f9b1@gregkh>
 <20260912013222.1762882-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 019a8912425e231511042a4eae48b7a9e459453c ]

Just cleanup, no changes.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Adapt this dependency to the page-based 6.12 tree:

- Use single-evaluation macros for the folio mapping predicates, with a
  NULL mapping check so that a truncated folio is rejected safely. Keep
  the existing page interfaces and pass page_folio() at their call sites.
- Supply folio allocation, release and writeback adapters using the
  existing page helpers. Earlier dependencies already use these missing
  interfaces. Preserve allocation failures as ERR_PTR(-ENOMEM).
- Repair the existing f2fs_get_node_folio() wrapper to use __get_node_page()
  and preserve error pointers; __get_node_folio() and NODE_TYPE_REGULAR
  are not present in this stable tree.
- Use a local last_folio in the fsync retry block, matching the context
  needed for ce366bfa821ec81dd45bde547ee31e659306cc61 to apply unchanged.

No new functions are introduced. The target's retry escape remains in
its own patch.

Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       |  2 +-
 fs/f2fs/f2fs.h       | 26 ++++++++++++++++++++++++++
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/node.c       | 32 +++++++++++++++++++-------------
 5 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6322bf2e16228..03f2623a822fe 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -93,7 +93,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE);
 
 	lock_page(page);
-	if (unlikely(page->mapping != mapping)) {
+	if (unlikely(!is_meta_folio(page_folio(page)))) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
@@ -453,7 +453,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 
 			folio_lock(folio);
 
-			if (unlikely(folio->mapping != mapping)) {
+			if (unlikely(!is_meta_folio(folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ec816df4887cc..a57dd4dc5fd2b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -353,7 +353,7 @@ static void f2fs_write_end_io(struct bio *bio)
 						STOP_CP_REASON_WRITE_FAIL);
 		}
 
-		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
+		f2fs_bug_on(sbi, is_node_folio(page_folio(page)) &&
 				page_folio(page)->index != nid_of_node(page));
 		if (f2fs_in_warm_node_list(sbi, page))
 			f2fs_del_fsync_node_entry(sbi, page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 67c5b9cb90ee6..a055673524f3c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2100,6 +2100,17 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->node_inode->i_mapping;
 }
 
+/* The caller holds the folio lock or otherwise stabilizes its mapping. */
+#define is_meta_folio(folio) ({						\
+	struct address_space *__mapping = (folio)->mapping;		\
+	__mapping && __mapping == META_MAPPING(F2FS_M_SB(__mapping));	\
+})
+
+#define is_node_folio(folio) ({						\
+	struct address_space *__mapping = (folio)->mapping;		\
+	__mapping && __mapping == NODE_MAPPING(F2FS_M_SB(__mapping));	\
+})
+
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	return test_bit(type, &sbi->s_flag);
@@ -2868,6 +2879,13 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 	return page;
 }
 
+/* Folio adapters for the page-based stable-tree helpers. */
+#define f2fs_grab_cache_folio(mapping, index, for_write) ({		\
+	struct page *__page = f2fs_grab_cache_page(mapping, index,		\
+						 for_write);		\
+	__page ? page_folio(__page) : ERR_PTR(-ENOMEM);			\
+})
+
 static inline struct page *f2fs_pagecache_get_page(
 				struct address_space *mapping, pgoff_t index,
 				fgf_t fgp_flags, gfp_t gfp_mask)
@@ -2890,6 +2908,12 @@ static inline void f2fs_put_page(struct page *page, int unlock)
 	put_page(page);
 }
 
+#define f2fs_folio_put(_folio, unlock) do {				\
+	struct folio *__folio = (_folio);					\
+	if (!IS_ERR_OR_NULL(__folio))					\
+		f2fs_put_page(&__folio->page, unlock);			\
+} while (0)
+
 static inline void f2fs_put_dnode(struct dnode_of_data *dn)
 {
 	if (dn->node_page)
@@ -3839,6 +3863,8 @@ void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
 					block_t blkaddr, unsigned int blkcnt);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered, bool locked);
+#define f2fs_folio_wait_writeback(folio, type, ordered, locked)		\
+	f2fs_wait_on_page_writeback(&(folio)->page, type, ordered, locked)
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fbd246b3e550a..f29d461bdb1ef 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1425,7 +1425,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 							F2FS_BLKSIZE);
 
 		folio_lock(mfolio);
-		if (unlikely(mfolio->mapping != META_MAPPING(fio.sbi) ||
+		if (unlikely(!is_meta_folio(mfolio) ||
 			     !folio_test_uptodate(mfolio))) {
 			err = -EIO;
 			f2fs_folio_put(mfolio, true);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1463488fcd832..ce75669332efc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -317,7 +317,7 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 
 bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct page *page)
 {
-	return NODE_MAPPING(sbi) == page->mapping &&
+	return is_node_folio(page_folio(page)) &&
 			IS_DNODE(page) && is_cold_node(page);
 }
 
@@ -1234,7 +1234,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		if (offset[1] == 0 &&
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
 			lock_page(page);
-			BUG_ON(page->mapping != NODE_MAPPING(sbi));
+			BUG_ON(!is_node_folio(page_folio(page)));
 			f2fs_wait_on_page_writeback(page, NODE, true, true);
 			ri->i_nid[offset[0] - NODE_DIR1_BLOCK] = 0;
 			set_page_dirty(page);
@@ -1500,7 +1500,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 	lock_page(page);
 
-	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+	if (unlikely(!is_node_folio(page_folio(page)))) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
@@ -1537,7 +1537,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)
 {
-	return __get_node_folio(sbi, nid, NULL, 0, NODE_TYPE_REGULAR);
+	struct page *page = __get_node_page(sbi, nid, NULL, 0);
+
+	if (IS_ERR(page))
+		return ERR_CAST(page);
+	return page_folio(page);
 }
 
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
@@ -1620,7 +1624,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 
 			lock_page(page);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(!is_node_folio(page_folio(page)))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
@@ -1854,7 +1858,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			lock_page(page);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(!is_node_folio(page_folio(page)))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
@@ -1916,12 +1920,14 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			break;
 	}
 	if (!ret && atomic && !marked) {
+		struct folio *last_folio = page_folio(last_page);
+
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
-			   ino, page_folio(last_page)->index);
-		lock_page(last_page);
-		f2fs_wait_on_page_writeback(last_page, NODE, true, true);
-		set_page_dirty(last_page);
-		unlock_page(last_page);
+			   ino, last_folio->index);
+		folio_lock(last_folio);
+		f2fs_folio_wait_writeback(last_folio, NODE, true, true);
+		folio_mark_dirty(last_folio);
+		folio_unlock(last_folio);
 		goto retry;
 	}
 out:
@@ -1992,7 +1998,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 
 			lock_page(page);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(!is_node_folio(page_folio(page)))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
@@ -2069,7 +2075,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			else if (!trylock_page(page))
 				continue;
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(!is_node_folio(page_folio(page)))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
-- 
2.53.0

