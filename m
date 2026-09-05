Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053514BC003
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625856; cv=none; b=fW+yR/GWRJ12KH95dom3HjosA0XZ/nEJTf7DChY5zsFfBRY26UzeA0yuTA8m003lBqM202D5RVdfOnYR6KAGL+vR6cD23wMBTzVk0nmO43SR/oVCATxIGqnGf3twfKl561MRWxPUImwJr/BJ9FEpncIwMQ2cq2+e6Q9mmdkA7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625856; c=relaxed/simple;
	bh=eMxE2T9wo3n9kUtfYwDzgHpzuuHJcY5qtHUAQGP7E2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPJ20W70a8CJz6thHNxTWLFJoiD4GVuNUSjFkvVCIDDLCs8MQpLKy7x1+2KFzuLkr4H+CaMCCdJPGinSOnA58Of/2Qr+VSJLvUp8XzoiL+TfH1deK+DYWQeT2U9klrzjU727/2r0g4NfloNjvr1MIOyVbXDASsAC6Jm/RyKXaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoHrntKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoHrntKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578BE1F00A3A;
	Sat,  5 Sep 2026 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788625842;
	bh=nZAO+oTSuIn8fgaYUePdH2w5vpxh5hWPSInll/x+md8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YoHrntKd1SGXMYCvN/PMvlznnDI9ARxu/Z95TvyyuGZ6k6q3oky8zcNaZ+yhvyvwU
	 SsCVsP4mRT9nx9tMvfZFjtRUV9Trrw+ZUedi4r10xlWueF/8lJcZhoc0aysxLnHgsr
	 yDMvi8qLFvbxRAzUsCqODDwXuGniTkDI3TvlJwhGPpsr8CMFzdcGuLLT9mFOtF/G8c
	 zVvCGEq6cMJLMWws7zfolhI+gdI37o4CgBt1oEa7oa/PkviPh9+5yQhBZWd3EDDFdU
	 nyK7vpkllqCyOas8WrTHAsn1xqlU9gC3/AuPzSm53xHahUwY9acllnGpmVQJl0FmKR
	 YduauQRkIkJyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
Date: Sat,  5 Sep 2026 12:30:40 -0400
Message-ID: <20260905163040.442384-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090340-pesky-jaybird-39c7@gregkh>
References: <2026090340-pesky-jaybird-39c7@gregkh>
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
[ adapted service-thread disposal state to the existing workqueue implementation by embedding it in struct nfsd_net ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 70 ++++++++++++---------------------------------
 fs/nfsd/netns.h     |  4 ++-
 2 files changed, 21 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 46eb06e32f0cd..6262c9b41cde0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -60,12 +60,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
-struct nfsd_fcache_disposal {
-	struct work_struct work;
-	spinlock_t lock;
-	struct list_head freeme;
-};
-
 static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
 
 static struct kmem_cache		*nfsd_file_slab;
@@ -413,16 +407,14 @@ nfsd_file_dispose_list(struct list_head *dispose)
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
-	while(!list_empty(dispose)) {
+	while (!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
-		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_gc, &l->freeme);
-		spin_unlock(&l->lock);
-		queue_work(nfsd_filecache_wq, &l->work);
+		spin_lock(&nn->fcache_dispose_lock);
+		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
+		spin_unlock(&nn->fcache_dispose_lock);
+		queue_work(nfsd_filecache_wq, &nn->fcache_dispose_work);
 	}
 }
 
@@ -651,12 +643,12 @@ static void
 nfsd_file_delayed_close(struct work_struct *work)
 {
 	LIST_HEAD(head);
-	struct nfsd_fcache_disposal *l = container_of(work,
-			struct nfsd_fcache_disposal, work);
+	struct nfsd_net *nn = container_of(work, struct nfsd_net,
+			fcache_dispose_work);
 
-	spin_lock(&l->lock);
-	list_splice_init(&l->freeme, &head);
-	spin_unlock(&l->lock);
+	spin_lock(&nn->fcache_dispose_lock);
+	list_splice_init(&nn->fcache_dispose_list, &head);
+	spin_unlock(&nn->fcache_dispose_lock);
 
 	nfsd_file_dispose_list(&head);
 }
@@ -825,44 +817,15 @@ __nfsd_file_cache_purge(struct net *net)
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
-	INIT_WORK(&l->work, nfsd_file_delayed_close);
-	spin_lock_init(&l->lock);
-	INIT_LIST_HEAD(&l->freeme);
-	return l;
-}
-
-static void
-nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
-{
-	cancel_work_sync(&l->work);
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
+	INIT_WORK(&nn->fcache_dispose_work, nfsd_file_delayed_close);
+	spin_lock_init(&nn->fcache_dispose_lock);
+	INIT_LIST_HEAD(&nn->fcache_dispose_list);
+	return 0;
 }
 
 /**
@@ -881,8 +844,11 @@ nfsd_file_cache_purge(struct net *net)
 void
 nfsd_file_cache_shutdown_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
 	nfsd_file_cache_purge(net);
-	nfsd_free_fcache_disposal_net(net);
+	cancel_work_sync(&nn->fcache_dispose_work);
+	nfsd_file_dispose_list(&nn->fcache_dispose_list);
 }
 
 void
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index be0c8f1ce4e3e..3b6c70b104d5c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -206,7 +206,9 @@ struct nfsd_net {
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 
-	struct nfsd_fcache_disposal *fcache_disposal;
+	struct work_struct	fcache_dispose_work;
+	spinlock_t		fcache_dispose_lock;
+	struct list_head	fcache_dispose_list;
 
 	siphash_key_t		siphash_key;
 
-- 
2.53.0

