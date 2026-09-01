Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0313B1029
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273115; cv=none; b=Ndfhx34pNrPk20A7zwf4UsLIhOpFwupTmpIl54RjTK9vjgHz5tC9rPsmCToNHR7+x5bVRv3CutbRhW3lE6fkw6W5b3h7rq7HfReN61w42px+Bjbqwe6oGwKuHMQsyGNP9Db8GWe3/V9W0+xHHCtKk8DCXD0w83y4ofM0ZlbRPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273115; c=relaxed/simple;
	bh=cS5AQkLPNnURVHwP5kEIS4vLsfIJnZhAAbTUr8nCwtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no/buhJf8SepOSxYCAvusbPLkP4mOn6g45VCjWiwU9vIpczQa0b1onGF0N/8p7fot9Ta/ZY72vztnGYvn1SxQoBlfSu9dbygbijEkMyP90/DgezUgkWphAwRLrR4WCpflw9rpI+iJocEUY0qWcOMcWenC7I0wo85TzEAKqnyImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kea/9pa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kea/9pa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D661F00A3F;
	Tue,  1 Sep 2026 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273113;
	bh=RmAEVAKIWWFhiomeVJTnPJGufRmlTNwN5gEGe18yh4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kea/9pa3f2Jcoxw7k/HcJlfnCRK5CaZivVstknnInLDPJ/1UsnDcjZEHhMDNQ2hGA
	 8vdXtPu14mufGOVJY3DWbTCMCW4Qh4qf/6YQUWhPcVJhZZpwf6zAezbWylYf2Cv71e
	 kCgMB2X+l2Qd/KRX+J01ij2nDSvx87XPNmUoHNIkQk6cVJmNlAUd7JEBpy/nFQ7KHH
	 ClV8/lpUMMNAn+XU03avxEUVwtmW69nKvV7ApicHJjRE68HStopHKWdyR9UKMNQHSW
	 bu5dqaxc+SXhwpaE5dOJ+59xrCBzsfpnE1VOj8B3R4CQYx3c3+Ts0Q1BNTzgUCkMu6
	 XBKlF2yxTgvpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Tangxin Xie <xietangxin@h-partners.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] vlan: fix skb_under_panic and races when toggling HW VLAN offload
Date: Tue,  1 Sep 2026 10:31:50 -0400
Message-ID: <20260901143150.1081831-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901143150.1081831-1-sashal@kernel.org>
References: <2026083119-eldest-saucy-a3c3@gregkh>
 <20260901143150.1081831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 447cbe95ebb95392b5d8f6a01c0556826919ce23 ]

Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
which dynamically changed vlandev->hard_header_len.

This causes two issues:
1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
   read dev->hard_header_len without holding RTNL lock. Mutating
   hard_header_len dynamically under RTNL creates a data race where upper
   layers reserve insufficient headroom based on a stale hard_header_len,
   resulting in skb_under_panic when vlan_dev_hard_header() is called.
2. In addition, vlan_transfer_features() updated hard_header_len without
   updating header_ops, causing a mismatch between allocated headroom
   and header creation.

Always setting dev->hard_header_len = real_dev->hard_header_len and
dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN unconditionally
ensures:
- dev->hard_header_len remains 100% static and immutable at real_dev->hard_header_len,
  eliminating all dynamic runtime updates and data races on hard_header_len.
- Upper layers allocating skbs via LL_RESERVED_SPACE() will always reserve
  sufficient headroom for software VLAN tag insertion (real_dev->hard_header_len +
  real_dev->needed_headroom + VLAN_HLEN).
- vlandev inherits real_dev->needed_tailroom so underlying trailer/padding/ICV
  requirements are honored.
- AF_PACKET SOCK_RAW network header offsets remain correctly aligned at
  real_dev->hard_header_len.
- vlan_header_ops is used unconditionally.

Note to stable teams: Make sure to backport these commits:

e16e960d55a4 ("ipvlan: inherit needed_headroom and needed_tailroom from phy_dev")
cef51860becd ("macvlan: inherit needed_headroom and needed_tailroom from lowerdev")

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
Cc: <stable@vger.kernel.org> # 3.19: e16e960d55a4: ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
Cc: <stable@vger.kernel.org> # 3.19: cef51860becd: macvlan: inherit needed_headroom and needed_tailroom from lowerdev
Cc: <stable@vger.kernel.org> # 3.19
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260811085246.2267779-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/8021q/vlan_dev.c | 39 +++++++--------------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 14908b8f5b0da..39fcb352541ba 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -500,26 +500,6 @@ static const struct header_ops vlan_header_ops = {
 	.parse_protocol = vlan_parse_protocol,
 };
 
-static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
-				     unsigned short type,
-				     const void *daddr, const void *saddr,
-				     unsigned int len)
-{
-	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct net_device *real_dev = vlan->real_dev;
-
-	if (saddr == NULL)
-		saddr = dev->dev_addr;
-
-	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
-}
-
-static const struct header_ops vlan_passthru_header_ops = {
-	.create	 = vlan_passthru_hard_header,
-	.parse	 = eth_header_parse,
-	.parse_protocol = vlan_parse_protocol,
-};
-
 static const struct device_type vlan_type = {
 	.name	= "vlan",
 };
@@ -572,14 +552,10 @@ static int vlan_dev_init(struct net_device *dev)
 	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
 #endif
 
-	dev->needed_headroom = real_dev->needed_headroom;
-	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
-		dev->header_ops      = &vlan_passthru_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len;
-	} else {
-		dev->header_ops      = &vlan_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
-	}
+	dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN;
+	dev->needed_tailroom = real_dev->needed_tailroom;
+	dev->header_ops      = &vlan_header_ops;
+	dev->hard_header_len = real_dev->hard_header_len;
 
 	dev->netdev_ops = &vlan_netdev_ops;
 
@@ -794,10 +770,9 @@ void vlan_transfer_features(struct net_device *dev,
 
 	netif_inherit_tso_max(vlandev, dev);
 
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+	vlandev->needed_headroom = dev->needed_headroom + VLAN_HLEN;
+	vlandev->needed_tailroom = dev->needed_tailroom;
+	vlandev->hard_header_len = dev->hard_header_len;
 
 #if IS_ENABLED(CONFIG_FCOE)
 	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
-- 
2.53.0

