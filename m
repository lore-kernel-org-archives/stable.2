Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603933;
	b=CCYlZ1JqVpE/sSBfwI1KpBAwZf+Xx3fEppjaw8M8IIIB2I16M03sVd5rbVMjj/IwXEsU
	 lzeB1nJ9SIie8SETXcS/apXcjRNLaiA+eG2sjhSvDvA1/ZUGA8grBeTfcZzUXiYJtRP+R
	 yhkBUO3sxd4RdVrXc0rXGcXkR9VUPXAvLBr+8z88NlCkeQkOfJJvhe53xX9m2pAMcxZl5
	 wuPN7iHtI+EW6H+aKxTlRT+JCg8l+2cgQxg/+fiAKBeI8j9eC6qQCmShCbgemotSTWRPJ
	 kBxyr9oNRK9ZQrkG9v7p+1Tfqhy//s7oZhsIzyRErAmPkliUVyQS6T6ch6l9Bl623qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZayWLYxFUM89a5T1rj9akSZzsWWWVEjqgqK7zgIR1Wg=;
	b=FREJGO4TmRHSqVb1UiRACf8S76lSeHkfuXUTCvVMqJAuD9oBLmwV9N4NHeyg2KmHrmvM
	 NX49hFydZg+eaxrsklDMDcVe2/2KQHpyv+1DV45XgRH///w3MZk53+cxCA+mX0maZ8XRj
	 VuyOuNDHpmvHOFftRSuoxMkcHir0tNVH7Rcmu6Pwov1B6bAaO8hYjpXsCnUGKiRDtFr8X
	 czVwU0WhZiS+AMkLaMbYfomU51GGDumoyxRXwYQGIFLUsT4jGRg1wVWFAuwQKnWrANKyh
	 Lx05VIJ2whq1wEBVlFF2DdV7FUl2dADhCTU7kRmRVdkt902l2bK3WUFjoyR/Xuec+Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjgYdSkK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA0606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjgYdSkK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1415F1F000C4;
	Fri, 13 Nov 2026 21:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603933;
	bh=ZayWLYxFUM89a5T1rj9akSZzsWWWVEjqgqK7zgIR1Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjgYdSkK+nGjh7RYiVl28YSXyvccz0ZcnZEP0Uin2snrL/eZUCchpXkfFbhUDs5VK
	 qQTstnZyciJVFjJ34rH2E7CpVFc186rEWtnWwyvpxJkJlxbcy1rY3A6rZDn6gY1UtC
	 anYLAep+62qiOjJMBsH1sK1qwhi/5ao+HSLy9Zry81haTKz1ETCZOTT9Vi/Msk7loS
	 BRNPek3vsmC4TlUtY0rOalg/tnVEO8CI0YJha0IBoBI19AdkK9QcpXfYRqVEAg4ZRB
	 9o0ucgi1E0Dpn0nRQ7qG8Cie/SF0BiEtkHp91xG8YtrW1/qqT7opTm8ZbbtsBSRP5S
	 lPFcpHV27gf4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YouYou Yu <youyouyu@amazon.com>,
	Dylan Johnson <dgj@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] quota: initialize dquot cache before mounting rootfs
Date: Fri, 13 Nov 2026 16:05:31 -0500
Message-ID: <20261113210521.2634258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200606-failed-6.12-e21a6f39aa6d@kernel.org>
References: <20261109200606-failed-6.12-e21a6f39aa6d@kernel.org>
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
[ sashal: adjusted context to match existing quota initialization declarations and surrounding includes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ff9d401e18539..55270ad327b48 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3204,6 +3205,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 7c3095622872f..1912ebf2bafdb 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3020,7 +3020,7 @@ static struct ctl_table fs_dqstats_table[] = {
 #endif
 };
 
-static int __init dquot_init(void)
+void __init dquot_cache_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
@@ -3028,8 +3028,6 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_init("fs/quota", fs_dqstats_table);
-
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -3071,7 +3069,11 @@ static int __init dquot_init(void)
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
index 2334a02c30149..06563b0baccfd 100644
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

