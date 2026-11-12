Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514994;
	b=EEDjx/OWQSV71F4OMmnM6NjtVjFFmEJQRxI70bhELRKPZHFZUMPElVuzCsUBchUjZ4SA
	 +bz6L4w/4TPr2V6ULbmOzvLuJFx6UfMZVuLKO3DpQrfo9i4PIr5SwUUM5j2KUTk+gcBA7
	 qCeVhUaKsKfIUO9/nFgu2TKCUVNo919TBy+8vNX+nPbwN1y9zx6m9UcS6JU2ibunYxMd7
	 og0iIczyOktVjOFntp/JDpPcz5Kpz3bjk2ndm/7Eqk3E8/93dLTuajgdMpP9ztlBhyj33
	 C9cUZ4Nr4Z9AWmypb3yK72okjH9N0YBc8jQo4QCDL1Su3hJS5QPcp2C7gsh70SRvoXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514994;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=8DzqwpdQD5heDHoUrlsNiPFwyABhSek6uK6Bj4NP0hg=;
	b=CRAV5rYsvWNE/7JtOkYczFzEgHBV0TXjgoeARwAinCDsI7HgoVfmQfEwhuiQjHrFHDVr
	 nTIs9UCz+fuqPjrQ/Kj8sQJDi8NeK6FHX1UzgnUUiGBUl0hdPswwqrBjuvX42APqjJjOP
	 GmSup6yyAjB3/+fEBSHreT57JvI55FaVT9++ijd+DZCEQqLX0A1xpgDjwtbZi3kXuGyzF
	 svWInPPpv5rc3kdz0OpDHU79AIHYDWjnEltKk24rj2mBBeJH4CPgmRU5/4ygAYpx1NTAq
	 OgcHigcdgqvY114SV9Hv+qNIR6wZ/hcqsIlpW9yc8NMckgrbmcyhI/X1YG3iRpOFOpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=pDaGQfy9;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E8606A327;
	Thu, 12 Nov 2026 20:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F5E8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=pDaGQfy9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794514994; x=1826050994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8DzqwpdQD5heDHoUrlsNiPFwyABhSek6uK6Bj4NP0hg=;
  b=pDaGQfy9QSnV4z2H8V2s7V6Y9FoAtjBAgdpz2s1NTDmAtX7oeGXReC1O
   mjoXHgIg9A+GKaH8afqLdEZ0FQ2l/gAaec+y8sQ+cPEQHbJT4o2nyca8i
   4ofCn7rjzYYVJnn04ppaDWgLqcYBzOZtBGDa6DAKWc3LHYMDbOClfpRTQ
   oeVZQExgm4W50Y9IZRjJSy1oCWaK9yCP/3RxUP8eVtdXXZbkIvrjAjjlm
   6lK6AEfxuBVz29sqlEhJ45lzDF9/wby0eX50OmsuToff7uszns88epl0y
   kqODXuIKn/TS5GI15ODGJ60xrnIhi2EaU6TTZTugwN7fjF3xisAGbBf72
   Q==;
X-CSE-ConnectionGUID: AEJzRDz1SWGPsKT+gABYmw==
X-CSE-MsgGUID: 8T5oW8P5QC+831tEvlbIrQ==
X-IronPort-AV: E=Sophos;i="6.27,210,1787011200"; 
   d="scan'208";a="33713108"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 20:23:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:26049]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 80d6f0d1-7a47-418a-a4da-54433e9e3046; Thu, 12 Nov 2026 20:23:11 +0000 (UTC)
X-Farcaster-Flow-ID: 80d6f0d1-7a47-418a-a4da-54433e9e3046
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 20:23:11 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 20:23:09 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Kyle Zeng <kylebot@openai.com>, Eric Dumazet <edumazet@kernel.org>,
	"Willem de Bruijn" <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 5.10.y] net/packet: check TX_RING fragments before memory accounting
Date: Thu, 12 Nov 2026 20:22:59 +0000
Message-ID: <20261112202259.1603271-1-doebel@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
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
[ 5.10: adjust for context in kernels lacking 3948b05950fd ("net:
  introduce a config option to tweak MAX_SKB_FRAGS") ]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 66aa5e7819ae7..41ee1113d109d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2662,6 +2662,12 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
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
 
@@ -2673,12 +2679,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
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

