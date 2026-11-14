Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794632758;
	b=mwRGlcsEpIBjZGmaKmIv2DvaAGmyWuxFmPyP+uXSPetdXuahVsLQkRCRfzlpAbVMDJ2R
	 bERQMttzuz3gOWP0TmfuXtAmR+rlCTT6Cn1KhLpSNWhq5kcQ197+tHMn/bkFMf6FJ6QAR
	 Xtfyio7rQo0jniAOqlOm4p14A/20UbwdBvIbbw4j7Hfh6r49vKm1nKcp67cRMWFDsYqi8
	 d9aU0RneMWJx/Acyq0DNLcJyJLStonzvLV06sZSGzKo9vIYEHffIXnl+dUesy9aNB1xJf
	 BeZ2W9rbBQF7Al/SsY6FT3HaxgEJy8soY2ZptlV2oN4ozyY9BnDoKGO9pQNw8eJTZPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8wSTK/9zVZk3gY6DUDRG+4sxOyp711Jj/hgEln+dla8=;
	b=0uqMXARyYNo0wxtSMyFYTs9y3eQGr925Ny+36lvmJarsYB4eDU+oMQxbUDja2oHgxLHn
	 Iq7yewYKVUXnCk4FX8wPTpyBGO3K/waLLmK4Q93VZBichRmZm9+GNRzegc7m0Rk9mQzJB
	 K8Bj0YPeVsdDnWE0jhQbnm7XgyCIjhdTPrjuL3nQIUKT770hpx4ddk/NjuMttE5X4aDlc
	 NKMMcU0pQ3D5hyODyC6nvQKJqX41ash8eEgTAVefKftDrGAEhppxU04cm8+UiUPQQkuN6
	 Oc501UijbxKGjq5go/cDmBoZWTqlBHCaIZQvl0yQurQibw+rSk676AwpirJwv/X/U5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j08YbWvQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73611606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j08YbWvQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFBD1F000C4;
	Sat, 14 Nov 2026 05:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794632758;
	bh=8wSTK/9zVZk3gY6DUDRG+4sxOyp711Jj/hgEln+dla8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j08YbWvQIilJ1Nz+A53DXzjXiUE0bXcF22ZUagnJnMCEj3Gcw0uRybRmOnne+qxdy
	 m7374h/bcjFE3R1cTjTxn05ET36iJXKukd0njodFdSc3lIcqUupPDf7h8hnumHLoZ8
	 fZl2qLBDQv4hjKmsiIwLtM9MLTdOqWH8h2h96YHHOeMqKyvSaytwEoAUVlcuaVT6V4
	 H78A9tYbMV3Vqm2vZgEi+CvFp5ttUOt/PFsGAI3d5kpRlcQA1COdEC+tqwRBrF9rY7
	 /SEY+/wWzdjUaVRF2feP/+hvz3rQt5kevgJeHpmVeo5iJTV7wis1t8upL+98pgz0Wh
	 TzUDgPBBOCBKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YouYou Yu <youyouyu@amazon.com>,
	Dylan Johnson <dgj@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] quota: initialize dquot cache before mounting rootfs
Date: Sat, 14 Nov 2026 00:05:56 -0500
Message-ID: <20261114050544.3046819-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202523-failed-5.10-e21a6f39aa6d@kernel.org>
References: <20261109202523-failed-5.10-e21a6f39aa6d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: YouYou Yu <youyouyu@amazon.com>

[ Upstream commit e21a6f39aa6d0336ffbf5f34e5fa20ff8de36773 ]

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
[ sashal: adapted sysctl initialization to use register_sysctl_table(sys_table) instead of register_sysctl_init() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52b7211cba915..ce6e4f41d252f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3248,6 +3249,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b4326fc1d90fd..b9f66b38c5d18 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3045,15 +3045,13 @@ static struct ctl_table sys_table[] = {
 	{ },
 };
 
-static int __init dquot_init(void)
+void __init dquot_cache_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_table(sys_table);
-
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -3085,7 +3083,11 @@ static int __init dquot_init(void)
 
 	if (register_shrinker(&dqcache_shrinker))
 		panic("Cannot register dquot shrinker");
+}
 
+static int __init init_fs_dquot_sysctls(void)
+{
+	register_sysctl_table(sys_table);
 	return 0;
 }
-fs_initcall(dquot_init);
+fs_initcall(init_fs_dquot_sysctls);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 8a1ad23da3a11..5f2e39226da60 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -39,6 +39,7 @@ void __quota_error(struct super_block *sb, const char *func,
 /*
  * declaration of quota_function calls in kernel.
  */
+void dquot_cache_init(void);
 int dquot_initialize(struct inode *inode);
 bool dquot_initialize_needed(struct inode *inode);
 void dquot_drop(struct inode *inode);
@@ -204,6 +205,10 @@ static inline int sb_has_quota_active(struct super_block *sb, int type)
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

