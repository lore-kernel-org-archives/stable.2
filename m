Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0B4A5EA8
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398847; cv=none; b=JjetB6C33d40W585tROo14QDDb2kNKWh7dhU99+mSpfxHAaX/SjCWHzJhTWATQPmdz5W5xAf/U4Yn0w0NMPiwDCJ8ui3nJFtqJQSLVE7wZDpy9dET9E7K3UTyfdofTe0Tp6FZGURBh5OI5vw78My+I9I8hrWMDEjTN96dqYQXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398847; c=relaxed/simple;
	bh=qu1a4D3n3eMBQyrcOyOOdCePdmonXSrT6Fdpl/F0JcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsb7w5fiYHHpj/pWKO5qQNr7MkKScMiqVmWiFPG0TOKTRU/CBAZZwyZoEvTaLqv9PLVkyhF2ounapW4k0pTD/CWPR6Jp+Rk9uxziVdPxGoktQUCGp6JPiJTaeMYFHgjgcQSlLwWo82OUm7CHjTXftjTIGJ8LyjhNgwYc8S4ZU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4ViDD/a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4ViDD/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxfU28vY4jGpIFbJ5It3kleVAPLwHORiApFBN+rAZFQ=;
	b=B4ViDD/aD6sYSNPMAmO0zHM9MrWSTMVWshmvCaeD4V+o97QLgheDgRmKgNB43PT3yeWf/b
	a7ejKK4uF6BnzvpUfF0gy2Tt5QhyO9sLDgUKWJ57pWr83Ov/RfuGyiAaCthYPcvpqhU6e7
	KgVWtklYn8JxFv3OEyV1wOY2Nocwngc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-wsStrZxBPK6hNFa3vlztqg-1; Mon,
 14 Sep 2026 11:14:01 -0400
X-MC-Unique: wsStrZxBPK6hNFa3vlztqg-1
X-Mimecast-MFC-AGG-ID: wsStrZxBPK6hNFa3vlztqg_1789398840
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4CAB1955DA3;
	Mon, 14 Sep 2026 15:13:59 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49BAF1955F74;
	Mon, 14 Sep 2026 15:13:56 +0000 (UTC)
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
Subject: [PATCH net v10 02/14] afs: Fix afs to abort the rxrpc call on send error
Date: Mon, 14 Sep 2026 16:13:26 +0100
Message-ID: <20260914151340.3227501-3-dhowells@redhat.com>
In-Reply-To: <20260914151340.3227501-1-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix afs_send_empty_reply() and afs_send_simple_reply() to always try to
abort the rxrpc call rather than just aborting on -ENOMEM and otherwise
abandoning it.  If the call is already complete due to network failure or a
received abort, this will do nothing.

Also make afs_make_call() always abort on send error; again, it does
nothing if the rxrpc call is already dead.

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
 fs/afs/rxrpc.c               | 36 +++++++++++-------------------------
 include/trace/events/rxrpc.h |  2 +-
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 09d9da92a1be..2b241716dae7 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -441,10 +441,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	return;
 
 error_do_abort:
-	if (ret != -ECONNABORTED)
-		rxrpc_kernel_abort_call(call->net->socket, rxcall,
-					RX_USER_ABORT, ret,
-					afs_abort_send_data_error);
+	rxrpc_kernel_abort_call(call->net->socket, rxcall,
+				RX_USER_ABORT, ret, afs_abort_send_data_error);
 	if (call->async) {
 		afs_see_call(call, afs_call_trace_async_abort);
 		return;
@@ -857,6 +855,7 @@ void afs_send_empty_reply(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
 	struct msghdr msg;
+	int ret;
 
 	_enter("");
 
@@ -869,22 +868,12 @@ void afs_send_empty_reply(struct afs_call *call)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
-				       afs_notify_end_reply_tx)) {
-	case 0:
-		_leave(" [replied]");
-		return;
-
-	case -ENOMEM:
-		_debug("oom");
+	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
+				     afs_notify_end_reply_tx);
+	if (ret < 0)
 		rxrpc_kernel_abort_call(net->socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					afs_abort_oom);
-		fallthrough;
-	default:
-		_leave(" [error]");
-		return;
-	}
+					RXGEN_SS_MARSHAL, ret,
+					afs_abort_send_error);
 }
 
 /*
@@ -913,12 +902,9 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
 				   afs_notify_end_reply_tx);
 	if (n < 0) {
-		if (n == -ENOMEM) {
-			_debug("oom");
-			rxrpc_kernel_abort_call(net->socket, call->rxcall,
-						RXGEN_SS_MARSHAL, -ENOMEM,
-						afs_abort_oom);
-		}
+		rxrpc_kernel_abort_call(net->socket, call->rxcall,
+					RXGEN_SS_MARSHAL, n,
+					afs_abort_send_error);
 		_leave(" [error]");
 	}
 }
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 704a10de6670..554dfb777b93 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -20,10 +20,10 @@
 	/* AFS errors */						\
 	EM(afs_abort_general_error,		"afs-error")		\
 	EM(afs_abort_interrupted,		"afs-intr")		\
-	EM(afs_abort_oom,			"afs-oom")		\
 	EM(afs_abort_op_not_supported,		"afs-op-notsupp")	\
 	EM(afs_abort_probeuuid_negative,	"afs-probeuuid-neg")	\
 	EM(afs_abort_send_data_error,		"afs-send-data")	\
+	EM(afs_abort_send_error,		"afs-send-error")	\
 	EM(afs_abort_unmarshal_error,		"afs-unmarshal")	\
 	EM(afs_abort_unsupported_sec_class,	"afs-unsup-sec-class")	\
 	/* rxperf errors */						\

