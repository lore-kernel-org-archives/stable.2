Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6403AF66D;
	Mon,  8 Jun 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907540; cv=none; b=eLwazlilO3XFdWu2bQ4jlt2WK9PSjUK2tJZhy/aBUejFkSrH6IFbxGt9fCZp7H5kk/A+Z+sTl5CAMMp0OGYl4AHybFBqIK7dGmn+LUWQGb7FZvMdQBSHKBM08OdCH7R7inFZOmZ2mWOMT70wST01+qkXgal8Vrd7V0VeR8FxuUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907540; c=relaxed/simple;
	bh=pnhXkgoDFVyHjO14pQvt/qt42pkN37eKdqiTtc6AlK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=crBqsWg0zjbXgPihXZ1ZzNVvM6pPP4b0+ywh+tOspkHf+bB5FcM9ShclsPt86zEOD7v9pN4D58GdEllT/+VtzG0lqc53kYvz4fWedZXF5/aAYU9O8SLWlEpUNElKa0cGBKHULoHmmzG6g6IuceVNHw3KnLY8erJUIGB1n2ttBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=mcTmQu2O; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="mcTmQu2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780907539; x=1812443539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=daCceaZNyZPEM/C2MSBzM4sNT4KsF3tDP1TOnakkCWU=;
  b=mcTmQu2O9XX/f0pFnM3sgYjKlyOIZuJNt7vZ6jXQjpT0J2u8ri9fnxci
   TYAAY195Vtu5eWsUrDUXFvl91g4ibphYhzNGgoayh+xBwuE447dSEFrNn
   qxnRXZ6X1nouoJlwdERBn0MYDvkKyF6+y8VN3Jxp7r0jmAsDcc1qKeWz/
   n0HzjoLqg7apxnmD4kCNPKwwMDfsDNgWriZTj/W347ZUK6akqAPgYWdEm
   rysFuXAIWYFqHPIv0uPUnUgeG8SdCdLmkFV7wZiSaip/ziqZQ0P6W7Rs9
   q3pxyEYM+6xpl9F3FleL/2mJHYZfc5rEoYPdW9n4kalcPS7dndHDA1+Hw
   A==;
X-CSE-ConnectionGUID: 9eQeX9otRxCoL4fsIMbqTA==
X-CSE-MsgGUID: 1k5YtbxpRfqTzep0OzJckA==
X-IronPort-AV: E=Sophos;i="6.24,194,1774310400"; 
   d="scan'208";a="21182260"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:32:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:18928]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.234:2525] with esmtp (Farcaster)
 id 3d500f38-8053-4a0e-8d6d-cd8de58f80a1; Mon, 8 Jun 2026 08:32:05 +0000 (UTC)
X-Farcaster-Flow-ID: 3d500f38-8053-4a0e-8d6d-cd8de58f80a1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 08:32:05 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 8 Jun 2026
 08:32:02 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>
CC: Qi Tang <tpluszz77@gmail.com>, Florian Westphal <fw@strlen.de>, "Simon
 Liebold" <simonlie@amazon.de>
Subject: [PATCH 5.15.y] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Mon, 8 Jun 2026 08:31:36 +0000
Message-ID: <20260608083136.2842689-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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
index 1f50517289fd..740f6510215f 100644
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
index 7dbefbb338ca..aaba607d31d5 100644
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
index 7f326a01cbce..5b3776b91ba8 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -650,10 +650,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
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
@@ -729,6 +733,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		if (sp)
 			sp->olen = 0;
 		skb_dst_drop(skb);
+		if (async)
+			dev_put(skb->dev);
 		gro_cells_receive(&gro_cells, skb);
 		return 0;
 	} else {
@@ -747,6 +753,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			if (sp)
 				sp->olen = 0;
 			skb_dst_drop(skb);
+			if (async)
+				dev_put(skb->dev);
 			gro_cells_receive(&gro_cells, skb);
 			return err;
 		}
@@ -757,6 +765,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	if (async)
+		dev_put(skb->dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;

base-commit: 241d66fa280c91b65942d641e92d06c9ae6a0b95
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

