Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5C3A3E67
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024211; cv=none; b=g0Hxq2ihPkAnox7VFCLot6F1L3FxIjC31bf4GCe7ht0KFACjxfn91EjP7Wz+GKVhhrfWRcIZepulgNFfeCFF3Ix4DUwQnjIPGaTSTP0o+aidrH2FAdLJU69mCYcULFV/FNtXa39QH54BDNU5mnNr+DZXEfnEfzfrcWQvoHKjIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024211; c=relaxed/simple;
	bh=YlAUfZiR8RD1+x10bGwIFJxOcZv/k1AHvj013XplKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASCRtjLTTNn+XnJA62j1aQd+UUf0/t07Q8SJRIqt3vq7Oc8l61Xs+EOj8783FKP7JW767U5NGPOn6cuf98kxUT8/9fRFKq0v82d6yOD+1rsvRRCAT02EOrumZF5j5N+cZk4lX6o7KmHecolCPrOlhjRNogbdknEehZ5Pgxl7Z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obi29OPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obi29OPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374E91F00A3F;
	Thu,  6 Aug 2026 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024210;
	bh=O4vEaqiv7XWjzov3kN/+GCQtyq+iAGk6iufh1UICzqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=obi29OPboPCN6obbSY2z3D58Z7+renmcCW5Eyr02MgwkSOkDjbX1tk0MR2bW7U512
	 dYmYI04TciXd3BRLx01K7fGTPcbWMEMaxKTFQ9c/nfhIXP7njvf9t0CHWE5K4Tvd8N
	 U3n8CpylpGymY5AQlPYL8hOC7+HufpObnBwQXhCnmQ4RCDkQSIiTFNm281twbOTddM
	 v+ta//qh4rQEY0epKCnvnTfKeoTU3rIitpYuqiNG2ZGIhVHlmT0lAfwbxw1l4NPquK
	 +Gr7h7u5GNcPzkPdjB6w7sFK/5GmOIXYVojDBRfPIujcm4lUKfBwknWk/FxdxK3mPh
	 +a/CEMw5dPXgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	LePremierHomme <kwqcheii@proton.me>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] rxrpc: Fix irq-disabled in local_bh_enable()
Date: Thu,  6 Aug 2026 09:50:03 -0400
Message-ID: <20260806135003.602726-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806135003.602726-1-sashal@kernel.org>
References: <2026073013-sanding-unlined-9b91@gregkh>
 <20260806135003.602726-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit e4d2878369d590bf8455e3678a644e503172eafa ]

The rxrpc_assess_MTU_size() function calls down into the IP layer to find
out the MTU size for a route.  When accepting an incoming call, this is
called from rxrpc_new_incoming_call() which holds interrupts disabled
across the code that calls down to it.  Unfortunately, the IP layer uses
local_bh_enable() which, config dependent, throws a warning if IRQs are
enabled:

WARNING: CPU: 1 PID: 5544 at kernel/softirq.c:387 __local_bh_enable_ip+0x43/0xd0
...
RIP: 0010:__local_bh_enable_ip+0x43/0xd0
...
Call Trace:
 <TASK>
 rt_cache_route+0x7e/0xa0
 rt_set_nexthop.isra.0+0x3b3/0x3f0
 __mkroute_output+0x43a/0x460
 ip_route_output_key_hash+0xf7/0x140
 ip_route_output_flow+0x1b/0x90
 rxrpc_assess_MTU_size.isra.0+0x2a0/0x590
 rxrpc_new_incoming_peer+0x46/0x120
 rxrpc_alloc_incoming_call+0x1b1/0x400
 rxrpc_new_incoming_call+0x1da/0x5e0
 rxrpc_input_packet+0x827/0x900
 rxrpc_io_thread+0x403/0xb60
 kthread+0x2f7/0x310
 ret_from_fork+0x2a/0x230
 ret_from_fork_asm+0x1a/0x30
...
hardirqs last  enabled at (23): _raw_spin_unlock_irq+0x24/0x50
hardirqs last disabled at (24): _raw_read_lock_irq+0x17/0x70
softirqs last  enabled at (0): copy_process+0xc61/0x2730
softirqs last disabled at (25): rt_add_uncached_list+0x3c/0x90

Fix this by moving the call to rxrpc_assess_MTU_size() out of
rxrpc_init_peer() and further up the stack where it can be done without
interrupts disabled.

It shouldn't be a problem for rxrpc_new_incoming_call() to do it after the
locks are dropped as pmtud is going to be performed by the I/O thread - and
we're in the I/O thread at this point.

Fixes: a2ea9a907260 ("rxrpc: Use irq-disabling spinlocks between app and I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/20250717074350.3767366-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/call_accept.c |  1 +
 net/rxrpc/peer_object.c | 12 +++++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index a3afe7413e771..48202528a2438 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1183,6 +1183,7 @@ struct rxrpc_peer *rxrpc_lookup_peer_rcu(struct rxrpc_local *,
 					 const struct sockaddr_rxrpc *);
 struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 				     struct sockaddr_rxrpc *srx, gfp_t gfp);
+void rxrpc_assess_MTU_size(struct rxrpc_local *local, struct rxrpc_peer *peer);
 struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *, gfp_t,
 				    enum rxrpc_peer_trace);
 void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer);
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 15e63b1ae7134..82766feb34e51 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -407,6 +407,7 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 
 	spin_unlock(&rx->incoming_lock);
 	read_unlock_irq(&local->services_lock);
+	rxrpc_assess_MTU_size(local, call->peer);
 
 	if (hlist_unhashed(&call->error_link)) {
 		spin_lock_irq(&call->peer->lock);
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 45d5f25db40b2..3af39fc67d34b 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -149,8 +149,7 @@ struct rxrpc_peer *rxrpc_lookup_peer_rcu(struct rxrpc_local *local,
  * assess the MTU size for the network interface through which this peer is
  * reached
  */
-static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
-				  struct rxrpc_peer *peer)
+void rxrpc_assess_MTU_size(struct rxrpc_local *local, struct rxrpc_peer *peer)
 {
 	struct net *net = local->net;
 	struct dst_entry *dst;
@@ -162,6 +161,8 @@ static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
 #endif
 
 	peer->if_mtu = 1500;
+	peer->mtu = peer->if_mtu;
+	peer->maxdata = peer->mtu - peer->hdrsize;
 
 	memset(&fl, 0, sizeof(fl));
 	switch (peer->srx.transport.family) {
@@ -201,6 +202,9 @@ static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
 	peer->if_mtu = dst_mtu(dst);
 	dst_release(dst);
 
+	peer->mtu = peer->if_mtu;
+	peer->maxdata = peer->mtu - peer->hdrsize;
+
 	_leave(" [if_mtu %u]", peer->if_mtu);
 }
 
@@ -239,8 +243,6 @@ static void rxrpc_init_peer(struct rxrpc_local *local, struct rxrpc_peer *peer,
 			    unsigned long hash_key)
 {
 	peer->hash_key = hash_key;
-	rxrpc_assess_MTU_size(local, peer);
-	peer->mtu = peer->if_mtu;
 
 	switch (peer->srx.transport.family) {
 	case AF_INET:
@@ -264,7 +266,6 @@ static void rxrpc_init_peer(struct rxrpc_local *local, struct rxrpc_peer *peer,
 	}
 
 	peer->hdrsize += sizeof(struct rxrpc_wire_header);
-	peer->maxdata = peer->mtu - peer->hdrsize;
 }
 
 /*
@@ -283,6 +284,7 @@ static struct rxrpc_peer *rxrpc_create_peer(struct rxrpc_local *local,
 	if (peer) {
 		memcpy(&peer->srx, srx, sizeof(*srx));
 		rxrpc_init_peer(local, peer, hash_key);
+		rxrpc_assess_MTU_size(local, peer);
 	}
 
 	_leave(" = %p", peer);
-- 
2.53.0

