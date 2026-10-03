Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA792CCC6
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033429; cv=none; b=e1rN4WrZ3R9LlODFfmiWIWOfMDFHovSNr0V7NRcNSCQi1MeSsecY1sbbJAdyuxfBDCWh+nWP7+Ps9NPdPeoaedMZkSQsQGikZ4DyoImbmUYxFz2Vvef01tZHCIwW9xbrWe4Qa9kxLR6Nh+gJC2pfZFTB6tNopHwH/BSzT1h7dJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033429; c=relaxed/simple;
	bh=v3LAXy3jqrBcg0Iv7bxRbU2Xmom0ufIGgYAXutiD2Ks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ime3fTWDSzlpYxTzMUW/mzn0jT98VfZRSdbnhxnLtoD76oVpQSn+aGr21+nhjaTscDozlO6l3TrDg0E7pXcmK7EPSKmk1wlRgAD8JBwsI2Q6otG+uKnfxLhycfboSPKFaVunM+Achi55IIZL9Zd7I7ECa7PB7kz/xtFcc7Tcerw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0zLdtV7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0zLdtV7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7909B1F0089C;
	Sat,  3 Oct 2026 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033428;
	bh=FAYAJK6qQsg+8Qr8rnAlIvPWdIDTR7pZ3RuqwvTGn2s=;
	h=Subject:To:Cc:From:Date;
	b=0zLdtV7r1s70Yvz/2zRDjNw4bqXOcmXagCS1fJ8Of0K6XxlbzuA5fxtbsK2s1GmM+
	 9z2LNEZEH874AwpgymNBumgY2bI73x9IBWL8/b5hH76QK7OlofNFfD009Lp76KKist
	 DU3D519ZKoyrwcPN7f4EQOmGwASy7a2sk9sYzjJI=
Subject: FAILED: patch "[PATCH] net: gso: limit recursive IP-in-IP segmentation" failed to apply to 6.18-stable tree
To: zihanx@nebusec.ai,pabeni@redhat.com,root@tr0jan.top,vega@nebusec.ai,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:17:05 +0200
Message-ID: <2026100305-credible-reference-2a7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 006c8b834aed8b02bd8fb9fb05e9e7ead37d1763
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100305-credible-reference-2a7c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 006c8b834aed8b02bd8fb9fb05e9e7ead37d1763 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Thu, 24 Sep 2026 05:15:21 +0000
Subject: [PATCH] net: gso: limit recursive IP-in-IP segmentation

IP-in-IP GSO can re-enter inet_gso_segment() or ipv6_gso_segment()
for each nested IP header. encap_level tracks header bytes, not callback
depth, so a deep chain can exhaust the kernel stack. Making
inet_gso_segment() stackable introduced unbounded IPv4 nesting; IPIP
GSO/TSO later made the path reachable. The IPv6 stackable path was
introduced separately and uses the same guard.

Count IPv4 and IPv6 GSO handler entries in skb_gso_cb, initialized once
per top-level GSO operation and preserved across GRE/UDP context changes.
Use the existing IP_TUNNEL_RECURSION_LIMIT for both handlers. The first
five entries pass, and the sixth returns -EINVAL before dispatching
another GSO callback.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260924051521.32568-2-zihanx@nebusec.ai
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad5..0749230d414e 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,18 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
+	u8	recursion_counter;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+static inline bool gso_recursion_inc_test(struct sk_buff *skb,
+					  unsigned int limit)
+{
+	return ++SKB_GSO_CB(skb)->recursion_counter > limit;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4d..e96ef6350064 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -117,6 +117,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..4ce38c99fef9 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1375,6 +1375,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 78f50c93c536..700f1861d8eb 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -17,6 +17,7 @@
 #include <net/udp.h>
 #include <net/gro.h>
 #include <net/gso.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 #include "tcpv6_offload.c"
@@ -104,6 +105,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;

