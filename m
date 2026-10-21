Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598128;
	b=h3l+KECiz4QSY7yH0fczhpv6mWcN9/sXvrsCwhdb3d2hKVoH6MVILYR8C12Y1NzkzfM1
	 T72HOst4sL+JodxHmy0JeWZonaT589c3L0Mkb6t5AieGjB+ZqBNwG7b5Gx0iF0zcJuCT7
	 TT0uS+yKmS7LnNETccU20Hv69znS2dgGss5+tLfb8u0/1aUJVrMlLzy2nIqXunSPSejho
	 t13Tzx8qC1LqK/pMa+uIlIOfi8onuoq/sgq60tDToE/TGyUb2OxlKKWpmErgqjh0AZLT+
	 2pST0T6fm9b176ctH+cussXC1TUYlqTg+4Yg9Ui/cEJWIoehuAYxQ09DWdPCPKCxamg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qYdobLlU0xLjOJP8riaKxvKAoSDn4rMN2Tuz6kPV4Zs=;
	b=TuxPyXkXXLlB02UEUFmzD72lByKI0tXAqjiJqrgY12r6rXuQCBWyyCuY4yPWy/XgDlTc
	 DNvN9fbuuEY8bdIbQlwA0iZ/zgX2vomZUDwXPIKGhd09FLi/NCJX6E7lRdd2On0hHeFXs
	 M/9+xgjaZcxL79U3nnL9Ku0BReyZ4HP/NEQ1ygPDHpQhsF/7ukd1necQ1bfAwlfKwCCvP
	 xKwNDDH1P8QLxVqUjPo5oFcR8jpPyYZ5UElexZl3xomssjXv6tRXd5nJxYhrk28jxyhcW
	 1SBhDlASAYTznH3Z00S1Pu6lo2CJO57x3vSNgyuIpFs0stdzoSVHZdVvENVIl1nSmqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmcyRQQo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1A606A324
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmcyRQQo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A431F000C1;
	Wed, 21 Oct 2026 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598127;
	bh=qYdobLlU0xLjOJP8riaKxvKAoSDn4rMN2Tuz6kPV4Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmcyRQQoR0K8bnEEPSve2d61XXD8QxplOyn4is6l9SQ/rWh+WDTKM763Leky4TDUm
	 zWDK+qe2LAK0zt6REg9fozFVSlgx0fZA0gr4GwhaFV1QkiHnqYZl7TMpwtNbziP3xW
	 F01fypFFI7JwTGm4MUDVM5K5DT2t+rlqqLSbG2f/Nxf9pwRSuL7tiYn3CTmlvg8W1g
	 3EPGM4e3pAdDJ1qUKtkuvUs06Mv4iy1M9K27I3MNsB8EY3Dih9UrCU27WkWzcNpK7F
	 /NMB2LtmSS2Faeb/ciQOUO/uE6MJjCPdRk+irerQR/1wlo/dmwiR9VCM8V6hpKRHId
	 v127ThLuu74Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ext4: free the sbi after a grace period
Date: Wed, 21 Oct 2026 11:55:26 -0400
Message-ID: <20261021155506.366052-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102103-nimble-translate-97e5@gregkh>
References: <2026102103-nimble-translate-97e5@gregkh>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit c17b44266a1f9fcb49b894d4611d1254bf1aa313 ]

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
[ sashal: omitted ext4_es_destroy_stats() integration with the extent KUnit tests ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h           |  2 ++
 fs/ext4/extents_status.c |  7 ++++++-
 fs/ext4/extents_status.h |  1 +
 fs/ext4/super.c          | 13 +++++++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 21de942bb6fb3..3e0c29434ae38 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1663,6 +1663,8 @@ struct ext4_sb_info {
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
+	/* ext4_get_link() reads the sbi in rcu pathwalk */
+	struct rcu_head s_rcu;
 	struct mb_cache *s_ea_block_cache;
 	struct mb_cache *s_ea_inode_cache;
 	spinlock_t s_es_lock ____cacheline_aligned_in_smp;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index c786691dabd3d..425a613683c0a 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1766,12 +1766,17 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
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
index 4424232de2989..c1e45f6ab6647 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -237,6 +237,7 @@ static inline void ext4_es_store_pblock_status(struct extent_status *es,
 
 extern int ext4_es_register_shrinker(struct ext4_sb_info *sbi);
 extern void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi);
+extern void ext4_es_destroy_stats(struct ext4_sb_info *sbi);
 
 extern int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 08f84ed65ad1c..25aae8165f070 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1289,6 +1289,14 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
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
@@ -1381,7 +1389,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_stop_mmpd(sbi);
 
 	brelse(sbi->s_sbh);
-	sb->s_fs_info = NULL;
 	/*
 	 * Now that we are completely done shutting down the
 	 * superblock, we need to actually destroy the kobject.
@@ -1396,7 +1403,8 @@ static void ext4_put_super(struct super_block *sb)
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
-	kfree(sbi);
+	/* ext4_get_link() reads the sbi and the counters in rcu pathwalk */
+	call_rcu(&sbi->s_rcu, ext4_put_sbi_rcu);
 }
 
 static struct kmem_cache *ext4_inode_cachep;
@@ -5659,6 +5667,7 @@ failed_mount8: __maybe_unused
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
+	ext4_es_destroy_stats(sbi);
 failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);
-- 
2.53.0

