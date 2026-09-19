Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA7357A3E;
	Sat, 19 Sep 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789805074; cv=none; b=Zsm0UDFXTUAOgZvf7nVwvT+bUUjE8edjZM8dW6Wvtvek4cyJP5nY+ihP+2AlozOdoq8IDMH6LGRYQGMf8Ur6ESArxVah0xqpoY+RqVreQY2Br3Cft1fO/L9G0QGBi069WpDUy5efep7Atlm25YA7j82fzEyMPZIIXQir+/U8tSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789805074; c=relaxed/simple;
	bh=EvHlpgivnDBPjAAAymcIR46sHhOLQzwTTV8L+BIXLPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGO+BwKNt+Gcd7dex53vv3pW8TqZa2uqO/A0y2PkbBoCX/bXU+6kzYqVqYcnscWERRTdT3Dmu22LroF1nQQTYYVxmXLcFJzhrhH0FefoKmdpFgLcNHqSKR1PQh4DeyN+YtBsMdX8VtYHEEVHKvSR1MC28NdbXKhwm8CxMr9Ur1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT5FmWnC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT5FmWnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3381F000FF;
	Sat, 19 Sep 2026 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789805072;
	bh=1A7zgHl0PbBLd/G+UwbWmI0Rmra8zyDI6VGB+cnjPfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fT5FmWnCQH/R4jOAvwjIAtCiR82HrqyVJUdOc8n4B1aNGfnl1DnNFC/0NHthvULGz
	 GoKY8ymNDlmUSj6FEZZAeMDVs5IRtWApb0N066dzm3am1c4mMXVzYTy/f8f+Ama2Bg
	 iNhPmJ8iVCNAXma7VMGdN07UCQf4GvMyFj/5T8JaY8VykSHVvl3nzl0/2BrD8UbS7d
	 5bIrwZdrlOLjrQj+mOX8fEsP8Z79EZxFhTzcMCFpoTqefsIqSwkvnOGU60Af8MvaQ1
	 PH2Jl/NBHoA7/O+0iu5RYgOfbkPuO7VTWciryLK8l6W5Gf+8M1Ma9bJ1OE46/UU4tl
	 +CIPjJuLVUnVw==
Date: Sat, 19 Sep 2026 09:04:28 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, ayush.sawal@chelsio.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, rohitm@chelsio.com,
	stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH] chtls: Fix skb reference leak in chtls_send_reset()
Message-ID: <20260919080428.GX51261@horms.kernel.org>
References: <20260917105846.2147976-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917105846.2147976-1-vulab@iscas.ac.cn>

+ Sabrina

On Thu, Sep 17, 2026 at 10:58:46AM +0000, Wentao Liang wrote:
> chtls_send_reset() is given a skb holding one reference, to be sent as
> CPL_ABORT_REQ. It consumes that reference on every path except the
> TCP_SYN_RECV one: there it sends a TCB field reply built from a freshly
> allocated skb and never releases the passed-in one.
> 
> This leaks the reference taken by reset_listen_child(), which resets
> half-open children in TCP_SYN_RECV found on the SYN queue.
> 
> Release the skb on the TCP_SYN_RECV path as well.
> 
> Fixes: 8ad2a970d201 ("cxgb4/chtls: Fix tid stuck due to wrong update of qid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> index 0e3e5cf52c2c..a363f20452fa 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> @@ -265,12 +265,14 @@ static void chtls_send_reset(struct sock *sk, int mode, struct sk_buff *skb)
>  	chtls_purge_write_queue(sk);
>  
>  	csk_set_flag(csk, CSK_ABORT_SHUTDOWN);
> -	if (sk->sk_state != TCP_SYN_RECV)
> +	if (sk->sk_state != TCP_SYN_RECV) {
>  		chtls_send_abort(sk, mode, skb);
> -	else
> +	} else {
>  		chtls_set_tcb_field_rpl_skb(sk, TCB_T_FLAGS_W,
>  					    TCB_T_FLAGS_V(TCB_T_FLAGS_M), 0,
>  					    TCB_FIELD_COOKIE_TFLAG, 1);
> +		kfree_skb(skb);
> +	}
>  
>  	return;
>  out:

This code change looks reasonable to me.
But the driver was removed in v7.2 by
cdae65fc43f2 ("tls: remove tls_toe and the related driver")
And, as a result it didn't run through our CI.

So while I think it could go to stable
It probably needs more eyes on it.

As an aside, I notice that this driver still appears
in MAINTAINERS in net-next. I will send a patch to remove it.


