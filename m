Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD92171AF
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597305; cv=none; b=sAixrBcHCu+10Rv9iNPzC7f3Ge6jd7p2hNzxkIzRieeNQifKCrvNCq77Mp8aC7fd9oRjhlnxRa8r0LIyP+enlCaEardozd9Xyo0trm9kR6J0IIs85PVOAL/lvtrX9w9Z3nSWg5510c4sq1nO2nydmWJmFqsP02VuEpt9YgB4A7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597305; c=relaxed/simple;
	bh=ebdvVj+ZjIEY7m1tyY08tTC/1EQeqvP9a0hHnVJRcPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lePrmBypPdn+p19o33LJNvDzcR3Lc52IZMVb/qYnxTQGU6jU/w0ilkghcNYIrkxEwIvHf49O7OP9eXuP9D0bQoDHROh+y9NXxTqvOKtM8cr+KYVw7Ovokb3uZqs2WcIxQ1qOyAxkSg3G1zb0nmzYHQePbi9XKgh2zsRjfKmLkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6QB4PpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6QB4PpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2811F000E9;
	Tue, 21 Jul 2026 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597303;
	bh=2xBHXav16NciwheHdg3U4bEuDfILeGiT3LTGDRN6V54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6QB4PpWgaQ+slnAKRq9te6lfutS516g3YA5SY/JkTGSo/tzDAWuoFs/fyGT5E83o
	 t2+zp5qVmAKv1EvzVd8YAK2U9yuy3fZgGzbrLhEQN4o7evWMHic8vs8GPBnh62Jk5N
	 lGqmxjWefjIgYwKQK57olf+g/pAMxIP0/ml7MrPGoXok4bpMJGOitbL8w5VYjLZPo+
	 s4qL2iYa+A3sbpgNW6kJLT/BfgHMu1xhElo5dep5/EWsex3gX5BmYgt+BuLRHkg23J
	 sVjcsIekt2QoVZvODt5Fsx3SrIs6cBQKazvqqoi+lL8WRl+BXIp1ux4TVKQq9kzZUe
	 2cNKqO+lrLuLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/6] exfat: remove unnecessary read entry in __exfat_rename()
Date: Mon, 20 Jul 2026 21:28:16 -0400
Message-ID: <20260721012821.3459448-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071544-able-urology-c058@gregkh>
References: <2026071544-able-urology-c058@gregkh>
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
 fs/exfat/namei.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 44cce2544a7467..94ce344b5e855e 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1145,17 +1145,12 @@ static int __exfat_rename(struct inode *old_parent_inode,
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
 	struct exfat_inode_info *new_ei = NULL;
-	unsigned int new_entry_type = TYPE_UNUSED;
-	int new_entry = 0;
-	struct buffer_head *new_bh = NULL;
 
 	/* check the validity of pointer parameters */
 	if (new_path == NULL || strlen(new_path) == 0)
@@ -1181,17 +1176,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
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
@@ -1223,6 +1209,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 
 	if (!ret && new_inode) {
 		struct exfat_entry_set_cache es;
+		struct exfat_chain *p_dir = &(new_ei->dir);
+		int new_entry = new_ei->entry;
 
 		/* delete entries of new_dir */
 		ret = exfat_get_dentry_set(&es, sb, p_dir, new_entry,
@@ -1239,7 +1227,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 			goto del_out;
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR &&
+		if (S_ISDIR(new_inode->i_mode) &&
 		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
-- 
2.53.0

