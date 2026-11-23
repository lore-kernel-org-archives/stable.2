Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460455;
	b=dcUZNt8mWr4gwbwvzQXizDGe0Xdsypui7YWWDS6J6vFceTIMsPhB72pFUCmNdyK6dtLv
	 5KckzLJiN+PWvzj2nnDPVY0pbgB+DdFp0c9Z7g8H30qf2yQLybEFYYa4F1LL2UBtNqOOW
	 lGAUvyH65xOHCvORi23XtTwsh17bUf9KmVLb/HvBHSRcgk+kNfC0Z4+mP4f5mmtJuAPlK
	 LOlqFqZ7Nwc1SYkwakatb5xPpuP0bbjkTKXc38c9WiwQTYqnVwYnX67Apoc4fV8domy1H
	 GPOXLCzAW1TH47Dip+w7ZMzFjlx+b23w6UUENdIUitqSU4v3wG2c82ieDRL1Ys2MHYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460455;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6hqSEVVgw4CPVV6h2E6Vul+wGHSIIB7M/bfVK6/0gN0=;
	b=TgsxY6N9vGXGL+2XIrAwQq8gLNj12/hq7cKYUykDZqAGxZPE98FFL8nNsRChsm00NRSB
	 C62BfI97g+U6Z4Ck71nHHqE2V98IVwepspoNpzzSe6XWoObCm9gPNEvtPku82JdqyvAy0
	 d01mykeDCSXjX0zo7Ql+XmkZYlTcJL+z+fSGcXb9bm9ELSjm6UVstm9yiKtSTR07W53t9
	 dCaeI0vT8Sfhm3D0QGe1OFqcQpOgRL4K5jpOk3Wj5+hT/GLq3UxYrcHG38hiKr8SSu4mW
	 nxdyGTqHH356jHjYs/sTEJMi/Wvho5nXO4dp2jIN24Isuwrq7Ix2epKVq9WOV7G7CXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHoxSiHJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A18606A31A;
	Mon, 23 Nov 2026 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHoxSiHJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6161F000D4;
	Mon, 23 Nov 2026 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460455;
	bh=6hqSEVVgw4CPVV6h2E6Vul+wGHSIIB7M/bfVK6/0gN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DHoxSiHJffR6+Nc606UOEyEd2EYQvC4vzuVqOae1qmLOC/IO4qvA1uz6gr3ob2D50
	 7t/5jR6Uy9C7gRa5IG3B8eP4gzGoUZ2aX8kglQCIdNpkYlMdV05S2AqYag1ojqXh0G
	 W5heKcti95GTV4kbKDY8e0OZc91JrNCtBM17rWSOqCn0MR8/X0V3TwpnzK/vciK2uq
	 vsg4pIQw/Zf4OlMaCxDEmZXO3SeYB5EJ3Lw5sX/tNM0LgfVe2z8zBEFURhHzy2f8tp
	 rfGVADs4HOKbNTZf1EjbanZGY3QWiVW4F3VsP3AHx3faB9SkcrFvZEgYKeahGMWqxf
	 CaZhudOZL3YmA==
Message-ID: <fbddbdbd-4052-4753-89ee-cc75198b9842@kernel.org>
Date: Mon, 23 Nov 2026 20:00:48 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 08/10] mptcp: pm: don't let listeners pin their netns
Content-Language: fr
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Christoph Paasch <cpaasch@openai.com>, Florian Westphal <fw@strlen.de>,
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
 Eric Dumazet <edumazet@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
 <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 23/11/2026 14:24, Matthieu Baerts (NGI0) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> For a "signal" endpoint with a port, the in-kernel path manager creates a
> listening MPTCP socket with sock_create_kern(). This socket is released
> when the endpoint is deleted or, failing that, by pm_nl_exit_net() when the
> network namespace is dismantled.
> 
> The MPTCP socket itself holds no reference on the namespace. But its first
> subflow is created by mptcp_subflow_create_socket(), which always calls
> sk_net_refcnt_upgrade(). So the namespace cannot be dismantled before
> the listener is released, and the listener is not released before the
> namespace is dismantled: unless somebody deletes the endpoint, both stay
> around for ever once the last process of the namespace is gone.
> 
>   unshare -Urn sh -c 'ip link set lo up;
>                       ip mptcp endpoint add 127.0.0.1 port 4321 signal'
> 
> leaks a namespace, with everything it contains, each time it is run. It
> remains charged to the user's max_net_namespaces limit.
> 
> Only take the reference if the MPTCP socket has one. A listening TCP
> socket has no timer of its own, and request sockets of a dead namespace are
> taken care of by inet_twsk_purge().
> 
> The sockets cloned from that listener for incoming MP_JOIN requests do
> need the reference, for their timers, but inherit sk_net_refcnt == 0. Take
> it when they are created, with __sk_net_refcnt_upgrade(), from the
> previous commit, as this is done in atomic context, and drop the
> connection request if the namespace is already going away.
> 
> The TCP listener of such an endpoint is now a plain kernel socket, like
> the MPTCP socket it belongs to: it is not counted in "sockets: used" in
> /proc/net/sockstat any more, and its destruction is not broadcast to the
> listeners of the SKNLGRP_INET*_TCP_DESTROY sock_diag groups.
> 
> This issue has been found with the help of an LLM, and reproduced in a
> VM, with the reproducer shared with the original version of this patch:
> the command above, run 1000 times by an unprivileged user. Without this
> patch, all the network namespaces were leaked:
> 
>   result: 1000 network namespaces made, 0 taken down, 1000 are left
> 
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ Use __sk_net_refcnt_upgrade(), from the previous commit, instead of an
>   open-coded copy of sk_net_refcnt_upgrade(), with maybe_get_net() like
>   rds_tcp_tune(). Shorter comments, and describe the condition: any
>   kernel msk. Commit message: how the issue was found, and its
>   symptoms. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/subflow.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 20d506235074..3e674c21bdb2 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -844,6 +844,22 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
>  	WRITE_ONCE(msk->fully_established, true);
>  }
>  
> +/* Children of a kernel listener need a netns ref for their timers */
> +static bool subflow_child_get_net(struct sock *child)
> +{
> +	struct net *net = sock_net(child);
> +
> +	if (likely(child->sk_net_refcnt))
> +		return true;
> +
> +	if (!maybe_get_net(net))
> +		return false;
> +
> +	__sk_net_refcnt_upgrade(child, GFP_ATOMIC);
> +	put_net(net);

I just noticed put_net() is somehow deprecated (according to
netdev/deprecated_api test on PW). In net_namespace.h, above the
declaration of "put_net()", it says "Try using put_net_track() instead",
but I don't think it makes sense here: I would need to allocate a new
tracker here. Indeed, I cannot use child->ns_tracker (it belongs to the
reference __sk_net_refcnt_upgrade()) or NULL (no_tracker was never
incremented) from what I see.

If a new tracker is needed, it would be allocated before
__sk_net_refcnt_upgrade() and released just after. The fix here follows
what is done in rds_tcp_tune(), with the same sequence from 5c70eb5c593d
("net: better track kernel sockets lifetime").

So I think there is nothing to change here.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

