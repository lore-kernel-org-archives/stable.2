Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB0492E5D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913511; cv=none; b=SDpwPrb0B+TEBp72T3CDbWbUgJGGgSIH4pBoUFohT1AHnTt+nb3OQSfsOCZLO6QRbZcOtnnyR63MakA50te3LDR43nDS5TGdPIf9BxpzipBUWN4Pmca6eXp0gON+oMg6ezIJvRkw8M4LpnXTF650zomOF+A/wPoyP7IMbMCq0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913511; c=relaxed/simple;
	bh=iX+jy9fMMlPAZXun53BnXlhoERZ9Z0SbX1nHQoHNSUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeAaiwEHdJMzgquXQ0qEeRQkyH8yHF5K6+iUjk53ddZ9B8ggp7yy4ihWNjhuOi7tVeLRMifY6HH1ZtYX1olijIROMrDudqNcNxhXcgd3fI5GC4VPOA3rmSWjJdYrhpsaLKH6SjFV0errH9rIpZZxc3obYSEoz01XJsFjXS0LAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWhEpVzr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWhEpVzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D24B1F00A3A;
	Wed,  9 Sep 2026 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913509;
	bh=2kdO9TxcsrNLtM2SALrHLfn/F2g1ueu/rWzmZCah8O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CWhEpVzrcKzhHg4afeYynv+pu+vijpGXgffCz+etEu7SWqhWxiPpK4PYHaSsV3OHZ
	 zg8aD8E4Vbd7TZnJ4VbG7CBc04VWkn1T5Rs5vbjU7VPakobmjIIdNRFBPpsGtgl1Mi
	 VGeNGJVZ0/GtMo8IOh+TZCx0kGz9HaDPoqCMD7B/nmaS+HmVclWMG79N7apYHkNnov
	 tLh2kTt3eyzavFP0v1XwIdbT3fAwrG2SOvF9IVMHLGvDaD5OQv3Z5KV1HiMBikK7aq
	 lIZSE5zP8/FSFxUQj5Y2/Fjl90I0uLBGIJLE9LCkMj4LxCpBMJI3gLT91Vawjsl3C7
	 bBeXkVvUBX//A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: dropreason: add SKB_DROP_REASON_FRAG_TOO_FAR
Date: Tue,  8 Sep 2026 20:25:06 -0400
Message-ID: <20260909002507.725158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-sagging-obliged-3e7b@gregkh>
References: <2026090351-sagging-obliged-3e7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3bdfb04f13ebdd4ae50fc5dc595663874781e48c ]

IPv4 reassembly unit can decide to drop frags based on
/proc/sys/net/ipv4/ipfrag_max_dist sysctl.

Add a specific drop reason to track this specific
and weird case.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 5.15: the original IPv4 drop-reason change cannot be
represented because this tree predates include/net/dropreason.h and the
reason-aware fragment purge API. Add only SKB_DROP_REASON_IPV6DISABLED to
the older enum and trace table, and align the IPv6 routing-header code so
the dependent fix applies cleanly. ]

[ sashal: Reduced backport -- upstream 3bdfb04f13ebd touches 2 file(s), this
  backport carries 3. Not backported here:
  include/net/dropreason.h
  net/ipv4/ip_fragment.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f826df95332c ("ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h     |  1 +
 include/trace/events/skb.h |  1 +
 net/ipv6/exthdrs.c         | 12 +++---------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 24ceeab1b509f..af4924ceafe61 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -337,6 +337,7 @@ enum skb_drop_reason {
 						  * is multicast, but L3 is
 						  * unicast.
 						  */
+	SKB_DROP_REASON_IPV6DISABLED,	/* IPv6 is disabled on the device */
 	SKB_DROP_REASON_MAX,
 };
 
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 485a1d3034a4b..33bebe0c7677e 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -23,6 +23,7 @@
 	EM(SKB_DROP_REASON_IP_RPFILTER, IP_RPFILTER)		\
 	EM(SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST,		\
 	   UNICAST_IN_L2_MULTICAST)				\
+	EM(SKB_DROP_REASON_IPV6DISABLED, IPV6DISABLED)		\
 	EMe(SKB_DROP_REASON_MAX, MAX)
 
 #undef EM
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 3c6de4ccbf53b..3bfe826c3134f 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -495,7 +495,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *idev;
 	struct ipv6hdr *oldhdr;
-	struct in6_addr addr;
 	unsigned int chdr_len;
 	unsigned char *buf;
 	int accept_rpl_seg;
@@ -505,10 +504,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 	idev = __in6_dev_get(skb->dev);
 
-	accept_rpl_seg = net->ipv6.devconf_all->rpl_seg_enabled;
-	if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
-		accept_rpl_seg = idev->cnf.rpl_seg_enabled;
-
+	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
+			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 	if (!accept_rpl_seg) {
 		kfree_skb(skb);
 		return -1;
@@ -607,9 +604,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	addr = ipv6_hdr(skb)->daddr;
-	ipv6_hdr(skb)->daddr = ohdr->rpl_segaddr[i];
-	ohdr->rpl_segaddr[i] = addr;
+	swap(ipv6_hdr(skb)->daddr, ohdr->rpl_segaddr[i]);
 
 	ipv6_rpl_srh_compress(chdr, ohdr, &ipv6_hdr(skb)->daddr, n);
 
@@ -690,7 +685,6 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	int accept_source_route;
 
-	idev = __in6_dev_get(skb->dev);
 	accept_source_route = READ_ONCE(net->ipv6.devconf_all->accept_source_route);
 
 	if (idev)
-- 
2.53.0

