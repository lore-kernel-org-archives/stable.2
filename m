Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33282DCF57
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619643; cv=none; b=SW+EnVpvMuVwVbLL1aBUG3ogTPf/dFjHrOxF5Sx3cOznI3G/igbTGjczDEfv0iMeevVYBuvnr3oTV+7pSJK5y+5UboZBycsF/RKV3nWXG4E+HKkt0QCD0ynylUeQOa16U516P6A32kKkYUy4reTMnQnu1VSmjob3EbCZbDaWkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619643; c=relaxed/simple;
	bh=spKzruL+3NyxGMn9sf94ZlmnzMCLdbUIaFd2rAryWjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoAOxN/uoGlSOzjd+CaVukLsasY4OCgiExkprrgcEyvGsLbQ8E8btK3Gl3XzcQHRJJv8TuHf/kyWipeS2Mw5cLR8uvL9u5SNCjiLLmthY0iEZ2Q/3ucPxmCInUyhcfWnBu30e7rk5B5P7SXkBFR2wg01cxJcP1VQH1qbrUQNTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS2Exngh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS2Exngh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33391F00A3A;
	Sat,  5 Sep 2026 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788619641;
	bh=yGPCGmmcjaVVUIsVOhwJ+ouxvMvyRZeumuPkoiUm/4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fS2Exngh2Si8InkjbQeqOU30jYySlGf9sF5RxhHYPkkSyLVVcTB2hOkNOY87S4F43
	 J4bXBK9aIKlASXRorDa7bNcU62Q8Dt8jby9MqHuZqzEv8D+SJF+6L0Ra9AC/xxVkva
	 1vJeYJvn9zCqWCMFhQ72UrC9vGwV3HR/+MeDzEP8SGy6LL7T+c4C3eWqdgcxinRW9S
	 vKTj24yORNJIfh9vPZADzrQT6q2U19S1jdAnEez7GMwdazaq+Ljg0ju0AOC8hysG8T
	 vNnzf210R0hh7kLe/CTxGmpaOzs4l2WP9+XoRAA4qoqn+hWuiIG2yj0eTNdfzFTOSM
	 MNtjIMmIPrViw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
Date: Sat,  5 Sep 2026 10:47:18 -0400
Message-ID: <20260905144718.272869-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-quarry-bottom-b4e0@gregkh>
References: <2026090339-quarry-bottom-b4e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit bbf13732f74351d21c5e0e8dd9bd8e1c48dc35d4 ]

nfsd_file_dispose_list_delayed() defers fput() to nfsd service threads
via a per-net freeme queue, preventing the shrinker and GC worker from
bearing the cost of closing files (see ffb402596147).  However, the
queue lives in a separately-allocated struct nfsd_fcache_disposal that
is freed by nfsd_free_fcache_disposal_net() during per-net teardown.
The global shrinker, laundrette, and fsnotify callbacks can still be
inside nfsd_file_dispose_list_delayed() dereferencing that pointer,
causing a use-after-free.

Inline the spinlock and freeme list directly into struct nfsd_net (as
fcache_dispose_lock and fcache_dispose_list), eliminating the separately
allocated struct nfsd_fcache_disposal entirely.  These fields now have
the same lifetime as the net namespace itself, so there is no dangling
pointer to chase.

nfsd_file_cache_start_net() now just initializes the inline fields and
cannot fail due to allocation.  nfsd_file_cache_shutdown_net() drains
the inline list directly instead of freeing a separate struct.  The
alloc/free helpers are removed.

Fixes: 1463b38e7cf3 ("NFSD: simplify per-net file cache management")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260602-nfsd-testing-v2-7-e4ea62e3cd5c@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ adapted disposal-list references while retaining the older unguarded service wake-up flow and removing the legacy kmalloc()-based helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 77 +++++++++++++--------------------------------
 fs/nfsd/netns.h     |  3 +-
 2 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 05f0a4867673d..4381d76e83c63 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -61,11 +61,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
-struct nfsd_fcache_disposal {
-	spinlock_t lock;
-	struct list_head freeme;
-};
-
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
@@ -431,25 +426,25 @@ nfsd_file_dispose_list(struct list_head *dispose)
 }
 
 /**
- * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme list
+ * nfsd_file_dispose_list_delayed - queue dead files for nfsd thread disposal
  * @dispose: list of nfsd_files to be disposed
  *
- * Transfers each file to the "freeme" list for its nfsd_net, to eventually
- * be disposed of by the per-net garbage collector.
+ * Transfers each file to the dispose list in its nfsd_net and wakes an nfsd
+ * thread to do the actual close.  This keeps the cost of fput() in the nfsd
+ * threads rather than in the shrinker or GC worker.
  */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
-	while(!list_empty(dispose)) {
+	while (!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
-		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 		struct svc_serv *serv;
 
-		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_gc, &l->freeme);
-		spin_unlock(&l->lock);
+		spin_lock(&nn->fcache_dispose_lock);
+		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
+		spin_unlock(&nn->fcache_dispose_lock);
 
 		/*
 		 * The filecache laundrette is shut down after the
@@ -473,17 +468,15 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
  */
 void nfsd_file_net_dispose(struct nfsd_net *nn)
 {
-	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-	if (!list_empty(&l->freeme)) {
+	if (!list_empty(&nn->fcache_dispose_list)) {
 		LIST_HEAD(dispose);
 		int i;
 
-		spin_lock(&l->lock);
-		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
-			list_move(l->freeme.next, &dispose);
-		spin_unlock(&l->lock);
-		if (!list_empty(&l->freeme))
+		spin_lock(&nn->fcache_dispose_lock);
+		for (i = 0; i < 8 && !list_empty(&nn->fcache_dispose_list); i++)
+			list_move(nn->fcache_dispose_list.next, &dispose);
+		spin_unlock(&nn->fcache_dispose_lock);
+		if (!list_empty(&nn->fcache_dispose_list))
 			/* Wake up another thread to share the work
 			 * *before* doing any actual disposing.
 			 */
@@ -658,11 +651,11 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 }
 
 /**
- * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
+ * nfsd_file_close_inode - attempt a deferred close of a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
  * Close out any open nfsd_files that can be reaped for @inode. The
- * actual freeing is deferred to the dispose_list_delayed infrastructure.
+ * actual freeing is deferred to the nfsd service threads.
  *
  * This is used by the fsnotify callbacks and setlease notifier.
  */
@@ -863,42 +856,14 @@ __nfsd_file_cache_purge(struct net *net)
 	nfsd_file_dispose_list(&dispose);
 }
 
-static struct nfsd_fcache_disposal *
-nfsd_alloc_fcache_disposal(void)
-{
-	struct nfsd_fcache_disposal *l;
-
-	l = kmalloc(sizeof(*l), GFP_KERNEL);
-	if (!l)
-		return NULL;
-	spin_lock_init(&l->lock);
-	INIT_LIST_HEAD(&l->freeme);
-	return l;
-}
-
-static void
-nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
-{
-	nfsd_file_dispose_list(&l->freeme);
-	kfree(l);
-}
-
-static void
-nfsd_free_fcache_disposal_net(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-	nfsd_free_fcache_disposal(l);
-}
-
 int
 nfsd_file_cache_start_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nn->fcache_disposal = nfsd_alloc_fcache_disposal();
-	return nn->fcache_disposal ? 0 : -ENOMEM;
+	spin_lock_init(&nn->fcache_dispose_lock);
+	INIT_LIST_HEAD(&nn->fcache_dispose_list);
+	return 0;
 }
 
 /**
@@ -917,8 +882,10 @@ nfsd_file_cache_purge(struct net *net)
 void
 nfsd_file_cache_shutdown_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
 	nfsd_file_cache_purge(net);
-	nfsd_free_fcache_disposal_net(net);
+	nfsd_file_dispose_list(&nn->fcache_dispose_list);
 }
 
 void
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 09a06e46dab98..610d514d35312 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -206,7 +206,8 @@ struct nfsd_net {
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 
-	struct nfsd_fcache_disposal *fcache_disposal;
+	spinlock_t		fcache_dispose_lock;
+	struct list_head	fcache_dispose_list;
 
 	siphash_key_t		siphash_key;
 
-- 
2.53.0

