Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9F32E6BC
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176739; cv=none; b=my1cqKKOH2FSFilKT7NXGXZRZN++o6sXIloiYxxUbGIoplZ8Ssmae4vya0ra/43BU3T7Ra+sI1CSxmcVhhCQTAnqSY6UXoJdmElTFwcYlsfEDFOldxmfHpu7+Ghh2a3yBkGI3MkdHDpyc75sD84uelmc76lH9SWaFxLNypjlYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176739; c=relaxed/simple;
	bh=bwPheFVG1P9Nqe4Pxa4QWRu/XCp0MoQysbwtj3t1r5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANt3IBQl9AANhKbs3C1OgIoz4VrdirNX96uQ7Q8oJqigARK8mX3ZbybCthWH1nU8v+Bf2C0H3l2mP4ExnGOdfHQPbOLzpEvf1cWgQ9vMEywgZ1pnmUV9GUn47iI+TJSjUYntp14AzNA992QrhwcBZVxF7cth02YDBUE9TKuWF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT2IZNsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT2IZNsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F27B1F00893;
	Sat, 12 Sep 2026 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176737;
	bh=rYMIOIIFplkBOqMcxxwhQiLUN28judzmUfVZruMDgm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XT2IZNsQsZDnQ6e60FhhaZ/zW5TfZfhAfEy/hkdCvEmT+qQXG/dEiyt91ApSPWu9X
	 OGStze+9YNfc/qhJrQyG61DJqR8HEkocVXZ0ws2Xypc1FdoudSl9UOZgAm3P2bepaB
	 KwcIGc4IOWoJGMbxanvCTeZmKCI9DE+/5dxIgcFWqZyYvvKJDZOwn8RK30sByqtYDa
	 IWL8OrmDbHZ/auppCmOfNHg/hKkOWQ7ywQbXrJOnC/aIzBeq7PFnYYU5HrIHD4cNmc
	 IUbLAuF1nggfRoQ/CBez0/nAdzSIX9VgIs88oKih63PZ7UeMe1+S501CzpSYjicijX
	 L9moPjOtcNGow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] f2fs: Pass a folio to __f2fs_find_entry()
Date: Fri, 11 Sep 2026 21:32:12 -0400
Message-ID: <20260912013214.1760785-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013214.1760785-1-sashal@kernel.org>
References: <2026090949-surpass-emphases-308c@gregkh>
 <20260912013214.1760785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit c190a13d71e7d9c3ccad1d17e00285888857b974 ]

Also pass a folio to f2fs_find_in_inline_dir() and find_in_level().
Remove three calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Adapt the folio lookup interface to the 6.6 page-based implementation.
Keep f2fs_get_node_page() for inline directories, preserve error pointers
with ERR_CAST(), and convert successful results with page_folio(). Use
f2fs_find_data_page() in find_in_level(), since the preceding dependency
introduced a call to f2fs_find_data_folio() which is absent from this tree.
Preserve NULL and error results when returning pages to existing callers.

Provide f2fs_folio_put() as a macro around the existing f2fs_put_page(),
retaining its NULL handling, lock assertion, unlock and reference release
without adding a function. This keeps the page-based callers intact.

Use the existing mtime setter at the four directory update sites and use
a folio internally in f2fs_set_link(). These equivalent API adaptations
provide the context required for 9ec09d5f4b31 to cherry-pick cleanly; all
seven changes to synchronous inode dirtying remain in the target commit.

Stable-dep-of: 9ec09d5f4b31 ("f2fs: dirty directory inodes on mtime/ctime update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c      | 54 +++++++++++++++++++++++++---------------------
 fs/f2fs/f2fs.h     | 15 ++++++++-----
 fs/f2fs/inline.c   | 10 ++++-----
 fs/f2fs/namei.c    | 10 ++++-----
 fs/f2fs/recovery.c | 12 +++++------
 5 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 48073550089fe..c8e7d48c4b752 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -303,7 +303,7 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 					unsigned int level,
 					const struct f2fs_filename *fname,
-					struct page **res_page,
+					struct folio **res_folio,
 					bool use_hash)
 {
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
@@ -326,26 +326,29 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 	while (bidx < end_block) {
 		/* no need to allocate new dentry pages to all the indices */
+		struct page *dentry_page;
 		struct folio *dentry_folio;
-		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_pgofs);
-		if (IS_ERR(dentry_folio)) {
-			if (PTR_ERR(dentry_folio) == -ENOENT) {
+
+		dentry_page = f2fs_find_data_page(dir, bidx, &next_pgofs);
+		if (IS_ERR(dentry_page)) {
+			if (PTR_ERR(dentry_page) == -ENOENT) {
 				room = true;
 				bidx = next_pgofs;
 				continue;
 			} else {
-				*res_page = &dentry_folio->page;
+				*res_folio = ERR_CAST(dentry_page);
 				break;
 			}
 		}
 
+		dentry_folio = page_folio(dentry_page);
 		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
-			*res_page = ERR_CAST(de);
+			*res_folio = ERR_CAST(de);
 			de = NULL;
 			break;
 		} else if (de) {
-			*res_page = &dentry_folio->page;
+			*res_folio = dentry_folio;
 			break;
 		}
 
@@ -372,7 +375,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 					 const struct f2fs_filename *fname,
-					 struct page **res_page)
+					 struct folio **res_folio)
 {
 	unsigned long npages = dir_blocks(dir);
 	struct f2fs_dir_entry *de = NULL;
@@ -380,13 +383,13 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int level;
 	bool use_hash = true;
 
-	*res_page = NULL;
+	*res_folio = NULL;
 
 #if IS_ENABLED(CONFIG_UNICODE)
 start_find_entry:
 #endif
 	if (f2fs_has_inline_dentry(dir)) {
-		de = f2fs_find_in_inline_dir(dir, fname, res_page, use_hash);
+		de = f2fs_find_in_inline_dir(dir, fname, res_folio, use_hash);
 		goto out;
 	}
 
@@ -402,8 +405,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, fname, res_page, use_hash);
-		if (de || IS_ERR(*res_page))
+		de = find_in_level(dir, level, fname, res_folio, use_hash);
+		if (de || IS_ERR(*res_folio))
 			break;
 	}
 
@@ -431,6 +434,7 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 {
 	struct f2fs_dir_entry *de = NULL;
 	struct f2fs_filename fname;
+	struct folio *rfolio;
 	int err;
 
 	err = f2fs_setup_filename(dir, child, 1, &fname);
@@ -442,7 +446,8 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 		return NULL;
 	}
 
-	de = __f2fs_find_entry(dir, &fname, res_page);
+	de = __f2fs_find_entry(dir, &fname, &rfolio);
+	*res_page = IS_ERR_OR_NULL(rfolio) ? ERR_CAST(rfolio) : &rfolio->page;
 
 	f2fs_free_filename(&fname);
 	return de;
@@ -472,16 +477,17 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 		struct page *page, struct inode *inode)
 {
 	enum page_type type = f2fs_has_inline_dentry(dir) ? NODE : DATA;
+	struct folio *folio = page_folio(page);
 
-	lock_page(page);
+	folio_lock(folio);
 	f2fs_wait_on_page_writeback(page, type, true, true);
 	de->ino = cpu_to_le32(inode->i_ino);
 	de->file_type = fs_umode_to_ftype(inode->i_mode);
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 }
 
 static void init_dent_inode(struct inode *dir, struct inode *inode,
@@ -633,7 +639,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 			f2fs_i_links_write(dir, true);
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
@@ -823,7 +829,7 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct f2fs_filename fname;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct f2fs_dir_entry *de = NULL;
 	int err;
 
@@ -839,14 +845,14 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 	 * consistency more.
 	 */
 	if (current != F2FS_I(dir)->task) {
-		de = __f2fs_find_entry(dir, &fname, &page);
+		de = __f2fs_find_entry(dir, &fname, &folio);
 		F2FS_I(dir)->task = NULL;
 	}
 	if (de) {
-		f2fs_put_page(page, 0);
+		f2fs_folio_put(folio, false);
 		err = -EEXIST;
-	} else if (IS_ERR(page)) {
-		err = PTR_ERR(page);
+	} else if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
 	} else {
 		err = f2fs_add_dentry(dir, &fname, inode, ino, mode);
 	}
@@ -944,7 +950,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	}
 	f2fs_put_page(page, 1);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 63d3450f895ee..311d3b82b60a6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2844,6 +2844,13 @@ static inline void f2fs_put_page(struct page *page, int unlock)
 	put_page(page);
 }
 
+/* Keep folio callers on the existing page release path in this tree. */
+#define f2fs_folio_put(_folio, _unlock)					\
+do {									\
+	struct folio *__folio = (_folio);					\
+	f2fs_put_page(__folio ? &__folio->page : NULL, (_unlock));		\
+} while (0)
+
 static inline void f2fs_put_dnode(struct dnode_of_data *dn)
 {
 	if (dn->node_page)
@@ -3600,8 +3607,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 int f2fs_room_for_filename(const void *bitmap, int slots, int max_slots);
 void f2fs_drop_nlink(struct inode *dir, struct inode *inode);
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
-					 const struct f2fs_filename *fname,
-					 struct page **res_page);
+		const struct f2fs_filename *fname, struct folio **res_folio);
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 			const struct qstr *child, struct page **res_page);
 struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p);
@@ -4203,9 +4209,8 @@ int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry);
 int f2fs_write_inline_data(struct inode *inode, struct page *page);
 int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
-					const struct f2fs_filename *fname,
-					struct page **res_page,
-					bool use_hash);
+		const struct f2fs_filename *fname, struct folio **res_folio,
+		bool use_hash);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 92bbdb272a6d9..d9e7f581de780 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -353,7 +353,7 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page,
+					struct folio **res_folio,
 					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
@@ -364,7 +364,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 
 	ipage = f2fs_get_node_page(sbi, dir->i_ino);
 	if (IS_ERR(ipage)) {
-		*res_page = ipage;
+		*res_folio = ERR_CAST(ipage);
 		return NULL;
 	}
 
@@ -374,11 +374,11 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
 	unlock_page(ipage);
 	if (IS_ERR(de)) {
-		*res_page = ERR_CAST(de);
+		*res_folio = ERR_CAST(de);
 		de = NULL;
 	}
 	if (de)
-		*res_page = ipage;
+		*res_folio = page_folio(ipage);
 	else
 		f2fs_put_page(ipage, 0);
 
@@ -720,7 +720,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e55d0ee3e2947..e009b145c3863 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -460,7 +460,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 {
 	struct inode *inode = NULL;
 	struct f2fs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 	struct dentry *new;
 	nid_t ino = -1;
 	int err = 0;
@@ -479,12 +479,12 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_splice;
 	if (err)
 		goto out;
-	de = __f2fs_find_entry(dir, &fname, &page);
+	de = __f2fs_find_entry(dir, &fname, &folio);
 	f2fs_free_filename(&fname);
 
 	if (!de) {
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			goto out;
 		}
 		err = -ENOENT;
@@ -492,7 +492,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	ino = le32_to_cpu(de->ino);
-	f2fs_put_page(page, 0);
+	f2fs_folio_put(folio, false);
 
 	inode = f2fs_iget(dir->i_sb, ino);
 	if (IS_ERR(inode)) {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 332996ff5cce6..1f37594defe0c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -172,7 +172,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	struct f2fs_dir_entry *de;
 	struct f2fs_filename fname;
 	struct qstr usr_fname;
-	struct page *page;
+	struct folio *folio;
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *entry;
 	int err = 0;
@@ -194,7 +194,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	if (err)
 		goto out;
 retry:
-	de = __f2fs_find_entry(dir, &fname, &page);
+	de = __f2fs_find_entry(dir, &fname, &folio);
 	if (de && inode->i_ino == le32_to_cpu(de->ino))
 		goto out_put;
 
@@ -219,11 +219,11 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 			iput(einode);
 			goto out_put;
 		}
-		f2fs_delete_entry(de, page, dir, einode);
+		f2fs_delete_entry(de, &folio->page, dir, einode);
 		iput(einode);
 		goto retry;
-	} else if (IS_ERR(page)) {
-		err = PTR_ERR(page);
+	} else if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
 	} else {
 		err = f2fs_add_dentry(dir, &fname, inode,
 					inode->i_ino, inode->i_mode);
@@ -233,7 +233,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	goto out;
 
 out_put:
-	f2fs_put_page(page, 0);
+	f2fs_folio_put(folio, false);
 out:
 	if (file_enc_name(inode))
 		name = "<encrypted>";
-- 
2.53.0

