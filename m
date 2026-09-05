Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506636D4FC
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644635; cv=none; b=k/cKDPIaltaiv32peTgoN93OkzIj78zR8SE31WMzFUSCLTfOrRimU1K95+A26nBt7WlJf1NLjdWH9Qye55DKdJMCWS5vSKC55y1IM+mA2vYrGGhlSt0wa4ZeWOoYpsZWO6iIlJEac9csTCo/deU3IWA0STCP65JtsUrMFznr6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644635; c=relaxed/simple;
	bh=S0MVr4LO1ih5Qr3DQslKvppZNSYKBoDb0rcLhPPzEwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCVbGkATQoGq5R7gs/YgiH/Ifixp/eBQtKurtn/cC32fotZt4WTdUqIjysKk2vrNFHDWYJ0iPypAV9l9q8eeeCOJ2iq0YhIaTHfxLwk3+OejV4BUR+rlKd8HfZr9tfw7uuU6lMV6W60nOfn+2pqSbd9KdfUpgjVQrXq2DTRlxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQBkdTh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQBkdTh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D501F00A3D;
	Sat,  5 Sep 2026 21:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644633;
	bh=CfE/goF9PPgvx2SaNj+K7YKATI+/yPIDMXPMpL4k1uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQBkdTh0RzIiX1lUvDsgPamGV72fpuJfhFyJWW4Msgtw0HbWte8kgKqme1qL9fEK3
	 kU8TogHyDXjIskeciFYIGXPPEBbOhIm16PpgfGPhHcDoPDjQANw+uu+FWotF7EpMMb
	 T2uFT04snXomYw3jfSKEOhP9y2mXNDiAvAqqZ/boJF2iUa1NoSfmiTOeZ4E10R+7/P
	 qiR6RNEdU+JUfXFYMQU5NO48sJZSOlsOAVYD3DU17JMnxYgMt2R8+KjwXP9X0Fb7Am
	 9mnbBqVIQX94j2GBSU63iU9FHe+WvbxdEDxdLGgPkj0eDASBa0+zbHmU02ZWqRI07J
	 vVNAwsVrzazSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in filecache
Date: Sat,  5 Sep 2026 17:43:51 -0400
Message-ID: <20260905214351.703039-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905214351.703039-1-sashal@kernel.org>
References: <2026090354-amends-antarctic-06e4@gregkh>
 <20260905214351.703039-1-sashal@kernel.org>
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
[ adapted inline disposal fields to the older allocated fcache_disposal queue while retaining the existing LRU implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e3441cac74f97..1eee2dc936d9f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -54,6 +54,12 @@
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
 #define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
+/*
+ * Serialize callers of nfsd_file_dispose_list_delayed() against per-net
+ * shutdown.
+ */
+static DEFINE_SPINLOCK(nfsd_gc_lock);
+
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_allocations);
@@ -436,11 +442,17 @@ nfsd_file_dispose_list(struct list_head *dispose)
  *
  * Transfers each file to the "freeme" list for its nfsd_net, to eventually
  * be disposed of by the per-net garbage collector.
+ *
+ * All callers must hold nfsd_gc_lock, so that nfsd_file_cache_shutdown_net()
+ * can synchronize against them before draining the per-net dispose list.
+ * This guarantees nf_net is still live when we call net_generic().
  */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
-	while(!list_empty(dispose)) {
+	lockdep_assert_held(&nfsd_gc_lock);
+
+	while (!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
@@ -565,10 +577,12 @@ nfsd_file_gc(void)
 	LIST_HEAD(dispose);
 	unsigned long ret;
 
+	spin_lock(&nfsd_gc_lock);
 	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
 			    &dispose, list_lru_count(&nfsd_file_lru));
-	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
+	spin_unlock(&nfsd_gc_lock);
+	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
 }
 
 static void
@@ -591,10 +605,14 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	LIST_HEAD(dispose);
 	unsigned long ret;
 
+	if (!spin_trylock(&nfsd_gc_lock))
+		return SHRINK_STOP;
+
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
-	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
+	spin_unlock(&nfsd_gc_lock);
+	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
 	return ret;
 }
 
@@ -680,8 +698,10 @@ nfsd_file_close_inode(struct inode *inode)
 {
 	LIST_HEAD(dispose);
 
+	spin_lock(&nfsd_gc_lock);
 	nfsd_file_queue_for_close(inode, &dispose);
 	nfsd_file_dispose_list_delayed(&dispose);
+	spin_unlock(&nfsd_gc_lock);
 }
 
 /**
@@ -927,6 +947,14 @@ void
 nfsd_file_cache_shutdown_net(struct net *net)
 {
 	nfsd_file_cache_purge(net);
+	/*
+	 * Ensure any in-progress shrinker, GC, or fsnotify/lease callback
+	 * (all of which hold nfsd_gc_lock while calling
+	 * nfsd_file_dispose_list_delayed()) has fully completed before
+	 * draining the per-net dispose list.
+	 */
+	spin_lock(&nfsd_gc_lock);
+	spin_unlock(&nfsd_gc_lock);
 	nfsd_free_fcache_disposal_net(net);
 }
 
-- 
2.53.0

