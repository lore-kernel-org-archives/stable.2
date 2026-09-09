Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1532EDD58
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917484; cv=none; b=XYxeYqe9lfNV3A1DJVdOMgVOl3RNUJKEMhek3kPsAIMo36uQ3DUQBf8sZPmenVUq8qyekUpv5HxeV5TW80lPWpGapzZVF8ikzbuYROy2nth9znsW3A4OTJUqEr3bA9wAA7GuRwLCuIzcrEomdfVpeB2+F/rLl6L9/uJNhgwxmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917484; c=relaxed/simple;
	bh=fXjBzWxgM+T5FhcbtnIjiBMW2BmwUGmXdYFWlTf5l18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7qY9SSEBXVpUuXwV0dRtF7ekiNBiSblUPZ/tpRN5/+qFJgamqBOU8Ecb2No0QNg1V47c92PnHvwbbvqfha1pvW0k/Mum/asgQdj6F2saAbP/gHMc5ZgAJ3HCyoI1QVj7bpnduMdijjB8IpQ6QVXgu4g4Ks28CifSkF3xTrQUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQB0frNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQB0frNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E235A1F00A3A;
	Wed,  9 Sep 2026 01:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917483;
	bh=crsWjzFskNPO/E6sBoKH1HNIEPpIiBHGo5G8bjspDHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQB0frNiYgJViOoHwylo8BEycfiQtxDIBxFz2S2xAOEYt5t4vHhejlc73PkSlKVHg
	 ybfOxMnkTACoOuMGoNxRSvFlJxEvOv+I+6ld2brfWiZjztYI3N9/yq8LOuzICqO06Y
	 VXX3PDGJiCHMd38qT00CWp3KmLxLMVSCmpDYruy+pAkof3Z1ij8+FUZVzcQOwh/Zqr
	 BImwsGJNKUCGSP3mzpSgTxEFKQeeGpZ12R4u27JRr8aVOU0DgmTxD5zFhbmRK63t6H
	 PiBUAK+KMxDOJEbodNjnvQMQtgDCCQJ5C6CScApS7hZgcTlucMtQFV5D68iELuLjfd
	 OjC9IN0la3Qow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15.y 1/2] SUNRPC: make various functions static, or not exported.
Date: Tue,  8 Sep 2026 21:31:20 -0400
Message-ID: <20260909013121.888599-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-lip-cognitive-6180@gregkh>
References: <2026090350-lip-cognitive-6180@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

For this 5.15 dependency backport, keep only the svc_rqst_alloc() and
svc_rqst_free() visibility changes. Move the existing svc_rqst_free()
before its first caller, make both helpers static, and remove their
public declarations and exports. No functions are added.

Drop the unrelated rpcbind, authentication, socket-buffer and svc_drop()
hunks. In particular, preserve this tree's transport release in
svc_drop(), int authentication API, and page-based request cleanup.

The follow-on c479bde671cbe2f9e152834a8b0eb7c3c295bbaf patch expects the
newer scratch-folio spelling beside the argument/reply frees. Provide
locally scoped spelling aliases to the existing rq_scratch_page member
and put_page() operation; the scratch allocation remains an order-0
page and cleanup behavior is unchanged. Undefine both aliases after the
allocator. Bracket the existing page-release loop to preserve the
follow-on patch's insertion context.

This lets the unmodified target apply without importing folio support
or adding compatibility functions. The RCU callback and deferred
argument/reply frees remain changes for the target commit.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |  3 ---
 net/sunrpc/svc.c           | 45 +++++++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 57e0d9b7553b4..6ac0c829f61a3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -476,11 +476,8 @@ void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
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
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 92d88aac2adff..4fc4a7f426a17 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -611,6 +611,13 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 	return pages == 0;
 }
 
+/*
+ * This tree uses an order-0 page for the scratch buffer. Keep the folio
+ * spelling used by follow-on request cleanup fixes local to these helpers.
+ */
+#define rq_scratch_folio rq_scratch_page
+#define folio_put put_page
+
 /*
  * Release an RPC server buffer
  */
@@ -619,12 +626,25 @@ svc_release_buffer(struct svc_rqst *rqstp)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(rqstp->rq_pages); i++)
+	for (i = 0; i < ARRAY_SIZE(rqstp->rq_pages); i++) {
 		if (rqstp->rq_pages[i])
 			put_page(rqstp->rq_pages[i]);
+	}
+}
+
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
 }
 
-struct svc_rqst *
+static struct svc_rqst *
 svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	struct svc_rqst	*rqstp;
@@ -658,7 +678,9 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	svc_rqst_free(rqstp);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(svc_rqst_alloc);
+
+#undef folio_put
+#undef rq_scratch_folio
 
 static struct svc_rqst *
 svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
@@ -841,23 +863,6 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
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

