Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA444582E6;
	Wed, 14 Oct 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988347; cv=none; b=asK54+fN1Y5YcEK3WaNf1Jv8/RBocM7N7x21f4vcGXWAyNqob8qHIwSFskwEOg0uvHGQsW6bRQZCEFtbiSarmLarSprrS/0Xj0q0DCz80xNHJ2aryLK/tMvemtzeqpBV5Hd3DiCUDdQ2RM/BdHkTjl5iEGCIVEHJ2u35467wrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988347; c=relaxed/simple;
	bh=rj4lErnJHXIRIvroMbe0dJX309uvoO0iMQDmNA553Vo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGHu3HMe7zyP7+lXB1OgUkxyke9Pjix3+8tqEXRaYbNjTSSKtgJ5/eCLcuAmhakHxZeUkKQsG2tuHzNJGahskVIpkUNCEt8XUj+Gq72maAw7Aj1EjIWHMAN0i2G9E3IEyV/UHwGv7GrN16rHuHpz23SniwFk6gb9cMPkNnIFsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/KWiWcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/KWiWcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548321F000C4;
	Wed, 14 Oct 2026 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988346;
	bh=nukyvaoE+wwPX/0XUeM7v+OP9T1JnMHkgJf8D7qR3AY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e/KWiWcc+nZT7+U9WYB8P4t1HgHnH1KGLHE3y6BuWDP57l5zlNamthA77oB1zoFdu
	 jXmru81ln6ZkgBoLfbtbzd0I0iQFwTpjxMxvfEGZQgVnh5/ddA3aSpWqGZRZ0SMkTp
	 C3cj9dfLwhNG5U6pZJ4OsE/rOm01I/WV+36nr5hZOxvSXRl3ZPxjEijHZygdwDfeHb
	 daBRBR/WLP0hPxowDvx1ZrJxI8+WFwQd0A7ZiaZpEiymnEF8KvPGyfb3ppNWaBpB1I
	 nOqf8FcFJstJ2+7TWscERtNTSCcRDjcuWwMfCBn8Qw/W1bLPLT+5ui+1FSPiKFHTCa
	 4zzhUYcFuFLCg==
Subject: Re: [PATCH net 1/4] mptcp: reset msk state on early connect failure
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 caoruide123@gmail.com, stable@vger.kernel.org, vega@nebusec.ai,
 sashiko-bot@kernel.org, weir@nebusec.ai, kuniyu@google.com,
 daniel@iogearbox.net, kafai@fb.com
Date: Wed, 14 Oct 2026 14:32:24 +0000
Message-ID: <179198834484.434549.4616694240552704738@kernel.org>
In-Reply-To:
 <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-1-932c9b182fc7@kernel.org>
References:
 <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-1-932c9b182fc7@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new error path in mptcp_connect()
  (net/mptcp/protocol.c:4224) calls…

--

mptcp: reset msk state on early connect failure

This commit changes the mptcp_connect() error path. It now clears the
fallback state (MPTCP_FALLBACK_DONE, allow_subflows,
allow_infinite_fallback) and resets the first subflow context. The goal
is that a later connect() on the same fd can use MPTCP again after an
early fallback followed by an immediate connect failure.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e89a69ab927c9..e6f73a5ee630a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4212,9 +4212,16 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	 * subflow_finish_connect()
>  	 */
>  	if (unlikely(err)) {
> -		/* avoid leaving a dangling token in an unconnected socket */
>  		mptcp_token_destroy(msk);
>  		mptcp_set_state(sk, TCP_CLOSE);
> +
> +		spin_lock_bh(&msk->fallback_lock);
> +		msk->allow_subflows = true;
> +		msk->allow_infinite_fallback = true;
> +		clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> +		spin_unlock_bh(&msk->fallback_lock);
> +
> +		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));

[Severity: Medium]
Is mptcp_subflow_ctx_reset() resetting more than this path needs? It
clears the whole reset group and then sets local_id to -1:

net/mptcp/protocol.h:mptcp_subflow_ctx_reset() {
	memset(&subflow->reset, 0, sizeof(subflow->reset));
	subflow->request_mptcp = 1;
	WRITE_ONCE(subflow->local_id, -1);
}

This also wipes two values that are set only once, when msk->first is
created:

net/mptcp/protocol.c:__mptcp_socket_create() {
    ...
	subflow->subflow_id = msk->subflow_id++;

	/* This is the first subflow, always with id 0 */
	WRITE_ONCE(subflow->local_id, 0);
    ...
}

A second connect() gets the same msk->first back from __mptcp_nmpc_sk(),
so this setup does not run again. The reset also runs on every immediate
failure (ENETUNREACH, EAFNOSUPPORT, BPF pre_connect, ...), not only after
an early fallback.

On the retry, local_id is -1, so the connect goes through:

tcp_connect()
  subflow_rebuild_header()
    subflow_chk_local_id()
      mptcp_pm_get_local_id()

mptcp_pm_get_local_id() returns 0 only when the msk local address matches
the subflow's address:

	mptcp_local_address((struct sock_common *)msk, &msk_local);
	mptcp_local_address((struct sock_common *)skc, &skc_local.addr);
	if (mptcp_addresses_equal(&msk_local, &skc_local.addr, false))
		return 0;

mptcp_copy_inaddrs() runs only after a successful connect. For an unbound
msk, the msk address is therefore still zero at this point.

Wouldn't the kernel PM then give the MPC subflow a non-zero ID, either
from a matching endpoint or by adding an IMPLICIT endpoint to the netns
endp_list?

If the endpoint table is full, mptcp_pm_nl_get_local_id() returns -ERANGE.
tcp_connect() would then fail the retry with -EHOSTUNREACH, even though a
valid route exists.

A non-zero local_id on the initial subflow also seems to break endpoint
removal. When that endpoint is deleted,
mptcp_nl_remove_subflow_and_signal_addr() gets the ID from
mptcp_endp_get_local_id(), which returns rm_id 0 for the MPC endpoint.
mptcp_pm_rm_addr_or_subflow() then skips the initial subflow because
id != rm_id, so the initial subflow is never closed.

The reset also zeroes subflow_id, while msk->subflow_id has already
advanced to 2. After a successful retry, mptcp_get_full_info() would
report the first subflow with id 0:

	sfinfo.id = subflow->subflow_id;

But tools/testing/selftests/net/mptcp/mptcp_sockopt.c expects:

	assert(sfinfo[0].id == 1);

mptcp_disconnect() already behaves this way for subflow_id. The local_id
part looks new, though: on the disconnect path, the msk still holds the
addresses from the earlier successful connect.

The commit message mentions only MPTCP_FALLBACK_DONE, allow_subflows and
request_mptcp. Would it work to reset only request_mptcp here (plus the
token and key fields if needed)? Another option would be to restore
local_id to 0 and keep the original subflow_id for msk->first after
mptcp_subflow_ctx_reset().

>  		return err;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7%40kernel.org
