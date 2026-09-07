Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62701509F18
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795166; cv=none; b=NrMLc5XFl0Jydgx+i8kDxfzgB6yJzuGmpXTs+rjEaQGEZpuF71wGttTJ6wMQl9OwNPngxZpYLYxlzDuDzni4vlcgD6ADqCmZV1oQivffv77x/y304fcrulu8f3RJt6wgHhlBOFQIHp50V+Rb+Mxn1LrX5p1IkKY0ulAeNAs5m0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795166; c=relaxed/simple;
	bh=lNdE5hQwxbC8zNqyjDPCQ1ygIeNWiWlq0JUn43dlXO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XtocEq5k7CDJANnrWxdcSgjBjf9n9C6CmrjrHvBqLSAJ7yip80Q47REm5w1GFNrE3+N68J1fGDP0zF7TRp+9CjtSQj8Z6uGajCBvSz7RxZVpOJ7QqZOJIEFxkEwp2fqbiskHFRQIjUZLdjgpW8S+xSiSTL7RaJyXfFgvjEqqa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hVWjyu/s; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hVWjyu/s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 726044E41575;
	Mon,  7 Sep 2026 15:32:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E78960383;
	Mon,  7 Sep 2026 15:32:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6008C11C7AF32;
	Mon,  7 Sep 2026 17:32:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788795154; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=BXlHvKIz0fjUJbOXiKgTHnFk1X4b670PHeIObA3iq8g=;
	b=hVWjyu/sz/rPY9Z/nzdhawhlnZMM8F+SJT1QAM9ZD4Z5OvetniZVfRf0WpJXhlBYOxleV9
	7JxHi55JuGpjyh9cfIWhef2dPZ+cAr3/ysuWdp4yU4Tdmfh+gyoYQSzY+RLpuNStZAYSYt
	DOlxFifN5CTQ4ns/yvbAiGwcwEfcQy+jVXts71ihUWOHHCC8sk3F0n1LT+4D3tSsAprmIZ
	vOyYPHKnSGe+Kwvdkr5QZZ4sTQVJSge81y3UiZmqlWxLwKXfzaEgA5CCxDg3qJIKrBUrdn
	ZUYzD0XnzJZ8O0YWBYFj8/yUVZKpWRGSFTr922Zxe5FIqvqLW+InLmf2DV8Lnw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 07 Sep 2026 17:32:22 +0200
Subject: [PATCH 6.1.y] vxlan: use pskb_network_may_pull() for transmit path
 header pulls
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-cve-2026-74474-v1-1-58df9a9a245b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMBCE4Vcpc3bLJsQs+iriwcStrocqiRal9
 N1N9fgNzD+jajGt2Hczik5W7T42uE2HfD2NFyU7N8Ozj7xjoTwprSAJQQLxIC6JjyltGe30KDr
 Y+xc8IPau/+D4n+sr3TQ/1xiW5Qte/EgeeQAAAA==
X-Change-ID: 20260907-cve-2026-74474-0f71b726bb50
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Stevens <dlstevens@us.ibm.com>, 
 Cong Wang <amwang@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Sasha Levin <sashal@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788795149; l=2651;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=x/q2y/HZZWyP2kOBq/jhuWIWKRT40N3cmfcN10dlvfs=;
 b=8R1uYMMkDUDyJ55vqMIpKXuRNNXtGjtc4p7cmKSBpIA6TkXzJBWf3AdBlVufi/ZOCRrnj/9u+
 DB65kJiXsz9CgHPPcq7gTV15kDSZ9Q9bWf7MFbFkRM56qeqKBEgvlEP
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b9553558b48db54ac9273e6b98d7263ef5c1a329 ]

In vxlan_xmit(), arp_reduce(), and vxlan_mdb_entry_skb_get(), pskb_may_pull() was
being called to verify the availability of network layer headers (ARP, IPv6/ND,
IP/IPv6 MDB keys).

However, during transmit skb->data points to the MAC header, so skb_network_offset(skb)
is ETH_HLEN (14 bytes). Using pskb_may_pull(skb, len) only checks len bytes from skb->data
rather than skb_network_offset(skb) + len, which can leave part of the network header
in non-linear frags.

Replace these remaining pskb_may_pull() calls with pskb_network_may_pull() to properly
account for the MAC header offset.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Fixes: f564f45c4518 ("vxlan: add ipv6 proxy support")
Fixes: 0f83e69f44bf ("vxlan: Add MDB data path support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260723144249.759100-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 245c4c705045..9684a3ab081b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1904,7 +1904,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	if (dev->flags & IFF_NOARP)
 		goto out;
 
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
+	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev->stats.tx_dropped++;
 		goto out;
 	}
@@ -2865,8 +2865,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			return arp_reduce(dev, skb, vni);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
-			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
-					    sizeof(struct nd_msg)) &&
+			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
+						    sizeof(struct nd_msg)) &&
 			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
 			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
 

---
base-commit: cf82dcca96346600c7068cf3f841335f9fa08f54
change-id: 20260907-cve-2026-74474-0f71b726bb50

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

