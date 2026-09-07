Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C4490C05
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781101; cv=none; b=IdRz1bY/l+Bqi13JLGLLJ89nlFgQjrg0u95OlNfcfWZzitJ6RP9MVFK0C5L3cH8YH1h3sHxur/bJxkxciJiPghNZaWK5a4ePH0b0F4lCtNM8viOKQlt9wgUVrrPKL+/R/pQlbIm3/6EWwllWRQ2jo2QD4U/2rqJ1Sv93gNr9bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781101; c=relaxed/simple;
	bh=ZtEu2PHvw1SjfO0Lr2jDTuXPP33/9pkmn37mdyPY354=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1P3Q4uyONuGshE3taK+e38VPgQXSBRmmNwKJ5vyCFMZQjP7gCPGyN/z8uEr1Fb1LOVRvjfu2pdbCiD3rsFkTecH5xsVmVf5TQ0ycgmxNt+cIf+YEFNY+1D9xxVUWlRJa9hlxBLs5JdLx1t/h/dcEu3QJQAOejFbyZ1k5whrv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWKT1v2h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWKT1v2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kblW+4X0qELmQ+paYNuu36a6ezabX7pB4fI7hh59UYU=;
	b=IWKT1v2hPvVjrbhJyJYOo2Yw/yzHD+woNg7Mt2hD/od2HG8Q2OL6oZY6KAihrrSQzUZHpl
	PLh3gZ4kDubnXwFejdBd1rBxIY6+q4jIlN67zjLv+dvMdRCfXrPWfG4IV2uVD+y5cWKUON
	Yeih6fdM4llox/PAE/qp7MxHbxr3zTc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-l32XF283Mnyr8ygzKrf1bA-1; Mon,
 07 Sep 2026 07:38:15 -0400
X-MC-Unique: l32XF283Mnyr8ygzKrf1bA-1
X-Mimecast-MFC-AGG-ID: l32XF283Mnyr8ygzKrf1bA_1788781094
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89707180137D;
	Mon,  7 Sep 2026 11:38:13 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BFBA427;
	Mon,  7 Sep 2026 11:38:09 +0000 (UTC)
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
Subject: [PATCH net v9 04/14] rxrpc: Fix sendmsg to not return an error if last packet queued
Date: Mon,  7 Sep 2026 12:37:31 +0100
Message-ID: <20260907113743.1453210-5-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Fix AF_RXRPC sendmsg() so that it doesn't return an error if it has
successfully queued the last packet of a call, but the call has seen to
have completed after it did that.  Rather, leave it to recvmsg() to report
the completion (which it will do anyway).

The problem with trying to report the error twice is that the caller may
try to clean up the dead call twice.

Fixes: 4ba68c519255 ("rxrpc: Return an error to sendmsg if call failed")
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
 fs/afs/rxrpc.c      |  2 +-
 net/rxrpc/sendmsg.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 04756d8744e2..1f5b6aa68943 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -878,7 +878,7 @@ void afs_send_empty_reply(struct afs_call *call)
 
 	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, 0,
 				     afs_notify_end_reply_tx);
-	if (ret >= 0)
+	if (ret >= 0) /* Shouldn't buffer more than 0 bytes. */
 		return;
 
 	rxrpc_kernel_abort_call(net->socket, call->rxcall,
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed2c9a51005a..1d66e9808162 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -453,9 +453,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 success:
 	ret = copied;
-	if (rxrpc_call_is_complete(call) &&
-	    call->error < 0)
-		ret = call->error;
 out:
 	call->tx_pending = txb;
 	_leave(" = %d", ret);
@@ -467,8 +464,14 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	return call->error;
 
 maybe_error:
-	if (copied)
+	if (copied) {
+		if (rxrpc_call_is_complete(call) &&
+		    call->error < 0) {
+			ret = call->error;
+			goto out;
+		}
 		goto success;
+	}
 	goto out;
 
 efault:
@@ -800,9 +803,16 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
  * Allow a kernel service to send data on a call.  The call must be in an state
  * appropriate to sending data.  No control data should be supplied in @msg,
  * nor should an address be supplied.  MSG_MORE should be flagged if there's
- * more data to come, otherwise this data will end the transmission phase.
+ * more data to come, otherwise this data will end the transmission phase if
+ * all the data is buffered.
+ *
+ * Note that this function may return a short send, in which case it should be
+ * called again for the remainder of the data or to pick up an error that
+ * caused the short send.
  *
- * Return: %0 if successful and a negative error code otherwise.
+ * Return: The number of bytes buffered (could be %0 if @len is 0 or
+ * msg_iter holds 0 bytes) if successful and a negative error code
+ * otherwise.
  */
 int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,

