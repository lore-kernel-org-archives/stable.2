Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273610;
	b=ctm73PgUXoX/tHXyWmpgZ0cec70JHKGS+iUFadfBu6IRCIPz5XT7LCMSerzUG2+Jd4u9
	 TmzUrgFF3Dq2PzRKTda9O0a/hSg4moqzPu5VcLVH+IAVg6LYBvVGaehdEGfdiQVKSxjDP
	 9pLRd6kvdlcG4BSKVFOgRiQhFxmcxpstPbZEY05CAGHcSS/fkOomoXdU6wB8wCqsBV4rd
	 GO9fCNroA0rOX7agD46X3LRybd64N/VCn5k7DwXIrLYIiT1z2yDzT/jAGhGC+M+5AuNI6
	 XoPygI8YyROw211lpf3HWuFGNmEPqG6oltVLoH0YicMJwSBnmLYAGlgOJ14xXrpnwcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ugR+zI4VShgNH1RBl/X0bMqrT/nGKlXtHYm8J451f20=;
	b=OpiScrw511ARiJ90Sjz1IMfnCL3kgamWw1fKFGO4E9IXVGNTnoI1vdan8wEaQZ4uHDGb
	 RNky5tY1GhPBxIH1XSajw1vobzBTujqNVO69XyZJ/s6OkgVf23CHenquFXNG9XizM7BmT
	 03t57ir9tNqiNEBiwS2DoQceGysGu9WSMuVDBbbuARC/gAjkN/KVKqA5JXoCNVilJqEDD
	 NH9k+96VHTAaErhPCajsz4qe2TYdqFWaMr/zXAY9LzSGWdWwdax5G5XWZu9rUVBurD3f9
	 1P1+su6OaQXIrYTUOm0+sGaxC8hQ5CyCbE8xfu5iUcUc7rOQCglOG++Qjn9ME0OFtQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS9dFpFU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F960A2617
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS9dFpFU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4C01F008A2;
	Tue, 10 Nov 2026 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273610;
	bh=ugR+zI4VShgNH1RBl/X0bMqrT/nGKlXtHYm8J451f20=;
	h=From:To:Cc:Subject:Date;
	b=fS9dFpFUSS2YgKKeAEb0I0GisrWbLjtxnaByaCBW2g2/fhtzNbfNcD2oyNGpd2gQR
	 kgMyndAehJ4uCYv3wAH7rg1kgC9EB3CgGc6Gp3ZqP+ngT4G6LNpF+3LwPRr0F+LUPN
	 1HaIyEVCYsBB730XZh0S4EfjEiQ0i4u6WsyAMOc6UtwkJ5sUuQSJVItL+EI+55X+Tz
	 IaONuvvpw3wZG0wSAw8G3fMk/ogM2biGZx+LfY7lWopU7QYp9z8uB2SPnvZ2xC1Ihd
	 gVPbairaTmaUMhjG8n2QKTtY3W3pIW09SJDVFz+TjxTZvgA1IsGspeLH8MaViqkQiV
	 ww+oub5EeSmEw==
From: Sasha Levin <sashal@kernel.org>
To: youyouyu@amazon.com,
	dgj@amazon.com,
	gunnarku@amazon.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] quota: initialize dquot cache before mounting rootfs" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:08 -0500
Message-ID: <20261109202008-failed-5.15-e21a6f39aa6d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e21a6f39aa6d0336ffbf5f34e5fa20ff8de36773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202008-failed-5.15-e21a6f39aa6d@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e21a6f39aa6d0336ffbf5f34e5fa20ff8de36773 Mon Sep 17 00:00:00 2001
From: YouYou Yu <youyouyu@amazon.com>
Date: Wed, 21 Oct 2026 18:12:17 +0000
Subject: [PATCH] quota: initialize dquot cache before mounting rootfs

On some systems, a tmpfs backed rootfs is extensively used throughout
system's lifecycle. tmpfs quotas are needed to limit per user rootfs
usage. However, booting with CONFIG_TMPFS_QUOTA=y, an initramfs, no root=
and "initramfs_options=usrquota" panics at boot:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:dqget+0x1ac/0x490
  Call Trace:
   __dquot_initialize
   dquot_initialize
   shmem_get_inode
   shmem_fill_super
   ...
   mnt_init
   vfs_caches_init
   start_kernel

The rootfs is mounted from mnt_init(), but the dquot hash table and
cache are only set up later by dquot_init(), an fs_initcall. Creating
the root inode of a quota enabled rootfs thus dereferences the NULL
dquot_hash in dqget().

Rename dquot_init() to dquot_cache_init() and call it from
vfs_caches_init() before mnt_init(). The slab, percpu and early
workqueue code it relies on is available there, and the workqueue
rescuer and shrinker debugfs entries are set up later by their own
subsystems. Keep the sysctl registration in an fs_initcall, as done
for the dcache, inode and mount sysctls. This only moves existing
allocations earlier in boot.

Fixes: 278033a225e1 ("fs: Add 'initramfs_options' to set initramfs mount options")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Dylan Johnson <dgj@amazon.com>
Signed-off-by: Dylan Johnson <dgj@amazon.com>
Signed-off-by: YouYou Yu <youyouyu@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Link: https://patch.msgid.link/20261021181217.20171-1-youyouyu@amazon.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 37d021d22a7da..a9a919bc91976 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -33,6 +33,7 @@
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
 #include <linux/namei.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3683,6 +3684,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3ad19d7e472f6..a3d5035918714 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2958,7 +2958,7 @@ static const struct ctl_table fs_dqstats_table[] = {
 	},
 };
 
-static int __init dquot_init(void)
+void __init dquot_cache_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash;
@@ -2966,8 +2966,6 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_init("fs/quota", fs_dqstats_table);
-
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -3008,7 +3006,11 @@ static int __init dquot_init(void)
 					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
 	if (!quota_unbound_wq)
 		panic("Cannot create quota_unbound_wq\n");
+}
 
+static int __init init_fs_dquot_sysctls(void)
+{
+	register_sysctl_init("fs/quota", fs_dqstats_table);
 	return 0;
 }
-fs_initcall(dquot_init);
+fs_initcall(init_fs_dquot_sysctls);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 0c64ca674e778..7346efc85d436 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -40,6 +40,7 @@ void __quota_error(struct super_block *sb, const char *func,
 /*
  * declaration of quota_function calls in kernel.
  */
+void dquot_cache_init(void);
 int dquot_initialize(struct inode *inode);
 bool dquot_initialize_needed(struct inode *inode);
 void dquot_drop(struct inode *inode);
@@ -206,6 +207,10 @@ static inline int sb_has_quota_active(struct super_block *sb, int type)
 	return 0;
 }
 
+static inline void dquot_cache_init(void)
+{
+}
+
 static inline int dquot_initialize(struct inode *inode)
 {
 	return 0;
-- 
2.53.0




