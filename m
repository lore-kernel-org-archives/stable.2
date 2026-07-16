Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69F32BF4B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200849; cv=none; b=fQni9gmtDkWRSamx7XWNL1USkrurNDUDACX70YN12IFwady2dOSQeHT2ywOIB/25wKhkEv8XX12o3KOZQBQosatq4BC8NIMWtC5W/KGW2SrDTBfXiuGXsPBm05N6dWRkKJs6Auus5VDlSR5seRxFk18qLhWv++9Ghf1WOxGivxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200849; c=relaxed/simple;
	bh=b2/e2TNOlF6jPFuWrHADfVDiDUfXtXJBvtcYRPkdDAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2QqbbS1W5y2UzgPtpeT83MRw9faCWiaXS6N+s8N5I69C+DoVhDz1zhuPiE8WnoowlseM39MpQO2aUTIDyKZYgYc/w+wCErVQZ+xKjD8ZPm2XeJWxmbgSbF3Kj6uNLWAElv6r7bC4E4UzzosNcDzj3T2FDvFrLkme2H8sVbhn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juyp0jrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juyp0jrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6A91F00A3E;
	Thu, 16 Jul 2026 11:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784200847;
	bh=wRUUZom8l5WhvxwzmHZTLPzHAi+E8jEw5dufUXhDpkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=juyp0jrJ0mxOcpg64nP5SVa2hj0yjLr6lD5EYfZBzb0YJ/ymj3X9OA7bU/U2DjAXQ
	 6eetMHibjvsvcRmGdy3KOwY6X4tODuJIbj8VsCnG2WBnT7XR9oj6jJfQ5RsZ8Pu8Q2
	 mLBU0DpKToVhgTHOO/B/0/Vne6QSp1kuA73fZKLEQ6/VxyQMYbSQQ6Pf4RB17/l2Df
	 ryqc1cdxK+mE/FiVlcixmXxAYOl5YapcWLlgcnADmqk8C8ug4y8CGaSwhOqmW7ySMz
	 uAABHBlelZhFb/wz/xxK1iZF3xC56G/B0koTUjpldhQsWDWFzjPQ+htYGa66SuxwRE
	 m8p6Er1zEVitw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Amir Goldstein <amir73il@gmail.com>,
	NeilBrown <neil@brown.name>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] vfs: make LAST_XXX private to fs/namei.c
Date: Thu, 16 Jul 2026 07:20:42 -0400
Message-ID: <20260716112043.1732826-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112043.1732826-1-sashal@kernel.org>
References: <2026071450-trespass-dispense-fb1b@gregkh>
 <20260716112043.1732826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jori Koolstra <jkoolstra@xs4all.nl>

[ Upstream commit f2f1dddccae50f7a1d088285c53c376e26cedf67 ]

The only user of LAST_XXX outside of fs/namei.c is fs/smb/server/vfs.c;
ksmbd_vfs_path_lookup() calls vfs_path_parent_lookup() and expects a
LAST_NORM last type (or it will be ENOENT). ksmbd_vfs_rename() also calls
vfs_path_parent_lookup() but forgets the LAST_NORM check.

It does not really make sense to have vfs_path_parent_lookup() expose
the last_type because it is only needed to ensure it is LAST_NORM. So
let's do this check in vfs_path_parent_lookup() instead and keep the
LAST_XXX internal to fs/namei.c. This changes the ENOENT errno in
ksmbd_vfs_path_lookup() to EINVAL, which matches better with how this is
handled by callers of filename_parentat().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Link: https://patch.msgid.link/20260528175854.57626-1-jkoolstra@xs4all.nl
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: 1c8951963d8e ("ksmbd: fix path resolution in ksmbd_vfs_kern_path_create")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namei.c            | 20 ++++++++++++++++----
 fs/smb/server/vfs.c   | 15 +++------------
 include/linux/namei.h |  7 +------
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1eb20cb5e58f9e..3552e5ad02a620 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -125,6 +125,11 @@
 
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
+/*
+ * Type of the last component on LOOKUP_PARENT
+ */
+enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
+
 struct filename *
 getname_flags(const char __user *filename, int flags)
 {
@@ -2736,15 +2741,22 @@ EXPORT_SYMBOL(kern_path);
  * @flags: lookup flags
  * @parent: pointer to struct path to fill
  * @last: last component
- * @type: type of the last component
  * @root: pointer to struct path of the base directory
  */
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
-			   struct path *parent, struct qstr *last, int *type,
+			   struct path *parent, struct qstr *last,
 			   const struct path *root)
 {
-	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
-				    type, root);
+	int type;
+	int err =  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
+				       &type, root);
+	if (err)
+		return err;
+	if (unlikely(type != LAST_NORM)) {
+		path_put(parent);
+		return -EINVAL;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(vfs_path_parent_lookup);
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a630994187a775..8c79ad55fe44d7 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -18,7 +18,6 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
-#include <linux/namei.h>
 
 #include "glob.h"
 #include "oplock.h"
@@ -73,7 +72,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	struct qstr last;
 	struct filename *filename;
 	struct path *root_share_path = &share_conf->vfs_path;
-	int err, type;
+	int err;
 	struct dentry *d;
 
 	if (pathname[0] == '\0') {
@@ -88,19 +87,13 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 		return PTR_ERR(filename);
 
 	err = vfs_path_parent_lookup(filename, flags,
-				     parent_path, &last, &type,
+				     parent_path, &last,
 				     root_share_path);
 	if (err) {
 		putname(filename);
 		return err;
 	}
 
-	if (unlikely(type != LAST_NORM)) {
-		path_put(parent_path);
-		putname(filename);
-		return -ENOENT;
-	}
-
 	err = mnt_want_write(parent_path->mnt);
 	if (err) {
 		path_put(parent_path);
@@ -701,7 +694,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	struct filename *to;
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	struct ksmbd_file *parent_fp;
-	int new_type;
 	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
 
 	if (ksmbd_override_fsids(work))
@@ -711,8 +703,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 
 retry:
 	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
-				     &new_path, &new_last, &new_type,
-				     &share_conf->vfs_path);
+				     &new_path, &new_last, &share_conf->vfs_path);
 	if (err)
 		goto out1;
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 8ec8fed3bce81d..99b158ca0ce2ec 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -12,11 +12,6 @@ enum { MAX_NESTED_LINKS = 8 };
 
 #define MAXSYMLINKS 40
 
-/*
- * Type of the last component on LOOKUP_PARENT
- */
-enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
-
 /* pathwalk mode */
 #define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
 #define LOOKUP_DIRECTORY	0x0002	/* require a directory */
@@ -63,7 +58,7 @@ extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
 extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
-			   struct path *parent, struct qstr *last, int *type,
+			   struct path *parent, struct qstr *last,
 			   const struct path *root);
 int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
-- 
2.53.0

