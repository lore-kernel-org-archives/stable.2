Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046506;
	b=sUwxHYvJTmFIXjG8Dxeb2jPIKvgAo8/TQhtjBb6NihZaz8QyGGZhI7dHBcMokzRopEHF
	 U5TZx4iXNLB9OCC86Cl6RInw95KaVUrzaTjP/xOiB3ee5DLAF95aE6uc+qgOTjnedhFDK
	 AAwJcTjHaZ5wm4cpJvWTWMAJHzOwVLG35Q8V3JZ5o0+FrT7RECaaXOIejeXPxdQRAr5UM
	 KI5qRQDvLYnAZzg55qNjr8srYY7iIKVS/LyFtpJmlXF3yQOB4Hs5YWGVkY2X6DEXIaxrY
	 IstM2wfd7ZRLhQUWCgav7OWGpjQCG8vw71abkRCcszCd/vS/0Y78q7EaQjcwIhFXaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x3MkzyFNVBHLhuJv/F/rcbNk8FIbljAYUNID+LHltZM=;
	b=HhCcXBxjIyubxfByGn2cBw9Xg59li+ThGW35D+5f26IunQNU7AnANnt9VCrz0WUU6lX0
	 y3SxGJF6mYHvgUWDgJ83M5Qq1hQ22qYx8R6zp5qkSWXyeFCA3AjcbXi7XOKhBALlbtoBf
	 VmEHjYHHO4dtT3Nz0OYmQNEOiwoLgLzRMInThTXdRRFJyOpORjTTxGGzmBtblVFz6hdBp
	 GnYkiW4GB1rG1NL7Wcj2m632ZcMW0ckOgKRjF8kJwzYnQwqFgeqxPySL1yFoKiGvG7AUg
	 gjr/5OVCN6iFAv0Ner3+0BnBBaPaLkTO+ZtGM8yaKyBVkV8Y7HHzRnW9FL7iiTPx/rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvcD8BmZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBC606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvcD8BmZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C371F0089F;
	Sat,  7 Nov 2026 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046506;
	bh=x3MkzyFNVBHLhuJv/F/rcbNk8FIbljAYUNID+LHltZM=;
	h=From:To:Cc:Subject:Date;
	b=IvcD8BmZp/+hlzaedi1jRVHYjU8+oQnFCMS+zA6T8Eza+D/m2rymcKEseZNBFdg3c
	 rOfvaAMmcWWKJV1FlVxUVy1iQO0uy1M9xdCgEJY6IBFDLrfSX+i5IpT6OHRgVqE/W5
	 s2jYLuwBkntOaCJELPRlj/lIIkIcjOpprBGfmoDvHcuQSeWPkkca2yaw/ZVBZ2JTPj
	 TQZoR2ctaB81coumnW59ZNps4usqtsUGM9dpeALzyJ9Q65mlDBwEnk4CApp3VWGjs+
	 6Gtpc9esJsxcSTryXykgvWS4i+Jc9rcrkD6WYik/VIM/Twq+ANqCksDtqhyrV7jIvT
	 4sdtit3LQRljw==
From: Sasha Levin <sashal@kernel.org>
To: idosch@nvidia.com,
	netdev-bot+sashiko@kernel.org,
	liuhangbin@kylinos.cn,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr, ip6mr: validate packets injected into the register vif on xmit" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:04 -0500
Message-ID: <20261107051504-failed-6.18-aa1799e93f5e@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x aa1799e93f5ebb973252aec649d84d12d9c7fd1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051504-failed-6.18-aa1799e93f5e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From aa1799e93f5ebb973252aec649d84d12d9c7fd1c Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Sun, 25 Oct 2026 09:17:29 +0200
Subject: [PATCH] ipmr, ip6mr: validate packets injected into the register vif
 on xmit

reg_vif_xmit() passes the packet to ipmr_cache_report() which copies its
IP header into the IGMPMSG_WHOLEPKT report that is queued to the mroute
socket. Nothing guarantees that the packet contains a full IP header, so
when a short packet is injected on the register device (e.g., using
AF_PACKET), the copy reads past the end of the packet and a recvmsg() on
the mroute socket leaks the uninitialized bytes to user space [1].

IPv6 has the same problem [2]. Its reg_vif_xmit() does call
pskb_inet_may_pull(), but the helper keys off skb->protocol and does not
pull anything when the protocol is neither IPv4 nor IPv6.

Fix by dropping packets whose protocol does not match the address family
of the register device or that do not contain a full network header.

[1]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 raw_recvmsg

Uninit was stored to memory at:
 ipmr_cache_report
 reg_vif_xmit
 packet_sendmsg

Uninit was created at:
 __alloc_skb
 sock_alloc_send_pskb
 packet_sendmsg

Bytes 1-3 of 21 are uninitialized

[2]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 rawv6_recvmsg

Uninit was stored to memory at:
 ip6mr_cache_report
 reg_vif_xmit
 packet_sendmsg

Uninit was created at:
 __alloc_skb
 sock_alloc_send_pskb
 packet_sendmsg

Bytes 8-23 of 41 are uninitialized

Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz%40nebusec.ai
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261025071729.34967-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/ipmr.c  | 6 ++++++
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 4a22d9f234254..915b210c4512b 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -539,6 +539,12 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 	};
 	int err;
 
+	if (skb->protocol != htons(ETH_P_IP) || !pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	rcu_read_lock();
 	err = ipmr_fib_lookup(net, &fl4, &mrt);
 	if (err < 0) {
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3a551be30f153..a628acf50b0d8 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -642,7 +642,7 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 		.flowi6_mark	= skb->mark,
 	};
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb->protocol != htons(ETH_P_IPV6) || !pskb_inet_may_pull(skb))
 		goto tx_err;
 
 	rcu_read_lock();
-- 
2.53.0




