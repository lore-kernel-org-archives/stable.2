Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497623;
	b=41JTQ1R17t5g8ZOl5qVdBhHZbywJk0pXSRylVwt53OJhUdYZh2lQUl01A4L8Mtw0gXGF
	 c9+7PiQ4z6cYJF43l0h/fMW2InwOjaw4+LkaSuUdkWqZlRt2OpM03LGpLLOxbvlsJ2WKH
	 ia6bkPJc7NARGGZ94jUBVYIfeIv1ictuB0YWrJjHAilF8bCLgnTH6WxIgNCDIKOicMBnU
	 EZH1PsCMHAYuI5f4CJsErTYWN9clpxAmEGul9/jUUzeFd13cIsWCHi1Q3XSkwugf9gGtt
	 vwHMoySyvhuFQryZ30fUMEUCpA1DrgbphdXMthCxoiE/zDBNtsPwl+omcoEIgovAV0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MC71rue+avO5o6pQ9I9Ynejelo3/8d9a+uWMvMZ/yHk=;
	b=NDVdvpCWJcLLXMN7SdD4XdfCoGyPA21t5BNU6odysf+Kx05sjkwyObLnebhhqyost7F1
	 mj38SV7Bmx/O62dcHNq+T8IfUMFNEpP6Cb5SF3prnTj0Znv5YRdHcTy2InWqHZhP2gQM2
	 Rt/hGOFT2uNqrryeb32TSJEMiNNiC0ck9BR7vwLKxWkwPuWUAldRbqMMqB5/bn6MEjKfp
	 Lv7XUiqxh/FMcMOBSdD3bKST0R/I5hJv1CSHwg+qTzrzlwDGNLKUb8kGUB0lbWClM+n7B
	 kW+8rTgzvKYz4YY+5eBNUisfSeX4Ji14PzNPw6vlBykllmwFR/7uXQ+wTDkMEbrIsDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiLgpF+w;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741860A260A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6741860A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiLgpF+w
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4aa3a2a5a15so1898835e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497621; x=1795102421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MC71rue+avO5o6pQ9I9Ynejelo3/8d9a+uWMvMZ/yHk=;
        b=XiLgpF+wPrcYNQ7zwPJcJzmHxwB/F9R5kOMp0/T1dxfvFjQhYEqyRxGyKhhSxosoJP
         k0y4xpY8EgrwFRUku6hx2RCv/rQJcmiiMklmvaP3DdFuuWw5VrplzAO9L5Mwt6oq/+jD
         IYLxTwYdorJ9x0l/xBWU3o3vWTK4X548YCDDv7ot2anr7Q1HFsICfbkpAlzqacye1Y3t
         AgLX6OImAXWTRo4B58taPEnPuiegt/WqazqBlK5EL2xg3Z1zYVyWgUeC544HdIc5gDB/
         CMX4vFPfyqAv1+Qv0XIs7lyWvB6hK/6pX8YR5pHRLGSjVRWRrY6fNy1n3iHAo9IZ/xLt
         Vpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497621; x=1795102421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MC71rue+avO5o6pQ9I9Ynejelo3/8d9a+uWMvMZ/yHk=;
        b=s+8L8KAiNdZBJN4T0kcXk1PaU07nvHkqWHb9qw7nurBVAGQvCOCRVQ+GDrMwGStgYW
         OlNvv3XAok+lp0b7GKOrAIwQo7630TkUQTDMxx4qdzRaqLhVLRtiBVNpQclbKN+w5hKf
         HEkifsc8QE5r4BJ/Fwp9edsx2ulgSVE5hLhs+xWqqCfuQf7b/H7JiggYjZ512wk5Oyqt
         TYcpP0fj7D6VEZChASiPfUGyzYABrWkavYx/NzEKpRgZzhe7VEdY+M8yV+up4ixqmdJJ
         eqwsK2ItSAzLi+GRRz/Hrb+sUfL77ptaIflfjnHM8RZGt4cvv6Mzh5K4/6T8O5sgJgmy
         Mb8A==
X-Forwarded-Encrypted: i=1; AL+hErGKnlDTxCwNJRWKgen5mXK0Sp+a9DfXpIUDwzom3ht/MGtPtiKvV/dDL1mQOLwAgLy5gfqdUDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S2IqBkXCdEtibuqYF8McBcxU0jSdpDOERPcbC8TsVkwBoGwYw
	ZBjRQ6M6u5jfslfA1PWiXUVyzGnL2YaItsdGDi2X/QM5KTHE/5XWwYZ1
X-Gm-Gg: AYBFou3RMVy6wHhZlgbvot7wjZHCsyey1M+05jpeEHHY7VptmAKklw6pET5iCCKnqHL
	aanklFVsAtTUzcFeyuz1Ag35uR+J3S8XI49wR3P3N39xkEoo80bU9zkoPYrQOkOuPDG2XJdhoul
	2QBiesw3j+JQ41h/dDrg8pBuaTpnZJhMYpJOyAayjrVJfzp6US+SRPkRvhTxBD148sqM4DfmxAO
	DcNyWC75knTBFASY1sU0zXhFKp6NLsJ6Bn351LjdjBdc5VZr91Ra+oozxLDmbbRaoZBuPKUvo7a
	Z+3MWLao183X8l/IBjsFkNCWUGm8/IIr+BKMSRmdbNPUTqz/EjbUbbljFKQRlOkhzJy5R4xomih
	XnNGs1QRrh/efM69CS404jiyoKqm4gPhdXx6dyJz4GRjzFbxGZkPEW5V/+ib9+4PbGNaaFZ8uqL
	zrrE2dm2/KNf5X2psbGuQRYeYUxW/lqtKeLJaycJnQ+Agh6cCcbOeOE4/peiIU2YzPuXyXxSXKT
	Rcw7k389AhaUyRIu89zV6D5BN0YmMpKP8Hmdsfq/JcQ9Nj0l/GobZDcmzKIXgBvYxuH5wM+jrei
	20P1dq4ZOZk5ToR312oXLudNFbk0TVeVGHLLoOunHANf6OWFqpdjTZPKToNUnrWiO88A0EvPIWI
	iPmmLYHhRFZTlmse1/CHWxLkkrRXAaFsoODLjPStyxIGGwlZ6xR6Lo+FtRDIQwmKoAf6u4BU8UN
	I0FV97ExYG
X-Received: by 2002:a05:600c:1986:b0:4a1:7dcf:be1f with SMTP id 5b1f17b1804b1-4ba0934e57cmr105777715e9.1.1794497620603;
        Thu, 12 Nov 2026 07:33:40 -0800 (PST)
Received: from L-022584.energy.envision.com (dynamic-093-130-172-139.93.130.pool.telefonica.de. [93.130.172.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08ddbe68sm229331185e9.0.2026.11.12.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:33:40 -0800 (PST)
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
	danishanwar@ti.com,
	richardcochran@gmail.com
Subject: [PATCH net v9 3/4] net: hsr: segment GSO before per-frame forwarding
Date: Thu, 12 Nov 2026 16:33:32 +0100
Message-ID: <20261112153333.20-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112153333.20-1-xiexinet@gmail.com>
References: <20261112153333.20-1-xiexinet@gmail.com>
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
the control block, the headers and the L4 checksum, so a still-shared
input is unshared first, and a head still shared with a clone, for
example from a packet socket, is copied.

Older HSR and PRP senders can pass a whole GSO skb with one tag or one
RCT, for example over tap or virtio. Such aggregates, including locally
destined ones, are now dropped instead of being delivered.

Remove the NETIF_F_GSO_MASK types from the master's hw_features so the
core segments local traffic before ndo_start_xmit(). This also holds
over ports with HSR tag insertion offload, at some cost in performance.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
Integration with net-next: Sebastian's pending series "hsr: Allow to
send packets on specific port and pass the timestamp" (v10) changes
hsr_forward_skb() to take the requested TX port and a has_hsr_header
flag, and keeps seqnr_lock in hsr_dev_xmit() and in the interlink path
of hsr_handle_frame(). With both series:
- keep v10's PTP header parsing in hsr_dev_xmit(), then call
  hsr_forward_input(skb, master, req_tx_port, has_hsr_header) without
  taking seqnr_lock there;
- call hsr_forward_input(skb, port, HSR_PT_NONE, false) from
  hsr_handle_frame(), without the interlink lock;
- add both arguments to hsr_forward_input() and hsr_forward_frame()
  and pass them to hsr_forward_skb() for the skb and for each segment;
- keep both include sets in hsr_forward.c.
A frame with the PTP header is not GSO and takes the single-frame path
under the lock, as in v10. A GSO input with the header is classified
after the pull: with an HSR header it is dropped like any inner HSR/PRP
aggregate, otherwise each segment keeps req_tx_port.
Checked: on net-next fa5196392691 with v10 applied, this series with
the resolution builds without warnings, and on a lockdep kernel
hsr_ptp.sh, the two tests of patch 4 and the existing hsr selftests
pass.

 net/hsr/hsr_device.c  |   6 +-
 net/hsr/hsr_forward.c | 158 ++++++++++++++++++++++++++++++++++++++++++
 net/hsr/hsr_forward.h |   1 +
 net/hsr/hsr_slave.c   |  12 ++--
 4 files changed, 165 insertions(+), 12 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 90ee55eb3c19..5db71b49d08e 100644
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
index 44f6d9c83180..9aefc5f0249f 100644
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
 
@@ -794,3 +797,158 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
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
+	/* Segmentation writes skb->cb, header metadata and the L4
+	 * checksum in the head: work on a private skb if the input is
+	 * still shared, and on a private head if a clone (for example
+	 * from a packet socket) still shares it.
+	 */
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb) {
+		hsr_gso_drop_stat(port);
+		return;
+	}
+	if (skb_cow_head(skb, 0))
+		goto drop;
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
index 666220b24dee..7fe7fa68af9e 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -76,15 +76,11 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
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

