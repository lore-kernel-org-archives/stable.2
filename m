Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94850552954
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884716; cv=none; b=uia5Q0s46wtVHZPjdRQaCLcxJdUuUBuz9Qh7/Fy15yhJlLbCxZ6mZaWYvD4K7yXtYe5vCgAVv961VYF78eVMeNEcai80KPmKjj915oOaCHvGP36bQ5/faTCsgWG+9wGS9EaTr+Ev+su3QZ14djGnVRMZDYKUvaZjerTl10gnwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884716; c=relaxed/simple;
	bh=JcwYpfOzspIoDsWVcchzU39xOYfuIYzF+/3S2F1DvPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfHdjq3Ieoo+sglTIpOVgfYoxnX9KTDvYfEV4pwFq9qZcu8Qd42JxcDBr5ygM9g5Rtep3C7+CnMtXs4gZ1i8cDQWe0htALBPNu78vPGEhksh4WzD3LQL30tZXlGykBdKnFZI5kRudpIi46KhNaOQrKxvQMftzK23FC2HdXmvxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuVcJ+Xi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuVcJ+Xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD63C1F00A3A;
	Tue,  8 Sep 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884715;
	bh=BnaxceyUfA0HzeYI94DXbGDvt18I/yv5WzsTO46CHyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fuVcJ+XixXkGSm1hYkdY0PGMO8htUTUc+8Uy/puKMlktH19kcMKsS9evyKaPnHwZ/
	 9ZyHGO8F6vKNvZh/gMWidKR0DZfMQv3pl0o2Pl8iTAxgJK5xInwiH5U5CnnWCq8XBI
	 nvIk3W18TaFtII7ZAy8l9/l/0acKzghrGu+p4qLkkqbj+bOhXEH7JJq1YGaXjc8cZD
	 THR25p0Zauh9S7TtuWgVZERaoLbSCVsnluDI9mFIRYuOEl4sxO5D7sCvt6PLW3OQTI
	 9/UoWksnNQbyN+eyfUBE9o3HiXZmn5lijovVrixIqxhZTxzZg2kK+AQlLaxKU2GrEB
	 9z8kE+VXkdrHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	Xiang Mei <xmei5@asu.edu>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()
Date: Tue,  8 Sep 2026 12:25:12 -0400
Message-ID: <20260908162512.2643067-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908162512.2643067-1-sashal@kernel.org>
References: <2026090350-vaseline-matchbook-9e16@gregkh>
 <20260908162512.2643067-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrea Mayer <andrea.mayer@uniroma2.it>

[ Upstream commit f826df95332c07380206dbd54178b6eefb311aba ]

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
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260817132644.2223-1-andrea.mayer@uniroma2.it
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 7f2d7cf976a93..b15a0c2c8d54e 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -370,23 +370,16 @@ static void seg6_update_csum(struct sk_buff *skb)
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
 
@@ -487,12 +480,11 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
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
@@ -501,8 +493,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	u64 n = 0;
 	u32 r;
 
-	idev = __in6_dev_get(skb->dev);
-
 	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
 			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 	if (!accept_rpl_seg) {
@@ -691,10 +681,14 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
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
@@ -839,6 +833,10 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
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
2.53.0

