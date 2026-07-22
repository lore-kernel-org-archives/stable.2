Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FA3F3265
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736490; cv=none; b=u8YroLoY4yDh7ChW9JUKXnoBrhZ5IgSf0sgUOh7KX3KDjle/94v36QIjBojs3eQsuWFYYmKOV/+hoqaD7+Hi/0sczjS3BeyMnaDg8JRDSuOHWlmDMq+cQD2gQ9LcEVeyKwghQ73DRYPPVZK7GG/Kk3mg/gHqamST7sEeHrXsmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736490; c=relaxed/simple;
	bh=uHC5M9Dnli8g/3vTSzEowfeZKf0uE3+PNHLryK1GpHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl2W702w/7JkmlOv40qMI17OS0QBDDer4NttTPojB3sqF7ZxNNRH0cUvx7BsFCLK4LhkIlPXxKEDk9r9LMmSyPscxGA5uIRnzwnZ29tU/9/CksddPJMhqvKYjSfd+BT8uSW90AVivRf2gs/D2Dgfs7huqSy/CT3XYw+lXKfw/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO7pA6wC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO7pA6wC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3CE1F00A3D;
	Wed, 22 Jul 2026 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736489;
	bh=zNsxP1jo5wZ4pPd+pSX5rVuxrUlV2+4tLrn1nhswSSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nO7pA6wCBO9/16ebTt0OxMw6OJNAZE8tHDs+na4hD68jf1dUk843LydQqzXIAFLWD
	 zgcZLGUavfpyMEnB5p6gnwCGK3HeiCm7KtZEadxsxXyv/awynhvNYAYnWinGVoZiaN
	 s7V/3iBt98BODw6eCsXETF3A46pL7rHsdq+EHCFq+m0ETpVIGZU2zaHM1TMNojddTV
	 gd/zsrbUenZOw6cI7QZR24F2m5txo3QhOjYqoAwtPbgtrPkEPemb1B9/Ljh6yKbvNZ
	 hNQMA45kPfdXPjMeIxcWhJUI2LzuXZqzVUWaBJv7SmIG5Iq+GlRBezcR79tVnB7nGX
	 nkb08JstogTww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] rxrpc: Don't need barrier for ->tx_bottom and ->acks_hard_ack
Date: Wed, 22 Jul 2026 12:08:02 -0400
Message-ID: <20260722160805.1741176-2-sashal@kernel.org>
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
index bb2e53d2a7c71c..dc43bf8cbac95f 100644
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
index c3913d8a50d340..a63e10fcd11c4c 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -216,14 +216,14 @@ void rxrpc_shrink_call_tx_buffer(struct rxrpc_call *call)
 
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

