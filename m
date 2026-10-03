Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24313223DC6
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033457; cv=none; b=jCKWmPBzqn7sA1sSufXzY6BR/5ASJBi0B5S4m0kbjMQhdE1/HA0eYuyE18RfFSv5ZrCjXq8DGtrDTRM1ejwQda/tc4TlfqHt1jl5MPS+M4VTHF+gvTomKG7BMG+aCsx1208SxhJi3HaBDNUdPrXBPeFY94dUdITiUPDKf6ACbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033457; c=relaxed/simple;
	bh=yecLm2w0AZa4iCGaiTUyI+I70oQT2aNfbok/0p3G67k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p5bh9ttKSvoeN5LNr8Vi5mmn0an8Yi9vu1Xmj8XlOXYDnguAT3wnw+hhJsdKXJ66IZsSi7UBycq0YB0m/B9nhKCUaLwPVAWu2Hbd5bEzsTml30jM52P76LD3gWmrhKugUb4IcnOSOcrhP/I/t87JTSu0An3gAtmoBCv2QmWPUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KETUAfLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KETUAfLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F941F0089B;
	Sat,  3 Oct 2026 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033455;
	bh=QZrkc14PTh6fYua8b5BXDoGD+hRPj644PmOFvDciRHs=;
	h=Subject:To:Cc:From:Date;
	b=KETUAfLF968iSHDQ48stl3JrU5kBx6CRub2DU++H2riyU92dqpCuYDsUMMDujwP+0
	 DNwJENkkltywr6b4qiJRpML+vh87zXVdGQWvg+uQpBGQq75FzLd88EnxP/5qSFtlMv
	 XUBHcQn22BLenHYElwo77w24LTb1gmZitVWEkbRc=
Subject: FAILED: patch "[PATCH] net: extend IPv6 exthdr detection of tunneled packets" failed to apply to 6.1-stable tree
To: willemb@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:17:24 +0200
Message-ID: <2026100324-coffee-settle-c24f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5f0764cb1c81a9712bce605d38efe6d844a70b29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100324-coffee-settle-c24f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f0764cb1c81a9712bce605d38efe6d844a70b29 Mon Sep 17 00:00:00 2001
From: Willem de Bruijn <willemb@google.com>
Date: Sat, 26 Sep 2026 10:04:54 -0400
Subject: [PATCH] net: extend IPv6 exthdr detection of tunneled packets

Commit c4336a07eb6b ("net: correctly handle tunneled traffic on IPV6_CSUM
GSO fallback") split skb_gso_has_extension_hdr() into mutually exclusive
branches on skb->encapsulation. This did not yet address all paths:

1. With skb->encapsulation set, the outer header is not checked. IPv6
   tunnels such as ip6_gre and ip6_tunnel add an outer Destination
   Options header by default (encap_limit). Their GSO packets skip
   software GSO, then skb_csum_hwoffload_help() sees the outer extension
   header and calls skb_checksum_help() on the GSO skb, which warns and
   drops it.

2. Tunnels over IPv6 without an outer transport header, such as
   ip6_tunnel, leave skb->transport_header at the inner transport
   header. skb_network_header_len() then spans the outer IPv6, tunnel
   and inner IP headers, a false positive.

3. UDP tunnels without an inner network header, such as SCTP-in-UDP or
   PSP, have no inner IPv6 header to check. Decide on the outer header
   alone.

4. Directly dereferencing inner_ip_hdr(skb)->version without
   skb_header_pointer() is unsafe.

Instead, check ipv6_ext_hdr(nexthdr) on the outer IPv6 header and, if
set, on the inner IPv6 header. Read the headers with skb_header_pointer().
Keep the skb_network_header_len() check when !skb->encapsulation to also
catch encapsulated packets without skb->encapsulation (e.g., virtio).

Use the same helper in skb_csum_hwoffload_help(). Its open coded test
has the false positive of (2) and ignores the inner header.

Background: checksum offload of tunneled packets invariants:

Non-GSO skb:
- If the inner packet is CHECKSUM_PARTIAL, Local Checksum Offload computes
  the outer checksum in software and the device offloads only the inner L4
  checksum.
- If the inner packet is CHECKSUM_NONE (e.g., SCTP-in-UDP, ESP-in-UDP,
  Remote Checksum Offload), the device offloads the outer UDP or GRE
  checksum instead.

GSO skb:
- A device with NETIF_F_GSO_UDP_TUNNEL_CSUM or NETIF_F_GSO_GRE_CSUM
  computes both inner and outer checksums per segment.
  The outer checksum is seeded with only the pseudo-header checksum.

A NETIF_F_IPV6_CSUM device must parse through the outer headers to
reach the inner ones.

Fixes: c4336a07eb6b ("net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260926140506.2335137-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/dev.c b/net/core/dev.c
index 8638c994bbcb..18dc88990510 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3818,20 +3818,36 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
-static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
+static bool __skb_has_ipv6_ext_hdr(const struct sk_buff *skb, int nhoff)
 {
-	if (!skb->encapsulation)
-		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-			  vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
-			skb_transport_header_was_set(skb) &&
-			skb_network_header_len(skb) != sizeof(struct ipv6hdr));
-	else
-		return (!skb_inner_network_header_was_set(skb) ||
-			((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-			  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-			   inner_ip_hdr(skb)->version == 6)) &&
-			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
+	const struct ipv6hdr *ip6h;
+	struct ipv6hdr _ip6h;
+
+	ip6h = skb_header_pointer(skb, nhoff, sizeof(_ip6h), &_ip6h);
+	return ip6h && ip6h->version == 6 && ipv6_ext_hdr(ip6h->nexthdr);
+}
+
+static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
+{
+	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6)) {
+		if (__skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
+			return true;
+
+		/* Catch tunnels without skb->encapsulation (e.g., virtio). */
+		if (!skb->encapsulation &&
+		    skb_transport_header_was_set(skb) &&
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+			return true;
+	}
+
+	/* Tunnels without an inner network header, such as SCTP-in-UDP or
+	 * PSP, have no inner IP header and thus no inner extension header.
+	 */
+	if (skb->encapsulation && skb_inner_network_header_was_set(skb) &&
+	    __skb_has_ipv6_ext_hdr(skb, skb_inner_network_offset(skb)))
+		return true;
+
+	return false;
 }
 
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
@@ -3886,7 +3902,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    skb_gso_has_extension_hdr(skb))
+	    skb_has_ipv6_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3988,8 +4004,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
-		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+		if (skb_has_ipv6_extension_hdr(skb))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {

