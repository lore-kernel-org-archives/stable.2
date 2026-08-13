Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42F3B27D1
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613537; cv=none; b=qbFNdu7Lm0fh1OcQQdN4wkpIgskMlf22KIWQn9Y7ue/TXUjy2VG0M445oQtsfaG7haivF7gYtX6I1vZc3jJjT4ARettbJwSmxU7Wykiz6aE2E4TXk+/eW/p6pa0IlGqXbi+vQCAT91kHvqOnEDHMj7WFrg5NiEck2uYlOpk9tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613537; c=relaxed/simple;
	bh=ErGs5o10e28dfVAtzVEpysYXW92M/x0Yjc2O8Tf1zKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jURDZdfWAgES47E0uKciLfJBX5PuxqSGdk3vQZ6ZcI7vPJZXLGfAdYSihXLTRB90CYuIkCgU/IdOZV/piwY8cuxjsvWeClnCrMl5mHUL2P7sIztOB1B8oE2AE66q8aWAtnTOXdTQfGAkVgrz4oWpTmzML0FaMHyX0RsETdbaINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KM1sF229; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KM1sF229"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso14632565e9.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786613533; x=1787218333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRNaOK1A0AewDrLDzr0tjnEL+QNpbJHvyeZyhyjeBBk=;
        b=KM1sF229zVnNeah6/77x1v8fDwmd34hf29lM9sxwrTgS9KAzAciDTQQLYQoXAAXmIB
         GvAxhuh8NC9egP4u5Av3ov4Mk6mes+s94b8nomFXjxxjuzjov2nzINuluROMer6F3NRc
         fOhkXcvIf83GJBDLnVl48hxVEYgWgjC/TXRWP/xdWdiYzaUEQDwZGpc39oawli6B8JXG
         vnca8YwnWBtnYP4pVJ/NPnh7JtL5NKt348lz5B3KBMZLpe4w0vt/kxZeHkgn2NAyZl73
         2yXfgMUMDi2rUYgQddxkVqmZLf9q2GZPedBNQIcEU38F+NCDjCpn+0jo+wvgrpixbfyM
         xROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613533; x=1787218333;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRNaOK1A0AewDrLDzr0tjnEL+QNpbJHvyeZyhyjeBBk=;
        b=olmvNrsS+uTkrTqgyI6Vs/3/fg1NLvxNbjgjV3vY9KdS1bQKD6JSLzFCQeAKADxWnh
         WiPdTtD4LntSq5tMS6GFSw+aMtXXLtVsb/5y0mSpwWGFaydbguF/k3P1th0WmHTA9wU+
         CZX7dgmSl8ihnTNbL8YlsAzUVs0d4faFN1RZ7qhySBMg8dSeOFf040JJkFd89wC7HBMP
         D5ymyHCbRANbpKFFU9P265Rgj6+wg4IRhh2OzDSkuJJtgrwPQgsheaiBwwDXL/A4akSu
         YWbBeK3gqA0LKIvFwe0ysoDEPIkRBleW30ZDAXnUc8HvvhyTlYZu+rh3F/xtuHuRT4PE
         ovRQ==
X-Forwarded-Encrypted: i=1; AHgh+RobBHLi5jH6YhO2lXMDX+3r5ktp+wvCc7IuDa5cHfX+OqLRwjL3HWPR/1nY9alePBef2Q7weuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAzt1X/DsrzJJexjuDopuHN7flo/HHHK2liySS7iLpVgL6v1D
	H+r9hi13zkOuzaxwnstPVaabhm5Pr2bsSta7vjMmgQXVpqY/xmfaodFa1uNJbcAQzIZrM3eUocJ
	xPqhq/A==
X-Received: from wmv6.prod.google.com ([2002:a05:600c:26c6:b0:492:45de:dde6])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45d4:b0:499:4dca:aa4
 with SMTP id 5b1f17b1804b1-4998219b782mr47455265e9.4.1786613532357; Thu, 13
 Aug 2026 02:32:12 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:31:53 +0200
In-Reply-To: <20260813093157.1436894-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813093157.1436894-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813093157.1436894-3-gnoack@google.com>
Subject: [PATCH v6 2/6] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: stable@vger.kernel.org
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Depends-on: 49c9e09d9610 ("landlock: Fix handling of disconnected directori=
es")
Depends-on: fe72ce6710cb ("landlock: Add errata documentation section")
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h    |  1 +
 security/landlock/errata/abi-1.h | 23 ++++++++++++++++++
 security/landlock/fs.c           | 41 +++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 7ffe2ef127ee..9c1102ebf06e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -351,6 +351,7 @@ struct landlock_net_port_attr {
  *   device.
  * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
  * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular fi=
le.
+ *   This also guards the creation of whiteout objects as used in OverlayF=
S.
  * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX doma=
in
  *   socket.
  * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pip=
e.
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/ab=
i-1.h
index 3f099555f059..e0d543d9d508 100644
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
+ * This fix changes the access rights required for the creation of whiteou=
t
+ * objects through :manpage:`mknod(2)` or :manpage:`renameat2(2)`.  Creati=
ng
+ * whiteout objects is now guarded by ``LANDLOCK_ACCESS_FS_MAKE_REG`` inst=
ead of
+ * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
+ *
+ * Whiteout objects are used in OverlayFS to mark the absence of a file in=
 an
+ * upper file system.  Despite being created with ``S_IFCHR``, whiteout ob=
jects
+ * do not count as character devices.
+ *
+ * Impact:
+ *
+ * Sandboxed programs that create OverlayFS whiteouts (such as fuse-overla=
yfs)
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
@@ -983,7 +984,8 @@ static int current_check_access_path(const struct path =
*const path,
 	return -EACCES;
 }
=20
-static __attribute_const__ access_mask_t get_mode_access(const umode_t mod=
e)
+static __attribute_const__ access_mask_t get_mode_access(const umode_t mod=
e,
+							 const dev_t dev)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -991,6 +993,9 @@ static __attribute_const__ access_mask_t get_mode_acces=
s(const umode_t mode)
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
+		/* Whiteout objects are guarded with MAKE_REG. */
+		if (dev =3D=3D WHITEOUT_DEV)
+			return LANDLOCK_ACCESS_FS_MAKE_REG;
 		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
 	case S_IFBLK:
 		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
@@ -1007,6 +1012,13 @@ static __attribute_const__ access_mask_t get_mode_ac=
cess(const umode_t mode)
 	}
 }
=20
+static access_mask_t get_dentry_access(const struct dentry *const dentry)
+{
+	const struct inode *const inode =3D d_backing_inode(dentry);
+
+	return get_mode_access(inode->i_mode, inode->i_rdev);
+}
+
 static access_mask_t maybe_remove(const struct dentry *const dentry)
 {
 	if (d_is_negative(dentry))
@@ -1093,6 +1105,7 @@ static bool collect_domain_accesses(const struct land=
lock_ruleset *const domain,
  * @new_dentry: Destination file or directory.
  * @removable: Sets to true if it is a rename operation.
  * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANG=
E.
+ * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOU=
T.
  *
  * Because of its unprivileged constraints, Landlock relies on file hierar=
chies
  * (and not only inodes) to tie access rights to files.  Being able to lin=
k or
@@ -1140,7 +1153,8 @@ static bool collect_domain_accesses(const struct land=
lock_ruleset *const domain,
 static int current_check_refer_path(struct dentry *const old_dentry,
 				    const struct path *const new_dir,
 				    struct dentry *const new_dentry,
-				    const bool removable, const bool exchange)
+				    const bool removable, const bool exchange,
+				    const bool whiteout)
 {
 	const struct landlock_cred_security *const subject =3D
 		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
@@ -1159,18 +1173,25 @@ static int current_check_refer_path(struct dentry *=
const old_dentry,
 	if (exchange) {
 		if (unlikely(d_is_negative(new_dentry)))
 			return -ENOENT;
-		access_request_parent1 =3D
-			get_mode_access(d_backing_inode(new_dentry)->i_mode);
+		access_request_parent1 =3D get_dentry_access(new_dentry);
 	} else {
 		access_request_parent1 =3D 0;
 	}
-	access_request_parent2 =3D
-		get_mode_access(d_backing_inode(old_dentry)->i_mode);
+	access_request_parent2 =3D get_dentry_access(old_dentry);
 	if (removable) {
 		access_request_parent1 |=3D maybe_remove(old_dentry);
 		access_request_parent2 |=3D maybe_remove(new_dentry);
 	}
=20
+	/*
+	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object is
+	 * created in the source location, so we require an additional access
+	 * right there.
+	 */
+	if (whiteout)
+		access_request_parent1 |=3D
+			get_mode_access(S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+
 	/* The mount points are the same for old and new paths, cf. EXDEV. */
 	if (old_dentry->d_parent =3D=3D new_dir->dentry) {
 		/*
@@ -1520,7 +1541,7 @@ static int hook_path_link(struct dentry *const old_de=
ntry,
 			  struct dentry *const new_dentry)
 {
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false);
+					false, false);
 }
=20
 static int hook_path_rename(const struct path *const old_dir,
@@ -1531,7 +1552,8 @@ static int hook_path_rename(const struct path *const =
old_dir,
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
-					!!(flags & RENAME_EXCHANGE));
+					!!(flags & RENAME_EXCHANGE),
+					!!(flags & RENAME_WHITEOUT));
 }
=20
 static int hook_path_mkdir(const struct path *const dir,
@@ -1544,7 +1566,8 @@ static int hook_path_mknod(const struct path *const d=
ir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	return current_check_access_path(dir, get_mode_access(mode));
+	return current_check_access_path(
+		dir, get_mode_access(mode, new_decode_dev(dev)));
 }
=20
 static int hook_path_symlink(const struct path *const dir,
--=20
2.55.0.699.gb54405d56f-goog

