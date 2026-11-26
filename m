Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658259;
	b=0QV8vO96uIeeMLxqJmyqAODCcvSbRZwMLk6nk6g8E4T9QyZuQ0hGmJu7dfmPMErO8yZL
	 VL75yUB8J54mwVoLcosLOUlgE0Vohl1BeSZt7uwv+tNb01ZSrBuXE6uC1BwlzwVuRzyUo
	 ffC8j/kXFrp/QevLh88eR2ZoCQJBCVC6ygOwH/d/iaafDHHC06G54xnbAoE5BPKjiPX0p
	 9F+acrMfBpALW29RRQNcenDo4EHF7wT7Y+ZZ3L1Alkhz3Wsd1YS6DntvxgWuNSBvrvQ5Q
	 LiNwlqW2++5Pid8RQdTowa8SnRkX/oAdMXuHYBPliWjJ3ghqRF4THRc/2cQt23V923w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658259;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QLi3ga4I43e/DNvr7Kiu5eUDhQrnreUSagAQxatHKIk=;
	b=kS2Y66fwlqNBBNQ8y/ncJUvwA2bulCHmwZWudlJtCBou56ongWRa6eo9GYcFDVb8vCen
	 CZV+pUUiEWlZWPtdIBd+OXwC/DkilTwbKQ4CdidKUyVD0FlhfdbET/WQnq0pRUNiVpL93
	 1zcWbZ+YXv+o++JfMhkC7S7TlEuLEnCtnLGZreB5hT6xtY54bsBdz2dcb9HdJY+EdwZhj
	 6xNND2G6WtaN4GBAyByX+R+j4jkXibiWm8MK0eo3etDejtERaA2QXkvq8lr4H/aRq2XKg
	 CeIMkY9cujexE8eh4vHkzR1rDcfrdGsdbStiVr8cgBsBwdxJUgDFU5z86lXcRj1PDXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pf+RqEfo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF3606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pf+RqEfo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB831F000C4;
	Thu, 26 Nov 2026 01:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658259;
	bh=QLi3ga4I43e/DNvr7Kiu5eUDhQrnreUSagAQxatHKIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pf+RqEfoq0W/MUttTTQrNBu+orTshcNj+zMkXz9Un35TnNJYAMrM+D9V7Dbd5SEjc
	 gNIas2v/piy1NRKloA/Y6nQ/1ZZeWPRzsNFH37Ea4kQ39JPqWhCOJ1UU71Pce5BnB0
	 LHfMXH2EWsbwtmXSlnNz493psBzQf/HK415AJaZrx2uA/6DN183919vIwWrvrcMntd
	 EUORnJzyDcdtLgfeShAvHrjtPEtLX07FZIJN3iSZE8pW5JoxOi596Gld4/biFJmlUa
	 EMe7hh0UzXSGQrfWSpJfkNYTcrED5YTxPkFq3/Oe/KWFakE6EqYDaLlTbqFXdPEkIE
	 lICHjPY6RvxAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] ovl: use wrapper ovl_revert_creds()
Date: Wed, 25 Nov 2026 20:57:34 -0500
Message-ID: <20261126015719.1731625-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112530-preplan-eldest-5662@gregkh>
References: <2026112530-preplan-eldest-5662@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit fc5a1d2287bf23f67da1fc7a178cf26c5e6ba9d0 ]

Introduce ovl_revert_creds() wrapper of revert_creds() to
match callers of ovl_override_creds().

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Stable-dep-of: 7031366be218 ("ovl: do not read the flags of a put upper dentry in lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/dir.c       | 10 +++++-----
 fs/overlayfs/file.c      | 14 +++++++-------
 fs/overlayfs/inode.c     | 20 ++++++++++----------
 fs/overlayfs/namei.c     | 10 +++++-----
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/readdir.c   |  8 ++++----
 fs/overlayfs/util.c      |  9 +++++++--
 fs/overlayfs/xattrs.c    |  9 ++++-----
 9 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 913e8adc9ea4e..432a6e08d16e1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1297,7 +1297,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0ff5b4b54e0e8..5426db632179a 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -627,7 +627,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		err = ovl_create_over_whiteout(dentry, inode, attr);
 
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
@@ -708,7 +708,7 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -918,7 +918,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1310,7 +1310,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else
@@ -1355,7 +1355,7 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 		fput(realfile);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 3a1f120b2af66..7ecbbf62f170b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -50,7 +50,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = backing_file_open(file,
 					     flags, realpath, current_cred());
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -214,7 +214,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	ret = vfs_llseek(fd_file(real), offset, whence);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	file->f_pos = fd_file(real)->f_pos;
 	ovl_inode_unlock(inode);
@@ -406,7 +406,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		ret = vfs_fsync_range(fd_file(real), start, end, datasync);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	fdput(real);
@@ -446,7 +446,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(fd_file(real), mode, offset, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file);
@@ -471,7 +471,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(fd_file(real), offset, len, advice);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	fdput(real);
 
@@ -544,7 +544,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file_out);
@@ -607,7 +607,7 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 	if (fd_file(real)->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		err = fd_file(real)->f_op->flush(fd_file(real), id);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 	fdput(real);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 4004edcd1fa85..bd15fd532f7d0 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -80,7 +80,7 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = ovl_do_notify_change(ofs, upperdentry, attr);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -280,7 +280,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -317,7 +317,7 @@ int ovl_permission(struct mnt_idmap *idmap,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -334,7 +334,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return p;
 }
 
@@ -469,7 +469,7 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 
 		old_cred = ovl_override_creds(inode->i_sb);
 		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	return acl;
@@ -498,7 +498,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		old_cred = ovl_override_creds(dentry->d_sb);
 		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
 				       acl_name);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -523,7 +523,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
 	else
 		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -600,7 +600,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -676,7 +676,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		err = ovl_set_protattr(inode, upperpath.dentry, fa);
 		if (!err)
 			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		ovl_drop_write(dentry);
 
 		/*
@@ -738,7 +738,7 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 86fab9f051b4f..5a6581fc19da6 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -969,7 +969,7 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
 
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
@@ -1003,7 +1003,7 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_err;
 
@@ -1358,7 +1358,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
 
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1382,7 +1382,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1439,7 +1439,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d96a2baf7620e..a18aacf106d84 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -439,6 +439,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+void ovl_revert_creds(const struct cred *old_cred);
 
 static inline const struct cred *ovl_creds(struct super_block *sb)
 {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index d102819622109..0c1344659adf9 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -291,7 +291,7 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -829,7 +829,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
@@ -889,7 +889,7 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	res = ovl_path_open(realpath, flags);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return res;
 }
@@ -1017,7 +1017,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root, NULL);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b8adda549c473..1d08393f35df9 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -68,6 +68,11 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
+void ovl_revert_creds(const struct cred *old_cred)
+{
+	revert_creds(old_cred);
+}
+
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.
@@ -1198,7 +1203,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_drop_write;
 
@@ -1223,7 +1228,7 @@ void ovl_nlink_end(struct dentry *dentry)
 
 		old_cred = ovl_override_creds(dentry->d_sb);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 6ba79ee00f737..c86f1a6c8b937 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -47,7 +47,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 		ovl_path_lower(dentry, &realpath);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (err < 0)
 			goto out;
 	}
@@ -72,7 +72,7 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 		WARN_ON(flags != XATTR_REPLACE);
 		err = ovl_do_removexattr(ofs, realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -91,7 +91,7 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 	ovl_i_path_real(inode, &realpath);
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return res;
 }
 
@@ -121,7 +121,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -268,4 +268,3 @@ const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *ofs)
 	return ofs->config.userxattr ? ovl_user_xattr_handlers :
 		ovl_trusted_xattr_handlers;
 }
-
-- 
2.53.0

