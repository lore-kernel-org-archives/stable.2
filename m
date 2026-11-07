Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050816;
	b=P2paQigaw4umYzwAdbsZPsOUci2pnWYse6dLberOCmxJDV+EX/urED4RJDsxobtatgFG
	 yVs1pnF8Tc3Tb6R8xwGDiMje21Nbej3tYgMsjbvgJefQVVMf1+wQ7yoKixulQwQA50fh5
	 0dnXQytCOSjFXnA4XBu8QGHsG+8YYdDKEtk+vG47/YD6NuR+TLgb2hjplQgaeHUkgY5vs
	 Hx/C16jxU9hhPcmWJHcIThWQdp08QiqE8c14HWoEEJfeu5dPhawwlYGdk/MwnCTG4JvqX
	 qtrOYdUFkeLs0hXQINL7mdrODQ+19HZMqtTGIqBXxBCt07BsXnIdsfnqsDyELIQ/5iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050816;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e+gTkBMv3yaLR8ZCl3+85urEX6IfACetfID0CskNJ4c=;
	b=WTiT2Q0srnxfB2dZm1WSar1X/TuGwjEGRkS5SLGeC474vKSvjist3q6JoVSRBPZNvGoQ
	 P217vN10KLipzH4GVxoIzHmcmajmb3/MHqGxTwhPvLwAocvyPy07SJ5nooTN+QcTRDp8i
	 lF6Cb9LsH7qhehENpX2+H3urcYZ2dvaK7JxU2PI8mh2cAghtvgqSTERSPKKYAuUBBHXzj
	 WEz7RQbnyIITAcxLmpRna41ORhJXxk3pacdkRwj4r2yGFvIWxPLQpZaSOJOvXWrjb/G2r
	 rPH1iqExLgg2Nfe4h3RywtPVMtORoAXxsIL9q1JGe0scwhgLY6mJ7ZIpbt920S2osjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOS831Pc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414BE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOS831Pc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4F21F008A1;
	Sat,  7 Nov 2026 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050816;
	bh=e+gTkBMv3yaLR8ZCl3+85urEX6IfACetfID0CskNJ4c=;
	h=From:To:Cc:Subject:Date;
	b=NOS831PcVILoEKOmtBOFHjnbJyCdttK7AHPhaB/O/QhOp25yjvuATz98VUFR7VJvN
	 Q78sM4fwsR1dLtu54tzOi+Zr497NJuI+u8a7/wQ2JmtRRfcAuf4Y48zrNf2YHUZBvi
	 gyWzIcASZPe/vz9cGnfPN/+FZqeBdNqTE4qZTOsDxFcv24K5grCPQehS23mEynEPkB
	 LrHURGYuvnc37qfVN5pqSgtRIvdYTF0P016UpKmohDMe2IrhgYhF2fMEgJz7aH2Z70
	 Hrxs/h/8ObizoCYwSyuiWVPnBKDXjGsfwzVlama58iMT1bBGZJRePFdbN0WuF83jMn
	 LQWENBfc/zctA==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	idosch@nvidia.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipv6: serialize address publication with device teardown" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:54 -0500
Message-ID: <20261107062654-failed-5.10-06227034e2d9@kernel.org>
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
git cherry-pick -x 06227034e2d93942119b922cf05f2de9da0ad848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062654-failed-5.10-06227034e2d9@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 06227034e2d93942119b922cf05f2de9da0ad848 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Thu, 15 Oct 2026 14:06:49 +0900
Subject: [PATCH] ipv6: serialize address publication with device teardown

ipv6_add_addr() checks idev state before allocating an ifaddr, but
publishes the object later. addrconf_ifdown() can mark and detach the
idev between the check and publication.

This happens when a non-loopback device MTU falls below IPV6_MIN_MTU. A
forced interleaving published an address on a dead idev, and
ipv6_get_ifaddr() still returned it after teardown. Later device deletion
remained blocked with:

  unregister_netdevice: waiting for ac0 to become free. Usage count = 3

Protect the dead indication with idev->lock and keep that lock across
both hash and device-list publication. Recheck dead before publishing;
if teardown wins the lock, reject the unpublished object.

Non-unregister teardown does not set dead. The preceding change covers an
add that misses the initial hash scan but reaches the per-device list
snapshot. Both changes are required when backporting this fix.

Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/179161099408.434549.14449036924552933828@kernel.org
Link: https://lore.kernel.org/r/20261012145306.GB779501@shredder
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261015050651.1841557-3-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv6/addrconf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 72d7df23f7967..3bede30d4e989 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1168,14 +1168,18 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	rcu_read_lock();
 
-	err = ipv6_add_addr_hash(idev->dev, ifa);
+	write_lock_bh(&idev->lock);
+
+	if (idev->dead)
+		err = -ENODEV;
+	else
+		err = ipv6_add_addr_hash(idev->dev, ifa);
 	if (err < 0) {
+		write_unlock_bh(&idev->lock);
 		rcu_read_unlock();
 		goto out;
 	}
 
-	write_lock_bh(&idev->lock);
-
 	/* Add to inet6_dev unicast addr list. */
 	ipv6_link_dev_addr(idev, ifa);
 
@@ -3897,7 +3901,9 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 *	   Do not dev_put!
 	 */
 	if (unregister) {
+		write_lock_bh(&idev->lock);
 		WRITE_ONCE(idev->dead, 1);
+		write_unlock_bh(&idev->lock);
 
 		/* protected by rtnl_lock */
 		RCU_INIT_POINTER(dev->ip6_ptr, NULL);
-- 
2.53.0




