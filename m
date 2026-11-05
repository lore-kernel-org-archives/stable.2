Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848799;
	b=0DL459DhseYti01eDo3H1ioc7hn7eXALezBtEnubExemWEU4FuJsfuGYg+Lja8z5K5Sc
	 Ut7adn4lXi8vjOjv0CYL43lB4njMfH9400KB9LfPVBbtACa/tbby0bepH0A4tBst+htIz
	 iexeCKe0d/BWIpPmySlV3Cv7IYW+ZZibyNSoHYYw9kWj/62K+Vg4G+1Xs9zREPPuuRtER
	 jY3kNEF7g6QethDENusORD4F4js0uT3YuKSNdwBNdSdw57O2ilbhCum8oC7ic7tUhyxqi
	 yUZH4MxgciNhZXSjZDaSb5skj7s2wVilTAysA+k0iC8eYoDzZ0e3tSCviAkuHh6LucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Oc8k4hGLIflc7IZb0kKOCDHC6k1gEOvCvzgjAwBhcTg=;
	b=O/daTM8sfR8w4ztKd0otzbUsRsd9CRdLjMoNRff15qOWLRH6eicjvW3Yds+L70zh0lVH
	 UvKQZWdePQ2z0JAtIafeAXzw6JGlS6/i94zkraOghR3IFCJrUxvjrACJZm76Ztfeok7Us
	 Eog7NyIxqDdhIE4lGfomfowovTMyGH0YX3vkSH3OGNq1567iY0KLXBKyVCpEgsmvZac6C
	 NK6xdPMPxjflYcDZQE1rgt6IYRfKXyrPGYs09ipAdYDuCeUHY70DDZ7i/bfjMKulktSgc
	 RQvg3ROcK2IUIlO6vVh3GKY0vwARzcraS+5u1fkx99wDyEga5+QHRinYoW2Ie8wIlkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCO0CCRc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E896606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCO0CCRc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5031F00A16;
	Thu,  5 Nov 2026 03:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848799;
	bh=Oc8k4hGLIflc7IZb0kKOCDHC6k1gEOvCvzgjAwBhcTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCO0CCRc7P23LVf3JI0SXkdGpG/MlTMRQXJDFuo5jl2krIEcTNwqHrGNawRAcmSBf
	 LAQkuH44A7e/7g0fC8Kd+aC15BScmHaYXzwdRRW1UdAbbBeJBm6vALDhxqr6GOWCxU
	 wSSzAkeWXzx8gULYfOmB1CFK66Yx7IHnY7IGd3hbMM3oewrZ0hcwGMvFXyJqUiqbmq
	 InLfEyE0orO1OJriqclOjSG96+4ThPI3rbYIDQwW3Kv5CysxJb8iSBs2Qp0Tn9Uapm
	 hNG5EpvltLsofVU98NISV3/6pLmdxh6tgB9jSYl73GI8FTOV6xKHxEOZMX3qmvnBOC
	 kSArjvV4LuZYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: hold a reference on the parent in readdir
Date: Wed,  4 Nov 2026 22:19:57 -0500
Message-ID: <20261105031934.1229181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110447-freestyle-darn-5554@gregkh>
References: <2026110447-freestyle-darn-5554@gregkh>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit 16d319e12328acafeafd3eecdf09c46d7fb43452 ]

Listing a directory on an overlay uses a freed dentry and crashes the
kernel when a lookup moves the directory at the same time.

Code that can sleep may only use d_parent without a reference while
something stops a move of the dentry. ovl_iterate_real(),
ovl_need_adjust_d_ino() and ovl_cache_update() use the d_parent of the
listed directory and hold only the lock of that directory. When a
lookup finds the directory under another parent after a change to a
layer, d_splice_alias() moves it without that lock and drops its
reference on the old parent.

With a delay in ovl_iterate_real(), getdents64 on an overlay directory
raced a rename in the lower layer and a lookup that moved its dentry,
and after an rmdir of the old parent KASAN reported a use-after-free in
security_inode_getattr().

Fix this by using dget_parent() in the three functions.

Fixes: b5efccbe0a12 ("ovl: constant d_ino across copy up")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: fix comments in ovl_need_adjust_d_ino()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: moved parent reference handling into ovl_iterate() because ovl_need_adjust_d_ino() is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 07eda53d282f7..ecf30a8f3dcf0 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -476,8 +476,8 @@ static int ovl_cache_update_ino(const struct path *path, struct ovl_cache_entry
 			goto get;
 		}
 		if (p->len == 2 && p->name[1] == '.') {
-			/* we shall not be moved */
-			this = dget(dir->d_parent);
+			/* d_splice_alias() can move even a locked dir */
+			this = dget_parent(dir);
 			goto get;
 		}
 	}
@@ -697,6 +697,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	struct dentry *dir = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dir->d_sb);
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
+	struct dentry *parent;
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
 		.orig_ctx = ctx,
@@ -707,18 +708,26 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	if (rdt.xinobits && lower_layer)
 		rdt.fsid = lower_layer->fsid;
 
-	if (OVL_TYPE_MERGE(ovl_path_type(dir->d_parent))) {
+	/*
+	 * The lock on dir does not stop d_splice_alias() from moving it to
+	 * another parent, which drops the reference dir holds on this one.
+	 */
+	parent = dget_parent(dir);
+	if (OVL_TYPE_MERGE(ovl_path_type(parent))) {
 		struct kstat stat;
 		struct path statpath = file->f_path;
 
-		statpath.dentry = dir->d_parent;
+		statpath.dentry = parent;
 		err = vfs_getattr(&statpath, &stat, STATX_INO, 0);
-		if (err)
+		if (err) {
+			dput(parent);
 			return err;
+		}
 
 		WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
 		rdt.parent_ino = stat.ino;
 	}
+	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
 		rdt.cache = ovl_cache_get_impure(&file->f_path);
@@ -747,6 +756,8 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		ovl_dir_reset(file);
 
 	if (od->is_real) {
+		struct dentry *parent = dget_parent(dentry);
+
 		/*
 		 * If parent is merge, then need to adjust d_ino for '..', if
 		 * dir is impure then need to adjust d_ino for copied up
@@ -755,11 +766,12 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		if (ovl_xino_bits(ofs) ||
 		    (ovl_same_fs(ofs) &&
 		     (ovl_is_impure_dir(file) ||
-		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
+		      OVL_TYPE_MERGE(ovl_path_type(parent))))) {
 			err = ovl_iterate_real(file, ctx);
 		} else {
 			err = iterate_dir(od->realfile, ctx);
 		}
+		dput(parent);
 		goto out;
 	}
 
-- 
2.53.0

