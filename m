Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407A492E4C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913527; cv=none; b=aW3rh5XZnL8Mx9aUlxQB5jYy9Nl2KQoigJGKzlG+q0iUij973kmQ+E61Wy5eeM2V0IdYCTKGeuqiCLIUYcIkauacDl7dq7p+NmC0g8CKlCMp93O439omBZ9YlNPAfN56tW7mdhOl8XaO9pabiPwNbrIN4QI/lvfSMJtPjLpWlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913527; c=relaxed/simple;
	bh=AVMg0+AVli0e4pWzEt0tWVZSesPONuKv9mDeych1PMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtHi27z34NAW0q8m2xN/gc12ccJJ1yQlKiWrt+pZoMGFkpsI5x+GyslZu0pbKBKMb2NXjHCEmFDg5yFRGGjXUnXG+lCJ0sMpDiHAvXqAhlobMJUqXavM9SGe+jx5DCKG3PWRbDNtdjesSgbher3sM0ywlEGuu/RCXkZ27oQCp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVhmZ8pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVhmZ8pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38421F00A3A;
	Wed,  9 Sep 2026 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913525;
	bh=PX7lFQKPLWz3sYF8UK2gXtabA43cn3FemkcrZDPaZKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YVhmZ8ptVBb7xcpJxeKwl/UyaLYe/IxGfwuBPNiT1PPN3g0LhUEKNTZhY1AZueMcS
	 yoJRpUFVaj60Uybin60a5CgUJSCUB7pn1Z01IvxSN8vAbR9KLezfDwjIDBYc9DFiye
	 rYgbUDR4Ppv+g6My+jFVtnu02ZsF0D0KDxIQkD4RmjCx82qflipZEpiWtifJWRSfYz
	 XpNyEedF0N2EifGMUd7ru87ZTLP185VSrxrs6189NyNmHkGPbmu30MGRSFsxgAXwhl
	 btEiFgJIprrfkLCPlr2aon1hOumcWSyMWY/FkIyNmzX1H8tsGj7msPuxc0Me6GTnn4
	 I68w3ekCAX2BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ipv6/addrconf: annotate data-races around devconf fields (II)
Date: Tue,  8 Sep 2026 20:25:22 -0400
Message-ID: <20260909002523.727517-1-sashal@kernel.org>
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

[ Backport to 5.10: omit ioam6.c and annotations for fields and control
  flow only present in newer kernels. Preserve the applicable data-race
  annotations, and annotate rpl_seg_enabled as well so the dependent IPv6
  RPL fix applies against its expected context. ]

[ sashal: Reduced backport -- upstream 2f0ff05a44302 touches 7 file(s), this
  backport carries 6. Not backported here:
  net/ipv6/ioam6.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f826df95332c ("ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c  | 47 +++++++++++++++++++++++---------------------
 net/ipv6/exthdrs.c   | 20 +++++++++----------
 net/ipv6/ip6_input.c |  2 +-
 net/ipv6/mcast.c     | 14 ++++++-------
 net/ipv6/ndisc.c     | 12 +++++------
 net/ipv6/seg6_hmac.c |  8 +++++---
 6 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3bb1855cdcb87..6d5a4a7fb18fe 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1492,15 +1492,17 @@ static inline int ipv6_saddr_preferred(int type)
 	return 0;
 }
 
-static bool ipv6_use_optimistic_addr(struct net *net,
-				     struct inet6_dev *idev)
+static bool ipv6_use_optimistic_addr(const struct net *net,
+				     const struct inet6_dev *idev)
 {
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	if (!idev)
 		return false;
-	if (!net->ipv6.devconf_all->optimistic_dad && !idev->cnf.optimistic_dad)
+	if (!READ_ONCE(net->ipv6.devconf_all->optimistic_dad) &&
+	    !READ_ONCE(idev->cnf.optimistic_dad))
 		return false;
-	if (!net->ipv6.devconf_all->use_optimistic && !idev->cnf.use_optimistic)
+	if (!READ_ONCE(net->ipv6.devconf_all->use_optimistic) &&
+	    !READ_ONCE(idev->cnf.use_optimistic))
 		return false;
 
 	return true;
@@ -1509,13 +1511,14 @@ static bool ipv6_use_optimistic_addr(struct net *net,
 #endif
 }
 
-static bool ipv6_allow_optimistic_dad(struct net *net,
-				      struct inet6_dev *idev)
+static bool ipv6_allow_optimistic_dad(const struct net *net,
+				      const struct inet6_dev *idev)
 {
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	if (!idev)
 		return false;
-	if (!net->ipv6.devconf_all->optimistic_dad && !idev->cnf.optimistic_dad)
+	if (!READ_ONCE(net->ipv6.devconf_all->optimistic_dad) &&
+	    !READ_ONCE(idev->cnf.optimistic_dad))
 		return false;
 
 	return true;
@@ -1797,7 +1800,7 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 		idev = __in6_dev_get(dst_dev);
 		if ((dst_type & IPV6_ADDR_MULTICAST) ||
 		    dst.scope <= IPV6_ADDR_SCOPE_LINKLOCAL ||
-		    (idev && idev->cnf.use_oif_addrs_only)) {
+		    (idev && READ_ONCE(idev->cnf.use_oif_addrs_only))) {
 			use_oif_addr = true;
 		}
 	}
@@ -2628,8 +2631,8 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
 		};
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-		if ((net->ipv6.devconf_all->optimistic_dad ||
-		     in6_dev->cnf.optimistic_dad) &&
+		if ((READ_ONCE(net->ipv6.devconf_all->optimistic_dad) ||
+		     READ_ONCE(in6_dev->cnf.optimistic_dad)) &&
 		    !net->ipv6.devconf_all->forwarding && sllao)
 			cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -3226,8 +3229,8 @@ void addrconf_add_linklocal(struct inet6_dev *idev,
 	struct inet6_ifaddr *ifp;
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-	if ((dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad ||
-	     idev->cnf.optimistic_dad) &&
+	if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad) ||
+	     READ_ONCE(idev->cnf.optimistic_dad)) &&
 	    !dev_net(idev->dev)->ipv6.devconf_all->forwarding)
 		cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -3784,10 +3787,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 */
 	if (!unregister && !idev->cnf.disable_ipv6) {
 		/* aggregate the system setting and interface setting */
-		int _keep_addr = net->ipv6.devconf_all->keep_addr_on_down;
+		int _keep_addr = READ_ONCE(net->ipv6.devconf_all->keep_addr_on_down);
 
 		if (!_keep_addr)
-			_keep_addr = idev->cnf.keep_addr_on_down;
+			_keep_addr = READ_ONCE(idev->cnf.keep_addr_on_down);
 
 		keep_addr = (_keep_addr > 0);
 	}
@@ -4009,8 +4012,8 @@ static void addrconf_dad_begin(struct inet6_ifaddr *ifp)
 
 	net = dev_net(dev);
 	if (dev->flags&(IFF_NOARP|IFF_LOOPBACK) ||
-	    (net->ipv6.devconf_all->accept_dad < 1 &&
-	     idev->cnf.accept_dad < 1) ||
+	    (READ_ONCE(net->ipv6.devconf_all->accept_dad) < 1 &&
+	     READ_ONCE(idev->cnf.accept_dad) < 1) ||
 	    !(ifp->flags&IFA_F_TENTATIVE) ||
 	    ifp->flags & IFA_F_NODAD) {
 		bool send_na = false;
@@ -4102,8 +4105,8 @@ static void addrconf_dad_work(struct work_struct *w)
 		action = DAD_ABORT;
 		ifp->state = INET6_IFADDR_STATE_POSTDAD;
 
-		if ((dev_net(idev->dev)->ipv6.devconf_all->accept_dad > 1 ||
-		     idev->cnf.accept_dad > 1) &&
+		if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->accept_dad) > 1 ||
+		     READ_ONCE(idev->cnf.accept_dad) > 1) &&
 		    !idev->cnf.disable_ipv6 &&
 		    !(ifp->flags & IFA_F_STABLE_PRIVACY)) {
 			struct in6_addr addr;
@@ -4241,8 +4244,8 @@ static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
 
 	/* send unsolicited NA if enabled */
 	if (send_na &&
-	    (ifp->idev->cnf.ndisc_notify ||
-	     dev_net(dev)->ipv6.devconf_all->ndisc_notify)) {
+	    (READ_ONCE(ifp->idev->cnf.ndisc_notify) ||
+	     READ_ONCE(dev_net(dev)->ipv6.devconf_all->ndisc_notify))) {
 		ndisc_send_na(dev, &in6addr_linklocal_allnodes, &ifp->addr,
 			      /*router=*/ !!ifp->idev->cnf.forwarding,
 			      /*solicited=*/ false, /*override=*/ true,
@@ -6389,7 +6392,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
 			struct net_device *dev;
 
-			net->ipv6.devconf_dflt->addr_gen_mode = new_val;
+			WRITE_ONCE(net->ipv6.devconf_dflt->addr_gen_mode, new_val);
 			for_each_netdev(net, dev) {
 				idev = __in6_dev_get(dev);
 				if (idev &&
@@ -6400,7 +6403,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 			}
 		}
 
-		*((u32 *)ctl->data) = new_val;
+		WRITE_ONCE(*((u32 *)ctl->data), new_val);
 	}
 
 out:
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 0230fa98a3482..bc01761844194 100644
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
@@ -491,9 +490,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 	idev = __in6_dev_get(skb->dev);
 
-	accept_rpl_seg = net->ipv6.devconf_all->rpl_seg_enabled;
-	if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
-		accept_rpl_seg = idev->cnf.rpl_seg_enabled;
+	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
+			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 
 	if (!accept_rpl_seg) {
 		kfree_skb(skb);
@@ -674,11 +672,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
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
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8cf5b10eee695..85e14f9df3a63 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -229,7 +229,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	if (!ipv6_addr_is_multicast(&hdr->daddr) &&
 	    (skb->pkt_type == PACKET_BROADCAST ||
 	     skb->pkt_type == PACKET_MULTICAST) &&
-	    idev->cnf.drop_unicast_in_l2_multicast)
+	    READ_ONCE(idev->cnf.drop_unicast_in_l2_multicast))
 		goto err;
 
 	/* RFC4291 2.7
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index c4a9866ea45b6..cdbff3dc89ced 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -162,9 +162,9 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	int iv;
 
 	if (mld_in_v1_mode(idev))
-		iv = idev->cnf.mldv1_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv1_unsolicited_report_interval);
 	else
-		iv = idev->cnf.mldv2_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv2_unsolicited_report_interval);
 
 	return iv > 0 ? iv : 1;
 }
@@ -1218,15 +1218,15 @@ static bool mld_marksources(struct ifmcaddr6 *pmc, int nsrcs,
 
 static int mld_force_mld_version(const struct inet6_dev *idev)
 {
+	const struct net *net = dev_net(idev->dev);
+	int all_force;
+
+	all_force = READ_ONCE(net->ipv6.devconf_all->force_mld_version);
 	/* Normally, both are 0 here. If enforcement to a particular is
 	 * being used, individual device enforcement will have a lower
 	 * precedence over 'all' device (.../conf/all/force_mld_version).
 	 */
-
-	if (dev_net(idev->dev)->ipv6.devconf_all->force_mld_version != 0)
-		return dev_net(idev->dev)->ipv6.devconf_all->force_mld_version;
-	else
-		return idev->cnf.force_mld_version;
+	return all_force ?: READ_ONCE(idev->cnf.force_mld_version);
 }
 
 static bool mld_in_v2_mode_only(const struct inet6_dev *idev)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index de389b519700d..e8e3ea61e0623 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -450,7 +450,7 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 
 	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
-	tclass = idev ? idev->cnf.ndisc_tclass : 0;
+	tclass = idev ? READ_ONCE(idev->cnf.ndisc_tclass) : 0;
 	rcu_read_unlock();
 
 	skb_push(skb, sizeof(*hdr));
@@ -538,7 +538,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 		src_addr = solicited_addr;
 		if (ifp->flags & IFA_F_OPTIMISTIC)
 			override = false;
-		inc_opt |= ifp->idev->cnf.force_tllao;
+		inc_opt |= READ_ONCE(ifp->idev->cnf.force_tllao);
 		in6_ifa_put(ifp);
 	} else {
 		if (ipv6_dev_get_saddr(dev_net(dev), dev, daddr,
@@ -991,7 +991,7 @@ static void ndisc_recv_na(struct sk_buff *skb)
 	 * and thus should not be accepted.
 	 */
 	if (!msg->icmph.icmp6_solicited && idev &&
-	    idev->cnf.drop_unsolicited_na)
+	    READ_ONCE(idev->cnf.drop_unsolicited_na))
 		return;
 
 	if (!ndisc_parse_options(dev, msg->opt, ndoptlen, &ndopts)) {
@@ -1737,7 +1737,7 @@ static bool ndisc_suppress_frag_ndisc(struct sk_buff *skb)
 	if (!idev)
 		return true;
 	if (IP6CB(skb)->flags & IP6SKB_FRAGMENTED &&
-	    idev->cnf.suppress_frag_ndisc) {
+	    READ_ONCE(idev->cnf.suppress_frag_ndisc)) {
 		net_warn_ratelimited("Received fragmented ndisc packet. Carefully consider disabling suppress_frag_ndisc.\n");
 		return true;
 	}
@@ -1812,8 +1812,8 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 		idev = in6_dev_get(dev);
 		if (!idev)
 			break;
-		if (idev->cnf.ndisc_notify ||
-		    net->ipv6.devconf_all->ndisc_notify)
+		if (READ_ONCE(idev->cnf.ndisc_notify) ||
+		    READ_ONCE(net->ipv6.devconf_all->ndisc_notify))
 			ndisc_send_unsol_na(dev);
 		in6_dev_put(idev);
 		break;
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index b52985c867c29..abccc86990c1a 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -243,6 +243,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	struct sr6_tlv_hmac *tlv;
 	struct ipv6_sr_hdr *srh;
 	struct inet6_dev *idev;
+	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
 	if (!idev)
@@ -252,16 +253,17 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 
 	tlv = seg6_get_tlv_hmac(srh);
 
+	require_hmac = READ_ONCE(idev->cnf.seg6_require_hmac);
 	/* mandatory check but no tlv */
-	if (idev->cnf.seg6_require_hmac > 0 && !tlv)
+	if (require_hmac > 0 && !tlv)
 		return false;
 
 	/* no check */
-	if (idev->cnf.seg6_require_hmac < 0)
+	if (require_hmac < 0)
 		return true;
 
 	/* check only if present */
-	if (idev->cnf.seg6_require_hmac == 0 && !tlv)
+	if (require_hmac == 0 && !tlv)
 		return true;
 
 	/* now, seg6_require_hmac >= 0 && tlv */
-- 
2.53.0

