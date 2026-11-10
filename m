Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273858;
	b=AzlutpqdKMsMWybcyAxQN8sQBQgPqi9PHPs1EJ31yacsLdxPeVcr0cS1SacafB4Yrz1A
	 Bb2YZyWke8fyw70U60Cjq4JfZ065Id6tNfxNf+WnzIHPM5hZCJFzBVgGYzgtpUQm9El5C
	 HWW3IUMyuhAQdlSj9JM46xrP97Va7jDkfwq/0nY+TTHvROcWAeQYosMtZRmR9YowGPOv2
	 NevjmKhHJQE/CLdNJ9bEc+Xz4xaEmyM01/51qNuxaB/mxcGquWyBgfqaew0qE46FJ/OXN
	 Jn8rQ7KAXic/JbzI8jw7OVMPkjwKK0Ie3pwCx1PCLn50ijzns+g3DJuPAszf6lq0PMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X8BpAK1kMby/LMFmlDOJKcY1HBE0k2bocYyvVrzru2c=;
	b=kf3Vj1wb9vKI6i5vMwFv/BZkgzWsQExpdxGay0/GcP08IFVOl9J1XAdQJabOCKfseDri
	 7PihXJNneQ9T6eFYaxkk493P0r7/gKDitHt5B24aFc0iLHFqCYU66yUsso73UzSVlaHDr
	 9vg+eiip5MGp9jedgcgI/XiSXrcpu7RJZVX5VsAQMgFcqvVH3X2iW0jveR0i9IjI/CyKB
	 ISkpP53zEFYyMdasAuw4Ua6VMT3uaPH4+vrfwMYhgFndr0xqpmkT/wDlRG1F61JIDUjhO
	 aZD3aLPPA9nijD4IlLHziCfFpS/nuPiR4EMPdWZNcFeRUuLOR9nzqfaZUmK+JjgF5fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3ypy84Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8160A3809
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3ypy84Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2EC1F008A1;
	Tue, 10 Nov 2026 01:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273858;
	bh=X8BpAK1kMby/LMFmlDOJKcY1HBE0k2bocYyvVrzru2c=;
	h=From:To:Cc:Subject:Date;
	b=b3ypy84Q9KA8F8TPd4d9NeCej6tOBv4ZloMeul1h15lUP4VmzDzF75fghNdOINXPD
	 cPq5/zpH+1Sla50fYWfJQ6WAtayVAn1D0HhdmqxlFBNagFUxLjMwC0WWt7qHWQa2/Q
	 pVhNNvn685jAG81JyvbEEuyB6YPvXJLgtgzaXtc0abIIwKBL8dNreng2C3BYXyGsER
	 LgDkkRHCZDU2Jk5zCZP6OJ1SK4mdWCzWrR/BsDTvBpH/JVJMbEJCmpIvrR/6xGR+WM
	 7n9cokmt7w407dQTVOmZfJPXeHDzgTUJsP2cwutojYWOTFJ7MA3mffCGWc0d5QtjeJ
	 ESnwIKgOa6JNQ==
From: Sasha Levin <sashal@kernel.org>
To: amir73il@gmail.com,
	brauner@kernel.org,
	edvard@tuta.io
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ovl: inherit FMODE_NONOTIFY when opening directory realfiles" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:16 -0500
Message-ID: <20261109202416-failed-5.15-323899b4ed23@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 323899b4ed233d5b6e2fc160c16fbf39cf0317da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202416-failed-5.15-323899b4ed23@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 323899b4ed233d5b6e2fc160c16fbf39cf0317da Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 18:07:02 +0100
Subject: [PATCH] ovl: inherit FMODE_NONOTIFY when opening directory realfiles

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
---
 fs/open.c                |  1 +
 fs/overlayfs/overlayfs.h |  9 ++++++++-
 fs/overlayfs/readdir.c   |  3 ++-
 fs/overlayfs/util.c      | 11 ++++++++++-
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index e43f02ff64acb..bb484b07390ac 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1172,6 +1172,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 	}
 	return f;
 }
+EXPORT_SYMBOL_GPL(dentry_open_nonotify);
 
 /**
  * kernel_file_open - open a file for kernel internal use
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index e9389a10452e8..b5a672e8e4764 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -531,7 +531,14 @@ void ovl_dir_modified(struct dentry *dentry, bool impurity);
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
index b862309eba4d1..5d21a328fad46 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -994,7 +994,8 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
 	with_ovl_creds(file_inode(file)->i_sb)
-		return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
+		return ovl_path_open_realfile(file, realpath,
+					      O_RDONLY | (file->f_flags & O_LARGEFILE));
 }
 
 /*
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 6c3fda047f94f..788c6870d67df 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -654,7 +654,8 @@ bool ovl_path_is_whiteout(struct ovl_fs *ofs, const struct path *path)
 		ovl_path_check_xwhiteout_xattr(ofs, path);
 }
 
-struct file *ovl_path_open(const struct path *path, int flags)
+struct file *ovl_path_open_realfile(const struct file *user_file,
+				    const struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	const struct mnt_idmap *real_idmap = mnt_idmap(path->mnt);
@@ -682,6 +683,14 @@ struct file *ovl_path_open(const struct path *path, int flags)
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




