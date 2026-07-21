Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC243E715E
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597305; cv=none; b=gxpucaaWvaG1mzA/o1h2yAih+vbr8nhPG5XZnPdzXYP2Mw+X3XlIcGGSxzYZNGq2KtBVL6oZ2wZIJT/UUHhulHThwBgBmShiEtr9+QzDavJAJ5PswebdsLUhyhdSA9WIijvUUiuhevki/2IAGUGUKQGUCXehr0EMO27ZNn9APiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597305; c=relaxed/simple;
	bh=5WU8key2DQppghnNHst4cTdcD80Tl9zgFZ55Oah7uyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1iYugaoCvx0L40FVoGRq5eApfaIm75qbC0EnnjqW4u7TMCDL38AKGbTGQI0XE4ZNAyor2o77eKqXKapIft31DLpgDFbfUCZ6stH5FN0ec+bOzHXz/yzXMRDAq6svJHG7IBL0yXeM+9qfB2pcdHn5T88bML+Zccmu+l80TZI5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjjQANbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjjQANbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9991F00A3E;
	Tue, 21 Jul 2026 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597304;
	bh=nhh6laXeQC9Dje9IGSpCynKPcCep9v3HjPn9PNAUbQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hjjQANbrhhhBZL+LF5KP29aQiWnhTo+rK8V7vbT1t/znwigFRfafIOuZiiJJT/krK
	 ojpa+YKxO6euC/ELaQu/y7/Tzbxxn1aSnNa7SLsCrraYLX5pYZQrFttY1SZ2KNnio0
	 Fr9Nug79ncGn3bf5hmT/EePdqWdgqEOY8jmJIvmpFNd71i0aJLgfMQwu601x7Fbp8b
	 BanUN3Jq24+4Jy93IXSGtzUPVDgObhmBhTPwuv62pt6JcAvfe8sQ/3iSDi/njpAK73
	 6NJTbqXUMC4W/uY2neMnTi9XdyUrgzuNt1hPKzvJJY47x3OkCfQl3xgTf292j5ow5X
	 wmo5ER/LEiR3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] exfat: rename argument name for exfat_move_file and exfat_rename_file
Date: Mon, 20 Jul 2026 21:28:17 -0400
Message-ID: <20260721012821.3459448-2-sashal@kernel.org>
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
 fs/exfat/namei.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 94ce344b5e855e..5f740e37825986 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1009,15 +1009,15 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
+static int exfat_rename_file(struct inode *parent_inode, struct exfat_chain *p_dir,
 		int oldentry, struct exfat_uni_name *p_uniname,
 		struct exfat_inode_info *ei)
 {
 	int ret, num_new_entries;
 	struct exfat_dentry *epold, *epnew;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache old_es, new_es;
-	int sync = IS_DIRSYNC(inode);
+	int sync = IS_DIRSYNC(parent_inode);
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
@@ -1037,7 +1037,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 	if (old_es.num_entries < num_new_entries) {
 		int newentry;
 
-		newentry = exfat_find_empty_entry(inode, p_dir, num_new_entries,
+		newentry = exfat_find_empty_entry(parent_inode, p_dir, num_new_entries,
 				&new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
@@ -1061,7 +1061,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		if (ret)
 			goto put_old_es;
 
-		exfat_remove_entries(inode, &old_es, ES_IDX_FILE);
+		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
 		ei->dir = *p_dir;
 		ei->entry = newentry;
 	} else {
@@ -1070,7 +1070,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
 
-		exfat_remove_entries(inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
+		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
 		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
 	}
 	return exfat_put_dentry_set(&old_es, sync);
@@ -1080,13 +1080,13 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 	return ret;
 }
 
-static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
+static int exfat_move_file(struct inode *parent_inode, struct exfat_chain *p_olddir,
 		int oldentry, struct exfat_chain *p_newdir,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
 	int ret, newentry, num_new_entries;
 	struct exfat_dentry *epmov, *epnew;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache mov_es, new_es;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
@@ -1098,7 +1098,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (ret)
 		return -EIO;
 
-	newentry = exfat_find_empty_entry(inode, p_newdir, num_new_entries,
+	newentry = exfat_find_empty_entry(parent_inode, p_newdir, num_new_entries,
 			&new_es);
 	if (newentry < 0) {
 		ret = newentry; /* -EIO or -ENOSPC */
@@ -1118,18 +1118,18 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	*epnew = *epmov;
 
 	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
-	exfat_remove_entries(inode, &mov_es, ES_IDX_FILE);
+	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
 
 	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
 		p_newdir->flags);
 
 	ei->entry = newentry;
 
-	ret = exfat_put_dentry_set(&new_es, IS_DIRSYNC(inode));
+	ret = exfat_put_dentry_set(&new_es, IS_DIRSYNC(parent_inode));
 	if (ret)
 		goto put_mov_es;
 
-	return exfat_put_dentry_set(&mov_es, IS_DIRSYNC(inode));
+	return exfat_put_dentry_set(&mov_es, IS_DIRSYNC(parent_inode));
 
 put_mov_es:
 	exfat_put_dentry_set(&mov_es, false);
-- 
2.53.0

