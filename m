Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF92DC79F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762498; cv=none; b=VTikT6XL0CPoqdeqL1wusyt8IEh1enHd3PQ8lreVlamYry6tZX1v6EPYP2l/lB6/Y4U7jzPyH4MuFenZ73DCbsXITXTB6D6IPuJ8Ctl+NMNsy3sWxis7dwq2lg3nKZm3Fo4s7C/YTsy6xtvihAhR3dMJ2ooGGuy93Wed66btZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762498; c=relaxed/simple;
	bh=G69uRV49oIJRzIovOxq87vOVXJirWXSz7ZeZdGTq+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ8xYVG3xA46TxZOT1QNTqjrVW//IquYZGqtNW+TGi+vbowspiNYPTD23skbS/5ta0Pv0NRbxyE4nQnsOozPmZJU4T9Kb5ecpFRJn1T71R0l5IbDPCj8ZRLKok/Xyw0i5AsqPB1Zh9V1L7AXT40TX1MI6xNkv2oeYPgFKMh5Jjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8CcxGyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8CcxGyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAF81F000E9;
	Wed, 22 Jul 2026 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762496;
	bh=IBKbeCBb1m98bRdVsc4LehavEA68tnM/8zXZJKsDGwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d8CcxGyv92y3oCTt2m4fgY2IBGdsfJG85o5GpbicAFVLaF7LZeY+UssiPoyJTvHWe
	 sCoNCNJxysILELdpHZVVyXjT+Nc5vEM1G/HV2zba+K62rDcqikF1CqoiWsGHDUEJoR
	 S5fv11R4IR5Chg/Zg4y14+7DMovlQ4brE6X0MGt559g0/0fHpoqtC5zflJy6WbJ3tL
	 YCy9hz9ff/7x3UJpX2OH/FwHMqrs3rVwuD9SQKqQtD4ORBN/IVgQ8o4xvnvoCPzATI
	 UYK0twNGbViqzeNPcCVhKKCsHzq2QQOrMoM6eEbeU4XJzO3yRStGBRFHNySvOsONCd
	 nAeQCgHj6n3JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	LePremierHomme <kwqcheii@proton.me>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] rxrpc: Fix recv-recv race of completed call
Date: Wed, 22 Jul 2026 19:21:31 -0400
Message-ID: <20260722232133.2553162-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072025-implode-raider-540f@gregkh>
References: <2026072025-implode-raider-540f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 962fb1f651c2cf2083e0c3ef53ba69e3b96d3fbc ]

If a call receives an event (such as incoming data), the call gets placed
on the socket's queue and a thread in recvmsg can be awakened to go and
process it.  Once the thread has picked up the call off of the queue,
further events will cause it to be requeued, and once the socket lock is
dropped (recvmsg uses call->user_mutex to allow the socket to be used in
parallel), a second thread can come in and its recvmsg can pop the call off
the socket queue again.

In such a case, the first thread will be receiving stuff from the call and
the second thread will be blocked on call->user_mutex.  The first thread
can, at this point, process both the event that it picked call for and the
event that the second thread picked the call for and may see the call
terminate - in which case the call will be "released", decoupling the call
from the user call ID assigned to it (RXRPC_USER_CALL_ID in the control
message).

The first thread will return okay, but then the second thread will wake up
holding the user_mutex and, if it sees that the call has been released by
the first thread, it will BUG thusly:

	kernel BUG at net/rxrpc/recvmsg.c:474!

Fix this by just dequeuing the call and ignoring it if it is seen to be
already released.  We can't tell userspace about it anyway as the user call
ID has become stale.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/20250717074350.3767366-3-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e66f8f32f501 ("rxrpc: Fix socket notification race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h |  2 ++
 net/rxrpc/call_accept.c      |  1 +
 net/rxrpc/recvmsg.c          | 19 +++++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 6cde10ae4445d1..c22e72eb5f6ec7 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -134,6 +134,7 @@ enum rxrpc_recvmsg_trace {
 	rxrpc_recvmsg_return,
 	rxrpc_recvmsg_terminal,
 	rxrpc_recvmsg_to_be_accepted,
+	rxrpc_recvmsg_unqueue,
 	rxrpc_recvmsg_wait,
 };
 
@@ -333,6 +334,7 @@ enum rxrpc_tx_point {
 	EM(rxrpc_recvmsg_return,		"RETN") \
 	EM(rxrpc_recvmsg_terminal,		"TERM") \
 	EM(rxrpc_recvmsg_to_be_accepted,	"TBAC") \
+	EM(rxrpc_recvmsg_unqueue,		"UNQU") \
 	E_(rxrpc_recvmsg_wait,			"WAIT")
 
 #define rxrpc_rtt_tx_traces \
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index b96af42a1b0415..47ea3251cf6ba5 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -220,6 +220,7 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	tail = b->call_backlog_tail;
 	while (CIRC_CNT(head, tail, size) > 0) {
 		struct rxrpc_call *call = b->call_backlog[tail];
+		rxrpc_see_call(call);
 		rcu_assign_pointer(call->socket, rx);
 		if (rx->discard_new_call) {
 			_debug("discard %lx", call->user_call_ID);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 301b8acf78f55f..8501150c2c35a3 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -546,6 +546,16 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	write_lock_bh(&rx->recvmsg_lock);
 	l = rx->recvmsg_q.next;
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
+
+	rxrpc_see_call(call);
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		list_del_init(&call->recvmsg_link);
+		write_unlock_bh(&rx->recvmsg_lock);
+		release_sock(&rx->sk);
+		trace_rxrpc_recvmsg(call, rxrpc_recvmsg_unqueue, 0, 0, 0, 0);
+		rxrpc_put_call(call, rxrpc_call_put);
+		goto try_again;
+	}
 	if (!(flags & MSG_PEEK))
 		list_del_init(&call->recvmsg_link);
 	else
@@ -568,8 +578,13 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	release_sock(&rx->sk);
 
-	if (test_bit(RXRPC_CALL_RELEASED, &call->flags))
-		BUG();
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call);
+		mutex_unlock(&call->user_mutex);
+		if (!(flags & MSG_PEEK))
+			rxrpc_put_call(call, rxrpc_call_put);
+		goto try_again;
+	}
 
 	if (test_bit(RXRPC_CALL_HAS_USERID, &call->flags)) {
 		if (flags & MSG_CMSG_COMPAT) {
-- 
2.53.0

