Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12771331EB3
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536624; cv=none; b=O4VmAFKNnHUYPdkdHYeWTUSKxcaFbW3hQ2uEFSEXWK3OK2w9KDLuESlJZZKUoolCVNnOFbuAYMNcwemANDSKTUcxMAyteNzHkAW0OqkwYSNnj5rKd7xp2gerk463C974r/nI2vRbhpS6z6gtUs83noLVzNfOuvMVvmv/uMYpu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536624; c=relaxed/simple;
	bh=xDSHLEJvv4S+ehumGrY7kGM1/OxoDe456ngMA0CCd3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNlpJF+I5axI4g0iFvHmQ3jaUCzWKc1zzVbAXrvNvqHfdh5G/EHJ+jM+UKD6N4nc56nz3ONhSFSAIu0Xckw7MHZ/hMiy1UHt1seTNqFbXTrNnOIdNbYz/f9jgfzT86jq0tYLtlepCd8+cF2JVbIlbRNYu1UgUL84d5+otNa/6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS6NAUNr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS6NAUNr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso12832555e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788536620; x=1789141420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HM9v/R2KBbxz5YchFa2QaH+CPRH5+oB0Pe0BiyXQ77I=;
        b=mS6NAUNr1mM4BBRmWAXSc/645EnwLLpRQLw9f8lI06nfwD7Nj3GI2d1eFtT8y0Ox/O
         HpMURrDDfdXoG7jibdZDos7e/7mbzOxrNkk06vhTv86Y/EYRZPnF+iYVQyoDfyXF24B/
         gnUt3gdOdYCvCxY58Vl+Zfo9XJwd1059oNTHmvCUP0Ni92UirebpmEwzOotUgIZkLrwJ
         vnv3TS5saG7UfjSjWQ5DmlTIEGKwviEu/cQBHyx85UXCkeqPXndby2ahFncgTZ9FNc30
         F8sENxFJ1YmPhb00KVOvgKbI01VAPkFGU2zqkc4QoRHeAvAREqLfZnEIEuNo4hisn5Iv
         QQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536620; x=1789141420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HM9v/R2KBbxz5YchFa2QaH+CPRH5+oB0Pe0BiyXQ77I=;
        b=fvutFBPZT7FHJTQd8bZ0gp5tCMOzZ5gfBg+eM0YUy8Acsq5is7k/djcYgdu/COzing
         IZ+lOnlje8g00cIAGZ+XxdODhRhXU49dNKVJ6zFHPzaF3SaGazIIdgmAzsAQtfPIqcY1
         x5sgQY+kU+dCEHnjKsrRShVxkQjieC1urlcAAZUzL5ps0WWeDHR92LafW/WxlD7Z0mHT
         9tFd9oAIPj/ndncqwQzipDjwwtsWEvxxXtbxj8oouo5qgUYi8aI4gyDVXomGyyPLksZ3
         FYednBOrvPihfr8TPHyEoXbdgBz0gu+EYnJJmvhJ9NmcT6FN60DbxqU3p3syLaIgzlUk
         ITAA==
X-Gm-Message-State: AFuF++mSNuzizvVL7pXphBUGYx4sc66HIXzZircjlLHTDnxvxkiZ/zje
	g98D6lgiglgaF5l52SmmPXjg8+eis0OxMDzTvrwxVl0tnXw9XC9p3E8YPY0v3cJA
X-Gm-Gg: AYBFou3t/x2pFmk86cwNUdN+XcoEV5KXWRmeCaucud3KqWPZndENPODbfY2gtIoCV4o
	gguImWFae89NezQkSqTkX2wZk+hpqdg9zo03mKXreohfS+iZZgmfnVN1kIFnuHXVoCEjV8K6fA3
	ouk4ZcIHHbEyX4e2ArBUnLkIHx1foOtefYh7KgqlgQK5ixE0qWxsyB4rTHp1e7MRuYsHqcx/DK0
	Pm7RnvB5Va9ZZb06G1Q6mItgzwep2MTJMgCKbXWoSLmmI7cwACzcWel6oxsDPLMNkg5Se6CrQ94
	Ef9z1oK/1ipVwaiIZSJAXKpGkK1rJIhrazQsBROz0hCVyvQYvHsK70ncYNBSfQ3UjZL+2Q17e5x
	zKxZ0vSjno1LHTGdkV/oOKLN4YG/ee1414xTcNaOJUTBikGODBQ93vMZJL54q46hC7SqbqDLweX
	0ujVIxXbelG6B2Ep+dZykbMEo62CqYqXktcQMw4P6kib5P80fOFYkdcKt35tOCJZvz4u7BZdgdv
	KsRVR0NGv82Mg==
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr86119915e9.12.1788536619983;
        Fri, 04 Sep 2026 08:43:39 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm88862085e9.2.2026.09.04.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:43:39 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	brauner@kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: 
Date: Fri,  4 Sep 2026 17:42:41 +0200
Message-ID: <20260904154240.68162-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090317-trapped-overload-3e96@gregkh>
References: <2026090317-trapped-overload-3e96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From f4c2168991ca1b1f4a1d00e755f43621f2ed89d1 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Date: Thu, 13 Aug 2026 11:31:53 +0200
Subject: [PATCH 6.12.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
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

