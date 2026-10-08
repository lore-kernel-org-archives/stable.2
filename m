Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E33D093E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486692; cv=none; b=MJluOuz1NkUDg/Vt1t8XBljPJ+Wkn4Cl44tJu0kAT7nrz7pWjntiLraZs/gNh1D7oIRAz9BW6tvLCPbDwOnGcrIpQDEDMysvSg9CPsX3I4xKLMMwlGEFA/qoPGT8pZ+O+ysDKW3kGS8oIAmr7yQ1ZUd11j8gnuNx/ZS7wFYqX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486692; c=relaxed/simple;
	bh=Q6yoQ9eq4EkttbxLXSnMpOXhkceDsmsGDV2AbKMifxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk9a42VlsG2OSsh9A8qchwuFH08wI9ioGvqQ5ftswp6H7Eif56nXcL2O/2oUAkeyz8ZpeROfyleMToIKpkwB53Vf37ODcxejS/OYq2EA8t12KafJOAbk5Opga6UNE2hpADCi2o76QQolFdUI2iHicX4/Fm+5agh5UA9RY226AlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=li+iiRSD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="li+iiRSD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-86aecf49833so733268b3a.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791486689; x=1792091489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRF2kQq5QIZ3bh8wQOV3pq+jZ04dVySkSP0ciDDkwhY=;
        b=li+iiRSD3wkAlZBI9SALOYwUjdowhaBwrKrQHAcNay5PinVdjqlo8DRRqXVGiSk8Z1
         wTJneYqT/gU8MmQZr7UZ4lnRLB9XX0+6JZ8W+aGB+CgjuP0w3bqaLb1+4yuprCYBU80I
         6qqmuDq6cLyfek8COIJAqnNlT/qtneVFi0nonGjyRoM0Gb9wuhNUThhcVWAzGmPN4Mfi
         h1C2oVzZa0CU5iis5y3oqXKGGUgjOCv6DQckbziJQKF1hkUb6JP9uDpsf6MrrwD6544f
         oApffqDPoqgaeBrUhtRNsqKPsY3/5e8Rew/Qws24RDriTcuaHgVLINLqg/sJKlo42rjl
         RVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486689; x=1792091489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRF2kQq5QIZ3bh8wQOV3pq+jZ04dVySkSP0ciDDkwhY=;
        b=DxrfFgkqXPi79GiymSgPyqeh1L8fitsmY0QAwBW1tT+kTqvDZjm0SXvS4VVWZeMmAo
         mefkGImgBq4ZWFkB3BCQ0hhfv6iaFVae+XhUDGZUvstAaw+WzDdrQj0v9yI/0a9Lv/EC
         UurXbUf2hI6fXvACP7z8ukaUfYn75CzTPUba34JZxRMHXBbA0AF5CQbYd5ADHkbR71WG
         gVKT7l0lEjzSmygdWbTcfipjdcLpAWVZsHQpxxYn4K6jalM7XfQnaYZc7v92q4PCg5fe
         3AaXWBI5+JVggMoLYNFi2b3WzqumjuVzZlK+WyH0xarquLouBVo0HbMaLafpb5O44zK8
         cMCA==
X-Forwarded-Encrypted: i=1; AKwUvBz2S+uueCflrfwaiQS5D8zEUQOorpFWzUdgw/w+ik/Zm/whPcap4eMksIbBH3HnJHP1VIu0YOA=@vger.kernel.org
X-Gm-Message-State: AFuF++nMxzmOX1tw1PrXS+dcWm4vlTRjvqSiyNP9hLF9lRqAk0rlxItY
	pgk1ORf5Is5SyNZ/j//dtLzdbr6/4LCG7QTrQ/HDHpoYirTXe5zIFghRAb14kLj6Ga8=
X-Gm-Gg: AYBFou3oSM/rojQ5qQ85WeKmxpcsmSw35gP/hRwCZgr78+T/V5nV3FkJYLOWbojhHfK
	fKdR7XUbfQKz/AfdelDKl2VevaM/nxyhPEgtwFcc1V9NweHd+GmpgDAZgBAUP+i4uFxtDVJiCtW
	dynU+EKwfI20FCsJJjw8GPjlbs3zHMKh8lpwovCPjjPJSbbjPpq8w1UUGjqxt5DQtnvC82Bn5bB
	/rUn//vcrr8kZIWHb82GW4Rc+RcO3r0fY8Gy37vwyhWxPcgU7f/u/sec+qMT6ISQ91I3nPJ6l8e
	RstQvs6Hd+FCo0LAHNuMOixTY1Dil2sx3ETH16u4JSpQjklACO7ylInuA5mdd206Lcg5km91BGc
	isrZ7hzlmGbx58f1Y2IANyaoq+UkzX8X172ZWetWXuXmBYDJo6LTHzt59VgyFZoAQ0UocOumOiS
	+4c7ikjIkC8kciXgaZ8zd9Ybf4SbUtmaNwSeAvwY6J/3GNDGheHlMlATbWL08DsHK4zZHsmc0qe
	6yZEGPley0L
X-Received: by 2002:a05:6a00:88e:b0:854:b3d3:8631 with SMTP id d2e1a72fcca58-8969540571bmr177761b3a.12.1791486688789;
        Thu, 08 Oct 2026 12:11:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c44a405dsm34246b3a.49.2026.10.08.12.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:11:28 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE
Date: Thu,  8 Oct 2026 12:11:12 -0700
Message-ID: <20261008191114.3736826-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008191114.3736826-1-joe@dama.to>
References: <20261008191114.3736826-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each SW USO segment is hdr_len + seg_payload bytes. With IPv4, hdr_len
is 42 bytes, so a segment carrying less than 10 bytes of UDP payload is
sent shorter than BNXT_MIN_PKT_SIZE. This happens with a short last
segment (e.g. gso_size 1400 and 1405 bytes of payload) or with a
gso_size below 10 bytes.

Fix the short last segment in bnxt_sw_udp_gso_xmit(): zero the pad
bytes after the header in the segment's inline header slot and add a
pad BD pointing at them after the payload BDs. Only the last segment
can need padding, and its pad BD fits within the existing bound in
bds_needed and BNXT_SW_USO_MAX_DESCS, since payload BDs are at most
num_segs + nr_frags.

If gso_size itself is too small, every segment would need a pad BD,
exceeding the descriptor bound. This case is unlikely, so
bnxt_features_check() clears GSO features for these skbs and the stack
segments them instead; bnxt_start_xmit() then pads each segment.

Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 12 ++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 23 +++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 15 ++++++++++++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 15a8349ccf7b..d766dd469797 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14268,6 +14268,18 @@ static netdev_features_t bnxt_features_check(struct sk_buff *skb,
 	u8 *l4_proto;
 
 	features = vlan_features_check(skb, features);
+
+	/* SW USO pads at most the last segment; let the stack segment skbs
+	 * where every segment would be shorter than BNXT_MIN_PKT_SIZE.
+	 */
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
+	    bnxt_sw_gso_pad_len(skb_transport_offset(skb) +
+				sizeof(struct udphdr),
+				skb_shinfo(skb)->gso_size))
+		features &= ~NETIF_F_GSO_MASK;
+
 	switch (vlan_get_protocol(skb)) {
 	case htons(ETH_P_IP):
 		if (!skb->encapsulation)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index ef04c9d08066..f87e02ef3033 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -82,11 +82,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	if (unlikely(num_segs <= 1))
 		goto drop;
 
+	if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
+		goto drop;
+
 	/* Upper bound on the number of descriptors needed.
 	 *
 	 * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
 	 * at most num_segs + nr_frags (each frag boundary crossing adds at
-	 * most 1 extra BD).
+	 * most 1 extra BD). The last segment may need 1 pad BD.
 	 */
 	bds_needed = 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
 
@@ -133,12 +136,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		dma_addr_t dma_addr;
 		struct tx_bd *txbd;
 		struct udphdr *uh;
+		unsigned int pad;
 		void *this_hdr;
 		int bd_count;
 		bool last;
 		u32 flags;
 
 		last = (i == num_segs - 1);
+		pad = bnxt_sw_gso_pad_len(hdr_len, seg_payload);
 		offset = slot * TSO_HEADER_SIZE;
 		this_hdr = txr->tx_inline_buf + offset;
 		this_hdr_dma = txr->tx_inline_dma + offset;
@@ -156,10 +161,18 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			iph->check = 0;
 		}
 
+		/* Pad bytes follow the header in the inline slot. Zero them
+		 * so stale header bytes from an earlier packet are not sent.
+		 */
+		if (pad)
+			memset(this_hdr + hdr_len, 0, pad);
+
 		dma_sync_single_for_device(&pdev->dev, this_hdr_dma,
-					   hdr_len, DMA_TO_DEVICE);
+					   hdr_len + pad, DMA_TO_DEVICE);
 
 		bd_count = tso_dma_map_count(&map, seg_payload);
+		if (pad)
+			bd_count++;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
@@ -222,6 +235,12 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			seg_payload -= chunk_len;
 		}
 
+		if (pad) {
+			prod = NEXT_TX(prod);
+			txbd = bnxt_sw_gso_data_bd(bp, txr, prod,
+						   this_hdr_dma + hdr_len, pad);
+		}
+
 		txbd->tx_bd_len_flags_type |=
 			cpu_to_le32(TX_BD_FLAGS_PACKET_END);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
index 77d9af97cc22..5916ee08c0e6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -19,10 +19,25 @@
  * Each segment: 1 long BD + 1 ext BD + payload BDs.
  * Total payload BDs across all segs <= num_segs + nr_frags (each frag
  * boundary crossing adds at most 1 extra BD).
+ * The last segment may need 1 pad BD (see bnxt_sw_gso_pad_len()).
  * So: 3 * max_segs + MAX_SKB_FRAGS + 1 = 3 * 64 + 17 + 1 = 210.
  */
 #define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
 
+/* Bytes of padding needed to bring a segment carrying @seg_payload bytes
+ * up to BNXT_MIN_PKT_SIZE, or 0 if no padding is needed.
+ */
+static inline unsigned int bnxt_sw_gso_pad_len(unsigned int hdr_len,
+					       unsigned int seg_payload)
+{
+	unsigned int len = hdr_len + seg_payload;
+
+	if (len < BNXT_MIN_PKT_SIZE)
+		return BNXT_MIN_PKT_SIZE - len;
+	else
+		return 0;
+}
+
 static inline u16 bnxt_inline_avail(struct bnxt_tx_ring_info *txr)
 {
 	return BNXT_SW_USO_MAX_SEGS -
-- 
2.53.0-Meta

