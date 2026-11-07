Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049796;
	b=f627XsrXy6YrRSm1ZzRWvvRN5l77hmZQDumUplG5h3soi2DI7NZZ+Z6qslSM0YaJumcs
	 DUVqaDoQZROfo2+Et3+DcVIOGjDnUGkVGgA79HPt5JE/l1qXKHJUCS8JH0nbdkv+ZlTAb
	 ScOBYQvtMrkju8YbFFQm69pIHoaVTq6NpEKJAig9vE2rsDeYDlppyweRrhIL6o60NQOfM
	 /hVL7bb3XiLYuVjfAVF9fG9sEHBwZHnCLH799waAqhTzOwODRf/+H7HeOnpXCSt8BHh0b
	 DXkrK/CGuQEA35dq0nkT6n5vV9vKA6u0Evij48fis5ztWvClxEmnAUv0Bo6sTmcDSiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rZC4hWd/eeLsh5k/8KmWbKPujBbURPKOhBYTG5Yi/yQ=;
	b=ILDWURJYa8pCy5iBRBLLsJI6b3taaeIa89GPL/5REyliKnCvOnzK68vjiOUcThUGX5zl
	 4TirQH6+5FSkS1Fmrd7pzr9z5o7WVfV6Yww0XPMarQiXZ24fQPpXGYij1Wq8FWgDC/ag3
	 JzkdylwxgOOZdZOK86lcIET1+M7TquvOZci/Z7jd5XNL9UHbysr6whOgfmS4/JJpw1qUS
	 u1V1/N1ggiZAJwuEIUaDnX8eVxvReGFg8pv5YzQ+YdTw9ttIHx4QjXkiAWnkM40RFch4X
	 C8WoyCPRAhP+pE45XMsUsC1Fyc62xufR1SEEEszM86BSY5ECN9j/OdpddOafwl2PJ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLBJzeGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2882606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLBJzeGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351701F008A1;
	Sat,  7 Nov 2026 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049795;
	bh=rZC4hWd/eeLsh5k/8KmWbKPujBbURPKOhBYTG5Yi/yQ=;
	h=From:To:Cc:Subject:Date;
	b=ZLBJzeGDpBeXa8gxhERlnlX40hrvh7UKWYS/ybq3w5v1pz0gD3eKqeRdDBRnulx8o
	 5Dw65FuZKVxsJ21wL3dZ70Cc84p7NGvFPR0KID+9EFWBHny3YLPIyemJsOo7Y2uNq7
	 YctgcUf0MhjMokXO1z17RSbvoDZ5uBXHALHTS6Uuckxlse5GA8mk3BBwTMza+p9YyI
	 B1R0w4IHemC1xX6q9qVbmMuCc4fWDTRc4CT5umwmhLpmpFPUC27whU4+wVcSIF9rAL
	 Jn4/JnQVu7ChPNT98058Ba56PiZW0ypKjrlZhfZKS8YLbN34X3x/euIUUQfW5kxDm5
	 WAC6mWdgldSWQ==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	idosch@nvidia.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipv6: serialize address publication with device teardown" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:09:54 -0500
Message-ID: <20261107060953-failed-5.15-06227034e2d9@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 06227034e2d93942119b922cf05f2de9da0ad848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060953-failed-5.15-06227034e2d9@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




