Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8370599A54
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907021; cv=none; b=DbXXAS7w0hqUa9AI1nplbnHuY0zRI/yMoO1NT2Ql8OsnyA/C9GAMyZrRHEPjD4UhgmgKZay9j+eZJxjZRiKXuj+X4u71B9rRBnnblfLKGPNS81UJHAt3ReFOCNwmx2+3nvlZlzWsDKsIO2JYPIYm+TMmMtJAU3H3txingK1H5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907021; c=relaxed/simple;
	bh=j8Tc8piKFmjQSNomgGS2ZWnhNzQLU615fDbji/UZ9iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=op/zAHk329RLL3scTe2oGeM5iiygf7iZCs2+QV7/d2NbXbGfyb5rELQab+GHXQqlifEmAbRPP25f/VcmGVd7a1j4z0majZD71dNTehseyvazspdH1oPf3fja5DBv5R9xhvd3g8JYmKODMQgW+G9RHXEkM3ik+ax4SS1Us6iNW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLXJl8vy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLXJl8vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B93F1F00ACF;
	Tue,  8 Sep 2026 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907016;
	bh=BlXKXSvy3Rxohc+GB8+VLd3o/7YBvEtDXgu1kJ0NU7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLXJl8vyIjA50faQSEobV0uhHaemrC20iPkSWGAuGSfoRFGaAfWXKqx6TTEc9SbAB
	 INasyLvzCuUStur2CJomfccaitrtcN/5szx9AkSa454jXaVpuF7kq1c3uWf3Yo+xnj
	 mIVJOym57a81GFJz5vM2yoI44xpO2lrnFTRcsNeryD7Mm9MrkIPITtewQNm+Rstyd6
	 zF4GGAN9fGAE3M/+9EQScG3HMmH/Y5+N4HYSmxM7dz/fm+C1dWdsDuTzI9JAp5/NRA
	 5DOhUekZyQMrkmuygiDa7HpFdcT9zfdwjYNUUnD8v2fJ4qJmWEtEbqLGDD4SqVGw2M
	 xjckJ/58u7xLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 18:36:49 -0400
Message-ID: <20260908223651.501880-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223651.501880-1-sashal@kernel.org>
References: <2026090350-breeze-repugnant-70de@gregkh>
 <20260908223651.501880-1-sashal@kernel.org>
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
index e1afc35e961d1..b9fcacb3902b2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -206,7 +206,7 @@ struct svc_rqst {
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
 	struct xdr_stream	rq_res_stream;
-	struct page		*rq_scratch_page;
+	struct folio		*rq_scratch_folio;
 	struct xdr_buf		rq_res;
 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
 	struct page *		*rq_respages;	/* points into rq_pages */
@@ -469,7 +469,7 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
 
 	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
-	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
+	xdr_set_scratch_folio(xdr, rqstp->rq_scratch_folio);
 }
 
 /**
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b9314d3632550..bfd685dfc70e9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -366,7 +366,7 @@ static int svc_pool_map_get_node(unsigned int pidx)
 		if (m->mode == SVC_POOL_PERNODE)
 			return m->pool_to[pidx];
 	}
-	return NUMA_NO_NODE;
+	return numa_mem_id();
 }
 /*
  * Set the given thread's cpus_allowed mask so that it
@@ -682,8 +682,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
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
@@ -705,8 +705,8 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
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

