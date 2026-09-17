Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37B36F906
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607606; cv=none; b=SaNcSss/kuaPYrlEYXwq550DIZcMDfaR95jvrJNBMpEY48b8RHM0lXG/SgKrKlnggjwQ87eO/i2aGdnICNJNXS9LWKUwrF6iIGpw1tqwIEiXl9s8Rzo1PPyf3EESt0GMHKn90NaCOmw05FczCzNr1A98ACdCN4TwDgyjVzTPgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607606; c=relaxed/simple;
	bh=6gFBiAD0jFG75STLak5Nsq8t6sgaEUdWegFqKDu01jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9gPkmX8/l8R1tlYNNrD3TZwNt4ttnBRS+kecbKYigu84Iwo/hZ5kny92vOrt9MaYgyXh+1t6nrA2anRTtr9VSRNvb+XMogU7LOzoCAtjT6tbZ2blSMWfjSmC9axNyUFsgHD9qUADfuKMsZxLpXr2BAZBjDEDm8Vx4iu4vnATNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/iIML0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/iIML0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D7C1F00893;
	Thu, 17 Sep 2026 01:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607601;
	bh=fZG0D5BcNPrFRH0M3IGSfWv85olp4rgnWkv2L1gQQBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/iIML0//T7jTHgawdZF+U6lsUbKNlGiwhzJsFMQoQEwJoRN+/JvR78W2erey5D3W
	 UrHfYaVm1C1soSK+VZ/uGVvpaNsqyX7pEs4/4MZ46mGcK3tiPZfpZDlTMfNDErPqWd
	 gPaiSyx9s/aZKHq4oLvO5LAMhQ1ju1RCew21aA4qkYObZpY5i3TGpaelBaaPj6oZsK
	 7f7ZTr18raYzrBAiEMLIwKGpa1q9aMGGydUoybEEmMMPngVfbO1MGmiNWOn3gjZ4gk
	 c73TDTNwC+9imcq+kODiRKD8zUJBFkMu8HUeiYcOmvEUDPWNuotyZNQzUZbYN4AuqG
	 VE9cT9+7HhI0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] netfilter: nf_log_arp: merge with nf_log_syslog
Date: Wed, 16 Sep 2026 21:13:16 -0400
Message-ID: <20260917011318.3530857-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917011318.3530857-1-sashal@kernel.org>
References: <2026091608-unstaffed-playpen-7696@gregkh>
 <20260917011318.3530857-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit f11d61e7957d9dd54c4d87bb59da83fa949c15cb ]

similar to previous change: nf_log_syslog now covers ARP logging
as well, the old nf_log_arp module is removed.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 2c018cc4842c ("netfilter: nf_log: unregister loggers before per-net teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/Kconfig      |   5 +-
 net/ipv4/netfilter/Makefile     |   3 -
 net/ipv4/netfilter/nf_log_arp.c | 172 --------------------------------
 net/netfilter/nf_log_syslog.c   | 113 ++++++++++++++++++++-
 4 files changed, 115 insertions(+), 178 deletions(-)
 delete mode 100644 net/ipv4/netfilter/nf_log_arp.c

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index aadb98e43fb19..63cb953bd0196 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -76,7 +76,10 @@ config NF_DUP_IPV4
 config NF_LOG_ARP
 	tristate "ARP packet logging"
 	default m if NETFILTER_ADVANCED=n
-	select NF_LOG_COMMON
+	select NF_LOG_SYSLOG
+	help
+	This is a backwards-compat option for the user's convenience
+	(e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
 
 config NF_LOG_IPV4
 	tristate "IPv4 packet logging"
diff --git a/net/ipv4/netfilter/Makefile b/net/ipv4/netfilter/Makefile
index abd133048b42e..f38fb1368ddb2 100644
--- a/net/ipv4/netfilter/Makefile
+++ b/net/ipv4/netfilter/Makefile
@@ -9,9 +9,6 @@ obj-$(CONFIG_NF_DEFRAG_IPV4) += nf_defrag_ipv4.o
 obj-$(CONFIG_NF_SOCKET_IPV4) += nf_socket_ipv4.o
 obj-$(CONFIG_NF_TPROXY_IPV4) += nf_tproxy_ipv4.o
 
-# logging
-obj-$(CONFIG_NF_LOG_ARP) += nf_log_arp.o
-
 # reject
 obj-$(CONFIG_NF_REJECT_IPV4) += nf_reject_ipv4.o
 
diff --git a/net/ipv4/netfilter/nf_log_arp.c b/net/ipv4/netfilter/nf_log_arp.c
deleted file mode 100644
index 136030ad2e546..0000000000000
--- a/net/ipv4/netfilter/nf_log_arp.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * (C) 2014 by Pablo Neira Ayuso <pablo@netfilter.org>
- *
- * Based on code from ebt_log from:
- *
- * Bart De Schuymer <bdschuym@pandora.be>
- * Harald Welte <laforge@netfilter.org>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/skbuff.h>
-#include <linux/if_arp.h>
-#include <linux/ip.h>
-#include <net/route.h>
-
-#include <linux/netfilter.h>
-#include <linux/netfilter/xt_LOG.h>
-#include <net/netfilter/nf_log.h>
-
-static const struct nf_loginfo default_loginfo = {
-	.type	= NF_LOG_TYPE_LOG,
-	.u = {
-		.log = {
-			.level	  = LOGLEVEL_NOTICE,
-			.logflags = NF_LOG_DEFAULT_MASK,
-		},
-	},
-};
-
-struct arppayload {
-	unsigned char mac_src[ETH_ALEN];
-	unsigned char ip_src[4];
-	unsigned char mac_dst[ETH_ALEN];
-	unsigned char ip_dst[4];
-};
-
-static void dump_arp_packet(struct nf_log_buf *m,
-			    const struct nf_loginfo *info,
-			    const struct sk_buff *skb, unsigned int nhoff)
-{
-	const struct arppayload *ap;
-	struct arppayload _arpp;
-	const struct arphdr *ah;
-	unsigned int logflags;
-	struct arphdr _arph;
-
-	ah = skb_header_pointer(skb, 0, sizeof(_arph), &_arph);
-	if (ah == NULL) {
-		nf_log_buf_add(m, "TRUNCATED");
-		return;
-	}
-
-	if (info->type == NF_LOG_TYPE_LOG)
-		logflags = info->u.log.logflags;
-	else
-		logflags = NF_LOG_DEFAULT_MASK;
-
-	if (logflags & NF_LOG_MACDECODE) {
-		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
-			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
-		nf_log_dump_vlan(m, skb);
-		nf_log_buf_add(m, "MACPROTO=%04x ",
-			       ntohs(eth_hdr(skb)->h_proto));
-	}
-
-	nf_log_buf_add(m, "ARP HTYPE=%d PTYPE=0x%04x OPCODE=%d",
-		       ntohs(ah->ar_hrd), ntohs(ah->ar_pro), ntohs(ah->ar_op));
-
-	/* If it's for Ethernet and the lengths are OK, then log the ARP
-	 * payload.
-	 */
-	if (ah->ar_hrd != htons(ARPHRD_ETHER) ||
-	    ah->ar_hln != ETH_ALEN ||
-	    ah->ar_pln != sizeof(__be32))
-		return;
-
-	ap = skb_header_pointer(skb, sizeof(_arph), sizeof(_arpp), &_arpp);
-	if (ap == NULL) {
-		nf_log_buf_add(m, " INCOMPLETE [%zu bytes]",
-			       skb->len - sizeof(_arph));
-		return;
-	}
-	nf_log_buf_add(m, " MACSRC=%pM IPSRC=%pI4 MACDST=%pM IPDST=%pI4",
-		       ap->mac_src, ap->ip_src, ap->mac_dst, ap->ip_dst);
-}
-
-static void nf_log_arp_packet(struct net *net, u_int8_t pf,
-			      unsigned int hooknum, const struct sk_buff *skb,
-			      const struct net_device *in,
-			      const struct net_device *out,
-			      const struct nf_loginfo *loginfo,
-			      const char *prefix)
-{
-	struct nf_log_buf *m;
-
-	/* FIXME: Disabled from containers until syslog ns is supported */
-	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
-		return;
-
-	m = nf_log_buf_open();
-
-	if (!loginfo)
-		loginfo = &default_loginfo;
-
-	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out, loginfo,
-				  prefix);
-	dump_arp_packet(m, loginfo, skb, 0);
-
-	nf_log_buf_close(m);
-}
-
-static struct nf_logger nf_arp_logger __read_mostly = {
-	.name		= "nf_log_arp",
-	.type		= NF_LOG_TYPE_LOG,
-	.logfn		= nf_log_arp_packet,
-	.me		= THIS_MODULE,
-};
-
-static int __net_init nf_log_arp_net_init(struct net *net)
-{
-	return nf_log_set(net, NFPROTO_ARP, &nf_arp_logger);
-}
-
-static void __net_exit nf_log_arp_net_exit(struct net *net)
-{
-	nf_log_unset(net, &nf_arp_logger);
-}
-
-static struct pernet_operations nf_log_arp_net_ops = {
-	.init = nf_log_arp_net_init,
-	.exit = nf_log_arp_net_exit,
-};
-
-static int __init nf_log_arp_init(void)
-{
-	int ret;
-
-	ret = register_pernet_subsys(&nf_log_arp_net_ops);
-	if (ret < 0)
-		return ret;
-
-	ret = nf_log_register(NFPROTO_ARP, &nf_arp_logger);
-	if (ret < 0) {
-		pr_err("failed to register logger\n");
-		goto err1;
-	}
-
-	return 0;
-
-err1:
-	unregister_pernet_subsys(&nf_log_arp_net_ops);
-	return ret;
-}
-
-static void __exit nf_log_arp_exit(void)
-{
-	unregister_pernet_subsys(&nf_log_arp_net_ops);
-	nf_log_unregister(&nf_arp_logger);
-}
-
-module_init(nf_log_arp_init);
-module_exit(nf_log_arp_exit);
-
-MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
-MODULE_DESCRIPTION("Netfilter ARP packet logging");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NF_LOGGER(3, 0);
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index b4452acb5cc0b..651412ff8c8e9 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -31,6 +31,95 @@ static const struct nf_loginfo default_loginfo = {
 	},
 };
 
+struct arppayload {
+	unsigned char mac_src[ETH_ALEN];
+	unsigned char ip_src[4];
+	unsigned char mac_dst[ETH_ALEN];
+	unsigned char ip_dst[4];
+};
+
+static void noinline_for_stack
+dump_arp_packet(struct nf_log_buf *m,
+		const struct nf_loginfo *info,
+		const struct sk_buff *skb, unsigned int nhoff)
+{
+	const struct arppayload *ap;
+	struct arppayload _arpp;
+	const struct arphdr *ah;
+	unsigned int logflags;
+	struct arphdr _arph;
+
+	ah = skb_header_pointer(skb, 0, sizeof(_arph), &_arph);
+	if (!ah) {
+		nf_log_buf_add(m, "TRUNCATED");
+		return;
+	}
+
+	if (info->type == NF_LOG_TYPE_LOG)
+		logflags = info->u.log.logflags;
+	else
+		logflags = NF_LOG_DEFAULT_MASK;
+
+	if (logflags & NF_LOG_MACDECODE) {
+		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
+			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
+		nf_log_dump_vlan(m, skb);
+		nf_log_buf_add(m, "MACPROTO=%04x ",
+			       ntohs(eth_hdr(skb)->h_proto));
+	}
+
+	nf_log_buf_add(m, "ARP HTYPE=%d PTYPE=0x%04x OPCODE=%d",
+		       ntohs(ah->ar_hrd), ntohs(ah->ar_pro), ntohs(ah->ar_op));
+	/* If it's for Ethernet and the lengths are OK, then log the ARP
+	 * payload.
+	 */
+	if (ah->ar_hrd != htons(ARPHRD_ETHER) ||
+	    ah->ar_hln != ETH_ALEN ||
+	    ah->ar_pln != sizeof(__be32))
+		return;
+
+	ap = skb_header_pointer(skb, sizeof(_arph), sizeof(_arpp), &_arpp);
+	if (!ap) {
+		nf_log_buf_add(m, " INCOMPLETE [%zu bytes]",
+			       skb->len - sizeof(_arph));
+		return;
+	}
+	nf_log_buf_add(m, " MACSRC=%pM IPSRC=%pI4 MACDST=%pM IPDST=%pI4",
+		       ap->mac_src, ap->ip_src, ap->mac_dst, ap->ip_dst);
+}
+
+static void nf_log_arp_packet(struct net *net, u_int8_t pf,
+			      unsigned int hooknum, const struct sk_buff *skb,
+			      const struct net_device *in,
+			      const struct net_device *out,
+			      const struct nf_loginfo *loginfo,
+			      const char *prefix)
+{
+	struct nf_log_buf *m;
+
+	/* FIXME: Disabled from containers until syslog ns is supported */
+	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
+		return;
+
+	m = nf_log_buf_open();
+
+	if (!loginfo)
+		loginfo = &default_loginfo;
+
+	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out, loginfo,
+				  prefix);
+	dump_arp_packet(m, loginfo, skb, 0);
+
+	nf_log_buf_close(m);
+}
+
+static struct nf_logger nf_arp_logger __read_mostly = {
+	.name		= "nf_log_arp",
+	.type		= NF_LOG_TYPE_LOG,
+	.logfn		= nf_log_arp_packet,
+	.me		= THIS_MODULE,
+};
+
 /* One level of recursion won't kill us */
 static noinline_for_stack void
 dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
@@ -343,12 +432,23 @@ static struct nf_logger nf_ip_logger __read_mostly = {
 
 static int __net_init nf_log_syslog_net_init(struct net *net)
 {
-	return nf_log_set(net, NFPROTO_IPV4, &nf_ip_logger);
+	int ret = nf_log_set(net, NFPROTO_IPV4, &nf_ip_logger);
+
+	if (ret)
+		return ret;
+
+	ret = nf_log_set(net, NFPROTO_ARP, &nf_arp_logger);
+	if (ret)
+		goto err1;
+err1:
+	nf_log_unset(net, &nf_arp_logger);
+	return ret;
 }
 
 static void __net_exit nf_log_syslog_net_exit(struct net *net)
 {
 	nf_log_unset(net, &nf_ip_logger);
+	nf_log_unset(net, &nf_arp_logger);
 }
 
 static struct pernet_operations nf_log_syslog_net_ops = {
@@ -368,9 +468,15 @@ static int __init nf_log_syslog_init(void)
 	if (ret < 0)
 		goto err1;
 
-	return 0;
+	ret = nf_log_register(NFPROTO_ARP, &nf_arp_logger);
+	if (ret < 0)
+		goto err2;
 
+	return 0;
+err2:
+	nf_log_unregister(&nf_arp_logger);
 err1:
+	pr_err("failed to register logger\n");
 	unregister_pernet_subsys(&nf_log_syslog_net_ops);
 	return ret;
 }
@@ -379,6 +485,7 @@ static void __exit nf_log_syslog_exit(void)
 {
 	unregister_pernet_subsys(&nf_log_syslog_net_ops);
 	nf_log_unregister(&nf_ip_logger);
+	nf_log_unregister(&nf_arp_logger);
 }
 
 module_init(nf_log_syslog_init);
@@ -387,5 +494,7 @@ module_exit(nf_log_syslog_exit);
 MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
 MODULE_DESCRIPTION("Netfilter syslog packet logging");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("nf_log_arp");
 MODULE_ALIAS("nf_log_ipv4");
 MODULE_ALIAS_NF_LOGGER(AF_INET, 0);
+MODULE_ALIAS_NF_LOGGER(3, 0);
-- 
2.53.0

