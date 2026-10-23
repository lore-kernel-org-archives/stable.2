Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783701;
	b=zQt7M20kZxbV1obBzIZ7s/aUkGJ/kUWONFuk+UhuxOP8u2AYm0sKSeGAaiEaRoxB40OV
	 KcNGkCp5rwqmKa8bCxn4q0ECbQQcli8Ptu3zUPzYiF2I7g5WIpuaIlFN8AhC4GgyLM3AH
	 vHEfFIHc6SovTb4gkg4Fetauz8uG60hrWStWrcsp5lLCPb9FgUVIyunnqn5nmKQjLXwsp
	 YXGPOxEZ6wsx44EygwvB43DPpJpYzBEekFmymW7ZNLnLGPMRAfAyvFHI5y8PlusHzRdTk
	 Lm871CE75NUYJjKkZGK9TnNoyTq37CBOK1It0ABPtO4zx5/P+4AT9iws1ENFW2oV4gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QCUO9koXJEjic7Y8rskQ370+egV/LCuM74NkA6fYd3k=;
	b=t8FJkCgPzWe2JZ7mTdqcls6T+yYXwdzrUxbj/aIBQKvPox1fCC9+MlHY39OIE7aIbozw
	 NwOBlKT8kSxR+2tbF97jJl2XI6ZzDDPQ7pohpiYPdICyLG5xBBqfXQUAmhkckGmGiSZ8e
	 r3OjJITEQQjbswWTcWUcbQqaP2HsT8nttuIsc7ntsDM194jvp06y/e5XDbtuTssB/bDCL
	 ajrw/aaIXsqKFRpZRmn7SwzziKfZyNnpfIejLL9BnO1bVocAR6G0UBORrtPagWQuAqo/J
	 Wn655Md128T9hzrTJkyNAwR+VgVcMM+k0X3BtCYhdUPkJQK7G80fxOm8HFGLVdafLMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faWtXKFx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE0606A31D;
	Fri, 23 Oct 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faWtXKFx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B7C1F01825;
	Fri, 23 Oct 2026 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783700;
	bh=QCUO9koXJEjic7Y8rskQ370+egV/LCuM74NkA6fYd3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=faWtXKFxdICbmTEKMgXhgkn0mMBdvAXVi17vlJ6SI5zw9k/c0KtFGlNq2meSuOPCn
	 /986U79B5nDQOfQnAcj8LOxQwIDt7+XdLd9oMMbeC8xO0Vp+stvq6krq1ZRO9yuOcT
	 QYORjbFizBDhNg8uF/nngNfsrcbWQX8ZCLmMQz9ZXb5V1rESJAkVObiJWxmIcGvuAA
	 /BfXfJMr839pD9QmhH2VJDK3QIHhNFNg7GxJNHiEIPjw1I4SjQhAuI2Thzh+mkB6gW
	 +FLsHiR2zyl560gKjLKduLt20kOxwdXMVCPZXBSRfNQ0wsIIgDhHnidyZmIKRVWSmW
	 wPmFOFAbk4E1Q==
Date: Fri, 23 Oct 2026 12:28:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Guillaume Nault <gnault@redhat.com>, Simon
 Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Victor Nogueira
 <victor@mojatatu.com>, Vega <vega@nebusec.ai>, Ren Wei <n05ec@lzu.edu.cn>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang
 <jasowangio@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 stable@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>, Pravin
 B Shelar <pshelar@ovn.org>, Shmulik Ladkani <sladkani@proofpoint.com>,
 Yotam Gigi <yotam.gi@gmail.com>, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org, Jiri Benc <jbenc@redhat.com>
Subject: Re: [PATCH net v2 0/6] net: pull short linear Ethernet headers
 before eth_type_trans()
Message-ID: <20261023122819.5e48ea9e@kernel.org>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 07:59:15 -0400 Jamal Hadi Salim wrote:
> This series fixes a class of producer/consumer bugs in which an outer
> header is popped and the packet is then handed to a consumer with fewer
> than ETH_HLEN bytes in the linear area.  eth_type_trans() pulls ETH_HLEN
> from that area and can BUG in __skb_pull() when the inner Ethernet header
> is not linear.  The affected producers are act_vlan POP_ETH, act_mpls POP,
> act_ife egress decode, and the Open vSwitch MPLS/TEB and NSH pops.  A
> consumer-side guard in act_mirred rejects redirecting a headerless packet
> to a device that expects a link-layer header.
> 
> Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after the
> pop and drop only when the packet is genuinely shorter than ETH_HLEN.
> Patch 2 does the same for act_mpls, gated on the pre-pop MAC length.
> Patch 3 adds the act_mirred guard at the redirect boundary.  Patch 4
> keeps act_ife egress decode from consuming the inner Ethernet header and
> restores the header metadata.
> 
> Patches 5 and 6 establish the same linear-header invariant for the OVS
> MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.

NIPA CI flagged a regression that appears to be introduced by this patch
(or one of the closely related act_vlan/act_mirred patches in the same
series).

The selftest tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh now
fails reliably (both the "ping" and "ping6" sub-tests, on both the
regular and debug forwarding test configs, consistently on retry as
well):

  # TEST: ping    [FAIL]
  # TEST: ping6   [FAIL]

The test builds an Ethernet-over-MPLS L2VPN using exactly the tc action
sequence this series touches:

  - ingress: mpls mac_push + vlan push_eth + mirred egress redirect
  - ingress: vlan pop_eth + mpls pop protocol teb + mirred egress redirect

dmesg on the test run shows mirred failing to redirect the traffic:

  tc mirred to Houston: device veth2 is down
  tc mirred to Houston: device veth3 is down

This is the same "vlan pop_eth followed by mpls pop" chain described in
this patch's own commit message as the bug reproduction scenario, so it
looks like the mac_len/pskb_may_pull bookkeeping added here may not be
correctly handling the ingress case used by this test, causing otherwise
valid packets built by this chain to be mishandled and the redirect to
fail.

Could you take a look at whether the new POP header-pull logic correctly
handles the "vlan pop_eth -> mpls pop protocol teb -> mirred redirect"
chain on ingress? It would also be worth double-checking this alongside
the companion act_vlan POP_ETH and act_mirred link-layer-header patches
from the same series, since they touch the same pipeline.
