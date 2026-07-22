Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360A368D4D
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741410; cv=none; b=ePkkBNO5nYxTr30l57HGU7U4fK94wPdf6AGl+ibW/eOdbfeHiukplCce3YB9y5ufsLeQGjQCppIOEBfCxawxxzmRGCR6Wfb5FJURnB5+l0OsfQzYlL6wrwxltA+hg1glD14+K+1pUYJu7lOve0Y9Ruac77vfXkbVnYK3Go9ZqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741410; c=relaxed/simple;
	bh=sGd5fS984n6t4LX92j21yf8pUbUVdEY9P0Hp+vxP/7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFEtDwLKzWwnnh/dglwAMu+LKvrCzXB3+6Ds/Sl2y6DbgMNPHHs09gWSSRCBynKFijW1vFDtHVOOJvAftRAP2MCtAlD/MtgXN/slz4VfxnuPhcDCoz7MmT7tvuagNhFk37dinP7VMMWYIGJ3ZoQJ5jDQDJ+9hVI0PiPqpYSO4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBcRCCrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBcRCCrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2A91F000E9;
	Wed, 22 Jul 2026 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741408;
	bh=dJneP7k2D+4eql1vmpmd9epcNVSZ3CM5FnZxaATESic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TBcRCCrNEPYE46deRJydruBWWelSb8Vznqhmj8Ah8/OXgfItO9sfwGzqyoR7GFLt/
	 MF/QsF3biWpwHs4PFmNs32BdgDudCkNc14fbrzcVmF3py0qd3q8YbvvvKFUunCrlto
	 Q26VeyR0/iiTgyeo5Mb11GuFp987H39CsCYIU58TbB88Wa2SjGLbk8t8v05uJNVeKe
	 vWY0fPItL3FwGVV33Z279lfXubTrRh2Cu0VoxwYGmGoIx0pAqeM10vsVxJhcCLiVj5
	 YkeXF6ByXS2Uo2d9iLHDeLQS6ijZ1r9VfhRvkiMvZv4/zw5sXa105CVQJxJI+autDR
	 CcTrEP78ByehQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] rxrpc: Don't need barrier for ->tx_bottom and ->acks_hard_ack
Date: Wed, 22 Jul 2026 13:30:03 -0400
Message-ID: <20260722173006.2069029-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072024-devalue-womanly-8b22@gregkh>
References: <2026072024-devalue-womanly-8b22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 6396b48ac0a77165f9c2c40ab03d6c8188c89739 ]

We don't need a barrier for the ->tx_bottom value (which indicates the
lowest sequence still in the transmission queue) and the ->acks_hard_ack
value (which tracks the DATA packets hard-ack'd by the latest ACK packet
received and thus indicates which DATA packets can now be discarded) as the
app thread doesn't use either value as a reference to memory to access.
Rather, the app thread merely uses these as a guide to how much space is
available in the transmission queue

Change the code to use READ/WRITE_ONCE() instead.

Also, change rxrpc_check_tx_space() to use the same value for tx_bottom
throughout.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/20241204074710.990092-18-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e66f8f32f501 ("rxrpc: Fix socket notification race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 8 +++++---
 net/rxrpc/txbuf.c   | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 6939617afc7bcd..3dc54d6d4e316f 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -93,9 +93,11 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
  */
 static bool rxrpc_check_tx_space(struct rxrpc_call *call, rxrpc_seq_t *_tx_win)
 {
+	rxrpc_seq_t tx_bottom = READ_ONCE(call->tx_bottom);
+
 	if (_tx_win)
-		*_tx_win = call->tx_bottom;
-	return call->tx_prepared - call->tx_bottom < 256;
+		*_tx_win = tx_bottom;
+	return call->tx_prepared - tx_bottom < 256;
 }
 
 /*
@@ -137,7 +139,7 @@ static int rxrpc_wait_for_tx_window_waitall(struct rxrpc_sock *rx,
 		rtt = 2;
 
 	timeout = rtt;
-	tx_start = smp_load_acquire(&call->acks_hard_ack);
+	tx_start = READ_ONCE(call->acks_hard_ack);
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index d43be851238640..84d067fbc2fd10 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -112,14 +112,14 @@ void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *call)
 
 	while ((txb = list_first_entry_or_null(&call->tx_buffer,
 					       struct rxrpc_txbuf, call_link))) {
-		hard_ack = smp_load_acquire(&call->acks_hard_ack);
+		hard_ack = call->acks_hard_ack;
 		if (before(hard_ack, txb->seq))
 			break;
 
 		if (txb->seq != call->tx_bottom + 1)
 			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_out_of_step);
 		ASSERTCMP(txb->seq, ==, call->tx_bottom + 1);
-		smp_store_release(&call->tx_bottom, call->tx_bottom + 1);
+		WRITE_ONCE(call->tx_bottom, call->tx_bottom + 1);
 		list_del_rcu(&txb->call_link);
 
 		trace_rxrpc_txqueue(call, rxrpc_txqueue_dequeue);
-- 
2.53.0

