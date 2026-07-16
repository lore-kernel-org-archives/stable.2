Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC123536B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200849; cv=none; b=MMmoyQj4u5nMXai9v/hITVthUmBh3NgIPqDc458cz5LSlOJL229Rlmofl+ZbhbBbFWa7Sm5pOJTosm2n29P6PXpx5bTxwdBrfCZPZCRvRpiEl9X3/LFawD16LcqJg3d19OUDo03FfDP9fEqQ3lRJJ2/3PePjczMw0m27EjgnCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200849; c=relaxed/simple;
	bh=tEgRpbNHvNcKL7vfEFVvvUQ1dgLC2lyqaIVdTwG/1Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RltmRWvPNT+Ig0ytc/FhXiBzxLbJcV5DYtctGI6xV0bdEvExivUdfClTQxaNaQxazFfRo58sTjLxWSb/Z3n2ZrMI/U3GPuFxIJgsLKsx6xylYj/FGfhGakcHHj+4VRX8XK9qmE8XgiCqAueB3krEgSSpGsBNMhCdE5+RaZGa0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP/RF+2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP/RF+2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BD01F00AC4;
	Thu, 16 Jul 2026 11:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784200848;
	bh=JBC83aBdLEl8NhZEVHK+H1SmSuUWNpfyQxo3PyqMwPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JP/RF+2fB6CUjHUSBMAxXf4jHiFK+ET70n8dY63OwiGxXKdFRaYfiMD4B1Ofu4B1x
	 d0ITTdfftFVW/yvPg/RUi4/V9jtlS5ZqzrZLC7sx/IQZdToWFneykuKzmjuCmrYAbX
	 6L/DDcTDfp1cYo6PN75KJblNLl2ZBGz1w8um/5mG7SJW2Ngr1CKadMlb5BBs7w7BZ4
	 VcL/TWjxC4vy/xKI6VpmrCLiSEAigRxjLjmhTF0eFxXBSorS5hq5gwM1dQEtwY12Im
	 evAx8j6JP3PUCSnk9DmNuOaIf3Jsr0TX/UmQej5dkc7pLBl69gfqD5DX9ZKmtCl6q8
	 K1oVZIMetLntA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Ornaghi <d.ornaghi97@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] ksmbd: fix path resolution in ksmbd_vfs_kern_path_create
Date: Thu, 16 Jul 2026 07:20:43 -0400
Message-ID: <20260716112043.1732826-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112043.1732826-1-sashal@kernel.org>
References: <2026071450-trespass-dispense-fb1b@gregkh>
 <20260716112043.1732826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Ornaghi <d.ornaghi97@gmail.com>

[ Upstream commit 1c8951963d8ed357f70f59e0ad4ddce2199d2016 ]

The SMB2 open lookup is rooted at the share with LOOKUP_BENEATH, but the
create/mkdir/hardlink sink is not: ksmbd_vfs_kern_path_create() builds an
absolute path with convert_to_unix_name() and resolves it from AT_FDCWD
via start_creating_path(), so a ".." component is walked from the real
filesystem root and escapes the export.

An authenticated client races a missing path component so the rooted open
lookup returns -ENOENT (taking the create branch) while the same component
is present (a directory) when the create walk runs; the create then
resolves ".." out of the share.

Root the create walk at the share like the lookup and rename paths already
are: resolve the parent with vfs_path_parent_lookup(..., LOOKUP_BENEATH,
&share_conf->vfs_path) and create the final component with
start_creating_noperm(). convert_to_unix_name() then has no callers and is
removed.

Fixes: 265fd1991c1d ("ksmbd: use LOOKUP_BENEATH to prevent the out of share access")
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/misc.c | 33 ---------------------------------
 fs/smb/server/misc.h |  1 -
 fs/smb/server/vfs.c  | 36 ++++++++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index cb2a11ffb23fe3..53ddcae31f7194 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -278,39 +278,6 @@ char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename)
 	return ksmbd_casefold_sharename(um, name);
 }
 
-/**
- * convert_to_unix_name() - convert windows name to unix format
- * @share:	ksmbd_share_config pointer
- * @name:	file name that is relative to share
- *
- * Return:	converted name on success, otherwise NULL
- */
-char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name)
-{
-	int no_slash = 0, name_len, path_len;
-	char *new_name;
-
-	if (name[0] == '/')
-		name++;
-
-	path_len = share->path_sz;
-	name_len = strlen(name);
-	new_name = kmalloc(path_len + name_len + 2, KSMBD_DEFAULT_GFP);
-	if (!new_name)
-		return new_name;
-
-	memcpy(new_name, share->path, path_len);
-	if (new_name[path_len - 1] != '/') {
-		new_name[path_len] = '/';
-		no_slash = 1;
-	}
-
-	memcpy(new_name + path_len + no_slash, name, name_len);
-	path_len += name_len + no_slash;
-	new_name[path_len] = 0x00;
-	return new_name;
-}
-
 char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				  const struct nls_table *local_nls,
 				  int *conv_len)
diff --git a/fs/smb/server/misc.h b/fs/smb/server/misc.h
index 1facfcd21200fd..53282a6d2436ca 100644
--- a/fs/smb/server/misc.h
+++ b/fs/smb/server/misc.h
@@ -22,7 +22,6 @@ void ksmbd_strip_last_slash(char *path);
 void ksmbd_conv_path_to_windows(char *path);
 char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name);
 char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
-char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name);
 
 #define KSMBD_DIR_INFO_ALIGNMENT	8
 struct ksmbd_dir_info;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 8c79ad55fe44d7..3346985c53b32a 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1309,15 +1309,39 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  unsigned int flags,
 					  struct path *path)
 {
-	char *abs_name;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct qstr last;
+	struct filename *filename;
 	struct dentry *dent;
+	int err;
 
-	abs_name = convert_to_unix_name(work->tcon->share_conf, name);
-	if (!abs_name)
-		return ERR_PTR(-ENOMEM);
+	/* resolve the name beneath the share root so ".." cannot escape */
+	filename = getname_kernel(name);
+	if (IS_ERR(filename))
+		return ERR_CAST(filename);
+
+	err = vfs_path_parent_lookup(filename, flags | LOOKUP_BENEATH,
+				     path, &last, &share_conf->vfs_path);
+	if (err) {
+		putname(filename);
+		return ERR_PTR(err);
+	}
 
-	dent = kern_path_create(AT_FDCWD, abs_name, path, flags);
-	kfree(abs_name);
+	err = mnt_want_write(path->mnt);
+	if (err) {
+		path_put(path);
+		putname(filename);
+		return ERR_PTR(err);
+	}
+
+	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
+	dent = lookup_one_qstr_excl(&last, path->dentry, LOOKUP_CREATE);
+	if (IS_ERR(dent)) {
+		inode_unlock(path->dentry->d_inode);
+		mnt_drop_write(path->mnt);
+		path_put(path);
+	}
+	putname(filename);
 	return dent;
 }
 
-- 
2.53.0

