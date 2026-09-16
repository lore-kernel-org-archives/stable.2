Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974847D925
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573754; cv=none; b=YdCfIHTjFWi2Fy2PqA96IYM1Nzz8/jG2S9DJQUKeVr7tH9NyOZ/BqGibBuSaTBJ8v+2fHbqQ2E9yXcg/URzYXEQtWacYa5Y2aJnUwmaqIjf5rbsXoiuHrdiCNyJZDJkK3+2BOFVeBijY5G47it0xJninhyuh7X3ZC7/q0UoXwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573754; c=relaxed/simple;
	bh=Q9OX9QUodhiZFpoHQg6RgES6wXDgLQLMOudwFunezao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5f+DSJXWEUKjEJCPeXOhe0NB0i+eAVAEkXK0s3ls8WlhbwZ/Ihme2UxReMlaSW+CU7mVYo3F8ncUf4bPdpgg/Lac1UZMpY144Ukt8WNUDfSopf2uzFDRf3xjKhto1B6VGEXC6AOdqqo1JC13HaYCDiXyuww6lX44u+EbGkWeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqAQ3pvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqAQ3pvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC08D1F0089E;
	Wed, 16 Sep 2026 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573752;
	bh=MCyUfqIEbnu25b3Cme5ir5U4eOJ5l0TCspUM06Qp5fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqAQ3pvPoWzKweBYi9tjXBVzAqdJ6FwdiQW0VB85gfzczARF+Xp5PhDNga8K1XriF
	 mt5K8bXJJqb2Dz0g5lX4Pps3zgjsWa0DO5wfioEw4T8gPfEMDNx/ZMjT6CymrD5tAb
	 05Fk+FamEIZ4EIIS20OCymwPR/XmV6Bqlkqxo3hAtrYpalgZQ5Bd5WSXw/lfmEdWyR
	 5MFmjDNfsMh0ATvCbXPeu/16M1zoRr+BvMFun9kp5Fbo36cAV+unuK92baBDjEKTSV
	 w7cCp2lPbUbis/4ssAJIY290iM7ElkotDfRDKQct1sdFV4/ZoArB4iI8zMzjzCwpFz
	 ByISJqD2wKg5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] configfs:get_target() - release path as soon as we grab configfs_item reference
Date: Wed, 16 Sep 2026 11:49:08 -0400
Message-ID: <20260916154909.4167397-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916154909.4167397-1-sashal@kernel.org>
References: <2026091644-washstand-tweed-f09f@gregkh>
 <20260916154909.4167397-1-sashal@kernel.org>
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

