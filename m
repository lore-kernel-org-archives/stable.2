Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050660;
	b=eI2ow7UNe5fCd4SP63bxyTR7okPkcBTC0wlJdVPEl9xem+R/YTO0KCbrzURDrfUkeARy
	 LOezQ6EATGojT3Dm4cBe0nIDbDbYJr1FsDC6yV8WILGNuK5Z+oXSAI8VHj1zqcktxlm05
	 785wFeiOdOBy+3Riwy0rETjcRAYrulAdfaunYF8FPYq/bHCHoaaLFRSzs47APSWJ5PkoK
	 o/t73SWxp7JVC1h46bHu1xpdvCv6GFMWyWK9AvyuWyyiXC4VinjvIYh1XwGKxwuwS22J7
	 +fJiCEsaV88+b3/6EBTMYwGe0w0zp8geO+G1vKbsREz1DwzfyftzuCRfJQEa9wcJxow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7y1b7LAdLnIa9XrdGnev2rLNJiNBHSe/d5TzhTiR7i8=;
	b=biXkmoHEz7scZRb5Kcki6lsea4ZVGauKrWtPnxRBXTA3XmMGpoWAkWWjPcjvfnqk0+fd
	 fku0eZ8fKXRqxbTrFhbsde4b7cyHtlXLR7qZwOAT3cg/F4r9UFjxKUZ9fBbPLuyZEeNFt
	 9rDpa/C2yC52fMuViwswjIIJwq0gd6veqmXev5aUeXy7CaB2emxFGQcMkh0YX2pXruSsC
	 OdmL5CR09wEv0RR1q1SKDXMlxVMwxFaIK9LTm/dNQBQ4tfEshBDBrql52D9kpSRZnjO18
	 ZCkdw8PH3Jv4nA8oaZMBFioifZ+S2k4+EzwV5PWp2Fb3v65Xs7oFfrHcG6s4I+jPmZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxhcKHmU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3690606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxhcKHmU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA0E1F0089F;
	Sat,  7 Nov 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050659;
	bh=7y1b7LAdLnIa9XrdGnev2rLNJiNBHSe/d5TzhTiR7i8=;
	h=From:To:Cc:Subject:Date;
	b=QxhcKHmUb09XdkHhg9m+QjNtOXFT77ph3HLq7jh3r3fTcd0+hukKUi2PmlRoKRLGA
	 Uq9WWsjql6nYwjYbkVw/StGwuxkRaHc2ZaqKjiJzxrbLNSlRE8RQcYp4x+zjVL3T94
	 WisL/8M7QNIT1E0MN+LP9S4oRjr5TD2J6Z9lsCr8IIe3GLSIDoEiD2JDxpfqX/BMIf
	 mb3mCXpg8SLqxERHAf3Sw370YQzeoL9PqOo5BlSnIEMlXCH+S9ITV948sqEEzo3IDg
	 3gLWcwLiCHJqVO0/wi3zYYw3PNlU7aLA2dyTrMsQtdr5BZIDLMAoH2NWyMOUBoesvS
	 bahPKcJVYpCPA==
From: Sasha Levin <sashal@kernel.org>
To: yun.zhou@windriver.com,
	idosch@nvidia.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:17 -0500
Message-ID: <20261107062417-failed-5.10-2d36ec73836e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2d36ec73836e83175deb467fd494c61006107e5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062417-failed-5.10-2d36ec73836e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2d36ec73836e83175deb467fd494c61006107e5d Mon Sep 17 00:00:00 2001
From: Yun Zhou <yun.zhou@windriver.com>
Date: Thu, 8 Oct 2026 17:38:24 +0800
Subject: [PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock

The ERSPAN xmit path re-enters the network stack, causing nested
acquisition of _xmit_lock on the underlay device while already holding
the ERSPAN device's _xmit_lock, creating an ABBA deadlock. This happens
for both IPv4 ERSPAN (erspan_xmit() -> ip_tunnel_xmit()) and IPv6 ERSPAN
(ip6erspan_tunnel_xmit() -> ip6_tnl_xmit()):

  sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
  ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

  sch_direct_xmit [lock erspan] -> ip6erspan_tunnel_xmit -> ip6_tnl_xmit ->
  ip6_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
This is safe as the ERSPAN xmit path has no shared mutable state: o_seqno
is atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
o_flags is no longer modified in the xmit path since commit 9958e69b9893
("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info").
GRETAP, the sibling device with identical xmit structure, already sets
lltx.

Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org # 9958e69b9893 ("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261008093824.119453-1-yun.zhou@windriver.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/ip_gre.c  | 1 +
 net/ipv6/ip6_gre.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e4878e9aa6367..149a4e83b6925 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1367,6 +1367,7 @@ static int erspan_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 04f7c70b7320e..3429543ec77e7 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1864,6 +1864,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 		dev->mtu -= 8;
 
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->lltx = true;
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
-- 
2.53.0




