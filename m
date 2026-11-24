Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540035;
	b=orQBIxgfmjQMwD8tQOBzpVvnNwCGJCO2SnZr/MKOU9CTNbS4ans72v/8Ms7lXR7j7TBv
	 Q8gQF1X9m6kKtdBzAjYGF/eka938QHrB80wp5BmulLm/TOK+xNDkMuz/U/IG0HsuH+Caw
	 /cfIIuyNKDuFbjB8fvo61Q/nwLKXnFRi0WNbLR+bmdkiSGfacRwvhdmNIohVcb7jnDsxs
	 FM7z+t9tHh5XzowqWuY7ICm4a6kyogtyH/sBC5ub0JpvycOU34jS111Yh0H1E0jg0m/Q4
	 XC/9N4ESaZI7+CBpx22j96TZiRVNPYELtOElBHOwoJ6KCd2SwEPAk/+TSGrf/98E79g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540035;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PdeRcBZfQ/0omXJZhIA/UvjOC4zkr2LWXvXBdpvLpE8=;
	b=Em2+lVpBJDWtOSqxetCNppqNd5aohHx7DvARlrF2LyVXSl/Vso0DncVveuvMB+fr4udh
	 00F5gJvCxERpCGaqDEYrfKlZyfBQQrr28rPKaK0cVQokA/TDXoheOfyK2ayXXqluQDNxU
	 uqE8B+4G136Y2AO27g1lCFpzRLr5c3kvl7jZYXfrlE81bAdHpF6fp3HN4fOwOr6d86Hqw
	 RXbh5BWthPuCi/ypijCgKTeeZ/dxBX64CoBWWgzAqRlznd+vpb/bYk839sRLzqgIR2Wpe
	 yA578ak0p3/1yX/yqIbpChw1fNRqNfa4LBhSmmeDwiG3CworwSptF1OsHptHVsG5A3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gq3b442w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E1606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gq3b442w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321F21F000C0;
	Tue, 24 Nov 2026 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795540034;
	bh=PdeRcBZfQ/0omXJZhIA/UvjOC4zkr2LWXvXBdpvLpE8=;
	h=Subject:To:Cc:From:Date;
	b=gq3b442wwJmyGckhsXBcvhNLvwKTtB3MPxS8rO9tvKqHJd+8ipEeTr4jHkZbhZwsS
	 HMrmGpsEQp2WjpODNshCh7L0OMNKBOnMt1JW/WFl+sS7piSJ4cBHZq1O1svgXEGTCP
	 2oP0nzmB4pr4o5syMbWbwpiK94BTKcZKu/qpIsrs=
Subject: FAILED: patch "[PATCH] net/smc: fix link group ownership in handshake abort" failed to apply to 6.12-stable tree
To: mjambigi@linux.ibm.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 18:07:35 +0100
Message-ID: <2026112435-economic-unearned-ea8a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e227b511582828c5a6513f70fc6a71211e5efbf0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112435-economic-unearned-ea8a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e227b511582828c5a6513f70fc6a71211e5efbf0 Mon Sep 17 00:00:00 2001
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
Date: Fri, 6 Nov 2026 14:04:57 +0100
Subject: [PATCH] net/smc: fix link group ownership in handshake abort

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

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ec5980add7a9..bfc0c7e71a12 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1013,14 +1013,15 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
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
index 0a9f5418329a..a3164201c142 100644
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
 		mod_delayed_work(system_percpu_wq, &lgr->free_work,
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
 
@@ -1281,10 +1301,12 @@ void smc_conn_free(struct smc_connection *conn)
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
@@ -1519,6 +1541,15 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
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
@@ -1566,12 +1597,20 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
@@ -1582,7 +1621,11 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
@@ -1596,17 +1639,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
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
index 5c18f08a4c8a..bff4c9e17792 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -301,9 +301,9 @@ struct smc_link_group {
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

