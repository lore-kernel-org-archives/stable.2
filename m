Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357235C183;
	Mon, 15 Jun 2026 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529443; cv=none; b=OFid451DlCY4f5ljwQ6bt183ctuOYsVTSdizBGV2NIycDMLrBOvrsrvRvoBbfO/Azlz4Nu34FnGFcJKcLtSNGFea+zXHPBn1tbbry5guMlcimeJ4YAaLxCWMX3pKTDQgSdpGyJ5lVwyVK1qx3DDkqZbybGKJXBhZUv6bff58Wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529443; c=relaxed/simple;
	bh=n91lsdIM2Jn9fZG9XblBjkqZ2+NOYXdF4cUdvwDYMRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s99ySvguWeAo3zLJp4yeQaq+rHtn4KeRRsrWp5he9334iyvh3NUjbSCey4T8cmNpP9Xs4/wYTSD7uhhN17HHsFczj5MPVMsNaIWSuyAoa9a5tO0Frs4597y4LYZZn6KnIm8DJ/EYyPJHIsgAHgH4KtOxDOl56vDeY/pvAxEyy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SgdSx9ri; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SgdSx9ri"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65FDGtYF2736984, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781529415; bh=vpVsmzYwgdLsqk0KWHh4aHTfZpL7wkRJwynQLacYRXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=SgdSx9rijD6S/+pfOR0Sbr286/jye/VsTjY63NSBFdvQvMiXcosHOJOUcnPDgsWAs
	 0z4WVa6nsCIBan8OAa9Elhl2+CCsRLY3OQ6vCBrtA7x42crEX/1puRcUq+pSmXZoJ3
	 Q4Qhiw8plhdZjKmtXwCv7H7Ymq483yN3TVg0gHwCNPzPtslZx7zRBTJkRIPoM0Xmhw
	 XbD8gqNYSy0ESt9ZxVy7e6w9TSu+BMWelSGSscz1awevVmgmyR9G1AXvEST/C6M71m
	 DrIR5hFDb653ViesqviaW5PXsj/cz/Pkcrvvhh66YpVGeDC2lBFIjItsqgipx1B/Wt
	 BUkATuTuBMYkA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65FDGtYF2736984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 21:16:55 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 21:16:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 21:16:55 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Jun 2026 21:16:55 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, <horms@kernel.org>,
	<richardcochran@gmail.com>, <david.laight.linux@gmail.com>,
	<aleksander.lobakin@intel.com>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v3] rtase: Workaround for TX hang caused by short UDP packets entering hardware PTP parsing
Date: Mon, 15 Jun 2026 21:16:53 +0800
Message-ID: <20260615131653.15730-1-justinlai0215@realtek.com>
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
 drivers/net/ethernet/realtek/rtase/rtase.h    |  2 +
 .../net/ethernet/realtek/rtase/rtase_main.c   | 79 +++++++++++++++++++
 2 files changed, 81 insertions(+)

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
index 55105d34bc79..4c295a39c7a0 100644
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
@@ -1249,6 +1250,81 @@ static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
 	return csum_cmd;
 }
 
+static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
+{
+	int no = skb_network_offset(skb);
+	struct ipv6hdr *i6h, _i6h;
+	struct iphdr *ih, _ih;
+
+	switch (vlan_get_protocol(skb)) {
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
@@ -1362,6 +1438,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
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

