Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199C3783AE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635005; cv=none; b=uqcWXPHX2wKuHQf8ExMgfrmBswouC711E611ejTETdGoqnDdnZxhPwxrbXLMrVnQupN2am24Kc6YGx1Lu2Z3PvbN79cj/tlZIs1Tk4SB0/Qc0bU0AupTmVkNLVq7cS45JjVmMiH0NJ04xnhmRr6narmnxC/BNHXA8nvJ3m7oFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635005; c=relaxed/simple;
	bh=UUmExpPkhBWYgVSe9tjbTWPPp0EthwFn2zSK7CZ+ArA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6mzpRLNbbNcG2+Ca9IH8zFBJnPpqcAc1i/zFjVxrq8RCZz2BPKsTsKjB1Xu86zcMIVzMVaMF85FdObkxARiAY2+zOKW17ym90YPWy1wPGBHcPq8L3YcpT13t8lqGLKR/8Z4Kz+EoNlO2/iF85TWTSXr4BCnVmudBagmsr38oYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9f5Et63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9f5Et63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA3B1F000E9;
	Tue, 21 Jul 2026 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635004;
	bh=d4nn9CEGEa4LOnJFX1D0fIgKUnV0khbfpct3HBFkIoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9f5Et63x15UI+5clTP2g/QCthMkcvF+1yniQeXWpHug2wRqUoN2p1LIrdh3uU4g0
	 PNWjKAvu7NK2vYHnogHdvNCnl88Cw6xTuQNBcGTG2XMCZyPHhKBYPOIqRuovSPfXhc
	 GfEzcQf1A+rLrXMoEEX1cXsoGViKOrlk6meSysksESgZBAtTiYkSAnV05ymuPdqUi/
	 eBf1RO//YDLyCb2H5gMtpqjXTlXs/+G7C5y8pvXdJaLSnWHt54N24golx9snxVF8p1
	 PZEWTtMiTtQJr7RHk6EMs+Ezk2I+1fIXPd1NVIiZJEFt62crYrDAeejoPWsFNsoXAA
	 KmAB9/Olb5Cwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] audit: add audit_log_nf_skb helper function
Date: Tue, 21 Jul 2026 07:56:41 -0400
Message-ID: <20260721115642.3699441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071527-delusion-yarn-0b07@gregkh>
References: <2026071527-delusion-yarn-0b07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Robaina <rrobaina@redhat.com>

[ Upstream commit f19590b07cb620be1fcd5474c49515e21a05d406 ]

Netfilter code (net/netfilter/nft_log.c and net/netfilter/xt_AUDIT.c)
have to be kept in sync. Both source files had duplicated versions of
audit_ip4() and audit_ip6() functions, which can result in lack of
consistency and/or duplicated work.

This patch adds a helper function in audit.c that can be called by
netfilter code commonly, aiming to improve maintainability and
consistency.

Suggested-by: Florian Westphal <fw@strlen.de>
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: 65dfde57d1e2 ("audit: fix potential integer overflow in audit_log_n_hex()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/audit.h    |  8 +++++
 kernel/audit.c           | 64 ++++++++++++++++++++++++++++++++++++++++
 net/netfilter/nft_log.c  | 58 +-----------------------------------
 net/netfilter/xt_AUDIT.c | 58 +-----------------------------------
 4 files changed, 74 insertions(+), 114 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b3d859831a3168..199274cc7615fc 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -186,6 +186,8 @@ extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
+extern int audit_log_nf_skb(struct audit_buffer *ab,
+			    const struct sk_buff *skb, u8 nfproto);
 
 extern int		    audit_update_lsm_rules(void);
 
@@ -251,6 +253,12 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 static inline void audit_log_task_info(struct audit_buffer *ab)
 { }
 
+static inline int audit_log_nf_skb(struct audit_buffer *ab,
+				   const struct sk_buff *skb, u8 nfproto)
+{
+	return 0;
+}
+
 static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
 {
 	return INVALID_UID;
diff --git a/kernel/audit.c b/kernel/audit.c
index da07e4f2117b5e..2d38092a30322a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -59,6 +59,8 @@
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 
 #include "audit.h"
 
@@ -2304,6 +2306,68 @@ void audit_log_path_denied(int type, const char *operation)
 	audit_log_end(ab);
 }
 
+int audit_log_nf_skb(struct audit_buffer *ab,
+		     const struct sk_buff *skb, u8 nfproto)
+{
+	/* find the IP protocol in the case of NFPROTO_BRIDGE */
+	if (nfproto == NFPROTO_BRIDGE) {
+		switch (eth_hdr(skb)->h_proto) {
+		case htons(ETH_P_IP):
+			nfproto = NFPROTO_IPV4;
+			break;
+		case htons(ETH_P_IPV6):
+			nfproto = NFPROTO_IPV6;
+			break;
+		default:
+			goto unknown_proto;
+		}
+	}
+
+	switch (nfproto) {
+	case NFPROTO_IPV4: {
+		struct iphdr iph;
+		const struct iphdr *ih;
+
+		ih = skb_header_pointer(skb, skb_network_offset(skb),
+					sizeof(iph), &iph);
+		if (!ih)
+			return -ENOMEM;
+
+		audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
+				 &ih->saddr, &ih->daddr, ih->protocol);
+		break;
+	}
+	case NFPROTO_IPV6: {
+		struct ipv6hdr iph;
+		const struct ipv6hdr *ih;
+		u8 nexthdr;
+		__be16 frag_off;
+
+		ih = skb_header_pointer(skb, skb_network_offset(skb),
+					sizeof(iph), &iph);
+		if (!ih)
+			return -ENOMEM;
+
+		nexthdr = ih->nexthdr;
+		ipv6_skip_exthdr(skb, skb_network_offset(skb) + sizeof(iph),
+				 &nexthdr, &frag_off);
+
+		audit_log_format(ab, " saddr=%pI6c daddr=%pI6c proto=%hhu",
+				 &ih->saddr, &ih->daddr, nexthdr);
+		break;
+	}
+	default:
+		goto unknown_proto;
+	}
+
+	return 0;
+
+unknown_proto:
+	audit_log_format(ab, " saddr=? daddr=? proto=?");
+	return -EPFNOSUPPORT;
+}
+EXPORT_SYMBOL(audit_log_nf_skb);
+
 /* global counter which is incremented every time something logs in */
 static atomic_t session_id = ATOMIC_INIT(0);
 
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index 57899454a53031..802a5a9b06c72f 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -26,46 +26,10 @@ struct nft_log {
 	char			*prefix;
 };
 
-static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
-{
-	struct iphdr _iph;
-	const struct iphdr *ih;
-
-	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_iph), &_iph);
-	if (!ih)
-		return false;
-
-	audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
-			 &ih->saddr, &ih->daddr, ih->protocol);
-
-	return true;
-}
-
-static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
-{
-	struct ipv6hdr _ip6h;
-	const struct ipv6hdr *ih;
-	u8 nexthdr;
-	__be16 frag_off;
-
-	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_ip6h), &_ip6h);
-	if (!ih)
-		return false;
-
-	nexthdr = ih->nexthdr;
-	ipv6_skip_exthdr(skb, skb_network_offset(skb) + sizeof(_ip6h), &nexthdr, &frag_off);
-
-	audit_log_format(ab, " saddr=%pI6c daddr=%pI6c proto=%hhu",
-			 &ih->saddr, &ih->daddr, nexthdr);
-
-	return true;
-}
-
 static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
 {
 	struct sk_buff *skb = pkt->skb;
 	struct audit_buffer *ab;
-	int fam = -1;
 
 	if (!audit_enabled)
 		return;
@@ -76,27 +40,7 @@ static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
 
 	audit_log_format(ab, "mark=%#x", skb->mark);
 
-	switch (nft_pf(pkt)) {
-	case NFPROTO_BRIDGE:
-		switch (eth_hdr(skb)->h_proto) {
-		case htons(ETH_P_IP):
-			fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-			break;
-		case htons(ETH_P_IPV6):
-			fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-			break;
-		}
-		break;
-	case NFPROTO_IPV4:
-		fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-		break;
-	case NFPROTO_IPV6:
-		fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-		break;
-	}
-
-	if (fam == -1)
-		audit_log_format(ab, " saddr=? daddr=? proto=-1");
+	audit_log_nf_skb(ab, skb, nft_pf(pkt));
 
 	audit_log_end(ab);
 }
diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
index 9cdc16b0d0d814..38eae24373d44f 100644
--- a/net/netfilter/xt_AUDIT.c
+++ b/net/netfilter/xt_AUDIT.c
@@ -28,46 +28,10 @@ MODULE_ALIAS("ip6t_AUDIT");
 MODULE_ALIAS("ebt_AUDIT");
 MODULE_ALIAS("arpt_AUDIT");
 
-static bool audit_ip4(struct audit_buffer *ab, struct sk_buff *skb)
-{
-	struct iphdr _iph;
-	const struct iphdr *ih;
-
-	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_iph), &_iph);
-	if (!ih)
-		return false;
-
-	audit_log_format(ab, " saddr=%pI4 daddr=%pI4 proto=%hhu",
-			 &ih->saddr, &ih->daddr, ih->protocol);
-
-	return true;
-}
-
-static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
-{
-	struct ipv6hdr _ip6h;
-	const struct ipv6hdr *ih;
-	u8 nexthdr;
-	__be16 frag_off;
-
-	ih = skb_header_pointer(skb, skb_network_offset(skb), sizeof(_ip6h), &_ip6h);
-	if (!ih)
-		return false;
-
-	nexthdr = ih->nexthdr;
-	ipv6_skip_exthdr(skb, skb_network_offset(skb) + sizeof(_ip6h), &nexthdr, &frag_off);
-
-	audit_log_format(ab, " saddr=%pI6c daddr=%pI6c proto=%hhu",
-			 &ih->saddr, &ih->daddr, nexthdr);
-
-	return true;
-}
-
 static unsigned int
 audit_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	struct audit_buffer *ab;
-	int fam = -1;
 
 	if (audit_enabled == AUDIT_OFF)
 		goto errout;
@@ -77,27 +41,7 @@ audit_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
 	audit_log_format(ab, "mark=%#x", skb->mark);
 
-	switch (xt_family(par)) {
-	case NFPROTO_BRIDGE:
-		switch (eth_hdr(skb)->h_proto) {
-		case htons(ETH_P_IP):
-			fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-			break;
-		case htons(ETH_P_IPV6):
-			fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-			break;
-		}
-		break;
-	case NFPROTO_IPV4:
-		fam = audit_ip4(ab, skb) ? NFPROTO_IPV4 : -1;
-		break;
-	case NFPROTO_IPV6:
-		fam = audit_ip6(ab, skb) ? NFPROTO_IPV6 : -1;
-		break;
-	}
-
-	if (fam == -1)
-		audit_log_format(ab, " saddr=? daddr=? proto=-1");
+	audit_log_nf_skb(ab, skb, xt_family(par));
 
 	audit_log_end(ab);
 
-- 
2.53.0

