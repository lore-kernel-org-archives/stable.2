Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CC3F9F47
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490277; cv=none; b=V+ML9WZUnvMftu1JWrd5+K0EAiDiL4NNWWRxHdiuB7VDOWegJogTWXWblYlw2xlEotMrpyaJxutDCEBszZLeB4bKt7lQRK0013RjzEIahZ1+EXmAtnaTYcFMtNd4dO82RCEuts9be1abMpjVl5QvO13gtpsCKZ/COAd5Zm/EHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490277; c=relaxed/simple;
	bh=1BwjrX4d9TQ4HOSyS+R9Fx1ATE0nJ6Elp3x7aI9r2rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHxumoZmpq2CT3ZW+RrmwAqSY4cpyAJD+2zpt0hew1NhXnhpnHMPw/seZkGwDN92joniz2xIPIXLMo+n37W47jwBZQpAF3DCAJeHyzaGFJ6tza8myaKnzOEZK21oIebsd0FoaQbLRTf9r2mqWQtKpc7JCbf3cMK4Pc7PxBnXrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=J4orESMl; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="J4orESMl"
Received: by dvalin.narfation.org (Postfix) id 6E0EA2045E;
	Fri, 26 Jun 2026 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnVHaRtOQMZCP1WT5rlP6T01FlYo23zVmLK34ujQlZk=;
	b=J4orESMl9MLwySKJUkijobk/6oi+soH9yxTBATZ/LjNj2sWSROsEoYkD27deN2SubB9lPx
	pvdBGaqtnaa9P+08qwSGKwo57PTAhxdct2g1xRhMax4IA6E9eG37tjn7bUOf+KzE7o8YS7
	2A81e47Qrw81TX0mjJiS93duIR2tcVo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 20/25] batman-adv: tp_meter: handle overlapping packets
Date: Fri, 26 Jun 2026 18:10:59 +0200
Message-ID: <20260626161105.124113-21-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161105.124113-1-sven@narfation.org>
References: <20260626161105.124113-1-sven@narfation.org>
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
index 83749d7b4fd11..5514fef54b0a9 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1284,7 +1284,8 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 /**
  * batadv_tp_handle_out_of_order() - store an out of order packet
  * @tp_vars: the private data of the current TP meter session
- * @skb: the buffer containing the received packet
+ * @seqno: sequence number of new received packet
+ * @payload_len: length of the received packet
  *
  * Store the out of order packet in the unacked list for late processing. This
  * packets are kept in this list so that they can be ACKed at once as soon as
@@ -1293,22 +1294,17 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
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
@@ -1476,7 +1472,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 {
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_vars *tp_vars;
-	size_t packet_size;
+	u32 payload_len;
 	u32 to_ack;
 	u32 seqno;
 
@@ -1511,15 +1507,17 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
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
@@ -1529,8 +1527,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	}
 
 	/* if everything was fine count the ACKed bytes */
-	packet_size = skb->len - sizeof(struct batadv_unicast_packet);
-	tp_vars->last_recv += packet_size;
+	tp_vars->last_recv = to_ack;
 
 	/* check if this ordered message filled a gap.... */
 	batadv_tp_ack_unordered(tp_vars);
-- 
2.47.3

