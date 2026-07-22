Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6531B80E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762498; cv=none; b=pioGIIQr9xVF4EPRtr+XVKyomiMNve6qgQlyasvbgQJenqfHxCYSEQnPKliPIHC1CijG1GQU2XLsX+5Nkb5xtZ3FJcAYXjUyqVzPsLf/RHSXl0L/s9pmzKr+8M6RpcPiaLMSDEwlCHeLVCcGjhC8bjy3mNY36d9KmU65pn1lKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762498; c=relaxed/simple;
	bh=feTdGXhm8CGk0Eob7PuDUIdU/UPOajU8J0zKmyWdDTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCxHcA7X6M18XV94d14a2Xovv9porgES6AxWgVKZXhpFWNIW8wS7XzZMhDgilgubjauVPbyXN5obK/y+hmYDHJnVFYXKBC+RCZWV2OP+JVjk7NIkVgFhPPQYyIXzVZceiU6jq/A5iFRV/ui795DC26wjwhIuIKK/UPp85MzsOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTXn2tcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTXn2tcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFF71F00A3A;
	Wed, 22 Jul 2026 23:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762497;
	bh=aR9fw0fDNSDl/IpSIiTSKANhm1JnVHLj0WSGRoOZGSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTXn2tcEc7RPfIIE79QhrftphfqhR8kx7bVfBndxyMhRfL2uU+cTH7FNRyMyMgJgT
	 CYivuTGPS3oI8dfOn4BBpz1sxEIDGYJV1F03/z1JMbJkdpuaYvcjkbnuASEKfgqBol
	 dnQL3k1+CcLWK9q6bLq/PiikDsktWM5EooSorh1pBa7SQQpl3anRPM6KJdCnzp7tbG
	 6p5Jkj6CVcc8G3u683Z19T5b+Q33E8F0xrQBLgwR0TU6vtCac7O2EetLjljfONkSu4
	 dDjZFxQuBVUpyPaSCZfx+6zNnnb9HvqwfCM3YcPddf/ZxQLOktLPStNDm2W6tH0KxO
	 GX+Ra0JQKha7w==
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
Subject: [PATCH 5.10.y 2/3] rxrpc: Fix notification vs call-release vs recvmsg
Date: Wed, 22 Jul 2026 19:21:32 -0400
Message-ID: <20260722232133.2553162-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722232133.2553162-1-sashal@kernel.org>
References: <2026072025-implode-raider-540f@gregkh>
 <20260722232133.2553162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2fd895842d49c23137ae48252dd211e5d6d8a3ed ]

When a call is released, rxrpc takes the spinlock and removes it from
->recvmsg_q in an effort to prevent racing recvmsg() invocations from
seeing the same call.  Now, rxrpc_recvmsg() only takes the spinlock when
actually removing a call from the queue; it doesn't, however, take it in
the lead up to that when it checks to see if the queue is empty.  It *does*
hold the socket lock, which prevents a recvmsg/recvmsg race - but this
doesn't prevent sendmsg from ending the call because sendmsg() drops the
socket lock and relies on the call->user_mutex.

Fix this by firstly removing the bit in rxrpc_release_call() that dequeues
the released call and, instead, rely on recvmsg() to simply discard
released calls (done in a preceding fix).

Secondly, rxrpc_notify_socket() is abandoned if the call is already marked
as released rather than trying to be clever by setting both pointers in
call->recvmsg_link to NULL to trick list_empty().  This isn't perfect and
can still race, resulting in a released call on the queue, but recvmsg()
will now clean that up.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/20250717074350.3767366-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e66f8f32f501 ("rxrpc: Fix socket notification race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/call_object.c | 27 +++++++++++----------------
 net/rxrpc/recvmsg.c     |  4 ++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 2240e93b0048af..9a0fbce9ee8321 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -529,7 +529,6 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 {
 	const void *here = __builtin_return_address(0);
 	struct rxrpc_connection *conn = call->conn;
-	bool put = false;
 
 	_enter("{%d,%d}", call->debug_id, refcount_read(&call->ref));
 
@@ -547,23 +546,13 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 	rxrpc_put_call_slot(call);
 	rxrpc_delete_call_timer(call);
 
-	/* Make sure we don't get any more notifications */
+	/* Note that at this point, the call may still be on or may have been
+	 * added back on to the socket receive queue.  recvmsg() must discard
+	 * released calls.  The CALL_RELEASED flag should prevent further
+	 * notifications.
+	 */
 	write_lock_bh(&rx->recvmsg_lock);
-
-	if (!list_empty(&call->recvmsg_link)) {
-		_debug("unlinking once-pending call %p { e=%lx f=%lx }",
-		       call, call->events, call->flags);
-		list_del(&call->recvmsg_link);
-		put = true;
-	}
-
-	/* list_empty() must return false in rxrpc_notify_socket() */
-	call->recvmsg_link.next = NULL;
-	call->recvmsg_link.prev = NULL;
-
 	write_unlock_bh(&rx->recvmsg_lock);
-	if (put)
-		rxrpc_put_call(call, rxrpc_call_put);
 
 	write_lock(&rx->call_lock);
 
@@ -612,6 +601,12 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
 		rxrpc_put_call(call, rxrpc_call_put);
 	}
 
+	while ((call = list_first_entry_or_null(&rx->recvmsg_q,
+						struct rxrpc_call, recvmsg_link))) {
+		list_del_init(&call->recvmsg_link);
+		rxrpc_put_call(call, rxrpc_call_put);
+	}
+
 	_leave("");
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 8501150c2c35a3..db93b05067ac89 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -29,6 +29,10 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	if (!list_empty(&call->recvmsg_link))
 		return;
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call);
+		return;
+	}
 
 	rcu_read_lock();
 
-- 
2.53.0

