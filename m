Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515010;
	b=npDER9pSfirlPpf817Z2iuPbTVvc6CBfYw9hLwPDWZLCdAroK5jXBcqOMb/2TiqOgp5u
	 OInQxGK+kq3Hf+SIG45zVLu/HR34gLC9bhneRCom5jhaywcraUpLH5GVVlwwAs1Ynbns3
	 LN+F4lxakLREY8RMLV3mig4mh/3+d/p0SyCPhqXyhgqvatAlOjCBJ6ML4fQbhYqzKRzUx
	 vYlEj11FJCYQy1YualjS9x/dhEZxH4wDbNR9ZMuvfnVWXKjnVyoUTXGs2CVBueyuKuoR0
	 J4fuFOT+1uC++kVN6mDyIcpKjOlC/38U9E8UPx9hYAt8S9V+IL3g7fVOa6/nyl3uEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515010;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=gIo44VjNCShDh9JoxuZCbDu5efW3CxcRnw8e07yhFRY=;
	b=nU7TGtSVPGdZcsTaIhuPmXIfFCQ+3GMU1I3o0Ba/O3WbSKKwmBxQ2E+0m02uVxJMM14P
	 tZ1oVzSm6lsi84jQd5+zfqYtvSEBy8PEnCaEf6tD1PBEBn0OlhMYwmM+VMY6OhvOU6lQQ
	 824lH1LOL5h7UYIlCfrEX5FcMSMfnX7ZhtUTtZ0QpMIiKGCbxr4t97byzMeD1uXoF4uMI
	 JUv1hpWg0mxNWIi/W4XkTIpZ0yKNuz2oZ8mnBL3fXrgzEMkqctVa2wlmJ/6cNIGtZJFli
	 WgXWW1OqWb2+n6fTBrhiWXBuHRhepTmnI7uTq4A3+CSOBAfTcG+QpYCwm0/DtfpEVMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=HTCZ2fil;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D3606A334;
	Thu, 12 Nov 2026 20:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 228D3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=HTCZ2fil
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794515010; x=1826051010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gIo44VjNCShDh9JoxuZCbDu5efW3CxcRnw8e07yhFRY=;
  b=HTCZ2filCBwvZGKb3hypxT7OnqiBgJw6bHNZppBP7Ym8bNn3pyTsoVT/
   fME5HHfh2osKA19m3xfHK1oZqrvbCWDyLOe/PIulUcSDnwrC98QLJUwgl
   eVIpHurlNDf9lAv9dneoAHpZt+BsR9g1EdTAYwd4O4ctuYqBDbKDQdwGh
   2wbT0VyUxrngk0dm7UCTYjWZHHh2DNradBJUW1+gxXvX8rqQMPg/RPV5L
   kEINz2a3EF9+Dyy10KzqFHX9/N6BMwOYlAi0Wgv2/Ejdm16BgpjXdBOh5
   lVZl+v9lLNFZV62JKBzGubATmjKgbJnHTMATkdFCSbUKZERhWmKydEjxC
   A==;
X-CSE-ConnectionGUID: K8U9nbOdS9a08qLob9kiNw==
X-CSE-MsgGUID: 0MrpFR12TnyVLAOGWYQtyQ==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33820958"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 20:23:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:17060]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.127:2525] with esmtp (Farcaster)
 id 8e4b780a-e04a-41b5-8761-0ed47fec9913; Thu, 12 Nov 2026 20:23:27 +0000 (UTC)
X-Farcaster-Flow-ID: 8e4b780a-e04a-41b5-8761-0ed47fec9913
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 20:23:26 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 20:23:25 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Kyle Zeng <kylebot@openai.com>, Eric Dumazet <edumazet@kernel.org>,
	"Willem de Bruijn" <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 6.1.y] net/packet: check TX_RING fragments before memory accounting
Date: Thu, 12 Nov 2026 20:23:19 +0000
Message-ID: <20261112202319.1603433-1-doebel@amazon.de>
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
[ 6.1: adjust for context in kernels lacking 3948b05950fd ("net:
  introduce a config option to tweak MAX_SKB_FRAGS") ]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 17167fd94692d..0f4fb8350bbe5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2705,6 +2705,12 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
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
 
@@ -2716,12 +2722,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
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

