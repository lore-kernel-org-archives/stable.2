Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE230492E4C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913516; cv=none; b=FyHWdiMRNXIrD9MfR7XUDT7KO/IfNSdDZtZEKxpZH7PtPFtGoxhsMo03F+pGXQmgVb/8TanxFpipv6Ya0bxTifY1AHaeCsms9OYzStayFnMpaki8rdsr6Hvn7tbt9bmPughzb7ejYDvsAkn0yuf9D0MuyTe6to139+66K9mnYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913516; c=relaxed/simple;
	bh=pDi1yr5Si6bUM3Jr2CkBdjHcgKMlfmAnW4EaKSOv4Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG8j9tIrJdHASIlO0R4kGQ+Nsb/h6UZdYY5eU30NZR5aAPeWbJdC5KQ77kSUrUs1ZhffKIRpmAMaR12PVSUZKohLud1eAXPPXuXT/w0Tz5lBBcJeznTFpmKXoH/KtM2TMoYYdGGkxilIM8WjCspgE2ohYHGleOpP21l8qnntW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtBPtcCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtBPtcCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17221F00A3D;
	Wed,  9 Sep 2026 00:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913514;
	bh=bRoi4Mpga/oJwsuL0fXg15dndICp3YVbwHyKbvEEXPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtBPtcCtEfWKdIRkdQs+QUZJJQ9PVWuEXTtjK9rj2B8RqJZRWdSVqwVFHd6GkQRiX
	 KbpKx9s/A2gmiqJaczC8czaP+V6MB/ulYR5wR3i695/7FeNHQuGWxvnLuztKx2ISTd
	 DN5SBU9qEp5UYyVJpCZUQsuA+PxUDoQ9G4ikBmdZ9za3YeLVa32+XN9QzQypHbE548
	 tKnuHiYIS5h+/6xY7OHsbvFdgtaGC+6nSxCoydgXjVPept29hCbbTk9Zpwzl+h8SW5
	 x+4zWRvBbamh65HeT9aUta36f8PFRHkyTIms1sxlrKIDu64bPWsHpgT1hY0OLRAW+2
	 nG0Mcu2rYKejw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] SUNRPC: make various functions static, or not exported.
Date: Tue,  8 Sep 2026 20:25:08 -0400
Message-ID: <20260909002511.725380-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002511.725380-1-sashal@kernel.org>
References: <2026090350-comment-projector-6988@gregkh>
 <20260909002511.725380-1-sashal@kernel.org>
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

[ Stable backport note: svc_rqst_alloc() and svc_rqst_free() are already
  static, and the latter already precedes its first use, in the preceding
  dependency. Keep that implementation and its scratch folio handling.
  Do not import the newer page-release helper or authentication interfaces.

  Retain the visibility cleanup for svc_rpcb_setup(),
  svc_rpcbind_set_version(), svc_authenticate(), and svc_sock_update_bufs().
  Declare svc_authenticate() as int in the private header to match 6.1.
  Keep svc_drop() in svc_xprt.c: it still calls the file-local
  svc_xprt_release(), which upstream no longer calls from svc_drop().

  Add braces around the existing svc_release_buffer() page-release loop,
  without changing its behavior, to provide the exact context required by
  the first hunk of c479bde671cb. No functions are added. ]

[ sashal: Reduced backport -- upstream f2b27e1d72527 touches 8 file(s), this
  backport carries 7. Not backported here:
  net/sunrpc/svc_xprt.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h     |  6 ------
 include/linux/sunrpc/svcauth.h |  1 -
 include/linux/sunrpc/svcsock.h |  1 -
 net/sunrpc/sunrpc.h            |  4 ++++
 net/sunrpc/svc.c               | 10 +++++-----
 net/sunrpc/svcauth.c           |  1 -
 net/sunrpc/svcsock.c           |  1 -
 7 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index d26e01c63dde0..4144a256fc255 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -468,7 +468,6 @@ struct svc_procedure {
 /*
  * Function prototypes.
  */
-int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
 struct svc_serv *svc_create(struct svc_program *, unsigned int,
@@ -509,11 +508,6 @@ int		   svc_generic_rpcbind_set(struct net *net,
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
index 6d9cc9080aca7..5e11fbe1fe463 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -149,7 +149,6 @@ struct auth_ops {
 
 struct svc_xprt;
 
-extern int	svc_authenticate(struct svc_rqst *rqstp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
 extern int	svc_set_client(struct svc_rqst *rqstp);
 extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 13aff355d5a13..cfcdbf4def22c 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -58,7 +58,6 @@ void		svc_close_net(struct svc_serv *, struct net *);
 int		svc_recv(struct svc_rqst *, long);
 int		svc_send(struct svc_rqst *);
 void		svc_drop(struct svc_rqst *);
-void		svc_sock_update_bufs(struct svc_serv *serv);
 int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const int fd, char *name_return, const size_t len,
 			    const struct cred *cred);
diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index d4a362c9e4b3b..07ab21b64f904 100644
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
+int svc_authenticate(struct svc_rqst *rqstp);
 #endif /* _NET_SUNRPC_SUNRPC_H */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index faa5193231240..3fe7152ee8bf5 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -32,6 +32,7 @@
 #include <trace/events/sunrpc.h>
 
 #include "fail.h"
+#include "sunrpc.h"
 
 #define RPCDBG_FACILITY	RPCDBG_SVCDSP
 
@@ -388,7 +389,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	return &serv->sv_pools[pidx % serv->sv_nrpools];
 }
 
-int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
+static int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
 {
 	int err;
 
@@ -400,7 +401,6 @@ int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
 	svc_unregister(serv, net);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(svc_rpcb_setup);
 
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net)
 {
@@ -625,9 +625,10 @@ svc_release_buffer(struct svc_rqst *rqstp)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(rqstp->rq_pages); i++)
+	for (i = 0; i < ARRAY_SIZE(rqstp->rq_pages); i++) {
 		if (rqstp->rq_pages[i])
 			put_page(rqstp->rq_pages[i]);
+	}
 }
 
 static void
@@ -1009,7 +1010,7 @@ static int __svc_register(struct net *net, const char *progname,
 	return error;
 }
 
-int svc_rpcbind_set_version(struct net *net,
+static int svc_rpcbind_set_version(struct net *net,
 			    const struct svc_program *progp,
 			    u32 version, int family,
 			    unsigned short proto,
@@ -1019,7 +1020,6 @@ int svc_rpcbind_set_version(struct net *net,
 				version, family, proto, port);
 
 }
-EXPORT_SYMBOL_GPL(svc_rpcbind_set_version);
 
 int svc_generic_rpcbind_set(struct net *net,
 			    const struct svc_program *progp,
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index e72ba2f13f6c6..1694c01bbaf9c 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -84,7 +84,6 @@ svc_authenticate(struct svc_rqst *rqstp)
 	rqstp->rq_authop = aops;
 	return aops->accept(rqstp);
 }
-EXPORT_SYMBOL_GPL(svc_authenticate);
 
 int svc_set_client(struct svc_rqst *rqstp)
 {
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 23b4c728de598..e6204afa78fd6 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1283,7 +1283,6 @@ void svc_sock_update_bufs(struct svc_serv *serv)
 		set_bit(XPT_CHNGBUF, &svsk->sk_xprt.xpt_flags);
 	spin_unlock_bh(&serv->sv_lock);
 }
-EXPORT_SYMBOL_GPL(svc_sock_update_bufs);
 
 /*
  * Initialize socket for RPC use and create svc_sock struct
-- 
2.53.0

