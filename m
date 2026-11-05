Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881247;
	b=pDCSyFeHK3mQV2CWJhuVAP6ppenyVCh5ZTbaeqgr/wfmPFfiT6tUTdkaa99lomSruJFu
	 n00jiix7/LXWyc7ORxL53+BgI4oBHDyM4wEfxdNGxKQx9pgrcfWWrQZZ0XAn+6E2YDba2
	 VwsUrJuPc5RGeRpOPM16+BskzQf3uqhJqmYn+0KrCes0yebmkTJOL0lbe9MJlXvqeKOXq
	 SCgiMMMAa3st94EPSpJJjeYHR4+MI3pETJW0V4agKrL44qQhmNer6XoaaryAcI5YDt1Ts
	 NQGpX+KG0U9ZG5bGbYUq5B/AtXoGPdJ6XHRtNa5A35M64k2B/uMAYufP/uYju+cpT5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2DqK50qOegGS2WP+VoAn0rftI92eyvVx/YD+jbbwuYo=;
	b=Z+KpF3OLsbUf+y1I+LHT5rVB8z61M4OkGBkIIxtG/ZcyVzRnIcsD9n8I8kNzfPdI1VU/
	 cGQ6j3uZjPtZ6oAThtrsx4Pfs0c4fpJwsRtBbsPiY+W/mZpRdarnzi0ZajfewJxwcfQG+
	 qsKJObnpHJBji/lpr5MV1MJn0/ccjhQE5bcieUDFsQhfgh/RfvkQQUB4XZKZB99dEidyK
	 +5B1iVxyeqWbgibSWDReHolBbsUPjqG1GcKJEkN+dQ3JBiYQ4OTsgT/3F7KsVrA9qzgzB
	 ZqC1l3wlaNNXnVKQ1rT1s+785QaZ+/egmEHsnobMV++0JLMZlPzOBVrtN8Ftw6v9SOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LlA/DLDq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36375606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlA/DLDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB821F000C1;
	Thu,  5 Nov 2026 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881247;
	bh=2DqK50qOegGS2WP+VoAn0rftI92eyvVx/YD+jbbwuYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LlA/DLDqVPT1I7o2bJB09mUtT2B6UnYhNg4pA/6pS0YPlSlGqGwoURPRpRTZnkzEc
	 q8dvebbAOzg2PLeOrVn0QyxF2f2NIn4BcbMlB3xabl9nOohdohwcITPYaWWGtCLVRq
	 B3seCOGdaZGeRO319mK8QqSWdJcmj0VX3m8lTX2MSVUfoPyLd3noBqrJUKycODHeKH
	 v9yUJ8+x8Az3uhFZP6zJ4ohMqDfAlZZ/A5/og6HYe2DK1tDtk5Kr9WRms/mQRh3Q9D
	 cXX7gPC729aOtvwvVOtsnSQLuLzrUrXTI6qPI8zWRo7/qJbKcGHm1Soevs4BEOzZ+T
	 gGBNruyNpB7Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: hold a reference on the parent in readdir
Date: Thu,  5 Nov 2026 07:20:45 -0500
Message-ID: <20261105121917.1276549-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110448-rebuild-overpower-e0e1@gregkh>
References: <2026110448-rebuild-overpower-e0e1@gregkh>
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
[ sashal: adapted ovl_need_adjust_d_ino() changes to the inline logic in ovl_iterate() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 666cc62578f65..75e47ef3c7118 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -474,8 +474,8 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
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
@@ -693,6 +693,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	struct ovl_dir_file *od = file->private_data;
 	struct dentry *dir = file->f_path.dentry;
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
+	struct dentry *parent;
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
 		.orig_ctx = ctx,
@@ -703,18 +704,26 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
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
@@ -742,6 +751,8 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		ovl_dir_reset(file);
 
 	if (od->is_real) {
+		struct dentry *parent = dget_parent(dentry);
+
 		/*
 		 * If parent is merge, then need to adjust d_ino for '..', if
 		 * dir is impure then need to adjust d_ino for copied up
@@ -750,11 +761,12 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		if (ovl_xino_bits(dentry->d_sb) ||
 		    (ovl_same_fs(dentry->d_sb) &&
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

