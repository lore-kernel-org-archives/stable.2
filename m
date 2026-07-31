Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765343B3EF
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512650; cv=none; b=iQY7VE39gXO5k/Yamalzv9Ub5hFIPaLrix/YMrbzqDWhZH3ACcomulhTMRQb0RwARGEQ/FAt3+PbTIifWup0D0wdZk6ApCOiPKNQNUkqLtX37DRLnCx86YL3cvwVhWaNv4yHOBTNT0+9qKWYJQe/F32pFnavf8bj8cjI4m13Gug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512650; c=relaxed/simple;
	bh=LEWxUOWVmU3Vw6HcaHSqImiVNkdfMh5fMNn+ukIuvOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JToCmfxd+lIWbNnSGReulniQHvn4pdMJH1z4O0LUrVi2v9BXdvnOwMYDq+8M1rtyNj0Rb/F+cdUmePK5wFDL2OpiGq66pweicCP2V8na1NJJSx9jiqcmbTi7Qw2gnX+scBZ7Gs06Hb7u1NQwRP1oGkV5DLkd7p/3BUUoUezpIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbHGyfz2; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbHGyfz2"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15cec1ccb6so109598966b.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785512647; x=1786117447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TGv9oaNlaBZk+/EC49Nn/fhRApP+RDWSQ21AKhDj5YQ=;
        b=LbHGyfz2fJvWGryBs0jfvghnzvaFPq/hvkqIzfRL2Mi2Cei+ejj+jisVbwI1wNs6SW
         VyZTRAD+2w9B4z+G+kIG2M/9DwKNsvbW7bBEAPf+5qcxQhZDNJ58cNKD8IQoMc62PJY5
         OmwqDQOYt3KO3F54n10stuVTHmHIKJ1FOxKypQ6vDEprSv/RTn3kYthIb9EaQrbQPfuW
         MP28fVKdzCgrmJQNEgrFzOHsvB9znYvMVUHS3L2bqyhyh3hLEC7Kzyl6JPbjYHS9FxHT
         qOgmX0no0RAmN/znmiMySgUobjba7MFqid4DuNLg8ZpMwL6Vf404l1tQDxjjYriDL9zs
         4sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512647; x=1786117447;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGv9oaNlaBZk+/EC49Nn/fhRApP+RDWSQ21AKhDj5YQ=;
        b=c9fLEYNNSNd1B8bJPAXoDIihfcRnifv0FNQNLYteI6D4yUxixqFZ2S9SzGxkNKxyKx
         2MRJVsFzHfDksV4uM+DrHJpLcIMTKr+WIe1ZsWGyqS3rVSg/Eea+aRi1Oo0r+gJZliWn
         H97P2xPLYKpZCX/Hg0EJjIGC5ggQ7+PFzPRAGJdLUZeGyme4ROeJiYNCdE/DNX+3Q4Qn
         Rh4gKqESGnqycxwpluPokZEg2YTyEE/2KkWhgjOHqJYjUBQIT9RERV71RFVd5uX/ybDz
         dOriGFQVNI4F6ZACnJ4AEhmlnzMhlr/T+Z9aM4W32YB5ka2NSGb9nNMwkP/3Gb9IB86F
         7tiA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3LDgFZN2poxmSibQpF+0M6nz/PQpsJb5jrlFnC8iU65H+KZGIt1mFVRGpyW8NLgYNK8kp4co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzo7rNa6eHqoXeM93aqQ/B0CwiRgY/MmTQw6AsqVqwDR7JHNOb
	Cr0oFpduPSJOIHMgkGh1CPT1d7sXSvccwrB8kB8m9Nks9Rrb+UAiB1dUC7Rc4bNzMSq/QMcF9WR
	P1P+Yvg==
X-Received: from wrtr6.prod.google.com ([2002:a5d:4e46:0:b0:47f:44b6:2328])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:f598:b0:c1c:2173:d412
 with SMTP id a640c23a62f3a-c1fe8494f9amr3013166b.1.1785512646788; Fri, 31 Jul
 2026 08:44:06 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:43:50 +0200
In-Reply-To: <20260731154353.1790268-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731154353.1790268-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731154353.1790268-3-gnoack@google.com>
Subject: [PATCH v5 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
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
LANDLOCK_ACCESS_MAKE_REG.

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
index f7e5e4ef9eac..c12af17cac9e 100644
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
+static __attribute_const__ access_mask_t
+get_dentry_access(const struct dentry *const dentry)
+{
+	return get_mode_access(d_backing_inode(dentry)->i_mode,
+			       d_backing_inode(dentry)->i_rdev);
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
2.55.0.508.g3f0d502094-goog

