Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998BC486404
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217391; cv=none; b=KStptBeBDQP/4D9AW1qBCgxiMMCRK04KEEMbfI2tOO5G/+IvDlbe+bxj3FwJQLJQ5Dnr9Cw/kY/1MK+CV9/pKTIFp+ugmi4ITjGRED9K7Ox2Ag6oEO2GonpNtsph9b33fGuyRRECGs0rFaTzpJgNQGd7NzE4kyutCN2D+XOMnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217391; c=relaxed/simple;
	bh=DV/WnWJZuYXFkqv9AoRoznktjcB8DfcZV4QJeraiKN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niGtjWSY3d7fT5zv+AM1FiuI4KUiPXsJw2jNkvqXjFuobmf5qKgb3nRkTKmgMzUdotaCQ9VMhoJGgYIwz5RY8sfyYMNfJX6C5yw7Y2VROHP+hvzfPKjpz44gDtyMnHM4n/H+Otj3t3QIhXcoPJ08TkY0TGmitKeKhS7CWj9VqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeSR5as/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeSR5as/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA831F000FF;
	Mon,  5 Oct 2026 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217390;
	bh=Mda7+yIjIBR3Qqe+VFjoT3FF7oC4qOUUWMYXDMMcUC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UeSR5as/UsIufpyyMXG3LJRC3gTGqixqRApX4dZ9Ad6CEIWNtELgPCa9uT7tBmxYy
	 IVvK6n0WuZDXH9vmErAym6ps+lfobe6cpzMcTo61/SYk2JN64EJXpOOLsG0zQTe7ZI
	 ihJU38JYTTusgZKiuWdSGtsapkj/M2AyVKBGUPuLSE3eCg34u9BblD+2DRdqNNEiAH
	 9FCAY/GGmFnJbqlV56WAvci+101XHe5JFG38363JI9fBQ+/w2H5cNOiwd9g9QKLxH0
	 NqDL0g24b138phAOmWI7yQ/ufDtnF2Yz2dH0zcwFpFTWTBje9P4SrbWx7p8C6VTYVq
	 d2eBrf/PY506g==
Message-ID: <25ffce03-e064-497a-9cbf-8bcbeccf14b7@kernel.org>
Date: Mon, 5 Oct 2026 18:23:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.1.y 2/2] mptcp: prevent race between disconnect() and
 rtx
Content-Language: fr
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
References: <2026091622-thieving-raffle-4915@gregkh>
 <20260917133440.405725-1-sashal@kernel.org>
 <20260917133440.405725-2-sashal@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260917133440.405725-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 17/09/2026 15:34, Sasha Levin wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> [ Upstream commit 85c580b0d8590520ae00a15c29e9fb9c99427a3e ]

Thank you for the backport!

> Sashiko noted that the two event can race, leading to inconsistent
> status. Prevent the race using the synchronous timer stop operation.
> 
> Cc: stable@vger.kernel.org
> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/mptcp/protocol.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 70810fa673c34..3e01ed990cf07 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3267,6 +3267,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
>  
>  static int mptcp_disconnect(struct sock *sk, int flags)
>  {
> +	struct inet_connection_sock *icsk = inet_csk(sk);
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
>  	/* We are on the fastopen error path. We can't call straight into the
> @@ -3279,8 +3280,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
>  	mptcp_check_listen_stop(sk);
>  	inet_sk_state_store(sk, TCP_CLOSE);
>  
> -	mptcp_stop_rtx_timer(sk);
> -	mptcp_stop_tout_timer(sk);
> +	/* The later subflow close can not kick again the tout timer,
> +	 * as the msk is already in closed status.
> +	 */
> +	msk->timer_ival = icsk->icsk_rto_min;

Same here in this version, and also because commit ea4eb2adb0d3 ("mptcp:
honour configured min/max RTO in retransmit paths") is not in this
version, this line should be adapted to:

  msk->timer_ival = TCP_RTO_MIN;

> +	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
> +	icsk->icsk_mtup.probe_timestamp = 0;
> +	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
>  
>  	if (mptcp_sk(sk)->token)
>  		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

