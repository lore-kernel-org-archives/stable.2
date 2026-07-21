Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0744439328
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634468; cv=none; b=rH7G3c79+WoFKC4gz2nBiKgxyYpJWou0rq28mk+ITN9Zqqa5Og+kGfePd2+258B3T+lLcKOe8Yv5nB4k74nn8aKdOARYsOTtYA5JGJhPm2lRoCjEbYew1v3TQ1SzoUi6yr1ZmCmVrKkQtcflofyjvIMDcPv2cFSWWcbXeAY7EGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634468; c=relaxed/simple;
	bh=gbifNQnj0aJiuvEERdiwkluSkwIXLJyldot7Mfud2jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1WK8mKADXAewidtHmMBMDrJ53cmOAU9YI9hbNQqFDsYqnhn5YCnR/v7zcc1n2iuksvuiaSdmoszua+k9o1yeJGSp9bULFb+bK2Y1or70pRjO2HLRB2sec1J0qE9JC7zY1O3LhXKJxsSxeIKjD803VMVSINggtbg97hVZ4mfgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1PcGk6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1PcGk6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7C51F00A3F;
	Tue, 21 Jul 2026 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634467;
	bh=SvU7AqNx60z4mlAyZNbKoJvKjhonlyNf5n44wyeqL0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1PcGk6lY3z9/oNXp8cVR0gP/7ONX16jL5iQcYPPjCdJjDtAU3tMwyN4m/LgJW7Iz
	 mxcC96HfGv1j/maBFs6q7bKdJWvYP+qN7x0yfTlI/iLGMhHNo7eJPl7L5xFTZ9T0pS
	 5b01xjCZN2xbr0a4dgHZhWfapM/DxR34Bfp5hs4HzoMGwdghO7vvWcBiZm5/QANrr3
	 +jxSf/SopdbwbxWiHnIWOBjjtzEp8N/FQ3JRCqtdM8rRRyQif2IWIkgbxRXIZS+Zeu
	 ak8I3QalLglP+Fqyr3Mmb2+dNeyss2EXYS5TKhaXM2Qac4rxGMeHuQFbVLztkvFzlI
	 G9l6Ke6Vaw6Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] exfat: remove unnecessary read entry in __exfat_rename()
Date: Tue, 21 Jul 2026 07:47:39 -0400
Message-ID: <20260721114743.3689685-2-sashal@kernel.org>
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

[ Upstream commit 30ef0e0d7ff5b6dceda19d18a85d9d72a4909784 ]

To determine whether it is a directory, there is no need to read its
directory entry, just use S_ISDIR(inode->i_mode).

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 942296784b2a ("exfat: preserve benign secondary entries during rename and move")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/namei.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 53fc0c26865deb..7d8c3d481f641d 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1177,18 +1177,13 @@ static int __exfat_rename(struct inode *old_parent_inode,
 	int ret;
 	int dentry;
 	struct exfat_chain olddir, newdir;
-	struct exfat_chain *p_dir = NULL;
 	struct exfat_uni_name uni_name;
-	struct exfat_dentry *ep;
 	struct super_block *sb = old_parent_inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	const unsigned char *new_path = new_dentry->d_name.name;
 	struct inode *new_inode = new_dentry->d_inode;
 	int num_entries;
 	struct exfat_inode_info *new_ei = NULL;
-	unsigned int new_entry_type = TYPE_UNUSED;
-	int new_entry = 0;
-	struct buffer_head *new_bh = NULL;
 
 	/* check the validity of pointer parameters */
 	if (new_path == NULL || strlen(new_path) == 0)
@@ -1214,17 +1209,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 			goto out;
 		}
 
-		p_dir = &(new_ei->dir);
-		new_entry = new_ei->entry;
-		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh);
-		if (!ep)
-			goto out;
-
-		new_entry_type = exfat_get_entry_type(ep);
-		brelse(new_bh);
-
 		/* if new_inode exists, update ei */
-		if (new_entry_type == TYPE_DIR) {
+		if (S_ISDIR(new_inode->i_mode)) {
 			struct exfat_chain new_clu;
 
 			new_clu.dir = new_ei->start_clu;
@@ -1255,6 +1241,11 @@ static int __exfat_rename(struct inode *old_parent_inode,
 				&newdir, &uni_name, ei);
 
 	if (!ret && new_inode) {
+		struct exfat_chain *p_dir = &(new_ei->dir);
+		int new_entry = new_ei->entry;
+		struct exfat_dentry *ep;
+		struct buffer_head *new_bh = NULL;
+
 		/* delete entries of new_dir */
 		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh);
 		if (!ep) {
@@ -1276,7 +1267,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR &&
+		if (S_ISDIR(new_inode->i_mode) &&
 		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
-- 
2.53.0

