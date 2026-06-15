Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F791407594
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538672; cv=none; b=sHP3AhAnbv3x3y/glqh2w6nSM8AruLxk3+p7bEk8eI+Ow9RolzQTPVjZfLhBeHxHaw3Ts+kYLOD7ELRLAO/Wzkb72v+8kdos1KrADSOPfeNAXY/l/iTqhYCLM6ROECO3YLGOP83lotFh0ZYCwLr6HWMtlKlYlPoU7Tyb/aiZub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538672; c=relaxed/simple;
	bh=OEnkoolpRIUMXzggsD2JiWXrZbwxIK836kEmh/sLAqw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ByiFkWEIiuGWVkqTjrOJcfZxBYMfFDYFAsXAbA6EnxeZs8/UoQtwgoR0AHE85QIhsP79RJOlto+BHar1QMYfag920ue51K7j/TgpqMUbL8eBjaB3T1e4Nl1Ed+eC6Dr5lqR/062R1k0MGmAqGIDN1df8qFo266QyplvGLgO9/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vr+bUvOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vr+bUvOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E071F000E9;
	Mon, 15 Jun 2026 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538671;
	bh=Ia8aCT/ri3G1+iMAprpUrF0GcbCIOKzqeem+hxW/Jok=;
	h=Subject:To:Cc:From:Date;
	b=Vr+bUvOfO25558j2s5R0g0K1UjsdkryKSo4RgS5Tm2S9CrOrcTEE6tc7YTi4ew5a1
	 FX67agFx9x58j5GXxhEf3p0n5m2mqQeQRgrwtMhLG8n4wgfbN0CV80uP6dqhNANur1
	 OSzCKaduJoZTPvFdPiKEz4GebFM722KqXYCxoXJ0=
Subject: FAILED: patch "[PATCH] rxrpc: Fix the ACK parser to extract the SACK table for" failed to apply to 6.6-stable tree
To: dhowells@redhat.com,davem@davemloft.net,edumazet@google.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com,michael.bommarito@gmail.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:43:43 +0200
Message-ID: <2026061543-superior-passerby-d597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 333b6d5bb9f87827ac2639c737bf9613dbae7253
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061543-superior-passerby-d597@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 333b6d5bb9f87827ac2639c737bf9613dbae7253 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Thu, 4 Jun 2026 12:46:00 +0100
Subject: [PATCH] rxrpc: Fix the ACK parser to extract the SACK table for
 parsing

Fix modification of the received skbuff in rxrpc_input_soft_acks() and a
potential incorrect access of the buffer in a fragmented UDP packet (the
packet would probably have to be deliberately pre-generated as fragmented)
when AF_RXRPC tries to extract the contents of the SACK table by copying
out the contents of the SACK table into a buffer before attempting to parse

AF_RXRPC assumes that it can just call skb_condense() and then validly
access the SACK table from skb->data and that it will be a flat buffer -
but skb_condense() can silently fail to do anything under some
circumstances.

Note that whilst rxrpc_input_soft_acks() should be able to parse extended
ACKs, the rest of AF_RXRPC doesn't currently support that.

Further, there's then no need to call skb_condense() in rxrpc_input_ack(),
so don't.

Fixes: d57a3a151660 ("rxrpc: Save last ACK's SACK table rather than marking txbufs")
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/r/20260513180907.2061972-1-michael.bommarito@gmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
Link: https://patch.msgid.link/105362.1780573560@warthog.procyon.org.uk
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 24aceb183c2c..ce761466b02d 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -963,23 +963,34 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_txqueue *tq = call->tx_queue;
 	unsigned long extracted = ~0UL;
-	unsigned int nr = 0;
+	unsigned int nr = 0, nsack;
 	rxrpc_seq_t seq = call->acks_hard_ack + 1;
 	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
-	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
+	u8 sack[256] __aligned(sizeof(unsigned long));
+	u8 *acks = sack;
 
 	_enter("%x,%x,%u", tq->qbase, seq, sp->ack.nr_acks);
 
 	while (after(seq, tq->qbase + RXRPC_NR_TXQUEUE - 1))
 		tq = tq->next;
 
+	/* Extract an individual SACK table.  A normal SACK table is up to 255
+	 * bytes with 1 ACK flag per byte, but an extended SACK table can be up
+	 * to 256 bytes with up to 8 ACK/NACK flags per byte.  The ACK flags go
+	 * across all bit 0's then all bit 1's, then all bit 2's, ...
+	 */
+	memset(sack, 0, sizeof(sack));
+	nsack = umin(sp->ack.nr_acks, 256);
+	if (skb_copy_bits(skb,
+			  sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket),
+			  sack, nsack) < 0)
+		return;
+
 	for (unsigned int i = 0; i < sp->ack.nr_acks; i++) {
 		/* Decant ACKs until we hit a txqueue boundary. */
+		if ((i & 255) == 0)
+			acks = sack;
 		shiftr_adv_rotr(acks, extracted);
-		if (i == 256) {
-			acks -= i;
-			i = 0;
-		}
 		seq++;
 		nr++;
 		if ((seq & RXRPC_TXQ_MASK) != 0)
@@ -1117,9 +1128,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	    skb_copy_bits(skb, ioffset, &trailer, sizeof(trailer)) < 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_trailer);
 
-	if (nr_acks > 0)
-		skb_condense(skb);
-
 	call->acks_latest_ts = ktime_get_real();
 	call->acks_hard_ack = hard_ack;
 	call->acks_prev_seq = prev_pkt;

