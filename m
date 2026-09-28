Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73646EC98
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583985; cv=none; b=JSXLjHaUKGuVqdhKyevkqCdlynGqltSDSe5+9L18j6I7teYC0SpZ3Sk9Wf4yMHlwspMzG7tJPXDXKnf38YPGUvi9p5sFxUifH4xeoloUzcfh5BoBLRcsL1wcSD/tcDpQO6r+LjnTHv+BTtM/WQfTz73mqwW6CJ82D+D80MJ11Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583985; c=relaxed/simple;
	bh=hoz2PWbxwglBUqn2GeLOv0PDatT28ZkpNEwAV+Iz7Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZpUMUQR2ul1WrlNcNMd/o7ePa6szxlOFK06UFS7aEFSIWhe/jmtzkRYwOHWBTKS+qR1uIus+aN/5rhcC1iCnzjZrd6IMMhHzGviAn1rrwQSVvX3CsKIGlB0H48BhjiNP+Aek4b0vqTUIaPwF/ZngQVG1T/CgzqDuvvtZAUq/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THth7EM8; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THth7EM8"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a47d5764feso147582a91.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790583983; x=1791188783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7TZNITFoQ1twO0nEHJsueQMwqRhiY/RYAx0j8E+QXo=;
        b=THth7EM88xGjHSpC+9JvdFzpg4fQH5GPTPWXMgPsWqZDTDmw7RN/mJ8qHlwpb7+NPX
         r8+mT6t7t03sQqV5qQk5i1stOlO2lPJyCGTRH6Zx5ExTk7ixYJUS9qgRlG1jslY5NCLH
         aY8Rl8sPjWCTb+rZStQ/9zXR8eZI02NeE4TcKcdSkANYJhquWLTD5/N/yG94vXkjqedF
         Pdb/hTuLiSpdLxtNPwBzzPqPeQOKj87RFq5WOPHCpjQTGLK5WniQvx+iQTJiejCVp4ND
         KA+ZJ9KEB/bGq1RPy7FCkNrtHxvXrwIS41tYDdulo40ruI2B6wGTe37JSPk7ivAOmERc
         De+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790583983; x=1791188783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7TZNITFoQ1twO0nEHJsueQMwqRhiY/RYAx0j8E+QXo=;
        b=qmgROrLFEDjkInsDxHmPabAflm6EcbsVTTBdOXNCY1UT9TmUDZdVI+SspNp5RrjQPh
         E0yPmQXXSYVrh7geOWwi3kv1DtBOyJgeCraDi1nxkqNF2mDvOPsV6YlQHPqplWD/pjvt
         klMzdkX9BrWIk5v/VbopRTxXUWszc7qsUWlnWkajuYnBuqZ0AmpSuiaSEz1TXMQgDGAW
         LDqriShxRR2CJMnzoDxN3O2v+23SwIorfMf2ys7nMQKk9IoUEIj3GGjqnaWB0O1tONnA
         zD4HNAXx5D5M4mm8+6ftF5r8O7UX6HzF0S7Jt8rSMU5eZbovJfosSyrkkSl1+zylHqdd
         LM/w==
X-Forwarded-Encrypted: i=1; AKwUvBwqoiIqTILh39IiCHmQnFyGAre9s0SS2CzUUi2JYo+HkAV60ePQZm8b65ePgO9FPfzXz/zUlkk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZL35vcwJECi2UZpT1Bcgzg00hAa4DFR+T7pBNSEjijOwzX45G
	G0fozDcCyLgGLfsZq3Iu81RxsbP4ImzIyGGa/lwdSN47mhlDkVIcXrM5
X-Gm-Gg: AYBFou2Wk/5BbXqoRyVJtNYM3mZg9vRZdWy0Wvfne0zWY2Xt7Vedzj5Qt8lZ3ZzNsBx
	wK7RnVZ6ESMPRWN1Rz3qguQInTYb7bsLlUESO6f+IFcAfSkNsku2vlAudWS3q2JUSgAA8EuYycw
	9GqfpOgEpgEWm3/K5k2yk/L2pozN3EKER+JIyOap4q9XxR309hRmdFwvIrNwwnuHGXBd+ZAv3/H
	WFL0ii8H6o3OIloeyRbgl61de9K4yxUsNPDOfbmtUzUmHRWyvmfdB/vZxOiGEg9We/pYm0chmJC
	FtNOXIBaSSxupYNIjbxsTM5Kku8kUdMcEH94uvJGZKBJeiiC6ZYRcnN1jY3W3Cr70bJzwlIyvYA
	sHb+CyQlKe6ucAj91oWnhvZzGhzn2BCveokY251O/9zNH0BJx2vhe0ExZzWbEA1neAgADdKAf7G
	kc75YJdivRnnWM+U2jGMZhSlYkOXB++meNXhhw5JJJ551/Tbp/qqEVzVQ/YMiwbgwUncaI5kjLX
	jHsNNcXwBHWoR5KcORRwbNS3caPrBwDV6wlMrML+g1Oy2lL/C1frtCdNp58ZUPlf7FsgWyHUji/
	w/Juk1ns
X-Received: by 2002:a17:90b:39a7:b0:3a0:bbd8:5ba7 with SMTP id 98e67ed59e1d1-3a0bbd879cemr6684055a91.62.1790583983069;
        Mon, 28 Sep 2026 01:26:23 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8d31b4esm7104456a91.3.2026.09.28.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:26:22 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net v3 1/1] tipc: destroy topsrv workqueues before closing connections
Date: Mon, 28 Sep 2026 16:24:38 +0800
Message-ID: <0b418e09f7a48ea35ed8ec4ecca1e209f3a8604f.1790157006.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790157006.git.xuyuqiabc@gmail.com>
References: <cover.1790157006.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_topsrv_stop() closed subscriber connections while the topology
server's send and receive workqueues were still running. Socket
callbacks and subscription events could then queue more work, and
in-flight send/recv work could drop the last connection reference
during the conn_idr walk.

That race produced several teardown failures: refcount_t addition on
0 from conn_get() on a connection whose release was blocked on
idr_lock, a subsequent use-after-free in tipc_conn_close(),
queue_work() on an already destroyed workqueue from the listener
data-ready callback, and an RCU stall in tipc_topsrv_exit_net()
while the walk spun under idr_lock.

Clear srv->listener under idr_lock so it acts as a shutdown flag,
skip queue_work() once it is NULL, destroy the workqueues to flush
in-flight work, and only then close the remaining connections.
Refuse tipc_conn_lookup() after that flag is cleared, and drop
idr_lock when the teardown walk finds no connection, so an
in-flight subscription event cannot pin idr_in_use while the
walk holds the lock.

v3 supersedes the narrower in-thread diff Tung Quang Nguyen
posted on 2026-09-23. It keeps his teardown order and adds the
lookup refusal and the empty-idr unlock.

Fixes: c5fa7b3cf3cb ("tipc: introduce new TIPC server infrastructure")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v3:
 - This version supersedes the narrower diff Tung Quang Nguyen
   posted in-thread on 2026-09-23 (replying to v2 1/2, Message-ID
   DU4P189MB3750BEF36FF7EEBA03E152FFC6822@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM).
   v3 keeps his teardown order and adds the lookup refusal and the
   empty-idr unlock.
 - Drop v2 2/2; the idr walk rewrite is not needed once in-flight
   work is flushed first.
 - v2 Link: https://lore.kernel.org/all/cover.1789960909.git.xuyuqiabc@gmail.com/

Changes in v2:
 - Add the exact reproduction command and the stack traces we observe
   to this changelog, as requested by Tung Quang Nguyen.
 - v1 Link: https://lore.kernel.org/all/cover.1789722780.git.xuyuqiabc@gmail.com/

 net/tipc/topsrv.c | 80 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index af530c9ed840..82e9f44e2fe4 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -55,7 +55,7 @@
 /**
  * struct tipc_topsrv - TIPC server structure
  * @conn_idr: identifier set of connection
- * @idr_lock: protect the connection identifier set
+ * @idr_lock: protect the connection identifier set and listener
  * @idr_in_use: amount of allocated identifier entry
  * @net: network namespace instance
  * @awork: accept work item
@@ -218,6 +218,10 @@ static struct tipc_conn *tipc_conn_lookup(struct tipc_topsrv *s, int conid)
 	struct tipc_conn *con;
 
 	spin_lock_bh(&s->idr_lock);
+	if (!s->listener) {
+		spin_unlock_bh(&s->idr_lock);
+		return NULL;
+	}
 	con = idr_find(&s->conn_idr, conid);
 	if (!connected(con) || !kref_get_unless_zero(&con->kref))
 		con = NULL;
@@ -301,10 +305,20 @@ static void tipc_conn_send_to_sock(struct tipc_conn *con)
 static void tipc_conn_send_work(struct work_struct *work)
 {
 	struct tipc_conn *con = container_of(work, struct tipc_conn, swork);
+	struct tipc_topsrv *srv;
+
+	srv = con->server;
+	spin_lock_bh(&srv->idr_lock);
+	if (!srv->listener) {
+		spin_unlock_bh(&srv->idr_lock);
+		goto out;
+	}
+	spin_unlock_bh(&srv->idr_lock);
 
 	if (connected(con))
 		tipc_conn_send_to_sock(con);
 
+out:
 	conn_put(con);
 }
 
@@ -334,8 +348,14 @@ void tipc_topsrv_queue_evt(struct net *net, int conid,
 	list_add_tail(&e->list, &con->outqueue);
 	spin_unlock_bh(&con->outqueue_lock);
 
-	if (queue_work(srv->send_wq, &con->swork))
-		return;
+	spin_lock_bh(&srv->idr_lock);
+	if (srv->listener) {
+		if (queue_work(srv->send_wq, &con->swork)) {
+			spin_unlock_bh(&srv->idr_lock);
+			return;
+		}
+	}
+	spin_unlock_bh(&srv->idr_lock);
 err:
 	conn_put(con);
 }
@@ -346,14 +366,20 @@ void tipc_topsrv_queue_evt(struct net *net, int conid,
  */
 static void tipc_conn_write_space(struct sock *sk)
 {
+	struct tipc_topsrv *srv;
 	struct tipc_conn *con;
 
 	read_lock_bh(&sk->sk_callback_lock);
 	con = sk->sk_user_data;
 	if (connected(con)) {
-		conn_get(con);
-		if (!queue_work(con->server->send_wq, &con->swork))
-			conn_put(con);
+		srv = con->server;
+		spin_lock_bh(&srv->idr_lock);
+		if (srv->listener) {
+			conn_get(con);
+			if (!queue_work(srv->send_wq, &con->swork))
+				conn_put(con);
+		}
+		spin_unlock_bh(&srv->idr_lock);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -418,8 +444,17 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *con)
 static void tipc_conn_recv_work(struct work_struct *work)
 {
 	struct tipc_conn *con = container_of(work, struct tipc_conn, rwork);
+	struct tipc_topsrv *srv;
 	int count = 0;
 
+	srv = con->server;
+	spin_lock_bh(&srv->idr_lock);
+	if (!srv->listener) {
+		spin_unlock_bh(&srv->idr_lock);
+		goto out;
+	}
+	spin_unlock_bh(&srv->idr_lock);
+
 	while (connected(con)) {
 		if (tipc_conn_rcv_from_sock(con))
 			break;
@@ -430,6 +465,7 @@ static void tipc_conn_recv_work(struct work_struct *work)
 			count = 0;
 		}
 	}
+out:
 	conn_put(con);
 }
 
@@ -438,6 +474,7 @@ static void tipc_conn_recv_work(struct work_struct *work)
  */
 static void tipc_conn_data_ready(struct sock *sk)
 {
+	struct tipc_topsrv *srv;
 	struct tipc_conn *con;
 
 	trace_sk_data_ready(sk);
@@ -445,9 +482,14 @@ static void tipc_conn_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	con = sk->sk_user_data;
 	if (connected(con)) {
-		conn_get(con);
-		if (!queue_work(con->server->rcv_wq, &con->rwork))
-			conn_put(con);
+		srv = con->server;
+		spin_lock_bh(&srv->idr_lock);
+		if (srv->listener) {
+			conn_get(con);
+			if (!queue_work(srv->rcv_wq, &con->rwork))
+				conn_put(con);
+		}
+		spin_unlock_bh(&srv->idr_lock);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -503,8 +545,12 @@ static void tipc_topsrv_listener_data_ready(struct sock *sk)
 
 	read_lock_bh(&sk->sk_callback_lock);
 	srv = sk->sk_user_data;
-	if (srv)
-		queue_work(srv->rcv_wq, &srv->awork);
+	if (srv) {
+		spin_lock_bh(&srv->idr_lock);
+		if (srv->listener)
+			queue_work(srv->rcv_wq, &srv->awork);
+		spin_unlock_bh(&srv->idr_lock);
+	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -700,23 +746,27 @@ static void tipc_topsrv_stop(struct net *net)
 	struct tipc_conn *con;
 	int id;
 
+	spin_lock_bh(&srv->idr_lock);
+	srv->listener = NULL;
+	spin_unlock_bh(&srv->idr_lock);
+	tipc_topsrv_work_stop(srv);
+
 	spin_lock_bh(&srv->idr_lock);
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
 		if (con) {
-			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
 			tipc_conn_close(con);
-			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
+			continue;
 		}
+		spin_unlock_bh(&srv->idr_lock);
+		spin_lock_bh(&srv->idr_lock);
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-	srv->listener = NULL;
 	spin_unlock_bh(&srv->idr_lock);
 
-	tipc_topsrv_work_stop(srv);
 	sock_release(lsock);
 	idr_destroy(&srv->conn_idr);
 	kfree(srv);
-- 
2.55.0

