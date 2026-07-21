Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FF3F99FA
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597308; cv=none; b=GBqIkWkVRt2N5w003vtfBCzsutc7BmkarGhIK4qkxCHx+8/fLWnRCq5gfYjgsrH04oOfVH9hxlksXwixUPUuMdCAXEHC8sVLM2vd/rZyBN+Mzhose513bhMn5UdLNJH6lsPyMm8FBIlaQ7itKrwnVFg4NPj+PCWduRbneMpFgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597308; c=relaxed/simple;
	bh=Q/0mNHVOpIe5ATtrJtSMUoBMvoQJOM//bVqaTgtM4VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpbVCrnT17YVnV588jts5ZOXHveiPKTb2utQNp/qD4uMIevsFIjb4g50o6vQOB1+yMX3KyCUjii/bpkskYkMLRaxCNwSg3OXQiHA/nTyV0OXH+qPywS1uue3dPT1Q2rpCMNkG1+VKbVp3rZqykaYUgo18jDRPEd5FRZcx/JUouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwJzsTWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwJzsTWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6531F000E9;
	Tue, 21 Jul 2026 01:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597306;
	bh=VC7as/mNoaUwfvEvrQsoQ4IIzkDrVpUgHWICVYGmkUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwJzsTWIzedcU/hgn9KwCqMVbThjbCTV66dnD+brycYeb0eQGetS28mAsdw20s2Cc
	 HpL2J0CgyZVdysBw2hgejAZXwl7VL/C3a8g63IVWWC0gntdHQ1f+hHjQm2Nk31Og6A
	 n0Qjwu69GL6x0LHtTjFGuyE2yj/clnpW43iepIkJa0K44Uwapd95ZD4+9Gi+zHAqe1
	 2F9gQrSzdzpI0EAaIE1CyQx082mbT3O/YRbsVu+T5kIvclCfSD25DYay4YMjHtC26s
	 9sRPXNG2t7f2UqJyDY41mzdU7C2+EeVaO+eBcYkte+4SkzhR3c3kdbAAX81y4vfBSD
	 8CqqOuBlHkpNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/6] exfat: move exfat_chain_set() out of __exfat_resolve_path()
Date: Mon, 20 Jul 2026 21:28:19 -0400
Message-ID: <20260721012821.3459448-4-sashal@kernel.org>
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
 fs/exfat/namei.c | 60 +++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2508894514e844..d4eaf422c36c68 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -311,6 +311,9 @@ static int exfat_find_empty_entry(struct inode *inode,
 		ei->hint_femp.eidx = EXFAT_HINT_NONE;
 	}
 
+	exfat_chain_set(p_dir, ei->start_clu,
+			EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
+
 	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
 					num_entries, es)) < 0) {
 		if (dentry == -EIO)
@@ -386,14 +389,11 @@ static int exfat_find_empty_entry(struct inode *inode,
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
@@ -432,24 +432,19 @@ static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
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
@@ -471,7 +466,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	int clu_size = 0;
 	unsigned int start_clu = EXFAT_FREE_CLUSTER;
 
-	ret = exfat_resolve_path(inode, path, p_dir, &uniname);
+	ret = exfat_resolve_path(inode, path, &uniname);
 	if (ret)
 		goto out;
 
@@ -602,10 +597,13 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
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
@@ -1004,8 +1002,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 static int exfat_rename_file(struct inode *parent_inode,
-		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		struct exfat_inode_info *ei)
+		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
 	int ret, num_new_entries;
 	struct exfat_dentry *epold, *epnew;
@@ -1030,9 +1027,10 @@ static int exfat_rename_file(struct inode *parent_inode,
 
 	if (old_es.num_entries < num_new_entries) {
 		int newentry;
+		struct exfat_chain dir;
 
-		newentry = exfat_find_empty_entry(parent_inode, p_dir, num_new_entries,
-				&new_es);
+		newentry = exfat_find_empty_entry(parent_inode, &dir,
+				num_new_entries, &new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
 			goto put_old_es;
@@ -1056,7 +1054,7 @@ static int exfat_rename_file(struct inode *parent_inode,
 			goto put_old_es;
 
 		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
-		ei->dir = *p_dir;
+		ei->dir = dir;
 		ei->entry = newentry;
 	} else {
 		if (exfat_get_entry_type(epold) == TYPE_FILE) {
@@ -1075,12 +1073,12 @@ static int exfat_rename_file(struct inode *parent_inode,
 }
 
 static int exfat_move_file(struct inode *parent_inode,
-		struct exfat_chain *p_newdir, struct exfat_uni_name *p_uniname,
-		struct exfat_inode_info *ei)
+		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
 	int ret, newentry, num_new_entries;
 	struct exfat_dentry *epmov, *epnew;
 	struct exfat_entry_set_cache mov_es, new_es;
+	struct exfat_chain newdir;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1090,8 +1088,8 @@ static int exfat_move_file(struct inode *parent_inode,
 	if (ret)
 		return -EIO;
 
-	newentry = exfat_find_empty_entry(parent_inode, p_newdir, num_new_entries,
-			&new_es);
+	newentry = exfat_find_empty_entry(parent_inode, &newdir,
+			num_new_entries, &new_es);
 	if (newentry < 0) {
 		ret = newentry; /* -EIO or -ENOSPC */
 		goto put_mov_es;
@@ -1112,9 +1110,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
 	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
 
-	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
-		p_newdir->flags);
-
+	ei->dir = newdir;
 	ei->entry = newentry;
 
 	ret = exfat_put_dentry_set(&new_es, IS_DIRSYNC(parent_inode));
@@ -1135,7 +1131,6 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		struct dentry *new_dentry)
 {
 	int ret;
-	struct exfat_chain newdir;
 	struct exfat_uni_name uni_name;
 	struct super_block *sb = old_parent_inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -1179,19 +1174,16 @@ static int __exfat_rename(struct inode *old_parent_inode,
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
 		struct exfat_entry_set_cache es;
-- 
2.53.0

