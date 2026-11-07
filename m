Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050970;
	b=fKp/fVm1zHP0h0Bc/guzitF1ytayNkYimMU/jL5vo0wl22IYJinevnd5XfhcgRAuqaII
	 xewUISNog8I3aQnfD9SqvuJ2cjo5YR5ssIUPhBXBgIEkr1pZZlGA0sjMrUap3sTlYJYsl
	 jSpVNnNFppIcODV/YPTq5BLAS4RV/3xo3Bl7omQ8g7mGfuLas/uFce7OrasufrNrZJB27
	 MoU/WSJv87ooPl4qBuXG7gqa1G1q/3GfJKoh5SU73VfQ4wFsbnWvTgD2kHpPEGeEZtdj1
	 d4zYxXfVtD+sU+/5YNRN0vwXwKlNYlCzk4PXKTFuXaJ46l4XvvqqVuUIA/cQZuiAykg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=68n30PyoclNtDsSuEehx25noxb1zK30RyP20qE0ouEM=;
	b=pzaT/QIItmk/z+pzB2t5kk13w8Wr1xK8+LDu15XP/vVmwpxA6K13qW7Z3GExR4jVgL8i
	 oO/KEAn4m5ZzokJJzRzkgb0XZqhkPy6gRSNsrZQ3bv2xTZXI6r+hwkWL5WEU1fpLNdWPO
	 IdFleNTDKNqjWAQ/7E2VizxpB659yHuMXkcfokp+zo9G8ta5Yl3YoM/9gjAJ9LT8GV5H1
	 tqFU5LCHb6UNwVIasbepT1RjlH9P7NKuHgq7M0eL2N+2hT7UpKbuCCmwkE3kNUzI/XIyI
	 7SAcYZkHodkH6EdPZIxzNwyQ4mxGn4PIz30tMbgnyc75aaJc3aAVfNc/UbEpgO8uiJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HYLgTRH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYLgTRH/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904FD1F0089F;
	Sat,  7 Nov 2026 11:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050970;
	bh=68n30PyoclNtDsSuEehx25noxb1zK30RyP20qE0ouEM=;
	h=From:To:Cc:Subject:Date;
	b=HYLgTRH/rm/AWGZehuCvgYJ3ozR2tWJzdkXwVUmB2MNA/rjoeMPK1afS6MAFlVBIB
	 ucGSjB/4TpKnpv+S2REWrwwBPCJldh6kyDlPGTW+8NTVVmaXBmhK4rc6hW3lpjxDFG
	 yqfi+wV9IlhwzTdm8/8lJhyxtsMu+NbZlKrZHlcqIQaKZFe8OSD9kfW/duFVFBa7kc
	 Let3MVV93clRnU5x5mgzTRBxVLrishk1zqQERMNvET4Rmd1KXC1OhVHrbgNVu291wS
	 A0qZ+RNgSjiJRqX/SGNbGAoM93eEZdxwzhyS17tGs3E7oglbx58aerUvFLrk/8kRbU
	 TSVeXybnStz2A==
From: Sasha Levin <sashal@kernel.org>
To: idosch@nvidia.com,
	netdev-bot+sashiko@kernel.org,
	liuhangbin@kylinos.cn,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr, ip6mr: validate packets injected into the register vif on xmit" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:28 -0500
Message-ID: <20261107062928-failed-5.10-aa1799e93f5e@kernel.org>
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
git cherry-pick -x aa1799e93f5ebb973252aec649d84d12d9c7fd1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062928-failed-5.10-aa1799e93f5e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




