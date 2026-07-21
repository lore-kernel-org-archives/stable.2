Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A8481FBC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634469; cv=none; b=Q4/lNzcWS2XISrF6wHdrmXCMlCd/eAUskOvJrVJcL4jXi6eZFpVSP+uiMUz/CshbYNJaMYp4JEzo0Jb3K+Ev8GU3lVD3xqpRWvu9LAs6OP2//rh460hoYT5C0wVRNqlY8xUYaAcBpfJ1FCA1DCiJP+nkKXZLrr/ISjhi21ytk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634469; c=relaxed/simple;
	bh=tndQXubF0SnQgwUUAHl3yC9jz/SJv2siR86Smm9tuxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhfwsaM5VzGUf4EJRJGiInuBD6lFynN9QXcwBgVj+cgHXb1kYW3DCY3L/zOuL8YEynlTScnmvXKbj1o2LiCRhTxb9LWJBZ+bBzZWKvHDa6mWtBH7U7suqPUEnXSEURljupLROyH3ROCJuFg/AxakXlxjBt9RhKuVOPYN1c/8CZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/UQf7u3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/UQf7u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665EB1F000E9;
	Tue, 21 Jul 2026 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634468;
	bh=5Ko2/VwmnarZExuQsBmGrzsBeqMqQk8djJaQTxeTqQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/UQf7u3tZ7x9YTpEm0mTaFonAVql7j7VNci9BIJ0m0bs38ixxZKZCwAawTVepEMs
	 6MJQ14Epe7KQCFatHxDz07Ywn7JJYh2E5dr9jRCdcxWhwz1lM73wY5BZeRbhiSeZkm
	 Rx68S76rEp9TlgzCfN7vZ22g3pvdxQxAeE0KE8cpLgV/Gx3meVRbZMDgg41N2OBise
	 oHhI2dS5QEhPMt5+a39DgHlQdBMC2nllLxHIw/2PqdoZYHlA2YK3IXl6nc8bkM8E/B
	 XOIlQRHC27nonlJ6EqnytRZXtLcXvITxM7eUSOOExCuHoGuutdQBH3MlU4UsU630C6
	 wVIelc5CpWoUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/6] exfat: rename argument name for exfat_move_file and exfat_rename_file
Date: Tue, 21 Jul 2026 07:47:40 -0400
Message-ID: <20260721114743.3689685-3-sashal@kernel.org>
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

[ Upstream commit 06a2b0b3b490a6103376652c01c3ac6e8e22e654 ]

In this exfat implementation, the relationship between inode and ei
is ei=EXFAT_I(inode). However, in the arguments of exfat_move_file()
and exfat_rename_file(), argument 'inode' indicates the parent
directory, but argument 'ei' indicates the target file to be renamed.
They do not have the above relationship, which is not friendly to code
readers.

So this commit renames 'inode' to 'parent_inode', making the argument
name match its role.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 942296784b2a ("exfat: preserve benign secondary entries during rename and move")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/namei.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 7d8c3d481f641d..7c7fe9448475cf 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1015,15 +1015,15 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
+static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_dir,
 		int oldentry, struct exfat_uni_name *p_uniname,
 		struct exfat_inode_info *ei)
 {
 	int ret, num_old_entries, num_new_entries;
 	struct exfat_dentry *epold, *epnew;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = parent_inode->i_sb;
 	struct buffer_head *new_bh, *old_bh;
-	int sync = IS_DIRSYNC(inode);
+	int sync = IS_DIRSYNC(parent_inode);
 
 	epold = exfat_get_dentry(sb, p_dir, oldentry, &old_bh);
 	if (!epold)
@@ -1041,8 +1041,8 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 	if (num_old_entries < num_new_entries) {
 		int newentry;
 
-		newentry =
-			exfat_find_empty_entry(inode, p_dir, num_new_entries);
+		newentry = exfat_find_empty_entry(parent_inode, p_dir,
+				num_new_entries);
 		if (newentry < 0)
 			return newentry; /* -EIO or -ENOSPC */
 
@@ -1073,12 +1073,12 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		brelse(old_bh);
 		brelse(new_bh);
 
-		ret = exfat_init_ext_entry(inode, p_dir, newentry,
+		ret = exfat_init_ext_entry(parent_inode, p_dir, newentry,
 			num_new_entries, p_uniname);
 		if (ret)
 			return ret;
 
-		exfat_remove_entries(inode, p_dir, oldentry, 0,
+		exfat_remove_entries(parent_inode, p_dir, oldentry, 0,
 			num_old_entries);
 		ei->dir = *p_dir;
 		ei->entry = newentry;
@@ -1090,10 +1090,10 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		exfat_update_bh(old_bh, sync);
 		brelse(old_bh);
 
-		exfat_remove_entries(inode, p_dir, oldentry,
+		exfat_remove_entries(parent_inode, p_dir, oldentry,
 			ES_IDX_FIRST_FILENAME + 1, num_old_entries);
 
-		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
+		ret = exfat_init_ext_entry(parent_inode, p_dir, oldentry,
 			num_new_entries, p_uniname);
 		if (ret)
 			return ret;
@@ -1101,13 +1101,13 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 	return 0;
 }
 
-static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
+static int exfat_move_file(struct inode *parent_inode, struct exfat_chain *p_olddir,
 		int oldentry, struct exfat_chain *p_newdir,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
 	int ret, newentry, num_new_entries, num_old_entries;
 	struct exfat_dentry *epmov, *epnew;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = parent_inode->i_sb;
 	struct buffer_head *mov_bh, *new_bh;
 
 	epmov = exfat_get_dentry(sb, p_olddir, oldentry, &mov_bh);
@@ -1124,7 +1124,8 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (num_new_entries < 0)
 		return num_new_entries;
 
-	newentry = exfat_find_empty_entry(inode, p_newdir, num_new_entries);
+	newentry = exfat_find_empty_entry(parent_inode, p_newdir,
+			num_new_entries);
 	if (newentry < 0)
 		return newentry; /* -EIO or -ENOSPC */
 
@@ -1137,7 +1138,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 		ei->attr |= ATTR_ARCHIVE;
 	}
-	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
+	exfat_update_bh(new_bh, IS_DIRSYNC(parent_inode));
 	brelse(mov_bh);
 	brelse(new_bh);
 
@@ -1151,16 +1152,17 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	}
 
 	*epnew = *epmov;
-	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
+	exfat_update_bh(new_bh, IS_DIRSYNC(parent_inode));
 	brelse(mov_bh);
 	brelse(new_bh);
 
-	ret = exfat_init_ext_entry(inode, p_newdir, newentry, num_new_entries,
-		p_uniname);
+	ret = exfat_init_ext_entry(parent_inode, p_newdir, newentry,
+		num_new_entries, p_uniname);
 	if (ret)
 		return ret;
 
-	exfat_remove_entries(inode, p_olddir, oldentry, 0, num_old_entries);
+	exfat_remove_entries(parent_inode, p_olddir, oldentry, 0,
+		num_old_entries);
 
 	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
 		p_newdir->flags);
-- 
2.53.0

