Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADD3F7AB2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490220; cv=none; b=uKX+amdaAqdPMn7QZXHX1J7hXZMB2NoYqy8O5lRW6XcqTxtCXKTdWQc/L1lklxKcxCQvxB4YxqcmD8Km3vHysWp+jeJ+IcRQu1gs7vew43AE52G3JYkShXSKc2gAQq68ketly5WY6H0Kr2P/rGaHJxr7vPBSauf0z5T+X+gXNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490220; c=relaxed/simple;
	bh=XG0jeXA8nsGHh0Oc2PJNJKUHcL5n/Euh+/NeBpgtqdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNk79v7sgOyZUIgB9DAkQQL6PC/voMLNayem0QjtORdm2Iix/v0Kx9/A0j7wEcOpJQFo1ItsZIRiKvi8tyjcUUaqf6UyJbHsXP7p1NZ+gj5tFrgL+BEI26nxzz2iKrO+rQZPCB5z/7ZALiDMIDn5BgqRejEXM1bIjtgH9PfZ7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=bxB0ebHM; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="bxB0ebHM"
Received: by dvalin.narfation.org (Postfix) id 21F9F20722;
	Fri, 26 Jun 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQdBn7IARfQuiHCHI/41yBrYtv+nbGNI+lUTauKkcdk=;
	b=bxB0ebHMYWfTuz8KGWS7Ei0/zJ9HYJe+UC+FxhzYFGzu35ajhYhXC20vq38XGju5Fef6fq
	t1yaf3jQD1s9WV6z44puJIJANbMqF/a36UNK4HOaO1+hBM2WPyMud3v/EAQRBvY11TwWL3
	IwwZh/uEnzCRWaC8uzTUAn/QJpZN60I=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 18/23] batman-adv: tp_meter: handle overlapping packets
Date: Fri, 26 Jun 2026 18:09:47 +0200
Message-ID: <20260626160952.123713-19-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit cbde75c38b21f022891525078622587ad557b7c1 upstream.

If the size of the packets would change during the transmission, it could
happen that some retries of packets are overlapping. In this case, precise
comparisons of sequence numbers by the receiver would be wrong. It is then
necessary to check if the start sequence number to the end sequence number
("seqno + length") would contain a new range.

If this is the case then this is enough to accept this packet. In all other
cases, the packet still has to be dropped (and not acked).

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Switch to pre-splitted tp_vars structure names ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c01ff6e72b5da..3a1561f579198 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1293,7 +1293,8 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 /**
  * batadv_tp_handle_out_of_order() - store an out of order packet
  * @tp_vars: the private data of the current TP meter session
- * @skb: the buffer containing the received packet
+ * @seqno: sequence number of new received packet
+ * @payload_len: length of the received packet
  *
  * Store the out of order packet in the unacked list for late processing. This
  * packets are kept in this list so that they can be ACKed at once as soon as
@@ -1302,22 +1303,17 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  * Return: true if the packed has been successfully processed, false otherwise
  */
 static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
-					  const struct sk_buff *skb)
+					  u32 seqno, u32 payload_len)
 	__must_hold(&tp_vars->unacked_lock)
 {
-	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_unacked *un, *new;
-	u32 payload_len;
 	bool added = false;
 
 	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	if (unlikely(!new))
 		return false;
 
-	icmp = (struct batadv_icmp_tp_packet *)skb->data;
-
-	new->seqno = ntohl(icmp->seqno);
-	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
+	new->seqno = seqno;
 	new->len = payload_len;
 
 	/* if the list is empty immediately attach this new object */
@@ -1484,7 +1480,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 {
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_vars *tp_vars;
-	size_t packet_size;
+	u32 payload_len;
 	u32 to_ack;
 	u32 seqno;
 
@@ -1519,15 +1515,17 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
 	 */
-	if (batadv_seq_before(seqno, tp_vars->last_recv))
+	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
+	to_ack = seqno + payload_len;
+	if (batadv_seq_before(to_ack, tp_vars->last_recv))
 		goto send_ack;
 
 	/* if the packet is out of order enqueue it */
-	if (ntohl(icmp->seqno) != tp_vars->last_recv) {
+	if (batadv_seq_before(tp_vars->last_recv, seqno)) {
 		/* exit immediately (and do not send any ACK) if the packet has
 		 * not been enqueued correctly
 		 */
-		if (!batadv_tp_handle_out_of_order(tp_vars, skb)) {
+		if (!batadv_tp_handle_out_of_order(tp_vars, seqno, payload_len)) {
 			spin_unlock_bh(&tp_vars->unacked_lock);
 			goto out;
 		}
@@ -1537,8 +1535,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	}
 
 	/* if everything was fine count the ACKed bytes */
-	packet_size = skb->len - sizeof(struct batadv_unicast_packet);
-	tp_vars->last_recv += packet_size;
+	tp_vars->last_recv = to_ack;
 
 	/* check if this ordered message filled a gap.... */
 	batadv_tp_ack_unordered(tp_vars);
-- 
2.47.3

