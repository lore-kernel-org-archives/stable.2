Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF84779A4
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625493; cv=none; b=oa4j6AKszEOR3vtA71aYgJZAqHaFsW7sro85KxiLghduHXEq3Elh4iAn9oClleGxTaMjJ39k/CDgi/CkEgCfPVswNJkEKZXZkONDmben6lASx3ioiI2VjixphmbYg62MZBsHRonQl5Y4afSZVgdQ97VpnrTKgYU/lBjOPJNkv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625493; c=relaxed/simple;
	bh=P1I+KWbK76llHaE2wH3T1Kgg++GDTr9b0M+6bQ/aXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxAJmhx/ZVTkVN3zjKOu50i/ITPrD23jcpHWXo7AH3f3Tu3/PxbaGxGrloWXj33YOwN7AaWKC+Q24d0Djb8juUHm7CJzGiGmdx9aLPVsAc7e7L6/Cm8VSDX96n2UneFZokUIUIpldjjPgyVKc6hkiWh8wafCjLlRywJ7380TxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDLtwOX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDLtwOX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781625491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ6shKU2Olrq5XLk9VR7nCy5qua26jmULBJsUITnQx4=;
	b=SDLtwOX2kKBTyHnrXmy7wG2Y/rBsXYM3uyXisxNrJLW+RLOe/IQJGyZIpNXI6eCCdSXQRl
	KusNDGwcQmcIBO8UfwEV9OA785+45IyRtykMGGc/dZoHF7ZTIgVFHZHkzGKxbma2Y3l3aH
	waI4zFbpF8KPP0GtASb1jPnIsb/oD44=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-YYgferILNXm0AdRbM1RG4A-1; Tue,
 16 Jun 2026 11:58:05 -0400
X-MC-Unique: YYgferILNXm0AdRbM1RG4A-1
X-Mimecast-MFC-AGG-ID: YYgferILNXm0AdRbM1RG4A_1781625483
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E40441800A3E;
	Tue, 16 Jun 2026 15:58:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 201311800595;
	Tue, 16 Jun 2026 15:57:56 +0000 (UTC)
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
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	stable@vger.kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: [PATCH net 1/5] rxrpc: input: reject ACKALL outside transmit phase
Date: Tue, 16 Jun 2026 16:57:43 +0100
Message-ID: <20260616155749.2125907-2-dhowells@redhat.com>
In-Reply-To: <20260616155749.2125907-1-dhowells@redhat.com>
References: <20260616155749.2125907-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Wyatt Feng <bronzed_45_vested@icloud.com>

rxrpc_input_ackall() accepts ACKALL packets without checking whether
the call is in a state that can legitimately have outstanding transmit
buffers.  A forged ACKALL can therefore reach a new service call in
RXRPC_CALL_SERVER_RECV_REQUEST before any reply packets have been
queued.

In that state call->tx_top is zero and call->tx_queue is NULL, so
rxrpc_rotate_tx_window() dereferences a NULL txqueue and triggers a
null-pointer dereference.

Fix rxrpc_input_ackall() to mirror the transmit-state gating already
used for normal ACK processing, and ignore ACKALL when there is no
outstanding transmit window to rotate.

Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/input.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index ce761466b02d..37881dffa898 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1214,8 +1214,22 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
+	rxrpc_seq_t top = READ_ONCE(call->tx_top);
+
+	switch (__rxrpc_call_state(call)) {
+	case RXRPC_CALL_CLIENT_SEND_REQUEST:
+	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
+	case RXRPC_CALL_SERVER_SEND_REPLY:
+	case RXRPC_CALL_SERVER_AWAIT_ACK:
+		break;
+	default:
+		return;
+	}
+
+	if (call->tx_bottom == top)
+		return;
 
-	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
+	if (rxrpc_rotate_tx_window(call, top, &summary))
 		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
 }
 

