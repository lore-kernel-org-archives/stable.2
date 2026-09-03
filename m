Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6714AF9E2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443129; cv=none; b=WYSuGL4i+nUinjt2QIBNDSFZJu+QhMzvro33epaNRdwswco8vGsL4LqPGe8TCz4t8Yb7wzXgYP9zMktk0M01Bu53g0lI2HCz508AxrEeISb5SYN7fa3GXr9mxJraEqYYXabSvAwP/UbKlMeqNbcTYuWAcB0A+PiLVOpolRH/mMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443129; c=relaxed/simple;
	bh=1DwjJ95d1GPxMscaHnoEEn8HuQBGfFIcMh2Z0kJF+w0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CgH8dnTJbmkTDZqwIlND+ARSJTGUwotM6vnOsvn8R1WfIlhfI7ISn490VllCOyBKnbBSECBsKaCUysakZt0wum7rC+agH60ypRdBAPThCwxl9wrtjQNcDXdis66p6k56W8RCVImdVyR1Am1Yxpgh7UkyWhuK3Yo4BhYD0Rki6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y40ynrDM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y40ynrDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5201F00A3E;
	Thu,  3 Sep 2026 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443123;
	bh=BaYBsYMht9Y96NcL0OcReq6TIyvJCAgv1sHVfdxx8oA=;
	h=Subject:To:Cc:From:Date;
	b=Y40ynrDM5cc/KnE9L0/8Eyxd3ykdkZs7AfnUjEhzqsFqCgkqGAFBb5xBUvX+IdLkv
	 6buRa2meqWq2ZJPo2ciUvMgJ58i1bAuDVx1SVGZG15KpYobjw8qcFmQjRQ/2VWWWqt
	 cCUwwKSyjwpQNHCKyS7XP4s1ciorkmWJy67CUrHo=
Subject: FAILED: patch "[PATCH] nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in" failed to apply to 6.18-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:18:53 +0200
Message-ID: <2026090353-raft-script-514e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 40162cfea79b9510380decfdd1795b754dc9f972
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090353-raft-script-514e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40162cfea79b9510380decfdd1795b754dc9f972 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 4 Jun 2026 10:31:09 -0400
Subject: [PATCH] nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in
 filecache

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

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index da5a44c31acb..1ea2bfd51825 100644
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
@@ -423,10 +434,16 @@ nfsd_file_dispose_list(struct list_head *dispose)
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
@@ -557,13 +574,6 @@ nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
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
@@ -586,9 +596,9 @@ nfsd_file_gc(void)
 				remaining = 0;
 		}
 	}
+	nfsd_file_dispose_list_delayed(&dispose);
 	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 static void
@@ -616,9 +626,9 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
@@ -704,8 +714,10 @@ nfsd_file_close_inode(struct inode *inode)
 {
 	LIST_HEAD(dispose);
 
+	spin_lock(&nfsd_gc_lock);
 	nfsd_file_queue_for_close(inode, &dispose);
 	nfsd_file_dispose_list_delayed(&dispose);
+	spin_unlock(&nfsd_gc_lock);
 }
 
 /**
@@ -974,6 +986,14 @@ nfsd_file_cache_shutdown_net(struct net *net)
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
 

