Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448810;
	b=YNw9k3EiSFAvLwLFa6LW6ZMldQIUaGNE/qzT3+kKX42UFEPHQnV1M3HMMNCbBENHgpL8
	 OBrLpzfYsOkBuh4oy4PKPMwv899TKZD57T2N6nFHpCrjXQRwNv5dR1c9RsWxf4NCELz7G
	 xSrqNszwXSJbJUfsYvh5xNTbVizcd9TXCxhmLY4oDl21m5nU68b95gQygeKn45Z/H2uKH
	 U6XyFXAmFGm9oyMqhs07qu7Lqim1faTNxo1EV5z9MYu8LO+tnmjX7rDE+kbtPQm2v2Yij
	 RW9P93B+XVBUHxbRCw5STLRnXu9nfRrslh0YMHerm9HkgXE95WFXBuqPvrmr1iim1Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5Eyu9Xsx70tqsAXJxCLO/4bq/yOmJ1pQyquaw8D0kU4=;
	b=sBSlu53gRQkWy0bS9PcvaROGjAuEZLKC8OtM21e0LxeAZMUg5tRQux1bDR6ddYbRYPom
	 pA9ID1idXT9avA8RHIUziJUCZEfaW8tGzmQbmN1sXJzKTjfDCP4ZRe2CiRfIej1dAfMbk
	 1oXOpxjZJTCaVUdisXC/zwtggAmLVjBJL4xZSDWoJSQDagrGx4Ch42DEuYKWhzmT+UOKY
	 QpaziZS8tyay9urGVmEmUPvOwl+nG9ybnSSVkZ+FoQuGALLJT1lU2ypzT9KpcXPvqteHN
	 buqoAL/wCnSMCodoj7XRwID8al6/Bv5UMUkUrQuTMNciN1X8B0WLQWXro0V+bYjbMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRp0keGO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514D606A8A4
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRp0keGO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3401F00A05;
	Thu, 12 Nov 2026 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448810;
	bh=5Eyu9Xsx70tqsAXJxCLO/4bq/yOmJ1pQyquaw8D0kU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRp0keGOGDuXNEUx9E30eca7cMXqa4g71nvp36rRL5bYQjTh73n7DeXUDyHI4Y9+o
	 mds9IRqzY29MUYJreDeOnFQgVwwlVhQe84N7mfuH95H+99rqmWf+IMSUtvJkL+DdFd
	 DzkjKtciFuzTykusSpkcRf/gvbRFa/AfJZy/Gp8oJElKhAK++hc3nkIeWRBC3d5b52
	 HQ1h6t1icHzre22+2mIcXxiwp5EC6JcEn/rp45XVswM1l175ZMmJmDaym0dRM6PN/G
	 /OBv9nKM2DMixaLTeW1mi7I0fj4Cgdc08dPehv6YezQJSHGXpZZT35kedZMPEVCp9F
	 wGQtotbM/L40g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ovl: inherit FMODE_NONOTIFY when opening directory realfiles
Date: Wed, 11 Nov 2026 21:00:07 -0500
Message-ID: <20261112015754.1242132-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112015754.1242132-1-sashal@kernel.org>
References: <20261109200528-failed-6.18-323899b4ed23@kernel.org>
 <20261112015754.1242132-1-sashal@kernel.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 323899b4ed233d5b6e2fc160c16fbf39cf0317da ]

When fanotify hands a listener an fd for a permission event on an
overlay directory, ovl_dir_open_realfile() opens the real directory via
dentry_open(), not backing_file_open(), so the lower open could still
raise FS_OPEN_PERM and deadlock a listener that also marks the backing
filesystem.

Export dentry_open_nonotify() and call it from ovl_path_open_realfile()
when the overlay user file must not generate events.  Ordinary
ovl_path_open() callers are unchanged.

Reported-by: Christian Brauner (Amutable) <brauner@kernel.org>
Closes: https://lore.kernel.org/all/20261030-welpen-anbinden-nullen-b2432cee1d10@brauner/
Fixes: 130fdbc3d1f99 ("ovl: pass correct flags for opening real directory")
Cc: stable@vger.kernel.org
Tested-by: Edvard Conrad <edvard@tuta.io>
Link: https://lore.kernel.org/ltp/P5Iny41--F-9@tuta.io/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c                |  1 +
 fs/overlayfs/overlayfs.h |  9 ++++++++-
 fs/overlayfs/readdir.c   |  3 ++-
 fs/overlayfs/util.c      | 11 ++++++++++-
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc675..3d5ff8f58d5c9 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1143,6 +1143,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 	}
 	return f;
 }
+EXPORT_SYMBOL_GPL(dentry_open_nonotify);
 
 /**
  * dentry_create - Create and open a file
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6268db46483e7..7bd69773f33c9 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -524,7 +524,14 @@ void ovl_dir_modified(struct dentry *dentry, bool impurity);
 u64 ovl_inode_version_get(struct inode *inode);
 bool ovl_is_whiteout(struct dentry *dentry);
 bool ovl_path_is_whiteout(struct ovl_fs *ofs, const struct path *path);
-struct file *ovl_path_open(const struct path *path, int flags);
+struct file *ovl_path_open_realfile(const struct file *user_file,
+				    const struct path *path, int flags);
+
+static inline struct file *ovl_path_open(const struct path *path, int flags)
+{
+	return ovl_path_open_realfile(NULL, path, flags);
+}
+
 int ovl_copy_up_start(struct dentry *dentry, int flags);
 void ovl_copy_up_end(struct dentry *dentry);
 bool ovl_already_copied_up(struct dentry *dentry, int flags);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 7fa4fecf15360..3c8fe45b06f12 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -960,7 +960,8 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
 	with_ovl_creds(file_inode(file)->i_sb)
-		return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
+		return ovl_path_open_realfile(file, realpath,
+					      O_RDONLY | (file->f_flags & O_LARGEFILE));
 }
 
 /*
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 19f4fe7b98f29..f75e8009fb15f 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -659,7 +659,8 @@ bool ovl_path_is_whiteout(struct ovl_fs *ofs, const struct path *path)
 		ovl_path_check_xwhiteout_xattr(ofs, path);
 }
 
-struct file *ovl_path_open(const struct path *path, int flags)
+struct file *ovl_path_open_realfile(const struct file *user_file,
+				    const struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct mnt_idmap *real_idmap = mnt_idmap(path->mnt);
@@ -687,6 +688,14 @@ struct file *ovl_path_open(const struct path *path, int flags)
 	if (inode_owner_or_capable(real_idmap, inode))
 		flags |= O_NOATIME;
 
+	/*
+	 * Directory opens use dentry_open() here, not backing_file_open().
+	 * Inherit FMODE_NONOTIFY from a fanotify permission fd so a listener
+	 * that also watches the real filesystem does not deadlock.
+	 */
+	if (user_file && FMODE_FSNOTIFY_NONE(user_file->f_mode))
+		return dentry_open_nonotify(path, flags, current_cred());
+
 	return dentry_open(path, flags, current_cred());
 }
 
-- 
2.53.0

