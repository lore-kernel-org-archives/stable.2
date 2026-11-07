Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049644;
	b=xVq/utZxz6G/Ao8TD/YQZ1XitEnvdPJcEwBm1gUBpiJso3BFeFjAy/EjVHrPDbDu8bbo
	 ma4JNMbDXZjg08g+woBxIC0hiVm73MT8vaQCUx8e4TOZlUm+W3W5eLLnJTw2j2bIMyvnR
	 jw9OVJPOpGBVr/ei+AzuFTRKJgzWuT8KwuqDq8hYObnmfW+Ilhj7dNKAZR+cLLJcESKoA
	 ykgUSB01RXT5SYntLSh+eQ1YWt+58SpKCHnywIvSv2TZHxDzyD4TLd8Q35xtilug4R2iO
	 B/97Vy9DEIXZQyCFn05uaZrhGG1iyAQu/I2HV/dL31rH8Tlipk4NA5KoB0fXb6VKi3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e/wZL7uAIzsH7sYIBXBM3EQjzqwX0tC8n5oDX9t7y0g=;
	b=fehYAtWzFSAqecuOk6ztlETxrcTWvs6/veCYjC0IRFztc/aTIsoJpDG3td0TrU1cmIaL
	 cLfaWDG2C2PK3I3TVNSI4i9dZ65MM05jfO7iCVWHMVNthHtfwvLw+Dh4vAz9tvQ9EyUtV
	 YCV/FW7M9O7FzLrr73HFngp2QGTLGMM8wzPyuG8e4ralswH94QEA3NRBjG+GEIFNN9KlJ
	 /9BOjmzOOMu8fW3R880ne+0xdbk3uxsBaPWAh1mPIXoojIS9VWDWCr41FSTpdgY/lRxkI
	 z6kp8jY5GMjFA2IubCPQqvYv2Lzkd2hqIfWRZ0kvOrsfsOwYqeEj3mXf7rU/mkV8qWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fmrb4IaJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF6606D808
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fmrb4IaJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A471F0089F;
	Sat,  7 Nov 2026 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049644;
	bh=e/wZL7uAIzsH7sYIBXBM3EQjzqwX0tC8n5oDX9t7y0g=;
	h=From:To:Cc:Subject:Date;
	b=Fmrb4IaJLFa8Ou3f+FUw6mM5K7Ol347l+QbzgC72L9dS2NfCiX/+VLXfMWYdbWtO9
	 r+YTxzbTeKOOZvOSWg0CIebNVMdh7CZczWvAdYisv5IdWSfF8mBh3rl4MVMIWHGCvV
	 IKFH1OQkA2N4LfkPiJuVXgAAuk+IJj1rRgFWp1xyG5IZtVGSCRvWNgLEZaETb1L1yY
	 IZSsfhNAWp2017gf+wYCcSpDFrIJmpOT2mQ5FqEeX2y9Eenvs+rG+rixFVEgrdhygW
	 4lRMft/+JZnOnCbApgj6co5m4sIjbT1/RQ8F08UxyDoNX97fOpwq5ck6fCMqTLBmcr
	 3HzyBYepo1eOA==
From: Sasha Levin <sashal@kernel.org>
To: yun.zhou@windriver.com,
	idosch@nvidia.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:22 -0500
Message-ID: <20261107060722-failed-5.15-2d36ec73836e@kernel.org>
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
git cherry-pick -x 2d36ec73836e83175deb467fd494c61006107e5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060722-failed-5.15-2d36ec73836e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




