Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A940DB25
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181070; cv=none; b=DoMbHlyGq7q5/IW7hfT0/LGVc6s0GJHjkeCulqsfNQ0klSpTHCv3I6PBHAuvWL2OwBkiCNbk4hp2Ffg1sULqJsOOJpZbJKDCLCX6dVyy+5EKiiCMdIwRiLG4VWmCjPGEBeh5Fn5s04QJC3p80FSU5P9H4nNR2iewBGFKQsxKbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181070; c=relaxed/simple;
	bh=c2UUa5pvkOlJlCsIN9Hwnzah6FyaRfUk/XgYpQFfJaA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=igqOEonqo76RmYstq6c3hQPnq8YXRM0qe6oMruY2XboXQi1J/fZ0EfrxmrVEVglkI3HVimCTzN2JT1bOgSZ+X0Wz540kKVcYklCoINxlUj/5Ac4dssKSI+fptbSfAvB7r/x+wDvHXvCL+A9gCmrlXf51mKMpDAjbKLgj16yF1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWdESYi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWdESYi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15221F000E9;
	Mon, 31 Aug 2026 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181068;
	bh=IFhtazPWoOBcg+hjUgmbWZkcAnqsqLhwi9Rgry06IZA=;
	h=Subject:To:Cc:From:Date;
	b=IWdESYi3fAbxYR8j/5SPRjJsqYxQbZAPpmvUU7p/1jrDdgl8R1+bsSJf2kCdiV+oB
	 4/rxO1x4ZByE4/fEAPmdTl0gYnEYbPk4VJ3pogLjk2Y51FRo/ritI1ycvvVVWyDUjG
	 Ldu+dTlfvANTGF4pXUJmtXpSUV5koh2AuJQnUZdU=
Subject: FAILED: patch "[PATCH] vlan: fix skb_under_panic and races when toggling HW VLAN" failed to apply to 6.12-stable tree
To: edumazet@google.com,kuba@kernel.org,stable@vger.kernel.org,xietangxin@h-partners.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:57:18 +0200
Message-ID: <2026083118-ranged-peddling-d8e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 447cbe95ebb95392b5d8f6a01c0556826919ce23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083118-ranged-peddling-d8e5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 447cbe95ebb95392b5d8f6a01c0556826919ce23 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Aug 2026 08:52:46 +0000
Subject: [PATCH] vlan: fix skb_under_panic and races when toggling HW VLAN
 offload

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

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ec2569b3f8da..2859cbac3f26 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
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
@@ -580,14 +560,10 @@ static int vlan_dev_init(struct net_device *dev)
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
 
@@ -1029,10 +1005,9 @@ static void vlan_transfer_features(struct net_device *dev,
 
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

