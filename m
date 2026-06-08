Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13933AC0D4;
	Mon,  8 Jun 2026 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907127; cv=none; b=k1CfgdBXW31hLGtI1h5XaGpRxQ+Lzf2pWbv1ZOYOxAxJvSRZXHLM+jxFTsZsCn70JWOWN61hYoV63FpwT3TxZBJBGE2lZ0KlSvaFRdATTNk2bn1r9qJVHAOS00A/ALsYkxKwKzu1zhSpQwSlGnlLYIC26oflJvZeV99dUTS8PGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907127; c=relaxed/simple;
	bh=r5FtMK/f2un1emUZ8ezo6Cz+b/7rSFAc20e5TK10Id0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOqnOHCXBcuRT4qgig+JU6Laqtp79j1cTr9mjqPSAS0KggpW0nLomay7upr9LMey2KU9+OGqxrEhdcvGhWCfwQiBhQKYT1I+Erup1e0WtB0X0oqlSFCmejLCqFcpiKgXLxx6SPZGfQaQQhRRRFywvHU7InRvw2CK65NUwwBH63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=eVWj7bx2; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="eVWj7bx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780907125; x=1812443125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2d1N+ncM5+OyeFdunTRQqXnxLg4pO8EHQkoV6u5lRY=;
  b=eVWj7bx2yxSyJLKQ3dugo6sy1OjQMl7+WRBDNWzWLy+XUOuvUEWmy/wF
   nOSg+qmymrrY8L9FuMnxHv9DCokugCubHz6W21JZVRkObV9Qk8latVh14
   X5VCr8ojT0mYOTvpxUXZ/Wq8Yx5pJhMbV9ntuWU7WEUn/Bsu0BVDzaFco
   ka5FNLJ+SUx7spBT3Jqhpgh9y2dQgQaT0ZgKkjf087TWSic9OqhSwQkBG
   ZFbO6pL1I3Zxu2+kV0bJAtN2mZrq5x4F6BlIEJUIEPxyCngaVbN92I+63
   otzNmsOoalJPOQek8USHRA1hJvvDjbTVQl/MiWGE+m8/kI1Sz4TDnELnB
   A==;
X-CSE-ConnectionGUID: d4gK/nVISWeA3UIFNb21EQ==
X-CSE-MsgGUID: g2h8g+3dQA+DaE9NBMmDBQ==
X-IronPort-AV: E=Sophos;i="6.24,194,1774310400"; 
   d="scan'208";a="20814917"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:25:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:21065]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id e3441014-2d5e-44fc-b598-45dc596f90c0; Mon, 8 Jun 2026 08:25:21 +0000 (UTC)
X-Farcaster-Flow-ID: e3441014-2d5e-44fc-b598-45dc596f90c0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 08:25:21 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 8 Jun 2026
 08:25:19 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>
CC: Qi Tang <tpluszz77@gmail.com>, Florian Westphal <fw@strlen.de>, "Simon
 Liebold" <simonlie@amazon.de>
Subject: [PATCH 6.6.y] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Mon, 8 Jun 2026 08:24:54 +0000
Message-ID: <20260608082454.2786663-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Qi Tang <tpluszz77@gmail.com>

[ Upstream commit 1c428b03840094410c5fb6a5db30640486bbbfcb ]

After async crypto completes, xfrm_input_resume() calls dev_put()
immediately on re-entry before the skb reaches transport_finish.
The skb->dev pointer is then used inside NF_HOOK and its okfn,
which can race with device teardown.

Remove the dev_put from the async resumption entry and instead
drop the reference after the NF_HOOK call in transport_finish,
using a saved device pointer since NF_HOOK may consume the skb.
This covers NF_DROP, NF_QUEUE and NF_STOLEN paths that skip
the okfn.

For non-transport exits (decaps, gro, drop) and secondary
async return points, release the reference inline when
async is set.

Suggested-by: Florian Westphal <fw@strlen.de>
Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ net/xfrm/xfrm_input.c: dev_hold/dev_put are unconditional here rather
than inside !crypto_done as in mainline, and the dev_put in the
encap_type == -1 async-resumption block does not exist; adapted by
gating dev_put at resume: with if (!async), adding if (async) dev_put
at -EINPROGRESS return, gro_cells_receive paths, and drop label. ]
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 net/ipv4/xfrm4_input.c |  5 ++++-
 net/ipv6/xfrm6_input.c |  5 ++++-
 net/xfrm/xfrm_input.c  | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index f6e90ba50b63..d05e8ff9c37b 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -48,6 +48,7 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct iphdr *iph = ip_hdr(skb);
+	struct net_device *dev = skb->dev;
 
 	iph->protocol = XFRM_MODE_SKB_CB(skb)->protocol;
 
@@ -71,8 +72,10 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 	}
 
 	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
-		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm4_rcv_encap_finish);
+	if (async)
+		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 8432b50d9ce4..b2e328de620b 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -41,6 +41,7 @@ static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
+	struct net_device *dev = skb->dev;
 	int nhlen = skb->data - skb_network_header(skb);
 
 	skb_network_header(skb)[IP6CB(skb)->nhoff] =
@@ -66,8 +67,10 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	}
 
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
-		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm6_transport_finish2);
+	if (async)
+		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 0c08bac3ed26..f79fc5d13e60 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -636,10 +636,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		else
 			nexthdr = x->type->input(x, skb);
 
-		if (nexthdr == -EINPROGRESS)
+		if (nexthdr == -EINPROGRESS) {
+			if (async)
+				dev_put(skb->dev);
 			return 0;
+		}
 resume:
-		dev_put(skb->dev);
+		if (!async)
+			dev_put(skb->dev);
 
 		spin_lock(&x->lock);
 		if (nexthdr < 0) {
@@ -707,6 +711,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			sp->olen = 0;
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
+		if (async)
+			dev_put(skb->dev);
 		gro_cells_receive(&gro_cells, skb);
 		return 0;
 	} else {
@@ -726,6 +732,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				sp->olen = 0;
 			if (skb_valid_dst(skb))
 				skb_dst_drop(skb);
+			if (async)
+				dev_put(skb->dev);
 			gro_cells_receive(&gro_cells, skb);
 			return err;
 		}
@@ -736,6 +744,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	if (async)
+		dev_put(skb->dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;

base-commit: 0a40c6fbd105802fbbcaadca249e0948fbf8095a
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

