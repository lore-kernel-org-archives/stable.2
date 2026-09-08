Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675539DBFD
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895715; cv=none; b=KavLeGet2HiwK80PjoStjO9v7ywA77bjsCPL6BXG9ub87+zTyTua0WPvF8K9cP2oxCCMQ+Jl8fHMOroA9tBbQOJt7b8cQ+tye8ixvAZSfmo1R4bpJxx5qhUWnFiizHydUKF5nUMhbIBSO1y4E6YmqXCFNvCdf35hOHDzBt163EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895715; c=relaxed/simple;
	bh=txBf6u3W/UElgdeGY5T5G0KFwnpIymlZQRRgSw9TBi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXE7d1q6VDr45+9mvLA4MLPWAUg5lOqlb5PnVx9NEsEx4zCMiFogMEEeKV14OTC0YgecPUUOQgQG8HzGfZDaDJRE0bpQUSNnpdJiCxSgEB3SYQnzNHnBBsvE/DTV/SdSbNhUMMqD0lHiFVbXvyH86FOuFSHY1vtOuGTJ1yWXlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBT5o6XB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBT5o6XB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8563A1F00A3D;
	Tue,  8 Sep 2026 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895711;
	bh=0P7anQYqmabIRndcp6Vo5DNXeikngS3FIJqsKdiBbMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBT5o6XBDXQEMUoHDpJTPnvbaY8FdPjcMthj+ml5i7xiv/+T5/1EuKMbcxMBI+74A
	 hfBHSIEBjKr+1rqK0hlQKYwmfi4bLUeAiN4s1J4fhhAIk84LhVxfDt+kn+V/VBnzzc
	 6kxBoUXPbyMJLRcMW7D7dC9TWUwlCqQcJBw+5X0r9fWmoxQQ0UL57WlLWadv4e7mfu
	 of0e4XKF+DDBh+NVo4gxEz+Q0YvGSsWMUNO4KNtK+XQXNJHopEAgfJNKoeZyqOkpZQ
	 veRzUQhD4FCmTuqI4VwsHqlNjMXS83Hw+OlbiTnt8dtMfCnMD+FUgZiJpq9VMcUa+5
	 JD4hhI/hldjWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 15:28:27 -0400
Message-ID: <20260908192828.296500-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908192828.296500-1-sashal@kernel.org>
References: <2026090349-throwing-hardware-8a25@gregkh>
 <20260908192828.296500-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

[ Upstream commit d57e43b72bf2071caac90da323849c3983a695f0 ]

The only snag here is that __folio_alloc_node() doesn't handle
NUMA_NO_NODE, so I also need to update svc_pool_map_get_node() to return
numa_mem_id() instead. I arrived at this approach by  looking at what
other users of __folio_alloc_node() do for this case.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h |  4 ++--
 net/sunrpc/svc.c           | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 617ebfff2f304..57c4dace80200 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -190,7 +190,7 @@ struct svc_rqst {
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
 	struct xdr_stream	rq_res_stream;
-	struct page		*rq_scratch_page;
+	struct folio		*rq_scratch_folio;
 	struct xdr_buf		rq_res;
 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
 	struct page *		*rq_respages;	/* points into rq_pages */
@@ -504,7 +504,7 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
 
 	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
-	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
+	xdr_set_scratch_folio(xdr, rqstp->rq_scratch_folio);
 }
 
 /**
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index df4dacd70beac..553ec553d3baf 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -352,7 +352,7 @@ static int svc_pool_map_get_node(unsigned int pidx)
 		if (m->mode == SVC_POOL_PERNODE)
 			return m->pool_to[pidx];
 	}
-	return NUMA_NO_NODE;
+	return numa_mem_id();
 }
 /*
  * Set the given thread's cpus_allowed mask so that it
@@ -734,8 +734,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
 {
 	folio_batch_release(&rqstp->rq_fbatch);
 	svc_release_buffer(rqstp);
-	if (rqstp->rq_scratch_page)
-		put_page(rqstp->rq_scratch_page);
+	if (rqstp->rq_scratch_folio)
+		folio_put(rqstp->rq_scratch_folio);
 	kfree(rqstp->rq_resp);
 	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
@@ -756,8 +756,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
-	rqstp->rq_scratch_page = alloc_pages_node(node, GFP_KERNEL, 0);
-	if (!rqstp->rq_scratch_page)
+	rqstp->rq_scratch_folio = __folio_alloc_node(GFP_KERNEL, 0, node);
+	if (!rqstp->rq_scratch_folio)
 		goto out_enomem;
 
 	rqstp->rq_argp = kmalloc_node(serv->sv_xdrsize, GFP_KERNEL, node);
-- 
2.53.0

