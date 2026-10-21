Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569523;
	b=mR1EO9jdohXEr7G8wLDAIOjdTpB3fqel5NnjP4L3KMmp+juaXRjCtJ4aQJXlBcO3VZLg
	 n2dQwSEdBi8FcD8R4qDApbQ1/OjPGsQ/REIG9K/Dr0iwDroiAR5TGVPhCWuw3j74DHLtr
	 os4AEYRFR4Q1rgqPpEW1E8qCMcnDspM1hCS6JtfSecjquecziyBWg3zjzFYUNsic92vHm
	 oLR+x77azmn2rcCEuyl0DamEsWJgifyMdMbmci2HhQ3VerAhb3RgOTL5kSOLeeK73zCc0
	 FsLEk07x9WbX6emOZ4ZzcYlURC9WQqkBokPSd/p3S6vFVL2zjRpQlhPIXVifK1pm3tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569523;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BEuFq2ZcpG6Qdjoo7J4mwss9klL99ylXE8HIyWM0L5s=;
	b=HCnIueBTfNmoID/3wUfyLP/RMVGnpByvP8SbRICtyNeHUw/Twj/su+gO1TPr8GFzyQ2J
	 39zcxd8VSnybGGkKHqLhDbYaztE7HMmkSAiuXoaKYHGgrpmj7n7GGezbsAHDYRsapln/9
	 om4Te7gOkChStvSHlh4LRmEZKHhhnzpVXORh4wuMejpTnZd1EfAlvGiI/s/pTp5S/TC5F
	 742UubsIYLindlePFX4MCYPOtMFgDiEk0cItRiCtbEhFHxSL8mJwsYE55KEWdbOwtQAp/
	 zIQiT+oxrBccrkuj1hjhyNuVikQVHbKp2yKziEiPp/S9tlbAgl3fBi7aGdnXy5Yz3qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwJzQ8vD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7F606A319;
	Wed, 21 Oct 2026 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwJzQ8vD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD8E1F000C9;
	Wed, 21 Oct 2026 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792569522;
	bh=BEuFq2ZcpG6Qdjoo7J4mwss9klL99ylXE8HIyWM0L5s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WwJzQ8vDPGdobhAZArrpAecTmZYHDzNkn00neUcZg8d6l/+av5LOJnv5P1aSTTSjM
	 9AetIAzqDmADrZ+fTKziRVfRgtEtqq2dCiVnh4qqWooYjBjrOMsXIWnof8wX9yHRPn
	 GYPcmjJuIFcnTT7ewD+jT00Rjae073lNmJVq96g5x4krE0dKc8nnxWAGc2DE0+7irJ
	 Wj2ASt+VK/1EEKqvIJDGJYjA2sxm/c9Bm7SdA4Vb1cUu2XObAXNU2EgUN+S77GIY/G
	 lKw69subrdZVpV2geBOiPUKmGDO0Kalh2x+Rfq8BEicB1kbFeAZKWLH/QH1+/yiwGF
	 buGX1hDUyI84g==
Subject: Re: [PATCH mptcp-net v3 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 21 Oct 2026 07:58:41 +0000
Message-ID: <179256952141.3133.6790903548691772660@kernel.org>
In-Reply-To: <20261019185512.458313-2-w453y.me@gmail.com>
References: <20261019185512.458313-2-w453y.me@gmail.com>
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

- [High] After this patch, fill_remote_addresses_fullmesh()
  (net/mptcp/pm_kernel.c:229-239) skips the retained initial subflow in…
- [Low] The commit message's account of the reset case is wrong about the
  remote address.

--

mptcp: pm: in-kernel: fullmesh: skip closed subflows

This patch makes fill_remote_addresses_fullmesh() skip subflows that are
closing or in TCP_CLOSE. They are skipped both when building the unavail_id
bitmap and when picking remote addresses. The goal is to let a re-added
fullmesh endpoint, used by the initial subflow, create a new subflow again.

> If it was already in TCP_CLOSE,
> e.g. after a reset, it is disconnected and its context is reset: the
> 'closing' flag and the remote ID are cleared, and its remote address
> and port are zeroed. It is then picked as a remote address, with the
> address 0.0.0.0, the port 0 and the ID 0, which also marks the remote
> ID 0 as unavailable.

[Severity: Low]
Is the part about the remote address being zeroed accurate?

__mptcp_subflow_disconnect() calls tcp_disconnect() and then
mptcp_subflow_ctx_reset(). tcp_disconnect() only clears the destination
port and the local source address:

net/ipv4/tcp.c:tcp_disconnect() {
    ...
	inet->inet_dport = 0;

	inet_bhash2_reset_saddr(sk);
    ...
}

That path ends in inet_reset_saddr(), which only clears inet_saddr,
inet_rcv_saddr, np->saddr and sk_v6_rcv_saddr. It does not touch
skc_daddr or skc_v6_daddr. mptcp_subflow_ctx_reset() only resets the
subflow context, not the TCP socket addresses.

So in the old code, mptcp_remote_address() would read the original peer
address with port 0 and ID 0, not 0.0.0.0. The conclusion about remote
ID 0 still holds.

Could the description say that only the port is zeroed?

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 1a7750813235..24cdb170ba62 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

[ ... ]

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

[Severity: High]
Once the closed initial subflow is skipped here, what provides the peer's
initial address (remote ID 0) when no other live subflow points to it?

__mptcp_close_ssk() unlinks every closed subflow except msk->first:

	dispose_it = msk->free_first || ssk != msk->first;
	if (dispose_it)
		list_del(&subflow->node);

After the initial subflow closes, the only other place a remote ID 0
candidate can come from is a live subflow to the peer's initial address.
fill_remote_addr() falls back to mptcp_remote_address() on the msk. This
fullmesh path has no such fallback.

When this loop finds nothing, mptcp_pm_create_subflow_or_signal_addr()
has already marked the endpoint as used:

		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
		...
		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh,
					       addrs, ARRAY_SIZE(addrs));
		if (nr == 0)
			continue;

The endpoint is then not retried for this msk.

The first case looks like the scenario the commit message describes. Take
a client with a single fullmesh endpoint A and a server with one address.
Removing A gracefully closes the first subflow: closing is set and the msk
stays established. Re-adding A maps it to local ID 0 through
mptcp_nl_add_subflow_or_signal_addr(). Both loops then skip the only
conn_list entry, and nr is 0.

Doesn't this still match the case the patch is meant to fix?

  "if the endpoint used by the initial subflow is removed and then
  added back, no new subflow is created from it"

Without the fullmesh flag, fill_remote_addr() still creates A->S in the
same steps. Selftests that keep a second endpoint (such as 10.0.2.2) with
a live subflow to remote ID 0 would not cover this case.

The second case covers endpoints that used to work. After a graceful
close, the first subflow keeps daddr, dport, remote_id 0 and local_id 0.
tcp_shutdown() does not reset them, and the later mptcp_close_ssk()
returns early on close_event_done.

Before this patch, take a new fullmesh endpoint C with a non-zero ID, for
example when an endpoint is removed and a new one is added. The first
loop would not mark ID 0, because local_id 0 != C's ID. The second loop
would then pick that entry, so C->S was created.

With this patch the entry is skipped, nr is 0 and C never connects. Is
this a regression? The connection would have no usable subflow until the
MPTCP close timeout.

Could the msk-level remote address be added as an ID 0 candidate when ID
0 is not set in unavail_id and deny_id0 is false? That should still
respect an RM_ADDR for ID 0 from the peer. If not, could the claim in the
commit message be narrowed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019185512.458313-1-w453y.me%40gmail.com
