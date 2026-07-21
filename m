Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE79376490
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634471; cv=none; b=R043PIaOzW01mqmBhwSTa68NEIk26Ha5lEiPpcgIQlHq6aZbWQ5pbbDRq5tVxEqqTbTedvM4X4MyWZTA951ckcPhEuMhnNcwtNP3RCn+gGF+viCKt8gM+U/Ar7/Bv7DIVFS/QoAEWzYYJ3t6OOz/GQQ+/eYjR0AWb7abamrxbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634471; c=relaxed/simple;
	bh=8Kz2MEsqwXoN15Y22KmYrH00+8lduUCe1vJGrWmE0U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEA3yqrqgfNqIENEPRXCiJOrdWegh8FZ4Pv9miGKDq6Oo8q3KLetxF0hLpx4Ieq6io2LarMIF3Tn82U69Km9bckCMYRwEBPHqYMAIDRDHc64ywPDz0dSAYsupLyIsjg9kBTfd12AgXcDgViaDjvsvk+l6uyTPKs2fx/P/XBlU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYq42J29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYq42J29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D1F1F00AC4;
	Tue, 21 Jul 2026 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634470;
	bh=RO13q/Xc7g2BahRTRdK1QIYe7MyG7+j7+6UV1+9Cc+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYq42J29sWmoL+9IqrCHoDew5aZC/my0QkTdkYh1erBGU+xvFH3cCRcWEB+4kgyQy
	 LSrh3hKM02OyQPxZPnD/9ZcSZx9c7CgVpKKKBzBe0MNSJv/Gdgzx3NoZGSWP3A7TUN
	 lD0QiT6tDyUUsWvdkDFzaHcH5P0zPn2Y0xR714lObXm1YIjySUav9e4YH3Gay19hS0
	 IwoTAA8fbAZSDy/WxWPpik36KnH1ujtUf+0Zm51EzE8olpr3z/RfWb51ifOfPxF7N3
	 55e4VLyXX7osiR/LXFqQ6NylMAHqkLNP/7RjDMHUZ0omP//Mmotml03RTFF1Gzisly
	 LHQU2r64akm/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/6] exfat: move exfat_chain_set() out of __exfat_resolve_path()
Date: Tue, 21 Jul 2026 07:47:42 -0400
Message-ID: <20260721114743.3689685-5-sashal@kernel.org>
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

[ Upstream commit 0891c7313d87a1b6baf7162bc2f0d755ce70383f ]

__exfat_resolve_path() mixes two functions. The first one is to
resolve and check if the path is valid. The second one is to output
the cluster assigned to the directory.

The second one is only needed when need to traverse the directory
entries, and calling exfat_chain_set() so early causes p_dir to be
passed as an argument multiple times, increasing the complexity of
the code.

This commit moves the call to exfat_chain_set() before traversing
directory entries.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 942296784b2a ("exfat: preserve benign secondary entries during rename and move")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/namei.c | 68 +++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index f1c34d8e6ff59b..f0856f7d9d5910 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -343,6 +343,9 @@ static int exfat_find_empty_entry(struct inode *inode,
 		ei->hint_femp.eidx = EXFAT_HINT_NONE;
 	}
 
+	exfat_chain_set(p_dir, ei->start_clu,
+			EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
+
 	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
 					num_entries)) < 0) {
 		if (dentry == -EIO)
@@ -419,14 +422,11 @@ static int exfat_find_empty_entry(struct inode *inode,
  * Zero if it was successful; otherwise nonzero.
  */
 static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
-		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int lookup)
+		struct exfat_uni_name *p_uniname, int lookup)
 {
 	int namelen;
 	int lossy = NLS_NAME_NO_LOSSY;
 	struct super_block *sb = inode->i_sb;
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct exfat_inode_info *ei = EXFAT_I(inode);
 	int pathlen = strlen(path);
 
 	/*
@@ -465,24 +465,19 @@ static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
 	if ((lossy && !lookup) || !namelen)
 		return (lossy & NLS_NAME_OVERLEN) ? -ENAMETOOLONG : -EINVAL;
 
-	exfat_chain_set(p_dir, ei->start_clu,
-		EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
-
 	return 0;
 }
 
 static inline int exfat_resolve_path(struct inode *inode,
-		const unsigned char *path, struct exfat_chain *dir,
-		struct exfat_uni_name *uni)
+		const unsigned char *path, struct exfat_uni_name *uni)
 {
-	return __exfat_resolve_path(inode, path, dir, uni, 0);
+	return __exfat_resolve_path(inode, path, uni, 0);
 }
 
 static inline int exfat_resolve_path_for_lookup(struct inode *inode,
-		const unsigned char *path, struct exfat_chain *dir,
-		struct exfat_uni_name *uni)
+		const unsigned char *path, struct exfat_uni_name *uni)
 {
-	return __exfat_resolve_path(inode, path, dir, uni, 1);
+	return __exfat_resolve_path(inode, path, uni, 1);
 }
 
 static inline loff_t exfat_make_i_pos(struct exfat_dir_entry *info)
@@ -502,7 +497,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	int clu_size = 0;
 	unsigned int start_clu = EXFAT_FREE_CLUSTER;
 
-	ret = exfat_resolve_path(inode, path, p_dir, &uniname);
+	ret = exfat_resolve_path(inode, path, &uniname);
 	if (ret)
 		goto out;
 
@@ -623,10 +618,13 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 		return -ENOENT;
 
 	/* check the validity of directory name in the given pathname */
-	ret = exfat_resolve_path_for_lookup(dir, qname->name, &cdir, &uni_name);
+	ret = exfat_resolve_path_for_lookup(dir, qname->name, &uni_name);
 	if (ret)
 		return ret;
 
+	exfat_chain_set(&cdir, ei->start_clu,
+		EXFAT_B_TO_CLU(i_size_read(dir), sbi), ei->flags);
+
 	/* check the validation of hint_stat and initialize it if required */
 	if (ei->version != (inode_peek_iversion_raw(dir) & 0xffffffff)) {
 		ei->hint_stat.clu = cdir.dir;
@@ -1010,8 +1008,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 static int exfat_rename_file(struct inode *parent_inode,
-		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		struct exfat_inode_info *ei)
+		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
 	int ret, num_old_entries, num_new_entries;
 	struct exfat_dentry *epold, *epnew;
@@ -1035,13 +1032,14 @@ static int exfat_rename_file(struct inode *parent_inode,
 
 	if (num_old_entries < num_new_entries) {
 		int newentry;
+		struct exfat_chain dir;
 
-		newentry = exfat_find_empty_entry(parent_inode, p_dir,
+		newentry = exfat_find_empty_entry(parent_inode, &dir,
 				num_new_entries);
 		if (newentry < 0)
 			return newentry; /* -EIO or -ENOSPC */
 
-		epnew = exfat_get_dentry(sb, p_dir, newentry, &new_bh);
+		epnew = exfat_get_dentry(sb, &dir, newentry, &new_bh);
 		if (!epnew)
 			return -EIO;
 
@@ -1057,7 +1055,7 @@ static int exfat_rename_file(struct inode *parent_inode,
 		epold = exfat_get_dentry(sb, &ei->dir, ei->entry + 1, &old_bh);
 		if (!epold)
 			return -EIO;
-		epnew = exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh);
+		epnew = exfat_get_dentry(sb, &dir, newentry + 1, &new_bh);
 		if (!epnew) {
 			brelse(old_bh);
 			return -EIO;
@@ -1068,14 +1066,14 @@ static int exfat_rename_file(struct inode *parent_inode,
 		brelse(old_bh);
 		brelse(new_bh);
 
-		ret = exfat_init_ext_entry(parent_inode, p_dir, newentry,
+		ret = exfat_init_ext_entry(parent_inode, &dir, newentry,
 			num_new_entries, p_uniname);
 		if (ret)
 			return ret;
 
 		exfat_remove_entries(parent_inode, &ei->dir, ei->entry, 0,
 			num_old_entries);
-		ei->dir = *p_dir;
+		ei->dir = dir;
 		ei->entry = newentry;
 	} else {
 		if (exfat_get_entry_type(epold) == TYPE_FILE) {
@@ -1097,13 +1095,13 @@ static int exfat_rename_file(struct inode *parent_inode,
 }
 
 static int exfat_move_file(struct inode *parent_inode,
-		struct exfat_chain *p_newdir, struct exfat_uni_name *p_uniname,
-		struct exfat_inode_info *ei)
+		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
 	int ret, newentry, num_new_entries, num_old_entries;
 	struct exfat_dentry *epmov, *epnew;
 	struct super_block *sb = parent_inode->i_sb;
 	struct buffer_head *mov_bh, *new_bh;
+	struct exfat_chain newdir;
 
 	epmov = exfat_get_dentry(sb, &ei->dir, ei->entry, &mov_bh);
 	if (!epmov)
@@ -1119,12 +1117,12 @@ static int exfat_move_file(struct inode *parent_inode,
 	if (num_new_entries < 0)
 		return num_new_entries;
 
-	newentry = exfat_find_empty_entry(parent_inode, p_newdir,
+	newentry = exfat_find_empty_entry(parent_inode, &newdir,
 			num_new_entries);
 	if (newentry < 0)
 		return newentry; /* -EIO or -ENOSPC */
 
-	epnew = exfat_get_dentry(sb, p_newdir, newentry, &new_bh);
+	epnew = exfat_get_dentry(sb, &newdir, newentry, &new_bh);
 	if (!epnew)
 		return -EIO;
 
@@ -1140,7 +1138,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	epmov = exfat_get_dentry(sb, &ei->dir, ei->entry + 1, &mov_bh);
 	if (!epmov)
 		return -EIO;
-	epnew = exfat_get_dentry(sb, p_newdir, newentry + 1, &new_bh);
+	epnew = exfat_get_dentry(sb, &newdir, newentry + 1, &new_bh);
 	if (!epnew) {
 		brelse(mov_bh);
 		return -EIO;
@@ -1151,7 +1149,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	brelse(mov_bh);
 	brelse(new_bh);
 
-	ret = exfat_init_ext_entry(parent_inode, p_newdir, newentry,
+	ret = exfat_init_ext_entry(parent_inode, &newdir, newentry,
 		num_new_entries, p_uniname);
 	if (ret)
 		return ret;
@@ -1159,9 +1157,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	exfat_remove_entries(parent_inode, &ei->dir, ei->entry, 0,
 		num_old_entries);
 
-	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
-		p_newdir->flags);
-
+	ei->dir = newdir;
 	ei->entry = newentry;
 	return 0;
 }
@@ -1172,7 +1168,6 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		struct dentry *new_dentry)
 {
 	int ret;
-	struct exfat_chain newdir;
 	struct exfat_uni_name uni_name;
 	struct super_block *sb = old_parent_inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -1217,19 +1212,16 @@ static int __exfat_rename(struct inode *old_parent_inode,
 	}
 
 	/* check the validity of directory name in the given new pathname */
-	ret = exfat_resolve_path(new_parent_inode, new_path, &newdir,
-			&uni_name);
+	ret = exfat_resolve_path(new_parent_inode, new_path, &uni_name);
 	if (ret)
 		goto out;
 
 	exfat_set_volume_dirty(sb);
 
 	if (new_parent_inode == old_parent_inode)
-		ret = exfat_rename_file(new_parent_inode, &newdir,
-				&uni_name, ei);
+		ret = exfat_rename_file(new_parent_inode, &uni_name, ei);
 	else
-		ret = exfat_move_file(new_parent_inode, &newdir,
-				&uni_name, ei);
+		ret = exfat_move_file(new_parent_inode, &uni_name, ei);
 
 	if (!ret && new_inode) {
 		struct exfat_dentry *ep;
-- 
2.53.0

