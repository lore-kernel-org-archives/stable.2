Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244544;
	b=g9B8c6VTlcLfFsx642Hm7ogq29fkIqu9GPNuYdL4x/nbsVFG6m/RUpwqgkaW5Iw9wHmE
	 DLiwxid01qC3VaSvUIJcf8vlR/33p+O1UsyH5RtzxvUzfmZQNbQ6/rtTLuRXPQzXcpU+w
	 MC4WY+8YXnZN1wbWK2StUnm9nH1jYun3/qZazghw2omIQBtWL9H8OX8LQV//hY2wOJiGl
	 /V1AuUXKOUKFbkRPu9wKYt/2AcDCG5OW2mYFC+GCU6ti/BDx0l3ukxp7AVF/IcYuF1HcP
	 1/FKVQ0UdtfJC0ocz3zzBQyl8RU4Q35E0kXrboKfkQHGq/6ygPuQ9nGvRE9tIZ/AC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244544;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FV/gOIEqM460iJY+njk1sy17xCRYfoeAfz2fjXVt/zQ=;
	b=WhCLnlOzQEUFX52HGONsyzaFn2JyLte15c2jP99FvHvs58CbB+HbhNkQ0fXOR4RxeYdu
	 8ts2TdvBApgxNJJXDnzDqj5jAMeFTxh9a/Z0DNooM9LoXjaIgf0d9bp868JnFq/iolqXB
	 jrzeD2Yi6mC9Gfd01usKEmPGcG0VWo8PISKL8FVLtbMX2GSgEGqyCPfv9jNes2OP+FdkT
	 PsuLJRtdaF3bkg5F+t5XmmXyQe9zGObAgZoyE1EKwV16lrL7udIxkzjeY8ze9xf+2uCBa
	 +BnE6ZY91wf1LKnb6CIklvvbg6SH9MS9xExQTp6HYuumyUQKevxoJaZS4D+dQ4Dp4pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcnUzuS5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A0606A325;
	Mon,  9 Nov 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcnUzuS5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716D51F008A3;
	Mon,  9 Nov 2026 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244543;
	bh=FV/gOIEqM460iJY+njk1sy17xCRYfoeAfz2fjXVt/zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QcnUzuS5LTfs+FxCMi1X6w0Ur2hdM50fYhVpXhOh5BKqXzA+mAsBFp1XzUgsorXsV
	 Ot2Et44aWuFTNwk7BK0NIHgALfpUaC8zndjBYR7K9gMLEH8R+OP9HcF6KYW7NTlsFr
	 OshGPel1lfW0Arg+9GIls0X7KmHq7uAPx7QgyK+crZB2h6rF8UISk72qQfiQMOReOM
	 22Mpk9fibez8Q50iO0VSn7m0B23/zsVxWLMlOG1+1aQgYZ3/BctllzopDKEPv9F1jC
	 PahI0erKUUBPfH55nJc6fGWkF/RAG59tbLkneH3T0FqCebOi9bWjW4hSsoU4vAnGlx
	 FmyeLvhOlKPbg==
Date: Mon, 9 Nov 2026 17:15:39 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] net/sched: sch_teql: unshare the header
 before writing and fix retry strip
Message-ID: <20261109171539.GU18859@horms.kernel.org>
References: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
 <QDISC-6HS9.v3.r0.20261103073017-1@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-6HS9.v3.r0.20261103073017-1@mojatatu.com>

On Tue, Nov 03, 2026 at 07:39:15AM -0500, Jamal Hadi Salim wrote:
> The issue:
> teql_master_xmit() writes the slave's link header into the skb in
> teql_resolve() and on retry pulls it back with __skb_pull().  Two bugs:
> 
> 1. When the skb's header is cloned (e.g. a tc-mirred action on a
>    physical device's clsact egress redirects to the teql master), the
>    write corrupts the other clone.  Call skb_cow_head() first.
> 
> 2. The pull always removes skb_network_offset() bytes.  For an
>    AF_PACKET/SOCK_RAW frame with no dst entry, teql_resolve() adds no
>    header, so the retry strips the user-supplied one.  Pull back only
>    the length this slave added.
> 
> The Fix:
> Track the added length per iteration; a header-cloned skb is unshared
> before the write and an AF_PACKET frame retries with its header intact.
> 
> Conditions to recreate the bug:
> CONFIG_NET_SCH_TEQL=y and CONFIG_VETH=y, run as root. A teql master with
> two veth slaves, the first slave returning NETDEV_TX_BUSY without
> consuming the skb so that teql retries the frame on the second one:
> 
>   ip link add vethBAD type veth peer name vethBADp
>   ip link add vethGOOD type veth peer name vethGOODp
>   ip link set vethBAD up;  ip link set vethBADp up
>   ip link set vethGOOD up; ip link set vethGOODp up
>   tc qdisc add dev vethBAD root teql0
>   tc qdisc add dev vethGOOD root teql0
>   ip link set teql0 up
> 
> Send a SOCK_RAW frame that carries its own link header on teql0 and
> capture it on the second slave's peer. A veth transmit does not return
> NETDEV_TX_BUSY on its own; to hold the skb pending this reproduction used
> a test-only IFF_DEBUG accelerator in veth_xmit(), which is not part of
> this patch and was applied to both the unfixed and the fixed build.
> 
> On the unfixed tree the captured frame arrives with its header stripped
> (176 of the 208 bytes sent, starting at the payload) because the retry
> pulls skb_network_offset() bytes while this slave added none. With the
> patch the frame arrives intact.
> 
> The shared headroom case needs a cloned skb: a PF_PACKET tap on the
> master whose socket is never drained keeps the clone alive across the
> transmit. A kprobe on eth_header then reports cloned=1 on the unfixed
> tree and cloned=0 with the patch.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

