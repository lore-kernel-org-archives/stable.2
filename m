Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC430C35C
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098800; cv=none; b=mxUM8f26h6KaktBJWyS4FYd/pfkgsAmVRgcbG/2vIiYdhtAGndmXzF8v0kfuu3FjRvKFzkY8MjbRygAq83qlXbaVsOcOeXDneRh84K8HoxX1137tdpOXfk34OXHy+VI/WhTbVjFHNHCFy2SnjYUvgdlP645JtaaAcxFm9MGVVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098800; c=relaxed/simple;
	bh=fdLoJ4POJFaa++Abi/OAab1Y76pYNdo+9H6ym+F3zno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMXiyYjljHgdiNb/0Qo5njSu1xhHGXvTESzEH35b3AibT4WtBSMqzmkF808HKyucMRqM25LNhuPfmadfh/7ehTfnHX/dPE6ZsnWS7daBgvTMACAZ2lJJ/IwUF+LteDGINUMchi+dV+cadLPOCT83Yr1CaF/SvGrIoMuaHS0Esjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF48IMCq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF48IMCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AFC1F00893;
	Fri, 29 May 2026 23:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098798;
	bh=hKdKmaifyjSSJTaY5HVqmeVaErxSxK34HrUl62IG0PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MF48IMCqbO5hDVjafEzQ10x5z32y3gxyRVV6qQ8HueyGCswjOAfdWdyDNQt8Z5T1V
	 KEfrjITK7Lxpl6v2y7D4jG3p4rq6GkJ8g2YkGts/AleQt4Dwz4aF02q2hMVN5hwz7z
	 ndEziBS9Ft8iC1i36R2v+4f63yNQkfuF745G3O7Euqd34quOEIGfyJWU0sd0s7V9ZV
	 XqKObGnbYFh+irsKhK3aLb80ZP4AF4czmm7sBaebzSMM+u1bdjmnm9BaokfBJi0Xyf
	 Kvk6iSWq228TYhPH9E6iQQ9jAzhPO1PYY5JXnBUHO2CkAKghLYVWqrf9lCxc3YmUiH
	 Saeh+OzC2hLVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ipv6/addrconf: annotate data-races around devconf fields (II)
Date: Fri, 29 May 2026 19:53:15 -0400
Message-ID: <20260529235316.1963855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052812-uncoated-spry-43e1@gregkh>
References: <2026052812-uncoated-spry-43e1@gregkh>
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
Stable-dep-of: d4ea0dfd7501 ("ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c  | 47 +++++++++++++++++++++++---------------------
 net/ipv6/exthdrs.c   | 16 ++++++++-------
 net/ipv6/ioam6.c     |  8 ++++----
 net/ipv6/ip6_input.c |  2 +-
 net/ipv6/mcast.c     | 14 ++++++-------
 net/ipv6/ndisc.c     | 18 ++++++++---------
 net/ipv6/seg6_hmac.c |  8 +++++---
 7 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 32fa6236dacdd..c880590090b34 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1518,15 +1518,17 @@ static inline int ipv6_saddr_preferred(int type)
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
@@ -1535,13 +1537,14 @@ static bool ipv6_use_optimistic_addr(struct net *net,
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
@@ -1823,7 +1826,7 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 		idev = __in6_dev_get(dst_dev);
 		if ((dst_type & IPV6_ADDR_MULTICAST) ||
 		    dst.scope <= IPV6_ADDR_SCOPE_LINKLOCAL ||
-		    (idev && idev->cnf.use_oif_addrs_only)) {
+		    (idev && READ_ONCE(idev->cnf.use_oif_addrs_only))) {
 			use_oif_addr = true;
 		}
 	}
@@ -2662,8 +2665,8 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
 		};
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-		if ((net->ipv6.devconf_all->optimistic_dad ||
-		     in6_dev->cnf.optimistic_dad) &&
+		if ((READ_ONCE(net->ipv6.devconf_all->optimistic_dad) ||
+		     READ_ONCE(in6_dev->cnf.optimistic_dad)) &&
 		    !net->ipv6.devconf_all->forwarding && sllao)
 			cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -3293,8 +3296,8 @@ void addrconf_add_linklocal(struct inet6_dev *idev,
 	struct inet6_ifaddr *ifp;
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-	if ((dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad ||
-	     idev->cnf.optimistic_dad) &&
+	if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad) ||
+	     READ_ONCE(idev->cnf.optimistic_dad)) &&
 	    !dev_net(idev->dev)->ipv6.devconf_all->forwarding)
 		cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -3866,10 +3869,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
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
@@ -4090,8 +4093,8 @@ static void addrconf_dad_begin(struct inet6_ifaddr *ifp)
 
 	net = dev_net(dev);
 	if (dev->flags&(IFF_NOARP|IFF_LOOPBACK) ||
-	    (net->ipv6.devconf_all->accept_dad < 1 &&
-	     idev->cnf.accept_dad < 1) ||
+	    (READ_ONCE(net->ipv6.devconf_all->accept_dad) < 1 &&
+	     READ_ONCE(idev->cnf.accept_dad) < 1) ||
 	    !(ifp->flags&IFA_F_TENTATIVE) ||
 	    ifp->flags & IFA_F_NODAD) {
 		bool send_na = false;
@@ -4183,8 +4186,8 @@ static void addrconf_dad_work(struct work_struct *w)
 		action = DAD_ABORT;
 		ifp->state = INET6_IFADDR_STATE_POSTDAD;
 
-		if ((dev_net(idev->dev)->ipv6.devconf_all->accept_dad > 1 ||
-		     idev->cnf.accept_dad > 1) &&
+		if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->accept_dad) > 1 ||
+		     READ_ONCE(idev->cnf.accept_dad) > 1) &&
 		    !idev->cnf.disable_ipv6 &&
 		    !(ifp->flags & IFA_F_STABLE_PRIVACY)) {
 			struct in6_addr addr;
@@ -4323,8 +4326,8 @@ static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
 
 	/* send unsolicited NA if enabled */
 	if (send_na &&
-	    (ifp->idev->cnf.ndisc_notify ||
-	     dev_net(dev)->ipv6.devconf_all->ndisc_notify)) {
+	    (READ_ONCE(ifp->idev->cnf.ndisc_notify) ||
+	     READ_ONCE(dev_net(dev)->ipv6.devconf_all->ndisc_notify))) {
 		ndisc_send_na(dev, &in6addr_linklocal_allnodes, &ifp->addr,
 			      /*router=*/ !!ifp->idev->cnf.forwarding,
 			      /*solicited=*/ false, /*override=*/ true,
@@ -6520,7 +6523,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
 			struct net_device *dev;
 
-			net->ipv6.devconf_dflt->addr_gen_mode = new_val;
+			WRITE_ONCE(net->ipv6.devconf_dflt->addr_gen_mode, new_val);
 			for_each_netdev(net, dev) {
 				idev = __in6_dev_get(dev);
 				if (idev &&
@@ -6531,7 +6534,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 			}
 		}
 
-		*((u32 *)ctl->data) = new_val;
+		WRITE_ONCE(*((u32 *)ctl->data), new_val);
 	}
 
 out:
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 54e71623aac9c..404555311bc74 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -383,9 +383,8 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	accept_seg6 = net->ipv6.devconf_all->seg6_enabled;
-	if (accept_seg6 > idev->cnf.seg6_enabled)
-		accept_seg6 = idev->cnf.seg6_enabled;
+	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
+			  READ_ONCE(idev->cnf.seg6_enabled));
 
 	if (!accept_seg6) {
 		kfree_skb(skb);
@@ -662,10 +661,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	struct ipv6_rt_hdr *hdr;
 	struct rt0_hdr *rthdr;
 	struct net *net = dev_net(skb->dev);
-	int accept_source_route = net->ipv6.devconf_all->accept_source_route;
+	int accept_source_route;
 
-	if (idev && accept_source_route > idev->cnf.accept_source_route)
-		accept_source_route = idev->cnf.accept_source_route;
+	accept_source_route = READ_ONCE(net->ipv6.devconf_all->accept_source_route);
+
+	if (idev)
+		accept_source_route = min(accept_source_route,
+					  READ_ONCE(idev->cnf.accept_source_route));
 
 	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
@@ -926,7 +928,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 		goto drop;
 
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!__in6_dev_get(skb->dev)->cnf.ioam6_enabled)
+	if (!READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index a1953cf6131be..fee1e23c3ae19 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -677,7 +677,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (!skb->dev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)__in6_dev_get(skb->dev)->cnf.ioam6_id;
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -685,7 +685,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id;
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -772,7 +772,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (!skb->dev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = __in6_dev_get(skb->dev)->cnf.ioam6_id_wide;
+			raw32 = READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
@@ -780,7 +780,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = __in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide;
+			raw32 = READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 1ba97933c74fb..133610a49da6b 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -236,7 +236,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	if (!ipv6_addr_is_multicast(&hdr->daddr) &&
 	    (skb->pkt_type == PACKET_BROADCAST ||
 	     skb->pkt_type == PACKET_MULTICAST) &&
-	    idev->cnf.drop_unicast_in_l2_multicast) {
+	    READ_ONCE(idev->cnf.drop_unicast_in_l2_multicast)) {
 		SKB_DR_SET(reason, UNICAST_IN_L2_MULTICAST);
 		goto err;
 	}
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 160b452f75e7d..a52c92b1f321e 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -159,9 +159,9 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	int iv;
 
 	if (mld_in_v1_mode(idev))
-		iv = idev->cnf.mldv1_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv1_unsolicited_report_interval);
 	else
-		iv = idev->cnf.mldv2_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv2_unsolicited_report_interval);
 
 	return iv > 0 ? iv : 1;
 }
@@ -1201,15 +1201,15 @@ static bool mld_marksources(struct ifmcaddr6 *pmc, int nsrcs,
 
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
index 652263e2f2d02..ee34831f5621a 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -451,7 +451,7 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 
 	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
-	tclass = idev ? idev->cnf.ndisc_tclass : 0;
+	tclass = idev ? READ_ONCE(idev->cnf.ndisc_tclass) : 0;
 	rcu_read_unlock();
 
 	skb_push(skb, sizeof(*hdr));
@@ -539,7 +539,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 		src_addr = solicited_addr;
 		if (ifp->flags & IFA_F_OPTIMISTIC)
 			override = false;
-		inc_opt |= ifp->idev->cnf.force_tllao;
+		inc_opt |= READ_ONCE(ifp->idev->cnf.force_tllao);
 		in6_ifa_put(ifp);
 	} else {
 		if (ipv6_dev_get_saddr(dev_net(dev), dev, daddr,
@@ -977,7 +977,7 @@ static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
 {
 	struct inet6_dev *idev = __in6_dev_get(dev);
 
-	switch (idev->cnf.accept_untracked_na) {
+	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
 	case 0: /* Don't accept untracked na (absent in neighbor cache) */
 		return 0;
 	case 1: /* Create new entries from na if currently untracked */
@@ -1028,7 +1028,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	 * drop_unsolicited_na takes precedence over accept_untracked_na
 	 */
 	if (!msg->icmph.icmp6_solicited && idev &&
-	    idev->cnf.drop_unsolicited_na)
+	    READ_ONCE(idev->cnf.drop_unsolicited_na))
 		return reason;
 
 	if (!ndisc_parse_options(dev, msg->opt, ndoptlen, &ndopts))
@@ -1821,7 +1821,7 @@ static bool ndisc_suppress_frag_ndisc(struct sk_buff *skb)
 	if (!idev)
 		return true;
 	if (IP6CB(skb)->flags & IP6SKB_FRAGMENTED &&
-	    idev->cnf.suppress_frag_ndisc) {
+	    READ_ONCE(idev->cnf.suppress_frag_ndisc)) {
 		net_warn_ratelimited("Received fragmented ndisc packet. Carefully consider disabling suppress_frag_ndisc.\n");
 		return true;
 	}
@@ -1898,8 +1898,8 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
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
@@ -1908,8 +1908,8 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 		if (!idev)
 			evict_nocarrier = true;
 		else {
-			evict_nocarrier = idev->cnf.ndisc_evict_nocarrier &&
-					  net->ipv6.devconf_all->ndisc_evict_nocarrier;
+			evict_nocarrier = READ_ONCE(idev->cnf.ndisc_evict_nocarrier) &&
+					  READ_ONCE(net->ipv6.devconf_all->ndisc_evict_nocarrier);
 			in6_dev_put(idev);
 		}
 
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index bf97bf5ac1387..214d137d545e7 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -242,6 +242,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	struct sr6_tlv_hmac *tlv;
 	struct ipv6_sr_hdr *srh;
 	struct inet6_dev *idev;
+	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
 	if (!idev)
@@ -251,16 +252,17 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 
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

