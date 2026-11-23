Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795444263;
	b=B1FqT1agfXwnuYUJZB9Q4eEJXnrGM0u5/GW/+ziosIgAaO8PGK1cT2zh1eu/LTnpgBs6
	 /362NwcbBG5PTh1m9YpROhHaKVfo6BiGxrgQseSL39dUtbKYAKRNLytLAFgn3hiOwBeO5
	 AN7YVGjHYCj/sZWBNKcYjqSY16WGG7dpJ/sBEoahgiARGFLPq5josYT0XFNVpsrczFCjz
	 NKKUCktaZAZ7KH2ZLlNtPmOGTEzhhrVdGYW+e4WOBeBdcZTfD59QPkoE/QbI3xi0HRRru
	 dlziT6z01cBnXDsoSRiEbn0ZoD9OyGzsWMvbUUfb5CUetVU3dyvmu3Da8WnCK4I/a1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444263;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xrLaKHA3sJwjAre87JnUl3Dnk2NMJRvKap97XCVKh7o=;
	b=B4kGpQGdppHkwCli8o+2p7Go1+7rvf2Uk5kosVwz0GYujHeKveKrFbjjtX/6Cq5hRRvT
	 3ubEQiZl6wyn1Fc1OnT/E+fjVXVii+WOxH3lzjCTIKbXHRRr5x7cYEPSTQvgLHg+9NSDu
	 NJPCRKQSzZKlOVPsbIbgerPs8UIVL05luYwb9FwuSeNbw89P/ryfXDIexRGvPYYCAhlqG
	 Ie5GB6qNjm43Pjg/SMho0i/dZML9P4Y5xwLeuF0cPLcjyQm33YV8oP1fWofNntBWrrZ1Y
	 7wBOUjpXSRQmzeiNZGIrUSyNaki+ak7c+lv/N2f0fFQhn4MfQlsQwM6eVmzplkRgQjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X23225MT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60048606A32E;
	Mon, 23 Nov 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X23225MT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795444263;
	b=YjX1CFzB0IX7sSz/QchQzmS13swHdrqZM1fUxq+ENXJPQOp1qhKTZNE2CczqQot2EbYR
	 v4l8Hyi/tiYQgQBrwCuO98xQ3GrUv7lxggBdIyyhLJUT5XSAkW5HRYvuEktyVtLHWE3de
	 DK9ZxvX587NvOUVkQbFKwx1uw7z63jZlA690xMlSAibQKmE/vahIG5cINoefM2rZRcm/q
	 RxSMKT0S6szjjoHuWUb8yE9jXdV1dcCgN3X5p9ex6aQGfG30fdZO6AiSa6A9uwSTlwXJa
	 nkvnT/0ZIzHF31JyURlaHCFT6J9DnVdySqx5JlqitvJia4S4GDUNbrFH+avEBSmZ4KA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795444263;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xrLaKHA3sJwjAre87JnUl3Dnk2NMJRvKap97XCVKh7o=;
	b=pmi1Qk4iAVVY0AU3VxsVA0YlBbrpmfV4Gi7kWIhQzzzTU3twOQ2kRWxnN1PrST5pkRFk
	 DeYyTgfnKH7Z3uJW/2YDI3vQQ9/SNR0QQGjRdUQCP4hrwSRFZjiLd326GaAC0PaRvvd5N
	 qPWytDFQUSOfomP9aszxMzzo2Og6+EmS5AVHnMrv6TLg9UZmqZFSgM+ILEKnDNcu9KSjt
	 DRhenHCY65TxK8fmlvpyYueYuSd2jBIBLCzJQAI8/tjpezAz67BQHOzMiL8EHBICvDHgR
	 dRHmhF6rKTAtIQMV6dVV99WInRUgg+ugk52VDcHplxkb8UTpV/whs0PBVW1OyowH1Yg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A8C511F000C4;
	Mon, 23 Nov 2026 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444263;
	bh=xrLaKHA3sJwjAre87JnUl3Dnk2NMJRvKap97XCVKh7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X23225MT00aLLFvrf2KvDneKDL6TCTl//ZcxB5aHy0CdThvZDHi4+dW1RPp4NtgXv
	 7gzP2lEs9ofSTT3Myyb9bY6ZHxmfUMrPd7ZlrGPE+qo2ofAtNSgZxYSR2k/JBVUi82
	 kdGnrSi2fiJLmUkz8b1+sKPC6LEg/cteyyamxNQKsdW0nF2hWb10yxsnJfgBYDQSv/
	 F5+R9+V9T9Y1zp6cYm2zIS2QKuWdr3qtzbFTEahoWXQKp4rOm6HPw+iGth6+x2KwNG
	 CUetOLOcw+xd6Qut2Nk9dmvdCBSKd4DU9YBrYP7QSGEkC0S79Ys+aJ2yEq4I/6Jz2Q
	 ue+MfgzrbGZqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 361944C4E2;
	Mon, 23 Nov 2026 14:30:52 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Mon, 23 Nov 2026 15:30:43 +0100
Subject: [PATCH net 1/2] ipv6: check the scope of the best source address
 candidate in a VRF
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-1-f667ab150ade@free.fr>
References: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
In-Reply-To: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795444251; l=2864;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=qAK+JiLvzEBuj4PJyiZhxLv+qsyTNP8cUsd3PTIFVWc=;
 b=DoNrMRJhpkn60MdAaMHqnBimsK6qsAE7VwJ7xzOfpQ4Ctqle+qhdlT3jDGtjUw2NbvaSBuZo0
 Z7xr8V0IESzDym2QwpvPhYX0/MHuNXVJgwzsgTcwd9paGMhzyTXMQl7
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
Content-Transfer-Encoding: 7bit

From: Vincent Jardin <vjardin@free.fr>

When a packet is sent through a device of a VRF, ipv6_dev_get_saddr()
first checks the addresses of that device and of the VRF device.
It stops there when the best of them has a scope that fits the
destination.

Since the commit abb9a68d2c64 ("ipv6: take care of scope when
choosing the src addr"), that is what the scopedist of the best
candidate is tested for.

scopedist is only written when the rule scope compares 2 candidates.
With a single candidate, the rules stop at the first one, which only
tells that there was no candidate yet, then scopedist is read without
having been written.

It is 0 with CONFIG_INIT_STACK_ALL_ZERO, which passes the test:
a device that only has an IPv6 link-local address sends to
global destinations with that link-local address,
although another device of the VRF has a global address.

  # ip link add site2 type vrf table 30
  # ip link set site2 up
  # ip link add dummy0 type dummy
  # ip link set dummy0 master site2 up
  # ip addr add fd00:91::1/64 dev dummy0 nodad
  # ip link add dummy1 type dummy
  # ip link set dummy1 master site2 up
  # ip -6 route add fd00:93::/64 vrf site2 dev dummy1
  # ip -6 route get fd00:93::1 vrf site2
  fd00:93::1 dev dummy1 table 30 src fe80::5cb7:13ff:fe96:87ac metric 1024 pref medium

When the scope rule does run, scopedist is negative, whether the scope
fits or not: the test fails, and the other devices of the VRF are
checked too. One of their addresses can then win on a later rule,
the longest matching prefix for instance, over the address of the VRF
device, which the first lookup is meant to prefer.

So let's compare the scope of the best candidate with the scope of the
destination instead.

This issue was found for a development of a UDP tunnel device with
IPv6 addresses in a VRF selecting an IPv6 link-local source
address for a global destination: then it was confirmed with the
fib_tests.sh case of the next commit, whose first two checks fail without
this fix on a CONFIG_INIT_STACK_ALL_ZERO=y kernel.

Fixes: abb9a68d2c64 ("ipv6: take care of scope when choosing the src addr")
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 net/ipv6/addrconf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d9d13e78bf13b..656bf1ea26da8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1902,8 +1902,10 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 							    master, &dst,
 							    scores, hiscore_idx);
 
-			if (scores[hiscore_idx].ifa &&
-			    scores[hiscore_idx].scopedist >= 0)
+			hiscore = &scores[hiscore_idx];
+			if (hiscore->ifa &&
+			    __ipv6_addr_src_scope(hiscore->addr_type) >=
+			    dst.scope)
 				goto out;
 		}
 

-- 
2.43.0


