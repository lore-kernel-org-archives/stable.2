Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473874A4EF4
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106342; cv=none; b=n+hRZhIVfFtJiqevb5Bab5FeLk/YHT1x+BP4175wnz9TR1qka9jMKuwoa+f2khkzWzd2TaogJb+GNhduAA8CL6xDpZRw5ClwW3GOAMcbgq6n4gpEO4kn3/nhXOeNmW3crU/kDlfzrvUhh+BEALSoFMTV6ekL5QyhEwBTqRwhk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106342; c=relaxed/simple;
	bh=bA/Yk356OkMO3nhLS6izNHoCFy29ZvudZLOrI0cm0F0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pagHOLVbS1051kYm2J4/k8pidVdwTf6XgbfgLwPZvG6K4MytVFfFFXGdPkW4yjMYfguGKpwsUljuhgaqFSoZh9NB2afNDj7nA94uHYBJEOAlnsowJDurCbXWjaaN2jsYHLzZlQdu9UKOgfIsuvaSoP9Mj6t6UqQ5+ijzY6+eeD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7t+B667; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7t+B667"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so210107a91.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106340; x=1790711140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAmFjAn7BDIXidXFExZXN4J+D0t0bLYkykmd4bXpEf4=;
        b=p7t+B667tg4V1NJmp0lV4zvnu+2A6YuMLZZrqxjWKf26marScLxzjy+DJUPztfEP/V
         HvNMczO25pZKlT+YZq49v4jEAYB5MXm49vxYGzmgriMW5tgwq++0hKDasCCiAJ9T0Dw5
         gYsEMl1YxYN1cHx0uS6BXFn03IMtMID9nKY1CMRkE5UZTw+tRlak+OLhXP6LYzYns2nT
         WjRgWF0V+ePv0SbPbmXQRr47DRmCIEwnas80nSWjBqiUwtGxB1095nxyriXLz1kmsEnN
         VXBub5a3HuGQRK/kmFAGYfEFrUIpLWOhiJDc4Bl138p3y5Khaa4DCBY1/x1akP42Jp1z
         TwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106340; x=1790711140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eAmFjAn7BDIXidXFExZXN4J+D0t0bLYkykmd4bXpEf4=;
        b=Qrn/B/LuJX9+QiZMTywcWria+ZuoFQcIQDJny7kS2FfNbjUeU4B7w5ce0RqFKZ9e2L
         nJ0qPlxIAOwlOH5cYc+DLvTZQuI1cka+ZPI4FHAs1B2bxhj+4YysJcRIySQJlQu3F8ZW
         T3R6lE8NY6uGLId/52aYuWG05Qk2doh2k7fQUBFLsl7wmXcC0/CI65ZQyrO0PeG1tkCf
         Cu4lUnqvAkKdFTQFjnLR3mz0gldPKsfNeu8MwQwq1ggps/M4jfNCGTnSsG7pFD5bEjxX
         +p8LGecsYfPoh8+WavdTS38OThG7cOsQInkaWwT0bnPceVqpLF+BmmMoExju0uHiVB9r
         sdfg==
X-Forwarded-Encrypted: i=1; AKwUvBxoKhXxkg4BAL+yAjRAsduf5SPUChhmDwUag5Kimo6vPeXsjDtON7ywhzLvM82JRxkwaOJsk+8=@vger.kernel.org
X-Gm-Message-State: AFuF++l23bDNn6/j69YvXhQkvj4sn+zS6Oh3dQ/TCZ6cSUoODeIjKLyd
	JlCHgq/fPzDOPDrisQrhUYa+wQtRdrZDk3RnwgbpsgmwyBN8LbgUov9t65PY0etpQdAWiO3q6gN
	TPM0TLnrTHP5Jog==
X-Received: from plhz4.prod.google.com ([2002:a17:902:d9c4:b0:2df:4c9e:a58d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d984:b0:2da:e967:7953 with SMTP id d9443c01a7336-2df69d28612mr3587035ad.12.1790106340217;
 Tue, 22 Sep 2026 12:45:40 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:25 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-2-joshwash@google.com>
Subject: [PATCH net v2 1/9] gve: increment work_done for XDP and error packets
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The GVE RX NAPI will continue polling as long as

1) there are packets to be processed, and
2) less than NAPI budget SKBs (denoted in GVE by work_done) have been
   passed up to the kernel.

However, GVE does not account for all of the packets that don't create
SKBs, namely error packets and XDP packets.

This can result in XDP programs that scarcely return XDP_PASS failing to
exit the NAPI poll as long as the NIC is DMA'ing packets, possibly
processing the entire RX ring before returning from the NAPI.

This has 3 negative implications:

1) XDP RX path can run much longer than is desirable, hogging CPU
   resources.
2) If XDP_PASS is never returned, the work_done never increases beyond
   0, which can lead to scheduling delays due to missed chances to
   reschedule the NAPI.
3) In AF_XDP zero-copy, XSK_TX occurs after the RX poll. If the RX poll
   takes a long time, it will delay TX, leading to degraded performance.

Ensure every packet is accounted for in work_done by incrementing
work_done before checking for the existence of a SKB.

Fixes: 293b49361f91 ("gve: add XDP DROP and PASS support for DQ")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v2:
  - corrected stat counting for packets relative to work_done
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 5cf242b28557..c3f4a76b0fac 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -932,6 +932,10 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		if (xdp_act != XDP_PASS) {
 			gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp_act,
 					 buf_state);
+			u64_stats_update_begin(&rx->statss);
+			rx->rpackets++;
+			rx->rbytes += compl_desc->packet_len;
+			u64_stats_update_end(&rx->statss);
 			return 0;
 		}
 
@@ -1090,6 +1094,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 	struct gve_rx_ring *rx;
 	struct gve_priv *priv;
 	u64 xdp_redirects;
+	u32 rx_packets = 0;
 	u32 work_done = 0;
 	u64 bytes = 0;
 	u64 xdp_txs;
@@ -1150,13 +1155,14 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 		/* Free running counter of completed descriptors */
 		rx->cnt++;
 
-		if (!rx->ctx.skb_head)
-			continue;
-
 		if (!compl_desc->end_of_packet)
 			continue;
 
 		work_done++;
+
+		if (!rx->ctx.skb_head)
+			continue;
+
 		pkt_bytes = rx->ctx.skb_head->len;
 		/* The ethernet header (first ETH_HLEN bytes) is snipped off
 		 * by eth_type_trans.
@@ -1164,6 +1170,9 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 		if (skb_headlen(rx->ctx.skb_head))
 			pkt_bytes += ETH_HLEN;
 
+		rx_packets++;
+		bytes += pkt_bytes;
+
 		/* gve_rx_complete_skb() will consume skb if successful */
 		if (gve_rx_complete_skb(rx, napi, compl_desc, feat) != 0) {
 			gve_rx_free_skb(napi, rx);
@@ -1173,7 +1182,6 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 			continue;
 		}
 
-		bytes += pkt_bytes;
 		rx->ctx.skb_head = NULL;
 		rx->ctx.skb_tail = NULL;
 	}
@@ -1187,7 +1195,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 	gve_rx_post_buffers_dqo(rx);
 
 	u64_stats_update_begin(&rx->statss);
-	rx->rpackets += work_done;
+	rx->rpackets += rx_packets;
 	rx->rbytes += bytes;
 	u64_stats_update_end(&rx->statss);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

