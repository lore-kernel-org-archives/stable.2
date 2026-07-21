Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614548A2C6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634470; cv=none; b=AKWgs8EgFvLQHd+bGxG6nfONCZf8uY78NParW38gWpQ5WWjhVbnnRX2fuB8huFhjvJNXcXafMdERzfy2keLk5krTVmCUzCB2Pkkcx3Lj+kT98AptAMRHXTCgID5mVLuazGLc12HoJymCoOmJ/34KqaDPLpXLlx8W5zG02OaLxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634470; c=relaxed/simple;
	bh=izLQ4+Lu0OQlzy5oSy0PsXLi4BtMeYav0JtLM+C8r+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+p461tF0FldcotE2f/cIFhWcvUswyltMLVhGjc0qbPoaQPhqDD5U1qljkI4DRF3ddVr+k7BtWUFzg4JdJBxrgu/6QWdRYJvxBRJ0r5IUq9pTpOVSqnH5Hv/rT18kifnZiyFwOfozz1Qb0+jP+FAiuSOVy8N5YcrdeIP3w+9UMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcqQkl3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcqQkl3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397871F00A3A;
	Tue, 21 Jul 2026 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634469;
	bh=URGxVt5p1iJd/slD/IMpTSWTlc+OKhW3znuSSNZjc+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcqQkl3Bqlqpm+Cpc5QWTbSZxfxdKGSSc1eHlqrs48RxmvYNjQoGSjsKuKQkMi5Se
	 KPfKR3+PYuWuEaGFdUoF5gheLmNNHmJtYCUOCGiim4aEcePj3VkWi/JMwYPmP3qgEO
	 6MiLrS5Jwrc1a4dL+9HtynIhi8kYKMp1MA3Z6L1zFv+p36LIrRqjywPPAZKyijvdW2
	 /lQi/ff37Hp9LSPVglIX+wOHCrBvkv6wZwVHRIUCNJCw5f04ir6aeuYSJNdZj7rb4l
	 ARx76eFwr1CZycNVrXdEuSmJ+g3n8gQ1IJjVTAIRU+Dz1rPFD02PQkPYPmj8P6z2RV
	 DqT8eeXIwMZ9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] exfat: add exfat_get_dentry_set_by_ei() helper
Date: Tue, 21 Jul 2026 07:47:41 -0400
Message-ID: <20260721114743.3689685-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721114743.3689685-1-sashal@kernel.org>
References: <2026071545-counting-slander-c4c4@gregkh>
 <20260721114743.3689685-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit ac844e91364a03c35838fd488437605fbe56f8c3 ]

This helper gets the directory entry set of the file for the exfat
inode which has been created.

It's used to remove all the instances of the pattern it replaces
making the code cleaner, it's also a preparation for changing ->dir
to record the cluster where the directory entry set is located and
changing ->entry to record the index of the directory entry within
the cluster.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 942296784b2a ("exfat: preserve benign secondary entries during rename and move")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/inode.c    |  2 +-
 fs/exfat/namei.c    | 82 +++++++++++++++++++--------------------------
 3 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 19245ddd885fc3..e154284be63b6f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -498,6 +498,8 @@ struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
 int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		struct super_block *sb, struct exfat_chain *p_dir, int entry,
 		unsigned int type);
+#define exfat_get_dentry_set_by_ei(es, sb, ei)		\
+	exfat_get_dentry_set(es, sb, &(ei)->dir, (ei)->entry, ES_ALL_ENTRIES)
 int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 13329baeafbcfb..81019484296de4 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -42,7 +42,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
 	exfat_set_volume_dirty(sb);
 
 	/* get the directory entry of given file or directory */
-	if (exfat_get_dentry_set(&es, sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES))
+	if (exfat_get_dentry_set_by_ei(&es, sb, ei))
 		return -EIO;
 	ep = exfat_get_dentry_cached(&es, ES_IDX_FILE);
 	ep2 = exfat_get_dentry_cached(&es, ES_IDX_STREAM);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 7c7fe9448475cf..f1c34d8e6ff59b 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -786,29 +786,26 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 /* remove an entry, BUT don't truncate */
 static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct exfat_chain cdir;
 	struct exfat_dentry *ep;
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct buffer_head *bh;
-	int num_entries, entry, err = 0;
+	int num_entries, err = 0;
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
-	exfat_chain_dup(&cdir, &ei->dir);
-	entry = ei->entry;
 	if (ei->dir.dir == DIR_DELETED) {
 		exfat_err(sb, "abnormal access to deleted dentry");
 		err = -ENOENT;
 		goto unlock;
 	}
 
-	ep = exfat_get_dentry(sb, &cdir, entry, &bh);
+	ep = exfat_get_dentry(sb, &ei->dir, ei->entry, &bh);
 	if (!ep) {
 		err = -EIO;
 		goto unlock;
 	}
-	num_entries = exfat_count_ext_entries(sb, &cdir, entry, ep);
+	num_entries = exfat_count_ext_entries(sb, &ei->dir, ei->entry, ep);
 	if (num_entries < 0) {
 		err = -EIO;
 		brelse(bh);
@@ -819,7 +816,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	exfat_set_volume_dirty(sb);
 	/* update the directory entry */
-	if (exfat_remove_entries(dir, &cdir, entry, 0, num_entries)) {
+	if (exfat_remove_entries(dir, &ei->dir, ei->entry, 0, num_entries)) {
 		err = -EIO;
 		goto unlock;
 	}
@@ -944,18 +941,15 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	struct exfat_dentry *ep;
-	struct exfat_chain cdir, clu_to_free;
+	struct exfat_chain clu_to_free;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct buffer_head *bh;
-	int num_entries, entry, err;
+	int num_entries, err;
 
 	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
 
-	exfat_chain_dup(&cdir, &ei->dir);
-	entry = ei->entry;
-
 	if (ei->dir.dir == DIR_DELETED) {
 		exfat_err(sb, "abnormal access to deleted dentry");
 		err = -ENOENT;
@@ -973,13 +967,13 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 		goto unlock;
 	}
 
-	ep = exfat_get_dentry(sb, &cdir, entry, &bh);
+	ep = exfat_get_dentry(sb, &ei->dir, ei->entry, &bh);
 	if (!ep) {
 		err = -EIO;
 		goto unlock;
 	}
 
-	num_entries = exfat_count_ext_entries(sb, &cdir, entry, ep);
+	num_entries = exfat_count_ext_entries(sb, &ei->dir, ei->entry, ep);
 	if (num_entries < 0) {
 		err = -EIO;
 		brelse(bh);
@@ -989,7 +983,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	brelse(bh);
 
 	exfat_set_volume_dirty(sb);
-	err = exfat_remove_entries(dir, &cdir, entry, 0, num_entries);
+	err = exfat_remove_entries(dir, &ei->dir, ei->entry, 0, num_entries);
 	if (err) {
 		exfat_err(sb, "failed to exfat_remove_entries : err(%d)", err);
 		goto unlock;
@@ -1015,8 +1009,8 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_dir,
-		int oldentry, struct exfat_uni_name *p_uniname,
+static int exfat_rename_file(struct inode *parent_inode,
+		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
 		struct exfat_inode_info *ei)
 {
 	int ret, num_old_entries, num_new_entries;
@@ -1025,11 +1019,12 @@ static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_d
 	struct buffer_head *new_bh, *old_bh;
 	int sync = IS_DIRSYNC(parent_inode);
 
-	epold = exfat_get_dentry(sb, p_dir, oldentry, &old_bh);
+	epold = exfat_get_dentry(sb, &ei->dir, ei->entry, &old_bh);
 	if (!epold)
 		return -EIO;
 
-	num_old_entries = exfat_count_ext_entries(sb, p_dir, oldentry, epold);
+	num_old_entries = exfat_count_ext_entries(sb, &ei->dir, ei->entry,
+		epold);
 	if (num_old_entries < 0)
 		return -EIO;
 	num_old_entries++;
@@ -1059,7 +1054,7 @@ static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_d
 		brelse(old_bh);
 		brelse(new_bh);
 
-		epold = exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh);
+		epold = exfat_get_dentry(sb, &ei->dir, ei->entry + 1, &old_bh);
 		if (!epold)
 			return -EIO;
 		epnew = exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh);
@@ -1078,7 +1073,7 @@ static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_d
 		if (ret)
 			return ret;
 
-		exfat_remove_entries(parent_inode, p_dir, oldentry, 0,
+		exfat_remove_entries(parent_inode, &ei->dir, ei->entry, 0,
 			num_old_entries);
 		ei->dir = *p_dir;
 		ei->entry = newentry;
@@ -1090,10 +1085,10 @@ static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_d
 		exfat_update_bh(old_bh, sync);
 		brelse(old_bh);
 
-		exfat_remove_entries(parent_inode, p_dir, oldentry,
+		exfat_remove_entries(parent_inode, &ei->dir, ei->entry,
 			ES_IDX_FIRST_FILENAME + 1, num_old_entries);
 
-		ret = exfat_init_ext_entry(parent_inode, p_dir, oldentry,
+		ret = exfat_init_ext_entry(parent_inode, &ei->dir, ei->entry,
 			num_new_entries, p_uniname);
 		if (ret)
 			return ret;
@@ -1101,20 +1096,20 @@ static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_d
 	return 0;
 }
 
-static int exfat_move_file(struct inode *parent_inode, struct exfat_chain *p_olddir,
-		int oldentry, struct exfat_chain *p_newdir,
-		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
+static int exfat_move_file(struct inode *parent_inode,
+		struct exfat_chain *p_newdir, struct exfat_uni_name *p_uniname,
+		struct exfat_inode_info *ei)
 {
 	int ret, newentry, num_new_entries, num_old_entries;
 	struct exfat_dentry *epmov, *epnew;
 	struct super_block *sb = parent_inode->i_sb;
 	struct buffer_head *mov_bh, *new_bh;
 
-	epmov = exfat_get_dentry(sb, p_olddir, oldentry, &mov_bh);
+	epmov = exfat_get_dentry(sb, &ei->dir, ei->entry, &mov_bh);
 	if (!epmov)
 		return -EIO;
 
-	num_old_entries = exfat_count_ext_entries(sb, p_olddir, oldentry,
+	num_old_entries = exfat_count_ext_entries(sb, &ei->dir, ei->entry,
 		epmov);
 	if (num_old_entries < 0)
 		return -EIO;
@@ -1142,7 +1137,7 @@ static int exfat_move_file(struct inode *parent_inode, struct exfat_chain *p_old
 	brelse(mov_bh);
 	brelse(new_bh);
 
-	epmov = exfat_get_dentry(sb, p_olddir, oldentry + 1, &mov_bh);
+	epmov = exfat_get_dentry(sb, &ei->dir, ei->entry + 1, &mov_bh);
 	if (!epmov)
 		return -EIO;
 	epnew = exfat_get_dentry(sb, p_newdir, newentry + 1, &new_bh);
@@ -1161,7 +1156,7 @@ static int exfat_move_file(struct inode *parent_inode, struct exfat_chain *p_old
 	if (ret)
 		return ret;
 
-	exfat_remove_entries(parent_inode, p_olddir, oldentry, 0,
+	exfat_remove_entries(parent_inode, &ei->dir, ei->entry, 0,
 		num_old_entries);
 
 	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
@@ -1177,8 +1172,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		struct dentry *new_dentry)
 {
 	int ret;
-	int dentry;
-	struct exfat_chain olddir, newdir;
+	struct exfat_chain newdir;
 	struct exfat_uni_name uni_name;
 	struct super_block *sb = old_parent_inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -1196,11 +1190,6 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		return -ENOENT;
 	}
 
-	exfat_chain_set(&olddir, EXFAT_I(old_parent_inode)->start_clu,
-		EXFAT_B_TO_CLU_ROUND_UP(i_size_read(old_parent_inode), sbi),
-		EXFAT_I(old_parent_inode)->flags);
-	dentry = ei->entry;
-
 	/* check whether new dir is existing directory and empty */
 	if (new_inode) {
 		ret = -EIO;
@@ -1235,35 +1224,34 @@ static int __exfat_rename(struct inode *old_parent_inode,
 
 	exfat_set_volume_dirty(sb);
 
-	if (olddir.dir == newdir.dir)
-		ret = exfat_rename_file(new_parent_inode, &olddir, dentry,
+	if (new_parent_inode == old_parent_inode)
+		ret = exfat_rename_file(new_parent_inode, &newdir,
 				&uni_name, ei);
 	else
-		ret = exfat_move_file(new_parent_inode, &olddir, dentry,
-				&newdir, &uni_name, ei);
+		ret = exfat_move_file(new_parent_inode, &newdir,
+				&uni_name, ei);
 
 	if (!ret && new_inode) {
-		struct exfat_chain *p_dir = &(new_ei->dir);
-		int new_entry = new_ei->entry;
 		struct exfat_dentry *ep;
 		struct buffer_head *new_bh = NULL;
 
 		/* delete entries of new_dir */
-		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh);
+		ep = exfat_get_dentry(sb, &new_ei->dir, new_ei->entry, &new_bh);
 		if (!ep) {
 			ret = -EIO;
 			goto del_out;
 		}
 
-		num_entries = exfat_count_ext_entries(sb, p_dir, new_entry, ep);
+		num_entries = exfat_count_ext_entries(sb, &new_ei->dir,
+			new_ei->entry, ep);
 		if (num_entries < 0) {
 			ret = -EIO;
 			goto del_out;
 		}
 		brelse(new_bh);
 
-		if (exfat_remove_entries(new_inode, p_dir, new_entry, 0,
-				num_entries + 1)) {
+		if (exfat_remove_entries(new_inode, &new_ei->dir, new_ei->entry,
+				0, num_entries + 1)) {
 			ret = -EIO;
 			goto del_out;
 		}
-- 
2.53.0

