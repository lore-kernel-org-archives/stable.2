Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841E407CFC;
	Thu,  9 Jul 2026 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593326; cv=none; b=VKedQa0GsjAPOJKqPhv1jzjYws3ZVgIq9p1HcASNsDCw0CRKl8zsK0cZjszfKwGyM1TPd6SsHMKE1GzTrP+0UQEKVlEo1sZZqp8zJDJC3v9KDxwL/fa/qRYuHa7BpeWFHXs5WrZJka6eieMIacdJWTfCRrEH0/Hr9HN9mhbfSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593326; c=relaxed/simple;
	bh=T1Y62vu2ZHhJDKqhNGFRRkiCxMTg26VdyIso6kwxcUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmmGBwW7KtHbKxxoSu/zrn61vBxmVSbUWugBJmKg6QqV3aZ7q5ljXskFRs+PgVPjbnc5faAxLDJholse2y4dZC/H2n9sa+8siJIi5cvnuoE8o4UNX2xxy+pAYn9KzRrL174Q3dLH28TIiWRzlOawODdqZ2kBQwa9IDNgPwPI+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IlaLYaM4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IlaLYaM4"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 669AYxIqA2991601, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783593299; bh=VoxrNT8BayOuGdFA09LCSb7weOY+l4w15zoWU0H1cZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=IlaLYaM4dONGqiQ/DkFd4JlN9qb5g5w5qDfr8TsEM0IkBSWFL+4ZNEw1FmCBfZunO
	 GOxEiVEpXvs8jquJNvKf3IyB6v9gT627uIGbcnESdlMdx+sQhQNPl5pqrbINFx/NM6
	 wWA0LvXU3AADmRcxOvnT9BLlLb9+giBz+uVqOrKTiVmO1/X7qDt4o5Ez/2fM2JH1J6
	 Bs4/XjLMoVJgn94nl/sO7w5ns72Rvg6YziTr3DV6Ws1E2E605WIAAcVxy87WwdVgrc
	 ThHXxTu/cF1gJ49Yur7NNzzi0agvc0UQau3t+4d6Np4wauGf5D8VuZDrMGqz0Yy4nY
	 ggSchzGeyV8AA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 669AYxIqA2991601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 18:34:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Jul 2026 18:34:59 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Jul 2026 18:34:58 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Jul 2026 18:34:58 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, <horms@kernel.org>,
	<richardcochran@gmail.com>, <david.laight.linux@gmail.com>,
	<aleksander.lobakin@intel.com>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v5] rtase: Workaround for TX hang caused by hardware packet parsing
Date: Thu, 9 Jul 2026 18:34:56 +0800
Message-ID: <20260709103456.83789-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The hardware performs packet parsing before packet transmission.
Parsing incomplete IPv4, IPv6, TCP, or UDP headers may trigger a TX
hang because the hardware parser expects additional protocol header
data that is not present in the packet.

The hardware performs additional PTP parsing on UDP packets identified
by destination ports 319/320 at the expected UDP destination port
offset.

If such a packet has transport data smaller than RTASE_MIN_PAD_LEN,
the hardware parser expects additional packet data and may trigger a
TX hang.

To avoid these hardware issues, the driver applies the following
workarounds.

Drop malformed packets that may trigger this hardware issue before
transmission.

For IPv4 non-initial fragments, the hardware does not check the
fragment offset before parsing the expected transport header location.
As a result, these packets are still subject to transport header
parsing even though they do not contain a transport header. If the
transport data is shorter than the minimum transport header required
by the hardware parser, pad the transport data to the minimum
transport header length required by the hardware parser. Packets that
also match the hardware PTP parsing conditions continue to follow the
corresponding workaround.

For IPv6 fragmented packets, neither of the above hardware issues
occurs because the hardware only continues packet parsing when the
IPv6 Base Header Next Header field directly indicates UDP. Packets
carrying a Fragment Header do not continue through the subsequent
packet parsing stages.

For packets identified for hardware PTP parsing, pad the transport
data so it reaches RTASE_MIN_PAD_LEN before transmission.

Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
v4 -> v5:
- Drop packets that may trigger a TX hang during hardware packet
  parsing.
- Pad IPv4 non-initial fragments when the transport data is shorter
  than the minimum transport header required by the hardware parser.

v3 -> v4:
- Derive the L3 protocol and network offset from Ethernet/VLAN
headers instead of relying on vlan_get_protocol().
- Reject malformed packets when the computed UDP offset exceeds
skb->len.

v2 -> v3:
- Remove dependency on skb_transport_header_was_set().
- Determine UDP header offset from IPv4/IPv6 headers.
- Use skb_header_pointer() for UDP header access.
- Add non-linear skb handling.

v1 -> v2:
- Remove RTASE_SHORT_PKT_THRESH and the packet length check.
- Check transport data length before parsing the UDP header.
- Add Fixes tag.
- Add Cc: stable@vger.kernel.org.
- Target net tree.
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |   8 +
 .../net/ethernet/realtek/rtase/rtase_main.c   | 197 ++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 9bd6872474c1..03b12d83f6e9 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -192,6 +192,12 @@ enum rtase_sw_flag_content {
 	RTASE_SWF_MSIX_ENABLED = BIT(2),
 };
 
+enum rtase_parse_result {
+	RTASE_PARSE_OK,
+	RTASE_PARSE_SKIP,
+	RTASE_PARSE_DROP,
+};
+
 #define RSVD_MASK 0x3FFFC000
 
 struct rtase_tx_desc {
@@ -363,4 +369,6 @@ struct rtase_private {
 
 #define RTASE_MSS_MASK GENMASK(28, 18)
 
+#define RTASE_MIN_PAD_LEN 47
+
 #endif /* RTASE_H */
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 255667775f0e..4168ad9e48ea 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -61,6 +61,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
+#include <linux/ptp_classify.h>
 #include <linux/rtnetlink.h>
 #include <linux/tcp.h>
 #include <asm/irq.h>
@@ -1252,6 +1253,199 @@ static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
 	return csum_cmd;
 }
 
+static enum rtase_parse_result rtase_get_l3_proto(struct sk_buff *skb,
+						  __be16 *proto,
+						  u32 *network_offset)
+{
+	struct vlan_hdr *vh, _vh;
+	struct ethhdr *eh, _eh;
+	u32 offset = ETH_HLEN;
+
+	eh = skb_header_pointer(skb, 0, sizeof(_eh), &_eh);
+	if (!eh)
+		return RTASE_PARSE_DROP;
+
+	*proto = eh->h_proto;
+
+	while (eth_type_vlan(*proto)) {
+		vh = skb_header_pointer(skb, offset, sizeof(_vh), &_vh);
+		if (!vh)
+			return RTASE_PARSE_DROP;
+
+		*proto = vh->h_vlan_encapsulated_proto;
+		offset += VLAN_HLEN;
+	}
+
+	*network_offset = offset;
+
+	return RTASE_PARSE_OK;
+}
+
+static bool rtase_pad_to_transport_len(struct sk_buff *skb,
+				       u32 transport_offset,
+				       u32 pad_to_len)
+{
+	u32 trans_data_len;
+	u32 pad_len;
+
+	trans_data_len = skb->len - transport_offset;
+	if (trans_data_len >= pad_to_len)
+		return true;
+
+	if (skb_is_nonlinear(skb)) {
+		if (skb_linearize(skb))
+			return false;
+	}
+
+	pad_len = pad_to_len - trans_data_len;
+	if (__skb_put_padto(skb, skb->len + pad_len, false))
+		return false;
+
+	return true;
+}
+
+static enum rtase_parse_result rtase_get_transport_offset(struct sk_buff *skb,
+							  u32 *transport_offset,
+							  u8 *transport_proto,
+							  u32 *pad_to_len)
+{
+	enum rtase_parse_result ret;
+	struct ipv6hdr *i6h, _i6h;
+	struct iphdr *ih, _ih;
+	bool non_first_frag;
+	__be16 proto;
+	u32 offset;
+	u32 no;
+
+	ret = rtase_get_l3_proto(skb, &proto, &no);
+	if (ret != RTASE_PARSE_OK)
+		return ret;
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
+		if (!ih)
+			return RTASE_PARSE_DROP;
+
+		if (ih->ihl < 5)
+			return RTASE_PARSE_DROP;
+
+		offset = no + ih->ihl * 4;
+		if (offset > skb->len)
+			return RTASE_PARSE_DROP;
+
+		non_first_frag = ntohs(ih->frag_off) & IP_OFFSET;
+
+		if (ih->protocol == IPPROTO_TCP) {
+			if (skb->len - offset < sizeof(struct tcphdr)) {
+				if (non_first_frag) {
+					*transport_offset = offset;
+					*transport_proto = IPPROTO_TCP;
+					*pad_to_len = sizeof(struct tcphdr);
+
+					return RTASE_PARSE_OK;
+				}
+
+				return RTASE_PARSE_DROP;
+			}
+
+			return RTASE_PARSE_SKIP;
+		}
+
+		if (ih->protocol != IPPROTO_UDP)
+			return RTASE_PARSE_SKIP;
+
+		*transport_offset = offset;
+		*transport_proto = IPPROTO_UDP;
+
+		if (skb->len - offset < sizeof(struct udphdr)) {
+			if (non_first_frag) {
+				*pad_to_len = sizeof(struct udphdr);
+
+				return RTASE_PARSE_OK;
+			}
+
+			return RTASE_PARSE_DROP;
+		}
+
+		return RTASE_PARSE_OK;
+
+	case htons(ETH_P_IPV6):
+		i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
+		if (!i6h)
+			return RTASE_PARSE_DROP;
+
+		offset = no + sizeof(*i6h);
+
+		if (i6h->nexthdr == IPPROTO_TCP) {
+			if (skb->len - offset < sizeof(struct tcphdr))
+				return RTASE_PARSE_DROP;
+
+			return RTASE_PARSE_SKIP;
+		}
+
+		if (i6h->nexthdr != IPPROTO_UDP)
+			return RTASE_PARSE_SKIP;
+
+		if (skb->len - offset < sizeof(struct udphdr))
+			return RTASE_PARSE_DROP;
+
+		*transport_offset = offset;
+		*transport_proto = IPPROTO_UDP;
+
+		return RTASE_PARSE_OK;
+
+	default:
+		return RTASE_PARSE_SKIP;
+	}
+}
+
+static bool rtase_skb_pad(struct sk_buff *skb)
+{
+	enum rtase_parse_result ret;
+	u32 transport_offset;
+	__be16 *dest, _dest;
+	u32 trans_data_len;
+	u32 pad_to_len = 0;
+	u8 transport_proto;
+	u16 dest_port;
+
+	ret = rtase_get_transport_offset(skb, &transport_offset,
+					 &transport_proto, &pad_to_len);
+	if (ret == RTASE_PARSE_SKIP) {
+		return true;
+	} else if (ret == RTASE_PARSE_DROP) {
+		netdev_dbg(skb->dev, "drop malformed packet\n");
+		return false;
+	}
+
+	if (pad_to_len &&
+	    !rtase_pad_to_transport_len(skb, transport_offset, pad_to_len))
+		return false;
+
+	if (transport_proto != IPPROTO_UDP)
+		return true;
+
+	trans_data_len = skb->len - transport_offset;
+	if (trans_data_len < offsetof(struct udphdr, len) ||
+	    trans_data_len >= RTASE_MIN_PAD_LEN)
+		return true;
+
+	dest = skb_header_pointer(skb,
+				  transport_offset +
+				  offsetof(struct udphdr, dest),
+				  sizeof(_dest), &_dest);
+	if (!dest)
+		return true;
+
+	dest_port = ntohs(*dest);
+	if (dest_port != PTP_EV_PORT && dest_port != PTP_GEN_PORT)
+		return true;
+
+	return rtase_pad_to_transport_len(skb, transport_offset,
+					  RTASE_MIN_PAD_LEN);
+}
+
 static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
 			    u32 opts1, u32 opts2)
 {
@@ -1365,6 +1559,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
 		opts2 |= rtase_tx_csum(skb, dev);
 	}
 
+	if (!rtase_skb_pad(skb))
+		goto err_dma_0;
+
 	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
 	if (unlikely(frags < 0))
 		goto err_dma_0;
-- 
2.40.1

