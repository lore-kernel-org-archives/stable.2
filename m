Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125F492E4C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913535; cv=none; b=AndDQxip3bOc6kyvMGNiUK1luyEC6jUWjMzfWqyiwC1ghfw/N/LSxZ/t1VuUCT0TcfvdIyMWJkxzcCMGUDnaAJjnDheqyUYIZYQdEkzjz2YbQHGs9oZSr3PUWvNQ8LrwhisBchkAqSFTngOGqrFjr3VUL5V0xNMqXnbXU3nKOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913535; c=relaxed/simple;
	bh=YeTXCZofo+4Lkgrhi6sj5Tavb17sY+LmXi/nQIqdo98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2w6t3nHf0u+UGRDAg3L6hJDM/sBLZiUjFC8GBGPYL61sPXLpEVxLKtfQDguDneXvqjGXvBMuU/iOJp7zTC7Rset0SsZA4Vi7Bzkf2sXWel5Z2HOJ8m6IkHDOp5T2vAehuqmolXIZgWRItTjqYv4jaTStcec80YulujS+4igvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWn/mCY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWn/mCY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D811F00A3A;
	Wed,  9 Sep 2026 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913534;
	bh=B50cgzh6xa4+103vjmhyZxgPc7SFXqBiUFL77CuTwuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jWn/mCY7jSsIpoxlnqzXf7vpG8bRTLUk9bmShorB8Br//f1+vhmmINkz96pbCUJWY
	 mm+FmJ0dfWwZ61Mmde/OoznzIveVGHUu061Wuqt0P64CRk+3HCPt76jwSK2rBzQ3u8
	 5NumZS6agh+hAfLmcW66krU940IdJF2/hDl7yB3+2rUOk9LG9RQ913xwUn9mz3Jh9v
	 lB4F1ZSJ60nyojPCD8UB+JLzwfzi7/3oBVjfHqaXOq5tedeevv/afuiO1wPK6B7LGN
	 7muXF2FaJkBvRvUDUh4fIkJgWH/oFnTv0gQadlubBBmtAR9P7wkTHCtsayv8FDgPFm
	 /6+HJ2Cv81Caw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] SUNRPC: remove timeout arg from svc_recv()
Date: Tue,  8 Sep 2026 20:25:28 -0400
Message-ID: <20260909002532.729106-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-comment-projector-6988@gregkh>
References: <2026090350-comment-projector-6988@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit c743b4259c3af2c0637c307f08a062d25fa3c99f ]

Most svc threads have no interest in a timeout.
nfsd sets it to 1 hour, but this is a wart of no significance.

lockd uses the timeout so that it can call nlmsvc_retry_blocked().
It also sometimes calls svc_wake_up() to ensure this is called.

So change lockd to be consistent and always use svc_wake_up() to trigger
nlmsvc_retry_blocked() - using a timer instead of a timeout to
svc_recv().

And change svc_recv() to not take a timeout arg.

This makes the sp_threads_timedout counter always zero.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

[ Stable backport note: The svc_recv timeout cleanup is unrelated to the
follow-up fix and does not fit the older lockd service loop. Drop those
hunks. Instead, make the existing svc request allocation/free helpers
private, move svc_rqst_free() before its first use, and convert the
scratch page to a folio. This aligns the lifetime-management context so
the follow-up fix applies cleanly. ]

[ sashal: Reduced backport -- upstream c743b4259c3af touches 9 file(s), this
  backport carries 2. Not backported here:
  fs/lockd/svc.c
  fs/lockd/svclock.c
  fs/nfs/callback.c
  fs/nfsd/nfssvc.c
  include/linux/lockd/lockd.h
  include/linux/sunrpc/svcsock.h
  net/sunrpc/svc_xprt.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h |  7 ++-----
 net/sunrpc/svc.c           | 38 +++++++++++++++++---------------------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 49621cc4e01bd..d26e01c63dde0 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -247,7 +247,7 @@ struct svc_rqst {
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
 	struct xdr_stream	rq_res_stream;
-	struct page		*rq_scratch_page;
+	struct folio		*rq_scratch_folio;
 	struct xdr_buf		rq_res;
 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
 	struct page *		*rq_respages;	/* points into rq_pages */
@@ -473,11 +473,8 @@ void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
 struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    int (*threadfn)(void *data));
-struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
-					struct svc_pool *pool, int node);
 void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
-void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     struct svc_stat *stats,
@@ -554,7 +551,7 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
 
 	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
-	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
+	xdr_set_scratch_page(xdr, folio_page(rqstp->rq_scratch_folio, 0));
 }
 
 /**
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9ae85347ab397..faa5193231240 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -630,7 +630,19 @@ svc_release_buffer(struct svc_rqst *rqstp)
 			put_page(rqstp->rq_pages[i]);
 }
 
-struct svc_rqst *
+static void
+svc_rqst_free(struct svc_rqst *rqstp)
+{
+	svc_release_buffer(rqstp);
+	if (rqstp->rq_scratch_folio)
+		folio_put(rqstp->rq_scratch_folio);
+	kfree(rqstp->rq_resp);
+	kfree(rqstp->rq_argp);
+	kfree(rqstp->rq_auth_data);
+	kfree_rcu(rqstp, rq_rcu_head);
+}
+
+static struct svc_rqst *
 svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	struct svc_rqst	*rqstp;
@@ -644,8 +656,10 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
-	rqstp->rq_scratch_page = alloc_pages_node(node, GFP_KERNEL, 0);
-	if (!rqstp->rq_scratch_page)
+	if (node == NUMA_NO_NODE)
+		node = numa_mem_id();
+	rqstp->rq_scratch_folio = __folio_alloc_node(GFP_KERNEL, 0, node);
+	if (!rqstp->rq_scratch_folio)
 		goto out_enomem;
 
 	rqstp->rq_argp = kmalloc_node(serv->sv_xdrsize, GFP_KERNEL, node);
@@ -664,7 +678,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	svc_rqst_free(rqstp);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(svc_rqst_alloc);
 
 static struct svc_rqst *
 svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
@@ -847,23 +860,6 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 }
 EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
 
-/*
- * Called from a server thread as it's exiting. Caller must hold the "service
- * mutex" for the service.
- */
-void
-svc_rqst_free(struct svc_rqst *rqstp)
-{
-	svc_release_buffer(rqstp);
-	if (rqstp->rq_scratch_page)
-		put_page(rqstp->rq_scratch_page);
-	kfree(rqstp->rq_resp);
-	kfree(rqstp->rq_argp);
-	kfree(rqstp->rq_auth_data);
-	kfree_rcu(rqstp, rq_rcu_head);
-}
-EXPORT_SYMBOL_GPL(svc_rqst_free);
-
 void
 svc_exit_thread(struct svc_rqst *rqstp)
 {
-- 
2.53.0

