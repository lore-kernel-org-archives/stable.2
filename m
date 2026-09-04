Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF93F39ED
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548325; cv=none; b=XhJPHnhgghODNOz5htV9vCuP0dSsRJ6LG019046Dp0KoWVjb0YlAoz4hyCh5hfyNo7kNBR/4Mq1AJWj4EQ0ub8ZRwKVVKqHqXrla0qxxDQOlcG0xtK/oQK/JoUgmMGzYiegB81YeAiUWhOMROpq3NlAGMUk+QtLyW/PyQDDiUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548325; c=relaxed/simple;
	bh=0qCCboCvW/ivFRduVZjG3cuttjqpCUsTgKkKXJV1MnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fn2HwenLY5iGcjLzAP+Lf375utP+adiGlzEh3OQucFWij+qITb52zteaL5une4l0hYJH5druVZYLCWkDr4AXjLVHkVRyoA3OMBnGMz1hF98HJcflq7ANFGUVmScCo6r2eOsznFa7MuvxPTsEuAoA9iKs+oqK2DKIJvBI777WTWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+ueXpk6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+ueXpk6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49557167508so15892285e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788548318; x=1789153118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aMoWgPahw43iVh071oF+KvgxCR/2ldDyid04S+m0FDE=;
        b=S+ueXpk6eMmQxn2gePIi2gngOrh52xE/Xr9yM8+7TiHNbmMO6YtHguPSz0pCn6zCQr
         YBI39q+jY+4L4CWND5y2UCnXY7+Nj8AO8h8I+/KSpC+cQoQXr+AMbh0owc5rNrCA3Gyo
         9Nh7ubGJgH1omxxrvNH1lzwMBz5ciSNTAgGgsLvdxT7ncFKBHBnTt5N95Hm9Lno/fB9K
         ttj+PTbEMlHKyM512H3J1x4F6SwztbUmGz70EzkbU2OwVN1YYzmA+I7VIQjJM+wJCtIB
         ggJ9DTMt7bBIJwZuoK5bE9tUEBhH9p73gw29n5zWST12W4w4cLHaPOPz6bV+GqLuGZk1
         0upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548318; x=1789153118;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMoWgPahw43iVh071oF+KvgxCR/2ldDyid04S+m0FDE=;
        b=jh9kSQIbSbRM0RYuwbScZSc+9/SmMqhlAwQh+5AH4euNMFUQJADWfYL3gwHKARTgiF
         9EL+tpZtOHIvELIqPRFGaI0ZZhWyBq1xT0ueGgt3zV3/ApVaFMZT8Q8M8LxZbH7UGYTl
         mdoNqUxbPdcWGeKfMu+EHwPUMEYFy499/ybaEjOby5dBT8bqQBY5J9dvs95yStR4px1i
         xPsJEo5f/8kH9F2WVH+1rkS19bMe0lHI7uCzIb8Uievp7ltBksw467Au8BFTKav+yTVS
         KKsn8Y5utYzjFiHjLUDZi/rHzo19VGHU2R3/Dz3mFOMvdxIdd3J6fiXEzm99Qf/GSVJp
         s3fw==
X-Gm-Message-State: AFuF++lxA34kb0w5Ae8MOfls3yfnTxmpQSBCVV+vVYedr0pC31vAEUVN
	MLKamHqz6ic9tCPmX8yz1hxS/PMRAPFCe3455avdrux7E9r4iqiAeB1OqO5/Q5IS
X-Gm-Gg: AYBFou3sTLKI2jpAUyEFptGuleUyMzyWY/0iSxGrgFD1EPWEK2lPvnITodMyJSu6DBe
	ykFNp8j8n7HtPipC9iNbo526tuAkxbwNseY/gd+IfryW8l6oNsWsS5jNvsEh/AFxP/dC+K7k7PB
	ZeO3nbpNKo93SjsEw9Ka6UA2U5vHCj3RnB/mCz3BfzzNf6Z1MNDw6UMute09rQj8Wjvy1W3fLiM
	MCziLhRwzFHBufpoaNIpz6TKmDqtTeeYqLBH+AczulCdBBd4/zF3kkN4cT4i/n6ZYnh0XUkUCiK
	VXMF6hsYX2iF8Bs1yGUOFyrQAPiNGi+y3owwi5OBZeWX078BJ1mo2OHGciqs879fQu/p6fuiIAE
	AXfCbCP90ugQ51lgne3fm3iGWciIYchoYya9ee8l9bDpLus1OzCKWdNx7r4AYMHojDuZNawEF1K
	NMcaJneNPbhG9fzvDWkyQ7cqvAPAXyxqpHgLQkBiVSmj29tsZALOHq6W3DsqDZB0d56EzyLs7Fr
	LPsBJf7epIPHw==
X-Received: by 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49cf7fdd67emr139853865e9.3.1788548317580;
        Fri, 04 Sep 2026 11:58:37 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm440465515e9.0.2026.09.04.11.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 11:58:37 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH 6.1.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
Date: Fri,  4 Sep 2026 20:58:17 +0200
Message-ID: <20260904185816.343078-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090318-unhook-scoff-4978@gregkh>
References: <2026090318-unhook-scoff-4978@gregkh>
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
 security/landlock/errata/abi-1.h | 24 +++++++++++++++++++
 security/landlock/fs.c           | 40 +++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 9 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 17bdfaa9eb87..d7a974f80cb9 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -115,6 +115,7 @@ struct landlock_path_beneath_attr {
  *   device.
  * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
  * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
+ *   This also guards the creation of whiteout objects as used in OverlayFS.
  * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
  *   socket.
  * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
new file mode 100644
index 000000000000..53c96c2057fa
--- /dev/null
+++ b/security/landlock/errata/abi-1.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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
index 7b95afcc6b43..dd7f0fd921cf 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/kdev_t.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
@@ -664,7 +665,7 @@ static inline int current_check_access_path(const struct path *const path,
 	return check_access_path(dom, path, access_request);
 }
 
-static inline access_mask_t get_mode_access(const umode_t mode)
+static inline access_mask_t get_mode_access(const umode_t mode, const dev_t dev)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -672,6 +673,9 @@ static inline access_mask_t get_mode_access(const umode_t mode)
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
+		/* Whiteout objects are guarded with MAKE_REG. */
+		if (dev == WHITEOUT_DEV)
+			return LANDLOCK_ACCESS_FS_MAKE_REG;
 		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
 	case S_IFBLK:
 		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
@@ -688,6 +692,13 @@ static inline access_mask_t get_mode_access(const umode_t mode)
 	}
 }
 
+static inline access_mask_t get_dentry_access(const struct dentry *const dentry)
+{
+	const struct inode *const inode = d_backing_inode(dentry);
+
+	return get_mode_access(inode->i_mode, inode->i_rdev);
+}
+
 static inline access_mask_t maybe_remove(const struct dentry *const dentry)
 {
 	if (d_is_negative(dentry))
@@ -768,6 +779,7 @@ static bool collect_domain_accesses(
  * @new_dentry: Destination file or directory.
  * @removable: Sets to true if it is a rename operation.
  * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANGE.
+ * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOUT.
  *
  * Because of its unprivileged constraints, Landlock relies on file hierarchies
  * (and not only inodes) to tie access rights to files.  Being able to link or
@@ -816,7 +828,8 @@ static bool collect_domain_accesses(
 static int current_check_refer_path(struct dentry *const old_dentry,
 				    const struct path *const new_dir,
 				    struct dentry *const new_dentry,
-				    const bool removable, const bool exchange)
+				    const bool removable, const bool exchange,
+				    const bool whiteout)
 {
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
@@ -836,18 +849,25 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1099,7 +1119,7 @@ static int hook_path_link(struct dentry *const old_dentry,
 			  struct dentry *const new_dentry)
 {
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false);
+					false, false);
 }
 
 static int hook_path_rename(const struct path *const old_dir,
@@ -1110,7 +1130,8 @@ static int hook_path_rename(const struct path *const old_dir,
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
-					!!(flags & RENAME_EXCHANGE));
+					!!(flags & RENAME_EXCHANGE),
+					!!(flags & RENAME_WHITEOUT));
 }
 
 static int hook_path_mkdir(const struct path *const dir,
@@ -1128,7 +1149,8 @@ static int hook_path_mknod(const struct path *const dir,
 
 	if (!dom)
 		return 0;
-	return check_access_path(dom, dir, get_mode_access(mode));
+	return check_access_path(dom, dir,
+				 get_mode_access(mode, new_decode_dev(dev)));
 }
 
 static int hook_path_symlink(const struct path *const dir,
-- 
2.55.0

