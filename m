Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563902;
	b=g4XodMqx8c59ZfXbXTiuzvSvk2u97MuXWTvJCwyJqpfTuwiqAqMQ9I9kTXsCfHgcINu6
	 fWTg2mSoFSkV/pavRWPJ5igYhKGGIJt4zDqylmfJHEQwDJEVIpTe+YtYTBuISidN9cxSk
	 tKpSXHu0ueS81rdVHwhMYjsHTdZNU+scr16h47CJJyNkahJ7y9BKnLiWT//vi8ZfwpmR4
	 BaUvPlGVPvAlnjGRElcJ8LZTJ8TQJZdIy4w7xa44wr4i+BIQEpI1UN7o495FpFPwrkLen
	 K9YmbhNF11P5CqUYTMx4lzGjcDK9mtHl7jyx2jJ3AXP9VJbTrkvyHWRgkwVwaq/pseA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iL87FokRS6FlayCEEXJujTpGxPMvSHKEkhgd3TzKtU8=;
	b=lEgc1Xr9TSSOujPOfVEJ0gRaRq7zG8HsSXt1RUoeqDu9qEtrwRHv+C3tlzyrIFOZlkTH
	 LYb/eZmVUYQnVOv9MqeJ+3NG6NfNwLiFb4TAuRmeR6rifN40MHeqCnGuyLDTeltdLviPr
	 Ptfm+SxxlH1231mR5FPko4VtGh12N5ivPFT+68GP4pLj2K1mTlfG3TiIMqFtGGmHnd6JY
	 ss6j+gRfpNQuGT9/3lHEJ7DgOejNDrTZZsFG8m1XYzTNl+Sn2brI+S0Vb2zUhJ6T/z4kB
	 EYA3vwt7azvGmTv3lOGP2C3Eey5voDoUpr1N0oDmQJtI1vAQfWskxrAcpb78tKtas4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UY5F6bNU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E425606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UY5F6bNU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C152B1F000C6;
	Tue, 24 Nov 2026 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563902;
	bh=iL87FokRS6FlayCEEXJujTpGxPMvSHKEkhgd3TzKtU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UY5F6bNU1NAvHZEfIput7pcTnQHhrd3U0LfxBFNIF8I9c4k+43HflTJIZOLWqmhXH
	 hcGfSB2kug8K6F+tnoDIV/p90UB68DlUI1FbjnC5HjHZYWIfi287BqiyrIgDGXuRmc
	 jNnNyAh5/s6iYBjtLr4Tb/cuoa993o/trtRXJC+kyzTG3wOBcsfSEWQx031UwXxurD
	 z8gBOgno6V0KfbqyIIJ+4cCxSZC99VlGMC7PstU/4ZAQaCGpYtjv2Q255vNfplEYFH
	 G43OeowmUhBQSJlHUdUX6rVMunS6tORCbAhd5equjEY1wLqsUm/vs0wBocPiOH9zOu
	 3cJQhUkMjS41w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net/smc: fix link group ownership in handshake abort
Date: Tue, 24 Nov 2026 18:45:00 -0500
Message-ID: <20261124234419.3360682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112435-economic-unearned-ea8a@gregkh>
References: <2026112435-economic-unearned-ea8a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahanta Jambigi <mjambigi@linux.ibm.com>

[ Upstream commit e227b511582828c5a6513f70fc6a71211e5efbf0 ]

An aborted first-contact handshake can hang the handshake worker on the
socket lock it already holds, reset the clcsock of a socket that has
fallen back to TCP, or corrupt the alert-node lookup when the handshake
retries with the same connection.

The abort leaves a connection registered in a link group that another
context has already unlinked for termination: smc_conn_free() skips the
unregister when lgr->list is empty, so the alert token and alert node
stay in lgr->conns_all. If the handshake retries another device or SMC
version, smc_conn_create() creates a second link group and
smc_lgr_register_conn() inserts the same alert node into it: the token
loop is skipped, rb_link_node() links a node that is still in the old
tree into the new one, and a second sock_hold() is taken where only one
sock_put() will follow. The old group's terminator then keeps returning
that node from rb_first() and can kill a connection that now belongs to
the new group.

smc_lgr_cleanup_early() also starts a second termination of the link
group that is already being terminated, which takes lock_sock() on the
socket the handshake worker holds; if the termination work wins the race
instead, it later kills the freed connection and aborts the clcsock of a
socket that has fallen back to TCP. Making the unregister unconditional
also lets smc_conn_free() reach the delayed free work on a claimed link
group, where the lockless freeing check can arm it after the owner has
cancelled it.

Always unregister the connection, claim a link group for termination
once under lgr_lock, keep the link group alive across the abort, and arm
the delayed free work only under the same lock and cancel it
synchronously before the teardown. Drop an already freed connection in
smc_conn_kill() without running the connection and socket teardown.

Fixes: 2a0674fffb6b ("net/smc: improve abnormal termination of link groups")
Fixes: f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
Cc: stable@vger.kernel.org
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Link: https://patch.msgid.link/20261106130457.1092203-1-mjambigi@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/af_smc.c   | 11 ++++---
 net/smc/smc_core.c | 78 +++++++++++++++++++++++++++++++++-------------
 net/smc/smc_core.h |  6 ++--
 3 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0d00fa56a9002..0adc46c691312 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1010,14 +1010,15 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
 {
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
-	bool lgr_valid = false;
-
-	if (smc_conn_lgr_valid(conn))
-		lgr_valid = true;
+	bool lgr_valid = local_first && smc_conn_lgr_valid(conn);
 
+	if (lgr_valid)
+		smc_lgr_hold(lgr);	/* lgr_put below */
 	smc_conn_free(conn);
-	if (local_first && lgr_valid)
+	if (lgr_valid) {
 		smc_lgr_cleanup_early(lgr);
+		smc_lgr_put(lgr);
+	}
 }
 
 /* check if there is a rdma device available for this connection. */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 1f340de96ec83..982c9cf39ba6a 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -80,16 +80,21 @@ static void smc_ibdev_cnt_dec(struct smc_link *lnk)
 
 static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 {
+	spinlock_t *lgr_lock;
+
 	/* client link group creation always follows the server link group
 	 * creation. For client use a somewhat higher removal delay time,
 	 * otherwise there is a risk of out-of-sync link groups.
 	 */
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
 	if (!lgr->freeing) {
 		mod_delayed_work(system_wq, &lgr->free_work,
 				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
 						SMC_LGR_FREE_DELAY_CLNT :
 						SMC_LGR_FREE_DELAY_SERV);
 	}
+	spin_unlock_bh(lgr_lock);
 }
 
 /* Register connection's alert token in our lookup structure.
@@ -679,19 +684,34 @@ int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
-void smc_lgr_cleanup_early(struct smc_link_group *lgr)
+/* Claim a link group for termination. Only one context can succeed: the
+ * lgr is removed from its list and marked freeing under lgr_lock.
+ * Returns false if @lgr is NULL or another context owns it.
+ */
+static bool smc_lgr_claim(struct smc_link_group *lgr)
 {
 	spinlock_t *lgr_lock;
 
 	if (!lgr)
-		return;
-
+		return false;
 	smc_lgr_list_head(lgr, &lgr_lock);
 	spin_lock_bh(lgr_lock);
+	if (lgr->freeing || lgr->terminating || list_empty(&lgr->list)) {
+		spin_unlock_bh(lgr_lock);
+		return false;
+	}
 	/* do not use this link group for new connections */
-	if (!list_empty(&lgr->list))
-		list_del_init(&lgr->list);
+	list_del_init(&lgr->list);
+	lgr->freeing = 1;
 	spin_unlock_bh(lgr_lock);
+	return true;
+}
+
+/* The caller must keep @lgr alive for the duration of the call. */
+void smc_lgr_cleanup_early(struct smc_link_group *lgr)
+{
+	if (!smc_lgr_claim(lgr))
+		return;	/* another context owns the termination */
 	__smc_lgr_terminate(lgr, true);
 }
 
@@ -1260,10 +1280,12 @@ void smc_conn_free(struct smc_connection *conn)
 		if (current_work() != &conn->abort_work)
 			cancel_work_sync(&conn->abort_work);
 	}
-	if (!list_empty(&lgr->list)) {
+	/* The handshake can retry another device or SMC version with this
+	 * connection, so it must never stay registered in an lgr it left.
+	 */
+	if (!list_empty(&lgr->list))
 		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
-		smc_lgr_unregister_conn(conn);
-	}
+	smc_lgr_unregister_conn(conn);
 
 	if (!lgr->conns_num)
 		smc_lgr_schedule_free_work(lgr);
@@ -1498,6 +1520,15 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
 {
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 
+	if (conn->freed) {
+		/* The connection was already freed, e.g. by a close or
+		 * a handshake that fell back to TCP. Do not abort a socket
+		 * that is no longer part of this link group.
+		 */
+		smc_lgr_unregister_conn(conn);
+		return;
+	}
+
 	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)
 		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
 	else
@@ -1545,12 +1576,20 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 	struct smc_connection *conn;
 	struct smc_sock *smc;
 	struct rb_node *node;
+	spinlock_t *lgr_lock;
 
-	if (lgr->terminating)
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
+	if (lgr->terminating) {
+		spin_unlock_bh(lgr_lock);
 		return;	/* lgr already terminating */
-	/* cancel free_work sync, will terminate when lgr->freeing is set */
-	cancel_delayed_work(&lgr->free_work);
+	}
 	lgr->terminating = 1;
+	spin_unlock_bh(lgr_lock);
+	/* The lgr is claimed, so no new free_work can be armed; wait for
+	 * one that is already queued or running.
+	 */
+	cancel_delayed_work_sync(&lgr->free_work);
 
 	/* kill remaining link group connections */
 	read_lock_bh(&lgr->conns_lock);
@@ -1561,7 +1600,11 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		sock_hold(&smc->sk); /* sock_put below */
 		read_unlock_bh(&lgr->conns_lock);
 		lock_sock(&smc->sk);
-		smc_conn_kill(conn, soft);
+		/* The connection may have been re-registered in another
+		 * link group by a retried handshake in the meantime.
+		 */
+		if (conn->lgr == lgr)
+			smc_conn_kill(conn, soft);
 		release_sock(&smc->sk);
 		sock_put(&smc->sk); /* sock_hold above */
 		read_lock_bh(&lgr->conns_lock);
@@ -1575,17 +1618,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 /* unlink link group and schedule termination */
 void smc_lgr_terminate_sched(struct smc_link_group *lgr)
 {
-	spinlock_t *lgr_lock;
-
-	smc_lgr_list_head(lgr, &lgr_lock);
-	spin_lock_bh(lgr_lock);
-	if (list_empty(&lgr->list) || lgr->terminating || lgr->freeing) {
-		spin_unlock_bh(lgr_lock);
+	if (!smc_lgr_claim(lgr))
 		return;	/* lgr already terminating */
-	}
-	list_del_init(&lgr->list);
-	lgr->freeing = 1;
-	spin_unlock_bh(lgr_lock);
 	schedule_work(&lgr->terminate_work);
 }
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 69b54ecd65031..bc32e6c08fb56 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -288,9 +288,9 @@ struct smc_link_group {
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
 	struct work_struct	terminate_work;	/* abnormal lgr termination */
 	struct workqueue_struct	*tx_wq;		/* wq for conn. tx workers */
-	u8			sync_err : 1;	/* lgr no longer fits to peer */
-	u8			terminating : 1;/* lgr is terminating */
-	u8			freeing : 1;	/* lgr is being freed */
+	u8			sync_err;	/* lgr no longer fits to peer */
+	u8			terminating;	/* lgr is terminating */
+	u8			freeing;	/* lgr is being freed */
 
 	refcount_t		refcnt;		/* lgr reference count */
 	bool			is_smcd;	/* SMC-R or SMC-D */
-- 
2.53.0

