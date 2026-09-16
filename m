Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07F4DA545
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568993; cv=none; b=J36Y3VxcgZMnKT4pegs2N0uvMf7spqM2dLztsv0Ueff716Vk9p2ucaT3qDkY29XVBnSTlZkrBeGDip4ksx+UO4mrmPdvqH3LYcmH4vWz73Z2PgIY1ogFX/aBTHLvWZtsA96iJKlc1PGbR3Ev1TWMFSYAQPYb44DPlKVGwb1IQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568993; c=relaxed/simple;
	bh=7y271+XDWNhcJeohUsT+v69SUDpvt79dA1r4zDYng3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1hXDspzMMGIGRIKgs5QkZ043K2kByYSF7e0VEmWrjqs4g9pE4sQvRSBvEZzCVhjrNDHI6GcwFEx221jfGIa0S5iomvTBqTh1cwv2eFcESW+Q6GGFU6PU19WUn5Cpdj3Jb5IFUEX8hlW3AClE6LbjvNO0QH3kXqQM+hipxxVZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewQpFG4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewQpFG4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABB51F00893;
	Wed, 16 Sep 2026 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568992;
	bh=nVaq+Sn+swttMkw3MiK92Q01/Wp+WtLeTuAQIWl0wrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ewQpFG4WcpQKYI0578dQeasMAIrtLcqGrmDljLGF4yr2iCp2pFamASKvFsN7MKB/e
	 VEpigbkeGTOasbaor62GNeK+n+wfbVpg/YpXvx63RJBwfn69p/OOasJndqVz9tKuVm
	 9xhLMJ3B56AlO1CBL4JrR8+PlpRj+R/BJQPo/1jjT4JmfHBWKTyIF0mPKxYJP2erb3
	 DLqAxQ15m6fDvb6larnBEGF1iPzjrq3cOwYTHDct45CoxdyQff6e55H/T3Tzjl6X6q
	 Zd7Fsj1IIYYhWhY8Sm62ClLqy5IN/scTp7wCHooYgVPjg4IZ6093N2C89R49+WRS9J
	 D4iRmniQIWTGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] configfs:get_target() - release path as soon as we grab configfs_item reference
Date: Wed, 16 Sep 2026 10:29:48 -0400
Message-ID: <20260916142949.3271509-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916142949.3271509-1-sashal@kernel.org>
References: <2026091643-swoop-reproach-dbbf@gregkh>
 <20260916142949.3271509-1-sashal@kernel.org>
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

