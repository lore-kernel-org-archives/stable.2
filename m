Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697247;
	b=hDnO7JAeYwfiuAJMmvAZyaJoGrzYqxIGMLi6ZeZqhD/0TrNpF1UhNYcQnZqXhSvnQO9P
	 RE3cepEtZv+O9SXB2DfulPGqEdCAkP1SR3oT1Ox1vKB+WFxPCKN0RNfF3qadHZhtXO+De
	 w9yarvsGw/vP0SQVQyfv1ohkaKC4ITgSU0cZ83cezlkGLybNjdOCNhXmy3LqWGdRKpjlo
	 5A2wqlcnJ/E/AkuOwJFPHkMuRZG1PdCn9lSgtNt+u8fg+48/CCJpaS/keFbgMWxrPptdt
	 2KBr3LFEkCe8bAGvjgRvQ27oSOXJtjTRSNFIMkKgvu4aKUWkXp315BdbbINKbC0rXXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t1/DAVBhm27R4WVDppqUSwYXcQywREL/+Le9FgN5bgA=;
	b=x+cerkMZSR0e+NYUBxRVU9EYvUqgeyDcqssgS39id6zTk1meK/w1MAUWXsEVOHpOq+yU
	 P90yoVFkHOQvfY1i5BojFIS4Qa/1zLjWqr7GJl9HpsvOdKrQqzKgAgxAVHMiIEFbkATDc
	 6zPrPXm82NOLUMzUmRBq67wpSXFy7bs4C8Ly8CZ3SDvTV6/j3V+R9sSPmLRmwShIa8dzV
	 5Ip5ojQz615ls1CJwKuAX6T9//3NixVDuGgjK762t9jGro7w7EIR8Bm1mFBPKarO0XbSU
	 wAwFRLHRTV7eAME1NI2b49T/OukMCgqp4ag3vgsnMc3t+tsBsvrCDLOQsvJEb/9hPQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cn5DoWKc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D4606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cn5DoWKc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912A81F031E1;
	Thu, 22 Oct 2026 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792697246;
	bh=t1/DAVBhm27R4WVDppqUSwYXcQywREL/+Le9FgN5bgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cn5DoWKc76a0ZG8gZHuq6/gUiB46fuxQ8SSW+Adk+I0hnMsT5wCVla94pOuvmqGe/
	 ySJUSJqPZlwhTNEV1s0aeeTqQDqKX60AqfWBIxkOwPdaYs2Lqsaifa5CdAknAkCpf1
	 PDyvnhF+QkXP9f1Km+mitNqe6MENisVRZMDbjNzv4Wf/jPkWu8zn15+vCf3e+CxJSf
	 eGu5+8rzYnLJj8quB7I4eSw8e0oWFhGCp9WvzM8fJBauLJh6166Gubulpimk/jxQV6
	 iAdYjiwzsf+VilP54yOXEttQxjIfnZUMokRsPKsD7UySxsNDffXggWDvMg4VcYzPgY
	 sI0pHDnFEgzQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Amit Klein <aksecurity@gmail.com>,
	Noam Caspi <noam.caspi@mail.huji.ac.il>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ipv4: udp: Create exceptions before socket matching
Date: Thu, 22 Oct 2026 15:27:23 -0400
Message-ID: <20261022192706.1912456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102120-delete-matching-aff8@gregkh>
References: <2026102120-delete-matching-aff8@gregkh>
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
[ sashal: inlined udp_err_update_exception() into the existing udp_err() wrapper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 86a1b2c9e71fe..8ceaeef5c184c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -870,7 +870,16 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
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

