Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190344212E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546082; cv=none; b=G+yfdnRFw/BEJ31mB84RYFEfWJlbj+/YdkcZKftS/F19m7VaaNWncu2n7Y499YhhbOrEuE3aSXGfXIryJF7zHoYOA8wfSS4elWYuRjTBVCYnemwZoQBq2vgt9lVE3vIRu+OYTIs3kgqM3gv8v1nCR0s+s0QbAMhzDjsQiCXYbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546082; c=relaxed/simple;
	bh=49q9Hzhn8exHOVFf/sEn54+iqM8ifecIf8bMbtcaFBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S3Fqq79ZlLHI2I7f18q0N/q5YjXs6ywE7Yxmvn3VHwqNh6oPCM+oEkDnMtm62u2qkb6OivUT0ckTZTx3ozXPz2o0xBaO29LmQn5WPKN779mGVxQuxO4eBXicA6EU9rMwHdRCRySbKiI/tegY3py8IS7sbA+ewq641RCWlt41RX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJlBpqwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJlBpqwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DD01F000FF;
	Wed, 16 Sep 2026 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546071;
	bh=vl//VTixq+qGcpsNOio1wbCLbmboxBCz+DIn2Qufvp4=;
	h=Subject:To:Cc:From:Date;
	b=vJlBpqwfC2ByErg7lgU7jc5floyXLClwAWWrFP9OkKorEB7OXI1MJKFaKsRv+vroJ
	 rnsM1TlHnA5THmq6ghtm+EcLfPXBkenGHZ6/bvziGTnCeYaX4QMacfinhs292/17a3
	 GxdZXG6RS4IBTHNxfUVm5la0oyUQ4/zJ3SenE+vU=
Subject: FAILED: patch "[PATCH] configfs: pin the symlink target's dirent instead of chasing" failed to apply to 6.1-stable tree
To: vasilisalmpanis@gmail.com,leitao@debian.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:05:44 +0100
Message-ID: <2026091643-quickness-ammonia-8ff3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a7c1290eef60711c10289c056ad32ed1f2b47b12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091643-quickness-ammonia-8ff3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7c1290eef60711c10289c056ad32ed1f2b47b12 Mon Sep 17 00:00:00 2001
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Date: Thu, 30 Jul 2026 11:30:24 +0200
Subject: [PATCH] configfs: pin the symlink target's dirent instead of chasing
 ->ci_dentry

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

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 31eb28b27309..3b31c714400f 100644
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
@@ -139,6 +153,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct configfs_dirent *sd;
 	struct config_item *parent_item;
 	struct config_item *target_item = NULL;
+	struct configfs_dirent *target_sd = NULL;
 	const struct config_item_type *type;
 
 	sd = dentry->d_parent->d_fsdata;
@@ -182,7 +197,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 *  AV, a thoroughly annoyed bastard.
 	 */
 	inode_unlock(dir);
-	ret = get_target(symname, &target_item, dentry->d_sb);
+	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
 		goto out_put;
@@ -196,13 +211,14 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
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

