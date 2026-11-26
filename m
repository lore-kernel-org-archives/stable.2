Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665290;
	b=w4fsc+uBVAFcwf2vseJoLOz1jiXh1FEKFVloWPUDjVX+kjHbLgYxt2bVFYZNt1suULf4
	 LLEmPCLr4LfYs+ltG1I6sz7oeezOMD7kvdWbMQ5eluTh6Gcwfa8Br+ISNKb2cV9FSKReH
	 AvgabYLrf+fok30jeCvvIsniTN8H4GIrR7xZG+CUs4kCHwuur8lYzGjf7lCfVF3YRk6qo
	 3ulMy+9FWQZdwRcar5ehuGDWuWtnLL8oHb7NkZPMIXyT2s7x1DMNoUlXAsVwmmr6m0Ngy
	 C6xoiup/eUEBW/NUSH7DextCiPsMWRhqrM46Qx2h/R3wIR03m1x1FvprXeghz2uhR5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NTbmHuZbu3eFwhykLEd2CF+FsGQLMkvupShYjHQ9y5w=;
	b=KiCHs47LMc3ZduA7j+VR64cCStXSE8rRXBeSCg87D6uCJ2vVKtK5xNE+anFVSVcnKITe
	 5n6YofLS5oWzFPKMFT8gg3fk3Hi8Xa8foREtbf3ZUuXWoeBqOCdndMQxG7rK5iIvX4haa
	 TVT6SKfCLqTU3kuYy/1ZIKOPdiOL/KpLEnO4CNjzHWUJ5K6T6mxTL83oX1fiLAmGjgdgv
	 yM+WcTVxSIxLGwG2Yey4xVyzBdY/FkI23Icx4IWdW0tXpt1Fv1OFiQr2Ttu4XYjSx5JzL
	 0JrU08v0N9JsG75fUwfnV73Yvst9nZAVfXPe3DoR8A9hWMhPaqpp4C0e2NMsHZeAvpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mzMs8/q8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E47606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzMs8/q8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B622C1F000C6;
	Thu, 26 Nov 2026 03:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665289;
	bh=NTbmHuZbu3eFwhykLEd2CF+FsGQLMkvupShYjHQ9y5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mzMs8/q8lzwt7a5Ohw9uegqLHD9XcfQZ2olnoL/YrufQIXWKoFhzRQbTHEckv0k64
	 hWRtBXMbSPpQ/G/hcYHdX1nIaEVDVLcVnjW8Q/CLSUgna0OMzfYySYQpqpx9YQWEFq
	 MikKIyuynIjlAEuxa6At+xsNsbnrJF7O/iG1qoD0KddKBdqzVWZYar0hGW+IZEmyfo
	 bQ6hJ56PvWpJBllNIRnMPeV1f413hhsqJE+vDc0o9N8INmrxY3ftQyDFnFbcnFdrlS
	 M5cd9LD8qdZJ50tIBHTo2I5ZJnGnhXxh7NtzJ5k7eUiAo8boknmd9UNaJHPXZ5tiQn
	 bSiOb59C6n/Ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giuseppe Scrivano <giuseppe@scrivano.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ovl: follow lower to lowerdata redirects from any lower layer
Date: Wed, 25 Nov 2026 22:54:47 -0500
Message-ID: <20261126035419.1698479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112513-encroach-july-9cbc@gregkh>
References: <2026112513-encroach-july-9cbc@gregkh>
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

From: Giuseppe Scrivano <giuseppe@scrivano.org>

[ Upstream commit cbf4ccabcbfdda3da70c10b37e21e99cd2ee0946 ]

Commit 5ef7bcdeecc9 ("ovl: relax redirect/metacopy requirements for lower
-> data redirect") allowed following redirects from a lower layer to a
data-only layer without redirect_dir=follow and metacopy=on, so that
data-only layers can be used with userxattr.

That fix was incomplete.  Without metacopy=on, a metacopy file with an
absolute redirect into a data-only layer is followed only from the lowest
lower layer.  From any other lower layer, the lookup fails with EPERM.

That commit also changed the behavior of redirect_dir=nofollow without
making it visible to users.  With data-only layers, some redirects are
followed, although the mount options show redirect_dir=nofollow, or
show nothing when that is the default.

Add redirect_dir=followdata, which follows only redirects from lower to
lowerdata, and select it when there are data-only layers, unless
redirect_dir=follow or redirect_dir=on is in effect, so the redirect
follow mode in effect is shown in /proc/self/mountinfo.

Without metacopy=on, the absolute redirect of a lower metacopy file stops
the lookup in the lower layers and the data is looked up in the data-only
layers.  Data-only layers cannot be used without following redirects,
so reject an explicit redirect_dir=nofollow with data-only layers.

Fixes: 5ef7bcdeecc9 ("ovl: relax redirect/metacopy requirements for lower -> data redirect")
Cc: stable@vger.kernel.org
Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261126014412.1696101-1-sashal@kernel.org>

 Documentation/filesystems/overlayfs.rst | 24 ++++++++-----
 fs/overlayfs/namei.c                    | 24 +++++++++++--
 fs/overlayfs/overlayfs.h                | 15 +++++++--
 fs/overlayfs/params.c                   | 45 ++++++++++++++++++++-----
 fs/overlayfs/params.h                   |  2 ++
 fs/overlayfs/super.c                    | 17 ++++++----
 6 files changed, 97 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 2d6202807fd1d..a478f6915b875 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -237,14 +237,19 @@ Module options (can also be changed through /sys/module/overlay/parameters/):
 Mount options:
 
 - "redirect_dir=on":
-    Redirects are enabled.
+    Redirects are created and followed.
 - "redirect_dir=follow":
     Redirects are not created, but followed.
+- "redirect_dir=followdata":
+    Redirects are not created.
+    Only redirects from lower to lowerdata are followed.
 - "redirect_dir=nofollow":
     Redirects are not created and not followed.
 - "redirect_dir=off":
-    If "redirect_always_follow" is enabled in the kernel/module config,
-    this "off" translates to "follow", otherwise it translates to "nofollow".
+    Redirects are not created.
+    Which redirects are followed depends on "redirect_always_follow" in the
+    kernel/module config, on data-only lower layers and on the "userxattr"
+    mount option.
 
 When the NFS export feature is enabled, every copied up directory is
 indexed by the file handle of the lower inode and a file handle of the
@@ -403,8 +408,8 @@ pointed by REDIRECT. This should not be possible on local system as setting
 "trusted." xattrs will require CAP_SYS_ADMIN. But it should be possible
 for untrusted layers like from a pen drive.
 
-Note: redirect_dir={off|nofollow|follow[*]} and nfs_export=on mount options
-conflict with metacopy=on, and will result in an error.
+Note: redirect_dir={off|nofollow|followdata|follow[*]} and nfs_export=on
+mount options conflict with metacopy=on, and will result in an error.
 
 [*] redirect_dir=follow only conflicts with metacopy=on if upperdir=... is
 given.
@@ -445,10 +450,11 @@ to the absolute path of the "lower data" file in the "data-only" lower layer.
 
 Instead of explicitly enabling "metacopy=on" it is sufficient to specify at
 least one data-only layer to enable redirection of data to a data-only layer.
-In this case other forms of metacopy are rejected.  Note: this way, data-only
-layers may be used together with "userxattr", in which case careful attention
-must be given to privileges needed to change the "user.overlay.redirect" xattr
-to prevent misuse.
+In this case other forms of metacopy are rejected.  A data-only layer selects
+"redirect_dir=followdata", unless "redirect_dir=follow" or "redirect_dir=on" is
+in effect.  Note: this way, data-only layers may be used together with
+"userxattr", in which case careful attention must be given to privileges needed
+to change the "user.overlay.redirect" xattr to prevent misuse.
 
 Since kernel version v6.8, "data-only" lower layers can also be added using
 the "datadir+" mount options and the fsconfig syscall from new mount api.
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 2c962a53cc59e..183dd987ed3c8 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1087,7 +1087,8 @@ static bool ovl_check_follow_redirect(struct ovl_lookup_data *d)
 		pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", d->dentry);
 		return false;
 	}
-	if ((d->redirect || d->upperredirect) && !ovl_redirect_follow(ofs)) {
+	/* Check follow to lower layer, redirects to lowerdata are not checked here */
+	if ((d->redirect || d->upperredirect) && !ovl_redirect_follow_lower(ofs)) {
 		pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", d->dentry);
 		return false;
 	}
@@ -1105,13 +1106,26 @@ struct ovl_lookup_ctx {
 	unsigned int ctr;
 };
 
+/*
+ * Without metacopy=on, the absolute redirect of a lower metacopy file is
+ * followed only into the data-only layers.
+ */
+static bool ovl_is_lowerdata_redirect(struct ovl_lookup_ctx *ctx,
+				      struct ovl_lookup_data *d)
+{
+	struct ovl_fs *ofs = OVL_FS(d->sb);
+
+	return ofs->numdatalayer && !ofs->config.metacopy && ctx->ctr &&
+	       d->metacopy && d->absolute_redirect;
+}
+
 static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data *d)
 {
 	struct dentry *dentry = ctx->dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	struct ovl_entry *roe = OVL_E(dentry->d_sb->s_root);
-	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
+	bool check_redirect = ovl_redirect_follow(ofs);
 	struct dentry *upperdir;
 	struct dentry *this;
 	struct dentry *origin = NULL;
@@ -1242,6 +1256,10 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 			ctx->ctr++;
 		}
 
+		/* Lookup of lowerdata in the data-only layers only */
+		if (ovl_is_lowerdata_redirect(ctx, d))
+			d->stop = true;
+
 		if (d->stop)
 			break;
 
@@ -1411,7 +1429,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
-	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
+	bool check_redirect = ovl_redirect_follow(ofs);
 	int err;
 	struct ovl_lookup_ctx ctx = {
 		.dentry = dentry,
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c3a0eb0bfd1f0..f0a61663ce169 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -75,11 +75,13 @@ enum ovl_entry_flag {
 
 enum {
 	/*
-	 * "off" mode is never used after mount options are verified. In effect
-	 * it translates to either "follow" or "nofollow".
+	 * "off" mode is never used after mount options are verified.
+	 * In effect it translates to either "follow", "nofollow" or
+	 * "followdata" (with data-only layers).
 	 */
 	OVL_REDIRECT_OFF,
 	OVL_REDIRECT_FOLLOW,
+	OVL_REDIRECT_FOLLOWDATA,
 	OVL_REDIRECT_NOFOLLOW,
 	OVL_REDIRECT_ON,
 };
@@ -632,11 +634,20 @@ static inline char ovl_get_opaquedir_val(struct ovl_fs *ofs,
 	return ovl_get_dir_xattr_val(ofs, path, OVL_XATTR_OPAQUE);
 }
 
+/* Are redirects followed into lower layers? */
+static inline bool ovl_redirect_follow_lower(struct ovl_fs *ofs)
+{
+	return ofs->config.redirect_mode == OVL_REDIRECT_FOLLOW ||
+	       ofs->config.redirect_mode == OVL_REDIRECT_ON;
+}
+
+/* Are redirects followed into lower or lowerdata layers? */
 static inline bool ovl_redirect_follow(struct ovl_fs *ofs)
 {
 	return ofs->config.redirect_mode != OVL_REDIRECT_NOFOLLOW;
 }
 
+/* Are redirects created in upper dir? */
 static inline bool ovl_redirect_dir(struct ovl_fs *ofs)
 {
 	return ofs->config.redirect_mode == OVL_REDIRECT_ON;
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 588a50e333404..486e10cec31fb 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -107,6 +107,7 @@ static int ovl_xino_def(void)
 const struct constant_table ovl_parameter_redirect_dir[] = {
 	{ "off",	OVL_REDIRECT_OFF      },
 	{ "follow",	OVL_REDIRECT_FOLLOW   },
+	{ "followdata",	OVL_REDIRECT_FOLLOWDATA },
 	{ "nofollow",	OVL_REDIRECT_NOFOLLOW },
 	{ "on",		OVL_REDIRECT_ON       },
 	{}
@@ -117,21 +118,29 @@ static const char *ovl_redirect_mode_name(int redirect_mode)
 	return ovl_parameter_redirect_dir[redirect_mode].name;
 }
 
-static const char *ovl_redirect_mode(struct ovl_config *config)
+const char *ovl_redirect_mode(struct ovl_config *config)
 {
 	return ovl_redirect_mode_name(config->redirect_mode);
 }
 
-static int ovl_redirect_follow_mode(void)
+int ovl_redirect_follow_mode(bool follow_lower, size_t nr_data)
 {
-	return ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
-					    OVL_REDIRECT_NOFOLLOW;
+	if (ovl_redirect_always_follow && follow_lower)
+		return OVL_REDIRECT_FOLLOW;
+
+	/* Data-only layers cannot be used without following redirects to them */
+	return nr_data ? OVL_REDIRECT_FOLLOWDATA : OVL_REDIRECT_NOFOLLOW;
 }
 
+/*
+ * The default for show_options() is resolved as if there are no data-only layers,
+ * so that redirect_dir=followdata, which is auto selected with data-only layers,
+ * is displayed in mount options.
+ */
 static int ovl_redirect_mode_def(void)
 {
 	return ovl_redirect_dir_def ? OVL_REDIRECT_ON :
-				      ovl_redirect_follow_mode();
+				      ovl_redirect_follow_mode(true, 0);
 }
 
 static const struct constant_table ovl_parameter_verity[] = {
@@ -887,6 +896,9 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 	struct ovl_opt_set set = ctx->set;
 	/* The requested redirect_dir=, for reporting conflicts with it */
 	int redirect_opt = config->redirect_mode;
+	/* The redirect follow mode for redirect_dir=off and for the default */
+	int follow_mode = ovl_redirect_follow_mode(!config->userxattr,
+						   ctx->nr_data);
 
 	/* Workdir/index are useless in non-upper mount */
 	if (!config->upperdir) {
@@ -913,9 +925,12 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		config->uuid = OVL_UUID_NULL;
 	}
 
-	/* Resolve redirect_dir=off to the default redirect follow mode */
+	/*
+	 * Resolve redirect_dir=off to the default redirect follow mode.
+	 * With userxattr, redirects are not followed to lower by default.
+	 */
 	if (config->redirect_mode == OVL_REDIRECT_OFF)
-		config->redirect_mode = ovl_redirect_follow_mode();
+		config->redirect_mode = follow_mode;
 
 	/*
 	 * This is to make the logic below simpler.  It doesn't make any other
@@ -1012,7 +1027,8 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 	/* Resolve userxattr -> !redirect && !metacopy dependency */
 	if (config->userxattr) {
 		if (set.redirect &&
-		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
+		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW &&
+		    config->redirect_mode != OVL_REDIRECT_FOLLOWDATA) {
 			pr_err("conflicting options: userxattr,redirect_dir=%s\n",
 			       ovl_redirect_mode_name(redirect_opt));
 			return -EINVAL;
@@ -1027,10 +1043,21 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		 * options must be explicitly enabled if used together with
 		 * userxattr.
 		 */
-		config->redirect_mode = OVL_REDIRECT_NOFOLLOW;
+		if (!set.redirect)
+			config->redirect_mode = follow_mode;
 		config->metacopy = false;
 	}
 
+	/* Data-only layers are reached through redirects */
+	if (ctx->nr_data && config->redirect_mode == OVL_REDIRECT_NOFOLLOW) {
+		pr_err("redirect_dir=nofollow is not supported with data-only layers\n");
+		return -EINVAL;
+	}
+	if (!ctx->nr_data && config->redirect_mode == OVL_REDIRECT_FOLLOWDATA) {
+		pr_err("redirect_dir=followdata requires data-only layers\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Fail if we don't have trusted xattr capability and a feature was
 	 * explicitly requested that requires them.
diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
index ffd53cdd84827..3a514a21b14c4 100644
--- a/fs/overlayfs/params.h
+++ b/fs/overlayfs/params.h
@@ -42,3 +42,5 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			 struct ovl_config *config);
 int ovl_show_options(struct seq_file *m, struct dentry *dentry);
 const char *ovl_xino_mode(struct ovl_config *config);
+const char *ovl_redirect_mode(struct ovl_config *config);
+int ovl_redirect_follow_mode(bool follow_lower, size_t nr_data);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f1c2509258f6d..251a28b044c18 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -684,7 +684,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 }
 
 static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
-			    const struct path *workpath)
+			    const struct path *workpath, size_t nr_data)
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
 	struct dentry *workdir;
@@ -748,9 +748,11 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	if (err) {
 		pr_warn("failed to set xattr on upper\n");
 		ofs->noxattr = true;
-		if (ovl_redirect_follow(ofs)) {
-			ofs->config.redirect_mode = OVL_REDIRECT_NOFOLLOW;
-			pr_warn("...falling back to redirect_dir=nofollow.\n");
+		if (ovl_redirect_follow_lower(ofs)) {
+			ofs->config.redirect_mode =
+				ovl_redirect_follow_mode(false, nr_data);
+			pr_warn("...falling back to redirect_dir=%s.\n",
+				ovl_redirect_mode(&ofs->config));
 		}
 		if (ofs->config.metacopy) {
 			ofs->config.metacopy = false;
@@ -827,7 +829,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
 			   const struct path *upperpath,
-			   const struct path *workpath)
+			   const struct path *workpath, size_t nr_data)
 {
 	int err;
 
@@ -856,7 +858,7 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	if (err)
 		return err;
 
-	return ovl_make_workdir(sb, ofs, workpath);
+	return ovl_make_workdir(sb, ofs, workpath, nr_data);
 }
 
 static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
@@ -1510,7 +1512,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 			}
 		}
 
-		err = ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work);
+		err = ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work,
+				      ctx->nr_data);
 		if (err)
 			goto out_err;
 
-- 
2.53.0

