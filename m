Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571157;
	b=GqzSjJIKyYz88VAMnlsst33clUTKe08JLESLmSWnKxhTV8qyUTqX+k/FikEskjq2rnP5
	 woAxeDGctbg5gEtLMadfagPBICQDCtPkvFmt+Gi3Hka0P/iFXWcvXm6wf2wEaN6EA2gwC
	 xg5R6f0w5Sg+Wv90dThkSxq0I833tNY0/2pULcqx5Rmnzwm5Sk3DyLQ5LFB8QwuP75FOR
	 4aq2mfGAT5TWXm+KfqSl8lPRHcItNQu6HQ/FA/jFGqnGZPF3qyW52P6y404y6aGVT+y1I
	 Z9smW6jWtGkjAa/Rlib1yJtr1xtLQB8cJcJST63rTuL2EJDdgV9d15vJkkIN3u3VGQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571157;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DmkVgGiiuycD3Zkw95qjrssB4Fz//sKvvBksBV1H+/A=;
	b=m7PGxV4Jt8RB/J0GoE0p+H96NePvbihaVNvl7mysg/kHc3p1RxO4rAdGDaQuQJEdJuxM
	 SK7fZqNJtz6UQqhsma7b4Jrxcm2RWqyOuOyY53nKbA4OgTFeCRJ/LyCcwXxyZ4JbTRw8A
	 h1UuRtJ5TYsvwCvgbhWwMSZqLoYDRa5VpGR3lLig+SFOQMGQxy7wuLOZlAy3vjJ10kDmy
	 Hnt2nh4jafp4+eZ6r6Idz4xtJRiHY1//wD9YQ5D48fAn58++ItKwDwE+GDxLHLT57ft2w
	 PZ/jrgB3wPSkiwdR3BFZBRWdZmgeoDzaMzwFTZeFTGAoTMp96Gy8WZmxkrlqKWC/4tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfEQ6o+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A5606A326;
	Wed, 21 Oct 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfEQ6o+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D0B1F000C9;
	Wed, 21 Oct 2026 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792571156;
	bh=DmkVgGiiuycD3Zkw95qjrssB4Fz//sKvvBksBV1H+/A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dfEQ6o+zBP/JJmcuy4xDtVp6NiQLWQegdRBnCcDSCH1IZo5lm05keg0zf7s6WXfvj
	 6g+fVBKcU846gE8OpDkJomltdm7KGfFvAf+UtT8eHs0xzZox4HUXws3bNJqQg3gYBk
	 3uXMCzIyzfh4h+IebMu/8w2wKHhrBb8MhDf3OjaVX26zd7Ikzz1UMET2eHrdTd6/1F
	 8Xnr5nurhP0la9UMSxwC2/fXr91Sf8D2ahmhyLfoOvwXq3zm9CLKFTf6iVmd7y411G
	 Hcu2wYjzMZ2WJA0PEsSs6blPajYLhX6iO5TvsGNLA955bJVuGqY5GdHqcjCVWCEPwz
	 Apnhfr/ll3SGQ==
Subject: Re: [PATCH mptcp-net v4 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 08:25:55 +0000
Message-ID: <179257115537.3133.922491428640838750@kernel.org>
In-Reply-To: <20261019190558.465270-2-w453y.me@gmail.com>
References: <20261019190558.465270-2-w453y.me@gmail.com>
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

- [High] The fix is incomplete, and it adds a regression in a transient
  window.
- [Low] The commit message is inaccurate.

--

mptcp: pm: in-kernel: fullmesh: skip closed subflows

With this commit, fill_remote_addresses_fullmesh() skips subflows that
are closing or in TCP_CLOSE state. The skip applies both when collecting
the remote IDs already in use and when picking remote addresses. The goal
is to let the fullmesh endpoint used by the initial subflow create a new
subflow after it is removed and added back.

> If it was already in TCP_CLOSE,
> e.g. after a reset, it is disconnected and its context is reset: the
> 'closing' flag and the remote ID are cleared, and its remote address
> and port are zeroed. It is then picked as a remote address, with the
> address 0.0.0.0, the port 0 and the ID 0, which also marks the remote
> ID 0 as unavailable.

[Severity: Low]
Is this description of the reset path accurate?

__mptcp_subflow_disconnect() calls tcp_disconnect() and then
mptcp_subflow_ctx_reset(). tcp_disconnect() does:

net/ipv4/tcp.c:tcp_disconnect() {
    ...
	inet->inet_dport = 0;

	inet_bhash2_reset_saddr(sk);
    ...
}

inet_reset_saddr() clears only the source addresses (inet_saddr,
inet_rcv_saddr and the IPv6 equivalents). Nothing here seems to clear
skc_daddr or skc_v6_daddr. So mptcp_remote_address() would return the
peer's real address with port 0 and ID 0, not 0.0.0.0.

The conclusion that remote ID 0 ends up marked unavailable still seems to
hold. Could the message describe the mechanism more precisely?

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
>  	 * already created by incoming ADD_ADDR
>  	 */
>  	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> -	mptcp_for_each_subflow(msk, subflow)
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (mptcp_subflow_is_closed(subflow))
> +			continue;
> +
>  		if (READ_ONCE(subflow->local_id) == local->id)
>  			__set_bit(subflow->remote_id, unavail_id);
> +	}
>  
>  	mptcp_for_each_subflow(msk, subflow) {
> +		if (mptcp_subflow_is_closed(subflow))
> +			continue;
> +
>  		ssk = mptcp_subflow_tcp_sock(subflow);
>  		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
>  		addrs[i].id = READ_ONCE(subflow->remote_id);

[Severity: High]
What happens here if the closed initial subflow was the only subflow
toward the peer's ID 0 address?

In the fullmesh path, this second loop is the only source of remote
candidates. Unlike fill_remote_addr(), it never falls back to the msk's
own remote address:

net/mptcp/pm_kernel.c:fill_remote_addr() {
    ...
	mptcp_remote_address((struct sock_common *)sk, &remote);
    ...
}

So when all such subflows are skipped, fill_remote_addresses_fullmesh()
returns 0. By that point, mptcp_pm_create_subflow_or_signal_addr() has
already consumed the endpoint:

		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
		...
			msk->pm.local_addr_used++;

		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh,
					       addrs, ARRAY_SIZE(addrs));
		if (nr == 0)
			continue;

The endpoint is then never retried for this connection.

This seems to affect two cases.

First, the case in the commit message still looks reachable with a single
fullmesh endpoint. Say the endpoint used by the initial subflow is
removed and added back through mptcp_nl_add_subflow_or_signal_addr(),
which sets mpc_endpoint_id so the local ID maps to 0. If no other live
subflow carries remote ID 0, nr is still 0. The connection then has no
subflow until the msk timeout started in __mptcp_close_ssk() fires.
Before the patch nr was also 0 here. Does that mean the fix is incomplete
for this case?

Second, after a graceful close of the initial subflow, __mptcp_close_ssk()
sets closing = 1, and __mptcp_subflow_disconnect() only does:

	} else {
		tcp_shutdown(ssk, SEND_SHUTDOWN);
	}

In FIN_WAIT1 or FIN_WAIT2, the subflow keeps its real daddr, dport and
remote_id 0. Before this patch, adding a different fullmesh endpoint in
that window created a working subflow to the peer. Now
mptcp_subflow_is_closed() returns true because subflow->closing is set,
so no subflow is created and the endpoint stays consumed. Is this a
regression for that window? It can last as long as the peer does not
send its FIN.

The follow-up selftest seems to cover only the two-endpoint case, where a
second live subflow carries remote ID 0. Neither case above is exercised.

Could the fullmesh path also offer the msk's remote address for ID 0
(still honoring deny_id0), as fill_remote_addr() does, when no live
subflow carries it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019190558.465270-1-w453y.me%40gmail.com
