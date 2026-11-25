Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650929;
	b=mfhnB95T0O9NjWJiOSYm8DIUFUL/502I2gQvmMfffFA/dsDiCIMn4Vxvf0CA/1HWSvwu
	 YEi2YExo2ZcPob3I3LySpDqevxUkTvB5dFLagEtN5TJppF7RWGk8b79neNdcBkwAZ4xCU
	 nIKEohIviTh2nmIGuKDzPNSmwjCUk81La/aJJ+Syj64nU1Q9fTD4n9y75nEYV21SxFZ1V
	 hGX0HGHrcexQCu6jmV+V5GuOZ7QEOoFKKSpY6A6KyNSVY/CiZPKlS68GYqQBo2sXc9jj6
	 zPOr1TWgWCAB4NYhaKI95v4ae1eib773P50nGYiS/Yx2jBJ7vh1qlgkn1AkIIzaD0vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y17RY7lnW2W3s1gLYweIbHY4WwiCO5fusa3god85Tng=;
	b=05J5vlkq1DegZBqvn3McMJB7B14HITfhIassCDZZg6UD1o3vtVaHXUcWriyC7TEcqMkG
	 rA3oYe8kVDRseYHbQ59VBOB96YISnSNp3HkmUHJPe7vKnJGYxmPnXnpsZvUM9Qij5fa3H
	 1ktCk0zSCkr1lVmK9meUo03DJzoXUVMQg2epRtE4OI1izBtdtEhyjAbk21BI32XLp6dwS
	 d9zSh8YR+Ul4CJrrwUKbLtTmzTs2uQnNf+nJz8a2IngNu0c5Let1x91KvMhLPHOJlXpcw
	 RcBDDCn/l6J6M3pVlYuGaRWOThVDeUbp/6qsnyTkJLIZ3TSFM2qCP5eRkfpiiDOavfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b="P+DYusK/";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1122C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=P+DYusK/
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso3902563eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795650927; x=1796255727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y17RY7lnW2W3s1gLYweIbHY4WwiCO5fusa3god85Tng=;
        b=P+DYusK//Rj533Zkh+1bXxaooxu2+GSPa/j6qooTwFz/U13kBHC0S5f3+D9QRd3Wk+
         mXLXI5DBmWoFKsj9WGOz/yMKXI4EQJCxgORYnhUIqmU/xFF0VrfkDTtHxADB4qOjEN/P
         e6Y6tIBVS2zrulh/9h9/V3P6sSTVejkM8JgECx4EPe1RZDsBlG0ceefEj/VRlbQUKJ9/
         p1GycljUbIDPJ9mK6v7rxzw6HN3o8dgmXxBzQAjxAcv1cHTmd6GhqLm2d8gnvxd8PXBf
         9fYzd/fz+ksmv9SdZLe4DMw+aZD+oTQJDBapvYsEWnHWuCibywWr/7LsWgWlyciyD/Hw
         Mh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650927; x=1796255727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y17RY7lnW2W3s1gLYweIbHY4WwiCO5fusa3god85Tng=;
        b=vkW7HQ3ve2VybVxhpspmwwXMg88iMRrH0vLqojmNq7s9E7EoqRa1LPuR5M5MLUlFjr
         cbXsuTsuZbF4FGQOchS/uiNcRRzqhNd6ZBUp9NSOqAPoHJTxPd4+YFVvD7t/lND9/0oH
         oCxA+RUYcxOHn1FNPjx2DPue5owCJmtpcyIoQHVKbo6mf1ZghNCccSQhlCSdvU4XJ+jw
         Xje6T5rdjxECseQzz0zCsuPlAqvrzukzUm3FKYOYcdhxz5M5pPZmujv3YNheQIWgQoUz
         dZajgWLC2PPlSpn4SBotgOIKLnFVEoDo/GijBoOaEwVqaalzakgn13iVrM5cASOdbsBN
         geEQ==
X-Forwarded-Encrypted: i=1; AL+hErF4KiSCHCiAKp6v+i4YZdUXsgQmvCBcI7TE0/ZXuNyMYnoIWJSmxRY1x3tV4nqvKvYZOKrwykA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GlMMIPCnhcbRBxhkjsEJAlekXC9ne5iDEkxRCUevzCogBYStq
	FJFNQlUl32+WSuP7wywvKUnHKa+hOekgCitNaRKHS8BTwWazFTDV2Slx0r7Y/greVw==
X-Gm-Gg: AZFdTZde/9qoC9lAS3ZWAoepEB/caQ8Brz9riS7mYj1P4e1E4/AEz8IzKHsC4SIWI+y
	Pi7ZZmFj7ZFFJ0kYzIHTCE0l3Jy8XQDRyTKizjJklZ+xbSmz1FSkFnRB9fv8d4uWHbOzKDRBrYc
	S8oMJVbxwhlh6E/NNuxRYTwuptFvIG02n71DTJF/h0QYi7hdyk9OSoYk6j3LMXFSBzZehFGYb/X
	mzhDFK4PqgBkt18SXOfj4Jzh1DEWN4LpYFEbcoXEH3nGy2kiwrce0B7ZGQ8XbuCjzxNarsM7RiQ
	KqEV3CnWpcPiju2r0fp1SsyBIwGuzUMXIlnIArEofs9sVOTfO2kZC4Ni/aw63hzmuwMSzUevT8I
	6G0pa/NNZdNRbcugd+6xdgQbSCRLJKXmPREtDz/ohWHoz82ffEEpdxMvGTjdR8NkR/MxhfTUwpL
	OjgqX2/Ilz9cNuUeUxUwTofZELfT2tkTjz/TFihfZ9yZ1Z4xlWXAJHQ00xqzjwiNhjZXguv22wE
	+5sQttmUlGoQbSnHPw1CU8XWXSyENsWZF0i6oLxNQsNut0qvNx5EjRo6OlGBLUC8jloC5FqAFdv
	t8+bsJJIHMQUBN1n011ShY0fPFbWpohZXL0fCJC4kRM+S89zlzwjnzzt5vRH3/rXnP5c
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7ab3 with SMTP id 5a478bee46e88-3860bd88965mr19027537eec.29.1795650927153;
        Wed, 25 Nov 2026 15:55:27 -0800 (PST)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm101477297eec.3.2026.11.25.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:55:26 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+80332c538f1d1a9d@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] geneve: fix out-of-bounds read in the DF inherit path
Date: Wed, 25 Nov 2026 16:55:24 -0700
Message-ID: <20261125235524.4139551-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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

The GENEVE_DF_INHERIT branch of geneve_xmit_skb() decides the inner
packet is IPv4 from skb_eth_hdr(skb)->h_proto and then reads
ip_hdr(skb)->frag_off, but skb_vlan_inet_prepare() only pulled an IPv4
header if skb_protocol(skb, true) is ETH_P_IP. For AF_PACKET/SOCK_RAW the
two are independent: a 14-byte frame with h_proto 0x0800 sent with
sll_protocol ETH_P_ARP passes the pull with only ETH_HLEN and the DF test
reads 6 bytes past skb->tail. The stale tailroom bit is copied into the
outer IPv4 DF bit on the wire, leaking one bit of slab memory per packet
to a user holding CAP_NET_ADMIN/CAP_NET_RAW in a user namespace. With
inner_proto_inherit there is no inner Ethernet header at all, so the
h_proto test is wrong there too.

The leak was observed. A PoC plants a known byte in a freed
skbuff_small_head object and reads it back one bit per probe from the
outer DF bit:

  planted=0xff recovered=0xff  MATCH
  planted=0xa5 recovered=0xa5  MATCH
  planted=0x5a recovered=0x5a  MATCH
  planted=0xc3 recovered=0xc3  MATCH
  phase B: 8/8 planted bytes recovered exactly (8 bits each)

With this patch every probe reads 0 (1/8, only the 0x00 pattern), while
the df=set/unset controls are unchanged.

Test skb_protocol(skb, true), the value the pull was keyed on, as the
TOS/TTL inheritance already does via ip_tunnel_get_dsfield() and
ip_tunnel_get_ttl().

Cc: stable@vger.kernel.org
Fixes: a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
Reported-by: co+80332c538f1d1a9d@bugs.sh
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/geneve.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 0ab729f055ea..74e9509598cf 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1471,11 +1471,11 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		if (cfg->df == GENEVE_DF_SET) {
 			df = htons(IP_DF);
 		} else if (cfg->df == GENEVE_DF_INHERIT) {
-			struct ethhdr *eth = skb_eth_hdr(skb);
+			__be16 inner_proto = skb_protocol(skb, true);
 
-			if (ntohs(eth->h_proto) == ETH_P_IPV6) {
+			if (inner_proto == htons(ETH_P_IPV6)) {
 				df = htons(IP_DF);
-			} else if (ntohs(eth->h_proto) == ETH_P_IP) {
+			} else if (inner_proto == htons(ETH_P_IP)) {
 				struct iphdr *iph = ip_hdr(skb);
 
 				if (iph->frag_off & htons(IP_DF))
-- 
2.43.0

