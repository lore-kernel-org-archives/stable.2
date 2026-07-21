Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5765481FAE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634427; cv=none; b=NjtdiTrt5UrjkNGnyTo8y+StjbGsd81ZhwQ1oojBc51Bl5nYjxIzm1eYahjA10bJSjdrR+/eyyNRjlAX+FuJwjkkeprkcduxOzOavmal/gf6Db+6dB2PkaRvB65fWO6jD0zb6G550X2OYIXKu6SChKHNTNRY5J4DSHtahRu9Lqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634427; c=relaxed/simple;
	bh=GelMaiDOR5Zz5GEyppY7YdeTVNZ6aVogGSPpG8eKLaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clrWOppoq3VU782c39TTYTzSjEJYqyJCKDAOZtFB9tz0mIm4vchVZvf8k+pFiFQ38nN6QLlC7cNkJR3XnntJ/4e62M+o8iZtWOB9ObZ3WrDUFHst9AgurX5l1PZLAYlYvroHapz6WnROoo6J2dI8wJD5BC8tNZ4t7dEvC278stk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiCOl+tY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiCOl+tY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C0F1F00A3A;
	Tue, 21 Jul 2026 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634425;
	bh=0Cn+rYnDrwYts3iF03o/fVGkrTjRmAj4JiOD/0/eqZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PiCOl+tYCnsK6E87Kh8lDMW4J3JOdop9OMJ2rp65vu9n3n28KgSgeSHNVb7z5ugYo
	 wpSaCmbGAhLKwaQYALpYicPSaBXzaWNYohTEPbo86NJpTH46/CRb29xgkHWYVGAHNs
	 IQba4Oo2Fm13iLEQ9ePVrRfhTirEl6t1IGnimRffP9SQiGEzCsdjBGHFy+N0yyxNSb
	 +Ql1tcwWEBQzkwHqosvS5FWy3eqD2ggvEzVHUB1v8vq08Gi9/ahFVJ3TyXKv4GM61V
	 kQ21Z2EooGsLXSb7V1VIKKPzfkKU7Van9gBO4u8WI/gFqNEDXS0BRXrqOR6cuZANva
	 zrxTegBe0uKhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] audit: add audit_log_nf_skb helper function
Date: Tue, 21 Jul 2026 07:47:02 -0400
Message-ID: <20260721114703.3688208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071526-subarctic-bloating-472e@gregkh>
References: <2026071526-subarctic-bloating-472e@gregkh>
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
index 82b7c1116a85c4..4c64e054c74694 100644
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
index 3e1c18a4110138..6cd9421a5610fd 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -59,6 +59,8 @@
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 
 #include "audit.h"
 
@@ -2307,6 +2309,68 @@ void audit_log_path_denied(int type, const char *operation)
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
index 54f6c2035e84d7..48b3049d8666fd 100644
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
index b6a015aee0cecc..4c18606b8654ba 100644
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

