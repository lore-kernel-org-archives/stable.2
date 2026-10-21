Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566444;
	b=QBeaRlHDqwEi7yPyMk5cPEBB4UasD4RRI01+euzA1NvB1xnNHgKbfzf6dcZVXhAsU+cO
	 3Plmswch52Wkytf1zn3vvFvKfqIBR4/4r+kRr3Mlm18cphqzYKw2Vlu+NTFpK8DTXLU3d
	 Aq5ECwHJLj/gAFWcoWh9lo0cVb17Xx0joXpp37ngtN+drcfnu8A0VkB3jWnlX8BDwUfIJ
	 VbZpmIpD5dz9vjmRlT+xWckMDxpdTEwv3wgWulLgSsL8qeNnc7U4HAHEXYMRrmBhkRZiE
	 zF1Tmh4zLniOLbikiI+VyEi28wALiM6X0HhtiJQ8K/AmWyHMmUar88XjdFFEzGm9bGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566444;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eldH1GwkcfIm86iPHajdVBfVY+XR1al5845OKT/WHts=;
	b=C2R5Nbgb9daN2VjDVh1ot5kB9/3S+4fWM6VsM37duZzXSpaj9N0oUZ2k3p3OvOw8IF+G
	 V2lLbVgzu+YmpWlh/qkyfKxBqy/yRZXOnRe4DAHRR5M5OiFs3ClJZTOr7xhpaxhTNeVRl
	 Dt8TqSUxuUF3HzK0Jpfo61Ci8Sn6sw0fTJF18aSzuRjHCUhbXSK2Gs0BU2tWdZ2wNfpsB
	 7cNZTGZPSAhBRBnWIxI9c9lFpJYZqy5U1f4JEV2iQlDrJrFCYPfJ07D0itZ72/yVuu+j+
	 Xj3wZy3mBvdS6xW/mX94enVQQfvzk1eFIE/cZcw/qnC3OJikDcsDanahNYk30fRfwlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQhR9hjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B35606A31E;
	Wed, 21 Oct 2026 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQhR9hjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E56A1F000C9;
	Wed, 21 Oct 2026 07:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566443;
	bh=eldH1GwkcfIm86iPHajdVBfVY+XR1al5845OKT/WHts=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gQhR9hjJXBr0e7SR/yp8mZbovgntvu5XYHS6SYLPIQjrHMWpMiH/RcqOYC1RxV3tG
	 /vyypnsefQsjTOfO8mZMobXBAbZ8Irh8hhCszzTYglqQFB7fcmhuGa6KyPLilEWnPF
	 5MZ8llLb5H+NaZZ7nyr8AeN/o4BYBtR5Lo2SrZIn6ROQqKXOk42W55WX+TSWzOrQEV
	 Ofte5/GhbanHxOTD6faxJqNBgNcRnSU51/LP6dCx/V5FDLH3J/4SHp09gEwFZpV07h
	 SJYooaxv0gMKV/qb2szthgXWC8yb3JKlEZ6yJUr7VNdyya5ojNn5a5VMqcf4x8BW+O
	 Tsh4bOjqatLLg==
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 07:07:22 +0000
Message-ID: <179256644257.3133.14974655979345931917@kernel.org>
In-Reply-To: <20261019180306.382039-2-w453y.me@gmail.com>
References: <20261019180306.382039-2-w453y.me@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete, and it adds a regression when no other
  subflow is still alive.
- [Low] The commit message describes the state of a reset initial subflow
  incorrectly.

--

mptcp: pm: in-kernel: fullmesh: skip closed subflows

This patch makes fill_remote_addresses_fullmesh() skip subflows that are
closing or in TCP_CLOSE state. The skip applies both when building the
bitmap of remote IDs already in use and when picking remote addresses.
The goal is to let the fullmesh endpoint of the initial subflow create
new subflows again after it is removed and re-added.

> If it was already in TCP_CLOSE,
> e.g. after a reset, it is disconnected and its context is reset: the
> 'closing' flag and the remote ID are cleared, and its remote address
> and port are zeroed. It is then picked as a remote address, with the
> address 0.0.0.0, the port 0 and the ID 0, which also marks the remote
> ID 0 as unavailable.

[Severity: Low]
Is the statement that the remote address is zeroed accurate?

On the TCP_CLOSE path, __mptcp_subflow_disconnect() does:

    WARN_ON_ONCE(tcp_disconnect(ssk, 0));
    mptcp_subflow_ctx_reset(subflow);

tcp_disconnect() only clears the destination port and the source
addresses:

    inet->inet_dport = 0;

    inet_bhash2_reset_saddr(sk);

inet_bhash2_reset_saddr() ends up in inet_reset_saddr(). That only
touches inet_saddr and inet_rcv_saddr, plus the IPv6 equivalents.

mptcp_subflow_ctx_reset() only clears the reset struct_group and sets
local_id to -1. Neither path clears skc_daddr or skc_v6_daddr.

So mptcp_remote_address() on that subflow would return the real peer
address with port 0 and ID 0, not 0.0.0.0. Could the commit message be
updated to say so?

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 1a7750813235..24cdb170ba62 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -199,6 +199,16 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
>  	return 1;
>  }
>  
> +/* Closed subflows can stay in the conn_list, e.g. the initial one: their
> + * addresses and IDs are not reliable, possibly even reset.
> + */
> +static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *subflow)
> +{
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +	return subflow->closing || inet_sk_state_load(ssk) == TCP_CLOSE;
> +}
> +
>  static unsigned int
>  fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
>  			       struct mptcp_addr_info *local,
> @@ -216,11 +226,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,

[ ... ]

>  	mptcp_for_each_subflow(msk, subflow) {
> +		if (mptcp_subflow_is_closed(subflow))
> +			continue;
> +
>  		ssk = mptcp_subflow_tcp_sock(subflow);
>  		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
>  		addrs[i].id = READ_ONCE(subflow->remote_id);

[Severity: High]
What happens when the closed initial subflow (msk->first) is the only
entry left in conn_list?

Both loops skip it, so fill_remote_addresses_fullmesh() returns 0.
fill_remote_addr() takes the address from the msk, but this function has
no such fallback:

    mptcp_remote_address((struct sock_common *)sk, &remote);

By that point, mptcp_pm_create_subflow_or_signal_addr() has already
consumed the endpoint ID:

    __clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
    ...
    nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh,
                                   addrs, ARRAY_SIZE(addrs));
    if (nr == 0)
        continue;

As a result, no subflow is created and the endpoint stays marked as used
for this msk.

Two cases seem to reach this.

The first is the case from the commit message, when the initial
subflow's endpoint was the only live one. An example is a single
fullmesh endpoint and a peer with a single address, where the endpoint
is removed and then re-added. Nothing is created, and the msk is closed
once the timeout started in __mptcp_close_ssk() expires:

    if (list_is_singular(&msk->conn_list) && msk->first &&
        inet_sk_state_load(msk->first) == TCP_CLOSE) {
        if (sk->sk_state != TCP_ESTABLISHED ||
            msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
            ...
        } else {
            mptcp_start_tout_timer(sk);

The second case looks like a regression from this patch. The initial
subflow's endpoint is removed, then a different fullmesh endpoint
(ID != 0) is added while msk->first is still closing gracefully.

Removing the endpoint goes through:

pm_nl_del_endpoint()
  mptcp_nl_remove_subflow_and_signal_addr()
    mptcp_pm_rm_addr_or_subflow()
      mptcp_close_ssk()
        __mptcp_close_ssk()

That path sets subflow->closing. msk->first is not disposed, so
__mptcp_subflow_disconnect() only calls tcp_shutdown(ssk, SEND_SHUTDOWN).
The subflow stays in FIN_WAIT1/FIN_WAIT2 and keeps a valid daddr, dport
and remote_id 0.

Before this patch, the first loop did not mark that subflow, since
local_id 0 differs from the new ID. The second loop then picked it as
remote ID 0 with a valid address and port, and the new endpoint created
a subflow.

Now mptcp_subflow_is_closed() skips it. Does the new endpoint still
create anything for this msk?

The non-fullmesh path recovers in both cases, because fill_remote_addr()
uses the msk's remote address. Would it make sense to fall back to the
msk remote address here (ID 0, subject to deny_id0) when it is not
already in use?

The selftest in this series ("selftests: mptcp: join: re-add the initial
subflow endp with fullmesh") always keeps a second endpoint (id 2) with
a live subflow. As far as I can tell, it covers neither case.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019180306.382039-1-w453y.me%40gmail.com
