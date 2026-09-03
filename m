Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F34B66DA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445509; cv=none; b=Pc7f8/6EhVpwttsNAck33LBgwmiVTxpaVpXItGyuuO0tOHm8khcgJXumlgnfDaiedE3OtdjbJ3weZI7HCkDsW/yAwKHJBS4uv+O9ftiBHn2vpU22QvlazR8SJwzg8mPdkBp283nwOKFXWsbS8yUHp6CyMUcOKI4lBS/MV6vxphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445509; c=relaxed/simple;
	bh=8AehoNnVcDep0/ZgY5I9VKcXVfQCqOrISGyqKl0cCJ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jD88SbAIPglMymL58lpzkn/6PVSbRJkEXOTOf9ZbhkI7nUcXOr4QRvdtqn8O+aA/fWXBGZ8p00IusiYN4r3ytEViSeJZnxMhfVdzx4sAHKDDAqkShAmOEuTn7P5RRPfZ1bNGqRcpDCq1UyCGC2zf13BLz5qT4Tie4jsZpJnkI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U61WmddP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U61WmddP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDB51F00A3D;
	Thu,  3 Sep 2026 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445498;
	bh=A/Wzu3sRwI99/HUulT40ZM8q2SS/mCNMNIhZ4DR4yQo=;
	h=Subject:To:Cc:From:Date;
	b=U61WmddP0l79MuPQJ/tf4o5m9JI5GgGKu0gCMD0kwVk4TEl+OQw4szxMBOcl+/26K
	 DfpMVujGZn5RnfbPUs6BovHJb+EV0INfphjsy0llTI5UmYVpSKX/6oa4b6lRxJldNT
	 cJP9KzNgXEPkjX6EM+ZEEATKINZugD7ouesxkvZ4=
Subject: FAILED: patch "[PATCH] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout" failed to apply to 6.6-stable tree
To: gnoack@google.com,brauner@kernel.org,mic@digikod.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:01:17 +0200
Message-ID: <2026090317-both-dab-e169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 672fa082d48b21e1fb62cdb184fee41513e53421
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090317-both-dab-e169@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 672fa082d48b21e1fb62cdb184fee41513e53421 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Thu, 13 Aug 2026 11:31:53 +0200
Subject: [PATCH] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 272f047df438..27ae3f39cafb 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -351,6 +351,7 @@ struct landlock_net_port_attr {
  *   device.
  * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
  * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
+ *   This also guards the creation of whiteout objects as used in OverlayFS.
  * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
  *   socket.
  * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
index 3f099555f059..315ea7e0fe50 100644
--- a/security/landlock/errata/abi-1.h
+++ b/security/landlock/errata/abi-1.h
@@ -22,3 +22,26 @@
  * from their original mount points.
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
index f7e5e4ef9eac..8fc7f82a374a 100644
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
@@ -983,7 +984,8 @@ static int current_check_access_path(const struct path *const path,
 	return -EACCES;
 }
 
-static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
+static __attribute_const__ access_mask_t get_mode_access(const umode_t mode,
+							 const dev_t dev)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -991,6 +993,9 @@ static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
+		/* Whiteout objects are guarded with MAKE_REG. */
+		if (dev == WHITEOUT_DEV)
+			return LANDLOCK_ACCESS_FS_MAKE_REG;
 		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
 	case S_IFBLK:
 		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
@@ -1007,6 +1012,13 @@ static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
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
@@ -1093,6 +1105,7 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
  * @new_dentry: Destination file or directory.
  * @removable: Sets to true if it is a rename operation.
  * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANGE.
+ * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOUT.
  *
  * Because of its unprivileged constraints, Landlock relies on file hierarchies
  * (and not only inodes) to tie access rights to files.  Being able to link or
@@ -1140,7 +1153,8 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
 static int current_check_refer_path(struct dentry *const old_dentry,
 				    const struct path *const new_dir,
 				    struct dentry *const new_dentry,
-				    const bool removable, const bool exchange)
+				    const bool removable, const bool exchange,
+				    const bool whiteout)
 {
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
@@ -1159,18 +1173,25 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1520,7 +1541,7 @@ static int hook_path_link(struct dentry *const old_dentry,
 			  struct dentry *const new_dentry)
 {
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false);
+					false, false);
 }
 
 static int hook_path_rename(const struct path *const old_dir,
@@ -1531,7 +1552,8 @@ static int hook_path_rename(const struct path *const old_dir,
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
-					!!(flags & RENAME_EXCHANGE));
+					!!(flags & RENAME_EXCHANGE),
+					!!(flags & RENAME_WHITEOUT));
 }
 
 static int hook_path_mkdir(const struct path *const dir,
@@ -1544,7 +1566,8 @@ static int hook_path_mknod(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	return current_check_access_path(dir, get_mode_access(mode));
+	return current_check_access_path(
+		dir, get_mode_access(mode, new_decode_dev(dev)));
 }
 
 static int hook_path_symlink(const struct path *const dir,

