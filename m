Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA4566C6D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907021; cv=none; b=XQ/77u2wdLBg+JWnuvJBn2CvIQ8g0ik5IIdOpLKzB9QS79LtohwuLPADGNwu7q1JnaS0WpNzv5K9RWwB6soBv3boeGJPCtDZQ9qCkdqbks6KSyoc9NdyXDzI736lRt8w1RyWYgCX0j6IeolJ/tMXZhMv7ap34hk5XiQQRmaxYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907021; c=relaxed/simple;
	bh=57794O/yNOLMi5N9FAt5KYYEUJUvOIkG34CnbJg2RCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIAyMZgjW8+3vuayQLfkt711eE8eZUTNg9PBx02oZ4dDuZzvBS57CANGVJEhn2HWQsU5XugXPx0Ohokvl/+vY9Xb3/YhiPo8VDXfByzXo28cQ/iPsU8CGK0yeFzqwm+PzhFFwGduEjsdaWezXuqASD1i9tpjiXAnpjWkaZiI04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7q/G6oy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7q/G6oy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A380F1F00A3A;
	Tue,  8 Sep 2026 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907015;
	bh=RlfBeGpK4BMWh1bRd/yIFXt3LfcFMYQGVKY/vcef5Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7q/G6oy1Q9IMPE2no0Hr2OebWmONRzGKqIWwaTDoqhE8v4juVgOvgGFwxgb+1FQu
	 6+Vgh18Nypaz1ODA1XgZHcUd7qEAK1LpBUr60PiXa37eUf+OUm8cBOP9XPNnj9kEIi
	 y6k6ZL33GvN8HZ5fv/w6qTIVriTy0CAerRxlimG0D2R99SUv8pCX+e+OCFG/ndl2H2
	 My7oUuBiSpMobEpWCI1uCfmHisj72Tx9v2RcI5vTYk8Bds+5hpZnmdZWzKxgukTweh
	 /y2WPZ9MPT5j8d0I2Ahdhj6mJ2xehHtHKsnrVGja8FKOxAAxEqNOKu+a4AACj/liJH
	 K3ZHpuODN8mdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] SUNRPC: make various functions static, or not exported.
Date: Tue,  8 Sep 2026 18:36:47 -0400
Message-ID: <20260908223651.501880-4-sashal@kernel.org>
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit f2b27e1d72527f94f030b6356b3187576e60885b ]

Various functions are only used within the sunrpc module, and several
are only use in the one file.  So clean up:

These are marked static, and any EXPORT is removed.
  svc_rcpb_setup()
  svc_rqst_alloc()
  svc_rqst_free()  - also moved before first use
  svc_rpcbind_set_version()
  svc_drop() - also moved to svc.c

These are now not EXPORTed, but are not static.
  svc_authenticate()
  svc_sock_update_bufs()

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h     |  9 -------
 include/linux/sunrpc/svcauth.h |  1 -
 include/linux/sunrpc/svcsock.h |  2 --
 net/sunrpc/sunrpc.h            |  4 +++
 net/sunrpc/svc.c               | 48 ++++++++++++++++++----------------
 net/sunrpc/svc_xprt.c          |  9 -------
 net/sunrpc/svcauth.c           |  1 -
 net/sunrpc/svcsock.c           |  1 -
 8 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index d4558fefd9b4e..e1afc35e961d1 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -397,17 +397,13 @@ struct svc_procedure {
  */
 int sunrpc_set_pool_mode(const char *val);
 int sunrpc_get_pool_mode(char *val, size_t size);
-int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
 struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    int (*threadfn)(void *data));
-struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
-					struct svc_pool *pool, int node);
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
-void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     struct svc_stat *stats,
@@ -443,11 +439,6 @@ int		   svc_generic_rpcbind_set(struct net *net,
 					   u32 version, int family,
 					   unsigned short proto,
 					   unsigned short port);
-int		   svc_rpcbind_set_version(struct net *net,
-					   const struct svc_program *progp,
-					   u32 version, int family,
-					   unsigned short proto,
-					   unsigned short port);
 
 #define	RPC_MAX_ADDRBUFLEN	(63U)
 
diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 61c455f1e1f50..63cf6fb26dcc1 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -151,7 +151,6 @@ struct auth_ops {
 
 struct svc_xprt;
 
-extern enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
 extern rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
 extern enum svc_auth_status svc_set_client(struct svc_rqst *rqstp);
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 9e6ecc3526e77..01a547fa447cf 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -61,8 +61,6 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
  */
 void		svc_recv(struct svc_rqst *rqstp);
 void		svc_send(struct svc_rqst *rqstp);
-void		svc_drop(struct svc_rqst *);
-void		svc_sock_update_bufs(struct svc_serv *serv);
 int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const int fd, char *name_return, const size_t len,
 			    const struct cred *cred);
diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index d4a362c9e4b3b..e3c6e3b63f0ba 100644
--- a/net/sunrpc/sunrpc.h
+++ b/net/sunrpc/sunrpc.h
@@ -36,7 +36,11 @@ static inline int sock_is_loopback(struct sock *sk)
 	return loopback;
 }
 
+struct svc_serv;
+struct svc_rqst;
 int rpc_clients_notifier_register(void);
 void rpc_clients_notifier_unregister(void);
 void auth_domain_cleanup(void);
+void svc_sock_update_bufs(struct svc_serv *serv);
+enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
 #endif /* _NET_SUNRPC_SUNRPC_H */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bf88a955920f2..b9314d3632550 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -32,6 +32,7 @@
 #include <trace/events/sunrpc.h>
 
 #include "fail.h"
+#include "sunrpc.h"
 
 #define RPCDBG_FACILITY	RPCDBG_SVCDSP
 
@@ -431,7 +432,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	return &serv->sv_pools[pidx % serv->sv_nrpools];
 }
 
-int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
+static int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
 {
 	int err;
 
@@ -443,7 +444,6 @@ int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
 	svc_unregister(serv, net);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(svc_rpcb_setup);
 
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net)
 {
@@ -677,7 +677,20 @@ svc_release_buffer(struct svc_rqst *rqstp)
 			put_page(rqstp->rq_pages[i]);
 }
 
-struct svc_rqst *
+static void
+svc_rqst_free(struct svc_rqst *rqstp)
+{
+	folio_batch_release(&rqstp->rq_fbatch);
+	svc_release_buffer(rqstp);
+	if (rqstp->rq_scratch_page)
+		put_page(rqstp->rq_scratch_page);
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
@@ -712,7 +725,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	svc_rqst_free(rqstp);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(svc_rqst_alloc);
 
 static struct svc_rqst *
 svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
@@ -946,24 +958,6 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
 	}
 }
 
-/*
- * Called from a server thread as it's exiting. Caller must hold the "service
- * mutex" for the service.
- */
-void
-svc_rqst_free(struct svc_rqst *rqstp)
-{
-	folio_batch_release(&rqstp->rq_fbatch);
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
@@ -1113,6 +1107,7 @@ static int __svc_register(struct net *net, const char *progname,
 	return error;
 }
 
+static
 int svc_rpcbind_set_version(struct net *net,
 			    const struct svc_program *progp,
 			    u32 version, int family,
@@ -1123,7 +1118,6 @@ int svc_rpcbind_set_version(struct net *net,
 				version, family, proto, port);
 
 }
-EXPORT_SYMBOL_GPL(svc_rpcbind_set_version);
 
 int svc_generic_rpcbind_set(struct net *net,
 			    const struct svc_program *progp,
@@ -1536,6 +1530,14 @@ svc_process_common(struct svc_rqst *rqstp)
 	goto sendit;
 }
 
+/*
+ * Drop request
+ */
+static void svc_drop(struct svc_rqst *rqstp)
+{
+	trace_svc_drop(rqstp);
+}
+
 /**
  * svc_process - Execute one RPC transaction
  * @rqstp: RPC transaction context
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 5440d6b50efa5..f44bba40fcf76 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -874,15 +874,6 @@ void svc_recv(struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
-/*
- * Drop request
- */
-void svc_drop(struct svc_rqst *rqstp)
-{
-	trace_svc_drop(rqstp);
-}
-EXPORT_SYMBOL_GPL(svc_drop);
-
 /**
  * svc_send - Return reply to client
  * @rqstp: RPC transaction context
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 1619211f0960a..93d9e949e2652 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -98,7 +98,6 @@ enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp)
 	rqstp->rq_authop = aops;
 	return aops->accept(rqstp);
 }
-EXPORT_SYMBOL_GPL(svc_authenticate);
 
 /**
  * svc_set_client - Assign an appropriate 'auth_domain' as the client
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2c22677563330..e3010eb060930 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1435,7 +1435,6 @@ void svc_sock_update_bufs(struct svc_serv *serv)
 		set_bit(XPT_CHNGBUF, &svsk->sk_xprt.xpt_flags);
 	spin_unlock_bh(&serv->sv_lock);
 }
-EXPORT_SYMBOL_GPL(svc_sock_update_bufs);
 
 /*
  * Initialize socket for RPC use and create svc_sock struct
-- 
2.53.0

