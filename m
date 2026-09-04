Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855A51E44B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545616; cv=none; b=r5Raqv5usupNZ9ppBoF8fYOLB+hD/YMpUnMGu3KZhpqTsy+Jt4Wt6nTDeWURfhk9QbTJEtbOUCuP2Z7foJLbqtQwNFn0BuXH6QlCTFs3Yo3BBFWHomxpHeb8k50dr0ur4iym8qhuwLKBHW9ctaOB9wnvinwBzmzdMTjmLjJZDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545616; c=relaxed/simple;
	bh=7CgTA2l3HnQo7IcMoM0EgIQYJGpBgeuAYn04MVqZKOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNfv3s8+l2xGO8KfOo5B9lk3ukOpihPX9O7z8cOXgtNtooKZbJDsJRYoQZd+K+LeD56fnKt05wKNZZfEcqg66RoyY8tYewFBob/KWy3B65uuddyvxYks37soSgEWFK8ZEik6rMTMbHXVo3RoDVCBXUW06XZAkSX4bJI2FOMDRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxV7t0E5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxV7t0E5"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1585955f8f.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788545612; x=1789150412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zO+f84IsQ/glUB/T+X7yKkaYY9EJ8My/IvSHFfr/QK8=;
        b=CxV7t0E5Tzd9pelO68dxocP0pgsPIPB173F889O0+/xmNFDcEtKg7UfaBZgKdg5p3u
         ctqJUOV+P05sE1+68mO1aRkxTI4DYXRiAkRvP7bxfxhWabMKoq6m3AfniqASjx4P7ugF
         Mm2BvSwto0/ipi2+b+PvBpuztKd/74I+sTqAHcOZR0PM3AYfAGHu0frbP4oUwaUCeHxT
         C/aPy7IY2hRSpgsbOVfyLUIzSqyiWUYZhcBGrJUJ7rKHcmjpbbHcly9rBfF5G2FUln/+
         FP/FSHbkLRBBvMWYn0Cgp+7zWeone7Urqi8k4Bx+nIClTIEIwJDMD+ngJtnmQeKY6FEB
         uJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788545612; x=1789150412;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zO+f84IsQ/glUB/T+X7yKkaYY9EJ8My/IvSHFfr/QK8=;
        b=lyrkwkl2CEeUM35KaxPdUsjZ9fV9b+LXP/j4ipX9g9xte8o05gpokGEEo3qnGvAYNz
         Z/GAhsyFhS6KJMKH6B5kDdjK5j6zvf4lK0AatrrqETv13qMIMUyXK2nQrXN4PyigJ4UE
         jXuigoQKKM3Ktzjvn2H40Sp9CvRleeMGBzLq7m0dSWTrixWKV5pWsNj1GtwRUd7cxxFD
         222wkeM+AJrsU1uIETkXM5ulmxu1PbxnCOX3hKQQnBGBKShxuK5HzyZVBc8B5yH6uYD/
         PQMZO4IFRNYTx3lQ6vLN6vYX1xEIRPmdY14aVan9GBUzWRMoMm0hyoieaJHDgPqF1LES
         Koxw==
X-Gm-Message-State: AFuF++mocBWFV4E05z8tBW7pFdg/hZUw8XKYPpl9uqvqniOVBbQlpruJ
	aL0ymML9JaAn2XRYpEyB7L9DY8Mh5P9WS4NtOJYIRE29F56PdMXlmgr9UvOe78DM
X-Gm-Gg: AYBFou1o7tYuzYKaClHd3ePmidV3NBok3aX59TNrRniqcdcC1pkWkElJLGnatko9+rY
	eS+ufJ3XwLvSkvRUkmDf3afK6BfDh9Qut/9Mgc3jTXlTDL04bYZ9bbRtWkh0XX1fsgNeHA4zUOQ
	AQ/X9vEqfR3YvMjpdGGDfR7nWBbjAZvA6GvgMCL7yHk84OMgOjN51d+61RAZxIufj15NCkQw9Um
	FsiHbaLnEtDEqDupDUA1hsxDoTRMNmiWytObJlXmmfHXZPoZDmyHbDgy9Zyj3HyXKp4y+7fvGcj
	w9kgHq6L66oIT+u42aJP7n1Mgnie8jfd1m4BJG0hmNtnLwjPiNMCBvIdC+XgI96tHSb9uHsfU7i
	FK1hq4U2agJwEjeUtg4W/ja85IC7KEqUmbZZsKGHsNeodJR0KOwniXUyQkfWRin6LTihPzw3nHQ
	V1Z4D4Lguq4T3eItQH+DVuO6nbCIZs4uTymniLurTZLvAUFbDeZuh0cJTlUApi7cdQGhaJ2D9AQ
	nWfzxDH+DZOTAHj+JFHZiqq0Q==
X-Received: by 2002:a05:6000:460b:b0:484:46f9:7adb with SMTP id ffacd0b85a97d-4858709b1e7mr17325337f8f.26.1788545612240;
        Fri, 04 Sep 2026 11:13:32 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm8188629f8f.1.2026.09.04.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 11:13:31 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	brauner@kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH 6.12.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
Date: Fri,  4 Sep 2026 20:13:27 +0200
Message-ID: <20260904181327.193032-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090317-trapped-overload-3e96@gregkh>
References: <2026090317-trapped-overload-3e96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Günther Noack <gnoack@google.com>

Whiteout objects are used in the upper layer of an OverlayFS to
indicate that the file with this name does not exist in the unified
view, even if it is present in one of the lower layer file systems.

For the userspace implementations of OverlayFS (fuse-overlayfs),
whiteout objects can be created from userspace as well:

* mknod(2) with S_IFCHR and makedev(0, 0)
* renameat2(2) with RENAME_WHITEOUT,
  creating the whiteout in the old place of the moved file.

This commit guards whiteout creation in both of these cases with
LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout objects are *not* considered
character devices and are not bound to a driver.

LANDLOCK_ACCESS_FS_MAKE_REG describes the same permission class as a
whiteout object: creating one is the only S_IFCHR creation that the VFS
exempts from CAP_MKNOD, so it is as unprivileged as creating a regular
file, while LANDLOCK_ACCESS_FS_MAKE_CHAR and
LANDLOCK_ACCESS_FS_MAKE_BLOCK keep meaning the creation of devices that
expose a kernel interface [1].

For the mknod(2) case, introduce a Landlock erratum.  The creation of
whiteout objects through mknod(2) was previously guarded using
LANDLOCK_ACCESS_FS_MAKE_CHAR, and it is now guarded using
LANDLOCK_ACCESS_FS_MAKE_REG.

For the renameat2(2) case, fix a bug: Before this commit, renameat2(2)
with RENAME_WHITEOUT would create a directory entry even when all
LANDLOCK_ACCESS_FS_MAKE_* rights were denied.

This does not affect normal renames within layered OverlayFS mounts:
When doing a regular rename() on a mounted fuse-overlayfs, it is the
fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITEOUT,
and only the Landlock domain of that daemon is checked there.

Suggested-by: Christian Brauner <brauner@kernel.org>
Suggested-by: Mickaël Salaün <mic@digikod.net>
Cc: stable@vger.kernel.org
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Depends-on: 49c9e09d9610 ("landlock: Fix handling of disconnected directories")
Depends-on: fe72ce6710cb ("landlock: Add errata documentation section")
Signed-off-by: Günther Noack <gnoack@google.com>
Link: https://patch.msgid.link/20260720.chow9ohYie5b@digikod.net [1]
Link: https://patch.msgid.link/20260813093157.1436894-3-gnoack@google.com
[mic: Record why LANDLOCK_ACCESS_FS_MAKE_REG is the matching right, and
add link(2) to the user doc]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
(cherry picked from commit 672fa082d48b21e1fb62cdb184fee41513e53421)
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h    |  1 +
 security/landlock/errata/abi-1.h | 23 ++++++++++++++++++
 security/landlock/fs.c           | 40 +++++++++++++++++++++++++-------
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index c223572f8229..94cfad88082f 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -177,6 +177,7 @@ struct landlock_net_port_attr {
  *   device.
  * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
  * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
+ *   This also guards the creation of whiteout objects as used in OverlayFS.
  * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
  *   socket.
  * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
index e8a2bff2e5b6..80930957e84d 100644
--- a/security/landlock/errata/abi-1.h
+++ b/security/landlock/errata/abi-1.h
@@ -14,3 +14,26 @@
  * actions.
  */
 LANDLOCK_ERRATUM(3)
+
+/**
+ * DOC: erratum_4
+ *
+ * Erratum 4: Creation of whiteout objects
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix changes the access rights required for the creation of whiteout
+ * objects through :manpage:`mknod(2)`, :manpage:`renameat2(2)`, or
+ * :manpage:`link(2)`.  Creating whiteout objects is now guarded by
+ * ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
+ *
+ * Whiteout objects are used in OverlayFS to mark the absence of a file in an
+ * upper file system.  Despite being created with ``S_IFCHR``, whiteout objects
+ * do not count as character devices.
+ *
+ * Impact:
+ *
+ * Sandboxed programs that create OverlayFS whiteouts (such as fuse-overlayfs)
+ * now require ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of
+ * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
+ */
+LANDLOCK_ERRATUM(4)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index bb4a9e82156a..b96a4daa5b2a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -20,6 +20,7 @@
 #include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/kdev_t.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
@@ -954,7 +955,7 @@ static int current_check_access_path(const struct path *const path,
 	return check_access_path(dom, path, access_request);
 }
 
-static access_mask_t get_mode_access(const umode_t mode)
+static access_mask_t get_mode_access(const umode_t mode, const dev_t dev)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -962,6 +963,9 @@ static access_mask_t get_mode_access(const umode_t mode)
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
+		/* Whiteout objects are guarded with MAKE_REG. */
+		if (dev == WHITEOUT_DEV)
+			return LANDLOCK_ACCESS_FS_MAKE_REG;
 		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
 	case S_IFBLK:
 		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
@@ -978,6 +982,13 @@ static access_mask_t get_mode_access(const umode_t mode)
 	}
 }
 
+static access_mask_t get_dentry_access(const struct dentry *const dentry)
+{
+	const struct inode *const inode = d_backing_inode(dentry);
+
+	return get_mode_access(inode->i_mode, inode->i_rdev);
+}
+
 static access_mask_t maybe_remove(const struct dentry *const dentry)
 {
 	if (d_is_negative(dentry))
@@ -1067,6 +1078,7 @@ static bool collect_domain_accesses(
  * @new_dentry: Destination file or directory.
  * @removable: Sets to true if it is a rename operation.
  * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANGE.
+ * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOUT.
  *
  * Because of its unprivileged constraints, Landlock relies on file hierarchies
  * (and not only inodes) to tie access rights to files.  Being able to link or
@@ -1115,7 +1127,8 @@ static bool collect_domain_accesses(
 static int current_check_refer_path(struct dentry *const old_dentry,
 				    const struct path *const new_dir,
 				    struct dentry *const new_dentry,
-				    const bool removable, const bool exchange)
+				    const bool removable, const bool exchange,
+				    const bool whiteout)
 {
 	const struct landlock_ruleset *const dom = get_current_fs_domain();
 	bool allow_parent1, allow_parent2;
@@ -1134,18 +1147,25 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	if (exchange) {
 		if (unlikely(d_is_negative(new_dentry)))
 			return -ENOENT;
-		access_request_parent1 =
-			get_mode_access(d_backing_inode(new_dentry)->i_mode);
+		access_request_parent1 = get_dentry_access(new_dentry);
 	} else {
 		access_request_parent1 = 0;
 	}
-	access_request_parent2 =
-		get_mode_access(d_backing_inode(old_dentry)->i_mode);
+	access_request_parent2 = get_dentry_access(old_dentry);
 	if (removable) {
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
 	}
 
+	/*
+	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object is
+	 * created in the source location, so we require an additional access
+	 * right there.
+	 */
+	if (whiteout)
+		access_request_parent1 |=
+			get_mode_access(S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+
 	/* The mount points are the same for old and new paths, cf. EXDEV. */
 	if (old_dentry->d_parent == new_dir->dentry) {
 		/*
@@ -1417,7 +1437,7 @@ static int hook_path_link(struct dentry *const old_dentry,
 			  struct dentry *const new_dentry)
 {
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false);
+					false, false);
 }
 
 static int hook_path_rename(const struct path *const old_dir,
@@ -1428,7 +1448,8 @@ static int hook_path_rename(const struct path *const old_dir,
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
-					!!(flags & RENAME_EXCHANGE));
+					!!(flags & RENAME_EXCHANGE),
+					!!(flags & RENAME_WHITEOUT));
 }
 
 static int hook_path_mkdir(const struct path *const dir,
@@ -1445,7 +1466,8 @@ static int hook_path_mknod(const struct path *const dir,
 
 	if (!dom)
 		return 0;
-	return check_access_path(dom, dir, get_mode_access(mode));
+	return check_access_path(dom, dir,
+				 get_mode_access(mode, new_decode_dev(dev)));
 }
 
 static int hook_path_symlink(const struct path *const dir,
-- 
2.55.0

