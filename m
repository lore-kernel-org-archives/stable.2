Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D53644A0
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638743; cv=none; b=GawwijDcVteDF/ANr9YBEWhZEwJjuU3YZM1dLDpzqokfPMn5w41fWq69ZoikJlWGA+eg+3Bnksx5F7sk7rgbb7nDoirLK3WCQytYrG2NsOoqp0rwVAVmYLFfOo3mRFbhAhb3q10I8FQGix3EoSe5smrnWTYKd7Kz6zMJ3EYlyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638743; c=relaxed/simple;
	bh=sq1tQQjc2wwY0fdSRaO2eWA7hN59EtKANVBVZ6GInyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLUnqB8e/CTmWtPnDIXkAvf5I04+/DHom+iQVykMXl51idwZqTY+vA9TcTXXxAl5dHsAi6QFHdf9zqInvOGc6ocz4i8zMv85RCxpJiwGg8HnPMBUu0wP1WSvDVPgjIZSKvNHh7ukf2GqgqTrmMRcLJmNvjRGYF3nqaGH4ID4dEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO2hG4fO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO2hG4fO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3378E1F00A3F;
	Sat,  5 Sep 2026 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638741;
	bh=BLf322DoagPIgw7M47+iw+vjuhli99IlqKXcWaN7KQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JO2hG4fOFleo2JLrNDlXw0qwu4QNIB86pUgMXsQk22WNa2GtTSFwpPnB54VFHFi1+
	 XyIw1Gnnx8gIG8YCho/PqEDIn84Mbb9/pqaGAb3vj9KjcL7VpPbM90kuWUDHAZ8SIA
	 Z2xfXmANVwJXpdOjFrv9DAUtsLLchONGtbi8j1hCadL+8ASX0SHG/nxPNVblyJmFcu
	 DE4uEztohnwYihLcVFcpc0AGKYrCoK9GsZNoZykBPOAPNaRH+RLh3RrovHKE3p3nCj
	 /aLgQ8B7mCBCsAUfz35OcEXwyESbrPhrqvVFjkWZ6Rpw2pnAVHV96Q9wcuI5Lrbsgj
	 GSZBl1ju7f86g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
Date: Sat,  5 Sep 2026 16:05:37 -0400
Message-ID: <20260905200538.608334-2-sashal@kernel.org>
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
Stable-dep-of: 40162cfea79b ("nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in filecache")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 77 +++++++++++++--------------------------------
 fs/nfsd/netns.h     |  3 +-
 2 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2258e7a59a850..f8974d5fa6737 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -62,11 +62,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
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
@@ -419,25 +414,25 @@ nfsd_file_dispose_list(struct list_head *dispose)
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
@@ -461,17 +456,15 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
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
-		if (!list_empty(&l->freeme)) {
+		spin_lock(&nn->fcache_dispose_lock);
+		for (i = 0; i < 8 && !list_empty(&nn->fcache_dispose_list); i++)
+			list_move(nn->fcache_dispose_list.next, &dispose);
+		spin_unlock(&nn->fcache_dispose_lock);
+		if (!list_empty(&nn->fcache_dispose_list)) {
 			/*
 			 * Wake up another thread to share the work
 			 * *before* doing any actual disposing.
@@ -695,11 +688,11 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
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
@@ -903,42 +896,14 @@ __nfsd_file_cache_purge(struct net *net)
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
@@ -957,8 +922,10 @@ nfsd_file_cache_purge(struct net *net)
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
index fe8338735e7cc..2a2b65930e3a9 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -200,7 +200,8 @@ struct nfsd_net {
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 
-	struct nfsd_fcache_disposal *fcache_disposal;
+	spinlock_t		fcache_dispose_lock;
+	struct list_head	fcache_dispose_list;
 
 	siphash_key_t		siphash_key;
 
-- 
2.53.0

