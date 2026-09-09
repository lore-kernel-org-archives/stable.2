Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5C56C63B;
	Wed,  9 Sep 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965379; cv=none; b=pmjb2Fg7242t7G770hEUV6ZbcSZf+q9xuZmiotrhVbkDeP7Lt5v1uUFtg9OH/azqP7fBW5RlCThDcK35m8FJ6xfUg+LddxwYeYtIocTVoFYIV6wMhnwhU0pcywYdZkH9RzTpCiuh3KDPdrc15DdfY/lTBi1aUnrM/ElmHaxcqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965379; c=relaxed/simple;
	bh=cFB8RVVy5cgD840Xmo/6V22yDAA/8kq7daif1EovzRg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ys50Dh1VTdfgz4SxPuCQAcw6b+oLGF4SsIiwZljKstWK7YVJUR7rZiqWV7FPPZlubTJv5re6csop7WxqUmMWZRkeM3y2kVIR0gtzlpdQVQGRNnMCQPINlfTHnLOIadyggMPAK+lDcv4+9Nsktqz1FpyZrZikNZEfDTUzx10Iomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cww3rYjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cww3rYjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D081F00A3D;
	Wed,  9 Sep 2026 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965377;
	bh=q/I33cz2PMyse7XTrTfmsFNdoyHp2PL+ZwacZmjYNUc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cww3rYjvLMQA7Cp2rMwMD4sEqOWbL1oXu/v88Ale/Ck59uHWoiQveI9w1qzxT84Lb
	 s1QtcFBd9l/OP5Tsskvp9Y8d25QW0nbiCbbTQOVMAUN6PhCGDam6caVqKRcHa1zemd
	 6WOZfMkad8lyGw3TB0JWOhuxNihJ62OiYpxH1pjqaXrmDE4DxVrtlll0pejNXHBgvx
	 +atWkln2w5AyFcLErPz/Tf/bFyKYUtinT3kG80lQ4w77dIups4zdA75QZAJpZNBukJ
	 8vOrDC9dM/eIcavW4FnZ264lpgHiO598cHO3tTmZ19IBOzhpPuXhLi9iatczenG1Z6
	 Po4IJvFi8PQVw==
Subject:
 Re: [PATCH net v2 06/15] mptcp: prevent race between disconnect() and rtx
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 09 Sep 2026 14:49:36 +0000
Message-ID: <178896537655.219967.3201901026877077910@kernel.org>
In-Reply-To:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org>
References:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] The commit message of "mptcp: prevent race between disconnect()
  and rtx" describes the change as only "Prevent the race using the…
- [Low] The commit carries "Fixes: b29fcfb54cd7 (\"mptcp: full disconnect
  implementation\")" (v5.18) for a real race that can leave a reused msk…

--

mptcp: prevent race between disconnect() and rtx

This replaces the mptcp_stop_rtx_timer() and mptcp_stop_tout_timer() calls in
mptcp_disconnect() with open-coded sk_stop_timer_sync() calls, so a
concurrently running retransmit timer cannot resurrect state after the
disconnect path has reset it.  No Link: or Closes: tags are present in the
commit header.

A couple of questions below, one about the changelog and one about the tags.

>     mptcp: prevent race between disconnect() and rtx
>     
>     Sashiko noted that the two event can race, leading to inconsistent
>     status. Prevent the race using the synchronous timer stop operation.
>     
>     Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>

[Severity: Low]
The Fixes: tag points at b29fcfb54cd7, which went in during v5.18, and the
race described can leave a reused msk with MPTCP_RETRANSMIT / MPTCP_WORK_RTX
set after mptcp_disconnect() has already cleared msk->flags and msk->cb_flags.

Should this also carry Cc: stable@vger.kernel.org?  Most of the other fixes in
this series do, including "mptcp: do not reschedule the RTX timer for fallback
sockets", whose MPTCP_RTX_ENABLED bit this change relies on so the timer cannot
be re-armed once the socket is in TCP_CLOSE.

Also, the report is credited to "Sashiko" in prose only.  Would it be possible
to add the matching Closes: or Link: tag, the way the sibling commits in the
series do?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index be59651e708e..d611af2eb74f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3588,6 +3588,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk)
>  
>  static int mptcp_disconnect(struct sock *sk, int flags)
>  {
> +	struct inet_connection_sock *icsk = inet_csk(sk);
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
>  	/* We are on the fastopen error path. We can't call straight into the
> @@ -3600,8 +3601,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
>  	mptcp_check_listen_stop(sk);
>  	mptcp_set_state(sk, TCP_CLOSE);
>  
> -	mptcp_stop_rtx_timer(sk);
> -	mptcp_stop_tout_timer(sk);
> +	/* The later subflow close can not kick again the tout timer,
> +	 * as the msk is already in closed status.
> +	 */
> +	msk->timer_ival = icsk->icsk_rto_min;
> +	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
> +	icsk->icsk_mtup.probe_timestamp = 0;
> +	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);

[Severity: Low]
The changelog says the race is prevented "using the synchronous timer stop
operation", which reads like a straight sk_stop_timer() to sk_stop_timer_sync()
swap, but the open-coded version in mptcp_disconnect() also changes two other
pieces of state.  Could the message mention them?

First, msk->timer_ival now ends up as icsk->icsk_rto_min, while the helper it
replaces sets it to zero:

net/mptcp/protocol.c:mptcp_stop_rtx_timer() {
	sk_stop_timer(sk, &sk->mptcp_retransmit_timer);
	mptcp_sk(sk)->timer_ival = 0;
}

The new value is what __mptcp_init_sock() seeds, so it looks intentional and
harmless, and the only reader, mptcp_reset_rtx_timer(), is gated on
MPTCP_RTX_ENABLED which mptcp_set_state(TCP_CLOSE) has just cleared.  Is that
the reasoning?

Second, the tout timer is now stopped and probe_timestamp cleared
unconditionally, whereas the replaced helper bailed out early when
probe_timestamp was already zero:

net/mptcp/protocol.h:mptcp_stop_tout_timer() {
	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
		return;

	sk_stop_timer(sk, &inet_csk(sk)->mptcp_tout_timer);
	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
}

That early return means a tout timer armed only for an MP_FAIL timeout, where
mptcp_reset_tout_timer() left probe_timestamp at zero, stayed pending across
disconnect().  Is that a separate fix folded in here, and would it be worth
calling out in the changelog so stable backporters can see it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6%40kernel.org
