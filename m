Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074B42A141;
	Mon, 17 Aug 2026 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973338; cv=none; b=SwvgApOzYh6VwksrqOO4P1R2O1vXPp56tPekEQFIzvsu9cC+bNk4rV2njF9U4THfCvhsx78vUw3ZcdYBBuUpmJpg8SHbUlSP6SKrANsvWS07y4xq4NTumzP120YHH02sCn8LtWWcdo2w+uaR/zBBnT4mp60yKZ/XYYZ9Z4XIDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973338; c=relaxed/simple;
	bh=ECnA9N6J6yvXElKohPbOxCBbjQKGS74I1vdWAggDW8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gC9wWpkZpiAj3JAYJChvNoULhDIqkuKFq4XQTWU4BIK20lp1mVTKLgOu8YcVQPi+xF5whxkI1eo6nwkH3Jgpr8BTb7P2T4JGIMJocO0JitnfF+n+AhTJZ2W10P1gPVEUiO6CWQb8jfh2P5zlV2jRgffE89kHZTP+FITOSB+DH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 67HDSDVD004409;
	Mon, 17 Aug 2026 15:28:18 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, idosch@nvidia.com, alex.aring@gmail.com,
        justin.iurman@gmail.com, bestswngs@gmail.com,
        stefano.salsano@uniroma2.it, xmei5@asu.edu,
        Andrea Mayer <andrea.mayer@uniroma2.it>, stable@vger.kernel.org
Subject: [PATCH net v3] ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()
Date: Mon, 17 Aug 2026 15:26:44 +0200
Message-Id: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

ipv6_rpl_srh_rcv() dereferences idev from __in6_dev_get() without a NULL
check when reading idev->cnf.rpl_seg_enabled.

When the device's MTU drops below IPV6_MIN_MTU, addrconf_ifdown() clears
dev->ip6_ptr through RCU_INIT_POINTER(). A packet that passed the idev
check in ip6_rcv_core() can then reach ipv6_rpl_srh_rcv() with
dev->ip6_ptr already NULL.

Reproduced by flooding the receiving interface with ping6 traffic while
flapping its MTU between 1500 and 1200:

 BUG: KASAN: null-ptr-deref in ipv6_rpl_srh_rcv+0xb3/0x1070
 Read of size 4 at addr 00000000000006b4 by task ping6/394

 CPU: 2 UID: 0 PID: 394 Comm: ping6 Not tainted 7.2.0-rc7-micro-vm-dev-00095-g24ef02f934ee #240 PREEMPT(full)
 Call Trace:
  <IRQ>
  kasan_report+0xc6/0x100
  ipv6_rpl_srh_rcv+0xb3/0x1070
  ip6_protocol_deliver_rcu+0x759/0x9a0
  ip6_input_finish+0xa8/0x1b0
  ip6_input+0xe1/0x490
  ipv6_rcv+0x33d/0x460
  __netif_receive_skb_one_core+0xd6/0x130
  process_backlog+0x2cc/0xa00
  __napi_poll.constprop.0+0x56/0x270
  net_rx_action+0x327/0x730
  handle_softirqs+0x11e/0x630
  do_softirq+0xb3/0xf0
  </IRQ>

Both ipv6_rpl_srh_rcv() and ipv6_srh_rcv() are called only from
ipv6_rthdr_rcv(), which already has an idev lookup.

Fix the NULL dereference on the RPL path by checking idev in
ipv6_rthdr_rcv(), before it calls either function. The callees take idev as
an argument and no longer call __in6_dev_get(), so the packet is now
dropped in one place, with SKB_DROP_REASON_IPV6DISABLED on both paths.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Tested-by: Xiang Mei <xmei5@asu.edu>
---
v3:
  - move the idev NULL check into ipv6_rthdr_rcv() and use the same drop
    reason on the seg6 and RPL paths (David Ahern)
  - pass idev to ipv6_srh_rcv() and ipv6_rpl_srh_rcv(), and check it for
    NULL in ipv6_rthdr_rcv() only for the seg6 and RPL types
  - add Xiang Mei's Tested-by tag
v2: https://lore.kernel.org/netdev/20260518140630.24280-1-andrea.mayer@uniroma2.it/
  - use SKB_DROP_REASON_IPV6DISABLED as drop reason (Eric Dumazet)
v1: https://lore.kernel.org/netdev/20260428224816.11223-1-andrea.mayer@uniroma2.it/
---
 net/ipv6/exthdrs.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 9c677eb1d1a6..51941ad656a3 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -368,23 +368,16 @@ static void seg6_update_csum(struct sk_buff *skb)
 			   (__be32 *)addr);
 }
 
-static int ipv6_srh_rcv(struct sk_buff *skb)
+static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
 	struct ipv6_sr_hdr *hdr;
-	struct inet6_dev *idev;
 	struct in6_addr *addr;
 	int accept_seg6;
 
 	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
-	idev = __in6_dev_get(skb->dev);
-	if (!idev) {
-		kfree_skb(skb);
-		return -1;
-	}
-
 	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
 			  READ_ONCE(idev->cnf.seg6_enabled));
 
@@ -485,12 +478,11 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	return -1;
 }
 
-static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
+static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 {
 	struct ipv6_rpl_sr_hdr *hdr, *ohdr, *chdr;
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
-	struct inet6_dev *idev;
 	struct ipv6hdr *oldhdr;
 	unsigned int chdr_len;
 	unsigned char *buf;
@@ -499,8 +491,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	u64 n = 0;
 	u32 r;
 
-	idev = __in6_dev_get(skb->dev);
-
 	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
 			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 	if (!accept_rpl_seg) {
@@ -689,10 +679,14 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	switch (hdr->type) {
 	case IPV6_SRCRT_TYPE_4:
 		/* segment routing */
-		return ipv6_srh_rcv(skb);
+		if (!idev)
+			goto disabled;
+		return ipv6_srh_rcv(skb, idev);
 	case IPV6_SRCRT_TYPE_3:
 		/* rpl segment routing */
-		return ipv6_rpl_srh_rcv(skb);
+		if (!idev)
+			goto disabled;
+		return ipv6_rpl_srh_rcv(skb, idev);
 	default:
 		break;
 	}
@@ -837,6 +831,10 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
 			  (&hdr->type) - skb_network_header(skb));
 	return -1;
+
+disabled:
+	kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
+	return -1;
 }
 
 static const struct inet6_protocol rthdr_protocol = {
-- 
2.43.0

