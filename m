Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794631400;
	b=0HyFJtwpErQ47P1Vx8S708nfZvcRzVGiB7urkZI4iD9eVS82yLTI+ozRDxce6Tx9x7AX
	 wcykgDnUQK9yypW/m6x+3IOHMM9Nut34+TD1kHTDGjWYW0Zw+GwGfz6jZRpwugxzNkC7g
	 ytCh6A4cyIlE57D78y35jjl3mddWVn9nh3/Ag1AgDgPtslTGLCIWXJj+qqIGNqP+Y4RWT
	 6l5rUZj7UOxqM2nwujkNIVoVR+qKoQtU5iLmgDlKiVS8yKnbgLvvO7uSqSfMdYSQ21diW
	 Dxsw62sZ0/3zzj5jAwZeBD0VOQjoJsouzlcvbNW012U/IGbGKv/Uy43U3TuL1GSVHjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794631400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y7t9REKgfGlB2cjuaCfWq0kJQ63PEYDXgFKtbJVJCwM=;
	b=iMVt+LD1Pd0Szd16GiuoO9gKUte1YKMXH1Jz6FeAIK6E52JexxAtIbCQNGeLotRfmKJP
	 dVImO8Ny5Owvk6cTbfX5uSq25oFP4GDmzVsRmQPNqS0fFwGQXQKzJwelFh+8Lsyjdep/v
	 m9f75ixrk+ZOLOsxRQtTvuEcKeJqOlZPke6ftU8SrffBbHAK0VA2eXPo7L/JPFkIltFBe
	 g5suN7VgIRMreCMNaq4aMn419R0kutJ8fn/fe7uXoiu9qByrJ6+HZiJJkgXgkrmNhXCnL
	 HehaN3DB33L+n48u7zhvOE5E5Fg2ApunOmPbYmM44XWNLsOGn1xIUTq6rH+foOnGoMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VghrRu00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B691606A337
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VghrRu00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894581F000C7;
	Sat, 14 Nov 2026 04:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794631400;
	bh=Y7t9REKgfGlB2cjuaCfWq0kJQ63PEYDXgFKtbJVJCwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VghrRu00qhT0DhtcvbMxfjDGbuCfay6wrTPdeTLSbCPwZsyYzQLwBpUnvCGdPp/H8
	 p5QQEn5yNjEnvgsFilmwi/UGBIneXboL3zk+PAfbkSP+AZLdSTpybvNceDOb3xPqEb
	 YM0M0yi3uyxAc51H7ICzOSphV/+I13gj/6H46hcyR/zdoCpWSvk+0cpbL2WD2ZpEBP
	 HF1tZ43Y6o4PN7BZVtQSzQR8O7kIwFaPIXnxh8km3ITbIbDixAYDBIomokPdvNTDlK
	 Mi/OnU1RAVcn/c96bO6S9uQ+M/bRKHu/D87GXeqCjiUUB4Wwk55Z+FB5ylANxk0sFI
	 HrQDeNzRPOrwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YouYou Yu <youyouyu@amazon.com>,
	Dylan Johnson <dgj@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] quota: initialize dquot cache before mounting rootfs
Date: Fri, 13 Nov 2026 23:43:18 -0500
Message-ID: <20261114044303.2954478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201027-failed-6.6-e21a6f39aa6d@kernel.org>
References: <20261109201027-failed-6.6-e21a6f39aa6d@kernel.org>
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
[ sashal: adjusted patch context to match the existing quota initialization code ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 023a9ab9c7574..c0d7ab8c5aab0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3357,6 +3358,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 7562ee4ff2929..d6295b987ef5f 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3030,15 +3030,13 @@ static struct ctl_table fs_dqstats_table[] = {
 	{ },
 };
 
-static int __init dquot_init(void)
+void __init dquot_cache_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_init("fs/quota", fs_dqstats_table);
-
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -3075,7 +3073,11 @@ static int __init dquot_init(void)
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
index a9be09f96b10e..9a4e5df8f52a2 100644
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

