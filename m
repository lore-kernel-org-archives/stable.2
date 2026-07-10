Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C7233932;
	Fri, 10 Jul 2026 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695834; cv=pass; b=bC43N1NxFntyAFPPGy4zCUwvoXvUB7UvFxMpTxiAFWcJNmewmMepQui8o7svrX4Ib46bGIAQzAEwhyWx8KDO0kurFQqpODZMj8F9mkJ2LOYiI7qVKk8rxPTEdZbcsmNrQ4rpOyain2lkNBOwY/K7psBhX7cMECT7u9bLE9fAdYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695834; c=relaxed/simple;
	bh=MMK84kRvLrazcgsIgR+si9AXEDsUxzxZERut+ac1mXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJRUCw2I75F1bn0rRHKqzb3Vp6fBANYtVQS4VOYkwdpflgRHiDFz78xVUENaRHItTDHKFMzMBxGHsfWwuwSX0lnHoFx1wduUhURONkAUoix8FAXbq7mVGh22NvWZuGTKsllY6rB6S3vrxoNgKeVB5CGTC/0CtC1uLVfTv77DAk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=WNHKtSEo; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="WNHKtSEo"
ARC-Seal: i=1; a=rsa-sha256; t=1783695809; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Dy7xZwnyDoYsSiDZdzNaXL7NfHsoG7q9FhFdtd5PRjoN85gPhSdsw3PdIJuV6Fns0dDMBJRxOQFw/aw1X1g1733plLfPVQlr1IVxNM2xbfZqTxxytnw/v76PrQGBCWR2E5oL64qkzVieZLm6MtSVhnHGAXbKtB2hbzlhWeWOFE8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783695809; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6ZO0HfgIdC0aAjoLXaBVORj6OTHFPoVCAvzYux53aXw=; 
	b=cRrcp0z8zDXkwTo9XZTyFmzPq17XhxSTZzFcLdRC63G2ytMeHgslyWL/cGlzx92FLDCnQ5nwMgkKt/T9yaGAMXj+H5h+POOSTc55Ty4kHLkgaZabnwPJVbvjJ5EzLH7QN+K7cFcgH5wM9TfdA73Clb9q1P290Kx2UdC7DzcEnGc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783695809;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6ZO0HfgIdC0aAjoLXaBVORj6OTHFPoVCAvzYux53aXw=;
	b=WNHKtSEohs1MxmA98H03hTrETwwoccdENPi70I0rOJYktD2R5+YxANxTXCe2Fe9Z
	yuJ92AU5FTUR114RcYv/dwKhbkY/YE5moPM92wHDIdT0OyPXLdYZPj1jz5gMMkVfe3O
	wQoz5QWYhSyT5sN+9qi7Gh2+RV1KMb8Utga3xzYo=
Received: by mx.zoho.eu with SMTPS id 1783695807226107.99386696008173;
	Fri, 10 Jul 2026 17:03:27 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: cap number of nodes per net namespace
Date: Fri, 10 Jul 2026 17:03:24 +0200
Message-ID: <20260710150324.32134-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

tipc_node_create() allocates a new struct tipc_node (plus a broadcast
receive link, a unicast link slot and a keepalive timer) for every
previously unseen (addr, node_id) pair carried in an inbound TIPC
LINK_CONFIG discovery frame:

	n = tipc_node_find(net, addr) ?:
		tipc_node_find_by_id(net, peer_id);
	if (n) {
		...
	}
	n = kzalloc_obj(*n, GFP_ATOMIC);
	...
	n->delete_at = jiffies + msecs_to_jiffies(NODE_CLEANUP_AFTER);

Both addr (msg_prevnode) and peer_id (msg_node_id) come straight out
of the discovery frame and are fully attacker controlled, and the
dedup key above is keyed on exactly those two values. There is no cap
on how many distinct nodes a net namespace may hold and no rate limit
on the create path, so an unauthenticated peer on an enabled TIPC
bearer (L2 or UDP) can flood LINK_CONFIG frames with a fresh (addr,
node_id) in each one and force the kernel to keep minting new,
distinct struct tipc_node objects without bound. A link-less spoofed
node is only reclaimed after NODE_CLEANUP_AFTER (300 s), so at typical
discovery rates the live node table, and the memory pinned by it,
grows roughly linearly with attacker-supplied identities for the
duration of the flood. This is (uncontrolled resource
consumption), reachable by any unauthenticated network-adjacent host
once tipc.ko is loaded and a bearer is enabled.

Bound this the same way net/core/neighbour.c bounds the ARP/ND
neighbour table against unauthenticated on-link input: reject new
entries once a hard ceiling is hit instead of letting the table grow
without limit. struct tipc_net already carries a num_nodes counter
that is declared but never read or written anywhere in net/tipc/; wire
it up on the create and delete paths and add a single bounds check on
it in tipc_node_create(), guarded by the same tn->node_list_lock
spinlock that already serializes every call site of
tipc_node_create(), tipc_node_delete_from_list(), tipc_node_delete()
and tipc_node_stop(). No new locking, no new data structures, and no
change to the node table's data layout or lookup semantics; legitimate
peers are still admitted exactly as before, up to the cap.

TIPC_MAX_NODES is set to 8192, well above any realistic TIPC cluster
size, bounding worst-case pinned memory to a fixed multiple of one
node's footprint instead of unbounded growth. It is intentionally not
tuned tight; exposing it as a sysctl (mirroring
net.ipv4.neigh.default.gc_thresh3) would be a reasonable follow-up but
is left out to keep this fix minimal.

Verified on a v6.19 KASAN build: flooding spoofed (addr, node_id)
peers past the cap makes the patched kernel log "Too many TIPC
nodes (8192)" and drop further peers, where the same flood grew
the live node table without bound before this patch.

Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 net/tipc/node.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..bb41f3231ce1 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -49,6 +49,16 @@
 #define INVALID_NODE_SIG	0x10000
 #define NODE_CLEANUP_AFTER	300000
 
+/* Hard cap on the number of live struct tipc_node entries a single net
+ * namespace will hold. Every entry (preliminary or not) also pins a
+ * broadcast-receive link, a unicast link slot and a keepalive timer, so
+ * this bounds worst-case memory from unauthenticated LINK_CONFIG discovery
+ * traffic the same way neigh_alloc()'s gc_thresh3 bounds the ARP/ND table
+ * (see net/core/neighbour.c). 8192 is far above any realistic TIPC cluster
+ * size and is not meant to be tight -- it only stops unbounded growth.
+ */
+#define TIPC_MAX_NODES		8192
+
 /* Flags used to take different actions according to flag type
  * TIPC_NOTIFY_NODE_DOWN: notify node is down
  * TIPC_NOTIFY_NODE_UP: notify node is up
@@ -535,6 +545,11 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 
 		goto exit;
 	}
+	if (tn->num_nodes >= TIPC_MAX_NODES) {
+		pr_warn_ratelimited("Too many TIPC nodes (%u), dropping new peer %x\n",
+				    tn->num_nodes, addr);
+		goto exit;
+	}
 	n = kzalloc_obj(*n, GFP_ATOMIC);
 	if (!n) {
 		pr_warn("Node creation failed, no memory\n");
@@ -598,6 +613,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 			break;
 	}
 	list_add_tail_rcu(&n->list, &temp_node->list);
+	tn->num_nodes++;
 	/* Calculate cluster capabilities */
 	tn->capabilities = TIPC_NODE_CAPABILITIES;
 	list_for_each_entry_rcu(temp_node, &tn->node_list, list) {
@@ -630,6 +646,7 @@ static void tipc_node_delete_from_list(struct tipc_node *node)
 #endif
 	list_del_rcu(&node->list);
 	hlist_del_rcu(&node->hash);
+	tipc_net(node->net)->num_nodes--;
 	tipc_node_put(node);
 }
 
-- 
2.50.1 (Apple Git-155)

