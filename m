Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795444255;
	b=ibZ92ZBkQruPqEQrCTD9+ENuiaC7GbrfZj0vFzh9DEYzJB++0mzOeJ5N6b91cVdcVlMJ
	 mKjfiEjI4snMtxlNz3/aTB/C8igB/CSyWz6vCix/MKcPuc4EbPtS78jSWFb1OmafCsPvq
	 KCc0MS4uxTDQZgfh12E8qv3UUd3Vj20uv7it2xvkvDy5TEQWfUXnxN97ivqGEgOfASqw+
	 87YNEnECS7PQSBbqIWO7pAn/e0ESIOBVlwQmWocwN0i2Gdu7sG5KAsBB2ttincPGwjobg
	 p+7cb5I7EJgie4P+FfImt80F31hKZyU7p5nlj9yU21c8jnYA0J3vEXBEBK2OdY7hWCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444255;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JScnUatuEfjCIskt4xIoZBpuSuIcjcWtECZJjYmVwFs=;
	b=xQHQTEW9eHETLm63FjST9cfr64PsOWbsxtWuGS7CxAP4fgtuWIej2tYn0qXMIffgHCpr
	 shMlEVYMycrBRdaIn3zzdlW1hFg7edR4b92PgogY4pRb4vgyBvTsKj3pZJZWTDMNgecEe
	 dDyfT/agxHdZZBd5460A1EOCd1wpz6lb5qLtKlNzvPh7BVTryubPsRm8wkZsmhIpODOe3
	 H5ZuM+NrK59YqSVXvu8QSb8yFFUqPfYy90VLJyFup8yopWvcb4nbi/9dxXFyvkKMYyA5+
	 Z+SPac3eSrZeNsWPC88afCdIaCbyIVaUJFHiQVrzl8U+5zM62T0fzNK2njbe5ofYXTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvHOX2DT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B3606A31A;
	Mon, 23 Nov 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvHOX2DT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795444255;
	b=0enELYi76I+goeDMfJazIV4lI6Lb9yvAE7RfrkjOyyucCvZU+RNbRkKEL3telT2cuidi
	 ZvqNuGQgtn0euH6xF0NDWOkmNBh6XihaIQwsIHcXyr1nxnTZUp0VP/O5myF0d9zWWKD4K
	 sLVTKSDmfKNDUpsC0m1ioXm7tVzkB9tlkKRlh0yw0GUyty4TMF77s4Az6T/jacLJJkUrE
	 4f+qQhYgO7DXTwDO02Mcx4gE2tZO8aJGP7CxEl6VzNkQJcoUVogfk9Aq06h1YEiDDCGMl
	 T0h6lYzOGJY0XKwWbMRO8rcboRDwrTbu+KH0DOQj/oFGo1jpksi3sUxLMFx8NxZ766w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795444255;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JScnUatuEfjCIskt4xIoZBpuSuIcjcWtECZJjYmVwFs=;
	b=DArmtgyoS5m5cvkKqCkYnSZOkXHxRK0LUdJsLwjXUPaHPih7/z8RWGkGcU7FL0gfQlbA
	 X1x7xRpIxz6qFC+qWz/vm2Pb8py5VKZVaLM1LLK0pg/PBW+jkkfzogBxeZsTGec9MI0SL
	 UhSmq5X4atSKkQ6+jTo/2J/ApoN/dC6brm6RqNMJKdvs+LiHFn4d/cVq36O/8keJY8UE4
	 X42by8oU4b1Uc3PWZfkNFS4a8in4wWucMwf1SF3S8fUBrHhwQy1ORbuO6IditnF72qhpH
	 NUmKLI0XcdhxhW48LSu+Fq63HMoE3gv+WJ/gNW2kQLW0WAiAXFbMCRSOhLqHUjEkcxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 89D931F000CF;
	Mon, 23 Nov 2026 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444255;
	bh=JScnUatuEfjCIskt4xIoZBpuSuIcjcWtECZJjYmVwFs=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=jvHOX2DT2ehfs9hvWJnu13s054D39b0HdDgI/yefeqo/ADNrMem/qaubXOApWo3g6
	 oqNimANGx0RBURt2WCcNnErOtjCQF69H4zCXoAguQ0EwDiKwXk6Vb6H97UCH9m4rV7
	 2iJs27UiGngMMm3Wc2ctjUEvEvn5uhROW4MiTgzLTB45MRUlbVrudL4lC8pABCUWnh
	 UIF1gWtemPSB4hhKKS5nouAfw00aoK1ophJ9jJ1eXhBEmmFB1tHf4fC14Fhs9uDAEj
	 SoQRzOijI6W35728GOZ5Y/0g2W2Hpch8tDyZe+PiqGMDA0Mz+JVZWM2usnE76WnlVQ
	 5LiYFeXCTJRjQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 13B894C4DC;
	Mon, 23 Nov 2026 14:30:52 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH net 0/2] ipv6: fix IPv6 scope check of the source address
 in a VRF
Date: Mon, 23 Nov 2026 15:30:42 +0100
Message-Id: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJOBGsC/x3NQQrDIBBA0auEWXdAjZHSq5QuJI7pLKoyk0og5
 O6VLt/m/xOUhEnhMZ0g1Fm5lgF7m2B9x7IRchoGZ1yw1s2Yq+C36S4UP8itB+ySUWNKgrrWRtg
 tejI2LHfjk59hpJpQ5uO/eUKhHV7X9QMm8anyewAAAA==
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795444251; l=1748;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=ckLhEkeU0s46EikTMohSy6D9LFFcDelhweYemdwaM7Y=;
 b=IhHwGmrL9GR8k8EXPg+veCjCJDcf7ZclMfh2fGb8EyR+/CoktYqy9ADqvvsbN8KfCOm6PLkAN
 4n1HjoSTl+sDWMy8Iib0gnkTy2Y0B+bTxJuKLHwFsIc0+1fHZHvv/PK
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

When a packet is sent through a device of a VRF, ipv6_dev_get_saddr()
first checks the addresses of that device and of the VRF device,
and stops when the best of them has a scope that fits the destination.

Since the commit abb9a68d2c64 ("ipv6: take care of scope when
choosing the src addr"), the check reads the scopedist of the best
candidate, which is an issue:

- with a single candidate, scopedist is not written: when the stack is
  zero-initialized, a device that only has a link-local address sends
  to global destinations with it, although another device of the VRF
  has a global address

- with more candidates, scopedist is negative, whether the scope fits
  or not: all the devices of the VRF are looked at, and one of their
  addresses can win over the address of the VRF device

Changes:
- patch 1 compares the scope of the best candidate with the scope
  of the destination

- patch 2 adds test cases to fib_tests.sh

Note: abb9a68d2c64 is in every kernel since v6.11 and was backported down
to 4.19, so the bug is in all the maintained trees (5.10, 5.15, 6.1, 6.6,
6.12, 6.18 and 7.3), hence this series for net.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Vincent Jardin (2):
      ipv6: check the scope of the best source address candidate in a VRF
      selftests: fib_tests: test IPv6 source address of a VRF

 net/ipv6/addrconf.c                      |  6 ++--
 tools/testing/selftests/net/fib_tests.sh | 47 +++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 3 deletions(-)
---
base-commit: af6737b9066832a2017c281159950ba92385ce00
change-id: 20261123-for-upstream-ipv6-vrf-saddr-scope-v1-4e0165804d43

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


