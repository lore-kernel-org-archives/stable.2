Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794089159;
	b=rLTbUjUfhFNk532Mw1YC3JOp5p2LEcAjSl0/n6Oi/fc3KmwybIf242fjTN5KxBZNAR6q
	 U5teFcAxsYr13KcdjsJrLb+5HxrbvHGMWFqCr9ortuWCcSir+3NVQTG1cHy6JxdHFuKpl
	 VFteY1kLJdjOEzWjDW/jQBXVz3Vw4jqwD7HOGkjstzmSUjhIWwvBpmZUNHR8IkTfpEdRD
	 9llxjG/9wIDgpYlfSQZjHhlBweCueXXV/r++qFDCSevNqVGfs/yhPwfdzB1Gsg9tcz5AC
	 3FXZRc35c1PmddL8ImgoS7GFPiR2U5phsJkF4mVC/nY7AJRDyBCoXJDFV1q7PM1GA8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QWbbx5vg8nOFhvTmkBnsiCSh4TO5tOsUHcVmDxiG/Qc=;
	b=IKviXdl5m6pwNLZnj4ssKA0KYOKUApwy1qUUmfzA5b9uhEgx56LQtiEEieU3TbsQKK4I
	 tc9cHQVo74yAdod+4GMbfeP63sJMAVwm35u8dnEPpSmDK8rgXBeBz+/drInf9yuAiap9u
	 93qANhNtCT/3ZL41I9bPT4Dg+19XK54xCYKoZYJ07pFoDmTNl1QhE67Pj/m3gkN+RpUxD
	 g54rz7pqoLR5tpZsI1tDOwotrucSJip3feqAmORJTT3pmXu+fDaVMGvZPH2/iiZguvUdK
	 5NpN4BXEW8MOHUAP1R4QzTK9W5Wx0WQImbxhPji2y/1YdrIhQ/OftDlH6uPfN8Y97og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AOY/It6c";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22863606D815
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22863606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AOY/It6c
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso114975e9.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794089157; x=1794693957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWbbx5vg8nOFhvTmkBnsiCSh4TO5tOsUHcVmDxiG/Qc=;
        b=AOY/It6c0Jbens12x+2TK/HJ0pBEaL3yqYZwBcWNHBRV1APPhyGK0OfBdFq3EBn5G0
         T6+q9yIF4EEyOctQwXrFFSqyE/AX0lD1yvRe4Jnt5aUGwH3eAnrcu4mC/v09gr1jCfV8
         a/wMV1bV9PO8hlIKncXT+MAcbEaBZ685TEEmWBT9yzsDUug9R/J4MUC4ku8gIE6IdKDT
         40wr1+Xmyxr0oWZf5ljUJ/lqwzhQDq/ph1f54+eFmUINlrXITYWbd0XhYonBazc1E/tJ
         5Or3K4cfxDWyjPnDDrsiL/F9Y+oF9/luv+s6JH/1mxbSCJ8xRQWg00x+a4zedCUDwTMm
         BPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089157; x=1794693957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWbbx5vg8nOFhvTmkBnsiCSh4TO5tOsUHcVmDxiG/Qc=;
        b=uk4OCwoA573FZwI/SRgtU5asSD+Cx5MIGsO656QBmOZ3DmR8EESqLPre3v2eT7y2TG
         QJX8/cxiv6ImF6o816gY6CWVkwAiVAhWCRBDYRm+rnz5ebR9XQp/xknJy7b1m69bRKfV
         e1/L6DCqfkx87/WCWYVKYAszXD9teSR00gAiou9YPaLYZgwXYy0lkiN0o8yen8LowcOz
         MEo8TybXTR7LhyDBBIu4cNu41WvqhvczSHFkbpVWQS1VyYdP25NhQwGqxeGgTvCSW3UY
         sggXbmDj6+LSO/JfU2FM7bgXNRGaBIPAo3tseIsLyVpHyNrZcmoI2H1+v9xPil7YFVXd
         YwlA==
X-Forwarded-Encrypted: i=1; AL+hErHGAwCME5VOlCXifuA9VFTbzCr5cgUvb4Pnz7/skGbdBwf5mG4F73pSX/ShODQHkvgJH7UvyDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yZVpZ/AoelO3owsnQLCyTS1MJ8swwP88y/64NH6oqwbP6i6qv
	VXGd/SqWjqhXHkMtk80ZP/CicC4LM5xqMu2Z9SVtAny9IpqREyxQ7bRj
X-Gm-Gg: AYBFou15YpEI8NEwWFGu/U9hr9SZU7pMr4aGWTSkbstMGurv7CJCVGtgx3lGKEYkOEq
	mNcNUq4pnsOtl7Uu1619OWLMtzAGa/yrGXWYjruSp7TfA7DwkPWI/psDjtjqgGkvYoBLmqan3FK
	sCm/KoRO3hskpVExWqiaIHfgLODs3A276r8Ja09VupW8GFsD7MSFkACMS+qUUa0MuH7ZMJD4BCH
	cb898rZXBwVS4v1MaLOrxalGleTuuVbufZVP2iz8tYrqsR3BolSxORZHfV8oFNJkll3NMTP8E1i
	5BdEnwaC5uQB9UkP99wJNb7W34K4S1DBjD9vGDaHQgMe9xsCNr1rAKR1jCKzY7aw/0eaolCfSMI
	Ke+gfw9536AG+Qsgk27HuOs7uCMNWxg/VHQY7JcdokyhKhKm1by5SRToIlGxiIdtPQc2yQQA2Ue
	W5W/cmEOPnmHlprP96KI44vW+I/tz+vQgRTtIWPngyveQYxb1HG5sdQ07OoHb2DXfVsn68IF8iT
	kICeaYu+0YdU3fL4KKzkVJu6vo4VhLVf20U6Xp5sykc4Clhsm+k3eSo5x+QpnW4SL+zxuZeoZnK
	pFHR5eqjndXzzRpuXc5lSlNbLZnMN/m6TBxdyIXE8RSOKwN9DwwF+O3A/O5KnSY7IFHEL5QZb5l
	5ULqb+v0DOABWSPzU93FyuiV4ObxL1xWIQLCnt1sUIcnwUXshNnj3iyxznjXTigg=
X-Received: by 2002:adf:e198:0:b0:48c:698b:502c with SMTP id ffacd0b85a97d-4958026fbc0mr463721f8f.1.1794089157401;
        Sat, 07 Nov 2026 14:05:57 -0800 (PST)
Received: from L-022584.energy.envision.com (dynamic-077-189-161-157.77.189.pool.telefonica.de. [77.189.161.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597b1f969sm358958f8f.50.2026.11.07.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 14:05:56 -0800 (PST)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	xiexinet@gmail.com,
	lukma@denx.de,
	fmancera@suse.de,
	danishanwar@ti.com
Subject: [PATCH net v8 3/4] net: hsr: segment GSO before per-frame forwarding
Date: Sat,  7 Nov 2026 23:05:42 +0100
Message-ID: <20261107220544.20-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107220544.20-1-xiexinet@gmail.com>
References: <20261107220544.20-1-xiexinet@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR and PRP tag and de-duplicate each wire frame separately. A GSO
super-packet reaching the forwarding path hides several wire frames,
which cannot be tagged or numbered per frame. Such skbs reach a member
even with GRO off, for example from a container or VM attached through
veth, tap or virtio to a software RedBox, or from a member whose GRO_HW
cannot be turned off.

Add one forwarding entry, hsr_forward_input(), for master TX and for
frames received on any port. It segments GSO input outside seqnr_lock;
each segment is then numbered and submitted under the lock, one frame
at a time as before, and follows the normal forwarding and local
delivery paths. Master TX and interlink RX now take the lock there
instead of in their callers.

Classify by the effective inner protocol with the core's bounded VLAN
decoder (802.1Q, 802.1AD, nested or accelerated). Drop aggregates with
inner HSR/PRP, unreadable fragments or undecodable headers, and IPv4
or IPv6 aggregates whose nonzero IP length ends before the skb does,
since the trailing bytes would become segment payload. GSO_PARTIAL and
zero IP lengths are left to the segmenter. Drops are counted once on
the entry device in the core per-CPU drop counters. Segmentation writes
the control block and headers, so a still-shared input is unshared
first.

Older PRP senders can append one RCT to a whole GSO skb. Such
aggregates, including locally destined ones, are now dropped instead
of being delivered.

Remove the NETIF_F_GSO_MASK types from the master's hw_features so the
core segments local traffic before ndo_start_xmit().

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  |   6 +-
 net/hsr/hsr_forward.c | 154 ++++++++++++++++++++++++++++++++++++++++++
 net/hsr/hsr_forward.h |   1 +
 net/hsr/hsr_slave.c   |  12 ++--
 4 files changed, 161 insertions(+), 12 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index fc512204600c..2521a72280ac 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
+		hsr_forward_input(skb, master);
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
@@ -686,7 +684,7 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
-			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
+			   NETIF_F_HW_CSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 44f6d9c83180..c9cd5d920879 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,6 +12,9 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/gso.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
@@ -794,3 +797,154 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	port->dev->stats.tx_dropped++;
 	kfree_skb(skb);
 }
+
+/* Master TX and interlink RX are numbered locally: number and submit
+ * one frame at a time under seqnr_lock, as before. LAN A/B input
+ * keeps its received number and needs no lock.
+ */
+static void hsr_forward_frame(struct sk_buff *skb, struct hsr_port *port)
+{
+	struct hsr_priv *hsr = port->hsr;
+	bool numbered = port->type == HSR_PT_MASTER ||
+			port->type == HSR_PT_INTERLINK;
+
+	if (numbered)
+		spin_lock_bh(&hsr->seqnr_lock);
+	hsr_forward_skb(skb, port);
+	if (numbered)
+		spin_unlock_bh(&hsr->seqnr_lock);
+}
+
+/* One count per rejected GSO input on its entry device. */
+static void hsr_gso_drop_stat(struct hsr_port *port)
+{
+	if (port->type == HSR_PT_MASTER)
+		dev_core_stats_tx_dropped_inc(port->dev);
+	else
+		dev_core_stats_rx_dropped_inc(port->dev);
+}
+
+/* Return the inner EtherType using the core's bounded 802.1Q/802.1AD
+ * decoder. An accelerated outer tag is metadata, not frame bytes.
+ */
+static __be16 hsr_gso_effective_proto(const struct sk_buff *skb, int *l3off)
+{
+	struct ethhdr eh;
+	const struct ethhdr *eth;
+
+	if (skb_vlan_tag_present(skb) &&
+	    !eth_type_vlan(skb->vlan_proto))
+		return 0;
+
+	eth = skb_header_pointer(skb, 0, sizeof(eh), &eh);
+	if (!eth)
+		return 0;
+
+	return __vlan_get_protocol(skb, eth->h_proto, l3off);
+}
+
+/* Bytes beyond the IP datagram must not become segment payload. Older
+ * PRP senders can append an RCT to a whole GSO skb. Zero IP lengths and
+ * GSO_PARTIAL headers do not provide the full aggregate length here.
+ */
+static bool hsr_gso_trailing_data(const struct sk_buff *skb, __be16 proto,
+				  int l3off)
+{
+	unsigned int l3len;
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL)
+		return false;
+
+	if (proto == htons(ETH_P_IP)) {
+		struct iphdr buffer;
+		const struct iphdr *iph;
+
+		iph = skb_header_pointer(skb, l3off, sizeof(buffer), &buffer);
+		if (!iph)
+			return true;
+		l3len = ntohs(iph->tot_len);
+	} else if (proto == htons(ETH_P_IPV6)) {
+		struct ipv6hdr buffer;
+		const struct ipv6hdr *ip6h;
+
+		ip6h = skb_header_pointer(skb, l3off, sizeof(buffer), &buffer);
+		if (!ip6h)
+			return true;
+		l3len = ntohs(ip6h->payload_len);
+		if (l3len)
+			l3len += sizeof(*ip6h);
+	} else {
+		return false;
+	}
+
+	return l3len && l3off + l3len < skb->len;
+}
+
+/* Unfold GSO super-packets before per-frame processing so that each
+ * wire frame gets its own HSR tag or PRP RCT and sequence number.
+ * Segmentation runs outside seqnr_lock; every segment is numbered and
+ * submitted under it like any other frame.
+ */
+void hsr_forward_input(struct sk_buff *skb, struct hsr_port *port)
+{
+	struct sk_buff *segs, *next;
+	__be16 proto;
+	int l3off;
+
+	if (likely(!skb_is_gso(skb))) {
+		hsr_forward_frame(skb, port);
+		return;
+	}
+
+	/* The gate is content-based, not port-based. An aggregate
+	 * whose effective protocol is ETH_P_HSR or ETH_P_PRP cannot be
+	 * segmented safely and is dropped, as is any skb whose headers
+	 * cannot be read or that is marked unreadable (net_iov device
+	 * memory): software segmentation cannot read its payload, so
+	 * each segment would carry uninitialized data. Ordinary VLAN
+	 * GSO (802.1Q/802.1AD at any reachable tag depth, accelerated
+	 * or in-band) is classified to its inner protocol through the
+	 * core VLAN decoder and segmented like plain input. With
+	 * NETIF_F_HW_HSR_TAG_RM the lower has already stripped the tag,
+	 * so such aggregates arrive plain.
+	 */
+	if (!skb_frags_readable(skb))
+		goto drop;
+	proto = hsr_gso_effective_proto(skb, &l3off);
+	if (!proto)
+		goto drop;
+	if (proto == htons(ETH_P_HSR) || proto == htons(ETH_P_PRP))
+		goto drop;
+	if (hsr_gso_trailing_data(skb, proto, l3off))
+		goto drop;
+
+	/* Segmentation writes skb->cb and header metadata: work on a
+	 * private skb if the input is still shared with a packet socket.
+	 */
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb) {
+		hsr_gso_drop_stat(port);
+		return;
+	}
+
+	/* features = 0 requests full software segmentation into single
+	 * wire frames; tx_path is true only for locally generated
+	 * traffic on the master.
+	 */
+	segs = __skb_gso_segment(skb, 0, port->type == HSR_PT_MASTER, 0);
+	if (IS_ERR_OR_NULL(segs))
+		goto drop;
+
+	consume_skb(skb);
+	while (segs) {
+		next = segs->next;
+		segs->next = NULL;
+		hsr_forward_frame(segs, port);
+		segs = next;
+	}
+	return;
+
+drop:
+	hsr_gso_drop_stat(port);
+	kfree_skb(skb);
+}
diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
index 206636750b30..ec08c4330259 100644
--- a/net/hsr/hsr_forward.h
+++ b/net/hsr/hsr_forward.h
@@ -14,6 +14,7 @@
 #include "hsr_main.h"
 
 void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
+void hsr_forward_input(struct sk_buff *skb, struct hsr_port *port);
 struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 					struct hsr_port *port);
 struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 26f16d98e479..73f4e555e18e 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -75,15 +75,11 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	skb_reset_mac_len(skb);
 
 	/* Only the frames received over the interlink port will assign a
-	 * sequence number and require synchronisation vs other sender.
+	 * sequence number and require synchronisation vs other sender;
+	 * hsr_forward_input() takes seqnr_lock for them, one frame at a
+	 * time.
 	 */
-	if (port->type == HSR_PT_INTERLINK) {
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
-		spin_unlock_bh(&hsr->seqnr_lock);
-	} else {
-		hsr_forward_skb(skb, port);
-	}
+	hsr_forward_input(skb, port);
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;
-- 
2.53.0

