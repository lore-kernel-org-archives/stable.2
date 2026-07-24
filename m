Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6E1419A4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856320; cv=none; b=XCvoS54BJ3baAEL8wlRynNoy9rwLBjWZDth0tqRI7BbwjVSGWZ6J/Cv9zrCj8Rnm6jGEaypcIxR7ha1EHfrB9L+3dn2GooEY7NaVmZ821LpzCoKIyAXiSzi/eXrd5dVtJWhQhCrKfPgLqa50cSI8HKtaWpXeRcyao0jO2iRsn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856320; c=relaxed/simple;
	bh=lv+qGz/2pjz6X2enJNZQ1AyioCzoLsA0aetbD/mnPr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeHnHQ2jEoM4ie5CwKtRSJP9QEeRW4g78cc4P3VCFSQtJ6/T1J1VJ6Z8rBLuLgWt2rzC2NhlIAcbdLYWqehb2SqXLvnZrkwxfESxqgycDo9YZZdK6Is8pUymxfjXcJs1Ov1Tl0mxWMaBqkDLQarRK7edep4e6o5L8MiollMX1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej1De/bQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej1De/bQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243B91F00A3A;
	Fri, 24 Jul 2026 01:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856318;
	bh=b5R1H6Mz89FX5vBiKPuu8rHc5qdRxYkiazfxvvRsMkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ej1De/bQXRx0ZZWKxKQ47B9s9/4TvWLk59LqXswnmWQCp9n6c9/OHTaA3+cCfJz1z
	 6tAHw4oyjb+6YUYBcg05BCzUrpIZ4eCQ7vxPpMMkjLVSGMg4xHXqpTTn2EAIWifWEa
	 np3DswRivC+WNzrdj50DTZuLVNhrBWNytt07l4jNmDoHiWv/vsSfxr9sZt8KjhEbpa
	 W21eY00szDc4LBZCV+AKZiiqPiMj4w3EeZMGJ4KhZRwxd15m49gDbVIEGC6EWDq1F6
	 YOY/xn746LNMTB/K4I5cecJUNmmKlP/OPAI3ASV9LYq7FXoho6eFXR4w23zXZvn6Yl
	 drP+6MQQJwR0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] sunrpc: allocate a separate bvec array for socket sends
Date: Thu, 23 Jul 2026 21:25:12 -0400
Message-ID: <20260724012515.3833219-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724012515.3833219-1-sashal@kernel.org>
References: <2026072058-disparate-ventricle-c83c@gregkh>
 <20260724012515.3833219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 6b3b697d65d46a0f640216a3f6c72856c159c567 ]

svc_tcp_sendmsg() calls xdr_buf_to_bvec() with the second slot of
rq_bvec as the start, but doesn't reduce the array length by one, which
could lead to an array overrun. Also, rq_bvec is always rq_maxpages in
length, which can be too short in some cases, since the TCP record
marker consumes a slot.

Fix both problems by adding a separate bvec array to the svc_sock that
is specifically for sending. For TCP, make this array one slot longer
than rq_maxpages, to account for the record marker. For UDP, only
allocate as large an array as we need since it's limited to 64k of
payload.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 18c1cc698861 ("SUNRPC: Return an error from xdr_buf_to_bvec() on overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svcsock.h |  3 +++
 net/sunrpc/svcsock.c           | 37 +++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 7c78ec6356b928..9e6ecc3526e774 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -26,6 +26,9 @@ struct svc_sock {
 	void			(*sk_odata)(struct sock *);
 	void			(*sk_owspace)(struct sock *);
 
+	/* For sends (protected by xpt_mutex) */
+	struct bio_vec		*sk_bvec;
+
 	/* private TCP part */
 	/* On-the-wire fragment header: */
 	__be32			sk_marker;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 78b139d8c1f3b9..5a90e3564ebdf1 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -68,6 +68,17 @@
 
 #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
 
+/*
+ * For UDP:
+ * 1 for header page
+ * enough pages for RPCSVC_MAXPAYLOAD_UDP
+ * 1 in case payload is not aligned
+ * 1 for tail page
+ */
+enum {
+	SUNRPC_MAX_UDP_SENDPAGES = 1 + RPCSVC_MAXPAYLOAD_UDP / PAGE_SIZE + 1 + 1
+};
+
 /* To-do: to avoid tying up an nfsd thread while waiting for a
  * handshake request, the request could instead be deferred.
  */
@@ -740,15 +751,14 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec,
-				ARRAY_SIZE(rqstp->rq_bvec), xdr);
+	count = xdr_buf_to_bvec(svsk->sk_bvec, SUNRPC_MAX_UDP_SENDPAGES, xdr);
 
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      count, rqstp->rq_res.len);
 	err = sock_sendmsg(svsk->sk_sock, &msg);
 	if (err == -ECONNREFUSED) {
 		/* ICMP error on earlier request. */
-		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 			      count, rqstp->rq_res.len);
 		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
@@ -1247,19 +1257,19 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	*sentp = 0;
 
 	/* The stream record marker is copied into a temporary page
-	 * fragment buffer so that it can be included in rq_bvec.
+	 * fragment buffer so that it can be included in sk_bvec.
 	 */
 	buf = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
 			      GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	memcpy(buf, &marker, sizeof(marker));
-	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
+	bvec_set_virt(svsk->sk_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1,
-				ARRAY_SIZE(rqstp->rq_bvec) - 1, &rqstp->rq_res);
+	count = xdr_buf_to_bvec(svsk->sk_bvec + 1, RPCSVC_MAXPAGES,
+				&rqstp->rq_res);
 
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	page_frag_free(buf);
@@ -1422,6 +1432,13 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	if (!svsk)
 		return ERR_PTR(-ENOMEM);
 
+	svsk->sk_bvec = kcalloc(RPCSVC_MAXPAGES + 1, sizeof(*svsk->sk_bvec),
+				GFP_KERNEL);
+	if (!svsk->sk_bvec) {
+		kfree(svsk);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	inet = sock->sk;
 
 	if (pmap_register) {
@@ -1431,6 +1448,7 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 				     inet->sk_protocol,
 				     ntohs(inet_sk(inet)->inet_sport));
 		if (err < 0) {
+			kfree(svsk->sk_bvec);
 			kfree(svsk);
 			return ERR_PTR(err);
 		}
@@ -1650,5 +1668,6 @@ static void svc_sock_free(struct svc_xprt *xprt)
 	if (pfc->va)
 		__page_frag_cache_drain(virt_to_head_page(pfc->va),
 					pfc->pagecnt_bias);
+	kfree(svsk->sk_bvec);
 	kfree(svsk);
 }
-- 
2.53.0

