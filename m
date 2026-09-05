Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FD37DAD7
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638743; cv=none; b=cZyyDnT32dC4Hwjvr9Y6GNp78vSZNIBgW/PDqMucUiEXU8ZhnYs8zikf4pZA9aQQoA72JlttgBvZFc2eUmo2Fxu8uywNernuSVzrNGgzaS6VQd+yRgUug5Zqv1tF59+SESCnSlwTPQgNpqSvZBaoAys9ytbFjM4+5W9LC7eaNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638743; c=relaxed/simple;
	bh=HWy0CBPL+D4Al2sPbENzcMzMJiaS6sMJV4s/TAuGobw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiDPwMVqqYPyfY4+JDXPI7oEVUssKvqJ5Ly/5lxdGcGFM+U0ynEnCSw4yNMlQktJ1jZwkJH+x2IUdJQvZwlt8MHIwVdpuO+GAnRfb/eMcAcjGZIONJhXkYQ/zyesAO/m58WGaiBQNvn47B16+FxaCJH2czvZQPy2DI9aW5y90No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUYka0Lf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUYka0Lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03441F00A3D;
	Sat,  5 Sep 2026 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638742;
	bh=C4pdXWJ0PODZPLlIqhYbgD2TW942sI/3MlotKOn1f8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUYka0LfVeHFofykMV81z11vZIlKgT3bsCUzzjhQBZqctRHUO1AQmxEhQ0fL0c8FN
	 ncyip3onqF9MKdqjDh38Z0NpFBMe/uR+PL4tj9sILfQ69jfM0Rm/Y0M5eWbiHhB4am
	 XNLCZ2kC7nVEw7Koki3PwgZqClt4Q5AOYm/zwLltlu8lDdmAgpHM6LY/LSbJxFoMou
	 9olWk9q+rUNVEJGTJ+uE+GyIfS47FIEv7TA/GvWQcie6/b1CVLB+dkObzwUebgRzyf
	 mI1pnQ6NjLK7sLasHwJhvLRpB/sghnEsBbrtWeyhfq2E1IZNXWIs7cnwCiPSPztKuo
	 l3kVna0L5Ff2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in filecache
Date: Sat,  5 Sep 2026 16:05:38 -0400
Message-ID: <20260905200538.608334-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905200538.608334-1-sashal@kernel.org>
References: <2026090353-raft-script-514e@gregkh>
 <20260905200538.608334-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 40162cfea79b9510380decfdd1795b754dc9f972 ]

The shrinker, GC worker, and fsnotify/lease callbacks can unhash an
nfsd_file from the rhashtable and then call
nfsd_file_dispose_list_delayed() to move it to the per-net dispose list.
If nfsd_file_cache_shutdown_net() runs concurrently, its rhashtable walk
misses the already-unhashed file, and its drain of the per-net dispose
list can run before the file has been queued.  The file then sits on
the per-net list with no thread to drain it, leaking both the file and
its associated state.

The GC worker and shrinker already hold nfsd_gc_lock while walking the
LRU, but in the original code they release it before calling
nfsd_file_dispose_list_delayed().  The fsnotify/lease path
(nfsd_file_close_inode) has no synchronization at all.

Fix this by:

  1. Widening nfsd_gc_lock in both nfsd_file_gc() and nfsd_file_lru_scan()
     to cover the nfsd_file_dispose_list_delayed() call.

  2. Wrapping nfsd_file_close_inode() in nfsd_gc_lock so that all three
     callers of nfsd_file_dispose_list_delayed() hold the lock.

  3. Adding a spin_lock/unlock(nfsd_gc_lock) barrier in
     nfsd_file_cache_shutdown_net() after the purge, so that any
     in-progress disposal has fully completed before the per-net list
     is drained.

All operations inside the lock are non-sleeping (rhashtable lookups,
atomic bit/refcount ops, list moves, svc_wake_up), so the spinlock is
appropriate.

Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work queue")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Assisted-by: Claude:claude-opus-4-8
Link: https://patch.msgid.link/20260604-nfsd-testing-v4-1-3aeb1479c5bb@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f8974d5fa6737..cfa2b5ad656ac 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -55,6 +55,17 @@
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
 #define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
+/* If the shrinker runs between calls to list_lru_walk_node() in
+ * nfsd_file_gc(), the "remaining" count will be wrong.  This could
+ * result in premature freeing of some files.  This may not matter much
+ * but is easy to fix with this spinlock which temporarily disables
+ * the shrinker.
+ *
+ * It also serializes callers of nfsd_file_dispose_list_delayed()
+ * against per-net shutdown.
+ */
+static DEFINE_SPINLOCK(nfsd_gc_lock);
+
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_allocations);
@@ -420,10 +431,16 @@ nfsd_file_dispose_list(struct list_head *dispose)
  * Transfers each file to the dispose list in its nfsd_net and wakes an nfsd
  * thread to do the actual close.  This keeps the cost of fput() in the nfsd
  * threads rather than in the shrinker or GC worker.
+ *
+ * All callers must hold nfsd_gc_lock, so that nfsd_file_cache_shutdown_net()
+ * can synchronize against them before draining the per-net dispose list.
+ * This guarantees nf_net is still live when we call net_generic().
  */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
+	lockdep_assert_held(&nfsd_gc_lock);
+
 	while (!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_gc);
@@ -554,13 +571,6 @@ nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
 	return nfsd_file_lru_cb(item, lru, arg);
 }
 
-/* If the shrinker runs between calls to list_lru_walk_node() in
- * nfsd_file_gc(), the "remaining" count will be wrong.  This could
- * result in premature freeing of some files.  This may not matter much
- * but is easy to fix with this spinlock which temporarily disables
- * the shrinker.
- */
-static DEFINE_SPINLOCK(nfsd_gc_lock);
 static void
 nfsd_file_gc(void)
 {
@@ -583,9 +593,9 @@ nfsd_file_gc(void)
 				remaining = 0;
 		}
 	}
+	nfsd_file_dispose_list_delayed(&dispose);
 	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 static void
@@ -613,9 +623,9 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
@@ -701,8 +711,10 @@ nfsd_file_close_inode(struct inode *inode)
 {
 	LIST_HEAD(dispose);
 
+	spin_lock(&nfsd_gc_lock);
 	nfsd_file_queue_for_close(inode, &dispose);
 	nfsd_file_dispose_list_delayed(&dispose);
+	spin_unlock(&nfsd_gc_lock);
 }
 
 /**
@@ -925,6 +937,14 @@ nfsd_file_cache_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfsd_file_cache_purge(net);
+	/*
+	 * Ensure any in-progress shrinker, GC, or fsnotify/lease callback
+	 * (all of which hold nfsd_gc_lock while calling
+	 * nfsd_file_dispose_list_delayed()) has fully completed before
+	 * draining the per-net dispose list.
+	 */
+	spin_lock(&nfsd_gc_lock);
+	spin_unlock(&nfsd_gc_lock);
 	nfsd_file_dispose_list(&nn->fcache_dispose_list);
 }
 
-- 
2.53.0

