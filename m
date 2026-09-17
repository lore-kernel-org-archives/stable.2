Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0836B92F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607609; cv=none; b=jamskeJ3jB9mCd3L68UKVkS3YLaMF3sqloSBG1TmqpEPe991dembEcBITtYaOtv1ohZ6V8gU+4KaLCj8hXqdnphao4s1BgcQzwUB3UXaDPGPb/tTKZq4/boDWGnT15uu3SanKCueZuUjogaSUeCxw74dUQn8aDhN3LovLZSWmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607609; c=relaxed/simple;
	bh=Dafjhv86saE5o5kW+dLDSk8WdkwEo35t5PW08nGjN+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jADU0LrBgqQzcZjVLvh+yYzXIKMwin3A4mbCwbxTgaT0HYMCRUMPFYq7rbLKagUhSoQmNQBFkQ7UgaRGVDhbAxZL84buKkRJWz8kPfGVZjkTczfgsZ+gM8mg4CY+plJVbaZONPzQCSuicBG9HaCpAbCoXUEpOap9uKLu9QG5Ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIEYzmoA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIEYzmoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5021F0089A;
	Thu, 17 Sep 2026 01:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607602;
	bh=4x1PlmvlPJLgUXa9pdH0y2BMi3CHWsNES31G/ahSaak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jIEYzmoAvGQGSEdJqA8Ti9D8imOfmokMbkU5tZpTq7fG6ZwMUa5qz/tchqgPImptN
	 JdkLDavNW12RpVdxPSRMA3VscZoPP1yfseE4WElpM8kaENMn71PDY79Pq70/qrs5g4
	 DTLVAXkVpvUcLR5AEVkGrBBeljDZ/KivrustQqmlqlkkpApkuaPX43RC9IESz/vcRt
	 XhjZ38G8fYF49/3JtQCPC/AknXq3gcmJG8aISNU+i88cSVfkgKn+iwFnnSFjFJ/XcG
	 bYd/eX2bDfLNGqTu0/Qt+UGYVbvxVz+UpzX+ZkPZxYntBc3A7GVgEQnQVcY/ehk48C
	 I14icQFK0YT3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] netfilter: nf_log_ipv6: merge with nf_log_syslog
Date: Wed, 16 Sep 2026 21:13:17 -0400
Message-ID: <20260917011318.3530857-3-sashal@kernel.org>
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

[ Upstream commit f5466caab9a8d2f363d2e0730a99f5916df892f5 ]

This removes the nf_log_ipv6 module, the functionality is now
provided by nf_log_syslog.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Stable dependency adaptation for 2c018cc4842c:

Preserve the 5.10 MAC-header validation from 2e96e1bc9b4d when moving
the IPv6 logger into nf_log_syslog; deleting the old file must not drop
the skb_mac_header_was_set() and skb_mac_header_len() checks.

Also consolidate the existing netdev and bridge loggers so the target's
five-logger exit hunk applies without modification. Move their packet
callbacks unchanged, merge registration and error unwinding into the
existing syslog callbacks, and retain compatibility Kconfig selections
and module aliases. No new functions are introduced.

Unset all five syslog loggers in the existing per-net callback and use
it as pre_exit, so namespace teardown waits for RCU readers. The 5.10
nfnetlink logger has no separate pre_exit callback; wait for RCU readers
in its existing exit callback after unsetting the logger, without adding
a function. These preserve the teardown guarantees needed by the target
while leaving its global-unregistration ordering change unapplied.

Stable-dep-of: 2c018cc4842c ("netfilter: nf_log: unregister loggers before per-net teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/Kconfig         |   5 +-
 net/bridge/netfilter/Makefile        |   3 -
 net/bridge/netfilter/nf_log_bridge.c |  79 -----
 net/ipv6/netfilter/Kconfig           |   5 +-
 net/ipv6/netfilter/Makefile          |   3 -
 net/ipv6/netfilter/nf_log_ipv6.c     | 427 --------------------------
 net/netfilter/Kconfig                |   5 +-
 net/netfilter/Makefile               |   3 -
 net/netfilter/nf_log_netdev.c        |  78 -----
 net/netfilter/nf_log_syslog.c        | 431 ++++++++++++++++++++++++++-
 net/netfilter/nfnetlink_log.c        |   2 +
 11 files changed, 442 insertions(+), 599 deletions(-)
 delete mode 100644 net/bridge/netfilter/nf_log_bridge.c
 delete mode 100644 net/ipv6/netfilter/nf_log_ipv6.c
 delete mode 100644 net/netfilter/nf_log_netdev.c

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index 5040fe43f4b42..12549a1517059 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -23,7 +23,10 @@ config NFT_BRIDGE_REJECT
 
 config NF_LOG_BRIDGE
 	tristate "Bridge packet logging"
-	select NF_LOG_COMMON
+	select NF_LOG_SYSLOG
+	help
+	  This is a backwards-compat option for the user's convenience
+	  (e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
 
 endif # NF_TABLES_BRIDGE
 
diff --git a/net/bridge/netfilter/Makefile b/net/bridge/netfilter/Makefile
index 8e2c5759d964e..1c9ce49ab6513 100644
--- a/net/bridge/netfilter/Makefile
+++ b/net/bridge/netfilter/Makefile
@@ -9,9 +9,6 @@ obj-$(CONFIG_NFT_BRIDGE_REJECT)  += nft_reject_bridge.o
 # connection tracking
 obj-$(CONFIG_NF_CONNTRACK_BRIDGE) += nf_conntrack_bridge.o
 
-# packet logging
-obj-$(CONFIG_NF_LOG_BRIDGE) += nf_log_bridge.o
-
 obj-$(CONFIG_BRIDGE_NF_EBTABLES) += ebtables.o
 
 # tables
diff --git a/net/bridge/netfilter/nf_log_bridge.c b/net/bridge/netfilter/nf_log_bridge.c
deleted file mode 100644
index 1ad61d1017b6c..0000000000000
--- a/net/bridge/netfilter/nf_log_bridge.c
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * (C) 2014 by Pablo Neira Ayuso <pablo@netfilter.org>
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/skbuff.h>
-#include <linux/if_bridge.h>
-#include <linux/ip.h>
-#include <net/route.h>
-
-#include <linux/netfilter.h>
-#include <net/netfilter/nf_log.h>
-
-static void nf_log_bridge_packet(struct net *net, u_int8_t pf,
-				 unsigned int hooknum,
-				 const struct sk_buff *skb,
-				 const struct net_device *in,
-				 const struct net_device *out,
-				 const struct nf_loginfo *loginfo,
-				 const char *prefix)
-{
-	nf_log_l2packet(net, pf, eth_hdr(skb)->h_proto, hooknum, skb,
-			in, out, loginfo, prefix);
-}
-
-static struct nf_logger nf_bridge_logger __read_mostly = {
-	.name		= "nf_log_bridge",
-	.type		= NF_LOG_TYPE_LOG,
-	.logfn		= nf_log_bridge_packet,
-	.me		= THIS_MODULE,
-};
-
-static int __net_init nf_log_bridge_net_init(struct net *net)
-{
-	return nf_log_set(net, NFPROTO_BRIDGE, &nf_bridge_logger);
-}
-
-static void __net_exit nf_log_bridge_net_exit(struct net *net)
-{
-	nf_log_unset(net, &nf_bridge_logger);
-}
-
-static struct pernet_operations nf_log_bridge_net_ops = {
-	.init = nf_log_bridge_net_init,
-	.exit = nf_log_bridge_net_exit,
-};
-
-static int __init nf_log_bridge_init(void)
-{
-	int ret;
-
-	/* Request to load the real packet loggers. */
-	nf_logger_request_module(NFPROTO_IPV4, NF_LOG_TYPE_LOG);
-	nf_logger_request_module(NFPROTO_IPV6, NF_LOG_TYPE_LOG);
-	nf_logger_request_module(NFPROTO_ARP, NF_LOG_TYPE_LOG);
-
-	ret = register_pernet_subsys(&nf_log_bridge_net_ops);
-	if (ret < 0)
-		return ret;
-
-	nf_log_register(NFPROTO_BRIDGE, &nf_bridge_logger);
-	return 0;
-}
-
-static void __exit nf_log_bridge_exit(void)
-{
-	unregister_pernet_subsys(&nf_log_bridge_net_ops);
-	nf_log_unregister(&nf_bridge_logger);
-}
-
-module_init(nf_log_bridge_init);
-module_exit(nf_log_bridge_exit);
-
-MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
-MODULE_DESCRIPTION("Netfilter bridge packet logging");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NF_LOGGER(AF_BRIDGE, 0);
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index 262bb51a2d996..f22233e44ee97 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -69,7 +69,10 @@ config NF_REJECT_IPV6
 config NF_LOG_IPV6
 	tristate "IPv6 packet logging"
 	default m if NETFILTER_ADVANCED=n
-	select NF_LOG_COMMON
+	select NF_LOG_SYSLOG
+	help
+	  This is a backwards-compat option for the user's convenience
+	  (e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
 
 config IP6_NF_IPTABLES
 	tristate "IP6 tables support (required for filtering)"
diff --git a/net/ipv6/netfilter/Makefile b/net/ipv6/netfilter/Makefile
index 731a74c60dca3..b85383606df71 100644
--- a/net/ipv6/netfilter/Makefile
+++ b/net/ipv6/netfilter/Makefile
@@ -18,9 +18,6 @@ obj-$(CONFIG_NF_DEFRAG_IPV6) += nf_defrag_ipv6.o
 obj-$(CONFIG_NF_SOCKET_IPV6) += nf_socket_ipv6.o
 obj-$(CONFIG_NF_TPROXY_IPV6) += nf_tproxy_ipv6.o
 
-# logging
-obj-$(CONFIG_NF_LOG_IPV6) += nf_log_ipv6.o
-
 # reject
 obj-$(CONFIG_NF_REJECT_IPV6) += nf_reject_ipv6.o
 
diff --git a/net/ipv6/netfilter/nf_log_ipv6.c b/net/ipv6/netfilter/nf_log_ipv6.c
deleted file mode 100644
index cc724870a467f..0000000000000
--- a/net/ipv6/netfilter/nf_log_ipv6.c
+++ /dev/null
@@ -1,427 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* (C) 1999-2001 Paul `Rusty' Russell
- * (C) 2002-2004 Netfilter Core Team <coreteam@netfilter.org>
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
-#include <net/ipv6.h>
-#include <net/icmp.h>
-#include <net/udp.h>
-#include <net/tcp.h>
-#include <net/route.h>
-
-#include <linux/netfilter.h>
-#include <linux/netfilter_ipv6.h>
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
-/* One level of recursion won't kill us */
-static void dump_ipv6_packet(struct net *net, struct nf_log_buf *m,
-			     const struct nf_loginfo *info,
-			     const struct sk_buff *skb, unsigned int ip6hoff,
-			     int recurse)
-{
-	u_int8_t currenthdr;
-	int fragment;
-	struct ipv6hdr _ip6h;
-	const struct ipv6hdr *ih;
-	unsigned int ptr;
-	unsigned int hdrlen = 0;
-	unsigned int logflags;
-
-	if (info->type == NF_LOG_TYPE_LOG)
-		logflags = info->u.log.logflags;
-	else
-		logflags = NF_LOG_DEFAULT_MASK;
-
-	ih = skb_header_pointer(skb, ip6hoff, sizeof(_ip6h), &_ip6h);
-	if (ih == NULL) {
-		nf_log_buf_add(m, "TRUNCATED");
-		return;
-	}
-
-	/* Max length: 88 "SRC=0000.0000.0000.0000.0000.0000.0000.0000 DST=0000.0000.0000.0000.0000.0000.0000.0000 " */
-	nf_log_buf_add(m, "SRC=%pI6 DST=%pI6 ", &ih->saddr, &ih->daddr);
-
-	/* Max length: 44 "LEN=65535 TC=255 HOPLIMIT=255 FLOWLBL=FFFFF " */
-	nf_log_buf_add(m, "LEN=%zu TC=%u HOPLIMIT=%u FLOWLBL=%u ",
-	       ntohs(ih->payload_len) + sizeof(struct ipv6hdr),
-	       (ntohl(*(__be32 *)ih) & 0x0ff00000) >> 20,
-	       ih->hop_limit,
-	       (ntohl(*(__be32 *)ih) & 0x000fffff));
-
-	fragment = 0;
-	ptr = ip6hoff + sizeof(struct ipv6hdr);
-	currenthdr = ih->nexthdr;
-	while (currenthdr != NEXTHDR_NONE && nf_ip6_ext_hdr(currenthdr)) {
-		struct ipv6_opt_hdr _hdr;
-		const struct ipv6_opt_hdr *hp;
-
-		hp = skb_header_pointer(skb, ptr, sizeof(_hdr), &_hdr);
-		if (hp == NULL) {
-			nf_log_buf_add(m, "TRUNCATED");
-			return;
-		}
-
-		/* Max length: 48 "OPT (...) " */
-		if (logflags & NF_LOG_IPOPT)
-			nf_log_buf_add(m, "OPT ( ");
-
-		switch (currenthdr) {
-		case IPPROTO_FRAGMENT: {
-			struct frag_hdr _fhdr;
-			const struct frag_hdr *fh;
-
-			nf_log_buf_add(m, "FRAG:");
-			fh = skb_header_pointer(skb, ptr, sizeof(_fhdr),
-						&_fhdr);
-			if (fh == NULL) {
-				nf_log_buf_add(m, "TRUNCATED ");
-				return;
-			}
-
-			/* Max length: 6 "65535 " */
-			nf_log_buf_add(m, "%u ", ntohs(fh->frag_off) & 0xFFF8);
-
-			/* Max length: 11 "INCOMPLETE " */
-			if (fh->frag_off & htons(0x0001))
-				nf_log_buf_add(m, "INCOMPLETE ");
-
-			nf_log_buf_add(m, "ID:%08x ",
-				       ntohl(fh->identification));
-
-			if (ntohs(fh->frag_off) & 0xFFF8)
-				fragment = 1;
-
-			hdrlen = 8;
-
-			break;
-		}
-		case IPPROTO_DSTOPTS:
-		case IPPROTO_ROUTING:
-		case IPPROTO_HOPOPTS:
-			if (fragment) {
-				if (logflags & NF_LOG_IPOPT)
-					nf_log_buf_add(m, ")");
-				return;
-			}
-			hdrlen = ipv6_optlen(hp);
-			break;
-		/* Max Length */
-		case IPPROTO_AH:
-			if (logflags & NF_LOG_IPOPT) {
-				struct ip_auth_hdr _ahdr;
-				const struct ip_auth_hdr *ah;
-
-				/* Max length: 3 "AH " */
-				nf_log_buf_add(m, "AH ");
-
-				if (fragment) {
-					nf_log_buf_add(m, ")");
-					return;
-				}
-
-				ah = skb_header_pointer(skb, ptr, sizeof(_ahdr),
-							&_ahdr);
-				if (ah == NULL) {
-					/*
-					 * Max length: 26 "INCOMPLETE [65535
-					 *  bytes] )"
-					 */
-					nf_log_buf_add(m, "INCOMPLETE [%u bytes] )",
-						       skb->len - ptr);
-					return;
-				}
-
-				/* Length: 15 "SPI=0xF1234567 */
-				nf_log_buf_add(m, "SPI=0x%x ", ntohl(ah->spi));
-
-			}
-
-			hdrlen = ipv6_authlen(hp);
-			break;
-		case IPPROTO_ESP:
-			if (logflags & NF_LOG_IPOPT) {
-				struct ip_esp_hdr _esph;
-				const struct ip_esp_hdr *eh;
-
-				/* Max length: 4 "ESP " */
-				nf_log_buf_add(m, "ESP ");
-
-				if (fragment) {
-					nf_log_buf_add(m, ")");
-					return;
-				}
-
-				/*
-				 * Max length: 26 "INCOMPLETE [65535 bytes] )"
-				 */
-				eh = skb_header_pointer(skb, ptr, sizeof(_esph),
-							&_esph);
-				if (eh == NULL) {
-					nf_log_buf_add(m, "INCOMPLETE [%u bytes] )",
-						       skb->len - ptr);
-					return;
-				}
-
-				/* Length: 16 "SPI=0xF1234567 )" */
-				nf_log_buf_add(m, "SPI=0x%x )",
-					       ntohl(eh->spi));
-			}
-			return;
-		default:
-			/* Max length: 20 "Unknown Ext Hdr 255" */
-			nf_log_buf_add(m, "Unknown Ext Hdr %u", currenthdr);
-			return;
-		}
-		if (logflags & NF_LOG_IPOPT)
-			nf_log_buf_add(m, ") ");
-
-		currenthdr = hp->nexthdr;
-		ptr += hdrlen;
-	}
-
-	switch (currenthdr) {
-	case IPPROTO_TCP:
-		if (nf_log_dump_tcp_header(m, skb, currenthdr, fragment,
-					   ptr, logflags))
-			return;
-		break;
-	case IPPROTO_UDP:
-	case IPPROTO_UDPLITE:
-		if (nf_log_dump_udp_header(m, skb, currenthdr, fragment, ptr))
-			return;
-		break;
-	case IPPROTO_ICMPV6: {
-		struct icmp6hdr _icmp6h;
-		const struct icmp6hdr *ic;
-
-		/* Max length: 13 "PROTO=ICMPv6 " */
-		nf_log_buf_add(m, "PROTO=ICMPv6 ");
-
-		if (fragment)
-			break;
-
-		/* Max length: 25 "INCOMPLETE [65535 bytes] " */
-		ic = skb_header_pointer(skb, ptr, sizeof(_icmp6h), &_icmp6h);
-		if (ic == NULL) {
-			nf_log_buf_add(m, "INCOMPLETE [%u bytes] ",
-				       skb->len - ptr);
-			return;
-		}
-
-		/* Max length: 18 "TYPE=255 CODE=255 " */
-		nf_log_buf_add(m, "TYPE=%u CODE=%u ",
-			       ic->icmp6_type, ic->icmp6_code);
-
-		switch (ic->icmp6_type) {
-		case ICMPV6_ECHO_REQUEST:
-		case ICMPV6_ECHO_REPLY:
-			/* Max length: 19 "ID=65535 SEQ=65535 " */
-			nf_log_buf_add(m, "ID=%u SEQ=%u ",
-				ntohs(ic->icmp6_identifier),
-				ntohs(ic->icmp6_sequence));
-			break;
-		case ICMPV6_MGM_QUERY:
-		case ICMPV6_MGM_REPORT:
-		case ICMPV6_MGM_REDUCTION:
-			break;
-
-		case ICMPV6_PARAMPROB:
-			/* Max length: 17 "POINTER=ffffffff " */
-			nf_log_buf_add(m, "POINTER=%08x ",
-				       ntohl(ic->icmp6_pointer));
-			fallthrough;
-		case ICMPV6_DEST_UNREACH:
-		case ICMPV6_PKT_TOOBIG:
-		case ICMPV6_TIME_EXCEED:
-			/* Max length: 3+maxlen */
-			if (recurse) {
-				nf_log_buf_add(m, "[");
-				dump_ipv6_packet(net, m, info, skb,
-						 ptr + sizeof(_icmp6h), 0);
-				nf_log_buf_add(m, "] ");
-			}
-
-			/* Max length: 10 "MTU=65535 " */
-			if (ic->icmp6_type == ICMPV6_PKT_TOOBIG) {
-				nf_log_buf_add(m, "MTU=%u ",
-					       ntohl(ic->icmp6_mtu));
-			}
-		}
-		break;
-	}
-	/* Max length: 10 "PROTO=255 " */
-	default:
-		nf_log_buf_add(m, "PROTO=%u ", currenthdr);
-	}
-
-	/* Max length: 15 "UID=4294967295 " */
-	if ((logflags & NF_LOG_UID) && recurse)
-		nf_log_dump_sk_uid_gid(net, m, skb->sk);
-
-	/* Max length: 16 "MARK=0xFFFFFFFF " */
-	if (recurse && skb->mark)
-		nf_log_buf_add(m, "MARK=0x%x ", skb->mark);
-}
-
-static void dump_ipv6_mac_header(struct nf_log_buf *m,
-				 const struct nf_loginfo *info,
-				 const struct sk_buff *skb)
-{
-	struct net_device *dev = skb->dev;
-	unsigned int logflags = 0;
-
-	if (info->type == NF_LOG_TYPE_LOG)
-		logflags = info->u.log.logflags;
-
-	if (!(logflags & NF_LOG_MACDECODE))
-		goto fallback;
-
-	switch (dev->type) {
-	case ARPHRD_ETHER:
-		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
-			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
-		nf_log_dump_vlan(m, skb);
-		nf_log_buf_add(m, "MACPROTO=%04x ",
-			       ntohs(eth_hdr(skb)->h_proto));
-		return;
-	default:
-		break;
-	}
-
-fallback:
-	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
-	    skb_mac_header_len(skb) != 0) {
-		const unsigned char *p = skb_mac_header(skb);
-		unsigned int len = dev->hard_header_len;
-		unsigned int i;
-
-		if (dev->type == ARPHRD_SIT) {
-			p -= ETH_HLEN;
-
-			if (p < skb->head)
-				p = NULL;
-		}
-
-		if (p != NULL) {
-			nf_log_buf_add(m, "%02x", *p++);
-			for (i = 1; i < len; i++)
-				nf_log_buf_add(m, ":%02x", *p++);
-		}
-		nf_log_buf_add(m, " ");
-
-		if (dev->type == ARPHRD_SIT) {
-			const struct iphdr *iph =
-				(struct iphdr *)skb_mac_header(skb);
-			nf_log_buf_add(m, "TUNNEL=%pI4->%pI4 ", &iph->saddr,
-				       &iph->daddr);
-		}
-	} else {
-		nf_log_buf_add(m, " ");
-	}
-}
-
-static void nf_log_ip6_packet(struct net *net, u_int8_t pf,
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
-	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out,
-				  loginfo, prefix);
-
-	if (in != NULL)
-		dump_ipv6_mac_header(m, loginfo, skb);
-
-	dump_ipv6_packet(net, m, loginfo, skb, skb_network_offset(skb), 1);
-
-	nf_log_buf_close(m);
-}
-
-static struct nf_logger nf_ip6_logger __read_mostly = {
-	.name		= "nf_log_ipv6",
-	.type		= NF_LOG_TYPE_LOG,
-	.logfn		= nf_log_ip6_packet,
-	.me		= THIS_MODULE,
-};
-
-static int __net_init nf_log_ipv6_net_init(struct net *net)
-{
-	return nf_log_set(net, NFPROTO_IPV6, &nf_ip6_logger);
-}
-
-static void __net_exit nf_log_ipv6_net_exit(struct net *net)
-{
-	nf_log_unset(net, &nf_ip6_logger);
-}
-
-static struct pernet_operations nf_log_ipv6_net_ops = {
-	.init = nf_log_ipv6_net_init,
-	.exit = nf_log_ipv6_net_exit,
-};
-
-static int __init nf_log_ipv6_init(void)
-{
-	int ret;
-
-	ret = register_pernet_subsys(&nf_log_ipv6_net_ops);
-	if (ret < 0)
-		return ret;
-
-	ret = nf_log_register(NFPROTO_IPV6, &nf_ip6_logger);
-	if (ret < 0) {
-		pr_err("failed to register logger\n");
-		goto err1;
-	}
-
-	return 0;
-
-err1:
-	unregister_pernet_subsys(&nf_log_ipv6_net_ops);
-	return ret;
-}
-
-static void __exit nf_log_ipv6_exit(void)
-{
-	unregister_pernet_subsys(&nf_log_ipv6_net_ops);
-	nf_log_unregister(&nf_ip6_logger);
-}
-
-module_init(nf_log_ipv6_init);
-module_exit(nf_log_ipv6_exit);
-
-MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
-MODULE_DESCRIPTION("Netfilter IPv6 packet logging");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NF_LOGGER(AF_INET6, 0);
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 1d18e46875c65..488e39241cc74 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -76,7 +76,10 @@ config NF_LOG_COMMON
 
 config NF_LOG_NETDEV
 	tristate "Netdev packet logging"
-	select NF_LOG_COMMON
+	select NF_LOG_SYSLOG
+	help
+	  This is a backwards-compat option for the user's convenience
+	  (e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
 
 config NF_LOG_SYSLOG
 	tristate "Syslog packet logging"
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 093147f19d0b2..de8ccb50b4349 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -52,9 +52,6 @@ nf_nat-y	:= nf_nat_core.o nf_nat_proto.o nf_nat_helper.o
 obj-$(CONFIG_NF_LOG_COMMON) += nf_log_common.o
 obj-$(CONFIG_NF_LOG_SYSLOG) += nf_log_syslog.o
 
-# packet logging for netdev family
-obj-$(CONFIG_NF_LOG_NETDEV) += nf_log_netdev.o
-
 obj-$(CONFIG_NF_NAT) += nf_nat.o
 nf_nat-$(CONFIG_NF_NAT_REDIRECT) += nf_nat_redirect.o
 nf_nat-$(CONFIG_NF_NAT_MASQUERADE) += nf_nat_masquerade.o
diff --git a/net/netfilter/nf_log_netdev.c b/net/netfilter/nf_log_netdev.c
deleted file mode 100644
index 968dafa684c97..0000000000000
--- a/net/netfilter/nf_log_netdev.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * (C) 2016 by Pablo Neira Ayuso <pablo@netfilter.org>
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/skbuff.h>
-#include <linux/ip.h>
-#include <net/route.h>
-
-#include <linux/netfilter.h>
-#include <net/netfilter/nf_log.h>
-
-static void nf_log_netdev_packet(struct net *net, u_int8_t pf,
-				 unsigned int hooknum,
-				 const struct sk_buff *skb,
-				 const struct net_device *in,
-				 const struct net_device *out,
-				 const struct nf_loginfo *loginfo,
-				 const char *prefix)
-{
-	nf_log_l2packet(net, pf, skb->protocol, hooknum, skb, in, out,
-			loginfo, prefix);
-}
-
-static struct nf_logger nf_netdev_logger __read_mostly = {
-	.name		= "nf_log_netdev",
-	.type		= NF_LOG_TYPE_LOG,
-	.logfn		= nf_log_netdev_packet,
-	.me		= THIS_MODULE,
-};
-
-static int __net_init nf_log_netdev_net_init(struct net *net)
-{
-	return nf_log_set(net, NFPROTO_NETDEV, &nf_netdev_logger);
-}
-
-static void __net_exit nf_log_netdev_net_exit(struct net *net)
-{
-	nf_log_unset(net, &nf_netdev_logger);
-}
-
-static struct pernet_operations nf_log_netdev_net_ops = {
-	.init = nf_log_netdev_net_init,
-	.exit = nf_log_netdev_net_exit,
-};
-
-static int __init nf_log_netdev_init(void)
-{
-	int ret;
-
-	/* Request to load the real packet loggers. */
-	nf_logger_request_module(NFPROTO_IPV4, NF_LOG_TYPE_LOG);
-	nf_logger_request_module(NFPROTO_IPV6, NF_LOG_TYPE_LOG);
-	nf_logger_request_module(NFPROTO_ARP, NF_LOG_TYPE_LOG);
-
-	ret = register_pernet_subsys(&nf_log_netdev_net_ops);
-	if (ret < 0)
-		return ret;
-
-	nf_log_register(NFPROTO_NETDEV, &nf_netdev_logger);
-	return 0;
-}
-
-static void __exit nf_log_netdev_exit(void)
-{
-	unregister_pernet_subsys(&nf_log_netdev_net_ops);
-	nf_log_unregister(&nf_netdev_logger);
-}
-
-module_init(nf_log_netdev_init);
-module_exit(nf_log_netdev_exit);
-
-MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
-MODULE_DESCRIPTION("Netfilter netdev packet logging");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NF_LOGGER(5, 0); /* NFPROTO_NETDEV */
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 651412ff8c8e9..cce8f282b0eda 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -18,6 +18,7 @@
 #include <net/route.h>
 
 #include <linux/netfilter.h>
+#include <linux/netfilter_ipv6.h>
 #include <linux/netfilter/xt_LOG.h>
 #include <net/netfilter/nf_log.h>
 
@@ -355,6 +356,249 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 	/* maxlen = 230+   91  + 230 + 252 = 803 */
 }
 
+static noinline_for_stack void
+dump_ipv6_packet(struct net *net, struct nf_log_buf *m,
+		 const struct nf_loginfo *info,
+		 const struct sk_buff *skb, unsigned int ip6hoff,
+		 int recurse)
+{
+	const struct ipv6hdr *ih;
+	unsigned int hdrlen = 0;
+	unsigned int logflags;
+	struct ipv6hdr _ip6h;
+	unsigned int ptr;
+	u8 currenthdr;
+	int fragment;
+
+	if (info->type == NF_LOG_TYPE_LOG)
+		logflags = info->u.log.logflags;
+	else
+		logflags = NF_LOG_DEFAULT_MASK;
+
+	ih = skb_header_pointer(skb, ip6hoff, sizeof(_ip6h), &_ip6h);
+	if (!ih) {
+		nf_log_buf_add(m, "TRUNCATED");
+		return;
+	}
+
+	/* Max length: 88 "SRC=0000.0000.0000.0000.0000.0000.0000.0000 DST=0000.0000.0000.0000.0000.0000.0000.0000 " */
+	nf_log_buf_add(m, "SRC=%pI6 DST=%pI6 ", &ih->saddr, &ih->daddr);
+
+	/* Max length: 44 "LEN=65535 TC=255 HOPLIMIT=255 FLOWLBL=FFFFF " */
+	nf_log_buf_add(m, "LEN=%zu TC=%u HOPLIMIT=%u FLOWLBL=%u ",
+		       ntohs(ih->payload_len) + sizeof(struct ipv6hdr),
+		       (ntohl(*(__be32 *)ih) & 0x0ff00000) >> 20,
+		       ih->hop_limit,
+		       (ntohl(*(__be32 *)ih) & 0x000fffff));
+
+	fragment = 0;
+	ptr = ip6hoff + sizeof(struct ipv6hdr);
+	currenthdr = ih->nexthdr;
+	while (currenthdr != NEXTHDR_NONE && nf_ip6_ext_hdr(currenthdr)) {
+		struct ipv6_opt_hdr _hdr;
+		const struct ipv6_opt_hdr *hp;
+
+		hp = skb_header_pointer(skb, ptr, sizeof(_hdr), &_hdr);
+		if (!hp) {
+			nf_log_buf_add(m, "TRUNCATED");
+			return;
+		}
+
+		/* Max length: 48 "OPT (...) " */
+		if (logflags & NF_LOG_IPOPT)
+			nf_log_buf_add(m, "OPT ( ");
+
+		switch (currenthdr) {
+		case IPPROTO_FRAGMENT: {
+			struct frag_hdr _fhdr;
+			const struct frag_hdr *fh;
+
+			nf_log_buf_add(m, "FRAG:");
+			fh = skb_header_pointer(skb, ptr, sizeof(_fhdr),
+						&_fhdr);
+			if (!fh) {
+				nf_log_buf_add(m, "TRUNCATED ");
+				return;
+			}
+
+			/* Max length: 6 "65535 " */
+			nf_log_buf_add(m, "%u ", ntohs(fh->frag_off) & 0xFFF8);
+
+			/* Max length: 11 "INCOMPLETE " */
+			if (fh->frag_off & htons(0x0001))
+				nf_log_buf_add(m, "INCOMPLETE ");
+
+			nf_log_buf_add(m, "ID:%08x ",
+				       ntohl(fh->identification));
+
+			if (ntohs(fh->frag_off) & 0xFFF8)
+				fragment = 1;
+
+			hdrlen = 8;
+			break;
+		}
+		case IPPROTO_DSTOPTS:
+		case IPPROTO_ROUTING:
+		case IPPROTO_HOPOPTS:
+			if (fragment) {
+				if (logflags & NF_LOG_IPOPT)
+					nf_log_buf_add(m, ")");
+				return;
+			}
+			hdrlen = ipv6_optlen(hp);
+			break;
+		/* Max Length */
+		case IPPROTO_AH:
+			if (logflags & NF_LOG_IPOPT) {
+				struct ip_auth_hdr _ahdr;
+				const struct ip_auth_hdr *ah;
+
+				/* Max length: 3 "AH " */
+				nf_log_buf_add(m, "AH ");
+
+				if (fragment) {
+					nf_log_buf_add(m, ")");
+					return;
+				}
+
+				ah = skb_header_pointer(skb, ptr, sizeof(_ahdr),
+							&_ahdr);
+				if (!ah) {
+					/* Max length: 26 "INCOMPLETE [65535 bytes] )" */
+					nf_log_buf_add(m, "INCOMPLETE [%u bytes] )",
+						       skb->len - ptr);
+					return;
+				}
+
+				/* Length: 15 "SPI=0xF1234567 */
+				nf_log_buf_add(m, "SPI=0x%x ", ntohl(ah->spi));
+			}
+
+			hdrlen = ipv6_authlen(hp);
+			break;
+		case IPPROTO_ESP:
+			if (logflags & NF_LOG_IPOPT) {
+				struct ip_esp_hdr _esph;
+				const struct ip_esp_hdr *eh;
+
+				/* Max length: 4 "ESP " */
+				nf_log_buf_add(m, "ESP ");
+
+				if (fragment) {
+					nf_log_buf_add(m, ")");
+					return;
+				}
+
+				/* Max length: 26 "INCOMPLETE [65535 bytes] )" */
+				eh = skb_header_pointer(skb, ptr, sizeof(_esph),
+							&_esph);
+				if (!eh) {
+					nf_log_buf_add(m, "INCOMPLETE [%u bytes] )",
+						       skb->len - ptr);
+					return;
+				}
+
+				/* Length: 16 "SPI=0xF1234567 )" */
+				nf_log_buf_add(m, "SPI=0x%x )",
+					       ntohl(eh->spi));
+			}
+			return;
+		default:
+			/* Max length: 20 "Unknown Ext Hdr 255" */
+			nf_log_buf_add(m, "Unknown Ext Hdr %u", currenthdr);
+			return;
+		}
+		if (logflags & NF_LOG_IPOPT)
+			nf_log_buf_add(m, ") ");
+
+		currenthdr = hp->nexthdr;
+		ptr += hdrlen;
+	}
+
+	switch (currenthdr) {
+	case IPPROTO_TCP:
+		if (nf_log_dump_tcp_header(m, skb, currenthdr, fragment,
+					   ptr, logflags))
+			return;
+		break;
+	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
+		if (nf_log_dump_udp_header(m, skb, currenthdr, fragment, ptr))
+			return;
+		break;
+	case IPPROTO_ICMPV6: {
+		struct icmp6hdr _icmp6h;
+		const struct icmp6hdr *ic;
+
+		/* Max length: 13 "PROTO=ICMPv6 " */
+		nf_log_buf_add(m, "PROTO=ICMPv6 ");
+
+		if (fragment)
+			break;
+
+		/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+		ic = skb_header_pointer(skb, ptr, sizeof(_icmp6h), &_icmp6h);
+		if (!ic) {
+			nf_log_buf_add(m, "INCOMPLETE [%u bytes] ",
+				       skb->len - ptr);
+			return;
+		}
+
+		/* Max length: 18 "TYPE=255 CODE=255 " */
+		nf_log_buf_add(m, "TYPE=%u CODE=%u ",
+			       ic->icmp6_type, ic->icmp6_code);
+
+		switch (ic->icmp6_type) {
+		case ICMPV6_ECHO_REQUEST:
+		case ICMPV6_ECHO_REPLY:
+			/* Max length: 19 "ID=65535 SEQ=65535 " */
+			nf_log_buf_add(m, "ID=%u SEQ=%u ",
+				       ntohs(ic->icmp6_identifier),
+				       ntohs(ic->icmp6_sequence));
+			break;
+		case ICMPV6_MGM_QUERY:
+		case ICMPV6_MGM_REPORT:
+		case ICMPV6_MGM_REDUCTION:
+			break;
+
+		case ICMPV6_PARAMPROB:
+			/* Max length: 17 "POINTER=ffffffff " */
+			nf_log_buf_add(m, "POINTER=%08x ",
+				       ntohl(ic->icmp6_pointer));
+			fallthrough;
+		case ICMPV6_DEST_UNREACH:
+		case ICMPV6_PKT_TOOBIG:
+		case ICMPV6_TIME_EXCEED:
+			/* Max length: 3+maxlen */
+			if (recurse) {
+				nf_log_buf_add(m, "[");
+				dump_ipv6_packet(net, m, info, skb,
+						 ptr + sizeof(_icmp6h), 0);
+				nf_log_buf_add(m, "] ");
+			}
+
+			/* Max length: 10 "MTU=65535 " */
+			if (ic->icmp6_type == ICMPV6_PKT_TOOBIG) {
+				nf_log_buf_add(m, "MTU=%u ",
+					       ntohl(ic->icmp6_mtu));
+			}
+		}
+		break;
+	}
+	/* Max length: 10 "PROTO=255 " */
+	default:
+		nf_log_buf_add(m, "PROTO=%u ", currenthdr);
+	}
+
+	/* Max length: 15 "UID=4294967295 " */
+	if ((logflags & NF_LOG_UID) && recurse)
+		nf_log_dump_sk_uid_gid(net, m, skb->sk);
+
+	/* Max length: 16 "MARK=0xFFFFFFFF " */
+	if (recurse && skb->mark)
+		nf_log_buf_add(m, "MARK=0x%x ", skb->mark);
+}
+
 static void dump_ipv4_mac_header(struct nf_log_buf *m,
 				 const struct nf_loginfo *info,
 				 const struct sk_buff *skb)
@@ -430,6 +674,138 @@ static struct nf_logger nf_ip_logger __read_mostly = {
 	.me		= THIS_MODULE,
 };
 
+static void dump_ipv6_mac_header(struct nf_log_buf *m,
+				 const struct nf_loginfo *info,
+				 const struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+	unsigned int logflags = 0;
+
+	if (info->type == NF_LOG_TYPE_LOG)
+		logflags = info->u.log.logflags;
+
+	if (!(logflags & NF_LOG_MACDECODE))
+		goto fallback;
+
+	switch (dev->type) {
+	case ARPHRD_ETHER:
+		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
+			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
+		nf_log_dump_vlan(m, skb);
+		nf_log_buf_add(m, "MACPROTO=%04x ",
+			       ntohs(eth_hdr(skb)->h_proto));
+		return;
+	default:
+		break;
+	}
+
+fallback:
+	nf_log_buf_add(m, "MAC=");
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) != 0) {
+		const unsigned char *p = skb_mac_header(skb);
+		unsigned int len = dev->hard_header_len;
+		unsigned int i;
+
+		if (dev->type == ARPHRD_SIT) {
+			p -= ETH_HLEN;
+
+			if (p < skb->head)
+				p = NULL;
+		}
+
+		if (p) {
+			nf_log_buf_add(m, "%02x", *p++);
+			for (i = 1; i < len; i++)
+				nf_log_buf_add(m, ":%02x", *p++);
+		}
+		nf_log_buf_add(m, " ");
+
+		if (dev->type == ARPHRD_SIT) {
+			const struct iphdr *iph =
+				(struct iphdr *)skb_mac_header(skb);
+			nf_log_buf_add(m, "TUNNEL=%pI4->%pI4 ", &iph->saddr,
+				       &iph->daddr);
+		}
+	} else {
+		nf_log_buf_add(m, " ");
+	}
+}
+
+static void nf_log_ip6_packet(struct net *net, u_int8_t pf,
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
+	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out,
+				  loginfo, prefix);
+
+	if (in)
+		dump_ipv6_mac_header(m, loginfo, skb);
+
+	dump_ipv6_packet(net, m, loginfo, skb, skb_network_offset(skb), 1);
+
+	nf_log_buf_close(m);
+}
+
+static struct nf_logger nf_ip6_logger __read_mostly = {
+	.name		= "nf_log_ipv6",
+	.type		= NF_LOG_TYPE_LOG,
+	.logfn		= nf_log_ip6_packet,
+	.me		= THIS_MODULE,
+};
+
+static void nf_log_netdev_packet(struct net *net, u_int8_t pf,
+				 unsigned int hooknum,
+				 const struct sk_buff *skb,
+				 const struct net_device *in,
+				 const struct net_device *out,
+				 const struct nf_loginfo *loginfo,
+				 const char *prefix)
+{
+	nf_log_l2packet(net, pf, skb->protocol, hooknum, skb, in, out,
+			loginfo, prefix);
+}
+
+static struct nf_logger nf_netdev_logger __read_mostly = {
+	.name		= "nf_log_netdev",
+	.type		= NF_LOG_TYPE_LOG,
+	.logfn		= nf_log_netdev_packet,
+	.me		= THIS_MODULE,
+};
+
+static void nf_log_bridge_packet(struct net *net, u_int8_t pf,
+				 unsigned int hooknum,
+				 const struct sk_buff *skb,
+				 const struct net_device *in,
+				 const struct net_device *out,
+				 const struct nf_loginfo *loginfo,
+				 const char *prefix)
+{
+	nf_log_l2packet(net, pf, eth_hdr(skb)->h_proto, hooknum, skb,
+			in, out, loginfo, prefix);
+}
+
+static struct nf_logger nf_bridge_logger __read_mostly = {
+	.name		= "nf_log_bridge",
+	.type		= NF_LOG_TYPE_LOG,
+	.logfn		= nf_log_bridge_packet,
+	.me		= THIS_MODULE,
+};
+
 static int __net_init nf_log_syslog_net_init(struct net *net)
 {
 	int ret = nf_log_set(net, NFPROTO_IPV4, &nf_ip_logger);
@@ -440,8 +816,27 @@ static int __net_init nf_log_syslog_net_init(struct net *net)
 	ret = nf_log_set(net, NFPROTO_ARP, &nf_arp_logger);
 	if (ret)
 		goto err1;
-err1:
+
+	ret = nf_log_set(net, NFPROTO_IPV6, &nf_ip6_logger);
+	if (ret)
+		goto err2;
+
+	ret = nf_log_set(net, NFPROTO_NETDEV, &nf_netdev_logger);
+	if (ret)
+		goto err3;
+
+	ret = nf_log_set(net, NFPROTO_BRIDGE, &nf_bridge_logger);
+	if (ret)
+		goto err4;
+	return 0;
+err4:
+	nf_log_unset(net, &nf_netdev_logger);
+err3:
+	nf_log_unset(net, &nf_ip6_logger);
+err2:
 	nf_log_unset(net, &nf_arp_logger);
+err1:
+	nf_log_unset(net, &nf_ip_logger);
 	return ret;
 }
 
@@ -449,11 +844,14 @@ static void __net_exit nf_log_syslog_net_exit(struct net *net)
 {
 	nf_log_unset(net, &nf_ip_logger);
 	nf_log_unset(net, &nf_arp_logger);
+	nf_log_unset(net, &nf_ip6_logger);
+	nf_log_unset(net, &nf_netdev_logger);
+	nf_log_unset(net, &nf_bridge_logger);
 }
 
 static struct pernet_operations nf_log_syslog_net_ops = {
 	.init = nf_log_syslog_net_init,
-	.exit = nf_log_syslog_net_exit,
+	.pre_exit = nf_log_syslog_net_exit,
 };
 
 static int __init nf_log_syslog_init(void)
@@ -472,9 +870,27 @@ static int __init nf_log_syslog_init(void)
 	if (ret < 0)
 		goto err2;
 
+	ret = nf_log_register(NFPROTO_IPV6, &nf_ip6_logger);
+	if (ret < 0)
+		goto err3;
+
+	ret = nf_log_register(NFPROTO_NETDEV, &nf_netdev_logger);
+	if (ret < 0)
+		goto err4;
+
+	ret = nf_log_register(NFPROTO_BRIDGE, &nf_bridge_logger);
+	if (ret < 0)
+		goto err5;
+
 	return 0;
-err2:
+err5:
+	nf_log_unregister(&nf_netdev_logger);
+err4:
+	nf_log_unregister(&nf_ip6_logger);
+err3:
 	nf_log_unregister(&nf_arp_logger);
+err2:
+	nf_log_unregister(&nf_ip_logger);
 err1:
 	pr_err("failed to register logger\n");
 	unregister_pernet_subsys(&nf_log_syslog_net_ops);
@@ -486,6 +902,9 @@ static void __exit nf_log_syslog_exit(void)
 	unregister_pernet_subsys(&nf_log_syslog_net_ops);
 	nf_log_unregister(&nf_ip_logger);
 	nf_log_unregister(&nf_arp_logger);
+	nf_log_unregister(&nf_ip6_logger);
+	nf_log_unregister(&nf_netdev_logger);
+	nf_log_unregister(&nf_bridge_logger);
 }
 
 module_init(nf_log_syslog_init);
@@ -495,6 +914,12 @@ MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
 MODULE_DESCRIPTION("Netfilter syslog packet logging");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("nf_log_arp");
+MODULE_ALIAS("nf_log_bridge");
 MODULE_ALIAS("nf_log_ipv4");
+MODULE_ALIAS("nf_log_ipv6");
+MODULE_ALIAS("nf_log_netdev");
+MODULE_ALIAS_NF_LOGGER(AF_BRIDGE, 0);
 MODULE_ALIAS_NF_LOGGER(AF_INET, 0);
 MODULE_ALIAS_NF_LOGGER(3, 0);
+MODULE_ALIAS_NF_LOGGER(5, 0); /* NFPROTO_NETDEV */
+MODULE_ALIAS_NF_LOGGER(AF_INET6, 0);
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 8c967bd772ec3..dbb226aa4c0ea 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -1128,6 +1128,8 @@ static void __net_exit nfnl_log_net_exit(struct net *net)
 	remove_proc_entry("nfnetlink_log", net->nf.proc_netfilter);
 #endif
 	nf_log_unset(net, &nfulnl_logger);
+	/* Wait for packet loggers before freeing per-net state. */
+	synchronize_rcu();
 	for (i = 0; i < INSTANCE_BUCKETS; i++)
 		WARN_ON_ONCE(!hlist_empty(&log->instance_table[i]));
 }
-- 
2.53.0

