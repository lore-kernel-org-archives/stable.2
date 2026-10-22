Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706696;
	b=xvZMX2jaKkipyZduTQhbuaRsRLI4yitH0Wo60k2Z1b191nxkuU2zwU1/BLRVvoxI8268
	 laxGD95zcLxJfmAT/MlX8CKqv0Sm6pS0MAaTWN6sgyN6fycRrnsoTaYn4cEFUTbzDDRzl
	 uxvUCaJq9nHG6PuRnSyVZ0x04KIID1tv/uyruWfgwiUnLlMXTaJbwmrcI8d418EaN8uv+
	 lEILxPteKP2uZWgcKDrlal3y7Psm/5BezA5g0KD7EuI2V9N5mRxNAQSR7iLAwadGYbwzB
	 7oQ9Vm2B/3JDg25p+lHN/4vb9SzqotQu1Ko88icmt16R7WdvEFsImUgPtJbppY/s8nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706696;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V+pp4HsGF8MG7/4fXk97ZD5VQnE/u6EXSEWiageyILI=;
	b=q9bav7e0Rz/viLUrPAjQ08d9Gs0D+hZyABB/0P+1aJN/89OEW3Aay8cyzjW46+k4FAS5
	 osCODGUWM4SMUM58DsB437YDvllV49lLOcS1JQtSESznjxi0dBPosfDkm6gyMOIrYnOfx
	 mR/LDXc8R/WX0Kkuq7RaVYeOBUoom+KZx1xSRGoQZrTKNuSR7POQo2iSpwy48pdeDWMvR
	 YyTCk0UlOY0QFROjpvOfMWQLNq2wkYiCumC4TH3ghJsAXoQPkqx0qZAuiGPFFfptOtc9Y
	 fkLkVlJDVcIm1cWpkECrjKaZFxYmtxbnqMdsH6Gg0mLDGGRFWr2FNvsqtZvUqnQOnZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdaFiZEd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01181606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdaFiZEd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4961F01825;
	Thu, 22 Oct 2026 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706695;
	bh=V+pp4HsGF8MG7/4fXk97ZD5VQnE/u6EXSEWiageyILI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdaFiZEdA8e03VToXJ1wNjb6eYSwgeSGC6wZVp2vZuPU0JJxeCUfVTuGQRpQd4G39
	 +GDru3OKN/0v5e7CnLJExAXKt5+JYQ5QyYNVsckdmPcHB2vC324rbRaun8D8uBA7BI
	 o4sJObP9wk/ZLV2J/8EK58MTCMDSxvXElM1iqOV5m8JcXhLovVYgGTtpIrTu0vebGf
	 ap/mLRLQHeSNxQSLBL7sfKU6rwdRz5jExEYGJgKUyEvtzhIQoPzbSq61cNqBrh2mJr
	 BjUCjpWz6gdHdgeaiTx65yd7FdHabLT40nMWFh1nYPkg0PKPQgvM5rmag4FyO2SEbf
	 fkMoz19wPA7RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Amit Klein <aksecurity@gmail.com>,
	Noam Caspi <noam.caspi@mail.huji.ac.il>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ipv4: udp: Create exceptions before socket matching
Date: Thu, 22 Oct 2026 18:04:53 -0400
Message-ID: <20261022220234.2082806-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102125-annuity-hardcore-06cd@gregkh>
References: <2026102125-annuity-hardcore-06cd@gregkh>
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
 net/ipv4/udp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3ebd5765fb9f3..65780cf993eac 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -821,6 +821,15 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
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

