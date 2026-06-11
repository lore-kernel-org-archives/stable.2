Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFA3EFD03;
	Thu, 11 Jun 2026 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179944; cv=none; b=A940OMD2SQhBs17k59/K9FRs4SM4bYrA2M9RfRM91PH56/qpWdVFBgDOnEQHIIf/7q9B1wTecWNxfvQTlgOC7AvmaY9INfnHVb+EiisL8Q2jEcX9pwyHDnbpVDU/mv8jHUxlTsOO/LEt38X8JJClInuwrTPpK5KcLpGosYnDZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179944; c=relaxed/simple;
	bh=UiGAIjlI8TKekyKYZJpkgKTjkOCxn66W0nCQRqWVw70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XK0ev+oGTKOkgmdN8vaSlFSleEmNdp74jBDMRgBh9/32ebn/f6mZbePJy709QKX17Zb5zPtIQzRgZf8KHbZNpTLTBE2HnjczWwAkrPR+tjpefEDKlx2k84zuYa5KABANoItfDZu2RFxFich1VxKE0J0E6PiiS6iGQiJcu8+yMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=koTTg7Zv; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="koTTg7Zv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781179943; x=1812715943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w5MwL8kRBcBy1n8l2oBZ5lJdvZejzvbfTlUbkMGKbSg=;
  b=koTTg7ZvoF3cwx7FEawZXDKw1Ovk1oos0vw712DBMM3oJaB9vz9HS6VF
   ye+LS4uXdoDjRDKX+j2RCDqucrxzV6aX/2S7h2CsHm+lgpWKVoFhfMPQq
   /LPdwwHOIQV543kXJvbCFMrtsjcwOufQiebeOU2oN/LvSkIAT2hUMDDAC
   LEfGaqrRM3b7j/z8Znj1/p0Sn8xCGPF7WgrpXWrbGhbnACqN1CTYNi7aO
   OynWOHbtjhfOorxkmc+Qemd9wNPufzYuxUc7QjmZahC5nQVp5nllcPKNv
   mzbnXGM9Ph4U7KagLxQJqvDa5rSHOZ6NHn+kwkv/K0htegjdp9D4euu4s
   Q==;
X-CSE-ConnectionGUID: cctrzFtNQlCyDn/O4+8rJg==
X-CSE-MsgGUID: tjSXLc9nSbKEJij/nrVWaA==
X-IronPort-AV: E=Sophos;i="6.24,198,1774310400"; 
   d="scan'208";a="21574024"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:12:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:11366]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id fcebbe3f-c75d-46a5-9f8f-7fb65b987b1b; Thu, 11 Jun 2026 12:12:20 +0000 (UTC)
X-Farcaster-Flow-ID: fcebbe3f-c75d-46a5-9f8f-7fb65b987b1b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 11 Jun 2026 12:12:19 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 11 Jun 2026
 12:12:17 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>
CC: Qi Tang <tpluszz77@gmail.com>, Florian Westphal <fw@strlen.de>, "Simon
 Liebold" <simonlie@amazon.de>
Subject: [PATCH 6.12.y v2] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Thu, 11 Jun 2026 12:11:27 +0000
Message-ID: <20260611121127.3908131-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
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
encap_type == -1 async-resumption block does not exist. Adapted by
taking a fresh dev_hold (when async && !xfrm_gro) immediately before
transport_finish, which releases it after NF_HOOK. The per-iteration
dev_hold/dev_put pair at loop-top/resume: is left unchanged.]
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---

Notes:
    v2: Restore unconditional dev_put at resume: and instead take a fresh (commits)
    dev_hold immediately before transport_finish (when async && !xfrm_gro),
    avoiding the reference leak on nested transport-mode that v1's
    suppressed resume: dev_put caused.
    
    Prerequisite b05d42eefac7 ("xfrm: hold device only for the asynchronous
    decryption") was not backported as it restructures the lock ordering and
    resume: label semantics of the decryption loop, requiring non-trivial
    adaptation beyond what a minimal stable fix warrants.
    
    I will send patches for 5.10.y -> 6.6.y once we concluded on this patch.

 net/ipv4/xfrm4_input.c | 5 ++++-
 net/ipv6/xfrm6_input.c | 5 ++++-
 net/xfrm/xfrm_input.c  | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 12a1a0f421956..adf21d6b6076c 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -50,6 +50,7 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct iphdr *iph = ip_hdr(skb);
+	struct net_device *dev = skb->dev;
 
 	iph->protocol = XFRM_MODE_SKB_CB(skb)->protocol;
 
@@ -73,8 +74,10 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
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
index 9005fc156a20e..699a001ac1662 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -43,6 +43,7 @@ static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
+	struct net_device *dev = skb->dev;
 	int nhlen = -skb_network_offset(skb);
 
 	skb_network_header(skb)[IP6CB(skb)->nhoff] =
@@ -68,8 +69,10 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
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
index 8edcb32735e59..0288d98e66ee4 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -726,8 +726,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		err = -EAFNOSUPPORT;
 		rcu_read_lock();
 		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
-		if (likely(afinfo))
+		if (likely(afinfo)) {
+			if (async && !xfrm_gro)
+				dev_hold(skb->dev);
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
+		}
 		rcu_read_unlock();
 		if (xfrm_gro) {
 			sp = skb_sec_path(skb);

base-commit: 1d3a00d3bacff25652c96e1527610c69e91f7c38
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

