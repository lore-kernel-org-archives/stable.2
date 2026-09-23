Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C100470456
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169870; cv=none; b=aRZF2u7LKFFSnus4IElzVzO4iUDWNsx00R/xD4Swc+tzgjIcXtsvp2TDy5cFT2t+1nQRAxVbHeWa08GRdDrQ/zG9fG44ZfuVsuksQiejMtOMQpZ6fbx6uQCkJVKAzHiJENbnax3AVxmLuj4ul70h9jumr+g8R6lxan1YTlpG6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169870; c=relaxed/simple;
	bh=LOfa3XQC5xyfXVCKdXuQJtP0yscDoRgzSbgW961VFIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qqQG41QESIDqB9d4dwOZSUU36ZMXFMB+3xO4fmKNxYCgEnN69c3HvkD12M11B2NW3Br9arelu3Ca2gIJyh3gt4ENS1NQR+bKgyPQvphlH6Fx+TMI0HC11lFzkg07cI5cOWC7C5e+3nTIryCUxDzTxzNGbPybPFfQQc2CEjVjw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6Vekwnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6Vekwnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7D21F000FF;
	Wed, 23 Sep 2026 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790169859;
	bh=Hu192gElUVlOFaP9H/cB55DFSvqCT2PavUVah2WNSFk=;
	h=Subject:To:Cc:From:Date;
	b=W6VekwnujvP6iLQeD1Sd7dsvFjXlXEcR///TFROQzPFDBF8ZBFYnwfGSsifnqQJcH
	 kDVjC57m4yTLg3RSaIt8PQK/p0IlQAVQnwA3bywy+UbSGH4/yP/x025SZY+cXEiGtQ
	 2Ae084pjFsg4L4nQls6vL06KfSTCbqxwbSFjkbfU=
Subject: FAILED: patch "[PATCH] fs: push nr_cached_objects memcg gating into individual" failed to apply to 7.2-stable tree
To: usama.arif@linux.dev,baolin.wang@linux.alibaba.com,brauner@kernel.org,dsterba@suse.com,jack@suse.cz,qi.zheng@linux.dev,shakeel.butt@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 23 Sep 2026 15:24:15 +0200
Message-ID: <2026092315-overtone-rename-4864@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 0ef8faff490be6aa1a1e5dfcb0c8492689e91c0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092315-overtone-rename-4864@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ef8faff490be6aa1a1e5dfcb0c8492689e91c0f Mon Sep 17 00:00:00 2001
From: Usama Arif <usama.arif@linux.dev>
Date: Wed, 15 Jul 2026 03:35:16 -0700
Subject: [PATCH] fs: push nr_cached_objects memcg gating into individual
 filesystems

Commit 0baad6f9b997 ("fs/super: skip non-memcg-aware nr_cached_objects
in memcg slab shrink") added a check in fs/super.c that skipped every
->nr_cached_objects() hook whenever the shrinker was invoked for a
non-root memcg, on the assumption that none of them honour sc->memcg.

That assumption is wrong for XFS, whose inode-reclaim hook is
intentionally driven from per-memcg contexts to free memcg-charged
slab. Encoding a blanket "never memcg-aware" policy in fs/super.c
short-circuits that path.

Push the check down into the callbacks whose counters really are
irrelevant to per-memcg reclaim - btrfs_nr_cached_objects() and
shmem_unused_huge_count() - and drop the fs/super.c gate. Each
filesystem can now lift the restriction independently if its counter
later grows memcg awareness, without touching fs/super.c.

Introduce mem_cgroup_shrink_is_root() in <linux/memcontrol.h> so the
callbacks don't open-code "sc->memcg is NULL or root".

Fixes: 0baad6f9b997 ("fs/super: skip non-memcg-aware nr_cached_objects in memcg slab shrink")
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Link: https://patch.msgid.link/20260715103516.2410175-1-usama.arif@linux.dev
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a7d804219bec..cc4537435399 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -22,6 +22,7 @@
 #include <linux/namei.h>
 #include <linux/miscdevice.h>
 #include <linux/magic.h>
+#include <linux/memcontrol.h>
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 #include <linux/crc32c.h>
@@ -2434,6 +2435,15 @@ static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_contro
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	const s64 nr = percpu_counter_read_positive(&fs_info->evictable_extent_maps);
 
+	/*
+	 * The evictable extent map counter is filesystem-global and does not
+	 * honour sc->memcg, so it is only meaningful on the global (kswapd or
+	 * root direct reclaim) shrink path. Skip the per-memcg iterations of
+	 * shrink_slab_memcg() to avoid queueing duplicate global work.
+	 */
+	if (!mem_cgroup_shrink_is_root(sc))
+		return 0;
+
 	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
 
 	return nr;
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1f46a0016fc..5407e4200460 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -520,6 +520,22 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return (memcg == root_mem_cgroup);
 }
 
+/**
+ * mem_cgroup_shrink_is_root - is this a global or root-memcg shrink invocation?
+ * @sc: shrink_control describing the current shrinker call
+ *
+ * Returns true when @sc represents a global reclaim shrink (sc->memcg == NULL)
+ * or a root-memcg shrink, i.e. not a per-memcg iteration of
+ * shrink_slab_memcg(). Filesystems whose ->nr_cached_objects()/
+ * ->free_cached_objects() implementations operate on filesystem-global state
+ * and do not honour sc->memcg can use this to early-return 0 in per-memcg
+ * contexts.
+ */
+static inline bool mem_cgroup_shrink_is_root(struct shrink_control *sc)
+{
+	return !sc->memcg || mem_cgroup_is_root(sc->memcg);
+}
+
 static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
 {
 	return objcg->is_root;
@@ -1071,6 +1087,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return true;
 }
 
+static inline bool mem_cgroup_shrink_is_root(struct shrink_control *sc)
+{
+	return true;
+}
+
 static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
 {
 	return true;
diff --git a/mm/shmem.c b/mm/shmem.c
index b51f83c970bb..9001aaf3b7b9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -846,6 +846,16 @@ static long shmem_unused_huge_count(struct super_block *sb,
 		struct shrink_control *sc)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
+	/*
+	 * The per-superblock shrinklist is filesystem-global and does not
+	 * honour sc->memcg, so it is only meaningful on the global (kswapd or
+	 * root direct reclaim) shrink path. Skip the per-memcg iterations of
+	 * shrink_slab_memcg() to avoid queueing duplicate global work.
+	 */
+	if (!mem_cgroup_shrink_is_root(sc))
+		return 0;
+
 	return READ_ONCE(sbinfo->shrinklist_len);
 }
 #else /* !CONFIG_TRANSPARENT_HUGEPAGE */

