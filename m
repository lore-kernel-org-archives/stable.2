Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0059EECB
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262790; cv=none; b=KpQgBUUpGrIrcLX8Q0J4fAop9WbZLPjwdGCzwlh8wYuUUIlpTsA1KdfHNtln9Bygg6tAJKR3218FvIGsEEeXEpaNSxqR06vLYwtEBSXBz77Hi1rzaqq3u7y3R7E8tnKGQa8+GTLwJQsd27/9IurLDhUhbawl7Fl3uS8L7YSSFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262790; c=relaxed/simple;
	bh=Puxvw1554sUUQs+ON1+uDVqUpybrTqZKj4hVuVK2NFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXeyp7a7fisnM0OnQw11q2mfzxmqtbCMzd0PNPFfe3GslOy2QRdcRmjwodUI+0h21iU1y9dhPUhKB5GOfpnWqGMW3NCoHcmfwWks5z0izWUTnVSab0dfBawnQmrpTjsYKXcYbVqGQk+MqeZ69ROE1QrbtTXzsru9hteoepxvG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPU++dwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPU++dwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C592F1F00A3D;
	Tue,  1 Sep 2026 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262789;
	bh=Ak0meX4xhRODj+vOe+ceWf6x5Ap9nIXfge/dl0EjHks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oPU++dwi7Z71iLPeU1a2M+lNBLgA4X6DDRCAQbUOD82pA20st7Vb/i1saGaotdUio
	 LHcTXJtjsQjtCALXiDWZIoHSialAuiXD0REDECRpVbC2mvqIGk4dCU7zbP02zZeWGw
	 9Fh0ER10EP2z01mybJeEOzZ8W9UJ9APAOnUHwlWT4UEm0/IuhCQtG89lDIgty95MzF
	 kcLvqkLTAJFtZfyX8Gm0zjY60uT5zZxsT+94qM6ceHNv1cMqM0CfLSvUFM8xeAS7vX
	 5qc+7N8nDXjryGn5tmMY+wfo6F4cz6mjMrD/VEbzHczFfOX5p9+sKUXRvuOU+E1KlV
	 BL27uI+k+ue/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Tangxin Xie <xietangxin@h-partners.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] vlan: fix skb_under_panic and races when toggling HW VLAN offload
Date: Tue,  1 Sep 2026 07:39:47 -0400
Message-ID: <20260901113947.240748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083118-ranged-peddling-d8e5@gregkh>
References: <2026083118-ranged-peddling-d8e5@gregkh>
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
[ moved the vlan_transfer_features() hunk to its pre-refactor location in vlan.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/8021q/vlan.c     |  7 +++----
 net/8021q/vlan_dev.c | 32 ++++----------------------------
 2 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index ecc1c8624006f..c6c93a0f2da69 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -324,10 +324,9 @@ static void vlan_transfer_features(struct net_device *dev,
 
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
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 9184cf7eb1286..e7e5b903fa8c3 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -494,26 +494,6 @@ static const struct header_ops vlan_header_ops = {
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
 
-- 
2.53.0

