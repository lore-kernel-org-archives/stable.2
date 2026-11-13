Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603708;
	b=NfeAt+WV/wOAkuBb4jIuOzmpuSJXxU4n2b6/DjihBBx1f9XYfo/mbLKrWzU10RrQvYxW
	 Ib0CkI2jzBucRFTxGjSMhcjZG59H06IPgf4nYlBJ/lKrnyTu+l/RrtDFsQYNuivmwMK4b
	 Df2KnRUnDZC8gY3x6vSjnVWRKX35Qe1oW72Jm6S/xoxsuPQFrELazuaGE1chr+laprj51
	 /6zp++vLipI6iwRxbESG5WLsHeKcsAZU7CVELGC04CsK8FeRpE9hLzYzDwd1HWUG18rzI
	 Ag/URuvg57Kw/j4/9QdGQ2+ptHwHtkvyUJssLq/xGCPjkcnwhZ8i9D3xJdEoEbg2a1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603708;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m+2PBg+xuY8snzxWrpphNxr/G/qRGP3b9fBq2e2dAcc=;
	b=sSdb7NyFDzvYiRT+jiiE686xMfDhpogK52Wr/r45R+k9BF8ALVC8SVhoAmwe9UnsiyZ4
	 13IstpWjGxDEhLF4TEI4RCzRGElMSPcjSKsAYnFrmgls++yP/gV8PHKbNEJR6oX/6W9s4
	 uz76YqmOQnPII/fhF6CQzCi1pZUtLGF1w4BuLmOdJ2AyDUrhy7Ny1u5jdPfCdZEOm86ov
	 J6+iJHSWZXi+iH8URvbGApgZl9E+0OXjfUdOgCVee0xjB6CwUWCR2DbsX+WDkLSINjPHb
	 m67rxE0BbgpzIAOyIfMfh5N0KAmt4+xDvNAExdRx05sPXFATXgleA3QieZGphCNvd8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rr9FBSg8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147F606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rr9FBSg8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2155C1F000C4;
	Fri, 13 Nov 2026 21:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603707;
	bh=m+2PBg+xuY8snzxWrpphNxr/G/qRGP3b9fBq2e2dAcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rr9FBSg8YB5QOADalGv3N67g7HgmdUZ1PaQ0Lzynn8hYIUCLyxlu8cCh9fuGCrXJd
	 252PETojh7kfjyiKTFjpWF21dGgNL9vE9oFH289MQts9CGoZYjFIX2KY/DkcnimK2n
	 CnG83Ve9NpcIk83e4il2lqPh/qkKT6ilwzX45F6in0PqV82kMnHA4Q5DrX6NWo6Vr6
	 p/P9dVo222f9OH3G9rHAo1Ghvw37yU8cY6LHvhcpzy1HkH8Jh477xwcwj3Ol8XjM+D
	 GBwrTIJCaYL5l5etE823AhR5iQwPAfSIQJfY0/eM26z/gi3FY4EXomXwMVXZknvB5l
	 5TIEqdmNS6zZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YouYou Yu <youyouyu@amazon.com>,
	Dylan Johnson <dgj@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] quota: initialize dquot cache before mounting rootfs
Date: Fri, 13 Nov 2026 16:01:45 -0500
Message-ID: <20261113205810.2538555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200215-failed-6.18-e21a6f39aa6d@kernel.org>
References: <20261109200215-failed-6.18-e21a6f39aa6d@kernel.org>
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
index 84952f6bbf406..77792a9e86737 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3288,6 +3289,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 45a46dc4de4ef..c91076c3f05e7 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3019,7 +3019,7 @@ static const struct ctl_table fs_dqstats_table[] = {
 #endif
 };
 
-static int __init dquot_init(void)
+void __init dquot_cache_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
@@ -3027,8 +3027,6 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_init("fs/quota", fs_dqstats_table);
-
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -3070,7 +3068,11 @@ static int __init dquot_init(void)
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
index f9c0f9d7c9d93..bbe22c22439ed 100644
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

