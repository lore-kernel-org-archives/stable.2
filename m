Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272770;
	b=iENGrV5Qmk2LOmkkbKavYN5nXBAXT8zKe7y1fu0wCYLcQOA9Dgo4DHWnrMj7JLDNe3NI
	 v3zV1bBfXuoLXdpQ+TBJvn8mKrhiAKd/KnziRdMeFwsfQfGT3OuZwb2gmORbM44Av+LXB
	 lB5Oxus6mlKAYz7+9JxYBLTy5nCEa/FnvOq+gZXEpACVXPuNbyiqLd7MnE9qHaMgAxbaE
	 1CouyTkCRUgI4y9S3TXGm/ZUWpwjTvUJwgJcgZEsq41eKUJnWcLYF7XvNmOyspgSe2zGr
	 85TF87g/tqcYj0EAinoR8mwNvI1vg+5ENOdZEUaIR2tDV/35VRL0IH8mFJEubItm/mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272770;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IqzYgbCeLXs1HfZFfrBXCcBqZS8tKxRBkcLceKYPH+A=;
	b=Ibp4ybFNDuGenpdNaDU7M5Wmg6kc4VELyray8sg+uby0ORTdjGutYWD7a4OuAed2VwqE
	 YUW3G6G9QqZUTOyPKLDA4GGrjCdP+DhUNb2sdJc1StJUp+fR9L0Zjxi8moZpHhHX/21ns
	 iJtuzLT4/fYVBkb3hvu76SSMqla0uU3WnCg44dlPCBmGaolu2PAGhEgynkVMF0Hl/NVw0
	 4OLDy5EFrIiK9YHmGbtdVyIaeV1xhg2/jchBQfdtTdIzZBAluspje9nkLwyDz/oBvMape
	 PW8TMl5MWXS8mAS4P2gS2SDR115xIv4dAPAvfb2yOIyl1cAK+Vd3Efbl9qzQRDXYnUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYBpGYTi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CA60A2603
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYBpGYTi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789681F0089F;
	Tue, 10 Nov 2026 01:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272769;
	bh=IqzYgbCeLXs1HfZFfrBXCcBqZS8tKxRBkcLceKYPH+A=;
	h=From:To:Cc:Subject:Date;
	b=WYBpGYTiPeu4Ag1kRQpfsFrycZELtiZyFPSrwBjJpnWVYeaNSKF00Py18CiZb1XhS
	 JDZp4YMBg179tykYpdL9gk9bQbWHzfPSsae1Afvr3RBOMwKzeWYyhWSRlh4YyPUEyk
	 TMzz+MPJYQToEmkD4utcPshqY5PgUsegInvSVairf98T0+uCTKBWh5AWkMpp48zB1/
	 AF4vuQdAKixHxtiIFrh9W6tn7G8PUvwPpcPo6nWFjHHVd/cmD0VcRZ+rD/laWa7PNK
	 aAwq6A69+LQnW6po1/sEeAAXrquH9y/mPO0j4GsOBcqnriEI7Jh3jzKg7cFF6JuU1n
	 wf/Dm8/MHeQHQ==
From: Sasha Levin <sashal@kernel.org>
To: youyouyu@amazon.com,
	dgj@amazon.com,
	gunnarku@amazon.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] quota: initialize dquot cache before mounting rootfs" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:06 -0500
Message-ID: <20261109200606-failed-6.12-e21a6f39aa6d@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e21a6f39aa6d0336ffbf5f34e5fa20ff8de36773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200606-failed-6.12-e21a6f39aa6d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




