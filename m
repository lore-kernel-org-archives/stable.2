Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C43CCA12;
	Thu,  4 Jun 2026 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568067; cv=none; b=k7iGPzo/DSozXYwwiWr/Y6Yyd7EN3A3nnc4QzcrEvJQgokv6XsN9cCnZXu0CqpiHrE5I5Jmzllwb3jk5z6H/r8U4ZYIC6zw5gRzKcXe+ATSVYFxKxYJ510T14HxA/QnNGjVyd4kU/97f+N3XU2eRXbKIjicFKnWhQ3xzQzlWCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568067; c=relaxed/simple;
	bh=DqVEM59lL7OQTcn9p0HqHEzBAvvMHwapc8TYXfz0Adk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m4QgsR8yLYBCpVk+PzFXtslEou3OLYSCLBHsqKOfxqvvPKn04lpbueNjrrnnB596eCVFU0nqGzyAZhy6sNteCXfzac6UvD5eWNEpQPVXToOfGHfu3K9Ibr5Cxe+5EjfyU9Qa7VroF1Cm+vEWNxVX3lKK01lfAWBbNtBUaWC3edQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z08RoqU9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z08RoqU9"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 654ADxYaA268502, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780568039; bh=TzXF7cxakGWG0ahpOW6BzzmAHd3zqxkCPLc1yupiztA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Z08RoqU9ZvUER1vIRTTeBAXuTa+Qdfs88DzwK4Bc71Gu3Ys6kR3NGhj3kcA8TNEIt
	 7EdDVk+X5YxAqGhjYPd6WWNoxS6M+Sea9VQUaqxlPjYml9mLxBEfUtJqpbK/kw3fYU
	 sRIFLRS9+0Eiss5NkU2m0t/n8Y0mxRVuqK9nfmv8fO86jowjjTXGY7M/wRnpT9yIsa
	 10QBq93Yd6xRsTfWVwQ6BL58ayRzxkxDTvm3GdNDn8yWf+WzTZwErdxrkyQwZqtwpc
	 7/8GQ7KCudNm1XI/D7o5p6AeXRTDupdg40DHm2lGxM+UWqiaksFkITpfPaH95J5VGb
	 Y0tNBXh7LYHJQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 654ADxYaA268502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 18:13:59 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 18:14:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 18:14:00 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 18:14:00 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, <horms@kernel.org>,
	<richardcochran@gmail.com>, <aleksander.lobakin@intel.com>,
	<pkshih@realtek.com>, <larry.chiu@realtek.com>, Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet hardware bug
Date: Thu, 4 Jun 2026 18:13:56 +0800
Message-ID: <20260604101356.15611-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The hardware parser incorrectly interprets 319/320 in a short
IP fragmented UDP packet payload as standard PTP destination
ports and treats the fragment as a PTP packet for further
parsing.

If the transport data is smaller than RTASE_MIN_PAD_LEN, the
remaining data is insufficient for further parsing and causes
hardware TX hang.

Pad these packets so the transport data reaches
RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
hardware issue.

Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
v1 -> v2:
- Remove RTASE_SHORT_PKT_THRESH and the packet length check.
- Check transport data length before parsing the UDP header.
- Add Fixes tag.
- Add Cc: stable@vger.kernel.org.
- Target net tree.
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |  2 +
 .../net/ethernet/realtek/rtase/rtase_main.c   | 50 +++++++++++++++++++
 2 files changed, 52 insertions(+)

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
index 55105d34bc79..6c189b3efab0 100644
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
@@ -1249,6 +1250,52 @@ static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
 	return csum_cmd;
 }
 
+static bool rtase_skb_is_udp(struct sk_buff *skb)
+{
+	int no = skb_network_offset(skb);
+	struct ipv6hdr *i6h, _i6h;
+	struct iphdr *ih, _ih;
+
+	switch (vlan_get_protocol(skb)) {
+	case htons(ETH_P_IP):
+		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
+		return ih && ih->protocol == IPPROTO_UDP;
+	case htons(ETH_P_IPV6):
+		i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
+		return i6h && i6h->nexthdr == IPPROTO_UDP;
+	default:
+		return false;
+	}
+}
+
+static bool rtase_skb_pad(struct sk_buff *skb)
+{
+	u32 trans_data_len;
+	u16 dest_port;
+	u32 pad_len;
+
+	if (!skb_transport_header_was_set(skb))
+		return true;
+
+	trans_data_len = skb_tail_pointer(skb) - skb_transport_header(skb);
+	if (trans_data_len < offsetof(struct udphdr, len) ||
+	    trans_data_len >= RTASE_MIN_PAD_LEN)
+		return true;
+
+	if (!rtase_skb_is_udp(skb))
+		return true;
+
+	dest_port = ntohs(udp_hdr(skb)->dest);
+
+	if (dest_port == PTP_EV_PORT || dest_port == PTP_GEN_PORT) {
+		pad_len = RTASE_MIN_PAD_LEN - trans_data_len;
+		if (__skb_put_padto(skb, skb->len + pad_len, false))
+			return false;
+	}
+
+	return true;
+}
+
 static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
 			    u32 opts1, u32 opts2)
 {
@@ -1362,6 +1409,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
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

