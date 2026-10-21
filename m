Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596608;
	b=rJ8owpbfpIIvV1I+846GZT5VOOc31UtRBsSn4G7gYp+tYc3why9xidELu0BCcAE3m/Q4
	 3cy9Zx0uc3sLWLM2FYnWHjxU0WTuRLRiuLsWxPK9+RBlCyd0oOi4HtmSb1PE2VDC95TNL
	 YoGCZjsvfSPlRhIRohKsyTIFyyZagH7xnDQhNvN2I+xLmctCOS9YNn4i8SUunoDjI1Pjt
	 pdl5rYhRcE8jMzgA9IS48QIcf9eQNX/+reD35biS20rFe7hoJ3qNdnjkdfrezqL7Lju65
	 osZjCYbrqNDdV2yds+Q1ZtkLKh6MTz0XZ2AA1TE3xc0gYw5L95CXeWGM1r0OICN57EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uFNUCuGzA+hpEMxm4fgOgzmswLKTR2sZ91KsxskyeOk=;
	b=bMurequghWyzGkjXgPm8q6XeIPaKmWWo42feaxfy8wz4te9Hksa4Zd7+v0mz/6ZcMkw6
	 Spwfu/sPC+41on3+akZLT0vYoV4sx+t/xVWYL5SmJ7pjIYWWrSQCTmTk26cIOYzS9m8DJ
	 /BOT74dqeAcDC8EJnY5v9XRWuzPKR2jfC3sMR2x7jVL86lGw9ESgvbE7kE50/m+VpRLck
	 AjhyFOGS5sqwivTOSXcMYj0ZgW1l3Ezr+wOWDjjIzNEDyx1oR8hP/aFuNtiDDwn8lM5iq
	 IY2+/OyErlnUc4F2LJ2eWwlJcPcZxFf+qiUVq148gUmXPJpuxQAjM1bqpuGfgseXbfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nb0Uzriw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39521606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nb0Uzriw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D761F000C8;
	Wed, 21 Oct 2026 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596608;
	bh=uFNUCuGzA+hpEMxm4fgOgzmswLKTR2sZ91KsxskyeOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nb0UzriwB+KDCvfcw/hDXPvdnSWQRXJ1p2t/BGrIsffgkvhRo+U0UjuyWLMAoGeSB
	 4hidK91ZGQc6QHySHoZV1eCkloSs+w5ybhb77oW6u8rMDqpcZxeCUYDhqV4U2LM46e
	 rWgUGD6UK6b8g0gqPONkhuHfQTMxSWCgwqgCpaOjnkSvriFN7aebzLwt2K2R+r1Xy4
	 6ql4EOn6ivZGOcCbexp3xbqXYkexeNehQFzOtN7HMzkdpWXCMhARdsiM9b8hA+AlZr
	 SenN9mQKHaQz4B82Dr3wVGohK5It5Yer6b09EpJDY0ExmcDRGvOgZDxaxqxnItkkSq
	 Kx70Z/erF4lHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ext4: free the sbi after a grace period
Date: Wed, 21 Oct 2026 11:30:06 -0400
Message-ID: <20261021152924.292498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102102-likewise-pointless-8de1@gregkh>
References: <2026102102-likewise-pointless-8de1@gregkh>
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
[ sashal: Omitted changes tied to absent extent KUnit tests. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h           |  2 ++
 fs/ext4/extents_status.c |  7 ++++++-
 fs/ext4/extents_status.h |  1 +
 fs/ext4/super.c          | 13 +++++++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index da6428312c36b..dae7fb8bc598e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1694,6 +1694,8 @@ struct ext4_sb_info {
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
+	/* ext4_get_link() reads the sbi in rcu pathwalk */
+	struct rcu_head s_rcu;
 	struct mb_cache *s_ea_block_cache;
 	struct mb_cache *s_ea_inode_cache;
 	spinlock_t s_es_lock ____cacheline_aligned_in_smp;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 31dc0496f8d0c..fbfd1937d07d0 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1796,12 +1796,17 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
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
index 8f9c008d11e81..502d9110a73cc 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -238,6 +238,7 @@ static inline void ext4_es_store_pblock_status(struct extent_status *es,
 
 extern int ext4_es_register_shrinker(struct ext4_sb_info *sbi);
 extern void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi);
+extern void ext4_es_destroy_stats(struct ext4_sb_info *sbi);
 
 extern int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9b45d27515f9f..3f5e9d825a5e6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1268,6 +1268,14 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
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
@@ -1361,7 +1369,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_stop_mmpd(sbi);
 
 	brelse(sbi->s_sbh);
-	sb->s_fs_info = NULL;
 	/*
 	 * Now that we are completely done shutting down the
 	 * superblock, we need to actually destroy the kobject.
@@ -1374,7 +1381,8 @@ static void ext4_put_super(struct super_block *sb)
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
-	kfree(sbi);
+	/* ext4_get_link() reads the sbi and the counters in rcu pathwalk */
+	call_rcu(&sbi->s_rcu, ext4_put_sbi_rcu);
 }
 
 static struct kmem_cache *ext4_inode_cachep;
@@ -5692,6 +5700,7 @@ failed_mount8: __maybe_unused
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
+	ext4_es_destroy_stats(sbi);
 failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);
-- 
2.53.0

