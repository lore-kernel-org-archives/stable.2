Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B70388E57
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097051; cv=none; b=PB1xKZw3Y1tV0lzdeoGcS4dqpHeCoIVHjLomApq3OIGwsOkUwqUqlSQAZivkc4vE9RPw8ShFR+ygsw2xsry8mpMEy/rQHiUujzUzc5RNzcci+5SUfo4RbCnbTFzh6YrQKV5QWSLCOQ/+tO32MsLzWImqkmbuFg3SrHf+w35uVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097051; c=relaxed/simple;
	bh=RoBn3uIrWa/iImFf3WbZRsJIpHQAmPsylKxgKn0E3xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieyfQgA9RvAyhp2Z/73/gbePEIpcGpP5BpMm0sZvNSWlXGexmBiq97SoenBG1cpzI5J7qwFB03xmOqHsnLtntYh4gFY8cMun8dZhGofH7iRKvtpXnIoR2ixKK77Mvf9QtiPw1zkjF5pJQLdn5ChZ2FY+LiKPTA7sMaRFNhctCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvDXp4zW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvDXp4zW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D771F00893;
	Fri, 29 May 2026 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097048;
	bh=9/q4CUVwBHx1kKJd2cQvlGk9fld5lxGoH2HBpxUhetg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvDXp4zWrG+2kMgqsRD0HtPLVtbX3Ha8x/oCTfkpQZIJ0/Tokjpwd/qyk9Mmj2gYK
	 sT57JZDlJW2FmWrFHKhjc4IN1hbXft7S9KYy6dzO+iGbEfYJeTllAkC43B+TS8m70R
	 iX7Ja6vIADyICEf6Xcc2JRBQelZQMjrVTieGPTN0jddIVZOLMkfdUWyR0s3CD32de5
	 m1zDsuxCEm+2rq3UGc4uhNwbYGozmoXYlKsN7jH3gNp0ntat8lN26Rwf6JzxyNBLaU
	 dPFrXg3mxO52EsXofDfw0+H7JQm62DZowKBKog8QWwwI0eflnadODAfo9Bhy7UI/+k
	 e86So3+uHBOXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Steffen Lindner <steffen.lindner@de.abb.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hsr: Implement more robust duplicate discard for PRP
Date: Fri, 29 May 2026 19:24:05 -0400
Message-ID: <20260529232406.1883397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052838-cleat-rewrite-24c4@gregkh>
References: <2026052838-cleat-rewrite-24c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Maurer <fmaurer@redhat.com>

[ Upstream commit 415e6367512bf8faca93eaaf46fbe23d841b4509 ]

The PRP duplicate discard algorithm does not work reliably with certain
link faults. Especially with packet loss on one link, the duplicate discard
algorithm drops valid packets which leads to packet loss on the PRP
interface where the link fault should in theory be perfectly recoverable by
PRP. This happens because the algorithm opens the drop window on the lossy
link, covering received and lost sequence numbers. If the other, non-lossy
link receives the duplicate for a lost frame, it is within the drop window
of the lossy link and therefore dropped.

Since IEC 62439-3:2012, a node has one sequence number counter for frames
it sends, instead of one sequence number counter for each destination.
Therefore, a node can not expect to receive contiguous sequence numbers
from a sender. A missing sequence number can be totally normal (if the
sender intermittently communicates with another node) or mean a frame was
lost.

The algorithm, as previously implemented in commit 05fd00e5e7b1 ("net: hsr:
Fix PRP duplicate detection"), was part of IEC 62439-3:2010 (HSRv0/PRPv0)
but was removed with IEC 62439-3:2012 (HSRv1/PRPv1). Since that, no
algorithm is specified but up to implementers. It should be "designed such
that it never rejects a legitimate frame, while occasional acceptance of a
duplicate can be tolerated" (IEC 62439-3:2021).

For the duplicate discard algorithm, this means that 1) we need to track
the sequence numbers individually to account for non-contiguous sequence
numbers, and 2) we should always err on the side of accepting a duplicate
than dropping a valid frame.

The idea of the new algorithm is to store the seen sequence numbers in a
bitmap. To keep the size of the bitmap in control, we store it as a "sparse
bitmap" where the bitmap is split into blocks and not all blocks exist at
the same time. The sparse bitmap is implemented using an xarray that keeps
the references to the individual blocks and a backing ring buffer that
stores the actual blocks. New blocks are initialized in the buffer and
added to the xarray as needed when new frames arrive. Existing blocks are
removed in two conditions:
1. The block found for an arriving sequence number is old and therefore not
   relevant to the duplicate discard algorithm anymore, i.e., it has been
   added more than the entry forget time ago. In this case, the block is
   removed from the xarray and marked as forgotten (by setting its
   timestamp to 0).
2. Space is needed in the ring buffer for a new block. In this case, the
   block is removed from the xarray, if it hasn't already been forgotten
   (by 1.). Afterwards, the new block is initialized in its place.

This has the nice property that we can reliably track sequence numbers on
low traffic situations (where they expire based on their timestamp) and
more quickly forget sequence numbers in high traffic situations before they
potentially wrap over and repeat before they are expired.

When nodes are merged, the blocks are merged as well. The timestamp of a
merged block is set to the minimum of the two timestamps to never keep
around a seen sequence number for too long. The bitmaps are or'd to mark
all seen sequence numbers as seen.

All of this still happens under seq_out_lock, to prevent concurrent
access to the blocks.

The KUnit test for the algorithm is updated as well. The updates are done
in a way to match the original intends pretty closely. Currently, there is
much knowledge about the actual algorithm baked into the tests (especially
the expectations) which may need some redesign in the future.

Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Steffen Lindner <steffen.lindner@de.abb.com>
Link: https://patch.msgid.link/8ce15a996099df2df5b700969a39e7df400e8dbb.1770299429.git.fmaurer@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: aaec7096f996 ("net: hsr: defer node table free until after RCU readers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_framereg.c         | 212 +++++++++++++++++++++------------
 net/hsr/hsr_framereg.h         |  25 +++-
 net/hsr/prp_dup_discard_test.c | 138 +++++++++++----------
 3 files changed, 237 insertions(+), 138 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 3a2a2fa7a0a39..7e21e607efc6d 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -11,6 +11,7 @@
  * Same code handles filtering of duplicates for PRP as well.
  */
 
+#include <kunit/visibility.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 #include <linux/slab.h>
@@ -35,7 +36,6 @@ static bool seq_nr_after(u16 a, u16 b)
 
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
-#define PRP_DROP_WINDOW_LEN 32768
 
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
 {
@@ -126,13 +126,29 @@ void hsr_del_self_node(struct hsr_priv *hsr)
 		kfree_rcu(old, rcu_head);
 }
 
+static void hsr_free_node(struct hsr_node *node)
+{
+	xa_destroy(&node->seq_blocks);
+	kfree(node->block_buf);
+	kfree(node);
+}
+
+static void hsr_free_node_rcu(struct rcu_head *rn)
+{
+	struct hsr_node *node = container_of(rn, struct hsr_node, rcu_head);
+
+	hsr_free_node(node);
+}
+
 void hsr_del_nodes(struct list_head *node_db)
 {
 	struct hsr_node *node;
 	struct hsr_node *tmp;
 
-	list_for_each_entry_safe(node, tmp, node_db, mac_list)
-		kfree(node);
+	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
+		list_del(&node->mac_list);
+		hsr_free_node(node);
+	}
 }
 
 void prp_handle_san_frame(bool san, enum hsr_port_type port,
@@ -158,7 +174,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 				     u16 seq_out, bool san,
 				     enum hsr_port_type rx_port)
 {
-	struct hsr_node *new_node, *node;
+	struct hsr_node *new_node, *node = NULL;
 	unsigned long now;
 	int i;
 
@@ -169,6 +185,14 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	ether_addr_copy(new_node->macaddress_A, addr);
 	spin_lock_init(&new_node->seq_out_lock);
 
+	new_node->block_buf = kcalloc(HSR_MAX_SEQ_BLOCKS,
+				      sizeof(struct hsr_seq_block),
+				      GFP_ATOMIC);
+	if (!new_node->block_buf)
+		goto free;
+
+	xa_init(&new_node->seq_blocks);
+
 	/* We are only interested in time diffs here, so use current jiffies
 	 * as initialization. (0 could trigger an spurious ring error warning).
 	 */
@@ -176,11 +200,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	for (i = 0; i < HSR_PT_PORTS; i++) {
 		new_node->time_in[i] = now;
 		new_node->time_out[i] = now;
-	}
-	for (i = 0; i < HSR_PT_PORTS; i++) {
 		new_node->seq_out[i] = seq_out;
-		new_node->seq_expected[i] = seq_out + 1;
-		new_node->seq_start[i] = seq_out + 1;
 	}
 
 	if (san && hsr->proto_ops->handle_san_frame)
@@ -199,6 +219,8 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	return new_node;
 out:
 	spin_unlock_bh(&hsr->list_lock);
+	kfree(new_node->block_buf);
+free:
 	kfree(new_node);
 	return node;
 }
@@ -280,6 +302,62 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 			    san, rx_port);
 }
 
+static bool hsr_seq_block_is_old(struct hsr_seq_block *block)
+{
+	unsigned long expiry = msecs_to_jiffies(HSR_ENTRY_FORGET_TIME);
+
+	return time_is_before_jiffies(block->time + expiry);
+}
+
+static void hsr_forget_seq_block(struct hsr_node *node,
+				 struct hsr_seq_block *block)
+{
+	if (block->time)
+		xa_erase(&node->seq_blocks, block->block_idx);
+	block->time = 0;
+}
+
+/* Get the currently active sequence number block. If there is no block yet, or
+ * the existing one is expired, a new block is created. The idea is to maintain
+ * a "sparse bitmap" where a bitmap for the whole sequence number space is
+ * split into blocks and not all blocks exist all the time. The blocks can
+ * expire after time (in low traffic situations) or when they are replaced in
+ * the backing fixed size buffer (in high traffic situations).
+ */
+VISIBLE_IF_KUNIT struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
+							 u16 block_idx)
+{
+	struct hsr_seq_block *block, *res;
+
+	block = xa_load(&node->seq_blocks, block_idx);
+
+	if (block && hsr_seq_block_is_old(block)) {
+		hsr_forget_seq_block(node, block);
+		block = NULL;
+	}
+
+	if (!block) {
+		block = &node->block_buf[node->next_block];
+		hsr_forget_seq_block(node, block);
+
+		memset(block, 0, sizeof(*block));
+		block->time = jiffies;
+		block->block_idx = block_idx;
+
+		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
+		if (xa_is_err(res)) {
+			block->time = 0;
+			return NULL;
+		}
+
+		node->next_block =
+			(node->next_block + 1) & (HSR_MAX_SEQ_BLOCKS - 1);
+	}
+
+	return block;
+}
+EXPORT_SYMBOL_IF_KUNIT(hsr_get_seq_block);
+
 /* Use the Supervision frame's info about an eventual macaddress_B for merging
  * nodes that has previously had their macaddress_B registered as a separate
  * node.
@@ -288,16 +366,18 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 {
 	struct hsr_node *node_curr = frame->node_src;
 	struct hsr_port *port_rcv = frame->port_rcv;
+	struct hsr_seq_block *src_blk, *merge_blk;
 	struct hsr_priv *hsr = port_rcv->hsr;
-	struct hsr_sup_payload *hsr_sp;
 	struct hsr_sup_tlv *hsr_sup_tlv;
+	struct hsr_sup_payload *hsr_sp;
 	struct hsr_node *node_real;
 	struct sk_buff *skb = NULL;
 	struct list_head *node_db;
 	struct ethhdr *ethhdr;
-	int i;
-	unsigned int pull_size = 0;
 	unsigned int total_pull_size = 0;
+	unsigned int pull_size = 0;
+	unsigned long idx;
+	int i;
 
 	/* Here either frame->skb_hsr or frame->skb_prp should be
 	 * valid as supervision frame always will have protocol
@@ -391,6 +471,18 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 		if (seq_nr_after(node_curr->seq_out[i], node_real->seq_out[i]))
 			node_real->seq_out[i] = node_curr->seq_out[i];
 	}
+
+	xa_for_each(&node_curr->seq_blocks, idx, src_blk) {
+		if (hsr_seq_block_is_old(src_blk))
+			continue;
+
+		merge_blk = hsr_get_seq_block(node_real, src_blk->block_idx);
+		if (!merge_blk)
+			continue;
+		merge_blk->time = min(merge_blk->time, src_blk->time);
+		bitmap_or(merge_blk->seq_nrs, merge_blk->seq_nrs,
+			  src_blk->seq_nrs, HSR_SEQ_BLOCK_SIZE);
+	}
 	spin_unlock_bh(&node_real->seq_out_lock);
 	node_real->addr_B_port = port_rcv->type;
 
@@ -398,7 +490,7 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 	if (!node_curr->removed) {
 		list_del_rcu(&node_curr->mac_list);
 		node_curr->removed = true;
-		kfree_rcu(node_curr, rcu_head);
+		call_rcu(&node_curr->rcu_head, hsr_free_node_rcu);
 	}
 	spin_unlock_bh(&hsr->list_lock);
 
@@ -505,17 +597,12 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	return 0;
 }
 
-/* Adaptation of the PRP duplicate discard algorithm described in wireshark
- * wiki (https://wiki.wireshark.org/PRP)
- *
- * A drop window is maintained for both LANs with start sequence set to the
- * first sequence accepted on the LAN that has not been seen on the other LAN,
- * and expected sequence set to the latest received sequence number plus one.
- *
- * When a frame is received on either LAN it is compared against the received
- * frames on the other LAN. If it is outside the drop window of the other LAN
- * the frame is accepted and the drop window is updated.
- * The drop window for the other LAN is reset.
+/* PRP duplicate discard algorithm: we maintain a bitmap where we set a bit for
+ * every seen sequence number. The bitmap is split into blocks and the block
+ * management is detailed in hsr_get_seq_block(). In any case, we err on the
+ * side of accepting a packet, as the specification requires the algorithm to
+ * be "designed such that it never rejects a legitimate frame, while occasional
+ * acceptance of a duplicate can be tolerated." (IEC 62439-3:2021, 4.1.10.3).
  *
  * 'port' is the outgoing interface
  * 'frame' is the frame to be sent
@@ -526,18 +613,21 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
  */
 int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 {
-	enum hsr_port_type other_port;
-	enum hsr_port_type rcv_port;
+	u16 sequence_nr, seq_bit, block_idx;
+	struct hsr_seq_block *block;
 	struct hsr_node *node;
-	u16 sequence_diff;
-	u16 sequence_exp;
-	u16 sequence_nr;
 
-	/* out-going frames are always in order
-	 * and can be checked the same way as for HSR
-	 */
-	if (frame->port_rcv->type == HSR_PT_MASTER)
-		return hsr_register_frame_out(port, frame);
+	node = frame->node_src;
+	sequence_nr = frame->sequence_nr;
+
+	/* out-going frames are always in order */
+	if (frame->port_rcv->type == HSR_PT_MASTER) {
+		spin_lock_bh(&node->seq_out_lock);
+		node->time_out[port->type] = jiffies;
+		node->seq_out[port->type] = sequence_nr;
+		spin_unlock_bh(&node->seq_out_lock);
+		return 0;
+	}
 
 	/* for PRP we should only forward frames from the slave ports
 	 * to the master port
@@ -545,52 +635,28 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	if (port->type != HSR_PT_MASTER)
 		return 1;
 
-	node = frame->node_src;
-	sequence_nr = frame->sequence_nr;
-	sequence_exp = sequence_nr + 1;
-	rcv_port = frame->port_rcv->type;
-	other_port = rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B :
-				 HSR_PT_SLAVE_A;
-
 	spin_lock_bh(&node->seq_out_lock);
-	if (time_is_before_jiffies(node->time_out[port->type] +
-	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME)) ||
-	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
-	     node->seq_start[other_port] == node->seq_expected[other_port])) {
-		/* the node hasn't been sending for a while
-		 * or both drop windows are empty, forward the frame
-		 */
-		node->seq_start[rcv_port] = sequence_nr;
-	} else if (seq_nr_before(sequence_nr, node->seq_expected[other_port]) &&
-		   seq_nr_before_or_eq(node->seq_start[other_port], sequence_nr)) {
-		/* drop the frame, update the drop window for the other port
-		 * and reset our drop window
-		 */
-		node->seq_start[other_port] = sequence_exp;
-		node->seq_expected[rcv_port] = sequence_exp;
-		node->seq_start[rcv_port] = node->seq_expected[rcv_port];
-		spin_unlock_bh(&node->seq_out_lock);
-		return 1;
-	}
 
-	/* update the drop window for the port where this frame was received
-	 * and clear the drop window for the other port
-	 */
-	node->seq_start[other_port] = node->seq_expected[other_port];
-	node->seq_expected[rcv_port] = sequence_exp;
-	sequence_diff = sequence_exp - node->seq_start[rcv_port];
-	if (sequence_diff > PRP_DROP_WINDOW_LEN)
-		node->seq_start[rcv_port] = sequence_exp - PRP_DROP_WINDOW_LEN;
+	block_idx = hsr_seq_block_index(sequence_nr);
+	block = hsr_get_seq_block(node, block_idx);
+	if (!block)
+		goto out_new;
+
+	seq_bit = hsr_seq_block_bit(sequence_nr);
+	if (__test_and_set_bit(seq_bit, block->seq_nrs))
+		goto out_seen;
 
 	node->time_out[port->type] = jiffies;
 	node->seq_out[port->type] = sequence_nr;
+out_new:
 	spin_unlock_bh(&node->seq_out_lock);
 	return 0;
-}
 
-#if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST)
-EXPORT_SYMBOL(prp_register_frame_out);
-#endif
+out_seen:
+	spin_unlock_bh(&node->seq_out_lock);
+	return 1;
+}
+EXPORT_SYMBOL_IF_KUNIT(prp_register_frame_out);
 
 static struct hsr_port *get_late_port(struct hsr_priv *hsr,
 				      struct hsr_node *node)
@@ -672,7 +738,7 @@ void hsr_prune_nodes(struct timer_list *t)
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
 				/* Note that we need to free this entry later: */
-				kfree_rcu(node, rcu_head);
+				call_rcu(&node->rcu_head, hsr_free_node_rcu);
 			}
 		}
 	}
@@ -706,7 +772,7 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
 				list_del_rcu(&node->mac_list);
 				node->removed = true;
 				/* Note that we need to free this entry later: */
-				kfree_rcu(node, rcu_head);
+				call_rcu(&node->rcu_head, hsr_free_node_rcu);
 			}
 		}
 	}
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index b04948659d84d..686f2a5954007 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -74,9 +74,27 @@ bool hsr_is_node_in_db(struct list_head *node_db,
 
 int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node, u16 block_idx);
+#endif
+
+#define HSR_SEQ_BLOCK_SHIFT 7 /* 128 bits */
+#define HSR_SEQ_BLOCK_SIZE (1 << HSR_SEQ_BLOCK_SHIFT)
+#define HSR_SEQ_BLOCK_MASK (HSR_SEQ_BLOCK_SIZE - 1)
+#define HSR_MAX_SEQ_BLOCKS 64
+
+#define hsr_seq_block_index(sequence_nr) ((sequence_nr) >> HSR_SEQ_BLOCK_SHIFT)
+#define hsr_seq_block_bit(sequence_nr) ((sequence_nr) & HSR_SEQ_BLOCK_MASK)
+
+struct hsr_seq_block {
+	unsigned long		time;
+	u16			block_idx;
+	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
+};
+
 struct hsr_node {
 	struct list_head	mac_list;
-	/* Protect R/W access to seq_out */
+	/* Protect R/W access to seq_out and seq_blocks */
 	spinlock_t		seq_out_lock;
 	unsigned char		macaddress_A[ETH_ALEN];
 	unsigned char		macaddress_B[ETH_ALEN];
@@ -91,8 +109,9 @@ struct hsr_node {
 	u16			seq_out[HSR_PT_PORTS];
 	bool			removed;
 	/* PRP specific duplicate handling */
-	u16			seq_expected[HSR_PT_PORTS];
-	u16			seq_start[HSR_PT_PORTS];
+	struct xarray		seq_blocks;
+	struct hsr_seq_block	*block_buf;
+	unsigned int		next_block;
 	struct rcu_head		rcu_head;
 };
 
diff --git a/net/hsr/prp_dup_discard_test.c b/net/hsr/prp_dup_discard_test.c
index e86b7b633ae89..bfa3d318ec046 100644
--- a/net/hsr/prp_dup_discard_test.c
+++ b/net/hsr/prp_dup_discard_test.c
@@ -4,6 +4,8 @@
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
 struct prp_test_data {
 	struct hsr_port port;
 	struct hsr_port port_rcv;
@@ -17,13 +19,17 @@ static struct prp_test_data *build_prp_test_data(struct kunit *test)
 		sizeof(struct prp_test_data), GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data);
 
+	data->node.block_buf = kunit_kcalloc(test, HSR_MAX_SEQ_BLOCKS,
+					     sizeof(struct hsr_seq_block),
+					     GFP_ATOMIC);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data->node.block_buf);
+
+	xa_init(&data->node.seq_blocks);
+	spin_lock_init(&data->node.seq_out_lock);
+
 	data->frame.node_src = &data->node;
 	data->frame.port_rcv = &data->port_rcv;
 	data->port_rcv.type = HSR_PT_SLAVE_A;
-	data->node.seq_start[HSR_PT_SLAVE_A] = 1;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 1;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 1;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 1;
 	data->node.seq_out[HSR_PT_MASTER] = 0;
 	data->node.time_out[HSR_PT_MASTER] = jiffies;
 	data->port.type = HSR_PT_MASTER;
@@ -31,19 +37,32 @@ static struct prp_test_data *build_prp_test_data(struct kunit *test)
 	return data;
 }
 
-static void check_prp_counters(struct kunit *test,
-			       struct prp_test_data *data,
-			       u16 seq_start_a, u16 seq_expected_a,
-			       u16 seq_start_b, u16 seq_expected_b)
+static void check_prp_frame_seen(struct kunit *test, struct prp_test_data *data,
+				 u16 sequence_nr)
+{
+	u16 block_idx, seq_bit;
+	struct hsr_seq_block *block;
+
+	block_idx = sequence_nr >> HSR_SEQ_BLOCK_SHIFT;
+	block = xa_load(&data->node.seq_blocks, block_idx);
+	KUNIT_EXPECT_NOT_NULL(test, block);
+
+	seq_bit = sequence_nr & HSR_SEQ_BLOCK_MASK;
+	KUNIT_EXPECT_TRUE(test, test_bit(seq_bit, block->seq_nrs));
+}
+
+static void check_prp_frame_unseen(struct kunit *test,
+				   struct prp_test_data *data, u16 sequence_nr)
 {
-	KUNIT_EXPECT_EQ(test, data->node.seq_start[HSR_PT_SLAVE_A],
-			seq_start_a);
-	KUNIT_EXPECT_EQ(test, data->node.seq_start[HSR_PT_SLAVE_B],
-			seq_start_b);
-	KUNIT_EXPECT_EQ(test, data->node.seq_expected[HSR_PT_SLAVE_A],
-			seq_expected_a);
-	KUNIT_EXPECT_EQ(test, data->node.seq_expected[HSR_PT_SLAVE_B],
-			seq_expected_b);
+	u16 block_idx, seq_bit;
+	struct hsr_seq_block *block;
+
+	block_idx = sequence_nr >> HSR_SEQ_BLOCK_SHIFT;
+	block = hsr_get_seq_block(&data->node, block_idx);
+	KUNIT_EXPECT_NOT_NULL(test, block);
+
+	seq_bit = sequence_nr & HSR_SEQ_BLOCK_MASK;
+	KUNIT_EXPECT_FALSE(test, test_bit(seq_bit, block->seq_nrs));
 }
 
 static void prp_dup_discard_forward(struct kunit *test)
@@ -57,49 +76,58 @@ static void prp_dup_discard_forward(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
 			data->node.seq_out[HSR_PT_MASTER]);
 	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 1, 1);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 }
 
-static void prp_dup_discard_inside_dropwindow(struct kunit *test)
+static void prp_dup_discard_drop_duplicate(struct kunit *test)
 {
-	/* Normal situation, other LAN ahead by one. Frame is dropped */
 	struct prp_test_data *data = build_prp_test_data(test);
 	unsigned long time = jiffies - 10;
 
-	data->frame.sequence_nr = 1;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 3;
-	data->node.seq_out[HSR_PT_MASTER] = 2;
+	data->frame.sequence_nr = 2;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 	data->node.time_out[HSR_PT_MASTER] = time;
 
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, 2, data->node.seq_out[HSR_PT_MASTER]);
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
 	KUNIT_EXPECT_EQ(test, time, data->node.time_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, 2, 2, 2, 3);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 }
 
-static void prp_dup_discard_node_timeout(struct kunit *test)
+static void prp_dup_discard_entry_timeout(struct kunit *test)
 {
 	/* Timeout situation, node hasn't sent anything for a while */
 	struct prp_test_data *data = build_prp_test_data(test);
+	struct hsr_seq_block *block;
+	u16 block_idx;
 
 	data->frame.sequence_nr = 7;
-	data->node.seq_start[HSR_PT_SLAVE_A] = 1234;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 1235;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 1234;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 1234;
-	data->node.seq_out[HSR_PT_MASTER] = 1234;
-	data->node.time_out[HSR_PT_MASTER] =
-		jiffies - msecs_to_jiffies(HSR_ENTRY_FORGET_TIME) - 1;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
+
+	data->frame.sequence_nr = 11;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
+
+	block_idx = data->frame.sequence_nr >> HSR_SEQ_BLOCK_SHIFT;
+	block = hsr_get_seq_block(&data->node, block_idx);
+	block->time = jiffies - msecs_to_jiffies(HSR_ENTRY_FORGET_TIME) - 1;
 
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
 	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
 			data->node.seq_out[HSR_PT_MASTER]);
 	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 1234, 1234);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
+	check_prp_frame_unseen(test, data, 7);
 }
 
 static void prp_dup_discard_out_of_sequence(struct kunit *test)
@@ -107,11 +135,13 @@ static void prp_dup_discard_out_of_sequence(struct kunit *test)
 	/* One frame is received out of sequence on both LANs */
 	struct prp_test_data *data = build_prp_test_data(test);
 
-	data->node.seq_start[HSR_PT_SLAVE_A] = 10;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 10;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 10;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 10;
-	data->node.seq_out[HSR_PT_MASTER] = 9;
+	/* initial frame, should be accepted */
+	data->frame.sequence_nr = 9;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
+			data->node.seq_out[HSR_PT_MASTER]);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* 1st old frame, should be accepted */
 	data->frame.sequence_nr = 8;
@@ -119,18 +149,13 @@ static void prp_dup_discard_out_of_sequence(struct kunit *test)
 			prp_register_frame_out(&data->port, &data->frame));
 	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
 			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 10, 10);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* 2nd frame should be dropped */
 	data->frame.sequence_nr = 8;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data, data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1);
 
 	/* Next frame, this is forwarded */
 	data->frame.sequence_nr = 10;
@@ -139,18 +164,13 @@ static void prp_dup_discard_out_of_sequence(struct kunit *test)
 			prp_register_frame_out(&data->port, &data->frame));
 	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
 			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 9, 9);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* and next one is dropped */
 	data->frame.sequence_nr = 10;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data, data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1);
 }
 
 static void prp_dup_discard_lan_b_late(struct kunit *test)
@@ -158,10 +178,6 @@ static void prp_dup_discard_lan_b_late(struct kunit *test)
 	/* LAN B is behind */
 	struct prp_test_data *data = build_prp_test_data(test);
 
-	data->node.seq_start[HSR_PT_SLAVE_A] = 9;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 9;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 9;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 9;
 	data->node.seq_out[HSR_PT_MASTER] = 8;
 
 	data->frame.sequence_nr = 9;
@@ -169,32 +185,30 @@ static void prp_dup_discard_lan_b_late(struct kunit *test)
 			prp_register_frame_out(&data->port, &data->frame));
 	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
 			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, 9, 10, 9, 9);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	data->frame.sequence_nr = 10;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
 	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
 			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, 9, 11, 9, 9);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	data->frame.sequence_nr = 9;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data, 10, 11, 10, 10);
 
 	data->frame.sequence_nr = 10;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data,  11, 11, 11, 11);
 }
 
 static struct kunit_case prp_dup_discard_test_cases[] = {
 	KUNIT_CASE(prp_dup_discard_forward),
-	KUNIT_CASE(prp_dup_discard_inside_dropwindow),
-	KUNIT_CASE(prp_dup_discard_node_timeout),
+	KUNIT_CASE(prp_dup_discard_drop_duplicate),
+	KUNIT_CASE(prp_dup_discard_entry_timeout),
 	KUNIT_CASE(prp_dup_discard_out_of_sequence),
 	KUNIT_CASE(prp_dup_discard_lan_b_late),
 	{}
-- 
2.53.0

