Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599212;
	b=kREIJkwyClmmFQ0TzEQKiddkU4WtvCJ5ygEFHHni7PWQY3Q879aj7hzbBA/T5fRWQjez
	 8XPJnliv8uXu1JMIVDudsT5duSa22V3zhCmjUlVl8AI/+ZNxZp8bjMoYVbgtvi9NfE0jk
	 0VCSYqEvrVdoV61kMCM17XLOCTmS16N4zmodByKY3+YAMjhDS/LiUre8jipAKpkCWpCyT
	 n0l1kaC7P41+k5jJhb39bP5FgZd62kUbIrCRbXLOyJwyzPP/dn7VDW6PPzcwm5rpU+kTp
	 E2u4uF33foe/8PLNVvNyukCx696MD2uODOw7USiTH6L/FQQ3rsJpX1Kk2OL/tsFXRcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I1ZjTkbIjaRmMwU0ovOWZLbxvUQmd2YIrZqESAIRr/k=;
	b=zkJr4a7dL01Xtv6MZfOqt18WNiVIr9jFI4xWyuv7atyR+I9CsOKum+yvYSiJ/v9K6j53
	 bVCvTZv6ebDZ8nCjKolCmXQgrjyLP6aVCvyXDkMTVXsbN5Bj5wJMaOTiWLjDZBTd9PfYr
	 2fWTLzcjbXcaKihVp3hlIAFmjpGdP1BSLJogpuoJFfCyf4nNcUFr2e3ZQ1bVvW31t5HI6
	 BUTEsWM3rOTAti/WYB8DHK62Nh3xIfcX6uBL/DKToUJFukXoU2kBE31U8tPiKctUYKgfM
	 TAPI5PmLFX2sZ1i5hSkLrynuYFICj8+YGOrOPpaPnTDEFnzoOqpmL7DZJSo8ODCwNFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZUU3/BGa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFEC606A335
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUU3/BGa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4F21F000C4;
	Fri, 13 Nov 2026 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599212;
	bh=I1ZjTkbIjaRmMwU0ovOWZLbxvUQmd2YIrZqESAIRr/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUU3/BGa+62kZvIR1yPYJ3ht2L9tG3wtc9NSHRPGgNLMl67dKWlYUQIGc8G+ygekN
	 KkZEdFo2odljOVTWAdGNeziNSed7ZOrd2nvVFVvuumGpnoGmrgbc++gXBkP5QW0uu6
	 UTLx8jxRWJUNSFvoNy2RJS92Q5GyNF0QGOtbWLCPMm+iD2ENp3y3mXQa5doHYukRRH
	 16hQ53y2nZn2KASecT+abcCwjU3jK9LbEeSle3I16JDoKgvFGdP6QYDt2OxvJON0XL
	 cwbP2Spc+Y5KMOHKV3CglSItHZrchIVw21YENbuRsGnjHSP0bUpwoTHoSaOzI1JFV2
	 uwS2vEzEI74Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YouYou Yu <youyouyu@amazon.com>,
	Dylan Johnson <dgj@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] quota: initialize dquot cache before mounting rootfs
Date: Fri, 13 Nov 2026 14:46:50 -0500
Message-ID: <20261113194641.2480996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200059-failed-7.3-e21a6f39aa6d@kernel.org>
References: <20261109200059-failed-7.3-e21a6f39aa6d@kernel.org>
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
[ sashal: Adjusted include-list context because the neighboring namei header is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c              |  2 ++
 fs/quota/dquot.c         | 10 ++++++----
 include/linux/quotaops.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f9c9f3b1ba807..7d7d96a098d78 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/quotaops.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3537,6 +3538,7 @@ void __init vfs_caches_init(void)
 	inode_init();
 	files_init();
 	files_maxfiles_init();
+	dquot_cache_init();
 	mnt_init();
 	bdev_cache_init();
 	chrdev_init();
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 1c78c695d0ddf..cd142c9cc7e0c 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2942,7 +2942,7 @@ static const struct ctl_table fs_dqstats_table[] = {
 	},
 };
 
-static int __init dquot_init(void)
+void __init dquot_cache_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash;
@@ -2950,8 +2950,6 @@ static int __init dquot_init(void)
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
-	register_sysctl_init("fs/quota", fs_dqstats_table);
-
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
@@ -2992,7 +2990,11 @@ static int __init dquot_init(void)
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

