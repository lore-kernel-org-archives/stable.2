Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272683;
	b=JMCHREr3ZJEHoobLhYLZFg11j5IrE25EnChH9yUrFjQIXT/uiMnZQvNMpGNn1ZFSPaqJ
	 D1+b14f9sjpIuC7iYGqd9YyRoBP9448MLydpHbAK47TXwVCYVe+kcR9PipGF8gimZJVK/
	 bvo0zdye0uX8pUVCzzPKFw9eW9Phvf7PWreIvxPdvEXvRDPQEi+eFAyXZXW0l8XV92GPc
	 NtNnbalUHTj10Ta3P6oOlg9ZtW73HbbkjaJCp3sd9IGG4y3yRcXce9TLHMhB9jNz3wJfP
	 BOsnQl9ULDfqrcsER0OcIM+56xCShKrjbiPWwqoqcNDxLVb66nfWHDbgjvHlI5FJi/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272683;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VXZoSZ+8iB6NA/SKArZDaCPPNjh9jG/YfMJ23q0opl8=;
	b=KVn80dkQlPQTgcn8mUtTU2d5HV7oolQKlTySpDa/yvSqkUARoZsAm+CrdOXkxAUVijl4
	 b9wyfhn/UBvlE7VQ//Til8TCaftmPf1wsaMmOqhKyiSZi1CRCjNE/jNKLUMU092IVbuRy
	 ZlDtdD7Hp70pWISRD+jARwCuSJrk3vRtKZanO4wWYPyjsV4g9gT4fWIXQ0SnXFb3FgAIO
	 poutbsOfXkeG47rYcVt2xeolOMF5CWIR+fEDyno4Y87H3nvKy2JFpyoWy6BWH3/op1OXF
	 momjYNBXAV3NhnpuytDtxebRKp3rasCN/FC6ONPxZzYHh5Co2Qfm9/d8ZkC2BAAKexA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJcvbVhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EC606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJcvbVhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90E21F008A2;
	Tue, 10 Nov 2026 01:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272683;
	bh=VXZoSZ+8iB6NA/SKArZDaCPPNjh9jG/YfMJ23q0opl8=;
	h=From:To:Cc:Subject:Date;
	b=iJcvbVhGSsZD92XpbBwuViZ6JkpOomYrJDkqLn2aShZ2Lepc1p5NoEvnZF1TSrSoj
	 GBHvHLliui1E65j+BHRh24vkHNsJaFpwX1MkRQ6QPt+mMy4iMtljOvqeuCiZ8P47XA
	 Xcq+OrKrkXjcUmqR6aT/QRjIjgu7RIilerbW/QYLFRtlucLYipRcLfcHm22K87DCId
	 vr/4WBwPWEn+TI5yU6vyh10QbNer7QzQc6SgLAX53N0nS8KuGYXLcx2BgQl7h6Aj8Z
	 M/CND/mk2G+WLPDtEemXYO1+ywj+OMC4OrxKh6giXNJ39LVvI3MD8ANcxTQTp2tLjS
	 0DrNqI7nEFXAA==
From: Sasha Levin <sashal@kernel.org>
To: sahilchandna@linux.microsoft.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: mana: Add support to process throttled EQEs" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:04:41 -0500
Message-ID: <20261109200441-failed-6.18-684603842b78@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 684603842b78f75835d21fdf5c19ae717ed8eb1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200441-failed-6.18-684603842b78@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 684603842b78f75835d21fdf5c19ae717ed8eb1a Mon Sep 17 00:00:00 2001
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
Date: Wed, 28 Oct 2026 03:40:17 -0500
Subject: [PATCH] net: mana: Add support to process throttled EQEs

When an event queue nears full, the hardware coalesces the per-CQ
GDMA_EQE_COMPLETION notifications into a single throttle EQE (type 4)
that carries no cq_id. The driver does not handle this event type, so
it falls through to the default case and is dropped. Any CQ whose
completion notification was replaced by the throttle EQE can remain
unserviced, causing its queue to stall.

This was observed internally as a TX stall:

  ens1: NETDEV WATCHDOG: CPU: 45: transmit queue 1 timed out 15133 ms
  mana 7870:00:00.0: HWC: Request timed out: 60000 ms
  mana 7870:00:00.0: Gf stats wk handler: gf stats query timed out.
  ens1: NETDEV WATCHDOG: CPU: 20: transmit queue 0 timed out 15859 ms
  ens1: NETDEV WATCHDOG: CPU: 15: transmit queue 0 timed out 31731 ms
  ens1: NETDEV WATCHDOG: CPU: 21: transmit queue 0 timed out 47603 ms
  ens1: NETDEV WATCHDOG: CPU: 42: transmit queue 0 timed out 62451 ms

Handle the throttle EQE:

- Record up to two child CQs per EQ when a CQ is created with a parent
  EQ. A mana_en EQ serves one TX CQ and one RX CQ, and the HWC EQ
  serves the HWC CQ.
- On a throttle EQE, call the callback of each child CQ that is still
  in cq_table[].
- Before a child CQ is freed, unlink it from its parent EQ and from
  cq_table[] in mana_gd_detach_cq(), then wait for an RCU
  grace period, because mana_gd_intr() reads both under
  rcu_read_lock(). mana_destroy_txq() and mana_destroy_rxq() detach
  the CQ before deleting its NAPI, so the synchronize_net() that NAPI
  deletion already needs also covers the CQ. mana_hwc_destroy_channel()
  detaches the HWC CQ and waits for a grace period before freeing the
  HWC queues.
- Advertise the capability bit for throttled EQE.
- Add a throttle eqe counter per queue.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Cc: stable@vger.kernel.org
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Link: https://patch.msgid.link/20261028084020.2051254-1-sahilchandna@linux.microsoft.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 88 +++++++++++++++++--
 .../net/ethernet/microsoft/mana/hw_channel.c  |  9 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 ++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 19 +++-
 include/net/mana/gdma.h                       | 19 +++-
 include/net/mana/mana.h                       |  1 +
 6 files changed, 143 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8c915e0087846..ab942d5bfe058 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -757,6 +757,27 @@ void mana_gd_free_service_wq(struct gdma_context *gc)
 	gc->service_wq = NULL;
 }
 
+static void mana_gd_schedule_eq_cqs(struct gdma_queue *eq)
+{
+	struct gdma_context *gc = eq->gdma_dev->gdma_context;
+	struct gdma_queue *cq;
+	u8 i;
+
+	for (i = 0; i < GDMA_EQ_MAX_CHILD_CQ; i++) {
+		cq = rcu_dereference(eq->eq.child_cq[i]);
+
+		if (!cq)
+			continue;
+
+		if (cq->id >= READ_ONCE(gc->max_num_cqs) ||
+		    !gc->cq_table || gc->cq_table[cq->id] != cq)
+			continue;
+
+		if (cq->cq.callback)
+			cq->cq.callback(cq->cq.context, cq);
+	}
+}
+
 static void mana_gd_process_eqe(struct gdma_queue *eq)
 {
 	u32 head = eq->head % (eq->queue_size / GDMA_EQE_SIZE);
@@ -787,6 +808,14 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 
 		break;
 
+	case GDMA_EQE_THROTTLE:
+		u64_stats_update_begin(&eq->eq.stats.syncp);
+		u64_stats_inc(&eq->eq.stats.throttle_count);
+		u64_stats_update_end(&eq->eq.stats.syncp);
+
+		mana_gd_schedule_eq_cqs(eq);
+		break;
+
 	case GDMA_EQE_TEST_EVENT:
 		gc->test_event_eq_id = eq->id;
 		complete(&gc->eq_test_event);
@@ -1032,6 +1061,8 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	queue->id = INVALID_QUEUE_ID;
 
+	u64_stats_init(&queue->eq.stats.syncp);
+
 	log2_num_entries = ilog2(queue->queue_size / GDMA_EQE_SIZE);
 
 	if (spec->eq.log2_throttle_limit > log2_num_entries) {
@@ -1073,25 +1104,66 @@ static void mana_gd_create_cq(const struct gdma_queue_spec *spec,
 			      struct gdma_queue *queue)
 {
 	u32 log2_num_entries = ilog2(spec->queue_size / GDMA_CQE_SIZE);
+	struct gdma_queue *parent;
+	u8 i;
 
 	queue->head |= INITIALIZED_OWNER_BIT(log2_num_entries);
-	queue->cq.parent = spec->cq.parent_eq;
+	parent = spec->cq.parent_eq;
+	queue->cq.parent = parent;
 	queue->cq.context = spec->cq.context;
 	queue->cq.callback = spec->cq.callback;
+
+	if (!parent)
+		return;
+
+	/* For throttled EQE store the child CQ */
+	for (i = 0; i < GDMA_EQ_MAX_CHILD_CQ; i++) {
+		if (!rcu_access_pointer(parent->eq.child_cq[i])) {
+			rcu_assign_pointer(parent->eq.child_cq[i], queue);
+			return;
+		}
+	}
+
+	WARN_ONCE(1, "mana: EQ %u has no free child CQ slot\n", parent->id);
 }
 
-static void mana_gd_destroy_cq(struct gdma_context *gc,
-			       struct gdma_queue *queue)
+/* Unlink queue from its parent EQ's child_cq[] and from gc->cq_table[].
+ *
+ * Return: true if queue was in the parent EQ's child_cq[]. In that case the
+ * caller must wait for an RCU grace period before freeing queue, because
+ * mana_gd_intr() may still be handling a throttle EQE for it.
+ */
+bool mana_gd_detach_cq(struct gdma_context *gc, struct gdma_queue *queue)
 {
+	struct gdma_queue *eq = queue->cq.parent;
+	bool attached = false;
 	u32 id = queue->id;
+	u8 i;
+
+	if (eq) {
+		for (i = 0; i < GDMA_EQ_MAX_CHILD_CQ; i++) {
+			if (rcu_access_pointer(eq->eq.child_cq[i]) == queue) {
+				RCU_INIT_POINTER(eq->eq.child_cq[i], NULL);
+				attached = true;
+			}
+		}
+	}
 
-	if (id >= gc->max_num_cqs)
-		return;
+	/* Check if CQ might have been detached already, only clear if
+	 * it still points to same queue .
+	 */
+	if (id < gc->max_num_cqs && READ_ONCE(gc->cq_table[id]) == queue)
+		WRITE_ONCE(gc->cq_table[id], NULL);
 
-	if (!gc->cq_table[id])
-		return;
+	return attached;
+}
 
-	gc->cq_table[id] = NULL;
+static void mana_gd_destroy_cq(struct gdma_context *gc,
+			       struct gdma_queue *queue)
+{
+	/* Wait for irq reader holding the cq */
+	if (mana_gd_detach_cq(gc, queue))
+		synchronize_net();
 }
 
 int mana_gd_create_hwc_queue(struct gdma_dev *gd,
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 3bca4b683134b..fb9f38f65911c 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -364,7 +364,7 @@ static void mana_hwc_comp_event(void *ctx, struct gdma_queue *q_self)
 
 	completions = hwc_cq->comp_buf;
 	comp_read = mana_gd_poll_cq(q_self, completions, hwc_cq->queue_depth);
-	WARN_ON_ONCE(comp_read <= 0 || comp_read > hwc_cq->queue_depth);
+	WARN_ON_ONCE(comp_read < 0 || comp_read > hwc_cq->queue_depth);
 
 	for (i = 0; i < comp_read; ++i) {
 		comp_data = *(struct hwc_rx_oob *)completions[i].cqe_data;
@@ -820,9 +820,14 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	 */
 	if (gc->max_num_cqs > 0) {
 		mana_smc_teardown_hwc(&gc->shm_channel, false);
-		gc->max_num_cqs = 0;
+		WRITE_ONCE(gc->max_num_cqs, 0);
 	}
 
+	if (hwc->cq)
+		mana_gd_detach_cq(gc, hwc->cq->gdma_cq);
+
+	synchronize_rcu();
+
 	if (hwc->txq)
 		mana_hwc_destroy_wq(hwc, hwc->txq);
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 6b7c027e497ed..e6d494df22e4d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2703,6 +2703,7 @@ static void mana_deinit_txq(struct mana_port_context *apc, struct mana_txq *txq)
 
 static void mana_destroy_txq(struct mana_port_context *apc)
 {
+	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
 	struct napi_struct *napi;
 	int i;
 
@@ -2721,8 +2722,6 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 			napi_synchronize(napi);
 			napi_disable_locked(napi);
 			cancel_work_sync(&apc->tx_qp[i]->tx_cq.dim.work);
-			netif_napi_del_locked(napi);
-			apc->tx_qp[i]->txq.napi_initialized = false;
 		}
 
 		/* Forget the SKBs freed without being completed after a drain
@@ -2735,6 +2734,18 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		if (apc->tx_qp[i]->tx_object != INVALID_MANA_HANDLE)
 			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 
+		if (apc->tx_qp[i]->txq.napi_initialized) {
+			/* Detach the CQ only after the WQ object is destroyed,
+			 * so a completion EQE that arrives before then still
+			 * finds the CQ in cq_table[] rather than hitting the
+			 * WARN in mana_gd_process_eqe(). One grace period then
+			 * covers both mana_gd_intr() and NAPI users.
+			 */
+			mana_gd_detach_cq(gc, apc->tx_qp[i]->tx_cq.gdma_cq);
+			netif_napi_del_locked(napi);
+			apc->tx_qp[i]->txq.napi_initialized = false;
+		}
+
 		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
 
 		mana_deinit_txq(apc, &apc->tx_qp[i]->txq);
@@ -2941,7 +2952,6 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 
 		napi_disable_locked(napi);
 		cancel_work_sync(&rxq->rx_cq.dim.work);
-		netif_napi_del_locked(napi);
 	}
 
 	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
@@ -2950,6 +2960,12 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (rxq->rxobj != INVALID_MANA_HANDLE)
 		mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
+	if (napi_initialized) {
+		/* See the comment in mana_destroy_txq() */
+		mana_gd_detach_cq(gc, rxq->rx_cq.gdma_cq);
+		netif_napi_del_locked(napi);
+	}
+
 	mana_deinit_cq(apc, &rxq->rx_cq);
 
 	if (rxq->xdp_save_va)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 33db79569d3b6..a91eb12badca4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -147,7 +147,8 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 		return ARRAY_SIZE(mana_eth_stats) +
 		       ARRAY_SIZE(mana_phy_stats) +
 		       ARRAY_SIZE(mana_hc_stats)  +
-		       num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+		       num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT +
+				       MANA_STATS_EQ_COUNT);
 
 	case ETH_SS_PRIV_FLAGS:
 		return MANA_PRIV_FLAG_MAX;
@@ -198,6 +199,9 @@ static void mana_get_strings_stats(struct mana_port_context *apc, u8 **data)
 		ethtool_sprintf(data, "tx_%d_csum_partial", i);
 		ethtool_sprintf(data, "tx_%d_mana_map_err", i);
 	}
+
+	for (i = 0; i < num_queues; i++)
+		ethtool_sprintf(data, "eq_%d_throttle_events", i);
 }
 
 static void mana_get_strings_priv_flags(u8 **data)
@@ -234,6 +238,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	void *phy_stats = &apc->phy_stats;
 	struct mana_stats_rx *rx_stats;
 	struct mana_stats_tx *tx_stats;
+	struct gdma_eq_stats *eq_stats;
 	unsigned int start;
 	u64 packets, bytes;
 	u64 xdp_redirect;
@@ -251,6 +256,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	u64 csum_partial;
 	u64 mana_map_err;
 	int q, i = 0, j;
+	u64 throttled;
 
 	if (!apc->port_is_up)
 		return;
@@ -325,6 +331,17 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 		data[i++] = csum_partial;
 		data[i++] = mana_map_err;
 	}
+
+	for (q = 0; q < num_queues; q++) {
+		eq_stats = &apc->eqs[q].eq->eq.stats;
+
+		do {
+			start = u64_stats_fetch_begin(&eq_stats->syncp);
+			throttled = u64_stats_read(&eq_stats->throttle_count);
+		} while (u64_stats_fetch_retry(&eq_stats->syncp, start));
+
+		data[i++] = throttled;
+	}
 }
 
 static u32 mana_get_rx_ring_count(struct net_device *ndev)
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 0b52582118e84..29d152e185967 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -60,6 +60,7 @@ enum gdma_work_request_flags {
 
 enum gdma_eqe_type {
 	GDMA_EQE_COMPLETION		= 3,
+	GDMA_EQE_THROTTLE		= 4,
 	GDMA_EQE_TEST_EVENT		= 64,
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
@@ -291,6 +292,7 @@ struct gdma_dev {
 #define GDMA_EQE_SIZE 16
 #define GDMA_MAX_SQE_SIZE 512
 #define GDMA_MAX_RQE_SIZE 256
+#define GDMA_EQ_MAX_CHILD_CQ 2
 
 #define GDMA_COMP_DATA_SIZE 0x3C
 
@@ -318,6 +320,11 @@ struct gdma_event {
 
 struct gdma_queue;
 
+struct gdma_eq_stats {
+	u64_stats_t throttle_count;
+	struct u64_stats_sync syncp;
+};
+
 struct mana_eq {
 	struct gdma_queue	*eq;
 	struct dentry		*mana_eq_debugfs;
@@ -371,6 +378,10 @@ struct gdma_queue {
 			unsigned int irq;
 
 			u32 log2_throttle_limit;
+
+			struct gdma_eq_stats stats;
+
+			struct gdma_queue __rcu *child_cq[GDMA_EQ_MAX_CHILD_CQ];
 		} eq;
 
 		struct {
@@ -601,6 +612,8 @@ void mana_gd_free_service_wq(struct gdma_context *gc);
 void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_vld,
 		      u32 mod_comps, bool mod_comps_vld);
 
+bool mana_gd_detach_cq(struct gdma_context *gc, struct gdma_queue *queue);
+
 struct gdma_wqe {
 	u32 reserved	:24;
 	u32 last_vbytes	:8;
@@ -760,6 +773,9 @@ enum {
 /* Driver supports non-contiguous queue buffers */
 #define GDMA_DRV_CAP_FLAG_1_NON_CONTIGUOUS_BUFFERS BIT(30)
 
+/* Driver supports handling throttled EQEs */
+#define GDMA_DRV_CAP_FLAG_1_THROTTLED_EVENT_QUEUE BIT_ULL(32)
+
 /* Capabilities in the PCI-only group below rely on dynamic MSI-X allocation
  * and on the servicing and reset paths reached through
  * mana_schedule_serv_work(). Transports that provide neither leave
@@ -784,7 +800,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION | \
-	 GDMA_DRV_CAP_FLAG_1_NON_CONTIGUOUS_BUFFERS)
+	 GDMA_DRV_CAP_FLAG_1_NON_CONTIGUOUS_BUFFERS | \
+	 GDMA_DRV_CAP_FLAG_1_THROTTLED_EVENT_QUEUE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 71d726b1f7840..09725e3256fa6 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -90,6 +90,7 @@ enum mana_priv_flag_bits {
 /* Update this count whenever the respective structures are changed */
 #define MANA_STATS_RX_COUNT (6 + MANA_CQE_COAL_PKTS_8 - 1)
 #define MANA_STATS_TX_COUNT 11
+#define MANA_STATS_EQ_COUNT 1
 
 #define MANA_RX_FRAG_ALIGNMENT 64
 
-- 
2.53.0




