Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847049;
	b=ILjIGSflQK01C5MSg1jg/yuSi83wTsNCRj/YKb2u6iXdt3xSo/ZF16bHUmZuQ3PoRUnD
	 F8lopjmrqgUtIaX89K9QmVHtCDPWNmNFDVwMEUdRmm57LfB+Rs8XcikXKoTGGzvM8g6YM
	 OO9vL3FhybXJsWuvb/y6VEVBpf9uvL65q9JfTm3OXFP6/qpSlHMT1IJqAzEXYQHf1Z8uv
	 eRfhUKfTqyNMFUIwrl48zTEO9YCy9LqUwMEMKmqne5/zU3A2fbBO8kXbhkPJEBq2aBrlt
	 U8hZaYumrY8BmRkQrzTBZG2j5LBX/Unv/FGP0bFP+17AB6HFjh3kT8/Yn/czAXUiHxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WlXkgzSFo97d+EE1tcEaAf9ubrlzniSAikJOt+S5mmY=;
	b=YsrIAMJU03ZHYC+ZPJ04J/I8f2tHTwyN9WDxaoR/wVsIPoiMsSX749pytA9/8DhxYYQx
	 IVQTqifKjTuRkaxTR1NV7axRi8kUBAXAuULNAFo4J/MHdX6gikl1mDCZND/cURVsTQkye
	 HOJ0xza3Sl5H5CS54LOT5Gf+C6xZ5U7kbtsQ+wMU6ki9qgoTP7DjBrKLvy9Hv79wmoMPW
	 3Y9ygeiJ04u9MliJE1RmpvO7mXFX6XZ8odDiCMQ4UziSO1Fjx7N6QwqAkEAZ6NHtu9LYP
	 XMkSVcDL+IrcI677zGJThRAoEM7CGGuiLD0sUEk+QuV/0oMdxgoCOEiFFG6LLZbqw0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ukj9Bos4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010A606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ukj9Bos4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0D41F000C1;
	Thu,  5 Nov 2026 02:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847048;
	bh=WlXkgzSFo97d+EE1tcEaAf9ubrlzniSAikJOt+S5mmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ukj9Bos4hHLK45d0G5LbaaV8IZ+tYDaJR+pe3gH5b9rJHDnJQ76WBSwpXDW9Fbu8g
	 RiN1zRSvBam4rZunnpjFoazmn4NLR2fTx7c4yPU39v4nVFhZEZNy+NmYT6bLctbfUC
	 zcVBuLPLq/X0ti/XZ3BunnqNMTohpEoXEx5xJOgwbrnEyPZW1I9DVaOAcKwBI3wXeW
	 qprI33IXonD0KC0LttmGS66ngZetzz0vLKd2pSnZ5jWgU/Z/rJ29LWRUhpE037Y0LO
	 62LYsqrl/N+9VJmpefo180nWYPhA3sXsZxlPVWQ5QFyQUhGv+MJLi6vReYg58qd1h4
	 watWkge4h50vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ovl: hold a reference on the parent in readdir
Date: Wed,  4 Nov 2026 21:50:46 -0500
Message-ID: <20261105025023.1204346-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110447-widen-reunite-2c7b@gregkh>
References: <2026110447-widen-reunite-2c7b@gregkh>
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
[ sashal: Applied the changes for the absent ovl_need_adjust_d_ino() helper directly to the inline logic in ovl_iterate(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 6931cbc1042c3..56425b369560d 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -486,8 +486,8 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
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
@@ -711,6 +711,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	struct dentry *dir = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dir->d_sb);
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
+	struct dentry *parent;
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
 		.orig_ctx = ctx,
@@ -721,18 +722,26 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
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
@@ -761,6 +770,8 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		ovl_dir_reset(file);
 
 	if (od->is_real) {
+		struct dentry *parent = dget_parent(dentry);
+
 		/*
 		 * If parent is merge, then need to adjust d_ino for '..', if
 		 * dir is impure then need to adjust d_ino for copied up
@@ -769,11 +780,12 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
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

