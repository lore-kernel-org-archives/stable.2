Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EEC3F105D;
	Wed,  9 Sep 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965375; cv=none; b=iRj4zYvAYtdNPl81N1UKm40EDpdfh7nEbq8nB+LkC+gBbKnudSAmqsYh7bciYuKLzYN5c3NTYc056jgdCbF2gN0s77rJ46rjzdvFQdvr/C4ARsJMbAxdY0YEAXpUh2cnZ2DUiulKs0sL6sBM+suIZJupyI0k7EheyawFM2Bk0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965375; c=relaxed/simple;
	bh=KbJPTvDwfx+oaqKliKQAuSmQ2LLLFMJ0hExBKjns60Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8F1l2rDATYtlWkN19gUEFMyxyI06fzmrhQzYDRxLWxn+HEKoPrbZjZKQSAgZLVbEGnBSpYmLehFXScFKt6wP6VQvYZZJ2858q4GwZAzdtir7HDRrT6GPB9ewL9CqPiCEOISWQbFityulf5SgF+Nwa2+MQaSFXYcIwcrPlxSKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir2WMG12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir2WMG12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105631F00A3A;
	Wed,  9 Sep 2026 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965373;
	bh=JUje0iI/j0iucNUCKxR+9jAlnVFk+YFTsDogvSdD9Qo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ir2WMG12+UAf9FIz1+63Thg+f9Es+hrNF3O43Hix7rWB/gMMntBOpS495snVzancc
	 dtp5c8rohH20Ylg0bYhp3UrcSGMaEi1pcGItWvIZAprfexgRAOpeSqJDwXKrA6OIIm
	 YXBVmD5Z/VEQ7135K0pIEDzdapBqe91iFVtlI0s6BAzjj52t3INFhkSWuMK5NjkpuE
	 0H/CDs38YKEhYPnxUzzxE+3sV3APPwsPiZ/cMHEXEKS979gJjc/YtDFkwkYffHIqC3
	 M4tRmLJ9lIm9lZBVD+QR+R6ym01LD9Z7EccQRPVSILE/RH4n3uGHx1ynk6IiuQx86m
	 +MvwLDnz0O5Tw==
Subject: Re: [PATCH net v2 01/15] mptcp: do not reschedule the RTX timer for
 fallback sockets
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 09 Sep 2026 14:49:32 +0000
Message-ID: <178896537258.219967.9085177988970978054@kernel.org>
In-Reply-To:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-1-df1de70348b6@kernel.org>
References:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-1-df1de70348b6@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete gate: mptcp_connect() (net/mptcp/protocol.c:4149)
  unconditionally does set_bit(MPTCP_RTX_ENABLED, &msk->flags) before…

--

mptcp: do not reschedule the RTX timer for fallback sockets

This adds a new MPTCP_RTX_ENABLED flag bit so that mptcp_reset_rtx_timer()
only arms the MPTCP retransmission timer while the msk has not fallen back
to plain TCP and is not closed.  The bit is set in mptcp_connect() and
mptcp_listen(), and cleared on fallback and on the transition to TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e1f08f71cdb1..be59651e708e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -95,6 +95,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
>  
>  	msk->allow_subflows = false;
>  	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> +	clear_bit(MPTCP_RTX_ENABLED, &msk->flags);
>  	__MPTCP_INC_STATS(net, fb_mib);
>  	spin_unlock_bh(&msk->fallback_lock);
>  	return true;
> @@ -1084,13 +1085,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
>  
>  static void mptcp_reset_rtx_timer(struct sock *sk)
>  {
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  	unsigned long tout;
>  
> -	/* prevent rescheduling on close */
> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
> +	/* Prevent rescheduling on close and in case of fallback. */
> +	if (!test_bit(MPTCP_RTX_ENABLED, &msk->flags))
>  		return;
>  
> -	tout = mptcp_sk(sk)->timer_ival;
> +	tout = msk->timer_ival;
>  	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
>  }
>  

[ ... ]

> @@ -4141,6 +4146,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	if (IS_ERR(ssk))
>  		return PTR_ERR(ssk);
>  
> +	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
>  	mptcp_set_state(sk, TCP_SYN_SENT);
>  	subflow = mptcp_subflow_ctx(ssk);

[Severity: Medium]
Can this set_bit() re-enable the RTX timer on a msk that is already in
fallback?  It runs unconditionally, before any of the fallback checks below
it, and the fallback state is sticky across a failed connect().

Sequence that seems reachable from userspace on its own fd:

1) First connect(): mptcp_active_should_disable() is true (or
   mptcp_token_new_connect() fails), so mptcp_connect() calls
   mptcp_early_fallback() -> __mptcp_try_fallback(), which sets
   MPTCP_FALLBACK_DONE, clears MPTCP_RTX_ENABLED and leaves
   subflow->request_mptcp == 0.

2) ssk->sk_prot->connect() fails immediately (for instance -EAFNOSUPPORT on
   a bad sin_family, or -ENETUNREACH from the route lookup), so
   mptcp_connect() takes:

	if (unlikely(err)) {
		/* avoid leaving a dangling token in an unconnected socket */
		mptcp_token_destroy(msk);
		mptcp_set_state(sk, TCP_CLOSE);
		return err;
	}

   MPTCP_RTX_ENABLED is cleared again by the TCP_CLOSE transition, but
   MPTCP_FALLBACK_DONE stays set.

3) __inet_stream_connect() returns the error directly:

	err = sk->sk_prot->connect(sk, uaddr, addr_len);
	if (err < 0)
		goto out;

   so sk->sk_prot->disconnect() (mptcp_disconnect(), which does
   WRITE_ONCE(msk->flags, 0)) is never called, and the socket stays
   SS_UNCONNECTED with sk_state == TCP_CLOSE.

4) Userspace calls connect() again.  mptcp_connect() sets
   MPTCP_RTX_ENABLED unconditionally, and since request_mptcp is already 0
   the fallback branches are skipped.  Even if mptcp_early_fallback() were
   reached, __mptcp_try_fallback() returns early at:

	if (__mptcp_check_fallback(msk))
		return true;

   before the new clear_bit(MPTCP_RTX_ENABLED, ...).

The result is a live fallback msk with MPTCP_RTX_ENABLED set, so
mptcp_reset_rtx_timer() passes the new gate and the send paths
(__mptcp_push_pending() and friends) arm the MPTCP RTX timer just as they
did before the patch:

		if (!mptcp_rtx_timer_pending(sk))
			mptcp_reset_rtx_timer(sk);

Would gating the set_bit() on !__mptcp_check_fallback(msk), or moving it
below the early-fallback checks, close this case and also make the new
comment "Prevent rescheduling on close and in case of fallback" hold for a
msk whose fallback predates the current connect()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6%40kernel.org
