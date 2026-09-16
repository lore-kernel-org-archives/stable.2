Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5CE4DA9D6;
	Wed, 16 Sep 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591551; cv=none; b=PGM6EfMJpZc5fTaYotuHfe/YZYZwbWZcke4hLXuz/lgCH/HNaTBy7tcutLuajiwa8sbMLD/bnBL4ayJaikYmmFxAZRdYkMMe2dPy7a6gQGcAqPl4JZht82fWgvBEM8MAlfMdToGWBER634Ol943qmq31s6PAOvZ1WAvPa3wgGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591551; c=relaxed/simple;
	bh=zGv5N28Q3Fuh+0z5UF4wmzmXO9E45q6BaSZkfbNfhsA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAV9hSTgXmoOa/T3e23M3+nvtDgJWoYzQ5Ezn02KGgeTx7dgdPoGubxKEyPE3kCgY6bL1ia/xeUEAYIkDkkBhHpmeqTV4GStKZbB3pJK0fK5nBeIUnfDeX8enQgdXre8L6CyBq5totyqwnsrqXAzmKnKLV52L/8Ux+kGh2JUJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSaIU6CZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSaIU6CZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28DF1F0089A;
	Wed, 16 Sep 2026 20:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591537;
	bh=QtbilFSd1lPNt3KCGiD9EVPlQo3LDxjHZ/yK5Hh1vHo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kSaIU6CZUguBMdke6wYGVGu+GUOw+U9VyY482vGlT3bqCyFTsIxg86GCycNCAdBk7
	 rikjjp54I9rlezyYnKwUQY2wd7+Dg7MnAdXFYwtR0cbowVgf/t21PFaK7O4k94w1AY
	 HdRu3DL8AYvms+U9eHVqyWktSSzs0ZskACHeoHPqG4BNjSRbz1APcxpkUxuXCYMuuN
	 ri17QakmJBxjN1cJP1DfIlJy9Oyn+amVZHA6EFPG3dnRHB2SzZPA88HQB7GQW+TI7Y
	 WssIckt8wZbgU7HZDE3K/AtMFxZmyPartu/3Orm8FKbvcdY7kThMFsCO05CyHZs8bd
	 K7NF2S40xNf9A==
Subject:
 Re: [PATCH net 2/2] mptcp: close race between scheduler and state change
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org,
 shardul.b@mpiricsoftware.com, xinyang@anthropic.com
Date: Wed, 16 Sep 2026 20:45:36 +0000
Message-ID: <178959153630.22033.1222004531183755077@kernel.org>
In-Reply-To:
 <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-2-a257797dd5d0@kernel.org>
References:
 <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-2-a257797dd5d0@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix: the identical `mss_now == 0` divide-by-zero that
  the patch guards in `mptcp_push_release()` (net/mptcp/protocol.c:1667)…

--

mptcp: close race between scheduler and state change

The patch guards the tcp_push() call in mptcp_push_release() with a check
for info->mss_now being non-zero, so that a subflow which failed
transmission (leaving mss_now at 0) is not used for a divide operation.

Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0098e28309318..709610db3ce9d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1664,7 +1664,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  
>  static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
>  {
> -	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
> +	if (info->mss_now)
> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
> +			 info->size_goal);
>  	release_sock(ssk);
>  }

[Severity: High]
Should the same guard also be added to the second tcp_push() call site, in
__mptcp_subflow_push_pending()?

That function starts with a zeroed info:

net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
	struct mptcp_sendmsg_info info = {
		.data_lock_held = true,
	};
	...
	int copied = 0;

and info.mss_now is only ever assigned inside mptcp_sendmsg_frag(), after
the early return the commit message refers to:

	if (unlikely(!__tcp_can_send(ssk)))
		return -EAGAIN;

	/* compute send limit */
	...
	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);

In the non-first iteration, the return value is accumulated into copied
without filtering negatives:

net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
		if (READ_ONCE(subflow->scheduled)) {
			mptcp_subflow_set_scheduled(subflow, false);
			ret = __subflow_push_pending(sk, ssk, &info);
			if (ret <= 0)
				keep_pushing = false;
			copied += ret;
		}

__subflow_push_pending() passes mptcp_sendmsg_frag()'s -EAGAIN through
verbatim when the first frag fails, so copied becomes -EAGAIN, which is
non-zero, while info.mss_now is still 0:

out:
	if (copied) {
		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
			 info.size_goal);

Can that reach the divide the patch is trying to avoid?  With a non-empty
subflow write queue, tcp_push() does not take the autocork early return
(it requires skb->len < size_goal, i.e. skb->len < 0), so it calls
__tcp_push_pending_frames(sk, 0, nonagle), which only bails for TCP_CLOSE.
For FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK it continues into
tcp_write_xmit(sk, 0, ...) and tcp_tso_segs() -> tcp_tso_autosize():

net/ipv4/tcp_output.c:tcp_tso_autosize() {
	return max_t(u32, bytes / mss_now, min_tso_segs);

tcp_set_skb_tso_segs() has the same shape with
DIV_ROUND_UP(skb->len, mss_now).

Is the "scheduled but no longer sendable" state reachable on this path?
mptcp_sched_get_send() returns early without re-validating sendability if
any subflow already has the flag set:

net/mptcp/sched.c:mptcp_sched_get_send() {
	mptcp_for_each_subflow(msk, subflow) {
		if (READ_ONCE(subflow->scheduled))
			return 0;
	}

and __mptcp_subflow_push_pending() itself leaves the flag set on the
subflows it delegates via mptcp_subflow_delegate().  The tree also comments
on leftover flags elsewhere ("there could be left-over scheduled subflows;
clear them all or later xmit could use bad ones"), and
__mptcp_push_pending() already anticipates -EAGAIN together with
FIN_WAIT1/FIN_WAIT2 - which are exactly the states where
__tcp_push_pending_frames() does not bail out.

The entry point with first == false is __mptcp_check_push():

	if (!sock_owned_by_user(sk))
		__mptcp_subflow_push_pending(sk, ssk, false);

reached from ack_update_msk() in net/mptcp/options.c on incoming DSS acks,
so this runs in softirq context on peer-supplied input.

A second, smaller question on the same statement: since copied mixes byte
counts with negative errnos, can a positive count followed by an error that
sums to exactly zero (for example 11 bytes then -EAGAIN) make the
if (copied) test false and skip both the flush and
mptcp_reset_rtx_timer() even though data was queued?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0%40kernel.org
