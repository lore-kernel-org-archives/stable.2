Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3819E7F7
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197133; cv=none; b=rvvle75iiMJtaCMlWBEVFquypsrRLjQ6zIdLX/fvqg86uJr1KXdmzaiTSwtQy8INzAAYujJQ194YGlfyWhDsU+UeGBIwWTHIUb+rR1lW4IhoO+11u30b5pBgw9YUutpwtqPsyK2jOdYD6cukFE0YGbz5viGliJKw0Do+ZR9hjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197133; c=relaxed/simple;
	bh=i8iUZ03MhoflQ7se+fZr6o7+3t4XyMQJ+t9HIsRlT0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYke5MOy1knKILz86UQsG4dE1FgFF/RuQv7VYIgfym9f6ZaD2MRV8Dlp71VNd5hAlMXdyGqwoo0D6eJFpJtTpqqvYB2krvvPI3liJhmLe+GSEh/NnUGu8Y5t4p3Ak84iH3gICkR51A/LGIBaaFkpWNWE9WC6zWmYyd5FjSs9a8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft36y/Pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft36y/Pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2EE1F00A3A;
	Thu, 16 Jul 2026 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784197131;
	bh=cdcv84rB6skoOKanhi+xKmStkreqEwoMMuatm/lpVWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ft36y/PzrtCwtlfuKLx0V7lxN19ZBO4jrn4ej1KIcBGihW6YHdWMgzKUKUeFEHFJb
	 9w9onrB+wkEkhUKbrc89SGOLQ8oybxuaBROw/Yp1OFna5sUlHQCSvAkOxyHovwA8/8
	 9S52nyEaHSDcP5NOOWtOGpHHlDajHI4mdZqCyUtC4U/R49rFwjrNwl1djnFK4ASIUx
	 IcqKh9DAcDcZNjkep4oPn6bA0tZtkFBq8pLNbwfU/R+G8KCCgdU8N3X5eD4A0FT+PB
	 Hu3yyNVD63kID4r/tLzNkt1n9Yc0pEYAx6rKGdduHj5/RgKw5KyEt03ygrpmLMfXjk
	 5NvZMLZd9EwWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Ornaghi <d.ornaghi97@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: fix path resolution in ksmbd_vfs_kern_path_create
Date: Thu, 16 Jul 2026 06:18:49 -0400
Message-ID: <20260716101849.1464192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071458-clerk-silly-d22d@gregkh>
References: <2026071458-clerk-silly-d22d@gregkh>
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
[ replaced start_creating_noperm() and CLASS(filename_kernel) with open-coded getname_kernel()/inode_lock_nested()/lookup_one_qstr_excl() equivalents absent in 6.18 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/misc.c | 33 ---------------------------------
 fs/smb/server/misc.h |  1 -
 fs/smb/server/vfs.c  | 38 ++++++++++++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 40 deletions(-)

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
index 90e693e4e41497..c70c4670778de1 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1322,15 +1322,41 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  unsigned int flags,
 					  struct path *path)
 {
-	char *abs_name;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct filename *filename __free(putname) = NULL;
+	struct qstr last;
 	struct dentry *dent;
+	int err, type;
+
+	/* resolve the name beneath the share root so ".." cannot escape */
+	filename = getname_kernel(name);
+	if (IS_ERR(filename))
+		return ERR_CAST(filename);
+
+	err = vfs_path_parent_lookup(filename, flags | LOOKUP_BENEATH,
+				     path, &last, &type,
+				     &share_conf->vfs_path);
+	if (err)
+		return ERR_PTR(err);
+
+	if (unlikely(type != LAST_NORM)) {
+		path_put(path);
+		return ERR_PTR(-EINVAL);
+	}
 
-	abs_name = convert_to_unix_name(work->tcon->share_conf, name);
-	if (!abs_name)
-		return ERR_PTR(-ENOMEM);
+	err = mnt_want_write(path->mnt);
+	if (err) {
+		path_put(path);
+		return ERR_PTR(err);
+	}
 
-	dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
-	kfree(abs_name);
+	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
+	dent = lookup_one_qstr_excl(&last, path->dentry, LOOKUP_CREATE);
+	if (IS_ERR(dent)) {
+		inode_unlock(path->dentry->d_inode);
+		mnt_drop_write(path->mnt);
+		path_put(path);
+	}
 	return dent;
 }
 
-- 
2.53.0

