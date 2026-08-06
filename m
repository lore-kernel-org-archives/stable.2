Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE51DC198
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020379; cv=none; b=tUwUEQTJ1X8uRMpcpL9O5Z7jA38DDiEuwM4dat9Kk402qf0sEukyHA6bXPybPwNvX0mKLPhRmMO7n2rcyGcP8GiNqgO5TO/31Ky8CDNMXgZbsjjx4L10RMDXBQts/LpbBFbZEsmP6rfSJ1fyUG/8TX1EzF17pQTdFNft2JIzuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020379; c=relaxed/simple;
	bh=SIxtB0yiL4lXvpUMZPIbrjRD4zAiRybsSg/xPGfsvBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exrivRSfp8OjMjQ5eseYYPBcIjL6JfWVzDfIRjVCom2nPRKri5RAJck4K+fJwbLwAIqg8firDK8cUU2H+Qy/mcO0zfdPLev4j1Tf8F1MG6zOVRWvo6A3Z1jHM1GoNTE4WfXguZLS+3H6OeYdvYu/cwzGc13tnuPLo84WPF2ldTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUYcPp3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUYcPp3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705031F000E9;
	Thu,  6 Aug 2026 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020376;
	bh=TPqIJ0O3WHrvL/CUmVsbxdi1I5J/dlgOjguQew7+wQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nUYcPp3ynzEWIBwP54t+ceJYE40SIhA0dpYdMA5VctQK3I1htUSLPZv3YUGKFCe6l
	 9GlkSm/nBuJmwfaL2jU5si/WNpYeQhl64oip+4XoJ9j1Ig1YREWVF3K4m1Z0PHbXat
	 EtXhp8+7y7ZKwJT1FKODCnTzZ69brsprYpdTaNwsYFHDD1d03mes9DT/Hj/5v+P+eX
	 +kPgAa1Ogfn7Ndn04ZVQDgyTJUzpp9iDNCcZV5rg1FJ+c2NLlpNB1UBQfJtT6+7z78
	 EWHNj22LHk30Q6e+5QshMXzNrVbqdRhkUWeaWkTtf5HIwIip37V8FaU6/FxqUZCxop
	 gVveieP7M0JWw==
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
Subject: [PATCH 6.6.y] rxrpc: Fix irq-disabled in local_bh_enable()
Date: Thu,  6 Aug 2026 08:46:13 -0400
Message-ID: <20260806124613.299390-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026073004-doodle-trickery-d104@gregkh>
References: <2026073004-doodle-trickery-d104@gregkh>
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
[ moved `peer->mtu`/`peer->maxdata` derivation into `rxrpc_assess_MTU_size()` at both exits since 6.12 predates the `max_data` rework ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/call_accept.c |  1 +
 net/rxrpc/peer_object.c | 12 +++++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5f5421680b2eb..494a87be3d854 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1188,6 +1188,7 @@ struct rxrpc_peer *rxrpc_lookup_peer_rcu(struct rxrpc_local *,
 					 const struct sockaddr_rxrpc *);
 struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 				     struct sockaddr_rxrpc *srx, gfp_t gfp);
+void rxrpc_assess_MTU_size(struct rxrpc_local *local, struct rxrpc_peer *peer);
 struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *, gfp_t,
 				    enum rxrpc_peer_trace);
 void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer);
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index cbf6187d68edf..66994e3698efb 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -407,6 +407,7 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 
 	spin_unlock(&rx->incoming_lock);
 	read_unlock_irq(&local->services_lock);
+	rxrpc_assess_MTU_size(local, call->peer);
 
 	if (hlist_unhashed(&call->error_link)) {
 		spin_lock_irq(&call->peer->lock);
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 3a4cf95ecddfc..7826081410290 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -147,8 +147,7 @@ struct rxrpc_peer *rxrpc_lookup_peer_rcu(struct rxrpc_local *local,
  * assess the MTU size for the network interface through which this peer is
  * reached
  */
-static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
-				  struct rxrpc_peer *peer)
+void rxrpc_assess_MTU_size(struct rxrpc_local *local, struct rxrpc_peer *peer)
 {
 	struct net *net = local->net;
 	struct dst_entry *dst;
@@ -160,6 +159,8 @@ static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
 #endif
 
 	peer->if_mtu = 1500;
+	peer->mtu = peer->if_mtu;
+	peer->maxdata = peer->mtu - peer->hdrsize;
 
 	memset(&fl, 0, sizeof(fl));
 	switch (peer->srx.transport.family) {
@@ -199,6 +200,9 @@ static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
 	peer->if_mtu = dst_mtu(dst);
 	dst_release(dst);
 
+	peer->mtu = peer->if_mtu;
+	peer->maxdata = peer->mtu - peer->hdrsize;
+
 	_leave(" [if_mtu %u]", peer->if_mtu);
 }
 
@@ -240,8 +244,6 @@ static void rxrpc_init_peer(struct rxrpc_local *local, struct rxrpc_peer *peer,
 			    unsigned long hash_key)
 {
 	peer->hash_key = hash_key;
-	rxrpc_assess_MTU_size(local, peer);
-	peer->mtu = peer->if_mtu;
 	peer->rtt_last_req = ktime_get_real();
 
 	switch (peer->srx.transport.family) {
@@ -266,7 +268,6 @@ static void rxrpc_init_peer(struct rxrpc_local *local, struct rxrpc_peer *peer,
 	}
 
 	peer->hdrsize += sizeof(struct rxrpc_wire_header);
-	peer->maxdata = peer->mtu - peer->hdrsize;
 }
 
 /*
@@ -285,6 +286,7 @@ static struct rxrpc_peer *rxrpc_create_peer(struct rxrpc_local *local,
 	if (peer) {
 		memcpy(&peer->srx, srx, sizeof(*srx));
 		rxrpc_init_peer(local, peer, hash_key);
+		rxrpc_assess_MTU_size(local, peer);
 	}
 
 	_leave(" = %p", peer);
-- 
2.53.0

