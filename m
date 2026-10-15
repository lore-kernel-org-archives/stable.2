Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF148F008;
	Thu, 15 Oct 2026 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053894; cv=none; b=G9JN49Ccb9n9VFT0HGGDl8owq4n/KR6Fr5HvuqIlKeX/GQQbZ8TWUAj+muZF003lWlb2ekoRcyLcD7dcM+GnOkOoljLvjUbzcfwosjFK/MbVZENB6tx31cdjyJrZLNPjvLV7FIpVlNwdd+pDrXTpwYPUmjrOD2f+fdEEVkUa/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053894; c=relaxed/simple;
	bh=OZhBrowA6cT0dx95d5pQzpiY4q0ZQDXXjiy2MBvSQwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LevSVgIEkaCn33FDqP+6k1Kvv/ZC3SFKu0YPWWeIOtO8QuDM06ONQ93OWm1dr14mo/yWv4Vu9oyoj5rzoBxG41o857dWPrxqkDbRd168UFv1NLj0k76uGgDQ7zBN/w2ihCypYYhnSiTXd8GYyoQkXgMCoWHB5gFWO67mj18P/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=OMrky5FW; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="OMrky5FW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1792053884;
	bh=OZhBrowA6cT0dx95d5pQzpiY4q0ZQDXXjiy2MBvSQwo=;
	h=From:To:Cc:Subject:Date:From;
	b=OMrky5FWQQHXgmi4cgffL54R3WqnKQ6v/r7KvjlAtvSfeUsKhNau3CPQK7r21MQ54
	 4jyHDrbXF2JrllgdUJnrHzK04tRLWnVBl9vAjQqYICEsez4c7shGhvNJJAgQov6JZJ
	 wOPVGX/D6UZSNBEqMRJ4WI62GXh/IhSVeHkYyehi4D3mc9DSvXSuVhx4VcncWqCQex
	 TQESHpjjsrW/+p2UYquT8J1tmV6Hf5hv4tqqrjWLVaaOS6bHK5NkeoqPXNtgZ/MM22
	 wqHR1aPvAMCyvjMOLdWce4OAJ60Rz8Gsm0XpCFdAwJ9SATbna7dRiR1FBaTs6s7kX+
	 QMkyNbIRY9jog==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 69F4F260A1;
	Thu, 15 Oct 2026 11:44:44 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu, 15 Oct 2026 11:44:43 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.48.108])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j51pf3K7mzL91;
	Thu, 15 Oct 2026 11:44:42 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] vxlan: use pskb_network_may_pull() for transmit path header pulls
Date: Thu, 15 Oct 2026 11:32:57 +0300
Message-ID: <20261015083259.1684-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/15 07:23:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206699 [Oct 15 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/15 06:31:00 #28687005
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/15 08:01:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Eric Dumazet <edumazet@google.com>

commit b9553558b48db54ac9273e6b98d7263ef5c1a329 upstream.

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
[ mdmitrichenko: drop the vxlan_mdb.c hunk, 5.10 and 5.15 have no VXLAN
  MDB support (added in v6.4); arp_reduce() context differs only in the
  tx_dropped accounting. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-74474
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a2955729998c..edd5976509d4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2004,7 +2004,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	if (dev->flags & IFF_NOARP)
 		goto out;
 
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
+	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev->stats.tx_dropped++;
 		goto out;
 	}
@@ -2937,8 +2937,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			return arp_reduce(dev, skb, vni);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
-			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
-					    sizeof(struct nd_msg)) &&
+			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
+						    sizeof(struct nd_msg)) &&
 			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
 			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
 
-- 
2.43.0

