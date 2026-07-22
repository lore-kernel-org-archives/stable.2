Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD03F3265
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736493; cv=none; b=U0nWZ7kEZzpWYjysKjo7g9TTP1KqTdVIy2ZXzeAcY0pHKfiYHVQziDqit7O0kLwkhZj+1Ggote4SUthXaNrckyt13TCIzgpBoShPTrxWY0JSxMnKi8KQeV9MHw3h6kliY74e4a/hjPLNNOB/v5gCD8dxvN0nT81utBKzJsHiPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736493; c=relaxed/simple;
	bh=xYF6OorAK0hfK17unIp62m8JPhsPt5+R8mWxmXsFprY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0hl+JVQyTHtdYG3TzZqwbHtB8r/vji0xgL56N3o6ewGKg7e19CNsk1Nl9aMg5Z5NgvC87xWottT6YImIOZX4rJjsOzDD+k/lqGTzad1D4PioyVANqR8NTTT3mJ5SdpINFs5bVtW7OKytyKMaaq7osXVcLLHb/+BD9HwOVxz6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGk0mS8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGk0mS8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAD31F000E9;
	Wed, 22 Jul 2026 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736491;
	bh=RANgIS/oJmskTNE9zOd6Dq6kbWURhe/Ftgu53yucU2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QGk0mS8ljK/k8lusu8dj06yByzwWwVLGXajcUvZ34Z2KIPiG8YN45UoE7/mFonCfl
	 wXjUcGE5P4ZDwpblLi77S9qvoFEVVkL4o+sxKmq/3rCkOt4M76rgdFZtNoogeEcDpk
	 Z/QlNErzGqPyqCCAnAx8CjKtbm23w3oVA0pwdpJLUrgbDeJEhvstBabsrblqQozBNN
	 8ODwyJ+BnkcgYzudlxC43dAG1V0n2buPu8GRJ5m6+LH9sWMaOpsjaLXwlWrBXCf18L
	 Jqpbwpx3O0eUZ4n9ZIlTB3b5ZoUMxlEnKfAKMU/38JfVKiRLP4sC5ctRMXiFXgXZHp
	 wbJ5WrTYALvLw==
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
Subject: [PATCH 6.12.y 4/5] rxrpc: Fix notification vs call-release vs recvmsg
Date: Wed, 22 Jul 2026 12:08:04 -0400
Message-ID: <20260722160805.1741176-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160805.1741176-1-sashal@kernel.org>
References: <2026072023-cricket-devoutly-1a61@gregkh>
 <20260722160805.1741176-1-sashal@kernel.org>
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
 include/trace/events/rxrpc.h |  3 ++-
 net/rxrpc/call_object.c      | 28 ++++++++++++----------------
 net/rxrpc/recvmsg.c          |  4 ++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index be25f47cfc7dbb..fd913d7f79b87d 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -278,10 +278,10 @@
 	EM(rxrpc_call_put_poke,			"PUT poke    ") \
 	EM(rxrpc_call_put_recvmsg,		"PUT recvmsg ") \
 	EM(rxrpc_call_put_recvmsg_peek_nowait,	"PUT peek-nwt") \
+	EM(rxrpc_call_put_release_recvmsg_q,	"PUT rls-rcmq") \
 	EM(rxrpc_call_put_release_sock,		"PUT rls-sock") \
 	EM(rxrpc_call_put_release_sock_tba,	"PUT rls-sk-a") \
 	EM(rxrpc_call_put_sendmsg,		"PUT sendmsg ") \
-	EM(rxrpc_call_put_unnotify,		"PUT unnotify") \
 	EM(rxrpc_call_put_userid_exists,	"PUT u-exists") \
 	EM(rxrpc_call_put_userid,		"PUT user-id ") \
 	EM(rxrpc_call_see_accept,		"SEE accept  ") \
@@ -294,6 +294,7 @@
 	EM(rxrpc_call_see_disconnected,		"SEE disconn ") \
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
+	EM(rxrpc_call_see_notify_released,	"SEE nfy-rlsd") \
 	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
 	EM(rxrpc_call_see_recvmsg_requeue,	"SEE recv-rqu") \
 	EM(rxrpc_call_see_recvmsg_requeue_first, "SEE recv-rqF") \
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 8210b86e7d1a6b..6e011a1e8e7138 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -547,7 +547,7 @@ static void rxrpc_cleanup_ring(struct rxrpc_call *call)
 void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 {
 	struct rxrpc_connection *conn = call->conn;
-	bool put = false, putu = false;
+	bool putu = false;
 
 	_enter("{%d,%d}", call->debug_id, refcount_read(&call->ref));
 
@@ -559,23 +559,13 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 
 	rxrpc_put_call_slot(call);
 
-	/* Make sure we don't get any more notifications */
+	/* Note that at this point, the call may still be on or may have been
+	 * added back on to the socket receive queue.  recvmsg() must discard
+	 * released calls.  The CALL_RELEASED flag should prevent further
+	 * notifications.
+	 */
 	spin_lock_irq(&rx->recvmsg_lock);
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
 	spin_unlock_irq(&rx->recvmsg_lock);
-	if (put)
-		rxrpc_put_call(call, rxrpc_call_put_unnotify);
 
 	write_lock(&rx->call_lock);
 
@@ -624,6 +614,12 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
 		rxrpc_put_call(call, rxrpc_call_put_release_sock);
 	}
 
+	while ((call = list_first_entry_or_null(&rx->recvmsg_q,
+						struct rxrpc_call, recvmsg_link))) {
+		list_del_init(&call->recvmsg_link);
+		rxrpc_put_call(call, rxrpc_call_put_release_recvmsg_q);
+	}
+
 	_leave("");
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index dccfa6cae71502..3ff5a9b78ba083 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -29,6 +29,10 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	if (!list_empty(&call->recvmsg_link))
 		return;
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_notify_released);
+		return;
+	}
 
 	rcu_read_lock();
 
-- 
2.53.0

