Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25653FD38
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569741; cv=none; b=acNJ6zisLx/wQDhsBKNfxLpxihuPPMHtLsMrKfq4aWRrLs2xoEO3Zb5UraMTB7zxrA5cxYNE2q0LqGe9CbEPl3unvFYe53V4ujOFp9+8Ozt+IRSEvoGeD0MJ77OuqD9Fl8wDwD497mN/3fn6VKHj5bLHpJK7oT12LkQJG7DMpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569741; c=relaxed/simple;
	bh=Q9OX9QUodhiZFpoHQg6RgES6wXDgLQLMOudwFunezao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huLWH9ffGqYjuvuts/9j4Pil6emP4Daw/LmQSqLbg7RyQTIYHXgbQGUC5EpbLtlNnepYqjpXKFslr5uTNzaYD//z1fKb8HKAISJGjKneETuJHwH2eCeA9UJtlo7ETC0KbomFzzAhsMNPEDJ78+UWUBIahXiXoV09fMdFtxjTQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXAUQoFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXAUQoFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A101F00899;
	Wed, 16 Sep 2026 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569738;
	bh=MCyUfqIEbnu25b3Cme5ir5U4eOJ5l0TCspUM06Qp5fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXAUQoFsR7Bsk2/To+rujJlqzozvpp9qYoHLAPOjkpJAh0a4/vwrf/IHYodLKGW9L
	 x55mIbqIX6jJHGqDaUWQsPmE/y0lvYaRxpmgihq16GlxPigTWRrXdkqHtMpEWNLHoe
	 hy5fzaYyLFcgQp7VrqM/H6BgxR6H+PJOm4RpoypFj9ziFveMBZYBaUdpLnPrccsdNy
	 k5cwMJf9Up+RGZbmhRzCWUXFQlU+Recr+3/vXQ8MMtmn4wgUSEcT7LiojjiKVNLw36
	 gZdMuw0lcALfs+ESnk2rB1bSEO8DQ1dev0CI456tMVof6f40FZmcxg9E6GtRl4mw+B
	 HNHWt3oW4MQIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] configfs:get_target() - release path as soon as we grab configfs_item reference
Date: Wed, 16 Sep 2026 10:42:14 -0400
Message-ID: <20260916144215.3565253-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916144215.3565253-1-sashal@kernel.org>
References: <2026091643-quickness-ammonia-8ff3@gregkh>
 <20260916144215.3565253-1-sashal@kernel.org>
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
index 0623c3edcfb9d..31b3a4ad5ea66 100644
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
 
 
@@ -141,7 +136,6 @@ int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, const char *symname)
 {
 	int ret;
-	struct path path;
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
@@ -188,7 +182,7 @@ int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &path, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -210,7 +204,6 @@ int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	}
 
 	config_item_put(target_item);
-	path_put(&path);
 
 out_put:
 	config_item_put(parent_item);
-- 
2.53.0

