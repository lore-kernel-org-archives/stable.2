Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C5418359;
	Wed, 23 Sep 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157730; cv=none; b=Bz8nStkmpRpoQLWJm2BoOPSnlGiIsQoFDLk2yN/r75PqegKzNbxD1jsE9LfbXVeVq8GBkiU/7TIwZbKNdgqRM7Rfew0kBZszYWwA/0plsd0btgj75wSL7sEIa+BWVvqCIMdD5w2vrL7m4VTDEPFs+kjxwWegRaXS5H+bvYJbIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157730; c=relaxed/simple;
	bh=tzxNDo5WXeyFlkwCcrqIZsB7nM08Rjkb98kddmjCJIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXQ4jzBb98JRGby9iel9uJr8/AL0OWDAH3QqcoQr/QLYe+oRSxrSsC485I4tQfo6WWeaBVHWfadBuSyp0ypoIfQPsnYhMP5R6csedDZDvOT58sBjUh/QZ09M5xwhQLdLzyvFMAoZXObq3wMn1XUbM1Tn1tEsK96Ml9EsCrc4Y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JYBK0Vz1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U4Aq31uQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JYBK0Vz1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U4Aq31uQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AA808EC009E;
	Wed, 23 Sep 2026 06:02:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 06:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790157724; x=
	1790244124; bh=H80tOJHy4q1eeGSRenOM710KaE3KyyTLuy/1fN88C/Q=; b=J
	YBK0Vz1sQwuDMhq6mjDMOphWcg2yR1pZ8tlOfEJer/eDnUmC0uubt0VqlA4gJE8x
	Zzutv/6zXyKwOSkKXElT4sM9lw7E5gVlk824j8wZS19RbJnH/eLMBRDCKQ+eqoev
	t6fULelANX8Ht1qGdlQcuV05PanAHWKxUMmhGYe9xsJkQ5/7nnn2A6Kzpw/Hx5Ex
	3lAfFWeLjloP9dV0BM6HDbwt7yu5GfNt7NyRKmT0O8LWInyp89885f5B0o3aMxNT
	KgQ+sFQsM6GQirdJw2E+OzjRodGXE/o/nb9G+b5DeLzrLoQPLG7DlIhjANc4kAyM
	8VMwxioWiSDT54aIFPhRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790157724; x=1790244124; bh=H80tOJHy4q1eeGSRenOM710KaE3KyyTLuy/
	1fN88C/Q=; b=U4Aq31uQLExV51+j0mwPxGAKqIXZbS4p/wfu5vPyqwb2ccA2LYQ
	ECf3Hz+feTDAV9WDHLUf814hs/QkMrxYdw3irN0OgQlj5UEicfjRqwh8iWUz+9z9
	5WtierrCSnXcBC7xYMdvGMwG4XdWKJiLFwRPtUR0QDP5DeLCFQFtsT/0XcMVDkS/
	wvz9d4qc+uHltGqk+WgNOE2/PpUDR9S0/QdyexefzI0hFZXfG85S8c1C4uvGpnMl
	jihyMDe9NRBpICaDjoJ5jexhIc5JJjniQZXAOPbTFQlqMDdxZ4JK8+ME0jtQm3Le
	nZIv4FrNAAc+1u9iqMyPwiX5w2wIdRepsgg==
X-ME-Sender: <xms:m6Ozap00IpgOP_xADoB1B29NbCLRBEUenaA8F99MgZQAjKjonbTjLg>
    <xme:m6OzatdMr4Qce08WbjsDUsxtA6URbNvHeFbD_D2-Zc_s1ibBG2kEoRNpSCjnTfYvK
    GfxQVof_zibGnFZhP_qe7FEnzDo-zOKW9s9WitbjdbQcn_zZO1reJ9a>
X-ME-Received: <xmr:m6OzahNZ4x5OxmWYYiAEt0H_7xd4YH3H7vo0nIZ8CWQhbt_o7dujx644UYL_>
X-ME-Proxy-Cause: dmFkZTFiHfcEiDDCQlKtF8UR98//XytAmN53V5AmNTFQjW+/2EjtueZdX89+sGhx5GnqbZ
    ajG7KOseg8FLGDnKaf6vbmYtCra8UO1CovbJRw1meTkrZo47OExRcjVvQRfhgNhYr29+Ix
    GH/o2nX/rU1BBsApo650C/1R1HrcLjfOPHKqLoDwnjsRmKapN+p61ztEKxEbMqd8bSy3rI
    YIV7Xuf9MsitY/pRpLRUcaBB8avvNUGWMiZlaq4wxt63eOEMBWJYJyESWTd6VUC/N//zQD
    ZKN8NMv+O4T+NC4C9BY4bYKdOYbW7DR38azwAVMzIQj7BJShYpaaCBlPe44sLKlcxI0YLp
    gH4MC695JD6U13aRMwCFv84F9qndxXuyiascGEKx2LgFXA+DpgtyogesCdCX/xFUXtpfNY
    WPdNVW06dcYEPfKyYQ93KnD7dZDMpzD0+/OfzLMkD8qhFeZ4JXVOkbrCf/CkTYb0ue64SZ
    u/eeRSoA0OGa27q5+K8u3FIfR9OOCa93NgjZ+Q6/el0WoYT4rrWViv7E8B6mNHoBj+SW1j
    90G4yL7soEGjH/rlclltyKZnmnkdkwcJHm3H7NeLg/qW5dbElu7ONall3qFulKa6gHaj71
    RSrsnDhMJ96zfufV836VUQX/4exoRckzBZlyJfBud48ftSOUNfITH8e4H2ng
X-ME-Proxy: <xmx:nKOzahVoGJQbDd1T9utcu-X8MNimL_vrfNTfQ1JQTYsI9jBOBnCF1w>
    <xmx:nKOzapw_teePWsVSluKsM_UYnybxjnfISntPEwfGxnjOREjV4vmyxA>
    <xmx:nKOzao__nPRM1H1j0BP5lRMiEj1Sb7RnSq7w6pXAdNpvd2KIHlgQ_g>
    <xmx:nKOzau_PvzCd0dwya9qvzvJEukufCvj-wZ0rkKP74RYsOos-ZAIhEw>
    <xmx:nKOzah1Hr54MCWNExRAR64oNNXfFxIfm71pIHMqxFU4hQuziDpWqDwW6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 06:02:03 -0400 (EDT)
Date: Wed, 23 Sep 2026 12:02:01 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Bruno Produit <bruno.produit@trailofbits.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfrm: espintcp: build sk_msg locally before publishing
Message-ID: <arOjmbAt_ctmnB9S@krikkit>
References: <20260922145335.2016559-1-bruno.produit@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922145335.2016559-1-bruno.produit@trailofbits.com>

2026-09-22, 16:53:35 +0200, Bruno Produit wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> espintcp_sendmsg() builds a new message directly in ctx->partial. If
> allocation fails, sk_stream_wait_memory() drops the socket lock while
> the shared sk_msg remains unpublished with emsg->len equal to zero. A
> concurrent sender can then reuse the same slot. If the first sender is

Could we add an ->owned flag to emsg to make the other sender
wait/abort when the flag is set (whether the emsg has been fully set
up or not)?

If not, comments below.

> interrupted, its failure path frees state now owned by the second sender
> while TCP may still be consuming it, causing a use-after-free.
> 
> Construct the message in a call-local sk_msg instead.


> After allocation
> and any lock-dropping wait, recheck that the shared partial slot is still
> free, then transfer the completed message into it. Failure cleanup
> consequently releases only state owned by the current call.

Please don't describe what the patch does. We can read the code.

> The recheck
> also covers packets submitted through the common IPv4 and IPv6
> espintcp_push_skb() path.

I have no idea what this means.


> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index 674aedc..1642b34 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -311,6 +311,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	struct espintcp_msg *emsg = &ctx->partial;
>  	struct iov_iter pfx_iter;
>  	struct kvec pfx_iov = {};
> +	struct sk_msg *skmsg;

nit: reverse xmas tree ordering

>  	size_t msglen = size + 2;
>  	char buf[2] = {0};
>  	int err, end;
> @@ -324,6 +325,11 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	if (msg->msg_controllen)
>  		return -EOPNOTSUPP;
>  
> +	skmsg = kmalloc_obj(*skmsg);
> +	if (!skmsg)
> +		return -ENOMEM;
> +	sk_msg_init(skmsg);

Why do that before trying (and possibly failing) to push the pending
message?

>  	lock_sock(sk);
>  
>  	err = espintcp_push_msgs(sk, msg->msg_flags & MSG_DONTWAIT);
> @@ -337,10 +343,9 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  		goto unlock;
>  	}
>  
> -	sk_msg_init(&emsg->skmsg);
>  	while (1) {
>  		/* only -ENOMEM is possible since we don't coalesce */
> -		err = sk_msg_alloc(sk, &emsg->skmsg, msglen, 0);
> +		err = sk_msg_alloc(sk, skmsg, msglen, 0);
>  		if (!err)
>  			break;
>  
> @@ -348,25 +353,30 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  		if (err)
>  			goto fail;
>  	}
> +	if (emsg->len) {
> +		err = -ENOBUFS;
> +		goto fail;
> +	}

Do another espintcp_push_msgs before giving up?

And there should be a comment here to explain why we need to recheck
emsg->len even though we already did at the top (something like "we
may have dropped the lock in sk_stream_wait_memory, check if someone
else used the emsg").

-- 
Sabrina
