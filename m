Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C23AEF47;
	Mon,  8 Jun 2026 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907264; cv=none; b=tkRiZP5oB0+QspBHbjCFeqgb99HMnyI/YqkBmrc2QfA0/X+efaesGJAzL7MnvlwhecsW3dzBFXz+LD7cOedQ8UlagZq/Yu+wl9VVBxwQKmjLK3vj4qxs3sqyoexpIxZgRzXO6gk08Qb3NfKKEx8WNtKQzK+QFuiqfUFN+cUjyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907264; c=relaxed/simple;
	bh=xX11XFF7CllnWCKodwtyNSA/wMhgnnvj0XHseFjK5So=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ATVjwlQmzn7SFg0lc74VK09B2Ieua5S4kVqfQtqP2M47lLFPFD+pZFIionJ8SZyBGZIW8EZuEU3+H/G+uUr+LlCID8nFoTeOqeppMw3/BPHwnpdHYVRMWp62/XsX84PTOVh8FGyYmOCcmee2FMjsEb+kMtaaoJlZq+rqWlEpcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=UYN3TFFu; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="UYN3TFFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780907260; x=1812443260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VmUw3UxYK4bXB/9MEWnupktjMpispESwRKJsyd57xfM=;
  b=UYN3TFFuh5E6mx2aL/rWrJl3/qw0OpJyDqxjNiSTMNjH37w0bYrvJeJD
   NrZTH2tdJ54J+Z4tJ2oxv0Hye401hA/4/Ad8ki6bUDVxg+wkwDaTfcaWb
   PjFnOBhvGPR4LpbZQZWylhj8Op6w/gQjkTwZZF3VwaYgaozBnhEd0PMbH
   Pzx2nLFMuud3DSArYCo9JpIhEOZ7xr5HITlSGoWdq0lLd/oohKsCxLEx9
   gSOQ2nV42fOng+2cu2WvWAKRhhS74IznyCnMkEHlz3CS4/Lqtw+aSCA1p
   QZ1WVfWfABZYi2BXKMO2IE9mj50jLm963U0gf/C61bqyZ1wAm/gtxTKBc
   g==;
X-CSE-ConnectionGUID: WdyUHsMAT5KzyG3KElEbzg==
X-CSE-MsgGUID: 2QCoQ4erQxeJCr3JM1h9Ag==
X-IronPort-AV: E=Sophos;i="6.24,194,1774310400"; 
   d="scan'208";a="21316100"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:27:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:16354]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.234:2525] with esmtp (Farcaster)
 id e186b9df-872e-4727-a057-6affbab4a8b6; Mon, 8 Jun 2026 08:27:37 +0000 (UTC)
X-Farcaster-Flow-ID: e186b9df-872e-4727-a057-6affbab4a8b6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 08:27:37 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 8 Jun 2026
 08:27:35 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>
CC: Qi Tang <tpluszz77@gmail.com>, Florian Westphal <fw@strlen.de>, "Simon
 Liebold" <simonlie@amazon.de>
Subject: [PATCH 6.1.y] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Mon, 8 Jun 2026 08:27:18 +0000
Message-ID: <20260608082718.2789134-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
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
index 4bba890ff3bc..588c671e661b 100644
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
@@ -706,6 +710,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			sp->olen = 0;
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
+		if (async)
+			dev_put(skb->dev);
 		gro_cells_receive(&gro_cells, skb);
 		return 0;
 	} else {
@@ -725,6 +731,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				sp->olen = 0;
 			if (skb_valid_dst(skb))
 				skb_dst_drop(skb);
+			if (async)
+				dev_put(skb->dev);
 			gro_cells_receive(&gro_cells, skb);
 			return err;
 		}
@@ -735,6 +743,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	if (async)
+		dev_put(skb->dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;

base-commit: dcbcab9d707928cd1679eba21ef0697fbb73b88a
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

