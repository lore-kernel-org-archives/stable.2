Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594162;
	b=h1s4M6spbf61hWKmxr+VvwZNC8tP9q7EJzlXDPhIP02Apo9GzwVtx4FOK2ZoB/W5HQOF
	 V0kgMXkyrzwQt4OVobrAlDQ57aKs3MtbiupqpZj8zTLm5MaVL08YryxSnhpCtpHVutUpi
	 0cF7i5M0KNKzFh1UqRvZE6LpjFCNSHn2c+eVv1HACYEdgdPQOpAugK0WT/o7KIIzBr/hi
	 xSWA5CiGyFfslBdGjEahVJ14B2rLPsEAwWN7vKgAo6TqgINV9WlfhqrNpKPF/CS32Pn4t
	 DOlPtzI7DhWBUGYx6MHqeZZJFwFfAZR3Ys9vYOmxT+huWlGOS6aNspTWHRJq7LPsj9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594162;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ACYpnNYOWq04OYilVKqgT++RknIZvGrs14dqSh129S8=;
	b=XdOCHUt4MWInFmlMNQZ2XyPRnS4m/Fudy/e0uuVVHNSv7fBINUc4Iw76qra2W0CtH9tV
	 U9yJv6krLvtA2WKWnyAg3VFYNW/EYBlUgRQaFpseiL1uWW9VgPfUMh+gCPCgCRqPQSg/w
	 RamdFQDMzsWOrTJg5mg4f9U1iWmlnV4RzVq+LKHtJOge+UHwwEFHomHWfznnD2SKoNYL2
	 SMhD4C4CyGvH0oouENoBLjypBupdTFfQWuQkCm+aWb5BPMr2xtCWo0ucSiOqrnFsCRHoz
	 +YyvniVNuH1iX38JZe0fnzSBnFZtZHkMtrE2XSSP7j1WiIi8gmh8OTtYiTsKVcUCC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=C4zmSCGa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A22606A33F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=C4zmSCGa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20451F000C4;
	Wed, 21 Oct 2026 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594161;
	bh=ACYpnNYOWq04OYilVKqgT++RknIZvGrs14dqSh129S8=;
	h=Subject:To:Cc:From:Date;
	b=C4zmSCGalGWOeLhq4F9TENQSzaTobpGVManzEJa/9ydxj0XT/cttT/0406/z5lCF6
	 xKrN+5vEtmDW+vWf2GqDWpWRWDl6zqWc3dSLv1d8PPh7gcXhcTIuuo5vPhxse1isKA
	 R9YdsVobIsOyZO8MBfIBfg9011abxm+uBOyitCGg=
Subject: FAILED: patch "[PATCH] ext4: free the sbi after a grace period" failed to apply to 6.18-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:38:02 +0200
Message-ID: <2026102102-likewise-pointless-8de1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c17b44266a1f9fcb49b894d4611d1254bf1aa313
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102102-likewise-pointless-8de1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c17b44266a1f9fcb49b894d4611d1254bf1aa313 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 9 Oct 2026 23:51:51 +0200
Subject: [PATCH] ext4: free the sbi after a grace period

ext4_get_link() follows a symlink that keeps its target in a data block
in rcu pathwalk mode with ext4_getblk(EXT4_GET_BLOCKS_CACHED_NOWAIT).
That reads s_mount_state in the ASSERT() of ext4_getblk() and again in
ext4_es_lookup_extent(), and the lookup bumps the extent status hit or
miss counter, all through sb->s_fs_info.

ext4_put_super() destroys those counters, clears sb->s_fs_info and frees
the sbi without waiting for a grace period. A pathwalk that is still in
ext4_get_link() when the last reference to the mount goes away then
dereferences a NULL s_fs_info, the freed sbi or the destroyed percpu
counters.

With a pathwalk held up in ext4_get_link() while the last reference
goes away:

  KASAN: null-ptr-deref in range [0x00000000000000a8-0x00000000000000af]
  RIP: 0010:ext4_getblk+0xf0/0x640
  Call Trace:
   <TASK>
   ext4_get_link+0x26c/0x410
   pick_link+0xf96/0x1780
   step_into_slowpath+0x9b8/0x1250
   path_lookupat+0x484/0xb00
   filename_lookup+0x1f1/0x5b0
   vfs_statx+0xd7/0x3b0
   vfs_fstatat+0x4d/0x90
   __do_sys_newfstatat+0xa0/0x100
   do_syscall_64+0x10e/0x5e0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

So far that has been hard to hit. umount(2) waits for a grace period in
namespace_unlock() before it drops the mount, so only a mount whose last
reference goes away elsewhere, like the close of a file or a chdir out of
a lazily unmounted directory, can race a walker.

Keep sb->s_fs_info and free the sbi together with the extent status
counters after a grace period. Split the counters out of
ext4_es_unregister_shrinker() for that. The shrinker still gets wasted
in ext4_put_super(), the counters go with the sbi.

Fixes: 6493792d3299 ("ext4: convert symlink external data block mapping to bdev")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009-work-fixes-rcu-v1-1-7446d2d335e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 724a27e8be61..af70bb26bb54 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1774,6 +1774,8 @@ struct ext4_sb_info {
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
+	/* ext4_get_link() reads the sbi in rcu pathwalk */
+	struct rcu_head s_rcu;
 	struct mb_cache *s_ea_block_cache;
 	struct mb_cache *s_ea_inode_cache;
 
diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index c3836ecb89f9..2e997f228330 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -151,6 +151,7 @@ static void extents_kunit_exit(struct kunit *test)
 
 	sbi = k_ctx.k_ei->vfs_inode.i_sb->s_fs_info;
 	ext4_es_unregister_shrinker(sbi);
+	ext4_es_destroy_stats(sbi);
 	deactivate_super(sbi->s_sb);
 	kfree(sbi);
 	kfree(k_ctx.k_ei);
@@ -340,6 +341,7 @@ static int extents_kunit_init(struct kunit *test)
 	k_ctx.k_data = NULL;
 
 	ext4_es_unregister_shrinker(sbi);
+	ext4_es_destroy_stats(sbi);
 out_deactivate:
 	deactivate_locked_super(sb);
 	kfree(sbi);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 76038b6c3655..3bf0a6cdbec2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6409,6 +6409,7 @@ EXPORT_SYMBOL_FOR_EXT4_TEST(__ext4_ext_dirty);
 EXPORT_SYMBOL_FOR_EXT4_TEST(ext4_ext_zeroout);
 EXPORT_SYMBOL_FOR_EXT4_TEST(ext4_es_register_shrinker);
 EXPORT_SYMBOL_FOR_EXT4_TEST(ext4_es_unregister_shrinker);
+EXPORT_SYMBOL_FOR_EXT4_TEST(ext4_es_destroy_stats);
 EXPORT_SYMBOL_FOR_EXT4_TEST(ext4_map_create_blocks);
 EXPORT_SYMBOL_FOR_EXT4_TEST(ext4_es_init_tree);
 EXPORT_SYMBOL_FOR_EXT4_TEST(ext4_es_lookup_extent);
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6e4a191e8219..018b6146b9d8 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1881,12 +1881,17 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
 }
 
 void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi)
+{
+	shrinker_free(sbi->s_es_shrinker);
+}
+
+/* ext4_get_link() bumps the hit and miss counters in rcu pathwalk */
+void ext4_es_destroy_stats(struct ext4_sb_info *sbi)
 {
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_hits);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_misses);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_all_cnt);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
-	shrinker_free(sbi->s_es_shrinker);
 }
 
 /*
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index f3396cf32b44..01cddcaaa68e 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -238,6 +238,7 @@ static inline void ext4_es_store_pblock_status(struct extent_status *es,
 
 extern int ext4_es_register_shrinker(struct ext4_sb_info *sbi);
 extern void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi);
+extern void ext4_es_destroy_stats(struct ext4_sb_info *sbi);
 
 extern int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d636b89090a2..3ace06b4f9e3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1279,6 +1279,14 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
 	}
 }
 
+static void ext4_put_sbi_rcu(struct rcu_head *head)
+{
+	struct ext4_sb_info *sbi = container_of(head, struct ext4_sb_info, s_rcu);
+
+	ext4_es_destroy_stats(sbi);
+	kfree(sbi);
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1374,7 +1382,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_stop_mmpd(sbi);
 
 	brelse(sbi->s_sbh);
-	sb->s_fs_info = NULL;
 	/*
 	 * Now that we are completely done shutting down the
 	 * superblock, we need to actually destroy the kobject.
@@ -1387,7 +1394,8 @@ static void ext4_put_super(struct super_block *sb)
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
-	kfree(sbi);
+	/* ext4_get_link() reads the sbi and the counters in rcu pathwalk */
+	call_rcu(&sbi->s_rcu, ext4_put_sbi_rcu);
 }
 
 static struct kmem_cache *ext4_inode_cachep;
@@ -5806,6 +5814,7 @@ failed_mount8: __maybe_unused
 	/* Drain deferred EA inode iputs from journal replay */
 	flush_delayed_work(&sbi->s_ea_inode_work);
 	ext4_es_unregister_shrinker(sbi);
+	ext4_es_destroy_stats(sbi);
 failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);

