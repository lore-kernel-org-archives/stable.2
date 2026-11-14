Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794631981;
	b=Q2gx8aLGEry/JEhUFc/mCu8t+gj8oUv843spQ6k4/d36t6eVVHc2JrWKWv0SsC0ZGR7P
	 flKTwKdqcq/WThGs4IPqei0OUQ2vQQEOsLr5f1cof8gZuT/oldT/Pi8xcSixvDr/N1xfY
	 sb2B6jfTaC3xXHjY0MfPAdN5301QEOTUKyPl4GVulaNMBQBlxxlGxRFrulBT/3E2UE4IW
	 JOujnnPRMXi5/Aw1GwmOynpkQ7XSJ1O8UoxIEdGPBWaeKchcgDmaedsFHYjngfVi3bLtD
	 R1VJ4+8ZQs0dZYGXX8jL+yWR1Lu4KSsLAi/1LGMbLy9LCRUk4Y9Dy59EEQUzJRJYlfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794631981;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LpgY82RM23vEIdY32vxjZkV0qn8XIJqvZ0gUf3SkyxE=;
	b=yW1DcX+0ePYcC6MmAXjMWuSITiV4Oj2pEKBYSxbzjy1P7a/hoFD85iQLRSsdf79FN3AU
	 xwehvf8yXAbnfo84ciTJubMN2rDKnlsmgswXat2qNJIZPlVDByyk6jbZ//GrmqtRrpKN0
	 +YBGhUZFskLYNzSAOXLJYSxruTQbG+iuTkHNwIdfvn2CdIjhxp/kAEVpRf5xvvyGh1/Bw
	 tqCeA+52+gzJF4fVZRFa6oO3fkEOqhnrESbC8sCpOq3wANshj6V+pwQXNC7qiWgqrsj4/
	 tmG3MSi1cm3EXWiDBBHZOIBAbK2t5p1O3/NcIdCPI48PKEBO/26MX+RJCyY0U++q94g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFXV8hqU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E155606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFXV8hqU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D431F000C4;
	Sat, 14 Nov 2026 04:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794631981;
	bh=LpgY82RM23vEIdY32vxjZkV0qn8XIJqvZ0gUf3SkyxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MFXV8hqU66NKvJ0l3TDHlpsw9oS0GTVHO2jt3rvpHSKxjk8fA0yq8mfpn2O70vaFn
	 WzfzGhN7YIvM+Djt+U+MaKOFzkPRbOu6kVGadeKqwExiCED97PphWT+CoeMZ1pkFMV
	 mGHor86yLFebDoT4xDfc7bow6FrE1G/ZWE2fMmSPYg7mjqmq9kSCb69NYZfWD9qcT9
	 nip3i9OuS982kGUC8e9uTlJd0nmslcwlRy7DicER/CHl8pBNWEWJ8a03+OA/Nch+fo
	 g8wwSKOz2tlb2K59xmiVizwVV1RCbJ72PJ7aq/g8b1ywiZ+WzSCwBehjjlVCeAlQ3x
	 sjbzoRj+J01sQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YouYou Yu <youyouyu@amazon.com>,
	Dylan Johnson <dgj@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] quota: initialize dquot cache before mounting rootfs
Date: Fri, 13 Nov 2026 23:52:58 -0500
Message-ID: <20261114045245.2958471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201511-failed-6.1-e21a6f39aa6d@kernel.org>
References: <20261109201511-failed-6.1-e21a6f39aa6d@kernel.org>
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
[ sashal: Replaced register_sysctl_init() with register_sysctl_table(sys_table) to preserve the existing sysctl table hierarchy. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a03646aff093d..4e1a0827e7ce9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3358,6 +3359,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f296872efda9e..0834ee83f88a7 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3053,15 +3053,13 @@ static struct ctl_table sys_table[] = {
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
@@ -3098,7 +3096,11 @@ static int __init dquot_init(void)
 					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
 	if (!quota_unbound_wq)
 		panic("Cannot create quota_unbound_wq\n");
+}
 
+static int __init init_fs_dquot_sysctls(void)
+{
+	register_sysctl_table(sys_table);
 	return 0;
 }
-fs_initcall(dquot_init);
+fs_initcall(init_fs_dquot_sysctls);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 7078e6f2429af..2a55b6bff1bbf 100644
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

