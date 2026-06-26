Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26135F5F8;
	Fri, 26 Jun 2026 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449199; cv=none; b=qAzmXIttpsju3HEIIx17NX0l7D9jwUu3BRv3NGSva4Bu+HFRSySuIiOQ4g/HB1SDuMi2Bbf7ikgpGQDGKJMwO5iIlJvK+Od82/hH4pXKSuKU04cc8MflsxIoNg0Dz2jGdMI/YOSfIGeld1uwsqIAWQ2k7xaNEy63vZoCasE9HHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449199; c=relaxed/simple;
	bh=L4vqXSXkrHRMHgZovzrunuycVeUskzAMUak53rgDsUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bw8YwAp5WwPjMdeGcCl1xnYNu3PxyUMej/MJtSqShAopz0E9rn0fcC0pVe53knSQDNqlxYr2d1Uf+BYSTY39YHXXi/VQjkZLPYOClBDuGrotxG0E16eeaqR19NOyp30DxOmm+IDA3b0p1D34emRERPveLqwFVTNjuonCpS0y0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hZeDGTNn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hZeDGTNn"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65Q4k0gM51486071, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782449160; bh=ceiyPFkdJcXf8oTK9NgEKLUatSgDnzteOpqSnwRFHh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=hZeDGTNnBi+VNx16mj1nf9f7cWlWholvhtlN0dYd1i88Mkt+9Z7+3ffBeb/qQZ3+J
	 vH3rw5j0Vi2SKoJ1JDVmyyMOkiaH6F7RDrfLHkL2F+KY4NiG8GCm//jhe6ygY08wG9
	 0phdqTSKjwS4g5yV7+kp90p4r2r2+rJTUC0fZ84Brvh+OgGE8BaAdnr7ryd4d7hpqC
	 kmj0Akg76w2qNAkhW4XL40PuLZOD3kkZWHYfMuZgrJ6Btjj7umX4jD6hbqecO1t1gQ
	 MJmcqBElt6GYq3OOMR6RNyWu+saNOZQmS5V/qHxWkjhe7/KTDH7G4eT5Gd82PEouln
	 5vIRouPx5Aa6Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65Q4k0gM51486071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jun 2026 12:46:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 26 Jun 2026 12:46:01 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 26 Jun 2026 12:46:01 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 26 Jun 2026 12:46:00 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, <horms@kernel.org>,
	<richardcochran@gmail.com>, <david.laight.linux@gmail.com>,
	<aleksander.lobakin@intel.com>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v4] rtase: Workaround for TX hang caused by short UDP packets entering hardware PTP parsing
Date: Fri, 26 Jun 2026 12:45:39 +0800
Message-ID: <20260626044539.37753-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The hardware performs additional PTP parsing on UDP packets identified
by destination ports 319/320 at the expected UDP destination port
offset.

If such a packet has transport data smaller than RTASE_MIN_PAD_LEN,
the parser may access data beyond the end of the packet and trigger a
TX hang.

For IPv4 fragmented packets, a non-initial fragment does not contain a
UDP header. However, if the payload contains values matching PTP
destination ports (319/320) at the expected UDP destination port
offset, the hardware incorrectly classifies the fragment as a PTP
packet and performs further parsing.

IPv6 fragmented packets are not affected because the hardware only
enters this parsing path when the IPv6 Next Header field directly
indicates UDP. Packets carrying a Fragment Header do not enter this
path.

Pad affected packets so the transport data reaches
RTASE_MIN_PAD_LEN before transmission to avoid triggering the
hardware issue.

Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
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
 drivers/net/ethernet/realtek/rtase/rtase.h    |   2 +
 .../net/ethernet/realtek/rtase/rtase_main.c   | 113 ++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index b9209eb6ea73..d489d20177ac 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -359,4 +359,6 @@ struct rtase_private {
 
 #define RTASE_MSS_MASK GENMASK(28, 18)
 
+#define RTASE_MIN_PAD_LEN 47
+
 #endif /* RTASE_H */
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 55105d34bc79..7dabf0004068 100644
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
@@ -1249,6 +1250,115 @@ static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
 	return csum_cmd;
 }
 
+static bool rtase_get_l3_proto(struct sk_buff *skb, __be16 *proto,
+			       u32 *network_offset)
+{
+	struct vlan_hdr *vh, _vh;
+	struct ethhdr *eh, _eh;
+	u32 offset = ETH_HLEN;
+
+	eh = skb_header_pointer(skb, 0, sizeof(_eh), &_eh);
+	if (!eh)
+		return false;
+
+	*proto = eh->h_proto;
+
+	while (eth_type_vlan(*proto)) {
+		vh = skb_header_pointer(skb, offset, sizeof(_vh), &_vh);
+		if (!vh)
+			return false;
+
+		*proto = vh->h_vlan_encapsulated_proto;
+		offset += VLAN_HLEN;
+	}
+
+	*network_offset = offset;
+
+	return true;
+}
+
+static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
+{
+	struct ipv6hdr *i6h, _i6h;
+	struct iphdr *ih, _ih;
+	__be16 proto;
+	u32 no;
+
+	if (!rtase_get_l3_proto(skb, &proto, &no))
+		return false;
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
+		if (!ih)
+			return false;
+
+		if (ih->ihl < 5)
+			return false;
+
+		if (ih->protocol != IPPROTO_UDP)
+			return false;
+
+		*udp_offset = no + ih->ihl * 4;
+
+		return true;
+	case htons(ETH_P_IPV6):
+		i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
+		if (!i6h)
+			return false;
+
+		if (i6h->nexthdr != IPPROTO_UDP)
+			return false;
+
+		*udp_offset = no + sizeof(*i6h);
+
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rtase_skb_pad(struct sk_buff *skb)
+{
+	__be16 *dest, _dest;
+	u32 trans_data_len;
+	u32 udp_offset;
+	u16 dest_port;
+	u32 pad_len;
+
+	if (!rtase_get_udp_offset(skb, &udp_offset))
+		return true;
+
+	if (udp_offset > skb->len)
+		return false;
+
+	trans_data_len = skb->len - udp_offset;
+	if (trans_data_len < offsetof(struct udphdr, len) ||
+	    trans_data_len >= RTASE_MIN_PAD_LEN)
+		return true;
+
+	dest = skb_header_pointer(skb,
+				  udp_offset + offsetof(struct udphdr, dest),
+				  sizeof(_dest), &_dest);
+	if (!dest)
+		return true;
+
+	dest_port = ntohs(*dest);
+	if (dest_port != PTP_EV_PORT && dest_port != PTP_GEN_PORT)
+		return true;
+
+	if (skb_is_nonlinear(skb)) {
+		if (skb_linearize(skb))
+			return false;
+	}
+
+	pad_len = RTASE_MIN_PAD_LEN - trans_data_len;
+	if (__skb_put_padto(skb, skb->len + pad_len, false))
+		return false;
+
+	return true;
+}
+
 static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
 			    u32 opts1, u32 opts2)
 {
@@ -1362,6 +1472,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
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

