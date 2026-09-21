Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C6495059;
	Mon, 21 Sep 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992828; cv=none; b=WWyeEEslMiY0GM5nfl3w+zFkIR0mIM1Y5oCZCauGNlUd6XLHmWcNm2w+WaTcipMzWXSa/Z+bnPRmk4dmQ21UNHjjBdgFMGKUrlumdvRoh6ijEhw6R5YgcaBLFffRcVtK9+4WvHV10AvcC8OpQTj3gKAcyFSsRdRYk7UuZcZWjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992828; c=relaxed/simple;
	bh=zQdEV/wVpGV9atSmPcDZQWJ7T3Jq2YXPJqci23CkWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJpLjjzT7or97Ws5LTzCaxsFpXRJuROsPYxhwukjIEXWlXev3vsQXDeC/N1RKmYE3i/tu4Wnufso2Q+FPzpuGM/DxfREL7eyrTP/KpriAu6jf0kTlHK4yJiOMCo9/eKXYiJc8VHhd4t7k8XHGCn1NTx8TtNPuL8KWG3iCA29FDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9DBMqBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9DBMqBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB71F00899;
	Mon, 21 Sep 2026 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789992826;
	bh=jbjPXACfg3Ph+2jfXjigx77zokI79x7esDVeVY/UVqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X9DBMqBqnRGzL8DPjw0jNm8NYhQsTbjTy8uJsHhbQO4KmtETjqdSQNxXwtA0Q0dQ3
	 4ufdlnKw0ihdlX+3SzQhgZS7FvRRGJrzNiH5fgt/qZR4P3R2s+NmMArx1RdCx6vtik
	 c8plBG5/SXxQuQgBbNUsv4vu63JU0iGSVkXhTspHnwo6MaYSXxw8Y1MGfrEjVnC3xs
	 Rs0LFTuHMOFTu8bQSUT2ohSVg5Ba2Bdp+FbB/wHdtV4Y4FDEczyRhwsQQN784keFvm
	 jhHFnMM0AZ++K+3R3IWeN43EbIkCAaCjSqaYsXu4hhrTB0y422B/nHy2FH0EZhpBoU
	 +SlEik4MqzQMw==
Date: Mon, 21 Sep 2026 13:13:42 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
	ayush.sawal@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, rohitm@chelsio.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] chtls: Fix skb reference leak in chtls_send_reset()
Message-ID: <20260921121342.GL13925@horms.kernel.org>
References: <20260917105846.2147976-1-vulab@iscas.ac.cn>
 <20260919080428.GX51261@horms.kernel.org>
 <arAJCMpzSVKDiLqe@krikkit>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arAJCMpzSVKDiLqe@krikkit>

On Sun, Sep 20, 2026 at 06:25:44PM +0200, Sabrina Dubroca wrote:
> 2026-09-19, 09:04:28 +0100, Simon Horman wrote:
> > > diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> > > index 0e3e5cf52c2c..a363f20452fa 100644
> > > --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> > > +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> > > @@ -265,12 +265,14 @@ static void chtls_send_reset(struct sock *sk, int mode, struct sk_buff *skb)
> > >  	chtls_purge_write_queue(sk);
> > >  
> > >  	csk_set_flag(csk, CSK_ABORT_SHUTDOWN);
> > > -	if (sk->sk_state != TCP_SYN_RECV)
> > > +	if (sk->sk_state != TCP_SYN_RECV) {
> > >  		chtls_send_abort(sk, mode, skb);
> > > -	else
> > > +	} else {
> > >  		chtls_set_tcb_field_rpl_skb(sk, TCB_T_FLAGS_W,
> > >  					    TCB_T_FLAGS_V(TCB_T_FLAGS_M), 0,
> > >  					    TCB_FIELD_COOKIE_TFLAG, 1);
> > > +		kfree_skb(skb);
> > > +	}
> > >  
> > >  	return;
> > >  out:
> > 
> > This code change looks reasonable to me.
> > But the driver was removed in v7.2 by
> > cdae65fc43f2 ("tls: remove tls_toe and the related driver")
> > And, as a result it didn't run through our CI.
> > 
> > So while I think it could go to stable
> > It probably needs more eyes on it.
> 
> But there isn't anyone around that has even a remote understanding of
> what this driver does... Since stable@ seems willing to take patches
> that remove broken features [1], maybe we should just do that?

Sure, that would address my concern regarding how to handle this quite nicely.

> 
> [1] https://lore.kernel.org/netdev/apbqjuv6l20bTjQI@laps/
> 
> -- 
> Sabrina
