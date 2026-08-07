Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED322579E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070161; cv=none; b=WDkuQPHeZVv/KZik0Qg3+glzY/daOT3KI4/f/caZaU9QfbfywzIRLoIJI6AJSABLpySZp+SzmpEXFlVmvRylCLRc5kl5rwPMmvcXsLXYzYHfPGrpTrr+MHRvPt4wgKVnsb/7i8GsUC47Je/xMNjHxNzEnXaNvbRupQpvb+yslxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070161; c=relaxed/simple;
	bh=DatFEBfkQJ6DahoAXspEjnboQy0l8r68JzyQxu72Tlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qg8VHVs7Cs28NgJfFjxLLo67/R9PbFB6ebzw7S7jj6LucmJhcxNxAyOmnjWd8eptzO8xYPW3uZ1onmbykytaZ6qVpV9xkV3KEhQccJWOvMNUnBkblA9xbiup/KWJBWRXpM8zBSyl4YM3CoV++jUGdECMgxgEZ9dMWUD83NXu8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4lfBojd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4lfBojd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870C01F000E9;
	Fri,  7 Aug 2026 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070159;
	bh=xWT4CwJ4ueHRVj7DMCbLmNPcVOoW/ItzD+SYOrGauzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W4lfBojdwLzsYA6Jq3DfDdqQT+3GxtsVFMpHMSg3Bj6H1l3CTSbL1hfp0YFDUGg3h
	 z+rlIb+7wj/kYU2q/3xbJdj9tcJGCN3cJDXXimswDIaoS4JbJDlURp+AgOs9krakxb
	 X4SGdHcEMxKsnt/k/QMA1YX9dU5UF3kb61j7nL336+TPk2S0v2ySYZ7WYU3Vdlxgbe
	 oTOiR/j1AO2hBySb9MI7Dr/jpEN3T+NCFscokTmF2MvuKGxyHEREaialV2kJi4cS4h
	 eVFCiu5OOXcpBeAYQQJ1MjbkGXsTmHWChEH1Qn8cEovo71iuohP7GESlHKohGyayfc
	 OcwqqPItxAKYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] sysctl: treewide: constify ctl_table_header::ctl_table_arg
Date: Thu,  6 Aug 2026 22:35:55 -0400
Message-ID: <20260807023556.1682974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072933-repent-chapped-0492@gregkh>
References: <2026072933-repent-chapped-0492@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit bfa858f220ab8c950dd3e1310fee61950d0ecdae ]

To be able to constify instances of struct ctl_tables it is necessary to
remove ways through which non-const versions are exposed from the
sysctl core.
One of these is the ctl_table_arg member of struct ctl_table_header.

Constify this reference as a prerequisite for the full constification of
struct ctl_table instances.
No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: f8d5e7846025 ("sctp: avoid auth_enable sysctl UAF during netns teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c                       | 2 +-
 include/linux/sysctl.h                  | 2 +-
 ipc/ipc_sysctl.c                        | 2 +-
 ipc/mq_sysctl.c                         | 2 +-
 kernel/ucount.c                         | 2 +-
 net/ax25/sysctl_net_ax25.c              | 2 +-
 net/bridge/br_netfilter_hooks.c         | 2 +-
 net/core/sysctl_net_core.c              | 2 +-
 net/ieee802154/6lowpan/reassembly.c     | 2 +-
 net/ipv4/devinet.c                      | 2 +-
 net/ipv4/ip_fragment.c                  | 2 +-
 net/ipv4/route.c                        | 2 +-
 net/ipv4/sysctl_net_ipv4.c              | 2 +-
 net/ipv4/xfrm4_policy.c                 | 2 +-
 net/ipv6/addrconf.c                     | 2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
 net/ipv6/reassembly.c                   | 2 +-
 net/ipv6/sysctl_net_ipv6.c              | 6 +++---
 net/ipv6/xfrm6_policy.c                 | 2 +-
 net/mpls/af_mpls.c                      | 4 ++--
 net/mptcp/ctrl.c                        | 2 +-
 net/netfilter/nf_conntrack_standalone.c | 2 +-
 net/netfilter/nf_log.c                  | 2 +-
 net/sctp/sysctl.c                       | 2 +-
 net/smc/smc_sysctl.c                    | 2 +-
 net/unix/sysctl_net_unix.c              | 2 +-
 net/xfrm/xfrm_sysctl.c                  | 2 +-
 27 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 9f7b05a010519..bce55ad2bcd99 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1983,7 +1983,7 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 static void vrf_netns_exit_sysctl(struct net *net)
 {
 	struct netns_vrf *nn_vrf = net_generic(net, vrf_net_id);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = nn_vrf->ctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(nn_vrf->ctl_hdr);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 698a71422a14b..ef84ac08e6c97 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -182,7 +182,7 @@ struct ctl_table_header {
 		struct rcu_head rcu;
 	};
 	struct completion *unregistering;
-	struct ctl_table *ctl_table_arg;
+	const struct ctl_table *ctl_table_arg;
 	struct ctl_table_root *root;
 	struct ctl_table_set *set;
 	struct ctl_dir *parent;
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 22b12a482ba91..becf66235cb04 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -306,7 +306,7 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 void retire_ipc_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = ns->ipc_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->ipc_sysctls);
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 6bb1c5397c69b..42bce339ca97e 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -159,7 +159,7 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
 
 void retire_mq_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = ns->mq_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->mq_sysctls);
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 44ede7a6b805a..0ae13e4b6e9f9 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -119,7 +119,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 void retire_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = ns->sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->sysctls);
diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index db66e11e7fe8b..e0128dc9def33 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -171,7 +171,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 void ax25_unregister_dev_sysctl(ax25_dev *ax25_dev)
 {
 	struct ctl_table_header *header = ax25_dev->sysheader;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (header) {
 		ax25_dev->sysheader = NULL;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index e6962d693359b..12e9e5af139b6 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1286,7 +1286,7 @@ static int br_netfilter_sysctl_init_net(struct net *net)
 static void br_netfilter_sysctl_exit_net(struct net *net,
 					 struct brnf_net *brnet)
 {
-	struct ctl_table *table = brnet->ctl_hdr->ctl_table_arg;
+	const struct ctl_table *table = brnet->ctl_hdr->ctl_table_arg;
 
 	unregister_net_sysctl_table(brnet->ctl_hdr);
 	if (!net_eq(net, &init_net))
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index a7fa17b6a1297..1c82146b5079f 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -741,7 +741,7 @@ static __net_init int sysctl_core_net_init(struct net *net)
 
 static __net_exit void sysctl_core_net_exit(struct net *net)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = net->core.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->core.sysctl_hdr);
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ba0455ad77019..26506dd4b357d 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -399,7 +399,7 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 
 static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 798497c8b1923..5d0994ee34097 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2793,7 +2793,7 @@ static __net_init int devinet_init_net(struct net *net)
 static __net_exit void devinet_exit_net(struct net *net)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = net->ipv4.forw_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.forw_hdr);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 786e761bd0a1b..66bd7e29f4c71 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -632,7 +632,7 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
 
 static void __net_exit ip4_frags_ns_ctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->ipv4.frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.frags_hdr);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f134c59f839e2..0ebc1cb65f60e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3623,7 +3623,7 @@ static __net_init int sysctl_route_net_init(struct net *net)
 
 static __net_exit void sysctl_route_net_exit(struct net *net)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = net->ipv4.route_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.route_hdr);
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 47f2a00e457da..ff849a5b863e5 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1564,7 +1564,7 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 
 static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->ipv4.ipv4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 63bbc7f6a5a88..96fd07ce5a363 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -182,7 +182,7 @@ static __net_init int xfrm4_net_sysctl_init(struct net *net)
 
 static __net_exit void xfrm4_net_sysctl_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!net->ipv4.xfrm4_hdr)
 		return;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 83dc90a8990c9..048ce7fb57fd5 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7251,7 +7251,7 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 static void __addrconf_sysctl_unregister(struct net *net,
 					 struct ipv6_devconf *p, int ifindex)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!p->sysctl_header)
 		return;
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 18e0e1c76c1eb..aee6d8eee8c9f 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -105,7 +105,7 @@ static int nf_ct_frag6_sysctl_register(struct net *net)
 static void __net_exit nf_ct_frags6_sysctl_unregister(struct net *net)
 {
 	struct nft_ct_frag6_pernet *nf_frag = nf_frag_pernet(net);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = nf_frag->nf_frag_frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(nf_frag->nf_frag_frags_hdr);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index cb219d4bdf25e..225a23f7fefa7 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -487,7 +487,7 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
 
 static void __net_exit ip6_frags_ns_sysctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->ipv6.sysctl.frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv6.sysctl.frags_hdr);
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 888676163e900..75de55f907b07 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -313,9 +313,9 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 
 static void __net_exit ipv6_sysctl_net_exit(struct net *net)
 {
-	struct ctl_table *ipv6_table;
-	struct ctl_table *ipv6_route_table;
-	struct ctl_table *ipv6_icmp_table;
+	const struct ctl_table *ipv6_table;
+	const struct ctl_table *ipv6_route_table;
+	const struct ctl_table *ipv6_icmp_table;
 
 	ipv6_table = net->ipv6.sysctl.hdr->ctl_table_arg;
 	ipv6_route_table = net->ipv6.sysctl.route_hdr->ctl_table_arg;
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 6bf22fd9cd380..cf31d884fa58d 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -229,7 +229,7 @@ static int __net_init xfrm6_net_sysctl_init(struct net *net)
 
 static void __net_exit xfrm6_net_sysctl_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!net->ipv6.sysctl.xfrm6_hdr)
 		return;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 2099ce095edc8..969871197c25c 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1422,7 +1422,7 @@ static void mpls_dev_sysctl_unregister(struct net_device *dev,
 				       struct mpls_dev *mdev)
 {
 	struct net *net = dev_net(dev);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!mdev->sysctl)
 		return;
@@ -2691,7 +2691,7 @@ static void mpls_net_exit(struct net *net)
 {
 	struct mpls_route __rcu **platform_label;
 	size_t platform_labels;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	unsigned int index;
 
 	table = net->mpls.ctl->ctl_table_arg;
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 34ae0ef4f9f39..d430f3d4af36a 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -218,7 +218,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
 {
-	struct ctl_table *table = pernet->ctl_table_hdr->ctl_table_arg;
+	const struct ctl_table *table = pernet->ctl_table_hdr->ctl_table_arg;
 
 	unregister_net_sysctl_table(pernet->ctl_table_hdr);
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 1d5de1d9f008d..a0434ac356ee9 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1113,7 +1113,7 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
 static void nf_conntrack_standalone_fini_sysctl(struct net *net)
 {
 	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = cnet->sysctl_header->ctl_table_arg;
 	unregister_net_sysctl_table(cnet->sysctl_header);
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 75c812f157e20..3cc569ac8a06b 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -509,7 +509,7 @@ static int netfilter_log_sysctl_init(struct net *net)
 
 static void netfilter_log_sysctl_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->nf.nf_log_dir_header->ctl_table_arg;
 	unregister_net_sysctl_table(net->nf.nf_log_dir_header);
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 77a76634014a5..9c55a70f2b64b 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -630,7 +630,7 @@ int sctp_sysctl_net_register(struct net *net)
 
 void sctp_sysctl_net_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->sctp.sysctl_header->ctl_table_arg;
 	unregister_net_sysctl_table(net->sctp.sysctl_header);
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 5cbc18c6e62b0..c632df62ff908 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -109,7 +109,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
 
 void __net_exit smc_sysctl_net_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->smc.smc_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->smc.smc_hdr);
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 3e84b31c355a2..44996af61999b 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -52,7 +52,7 @@ int __net_init unix_sysctl_register(struct net *net)
 
 void unix_sysctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->unx.ctl->ctl_table_arg;
 	unregister_net_sysctl_table(net->unx.ctl);
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 7fdeafc838a7c..e972930c292b6 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -76,7 +76,7 @@ int __net_init xfrm_sysctl_init(struct net *net)
 
 void __net_exit xfrm_sysctl_fini(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->xfrm.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->xfrm.sysctl_hdr);
-- 
2.53.0

