Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF354B95A5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573755; cv=none; b=JA4s9QWh4eQtdnvDTou9r8NQMeWOmquzd5s78ub6023AclzMiCUr4/I8OyMolChhJPcKB2FeRb8cjutP6SBr1OM/FKNv+vc0a3YLSBMPsbvhkPSO9eUl3p5kzx5nG5jJqgMZTgxI50nMZt78wGlTbMxzMLuUvj/F77TpBTX5hLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573755; c=relaxed/simple;
	bh=0j9LmuSz/S7KLGjPVlrvtHmlAHuUvgo6r5kx5NWWg8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icVgr2NabWNc/rlWmTx7hBnr1XxcRx1Fe9PDtF38Uj8my6yvMnyHe9z7B34XDkXxlw8OxQ4YdV9aX0wRUyOIFzxPxjXdnjUxk1/f/MsOFcWrmtIzvaJvHynJgnkjutwL+o/3XewOzPcuRBhb+3s7CaJdkkjst5GRKWnYhaecZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ/h8oj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ/h8oj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC13D1F00893;
	Wed, 16 Sep 2026 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573753;
	bh=P1BD/TRayNCwNCx3mEnQNNldmydQjvNYjTXB88/AVMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CZ/h8oj0N52ArybarW218e2U01tE9HV9CdbtAeqyoxWs20cTADJr+Y76f3rIIL6dx
	 YBinG40M62rLl9ZW1sguACTh2cAALEfiGdITS0nPcUaYbyEyHD2fZV4ZewnbIPUrYf
	 i9Y62y85Y+7pieez59RO+mSxG+1OAK0iP5PM//RUIlz7F1ZTCgMpDIEYrqhSC2C4D0
	 cWFdOpWDceBWMa3mQtJCaCh680Ce6JTa0r00clUAdSqAxHwI+Muo2X71ex8UV0yYqU
	 U3xtDb6D2BVd0TD0jDspOJMqMux4M7UUFZ7R344A7j8mAd2+cqxybEI+iJ1YGxjDdU
	 UIvy4TFWn9loA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasileios Almpanis <vasilisalmpanis@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] configfs: pin the symlink target's dirent instead of chasing ->ci_dentry
Date: Wed, 16 Sep 2026 11:49:09 -0400
Message-ID: <20260916154909.4167397-3-sashal@kernel.org>
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
index 31b3a4ad5ea66..feaccac55d8cd 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -76,9 +76,9 @@ static int configfs_get_target_path(struct config_item *item,
 
 static int create_link(struct config_item *parent_item,
 		       struct config_item *item,
+		       struct configfs_dirent *target_sd,
 		       struct dentry *dentry)
 {
-	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;
 	char *body;
 	int ret;
 
@@ -115,6 +115,7 @@ static int create_link(struct config_item *parent_item,
 
 
 static int get_target(const char *symname, struct config_item **target,
+		      struct configfs_dirent **target_sd,
 		      struct super_block *sb)
 {
 	struct path path __free(path_put) = {};
@@ -125,7 +126,20 @@ static int get_target(const char *symname, struct config_item **target,
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
@@ -139,6 +153,7 @@ int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
+	struct configfs_dirent *target_sd = NULL;
 	const struct config_item_type *type;
 
 	sd = dentry->d_parent->d_fsdata;
@@ -182,7 +197,7 @@ int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -196,13 +211,14 @@ int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
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

