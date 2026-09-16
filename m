Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1B2931FF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566131; cv=none; b=GPHlxfIOk6QzL1rvs2kTIw3T+gooO2IDqP5TsJdl4w5W6Z5nSE2fCHr5lVCFrFfsMqwWl+dfQoxQ8sT7+ASg404d78fS7u90S4xtjPSh7uRLMmTN6RJt3602SiICN6rBSOoos7WU/RA0wMz+k4+cybaUvbNGiN6RvRfbUbATisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566131; c=relaxed/simple;
	bh=7y271+XDWNhcJeohUsT+v69SUDpvt79dA1r4zDYng3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2CQVze6u8vWKhs7HbaSVtoTqQiaIb+wcO3JGDg2bvIFkfJClYjMzmeXQWmPH9ZynHcUEuAW0g6XdC1jsIpxBNDo1rDBsmxG7TcsqM2cA+G+KKdzOf7ogJaN6IfU2PjneoRXFsJobMb6gkkWQawD1IrbMcagOoLvAeiWcZckZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFZxbw7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFZxbw7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C051F00893;
	Wed, 16 Sep 2026 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566115;
	bh=nVaq+Sn+swttMkw3MiK92Q01/Wp+WtLeTuAQIWl0wrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HFZxbw7mvKwOeWMTfrs9iUuPDuF6ddeKyzpqZD4LMrTsjWOreAaWlqCCdXJ6q+X8G
	 coqVqg8VE+dGb1T0xfIyJ0slA8hu9AOuGly9eghpMYw7GqNp962dL2iVShDFHv+vFf
	 kZHqdS/3Vu3bShRdyp7xoZ8Q9t4e8r1QMTDBV9Kp5PogYo1wwwkbHe/odwmG22jBqS
	 F/6MsWQF84+ZkDweGLakl0KmRF1ruK1QNVr8CBBg8PQDgMdhmWCInqkqh3X2nFvekN
	 gHqp6BnfjNCqNW1QawUL0cSGa69oXNCR4Ky+zxaLNKqaWE5iBQwgNuOdbpLOpkeABo
	 mG/g5tGeVRB1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] configfs:get_target() - release path as soon as we grab configfs_item reference
Date: Wed, 16 Sep 2026 09:41:52 -0400
Message-ID: <20260916134153.2707274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091642-reroute-scrap-0bef@gregkh>
References: <2026091642-reroute-scrap-0bef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 1b25dea3867abc9bad6f0337d395c6f0ce4e4f6f ]

... and get rid of path argument - it turns into a local variable in get_target()

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: a7c1290eef60 ("configfs: pin the symlink target's dirent instead of chasing ->ci_dentry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/configfs/symlink.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 69133ec1fac2a..f3f79c67add5d 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -114,26 +114,21 @@ static int create_link(struct config_item *parent_item,
 }
 
 
-static int get_target(const char *symname, struct path *path,
-		      struct config_item **target, struct super_block *sb)
+static int get_target(const char *symname, struct config_item **target,
+		      struct super_block *sb)
 {
+	struct path path __free(path_put) = {};
 	int ret;
 
-	ret = kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, path);
-	if (!ret) {
-		if (path->dentry->d_sb == sb) {
-			*target = configfs_get_config_item(path->dentry);
-			if (!*target) {
-				ret = -ENOENT;
-				path_put(path);
-			}
-		} else {
-			ret = -EPERM;
-			path_put(path);
-		}
-	}
-
-	return ret;
+	ret = kern_path(symname, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &path);
+	if (ret)
+		return ret;
+	if (path.dentry->d_sb != sb)
+		return -EPERM;
+	*target = configfs_get_config_item(path.dentry);
+	if (!*target)
+		return -ENOENT;
+	return 0;
 }
 
 
@@ -141,7 +136,6 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry, const char *symname)
 {
 	int ret;
-	struct path path;
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
@@ -188,7 +182,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &path, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -210,7 +204,6 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	config_item_put(target_item);
-	path_put(&path);
 
 out_put:
 	config_item_put(parent_item);
-- 
2.53.0

