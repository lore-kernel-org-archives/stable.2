Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA1483BF8
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781085; cv=none; b=AQ5sTN+W2z37y9Ce0z1LL4gJ9i0XLnxLetN1NPAcXEjLmSkbFKQiy+qZ5Uw7GoDQnT+nhRKidBRQpqq4iPZOXIqxYWFzV04eMpppLNrlDNhN0eG0CeMepcnVzkYDWSogyIKC2d7Q1NS+BDQ1oQQxBgR8OLpCa0RUxzaU+d6MiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781085; c=relaxed/simple;
	bh=QkrXgiLBzAZrUOZ6rbFL5J/0l0Uf0yR9sCHA/3lcU/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVnUSZV8Id3/58l5+vqQUtQi5EnqsRTg9eR8/8YTqlQMRD8Xd1ZlUKd8YDvKgYU4iTsgGwvC8Nq6YoZd0cQ/tkfBp1i58oR7I1mAA8Hjw+j3+oOUW04L/Q0u9M8OwWO1rnaGuXFix88GmKv49Z5NP540mKUswkfQN/eAYq6DeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTzxLW/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTzxLW/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfhzEQdfY31yuT9bz4poJnqa+tccgqvEMkzikJwbDsU=;
	b=MTzxLW/Qd6O1EXsLWLyVmiDnA7qt5aXQdClWZi9ntW2mcEdT7alqkBay/fvAviGE3S4xzM
	Rhr1Hz5wAWGQN6OIE+w/U8aKMw1WVTQnT0BNzW1VXv29q4jiCDhdbzrodxLpdEUiLes7li
	chAD7IEm0SA3EqX25hFg2hl/JBDf7Sg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-xCWdMGJkMG6O50tqMUecqQ-1; Mon,
 07 Sep 2026 07:37:59 -0400
X-MC-Unique: xCWdMGJkMG6O50tqMUecqQ-1
X-Mimecast-MFC-AGG-ID: xCWdMGJkMG6O50tqMUecqQ_1788781078
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C9CD19540DD;
	Mon,  7 Sep 2026 11:37:58 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE1C31956042;
	Mon,  7 Sep 2026 11:37:54 +0000 (UTC)
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
	stable@vger.kernel.org
Subject: [PATCH net v9 01/14] afs: Fix lack of loop around sendmsg() to rxrpc
Date: Mon,  7 Sep 2026 12:37:28 +0100
Message-ID: <20260907113743.1453210-2-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix the afs callers of sendmsg() to send data through an rxrpc socket to
call again if a short send occurs.

Note that this is also a prerequisite for changing the way rxrpc_send_data()
works to return a short send rather than an error if some data was buffered.

Fixes: 08e0e7c82eea ("[AF_RXRPC]: Make the in-kernel AFS filesystem use AF_RXRPC.")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 fs/afs/rxrpc.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..a80b043d36be 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -412,26 +412,32 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
 
-	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
-				     &msg, call->request_size,
-				     afs_notify_end_request_tx);
-	if (ret < 0)
-		goto error_do_abort;
+	do {
+		ret = rxrpc_kernel_send_data(call->net->socket, rxcall, &msg,
+					     msg_data_left(&msg),
+					     afs_notify_end_request_tx);
+		if (ret < 0)
+			goto error_do_abort;
+	} while (msg_data_left(&msg) > 0);
 
 	if (call->write_iter) {
 		msg.msg_iter = *call->write_iter;
 		msg.msg_flags &= ~MSG_MORE;
 		trace_afs_send_data(call, &msg);
 
-		ret = rxrpc_kernel_send_data(call->net->socket,
-					     call->rxcall, &msg,
-					     iov_iter_count(&msg.msg_iter),
-					     afs_notify_end_request_tx);
+		do {
+			ret = rxrpc_kernel_send_data(call->net->socket,
+						     call->rxcall, &msg,
+						     msg_data_left(&msg),
+						     afs_notify_end_request_tx);
+			if (ret < 0) {
+				trace_afs_sent_data(call, &msg, ret);
+				goto error_do_abort;
+			}
+		} while (msg_data_left(&msg) > 0);
 		*call->write_iter = msg.msg_iter;
 
-		trace_afs_sent_data(call, &msg, ret);
-		if (ret < 0)
-			goto error_do_abort;
+		trace_afs_sent_data(call, &msg, 0);
 	}
 
 	/* Note that at this point, we may have received the reply or an abort
@@ -912,8 +918,12 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
-				   afs_notify_end_reply_tx);
+	do {
+		n = rxrpc_kernel_send_data(net->socket, call->rxcall,
+					   &msg, msg_data_left(&msg),
+					   afs_notify_end_reply_tx);
+	} while (n >= 0 && msg_data_left(&msg) > 0);
+
 	if (n >= 0) {
 		/* Success */
 		_leave(" [replied]");

