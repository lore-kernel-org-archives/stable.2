Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384D46A611
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574378; cv=none; b=rlEvS5Yurl/C2NJ8+h/+LN6m3k/rVFzskPsq9Zv2dPreJ7gk3lrONz/3mdta8bgK2BJ5as6ruadk4T8lwdQRLbBNyJNFmZBq3wr3s40n3uoI4Gl47Q7PkG4F2z2+jfRhSlsNXMFlJuDly86AOUpbGsSuTGsMyIPiOqSTwCihhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574378; c=relaxed/simple;
	bh=BDV7XWTzcWHLY0Ew72QlEjVvPTeiguJFBx1/1pGChc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSNISgWDDi010fEHkTKIx9LB0DZuZn6EIpnr8ixI2B2SkMUTZDGNrHm7Qi2J0yOHRbbcFgjbUmT/n4LFkEsj2V1E6pXCct5P8dNHv3yU/dZ4gnf+7QVqsGPpK8yNRl7hnWSnuA5JYk8JBcCEfEqstq7NpNdL9RVyQvNhatfAFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF9Muozg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF9Muozg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92571F00899;
	Wed, 16 Sep 2026 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574375;
	bh=cA+UykqY7UUxLrSLeFZxXQCt3ZuY+Ykz/Kda78G4xgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kF9MuozgDHJJc2t0FUwkSGu5iThS+oUzs+vKFpLMtYXGGM243JvsO6TsL2kw853mE
	 K8VfbPTn1kOWCGHHPueB3Qwnx1fpkhRnqznsr0KXZW11ZTNFBYGqfnPBvmTnzhxbEo
	 Rl3j5EmAV3jnuBMzo7zCIuQZwRxzx5Hmt759LVyzk17bdKVCfHvd1y3K9aTmf8YCSf
	 Xt2/yaXB/10sIB9a5zmb0FR/t+Vh74XELt2wJpOyz01FEzCd2Gq8upcta+EgtdDdZH
	 at4D4DR99G6aSas0eHThO8NR1zWx6HEtfmWdPjuV3b6egLmfkNMPjkRoGrnn4L3Bjd
	 jhS7SaNISpiug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] configfs:get_target() - release path as soon as we grab configfs_item reference
Date: Wed, 16 Sep 2026 11:59:31 -0400
Message-ID: <20260916155932.28397-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916155932.28397-1-sashal@kernel.org>
References: <2026091645-grappling-craziness-559e@gregkh>
 <20260916155932.28397-1-sashal@kernel.org>
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
index cb61467478ca8..64a57c0b67c14 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -116,33 +116,27 @@ static int create_link(struct config_item *parent_item,
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
 
 
 int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 {
 	int ret;
-	struct path path;
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
@@ -189,7 +183,7 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &path, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -210,7 +204,6 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 	}
 
 	config_item_put(target_item);
-	path_put(&path);
 
 out_put:
 	config_item_put(parent_item);
-- 
2.53.0

