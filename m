Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515002;
	b=MMk56GmOye0QiW5GzTIKhD3j95k0nccycpQm89elskFq1JZLLYMsUKxL/RSjORfAP8Is
	 iqK696dCwOBLVpX/e9CLv4Hf4AsGdcDO4u1bDiEzHfdsg9hGiuBwWhcK5YNb26QHq+ld6
	 U/HBzBRRz9EISdh4DnHo88z+CEl/NbURNRDQ14WnH4E+r/2oBQZwcwnDYSs+X1uxLdt1n
	 AoHvbMpVhl+Kg0dBYuLbKKUTE1LuouOb7bFr+2QcxkGRda5vthhjY5eITtcXLwyAt2yIK
	 siJU+F+5Jak0k0z+PFsWE5MmKvIQHftWyqmsQub/TKiMF5pzJqEN+IOTzbqlqyMKIDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515002;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=K2FZCljGaZ5Cae2DMfeHsHJsgiYGyvlnAKdx0u4b/6U=;
	b=Zo8ClFFPjINAvKopXS1A9m4jZ3eDWPRRNF50a82W11+p9y464jKDTdCHCGqxk+q6KnO6
	 KM4LzI2OXUtftYifHxCzi/1rAt3zU+0wrZo4ry6FnLfTQGsr+KKEuNIDa4YQOMcKrzYvM
	 wGHRTelyFQ1xVOHBvIVLWONgQE26uLoWNXgQ5DaggwLDHfGGqMb64gj4GquBbPkvVScLI
	 hgtQcA+NMLVNuMXJWvlp/eEkRa/ZGiPgfFEbG9IPEBzME4jvW1o4UTAPLHN8V4JItZjsR
	 LrBW94EkU1d1DEVKww/1jDzcs5RA9LZBJRw6geTqtAtBcNn3nNyYmJegjSocw9fv/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=qcu04zAn;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB2606A31C;
	Thu, 12 Nov 2026 20:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08BB2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=qcu04zAn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794515002; x=1826051002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K2FZCljGaZ5Cae2DMfeHsHJsgiYGyvlnAKdx0u4b/6U=;
  b=qcu04zAnQSVi7rFQpLp62VDt2OE8Ofqy3tzyw4wr/dEfPThufYT1+IJH
   tH6aAd9bzwwgyH3nKBE6z6RwAa6IF1NaWyVEHcw5OKozqFgepfi/Hz7vB
   KV3gCj9sDwLBzL+N7ftCVG5nXay5Q8g9YeEYU8J4UAGrThw6wDyjYRtDj
   4GGUHhMfc3V+7WlT17OkPwU4qeYiWe/IKE7CrDBG7lyZRA1HOTHrvbC0g
   xdYKJZm3+rKiIDg16hg+OzmX7uRnVkO0AlBnf93G3pdSe7yauCwulOt8E
   wgK1rQSQ57cO25huc1wbCBJuARhf4FEIVGWF7U9Q06YfCnjShh8Dg5lCR
   g==;
X-CSE-ConnectionGUID: HRUiPj0YSuCvzbHeC292iQ==
X-CSE-MsgGUID: yKvHfUh0Ts65FpBL8ihbXA==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33853166"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 20:23:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:23820]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id 5848bfd7-122a-422c-97e6-49be87636d8f; Thu, 12 Nov 2026 20:23:19 +0000 (UTC)
X-Farcaster-Flow-ID: 5848bfd7-122a-422c-97e6-49be87636d8f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 20:23:19 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 20:23:18 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Kyle Zeng <kylebot@openai.com>, Eric Dumazet <edumazet@kernel.org>,
	"Willem de Bruijn" <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 5.15.y] net/packet: check TX_RING fragments before memory accounting
Date: Thu, 12 Nov 2026 20:23:11 +0000
Message-ID: <20261112202311.1603376-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit dc4dd12f80e499dc034710cd8195489abcf0b059 ]

tpacket_fill_skb() adds the full non-linear payload length to
skb->truesize and sk_wmem_alloc before checking MAX_SKB_FRAGS. With
PACKET_VNET_HDR, userspace can submit a ring-sized frame even when it
greatly exceeds the device MTU.

A near-INT_MAX frame can saturate sk_wmem_alloc before the fragment
loop rejects it. A subsequent refcount_add(0x40000001) can temporarily
turn REFCOUNT_SATURATED into 1. A concurrent TX completion can then
drop that apparent last reference and free the still-live packet
socket before refcount_warn_saturate() restores the counter.

Check that the remaining payload fits in MAX_SKB_FRAGS pages before
accounting it. Include the initial page offset in the calculation,
and move the existing -EFAULT handling out of the fragment loop.
This preserves the accepted packet sizes and error code while
preventing an invalid frame from injecting an oversized byte charge.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: use net_warn_ratelimited() instead of pr_err(), add a Fixes: tag]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20261028181450.2221013-1-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ 5.15: adjust for context in kernels lacking 3948b05950fd ("net:
  introduce a config option to tweak MAX_SKB_FRAGS") ]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index dc9308a22f9e3..76762e3b55226 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2666,6 +2666,12 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	}
 
 	offset = offset_in_page(data);
+	if (unlikely(to_write > MAX_SKB_FRAGS * PAGE_SIZE - offset)) {
+		net_warn_ratelimited("Packet exceed the number of skb frags(%u)\n",
+				     (unsigned int)MAX_SKB_FRAGS);
+		return -EFAULT;
+	}
+
 	len_max = PAGE_SIZE - offset;
 	len = ((to_write > len_max) ? len_max : to_write);
 
@@ -2677,12 +2683,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	while (likely(to_write)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
 
-		if (unlikely(nr_frags >= MAX_SKB_FRAGS)) {
-			pr_err("Packet exceed the number of skb frags(%lu)\n",
-			       MAX_SKB_FRAGS);
-			return -EFAULT;
-		}
-
 		page = pgv_to_page(data);
 		data += len;
 		flush_dcache_page(page);
-- 
2.50.1

