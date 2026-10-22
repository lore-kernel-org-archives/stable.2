Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698824;
	b=MJ1g3qKvUM6migCumiWT48rqf5how4+lLCv9npv01tvToJfTx5iMQPfaMYD8hzPIS+pb
	 LyEfvQcoZkr+diB4v9cjyQXgXMxc4lIVpDSt4UuwPmQEoeXZR7j4M4kWr81gF5dAmNWso
	 zMwJocv5bWDspXQLnlosskR7tymm2+EUlVwx9HOMQ6HFR1PKusyHy5NwcPUQGZbFxt1R0
	 W8s3vtCpfmKX/DYIsl5kldcGTHZ6mGIg52JQ+BnFNkcE12til07kFBz5MynPm5pMLx8uy
	 CIcvU/hvQCl+UPn077whOAtJbQHL16OzatH9ZAgyjbqRJsjeb4Htw1PC1kVkumTa+qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WP6JlEeQD8ASkWEjwTi9/wZT4bsEhI/9QekFpGnJ+1s=;
	b=BmtZsbv5NTi0MZAC2g+wCfkcDw04B7idE7JL7ID+m0CLy8v9I19uehUFaQiG2WS44I2e
	 7xgsc57kV+P0wv8QfBFqVvavG0JKPktC2jpoFEF/n2HPW+fVD3qpysJkshnT83XHFlNiX
	 rNxL9yFZMpz9qfZNbP4dWqxinpkEbYNfuyn1t7p/KUTWtYlhS4qLPEJHir57qHUSzvAqm
	 ErW4I4iT6UQRRjaOKkTac9hY0dVxh7F3sv5ZEuZ6esRkQRZhgeMv3W7/sTH45y8QbWAg2
	 fCiIrMRMbHOhml5JfeLXhYV7qpDsuDXDup1hizqvPdPn+J2i7FiUX12fhGsU70Lg6fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ap/n+GRk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F91606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap/n+GRk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC5B1F01828;
	Thu, 22 Oct 2026 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792698824;
	bh=WP6JlEeQD8ASkWEjwTi9/wZT4bsEhI/9QekFpGnJ+1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ap/n+GRkCB9RpxAIDBLjjEOMXtAuv21IFKd9fcEQYnj8ZR0/hyMXvwq3wdekNAUFS
	 rIrGob/5EHHN3S7PTvFclFfuxgoRhi6vE7B/ZHiS2DReXwoBQo2WJzOqE8gGCMBO4F
	 lkb0XBrlr8Dywv8gQEA/BJeRGx6mSpnQshaY660wEGg4kFCMtzo3cf/10otihjW/AD
	 L3LOh1tcA2hRSY2XQSEKSWihBD/OFwTVj2lAhdgxlw9ZQHWooGZguJD3BBFYp/pCsP
	 lEIM7qY3R5K/cp8GuXxEGItcKoR20sjSL+jBEMT8SCM/Ll6b4lers1JDySH/e6MK2E
	 RvLhkN/jPOepg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Amit Klein <aksecurity@gmail.com>,
	Noam Caspi <noam.caspi@mail.huji.ac.il>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ipv4: udp: Create exceptions before socket matching
Date: Thu, 22 Oct 2026 15:53:42 -0400
Message-ID: <20261022195312.1991979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102123-unroasted-manpower-c7ea@gregkh>
References: <2026102123-unroasted-manpower-c7ea@gregkh>
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
[ sashal: Inlined udp_err_update_exception() into the existing udp_err() wrapper before calling __udp4_lib_err(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 271bf781fe54b..3c41aed3788c0 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -879,6 +879,15 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
 int udp_err(struct sk_buff *skb, u32 info)
 {
+	const int type = icmp_hdr(skb)->type;
+	const int code = icmp_hdr(skb)->code;
+	struct net *net = dev_net(skb->dev);
+
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_UDP);
+	else if (type == ICMP_REDIRECT)
+		ipv4_redirect(skb, net, 0, IPPROTO_UDP);
+
 	return __udp4_lib_err(skb, info, &udp_table);
 }
 
-- 
2.53.0

