Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696203;
	b=Zuwu6fEmLGAVmaODAprKcd632tbtLrYjBlHxDDFqXTujAx/Mfi45yevd24p67lbtlDYu
	 dbpKe+HY3Br9/K7KX1WfJPjip+b/p9ijcges7LfhckiMWpSowB0z+uFgsPaFnGJcgs/Qu
	 k1hmvIPKYycRoDMPMAuDnZJ1dN+P5F4W4+e6gWIy8XdXIdZWCshyWfRsGi9WIzSgXrD9w
	 QQ1M7pWTTsc56NEibSoysiw1VA4YsP0czQVs5moReKerIR7gZs/YtFU5Hk1wjhHb5CE3F
	 rGeiZSTVHUjLeX3+0i9rwnQtfAPuh30CXIhVf7Smu67PNFcFTyNbk3Z8YRrE0mW25og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IjMuDhB/htoqUBtjMuWIWPkXt6d54uKgpBPUUk5OsSs=;
	b=Xrw9sVL4m8AF4a3pvWWSHQP5xcJ6iVcQV9qB65O9WtprvVlLTLufOocV2wSyicRmUaiY
	 jz9ElWQDBmkjLmZBWdrxzjml3cGVHzywfuHGssy9MIM573i7UnlQEfnIjMiE3cNWZ1GCM
	 Tm01EG9jsRBWAPg1oGMPzt0/Eiw4dNwOpt/3B0NQjN33SUwSAgHH3AZ0fKSq///OXTClZ
	 1HYTxTixqcVs/h3nzTtnON9k5WWLSE5zAuvDCAifRmDuFxnqOe5OMmTQOMSj6VxVJuU5j
	 SwvjLVCRbGWDguosMpuKoZ3cAUSGRbIESGIiTg67ViQPUd5Q8yJ2hqB+z9qKjtHal8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr0AtMCA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1669606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr0AtMCA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD551F01825;
	Thu, 22 Oct 2026 19:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696202;
	bh=IjMuDhB/htoqUBtjMuWIWPkXt6d54uKgpBPUUk5OsSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gr0AtMCALoctvW9QhAmH79RggkCMXASLg8Z0p+YISvTQJolo9gcwGropm++Mu0/x3
	 qIWyZGmZnU8EyCHoKgIxhKTDnjvH+80hN3JA5xI7kY2UhHu9U5ufHcMCEpFleNeCIw
	 nWrGLjm2rKLpEO2E3zxhytsVMlXJIHSLNSKoNm9IH+7UqablREXNmX/ai4lgc3Feec
	 lOgzkbQwJbj7l7mecYeJq+22wUqpgDLF5AHXYzJdrKY9THJkeaeCA4/XTf+hIy0Xo+
	 ZoshYzpKuCgqFMhr1ETKWdLdZcHiEDTZ0DPYfBtN3rq2CI5ziC/Hj3rchWB5RdDxnl
	 7jbr7FlLAH6uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Amit Klein <aksecurity@gmail.com>,
	Noam Caspi <noam.caspi@mail.huji.ac.il>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ipv4: udp: Create exceptions before socket matching
Date: Thu, 22 Oct 2026 15:09:57 -0400
Message-ID: <20261022174745.1782635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102117-hankering-heroics-c7d5@gregkh>
References: <2026102117-hankering-heroics-c7d5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 4c3499f79f8c7e8561266bcc220a18538cec0458 ]

Currently, when ICMP Fragmentation Needed and Redirect Message packets
are locally delivered and quote a UDP packet, a FIB nexthop exception
(FNHE) is only created if the kernel can match the UDP packet to an
existing socket.

This behavior allows off-path attackers to conduct a side-channel attack
on the FNHE cache in order to discover the ephemeral port used by a
connected UDP socket.

Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
less predictible") tried to mitigate such attacks by making it harder
for attackers to discover hash collisions in the FNHE cache and by
randomizing the number of exceptions a hash bucket can hold,
respectively. Unfortunately, both of the mitigations can be bypassed.

Instead, mitigate such attacks by always creating a FNHE, even before
trying to find a matching socket. Do that by calling ipv4_update_pmtu()
and ipv4_redirect(), the helpers used when the quoted packet did not
originate from a socket.

This means that guesses (right or wrong) from an off-path attacker will
always result in a FNHE being created or updated in the cache that the
attacker can observe.

Pass an oif of 0, in a similar fashion to icmp_err(). This is also the
oif used by the socket path for sockets that are not bound to a device.

Note that this does not allow attackers to create FNHEs that they could
not create before, as both helpers can already be reached with little to
no validation. For example, by sending an ICMP error that quotes an ICMP
Echo Reply or one that quotes a UDP source port that matches a wildcard
socket.

Also note that in the good case (matched socket) the above scheme comes
at the cost of an extra route lookup, as the no socket helpers perform
their own lookup before the one performed by ipv4_sk_update_pmtu() /
ipv4_sk_redirect(). When the two resolve to different nexthops, it also
results in two exceptions being created for the same destination IP. One
in the FNHE cache of the nexthop resolved by the no socket helpers and
another in the FNHE cache of the nexthop used by the socket.

Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
Cc: stable@vger.kernel.org
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260828192344.2596928-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: inlined udp_err_update_exception() in the udp_err() wrapper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 69e6897337417..22eee4fdd5d8d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -869,7 +869,16 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
 int udp_err(struct sk_buff *skb, u32 info)
 {
-	return __udp4_lib_err(skb, info, dev_net(skb->dev)->ipv4.udp_table);
+	const int type = icmp_hdr(skb)->type;
+	const int code = icmp_hdr(skb)->code;
+	struct net *net = dev_net(skb->dev);
+
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_UDP);
+	else if (type == ICMP_REDIRECT)
+		ipv4_redirect(skb, net, 0, IPPROTO_UDP);
+
+	return __udp4_lib_err(skb, info, net->ipv4.udp_table);
 }
 
 /*
-- 
2.53.0

