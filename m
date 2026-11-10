Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273030;
	b=F3lJy0X+oScXXHGWek4IfHugCFBBNzMRXPrWUkHfoX7gF1Na79mz+8o0PkMXy3GnubSy
	 J6QYGMYxtOmS5qMwlyIKlWQEk22ZZOwm4pKN5RmCk76vsc3cJ5frROzGo3qtsRWS5fzes
	 nOuURxWTdxcdhMHggb0NZjEeFOtvQ9xkAdcf5Db96f7zSkHpDnDGqfWa/hk47MzqUflZ8
	 OCkQiPfio301hhijBjWf+t/uEj68uly/cerWNiI1Bxp/uTNHTQSE1TrS0vXabNUUtN9MQ
	 PXv0zshECsrtjyEBk/ueRU1V4kBvCo0ev1bMeKlJOBE5uTH7jqphQJoikCD35BerFHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273030;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O51aSnqW3RXyBYZz9SmlFDLw0sgDgiL+1GQuu1DmUwU=;
	b=yR7hy1qwwSFJoGwvSEMpjRLLvzXMkqDtptu7XrP5z/ndgZOrCj7LKqRlicJ61WFx3FP7
	 tKPqOxodIiavufm0I4A839X2/RFedsUBf/mcISSTLYCaT3EtS9Ng6+uvel3d/LY6yzOUs
	 2uP9CAaZFD47txeofXDPqkUzmfPrjKN67XlAFPSsOyGcjEFy9+XkeUa0ugPWPY40wb2S6
	 5F70KidQmpnbHP/7ENmKAcwfDHcac/Pqs4sFlBxo5muHiT6fQdQXssQImwvN/OeSfUv+i
	 TIEOTs2ZIPALRfuW7bjJp3oICrxLJw1CJBMWKoMA/5VPOOVLYFovhqNPN0TjW1r/NTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Uf5/dUI4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uf5/dUI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B391F0089F;
	Tue, 10 Nov 2026 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273029;
	bh=O51aSnqW3RXyBYZz9SmlFDLw0sgDgiL+1GQuu1DmUwU=;
	h=From:To:Cc:Subject:Date;
	b=Uf5/dUI4xGitv4uei2rIIh/SKW7sjXILc9Xd4GZz7QPsXpWMSFtQhBRvvI5npR2HY
	 AmtVjIfu1bgnXdF3R9a47SZmho+uDZUwp+6Unhl2+3UwtGb6EaiD6cUq614ck+hJMk
	 NXYUuT8Adiisp7VM7fY8fhyqmTKlX0QWyPZPv1x+vILHiBTyl/mQoDWJvsP81AtZiq
	 CCWIMex7XhpiCLeooR602YIH+XHrxMknsWbL/AG2DaHhS6S0q42XwCnYtJkkm547TF
	 vF4nt6nwgGN79xRKV1K75eTff/70cvGuF/Y2r1xt8Pl7L4DQu57nUgxVkp22BVon/1
	 NKhf9yEMLI2cA==
From: Sasha Levin <sashal@kernel.org>
To: youyouyu@amazon.com,
	dgj@amazon.com,
	gunnarku@amazon.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] quota: initialize dquot cache before mounting rootfs" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:28 -0500
Message-ID: <20261109201027-failed-6.6-e21a6f39aa6d@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e21a6f39aa6d0336ffbf5f34e5fa20ff8de36773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201027-failed-6.6-e21a6f39aa6d@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




