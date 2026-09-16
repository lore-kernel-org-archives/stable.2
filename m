Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0774AAC71
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574379; cv=none; b=OXau5pOVqpdZIVw6FgMQ39IbV9xjaG1OnTqDTgI4xFrao0E+bLqLu96lDOQbKnmL2lw1LGq3LXwVOYAsDGydrB6qOi2xvRoKkVyou0O6QeFUExFCQIOcEc4bO4WCQY9MllAMeI156UO4S/dQah8xKJH6dqoCFHw29zSEgJgQ0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574379; c=relaxed/simple;
	bh=pgNTIQAbRIEjn+iBVfVuvCtBENIKVpDQKUi/IU+Pb2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh+GmOcwDhdChoKM+aO0hfDOr7znFLVKWlqSwy4MMZ9a0hqNxtoL90ggvmGXD4m37+sKA/rIFdMuBTsR33+HOob9D23ldUTdIzE83zzhSTSZZrOnSa/bufoERtamglTUhoJ7YVzNm8lyR93sKOlZDsrN+Si2WAJwZxO+R9B0f5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+AQ2WD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+AQ2WD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952181F00893;
	Wed, 16 Sep 2026 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574376;
	bh=S8OY3tElOBA1lJhFtI8Pqrjnf48KdqjddzCj3XQar3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+AQ2WD06YsUbCfHkoeiny9YDhMS5zCQ+i0HIVEi4lXeRj16VpS3runRJ8HrArHLr
	 qUdh+smPRmMI5+I8WX5iaDFLJfTlgI6bG81TV9+D4J1ETotxtZcQR2+/w4fmJV8z5v
	 hClAv864QE7Eeo53PRE1hxaTtS6NwA8Q3VuhaGDuIt+O0Ze/MkP6b86cS4X54bqC2S
	 U2p6pGZtFL+a//nP/TTZ8PncCHFudlEw3UK9+mvS2bqPOybE1j3gnAzupeCo4a8xva
	 e+tIyfCbDGwjlJee5Y3VpYD48Ne4538vXEEtgm1RrkJ0t1DJ1kZGttZv6eV/PQ0YAn
	 sOBZHE699zL4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasileios Almpanis <vasilisalmpanis@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] configfs: pin the symlink target's dirent instead of chasing ->ci_dentry
Date: Wed, 16 Sep 2026 11:59:32 -0400
Message-ID: <20260916155932.28397-3-sashal@kernel.org>
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

From: Vasileios Almpanis <vasilisalmpanis@gmail.com>

[ Upstream commit a7c1290eef60711c10289c056ad32ed1f2b47b12 ]

create_link() reads the target's configfs_dirent from
item->ci_dentry->d_fsdata, relying on the item reference taken by
get_target().  That reference pins the item, not its dentry: the dentry is
pinned by DCACHE_PERSISTENT, which configfs_remove_dir() releases via
simple_rmdir() while the item is still alive.  A symlink racing with rmdir
of its target can therefore find ->ci_dentry freed and its dirent
released, triggering WARN_ON(!atomic_read(&sd->s_count)) in configfs_get().

Take the dirent in get_target() as well, under ->d_lock and atomically
with the item reference, and pass it down to create_link().  A hashed
dentry has not been killed yet, so its ->d_fsdata reference keeps the
dirent alive there.

Cc: stable@vger.kernel.org
Fixes: 7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Tested-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260730093435.195441-2-vasilisalmpanis@gmail.com
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/configfs/symlink.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 64a57c0b67c14..0acee5f17d947 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -78,9 +78,9 @@ static int configfs_get_target_path(struct config_item *item,
 
 static int create_link(struct config_item *parent_item,
 		       struct config_item *item,
+		       struct configfs_dirent *target_sd,
 		       struct dentry *dentry)
 {
-	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;
 	char *body;
 	int ret;
 
@@ -117,6 +117,7 @@ static int create_link(struct config_item *parent_item,
 
 
 static int get_target(const char *symname, struct config_item **target,
+		      struct configfs_dirent **target_sd,
 		      struct super_block *sb)
 {
 	struct path path __free(path_put) = {};
@@ -127,7 +128,20 @@ static int get_target(const char *symname, struct config_item **target,
 		return ret;
 	if (path.dentry->d_sb != sb)
 		return -EPERM;
-	*target = configfs_get_config_item(path.dentry);
+	/*
+	 * A hashed dentry guarantees that neither the item nor the dirent
+	 * have been released yet, as removals unhash before dropping.
+	 * Grab both references here. An item reference alone would not keep
+	 * ->ci_dentry alive.
+	 */
+	spin_lock(&path.dentry->d_lock);
+	if (!d_unhashed(path.dentry)) {
+		struct configfs_dirent *sd = path.dentry->d_fsdata;
+
+		*target = config_item_get(sd->s_element);
+		*target_sd = configfs_get(sd);
+	}
+	spin_unlock(&path.dentry->d_lock);
 	if (!*target)
 		return -ENOENT;
 	return 0;
@@ -140,6 +154,7 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
+	struct configfs_dirent *target_sd = NULL;
 	const struct config_item_type *type;
 
 	sd = dentry->d_parent->d_fsdata;
@@ -183,7 +198,7 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -196,13 +211,14 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 		ret = type->ct_item_ops->allow_link(parent_item, target_item);
 	if (!ret) {
 		mutex_lock(&configfs_symlink_mutex);
-		ret = create_link(parent_item, target_item, dentry);
+		ret = create_link(parent_item, target_item, target_sd, dentry);
 		mutex_unlock(&configfs_symlink_mutex);
 		if (ret && type->ct_item_ops->drop_link)
 			type->ct_item_ops->drop_link(parent_item,
 						     target_item);
 	}
 
+	configfs_put(target_sd);
 	config_item_put(target_item);
 
 out_put:
-- 
2.53.0

