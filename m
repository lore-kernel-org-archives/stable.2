Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB847884A
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212091; cv=none; b=XvHS2L0TUNLVf+cqpYQz1T7UMOs27IuKVsxhwvzeIZWLEKfSOUiFwZY8Fc45HwEg4fcl7Hx0QgHWpmB021w4A+C2Z30iZvZ1qedlxv1zJOmowlYApUdCwUIjMrbtvXvkdNesh6PcHBILSH1NzCi+XSOzeq1lR7BdBy09C7HpAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212091; c=relaxed/simple;
	bh=MXel9W2TKgOxLpr4L2mWkFoutlYbnlyggUHa3OVNuWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBvG5fE6TXm+5qHobdNqAgBjE9YnpISdfhzLFtZZ9DRUHYVKAQAYwVQWzgtdNBLJIAnG7vGB+UaSWogWvyPZAFi7VewSNWT7xVBJdpfTfzZzYqT31jxFflYmQhkfxYWwoBtB5PxMEh1FkknzQCbcrbYIYqvOaq0bX05SvPIIWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtPyL1Hg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtPyL1Hg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99E61F0089E;
	Sat, 12 Sep 2026 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212090;
	bh=Jr0s5dJwqWDKbo+BFbmhJAdBf3OB/ncXTwoodLuMH1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GtPyL1HglNcop771dLXaiqGk5IJ86CdFC9xpuf39CvOWK9uAJMd8fpsHDtnrr+1du
	 +P/IjK0u7hFKewgEGw+CERn17LdvOo3cVjgpM6NH37HCfqIhpGyviZa12NAHhD3OcZ
	 C8dtroLwGH+jzHpOMTdBnexWA2TgYfLuOxC5LAt5YgnCWftvyrtxQNJu8Ut8UBG/O3
	 hoQrtky4VSnBvX1uk2fjIc/D+C/5Vvn0YzP8C8RFKQHI0JfhAmj6dqAGFFQFCgzmKF
	 n6iOl8nHLgm5Ep7XchSp87UxRAnDgZ9V8xVA1EQOr4RzrGonAbsDtNjlf136tEqMey
	 GbcooFXmpk4iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/6] f2fs: introduce is_{meta,node}_folio
Date: Sat, 12 Sep 2026 07:21:23 -0400
Message-ID: <20260912112124.2312624-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912112124.2312624-1-sashal@kernel.org>
References: <2026090958-headband-sturdy-0f93@gregkh>
 <20260912112124.2312624-1-sashal@kernel.org>
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

Adapt this dependency to the page-based stable tree so that the unchanged
ce366bfa821e fsync retry fix applies cleanly.

Keep the node mapping checks in last_fsync_dnode() and
f2fs_fsync_node_pages(). Implement is_node_folio() as a macro which checks
for a NULL mapping before looking up the superblock. The upstream helper
would dereference a detached folio's NULL mapping in the race that the
target addresses. Drop the unrelated metadata, data I/O, GC and other
node cleanup hunks instead of importing their missing folio conversions.

Use a local last_folio in the fsync retry block and provide macro adapters
for folio put and writeback wait operations using the stable page APIs.
Normalize existing node-write failures to -EIO at their source, then
return ret unchanged so the target's new -EAGAIN result is preserved.
Existing error behavior is unchanged before the target is applied.

Earlier dependencies already converted node allocation and truncation to
folios without supplying all prerequisites. Adapt the existing
f2fs_new_node_folio() and f2fs_get_node_folio() implementations to the
available page allocation and lookup functions, retaining allocation
failure and error-pointer handling. The put/writeback adapters also
resolve the missing APIs in those earlier conversions.

No functions are added by this backport; the adaptation uses macros and
changes existing functions only. Leave the retry mapping guard itself
to the target commit.

[ sashal: Reduced backport -- upstream 019a8912425e2 touches 5 file(s), this
  backport carries 2. Not backported here:
  fs/f2fs/checkpoint.c
  fs/f2fs/data.c
  fs/f2fs/gc.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 14 ++++++++++++++
 fs/f2fs/node.c | 33 +++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 93b0bafcb0888..425ac7ac30dac 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2055,6 +2055,12 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->node_inode->i_mapping;
 }
 
+/* The caller must stabilize folio->mapping before testing it. */
+#define is_node_folio(folio) ({						\
+	struct address_space *__mapping = (folio)->mapping;		\
+	__mapping && __mapping == NODE_MAPPING(F2FS_M_SB(__mapping));	\
+})
+
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	return test_bit(type, &sbi->s_flag);
@@ -2771,6 +2777,12 @@ static inline void f2fs_put_page(struct page *page, int unlock)
 	put_page(page);
 }
 
+#define f2fs_folio_put(_folio, unlock) do {				\
+	struct folio *__folio = (_folio);					\
+	if (!IS_ERR_OR_NULL(__folio))					\
+		f2fs_put_page(&__folio->page, (unlock));			\
+} while (0)
+
 static inline void f2fs_put_dnode(struct dnode_of_data *dn)
 {
 	if (dn->node_page)
@@ -3694,6 +3706,8 @@ void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
 					block_t blkaddr, unsigned int blkcnt);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered, bool locked);
+#define f2fs_folio_wait_writeback(folio, type, ordered, locked)	\
+	f2fs_wait_on_page_writeback(&(folio)->page, type, ordered, locked)
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9df3e8fb23089..32296fc08f386 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1309,14 +1309,16 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info new_ni;
 	struct folio *folio;
+	struct page *page;
 	int err;
 
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
-	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), dn->nid, false);
-	if (IS_ERR(folio))
-		return folio;
+	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), dn->nid, false);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+	folio = page_folio(page);
 
 	if (unlikely((err = inc_valid_node_count(sbi, dn->inode, !ofs))))
 		goto fail;
@@ -1499,7 +1501,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
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
@@ -1581,7 +1587,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 
 			lock_page(page);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(!is_node_folio(page_folio(page)))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
@@ -1811,7 +1817,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			lock_page(page);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(!is_node_folio(page_folio(page)))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
@@ -1855,6 +1861,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			if (ret) {
 				unlock_page(page);
 				f2fs_put_page(last_page, 0);
+				ret = -EIO;
 				break;
 			} else if (submitted) {
 				nwritten++;
@@ -1873,18 +1880,20 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			break;
 	}
 	if (!ret && atomic && !marked) {
+		struct folio *last_folio = page_folio(last_page);
+
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
-			   ino, last_page->index);
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
 	if (nwritten)
 		f2fs_submit_merged_write_cond(sbi, NULL, NULL, ino, NODE);
-	return ret ? -EIO : 0;
+	return ret;
 }
 
 static int f2fs_match_ino(struct inode *inode, unsigned long ino, void *data)
-- 
2.53.0

