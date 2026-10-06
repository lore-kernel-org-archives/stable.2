Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB293E9C17
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293477; cv=none; b=nGap1A7Hgr5BuzCzC+HSUZM8fvH6IsA5Q8PLxTmhrfmBFBRMhdE4m38ULurjILdPuDGjaHBihElKilsuWMKLMgJwCYq5uTAIqOzua+wU6FBG7gtRWGHhCsJK5BNU416MoHy2hC0QFp6mkYeO67zWwk/E/uuRjDmHKr0Noi0R/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293477; c=relaxed/simple;
	bh=S+3y5zpsT0dJxQfYSb/m1lEcCkWv4LSVDbe7tctYbbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlyS8wO+nk39lp37daEOQxq0K1tyIx7WM27xnHft+7s87AZ3uVt6qM/hFTX4mC3SgTqCUhZ08TlYCfyU/O0xnq/BOXZSTj3KQrJCWcRrLcXAL1+sG5oZT64I9fdz/Bdwdth/wCzwKv6b+4Jht+inq4os2rkIQG8AOulAyczM3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avFrsHr3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avFrsHr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791293474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dggRW1Hf1BG7rN9abzHZgWlSb0X3TvHBoa+M1GNfnS8=;
	b=avFrsHr3EslBhlonr4ftH6D+PV2as/5fJRTAInm2QdJogDlj+tCK3RaOOrzQvsqbEy0Nx3
	XLYzcvtqwfK6WqcR0Tp9psRqx6tuzP0fTw1qGo7xHyk66bONr5RFXi6Yxjv5yhBG5EDOJY
	8bXAZ8NgAhUTqDbGIePbjrdeBz+0pxM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-DsSKMJAzNBuLb5ksMJ1OBQ-1; Tue,
 06 Oct 2026 09:31:13 -0400
X-MC-Unique: DsSKMJAzNBuLb5ksMJ1OBQ-1
X-Mimecast-MFC-AGG-ID: DsSKMJAzNBuLb5ksMJ1OBQ_1791293470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A89381964CCA;
	Tue,  6 Oct 2026 13:31:10 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56BEF3001D34;
	Tue,  6 Oct 2026 13:31:07 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@vger.kernel.org
Subject: [PATCH net v12 10/15] rxrpc: Fix the cleanup of service calls when socket shut down
Date: Tue,  6 Oct 2026 14:30:02 +0100
Message-ID: <20261006133011.531806-11-dhowells@redhat.com>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
References: <20261006133011.531806-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When a kernel AF_RXRPC socket is shut down, rxrpc_release_call() detaches
each outstanding service call from the socket, but doesn't send the app a
notification for each call that the socket to end the linkage from the app
side, assuming that the app will do this - but neither afs nor rxperf do.
The notification is prevented by rxrpc_notify_socket() rejecting the
notification if the socket in the CLOSE state.  This could lead to calls
not being cleaned up and rmmod of rxrpc stalling indefinitely.

Fix this by:

 (1) Making rxrpc_release_calls_on_socket() wait for the call to be
     transitioned to the completed state when the I/O thread processes the
     abort proposal.  This prevents the call from having the RELEASED flag
     set before rxrpc_notify_socket() runs (which would otherwise cause the
     notification to be skipped).

 (2) Making rxrpc_notify_socket() call ->notify_rx() even if the socket is
     in the RXRPC_CLOSE state.  The wait added in (1) makes sure that the
     notification is done before the call is released from the socket.

Note that this isn't relevant to userspace as the userspace app doesn't
have its own structures in the kernel that need to be cleaned up.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 net/rxrpc/call_object.c |  1 +
 net/rxrpc/recvmsg.c     | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 817ed9acb91e..68d4096994bd 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -628,6 +628,7 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
 		rxrpc_get_call(call, rxrpc_call_get_release_sock);
 		rxrpc_propose_abort(call, RX_CALL_DEAD, -ECONNRESET,
 				    rxrpc_abort_call_sock_release);
+		wait_event(call->waitq, rxrpc_call_is_complete(call));
 		rxrpc_release_call(rx, call);
 		rxrpc_put_call(call, rxrpc_call_put_release_sock);
 	}
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 0c960f13b5fc..214eea04b1c2 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -37,12 +37,12 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	rx = rcu_dereference(call->socket);
 	sk = &rx->sk;
-	if (rx && sk->sk_state < RXRPC_CLOSE) {
-		if (call->notify_rx) {
-			spin_lock_irqsave(&call->notify_lock, flags);
-			call->notify_rx(sk, call, call->user_call_ID);
-			spin_unlock_irqrestore(&call->notify_lock, flags);
-		} else {
+	if (call->notify_rx) {
+		spin_lock_irqsave(&call->notify_lock, flags);
+		call->notify_rx(sk, call, call->user_call_ID);
+		spin_unlock_irqrestore(&call->notify_lock, flags);
+	} else {
+		if (rx && sk->sk_state < RXRPC_CLOSE) {
 			spin_lock_irqsave(&rx->recvmsg_lock, flags);
 			if (list_empty(&call->recvmsg_link)) {
 				rxrpc_get_call(call, rxrpc_call_get_notify_socket);

