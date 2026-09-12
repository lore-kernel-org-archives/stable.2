Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4162331ED5
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176740; cv=none; b=u2KSui5BMpkcNccaRnisyVH67rQUGCKdN0iTR36u84X8M84W158xjr9y/ywAz4Xl7Zbc6WBN24ZfVOyWWx/5bTAOhMI9KwdbbAgAhmPT/54oITALd8SDSHWExYrFhbv8gpmUJY5uInw/syJR6ETgG7Z1PwyW6tEWYV9ZCYN/w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176740; c=relaxed/simple;
	bh=GX53bE+PDoQd9hbosKA2lx0wlk9xKRuADDwbLssj6mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGSVv/Pp8iN96fCUZWHwg+udzOn9CPxw1Uf5EvTZ9+LP3uWq50vDGG2Px76Fmq7QRr8bpV5OX6g9zP2ECl8TO8beLlv5mUvq0FQ3SxcZXkmD8KFVQRxE7WRF0XPmd+f4GtifybP+jvmMBqPkmgzRc/A3A1VKjgjBrD6rqvmuR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KITyb0GA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KITyb0GA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16F21F00898;
	Sat, 12 Sep 2026 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176738;
	bh=DkBy/1bzULiXsTsbje3Np+O31CNXI6ObGif3Wly9gOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KITyb0GA+YjcomiCHK4ILUFy2A8eQDrI2pUs+UiKM1QHMbpj/Bftpn36V5/lWL9GE
	 eohVZ+5/x2GQ5ZhfmNYVs2C6WMXgjsA7a3WUguuH/trOg/AVMZh6gEIhys7yhZ6u/Y
	 ftktZg+OfzeCe15vJVq/ye5q7fuEbl1zaMzzFs/jrOKzm1lZ1EHJ6gPmKfT5OnESMp
	 GcoHTblqp5ZOtkZqx6WFD9lfPBilq3oHp2FNQdOdUulHhBXPaBaTUyEHmMX0mdF4xt
	 Fbtn9yf7fjvULS5vemDq/MvAOmmkrErHVu75xQPt9gowXKtHvfThNiWWa1uVV1oB4N
	 yFyxwgC5a3iCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] f2fs: Pass a folio to f2fs_find_entry()
Date: Fri, 11 Sep 2026 21:32:13 -0400
Message-ID: <20260912013214.1760785-3-sashal@kernel.org>
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

[ Upstream commit 0bd84d2d8912e83c4c6771ca12c647f4e37419cd ]

Convert all callers to pass in a pointer to a folio instead of a page.
Also convert f2fs_inode_by_name() to take a folio pointer.  Removes
six calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Adapt this dependency to the stable page-based implementation. Return the
folio directly from f2fs_find_entry(), and preserve NULL and error pointers
when f2fs_parent_dir() converts its result back to a page.

Pass folios to the existing f2fs_set_link(), f2fs_delete_entry() and
f2fs_delete_inline_entry() functions, updating all callers, including
recovery. Keep the stable page-based writeback and cache helpers through
local page pointers, and use the existing f2fs_folio_put() compatibility
macro to preserve locking and reference-release behavior.

These interface and release-call adaptations supply the context needed for
9ec09d5f4b31 ("f2fs: dirty directory inodes on mtime/ctime update") to apply
without conflicts. Leave all seven synchronous inode-dirtying changes to
the target commit. No new functions are introduced.

Stable-dep-of: 9ec09d5f4b31 ("f2fs: dirty directory inodes on mtime/ctime update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c      | 38 +++++++++++-----------
 fs/f2fs/f2fs.h     | 10 +++---
 fs/f2fs/inline.c   |  5 +--
 fs/f2fs/namei.c    | 78 ++++++++++++++++++++++++----------------------
 fs/f2fs/recovery.c |  2 +-
 5 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c8e7d48c4b752..29005eeb283ca 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -425,29 +425,27 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 /*
  * Find an entry in the specified directory with the wanted name.
- * It returns the page where the entry was found (as a parameter - res_page),
- * and the entry itself. Page is returned mapped and unlocked.
+ * It returns the folio where the entry was found (as a parameter - res_folio),
+ * and the entry itself. Folio is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
  */
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
-			const struct qstr *child, struct page **res_page)
+			const struct qstr *child, struct folio **res_folio)
 {
 	struct f2fs_dir_entry *de = NULL;
 	struct f2fs_filename fname;
-	struct folio *rfolio;
 	int err;
 
 	err = f2fs_setup_filename(dir, child, 1, &fname);
 	if (err) {
 		if (err == -ENOENT)
-			*res_page = NULL;
+			*res_folio = NULL;
 		else
-			*res_page = ERR_PTR(err);
+			*res_folio = ERR_PTR(err);
 		return NULL;
 	}
 
-	de = __f2fs_find_entry(dir, &fname, &rfolio);
-	*res_page = IS_ERR_OR_NULL(rfolio) ? ERR_CAST(rfolio) : &rfolio->page;
+	de = __f2fs_find_entry(dir, &fname, res_folio);
 
 	f2fs_free_filename(&fname);
 	return de;
@@ -455,32 +453,35 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 
 struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p)
 {
-	return f2fs_find_entry(dir, &dotdot_name, p);
+	struct folio *folio;
+	struct f2fs_dir_entry *r = f2fs_find_entry(dir, &dotdot_name, &folio);
+
+	*p = IS_ERR_OR_NULL(folio) ? ERR_CAST(folio) : &folio->page;
+	return r;
 }
 
 ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
-							struct page **page)
+							struct folio **folio)
 {
 	ino_t res = 0;
 	struct f2fs_dir_entry *de;
 
-	de = f2fs_find_entry(dir, qstr, page);
+	de = f2fs_find_entry(dir, qstr, folio);
 	if (de) {
 		res = le32_to_cpu(de->ino);
-		f2fs_put_page(*page, 0);
+		f2fs_folio_put(*folio, false);
 	}
 
 	return res;
 }
 
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
-		struct page *page, struct inode *inode)
+		struct folio *folio, struct inode *inode)
 {
 	enum page_type type = f2fs_has_inline_dentry(dir) ? NODE : DATA;
-	struct folio *folio = page_folio(page);
 
 	folio_lock(folio);
-	f2fs_wait_on_page_writeback(page, type, true, true);
+	f2fs_wait_on_page_writeback(&folio->page, type, true, true);
 	de->ino = cpu_to_le32(inode->i_ino);
 	de->file_type = fs_umode_to_ftype(inode->i_mode);
 	folio_mark_dirty(folio);
@@ -908,9 +909,10 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
  * It only removes the dentry from the dentry page, corresponding name
  * entry in name page does not need to be touched during deletion.
  */
-void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
+void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 					struct inode *dir, struct inode *inode)
 {
+	struct page *page = &folio->page;
 	struct	f2fs_dentry_block *dentry_blk;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
@@ -922,7 +924,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		f2fs_add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
 
 	if (f2fs_has_inline_dentry(dir))
-		return f2fs_delete_inline_entry(dentry, page, dir, inode);
+		return f2fs_delete_inline_entry(dentry, folio, dir, inode);
 
 	lock_page(page);
 	f2fs_wait_on_page_writeback(page, DATA, true, true);
@@ -948,7 +950,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		inode_dec_dirty_pages(dir);
 		f2fs_remove_dirty_inode(dir);
 	}
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 311d3b82b60a6..f93c226f710c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3609,12 +3609,12 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode);
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 		const struct f2fs_filename *fname, struct folio **res_folio);
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
-			const struct qstr *child, struct page **res_page);
+			const struct qstr *child, struct folio **res_folio);
 struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p);
 ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
-			struct page **page);
+			struct folio **folio);
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
-			struct page *page, struct inode *inode);
+			struct folio *folio, struct inode *inode);
 bool f2fs_has_enough_room(struct inode *dir, struct page *ipage,
 			  const struct f2fs_filename *fname);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
@@ -3626,7 +3626,7 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
 int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 			struct inode *inode, nid_t ino, umode_t mode);
-void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
+void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 			struct inode *dir, struct inode *inode);
 int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
 					struct f2fs_filename *fname);
@@ -4216,7 +4216,7 @@ int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
-				struct page *page, struct inode *dir,
+				struct folio *folio, struct inode *dir,
 				struct inode *inode);
 bool f2fs_empty_inline_dir(struct inode *dir);
 int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d9e7f581de780..68e5a77bb515d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -698,9 +698,10 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 	return err;
 }
 
-void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
+void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 					struct inode *dir, struct inode *inode)
 {
+	struct page *page = &folio->page;
 	struct f2fs_dentry_ptr d;
 	void *inline_dentry;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
@@ -718,7 +719,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		__clear_bit_le(bit_pos + i, d.bitmap);
 
 	set_page_dirty(page);
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e009b145c3863..96ed0ab996b0d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -444,12 +444,12 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 struct dentry *f2fs_get_parent(struct dentry *child)
 {
-	struct page *page;
-	unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &page);
+	struct folio *folio;
+	unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &folio);
 
 	if (!ino) {
-		if (IS_ERR(page))
-			return ERR_CAST(page);
+		if (IS_ERR(folio))
+			return ERR_CAST(folio);
 		return ERR_PTR(-ENOENT);
 	}
 	return d_obtain_alias(f2fs_iget(child->d_sb, ino));
@@ -536,7 +536,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode = d_inode(dentry);
 	struct f2fs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 	int err;
 
 	trace_f2fs_unlink_enter(dir, dentry);
@@ -553,10 +553,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto fail;
 
-	de = f2fs_find_entry(dir, &dentry->d_name, &page);
+	de = f2fs_find_entry(dir, &dentry->d_name, &folio);
 	if (!de) {
-		if (IS_ERR(page))
-			err = PTR_ERR(page);
+		if (IS_ERR(folio))
+			err = PTR_ERR(folio);
 		goto fail;
 	}
 
@@ -565,7 +565,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 			  __func__, inode->i_ino);
 		err = -EFSCORRUPTED;
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
-		f2fs_put_page(page, 0);
+		f2fs_folio_put(folio, false);
 		goto fail;
 	}
 
@@ -575,10 +575,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	err = f2fs_acquire_orphan_inode(sbi);
 	if (err) {
 		f2fs_unlock_op(sbi);
-		f2fs_put_page(page, 0);
+		f2fs_folio_put(folio, false);
 		goto fail;
 	}
-	f2fs_delete_entry(de, page, dir, inode);
+	f2fs_delete_entry(de, folio, dir, inode);
 	f2fs_unlock_op(sbi);
 
 #if IS_ENABLED(CONFIG_UNICODE)
@@ -901,7 +901,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *whiteout = NULL;
 	struct page *old_dir_page = NULL;
-	struct page *old_page, *new_page = NULL;
+	struct folio *old_folio, *new_folio = NULL;
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
@@ -960,10 +960,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	err = -ENOENT;
-	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
 	if (!old_entry) {
-		if (IS_ERR(old_page))
-			err = PTR_ERR(old_page);
+		if (IS_ERR(old_folio))
+			err = PTR_ERR(old_folio);
 		goto out;
 	}
 
@@ -984,10 +984,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 		err = -ENOENT;
 		new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name,
-						&new_page);
+						&new_folio);
 		if (!new_entry) {
-			if (IS_ERR(new_page))
-				err = PTR_ERR(new_page);
+			if (IS_ERR(new_folio))
+				err = PTR_ERR(new_folio);
 			goto out_dir;
 		}
 
@@ -999,8 +999,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (err)
 			goto put_out_dir;
 
-		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
-		new_page = NULL;
+		f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
+		new_folio = NULL;
 
 		inode_set_ctime_current(new_inode);
 		f2fs_down_write(&F2FS_I(new_inode)->i_sem);
@@ -1039,8 +1039,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	inode_set_ctime_current(old_inode);
 	f2fs_mark_inode_dirty_sync(old_inode, false);
 
-	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
-	old_page = NULL;
+	f2fs_delete_entry(old_entry, old_folio, old_dir, NULL);
+	old_folio = NULL;
 
 	if (whiteout) {
 		set_inode_flag(whiteout, FI_INC_LINK);
@@ -1060,7 +1060,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (old_dir_entry) {
 		if (old_dir != new_dir)
 			f2fs_set_link(old_inode, old_dir_entry,
-						old_dir_page, new_dir);
+						page_folio(old_dir_page), new_dir);
 		else
 			f2fs_put_page(old_dir_page, 0);
 		f2fs_i_links_write(old_dir, false);
@@ -1082,12 +1082,12 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 put_out_dir:
 	f2fs_unlock_op(sbi);
-	f2fs_put_page(new_page, 0);
+	f2fs_folio_put(new_folio, false);
 out_dir:
 	if (old_dir_entry)
 		f2fs_put_page(old_dir_page, 0);
 out_old:
-	f2fs_put_page(old_page, 0);
+	f2fs_folio_put(old_folio, false);
 out:
 	iput(whiteout);
 	return err;
@@ -1100,7 +1100,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct page *old_dir_page, *new_dir_page;
-	struct page *old_page, *new_page;
+	struct folio *old_folio, *new_folio;
 	struct f2fs_dir_entry *old_dir_entry = NULL, *new_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry, *new_entry;
 	int old_nlink = 0, new_nlink = 0;
@@ -1128,17 +1128,17 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out;
 
 	err = -ENOENT;
-	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
 	if (!old_entry) {
-		if (IS_ERR(old_page))
-			err = PTR_ERR(old_page);
+		if (IS_ERR(old_folio))
+			err = PTR_ERR(old_folio);
 		goto out;
 	}
 
-	new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name, &new_page);
+	new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
 	if (!new_entry) {
-		if (IS_ERR(new_page))
-			err = PTR_ERR(new_page);
+		if (IS_ERR(new_folio))
+			err = PTR_ERR(new_folio);
 		goto out_old;
 	}
 
@@ -1186,14 +1186,16 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	/* update ".." directory entry info of old dentry */
 	if (old_dir_entry)
-		f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
+		f2fs_set_link(old_inode, old_dir_entry,
+				page_folio(old_dir_page), new_dir);
 
 	/* update ".." directory entry info of new dentry */
 	if (new_dir_entry)
-		f2fs_set_link(new_inode, new_dir_entry, new_dir_page, old_dir);
+		f2fs_set_link(new_inode, new_dir_entry,
+				page_folio(new_dir_page), old_dir);
 
 	/* update directory entry info of old dir inode */
-	f2fs_set_link(old_dir, old_entry, old_page, new_inode);
+	f2fs_set_link(old_dir, old_entry, old_folio, new_inode);
 
 	f2fs_down_write(&F2FS_I(old_inode)->i_sem);
 	if (!old_dir_entry)
@@ -1212,7 +1214,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_mark_inode_dirty_sync(old_dir, false);
 
 	/* update directory entry info of new dir inode */
-	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
+	f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
 
 	f2fs_down_write(&F2FS_I(new_inode)->i_sem);
 	if (!new_dir_entry)
@@ -1251,9 +1253,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_put_page(old_dir_page, 0);
 	}
 out_new:
-	f2fs_put_page(new_page, 0);
+	f2fs_folio_put(new_folio, false);
 out_old:
-	f2fs_put_page(old_page, 0);
+	f2fs_folio_put(old_folio, false);
 out:
 	return err;
 }
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 1f37594defe0c..fc51ee800e3f5 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -219,7 +219,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 			iput(einode);
 			goto out_put;
 		}
-		f2fs_delete_entry(de, &folio->page, dir, einode);
+		f2fs_delete_entry(de, folio, dir, einode);
 		iput(einode);
 		goto retry;
 	} else if (IS_ERR(folio)) {
-- 
2.53.0

