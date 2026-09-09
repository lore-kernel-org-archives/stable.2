Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B82E7F39
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917476; cv=none; b=WwgTnL8K5gpXKWMyZ5UYZ1RA7k9Lu6w+MVv3rqHPZ8zo0Xxa1irfq8IDTz4aDwCAH9XB73QxkrtVG6yzYUp3QZRKQcmn7qQTQpG6b0TEtEZP47jFntlw4u4iBcJK9dD+ULupNppmE9uGtan0aoM9C4BxaTGb7wJQ4Ujb4aingIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917476; c=relaxed/simple;
	bh=TKH0PVoyUmctdFFISiNWbUyYkB93PkADRbBPGArIfpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlpfP23Dw3+R+Nu5SSUn2EZlN86Iw73S+tBDiTcbYIn5XYBfQ3Wxr/DiZADpNn2tiynKBTATUjqq3tYT/6WudnKLa/OirQPBC1kJzE1bMKHgAYxVRGVhzxqNOkvPT0yX2nvEQsIjfTtvNHck8rKXBwCttIi/9PKeIsXRryacGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTebgHkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTebgHkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6AE1F00A3F;
	Wed,  9 Sep 2026 01:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917474;
	bh=GYVGysDi72IxPQZ7CE2G7ciBeGBYRVNpUIY5N161KGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTebgHkEcZxyYIro3vxK/ogKAMMxsyPmtRa096EkupIWPJtCWvLzlU7UrD8c3YB9o
	 rpFe64mJg6HYu4gP9xTWaOmwj5jgU+Lh/d1Qyhox8rptQ4FGdlhJJ3YOZeSRSo3K/n
	 1AStYf0UwNCak1gFTiZbTlPSGK9+EAPPRhZkiakBNykknkAgwgU6T33YUsAmO4Etba
	 34MX1louSAuHqM4/DCSSdzbDhSi04mxxLCuzqVOQY+7B2Ls9423gZtu+Oevy6/ZYho
	 qVF0LUcnFGGbZMZQHVBWvp2bt2gRRmwBuago52G099mbJMJ3h0CWhq1+hkfmN7eFvt
	 reZ5hWoMXVCvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ipv6/addrconf: annotate data-races around devconf fields (II)
Date: Tue,  8 Sep 2026 21:31:11 -0400
Message-ID: <20260909013112.887941-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-marbling-tiny-a334@gregkh>
References: <2026090351-marbling-tiny-a334@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2f0ff05a44302c91af54a5f9efe1b65b7681540e ]

Final (?) round of this series.

Annotate lockless reads on following devconf fields,
because they be changed concurrently from /proc/net/ipv6/conf.

- accept_dad
- optimistic_dad
- use_optimistic
- use_oif_addrs_only
- ra_honor_pio_life
- keep_addr_on_down
- ndisc_notify
- ndisc_evict_nocarrier
- suppress_frag_ndisc
- addr_gen_mode
- seg6_enabled
- ioam6_enabled
- ioam6_id
- ioam6_id_wide
- drop_unicast_in_l2_multicast
- mldv[12]_unsolicited_report_interval
- force_mld_version
- force_tllao
- accept_untracked_na
- drop_unsolicited_na
- accept_source_route

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Backport notes for Linux 5.10:

Keep only the routing-header annotations in net/ipv6/exthdrs.c. The
addrconf, input, multicast, neighbour-discovery, HMAC and IOAM hunks are
not needed by f826df95332c07380206dbd54178b6eefb311aba. In particular,
this tree lacks IOAM and several newer devconf fields and drop reasons.

Also annotate rpl_seg_enabled with READ_ONCE() and min(), and use swap()
for the existing RPL address exchange, eliminating its temporary address.
These changes supply the exact RPL context expected by the target without
adding functions or importing unrelated receive-path refactors. Keep the
existing SRv6 NULL check for the target to move to the common caller.

Remove the redundant second idev lookup in ipv6_rthdr_rcv() while adapting
the accept_source_route annotation. Use the already acquired RCU pointer.

Provide a macro local to the routing-header section mapping
kfree_skb_reason(skb, reason) to kfree_skb(skb). Linux 5.10 has no skb drop
reason API; this permits the unchanged target to build while retaining
this branch's existing packet-freeing semantics. No reason enum or new
function is introduced.

[ sashal: Reduced backport -- upstream 2f0ff05a44302 touches 7 file(s), this
  backport carries 1. Not backported here:
  net/ipv6/addrconf.c
  net/ipv6/ioam6.c
  net/ipv6/ip6_input.c
  net/ipv6/mcast.c
  net/ipv6/ndisc.c
  net/ipv6/seg6_hmac.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f826df95332c ("ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 0230fa98a3482..8099715a08a5d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -368,9 +368,8 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	accept_seg6 = net->ipv6.devconf_all->seg6_enabled;
-	if (accept_seg6 > idev->cnf.seg6_enabled)
-		accept_seg6 = idev->cnf.seg6_enabled;
+	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
+			  READ_ONCE(idev->cnf.seg6_enabled));
 
 	if (!accept_seg6) {
 		kfree_skb(skb);
@@ -481,7 +480,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *idev;
 	struct ipv6hdr *oldhdr;
-	struct in6_addr addr;
 	unsigned int chdr_len;
 	unsigned char *buf;
 	int accept_rpl_seg;
@@ -491,10 +489,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
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
@@ -593,9 +589,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	addr = ipv6_hdr(skb)->daddr;
-	ipv6_hdr(skb)->daddr = ohdr->rpl_segaddr[i];
-	ohdr->rpl_segaddr[i] = addr;
+	swap(ipv6_hdr(skb)->daddr, ohdr->rpl_segaddr[i]);
 
 	ipv6_rpl_srh_compress(chdr, ohdr, &ipv6_hdr(skb)->daddr, n);
 
@@ -663,6 +657,9 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
   Routing header.
  ********************************/
 
+/* This stable tree has no skb drop-reason accounting. */
+#define kfree_skb_reason(skb, reason) kfree_skb(skb)
+
 /* called with rcu_read_lock() */
 static int ipv6_rthdr_rcv(struct sk_buff *skb)
 {
@@ -674,11 +671,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	struct ipv6_rt_hdr *hdr;
 	struct rt0_hdr *rthdr;
 	struct net *net = dev_net(skb->dev);
-	int accept_source_route = net->ipv6.devconf_all->accept_source_route;
+	int accept_source_route;
 
-	idev = __in6_dev_get(skb->dev);
-	if (idev && accept_source_route > idev->cnf.accept_source_route)
-		accept_source_route = idev->cnf.accept_source_route;
+	accept_source_route = READ_ONCE(net->ipv6.devconf_all->accept_source_route);
+
+	if (idev)
+		accept_source_route = min(accept_source_route,
+					  READ_ONCE(idev->cnf.accept_source_route));
 
 	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
@@ -858,6 +857,8 @@ static const struct inet6_protocol rthdr_protocol = {
 	.flags		=	INET6_PROTO_NOPOLICY,
 };
 
+#undef kfree_skb_reason
+
 static const struct inet6_protocol destopt_protocol = {
 	.handler	=	ipv6_destopt_rcv,
 	.flags		=	INET6_PROTO_NOPOLICY,
-- 
2.53.0

