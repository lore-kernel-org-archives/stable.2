Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921E171AF
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597307; cv=none; b=UuzoIJXqv8m4qLScAs9FrR2kM4PVTrUOyxwePAUBvIaq3Zuxb/wyWPN+ItKzq+3KFKuLf6B5PGwxANI2y48fzSSWDcFKsUT7+NzcSQU0QFC8RITVlkXaHU0yAWv/ziUadK4Dxj6V6ldWJMWrbmuTtJRy5O1x6kwrXfbSuuxo4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597307; c=relaxed/simple;
	bh=bIjtf5+aIWp+2Yiff9+0f+53+dvZG2VYM5jif4lzA/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkMg+FvLlybPwbkddczpkAmGE5n7YYf6X+UBotqJ1HNLt8mTakwgpO3PowMd1yszen9bTBVv8qWh3lUMjtb7zH9+rbrf2uWmtJFKk0OrMnyjlmHmIBdjFwuXtrIvFsK2Qkk7js/Rt3Z01VOLeOEjF02+/16IbOxPh8Jf28M9PIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odbahWxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odbahWxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1011F00A3A;
	Tue, 21 Jul 2026 01:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597305;
	bh=3cMWkycjar0tn3wk4RpftPnJATfstxP/FaeG4xpaGAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odbahWxNBco61fI/0IpzRo4k74DyfXyA6RtvlRANocDKH96jUwI6KIL3afHHQKbRf
	 mg55HMsrPzyoda3UXzy7Mvp5whGUwb73wgeEIxQ5VZh5y2aYpwolF9yYWcClhg6nbg
	 q5fQNCdDP+/AARrlcFectzCStHU0CMXMCBY2Mlx5AWwzTz0z5LJ+UIANEroLJpOZ9b
	 4ic/VdRMYtR0wiRg/aRrNcHq3XVF9nnY5h7P9CQk1hyXsVR3lNrk5h9XRmjtpdVQHC
	 JXqD1gPTOoYpSB6SIgV7iOgS9NlLttAf3k5pvg6kP8jV4uNRMb4tazzzviMS5GEnq9
	 Wu1bc+A/Gf6fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] exfat: add exfat_get_dentry_set_by_ei() helper
Date: Mon, 20 Jul 2026 21:28:18 -0400
Message-ID: <20260721012821.3459448-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721012821.3459448-1-sashal@kernel.org>
References: <2026071544-able-urology-c058@gregkh>
 <20260721012821.3459448-1-sashal@kernel.org>
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
 fs/exfat/namei.c    | 53 +++++++++++++++------------------------------
 3 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index d2ba8e2d0c398a..c7aee1a14406ca 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -508,6 +508,8 @@ struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
 int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		struct super_block *sb, struct exfat_chain *p_dir, int entry,
 		unsigned int num_entries);
+#define exfat_get_dentry_set_by_ei(es, sb, ei)		\
+	exfat_get_dentry_set(es, sb, &(ei)->dir, (ei)->entry, ES_ALL_ENTRIES)
 int exfat_get_empty_dentry_set(struct exfat_entry_set_cache *es,
 		struct super_block *sb, struct exfat_chain *p_dir, int entry,
 		unsigned int num_entries);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index cc4dcb7a32b57d..b22c02d6000f79 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -43,7 +43,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
 	exfat_set_volume_dirty(sb);
 
 	/* get the directory entry of given file or directory */
-	if (exfat_get_dentry_set(&es, sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES))
+	if (exfat_get_dentry_set_by_ei(&es, sb, ei))
 		return -EIO;
 	ep = exfat_get_dentry_cached(&es, ES_IDX_FILE);
 	ep2 = exfat_get_dentry_cached(&es, ES_IDX_STREAM);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 5f740e37825986..2508894514e844 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -788,26 +788,23 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 /* remove an entry, BUT don't truncate */
 static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct exfat_chain cdir;
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct exfat_entry_set_cache es;
-	int entry, err = 0;
+	int err = 0;
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
-	exfat_chain_dup(&cdir, &ei->dir);
-	entry = ei->entry;
 	if (ei->dir.dir == DIR_DELETED) {
 		exfat_err(sb, "abnormal access to deleted dentry");
 		err = -ENOENT;
 		goto unlock;
 	}
 
-	err = exfat_get_dentry_set(&es, sb, &cdir, entry, ES_ALL_ENTRIES);
+	err = exfat_get_dentry_set_by_ei(&es, sb, ei);
 	if (err) {
 		err = -EIO;
 		goto unlock;
@@ -942,21 +939,18 @@ static int exfat_check_dir_empty(struct super_block *sb,
 static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	struct exfat_chain cdir, clu_to_free;
+	struct exfat_chain clu_to_free;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct exfat_entry_set_cache es;
-	int entry, err;
+	int err;
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
 
 	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
 
-	exfat_chain_dup(&cdir, &ei->dir);
-	entry = ei->entry;
-
 	if (ei->dir.dir == DIR_DELETED) {
 		exfat_err(sb, "abnormal access to deleted dentry");
 		err = -ENOENT;
@@ -974,7 +968,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 		goto unlock;
 	}
 
-	err = exfat_get_dentry_set(&es, sb, &cdir, entry, ES_ALL_ENTRIES);
+	err = exfat_get_dentry_set_by_ei(&es, sb, ei);
 	if (err) {
 		err = -EIO;
 		goto unlock;
@@ -1009,8 +1003,8 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_dir,
-		int oldentry, struct exfat_uni_name *p_uniname,
+static int exfat_rename_file(struct inode *parent_inode,
+		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
 		struct exfat_inode_info *ei)
 {
 	int ret, num_new_entries;
@@ -1026,7 +1020,7 @@ static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_d
 	if (num_new_entries < 0)
 		return num_new_entries;
 
-	ret = exfat_get_dentry_set(&old_es, sb, p_dir, oldentry, ES_ALL_ENTRIES);
+	ret = exfat_get_dentry_set_by_ei(&old_es, sb, ei);
 	if (ret) {
 		ret = -EIO;
 		return ret;
@@ -1080,21 +1074,19 @@ static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_d
 	return ret;
 }
 
-static int exfat_move_file(struct inode *parent_inode, struct exfat_chain *p_olddir,
-		int oldentry, struct exfat_chain *p_newdir,
-		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
+static int exfat_move_file(struct inode *parent_inode,
+		struct exfat_chain *p_newdir, struct exfat_uni_name *p_uniname,
+		struct exfat_inode_info *ei)
 {
 	int ret, newentry, num_new_entries;
 	struct exfat_dentry *epmov, *epnew;
-	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache mov_es, new_es;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
 		return num_new_entries;
 
-	ret = exfat_get_dentry_set(&mov_es, sb, p_olddir, oldentry,
-			ES_ALL_ENTRIES);
+	ret = exfat_get_dentry_set_by_ei(&mov_es, parent_inode->i_sb, ei);
 	if (ret)
 		return -EIO;
 
@@ -1143,8 +1135,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		struct dentry *new_dentry)
 {
 	int ret;
-	int dentry;
-	struct exfat_chain olddir, newdir;
+	struct exfat_chain newdir;
 	struct exfat_uni_name uni_name;
 	struct super_block *sb = old_parent_inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -1161,11 +1152,6 @@ static int __exfat_rename(struct inode *old_parent_inode,
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
@@ -1200,21 +1186,18 @@ static int __exfat_rename(struct inode *old_parent_inode,
 
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
 		struct exfat_entry_set_cache es;
-		struct exfat_chain *p_dir = &(new_ei->dir);
-		int new_entry = new_ei->entry;
 
 		/* delete entries of new_dir */
-		ret = exfat_get_dentry_set(&es, sb, p_dir, new_entry,
-				ES_ALL_ENTRIES);
+		ret = exfat_get_dentry_set_by_ei(&es, sb, new_ei);
 		if (ret) {
 			ret = -EIO;
 			goto del_out;
-- 
2.53.0

