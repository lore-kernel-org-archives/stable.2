Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794632623;
	b=XUcrEy9cIrdkL/JGv2EmuVkHlQlHVlQaf8X5Ekup876DC9ALVhwwkORWcEniWbakQ74k
	 7xeuqpUOXbTckznOVATbkgvmc63ufWsgWUZCCAgfCj4QrQUTu3qfDGJkK9FIE1IUBIdBq
	 TvkIN+hJCXjjXlgCZ8wZhaetd96vmupbsyCP5CfSURM3OSuEnfIy4807OzVbUglEOAfsF
	 w/FBUWmv8xEwj6sWKeYAru8s1P5Zq+4WC00nE/f7VPd3+6ezPjlKPSpKCdS4Pqm6VD4ha
	 iZPW8IWx4gibKEOBAj6qaoNNWw+g4sg8l9rmEjjgf/Ywtv5wjMYrkZNHvgXI5HtYZ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1tAduaOzKQlcJL3gHfyiK8lX4l1BVm9veymeI+3t3mw=;
	b=Ssn5hrCOxlQroovEGSG9xXUWTAZ3wa8q4LpU49TTB+Yz1iOISVyxdajeuC2ZlZ8QhU1Y
	 2CQJ57O/nKNAxVqNVAbCFA5W1izi1X22ydiOwp1x/mKfdmDd1gw6LmWI0aiLJLAPUATx5
	 ejY+Xrpsp0Iz1h8/MAVjvdWJrnrhNe55odCfoUcCX+jn3S7G/mzs7HqTLhttrqNFGT1l7
	 O9jjQC/JRwUgKv3xNnJrNjxrafn1hSzIrApNzphusHpZ2K5NQdF9rTrRf7YzhIdKGza8f
	 ITIjNYeV5t53Xxc07nMocerx8hipq5wPaheuWEuLPIPOTVwvJjGrIXpy59q/cnajcKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLXPmayI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F28606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLXPmayI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67221F000C5;
	Sat, 14 Nov 2026 05:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794632622;
	bh=1tAduaOzKQlcJL3gHfyiK8lX4l1BVm9veymeI+3t3mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLXPmayIQpremGRlzvKRjdUWDhPwbwZd8rT/mmcQL3l0vOruhxQ0PYtW8ToUDMid6
	 46iK2KA7k2p/i5B33Zn9+T+c9BIBGPs+Mi9aurnhfZklDTaMwPkiOQhP96FWFN7qBR
	 xFWQayu3ZeOrY2WfTHAO9JKlKSRWcp6khB1J3Php4b+7hZ46bqpZEfOqPaQwpH9P9p
	 afQV3TKsZiIGl9OGFkxfTJNFaurwgFcJuWic+EQ4+O4IZ+3X/BZTBamemaRMdrZ5Vf
	 pQEiOYNdDABnShmiCXHLY9scMI5cCd0A08QxjJaoUYxEY2V5pAhy135l+ZPpv7QnGu
	 6lbt7PnzeUxgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YouYou Yu <youyouyu@amazon.com>,
	Dylan Johnson <dgj@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] quota: initialize dquot cache before mounting rootfs
Date: Sat, 14 Nov 2026 00:03:40 -0500
Message-ID: <20261114050329.2994867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202008-failed-5.15-e21a6f39aa6d@kernel.org>
References: <20261109202008-failed-5.15-e21a6f39aa6d@kernel.org>
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
[ sashal: Retained register_sysctl_table(sys_table) instead of register_sysctl_init() to preserve the existing quota table hierarchy. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 89e38520f66c4..b8a8d4c9df552 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3283,6 +3284,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6b53db7e9d6fb..de36d75d022ad 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3043,15 +3043,13 @@ static struct ctl_table sys_table[] = {
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
@@ -3083,7 +3081,11 @@ static int __init dquot_init(void)
 
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

