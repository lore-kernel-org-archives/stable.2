Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496F54281B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079569; cv=none; b=M1BHWt9mups1VOEp+LEPTUNzBgrSsTmr177fE7USz9h2GYSWVRMYvxPz/4gO53E5eVVV7jXzObq0/qTFUuM+jqMU0L99aD+obvhWnu0L5yuFIB9xLO12sC+MCzgFg9vOJcvAhI4Suova01fjPN+U8/lvKS+uqAjZA0/AzrFDGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079569; c=relaxed/simple;
	bh=+RIHEuhZp1b6vhibJPpif1chNiO2vengPRi7kfK96as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTlVU7UlxVbxxBGGKL0T62pCvG53CfA6vPdPiWXe3pBu5O9SHWnykiFRjkbeK9KHOBkuUqn0JiZuigAzHlMBP99C7XXkEp4XEk012jsjpc1DKX14Mi5YxFARXs+HKvVHET0GdgmPtxV6xLAeeu/ud9Uyy9Nc8ndWWw7TvJ/SeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFgaGKrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFgaGKrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3851F000FF;
	Tue, 22 Sep 2026 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079567;
	bh=o1WqHOuI81RP9UOREweD0D5rqDQZ8/zTZZh0Re+1RLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFgaGKrA6ty0MNtwenHjxrc5wkMoiby28W7tMWiLume/FZ/pB1jSEmZBeDLKFkATq
	 a4yG3m1ed/u5ObrRJYs/O9CB3DXi4R+CIle46mIOhJzprBdNnztYplmIKJwZic3VwE
	 +6jit6m3SeBii78V1Iw+Hzwda6Ahr449WgA2wbgf18ytL2CjezyC/mfcmQCbqyyiiN
	 yXUyAJMvD5ZdL+VMg3h+ryY3jiE2BaH6lBkfTlvh0Uay8iW8RTdJ8lFDgUTcWX6uKb
	 aVmeKBmlQAeIrc8+mFMcgnssTdF44KOtv0CO0v/QAdl69PvDZrvOps8lEJqVaP2w25
	 Gy5cdapTGd7Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Usama Arif <usama.arif@linux.dev>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] fs/super: skip non-memcg-aware nr_cached_objects in memcg slab shrink
Date: Tue, 22 Sep 2026 08:19:24 -0400
Message-ID: <20260922121925.2214152-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092250-stool-feed-1f18@gregkh>
References: <2026092250-stool-feed-1f18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Usama Arif <usama.arif@linux.dev>

[ Upstream commit 0baad6f9b9970c6e3f1d33dbfd17d1a77702771d ]

The super_block shrinker is registered with SHRINKER_MEMCG_AWARE because its
dentry and inode LRUs are memcg-aware (via list_lru). But the optional
->nr_cached_objects() hooks that the shrinker also drives are not memcg-aware:
btrfs extent maps and xfs inode reclaim operate on filesystem-global
state, and shmem's unused-huge shrinker walks a per-superblock shrinklist.
None of them filter by sc->memcg.

The mismatch shows up under memcg-heavy slab reclaim. shrink_slab_memcg()
calls do_shrink_slab() once per (memcg, NUMA node) pair for every memcg
whose bit is set in the per-superblock shrinker bitmap, which on a busy
host means hundreds of calls per reclaim pass. Each scan queues the same
global shrinker work item that's already kicked from the root path.

Because btrfs/xfs global count is typically non-zero on any in-use filesystem,
the returned total stays positive even if a memcg's own dentry/inode LRUs
are empty. shrink_slab_memcg() therefore never clears the SB shrinker bit
in the memcg bitmap, so subsequent reclaim passes from the same memcg
re-enter super_cache_count() and pay for the global counter walk again.

Restrict ->nr_cached_objects() to the global shrink path (sc->memcg NULL
or root). The memcg-aware dentry/inode LRUs keep being counted and
scanned per memcg as before; only the global fs-specific hooks are skipped.
The root/global shrink path still drives those hooks; only their
invocation from non-root memcg slab reclaim is removed.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
Link: https://patch.msgid.link/20260609123047.1948242-1-usama.arif@linux.dev
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: 641aade99f06 ("fs: fix missed removal of super_fs_objects_eligible()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1159a73856db6..feac9ba5abe81 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/memcontrol.h>
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
@@ -169,6 +170,19 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+/*
+ * The s_op->nr_cached_objects hooks (used for example by btrfs and xfs)
+ * operate on filesystem-global state and ignore sc->memcg. Driving them
+ * from per-memcg shrink_slab_memcg() invocations only burns CPU walking
+ * per-cpu counters and queueing duplicate work: the actual reclaim happens on
+ * the global path (kswapd or root direct reclaim) regardless. Restrict them
+ * to that path.
+ */
+static inline bool super_fs_objects_eligible(struct shrink_control *sc)
+{
+	return !sc->memcg || mem_cgroup_is_root(sc->memcg);
+}
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
@@ -198,7 +212,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!super_trylock_shared(sb))
 		return SHRINK_STOP;
 
-	if (sb->s_op->nr_cached_objects)
+	if (sb->s_op->nr_cached_objects && super_fs_objects_eligible(sc))
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	inodes = list_lru_shrink_count(&sb->s_inode_lru, sc);
@@ -259,7 +273,8 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 		return 0;
 	smp_rmb();
 
-	if (sb->s_op && sb->s_op->nr_cached_objects)
+	if (sb->s_op && sb->s_op->nr_cached_objects &&
+	    super_fs_objects_eligible(sc))
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
-- 
2.53.0

