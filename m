Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43762D7DF1;
	Sun, 20 Sep 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921552; cv=none; b=jXCYnxfaFtInggBEAX5o8pCArTWo7cTdaxnxgmBaVFfbJjvJqR6xkoj+kU3z/k74jD0hh4qyptJQPlN3bkq211FgadGRj2uamd+B+pIzC51VTMwchAQ/7Qf9UuWvgwZn/iMO7XMyLxrZqzu/yy3VkrnKFaeiLZzuSzQJW3CSJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921552; c=relaxed/simple;
	bh=d2MlFTveKjxRY0wtc80I6nUBdByXe0KUB2Rgx7U+510=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP8rmFw5sxVuaZz2X3wVZ97rmV9PVCJhlb+SGFH2bfM85FtXKcehzBJffZ0uOFfB4X//p/zdI2IhLoOEsb2lCcYNP46ukbV5QQPuJlF9antr/X6BxxLAh3SMPk8+8vNK2nA8QCvY2VvrctfLCIBn2+TbDBFc38pLGfOKR3uQoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ngK05mlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5yv9gV8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ngK05mlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5yv9gV8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 85E1A1D000FB;
	Sun, 20 Sep 2026 12:25:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 20 Sep 2026 12:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789921548; x=
	1790007948; bh=uKa0UKRyOFRFPJ9hTIM9DrO+qTY1MbP0REohWq4oE+c=; b=n
	gK05mlow/6hS7w3yfog4jJ0JMljkkYA/6IHouBPRXPCFFN6jRQKR4Yo549vKfX6v
	N6Jg65G9pga8FrHRhtIFAGBj+GIf6fPYtMrSZQS23ZH70FaodbCw0B6jd6JIPvHO
	jeIPlzvo8fbo8mf0HAg5/stgm0exXYRa06Kd7SFhRpoPfkRN60ayWsXwNIqvHV83
	pYRTmlQ3EWJBU22TFy+Ru2vkGjaHYRqZoa+xC4HNiuTW/Y2uTDSkRq04xhcoNhYn
	FuqLZj1iO7x68RZAA3G87lEMBIfOGnp+3HWSGfSNpUTUD23/cvtlue4fGayKfE09
	OjMi5hRbdyTbV8pySMoRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789921548; x=1790007948; bh=uKa0UKRyOFRFPJ9hTIM9DrO+qTY1MbP0REo
	hWq4oE+c=; b=Y5yv9gV860a9pTOxyImtYmmIlV07rDuq4aMlu2Zj2LoYeFor1xd
	jwuK0VT8jz7JoekFRVsrpm9SL9CRUTZA5C6pcLND2vXYCALgXJD3NSNHcr4+116M
	JKjGY8wiF2FVB0XBLo00GD/8+XHoeUcG46NaQe8Z9zLZ8P2msKGq70lYqYMQ9Wkb
	0bTrbAiNpnPOBhJ2TP5nBnChXBSPikFS+3z7sq4ny6eWNrhXyLPkv3OAMDCb5o9H
	/ypxCHnVZzcv7OWBDVHUPkmswQSca9I9InxTJbgoofqrbU5b0PgWZKigm1Ttx15/
	iW9bLvvQEtH5iI8amh+GoeG0FrdH4g50jMg==
X-ME-Sender: <xms:CwmwaiTgO5Mepgdqf26uDmVKzPSWiP1wz7IYCMCa04EAqAMlTCK8rw>
    <xme:CwmwauJFeadPzop4HJKHcKnTrm2ZUJGAdOloF135rnV38xcdhGcTcILe2xpkSp9gJ
    65yVgMgmw65BV22IhDBKJm57OBOOlGUqp2xJO-7f-oab3piHK8hpupD>
X-ME-Received: <xmr:CwmwasHusygI4-PZThi9kcMMuq989bjNa_UbhLNNzH42z67sj8lDEZc8cHTq>
X-ME-Proxy-Cause: dmFkZTFBc1TPBpr/LM9c9kHBtWvzNuUjGBUVRa+QYJQpVvspV0TJNc5ATtkHRnnmq6vv+5
    eK3unvJ4+8cQKt5BexqxPewf8Cr0OhUGwsEDWAajP/7TZIGK+siVNNuWG6Te7Z2pgBh7to
    olWRSEoBCjO48HVfiRFf6ELXEwYzuiy2iNIxozOJVN2mnE9nyzVU7JFzOMnFMXeK3VJwq+
    Db4JLXXX8TuHHFC1VqUSutvEB7WEEaQqzW006TKtEY247EFIV8vM+UjNJvHTgM0lIiI/Qb
    4w7HyHDnZ6tf+ACXfu7GoQWP2g2Q0W0Bm0dMjueaAMIh151ctxCmKllD+18LBhlPQZakh5
    rlw2oAOgtJnRRvSwLuUZX+Zc5uf1buNrGcSODcn1j0cRF37DS0ELE41SQ+IruhbmXA/EF1
    W3W3zFgnzKV2ALouRxDPobUBG967VuIfTPd52gNpGTXgjWJ72c4BqQsAqr8pYJp9aC+3+9
    yOcE6JxoD0oDexcH54lYp2DhIXp3bPNCiw9EcCd/g8LgqNTO9isxMnVQO+qH9z/GTYv2+D
    KUJeFGSzm1ZJueGgP1rLvQztEkhxDanMrvYsHKRc54VaqesiUoJXXr11ZAeM9O2rr5D/Ug
    OUGsAaaglMhBBeTPF2EGsA+77qR2K4eIjMDqNnexZugDiRb5gZ9DOgpLIKAQ
X-ME-Proxy: <xmx:Cwmwar2td9p8JzQijfXenKCFHm6KWJhG0UcrJLI9kljUgiQQ4MKgNA>
    <xmx:CwmwakLSMjSTv-56ZdEbbbTfl9uXOjkz2h6_PDOX0OcLe1moEoXgrQ>
    <xmx:Cwmwag0eDQFwnwI4OowdAX3nyMG6xIif2th0nTJIr2SS8erShG289Q>
    <xmx:Cwmwaolcf6-U539gkABvA8MlllcPdmv9FGDjzj4E41JODBVUwPLCPA>
    <xmx:DAmwaqroV7oB5DL_PuFL1L93Gq7T73Ztr03gUVfUqW4k8y0TMgIuyRIa>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Sep 2026 12:25:46 -0400 (EDT)
Date: Sun, 20 Sep 2026 18:25:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Simon Horman <horms@kernel.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
	ayush.sawal@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, rohitm@chelsio.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] chtls: Fix skb reference leak in chtls_send_reset()
Message-ID: <arAJCMpzSVKDiLqe@krikkit>
References: <20260917105846.2147976-1-vulab@iscas.ac.cn>
 <20260919080428.GX51261@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919080428.GX51261@horms.kernel.org>

2026-09-19, 09:04:28 +0100, Simon Horman wrote:
> > diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> > index 0e3e5cf52c2c..a363f20452fa 100644
> > --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> > +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> > @@ -265,12 +265,14 @@ static void chtls_send_reset(struct sock *sk, int mode, struct sk_buff *skb)
> >  	chtls_purge_write_queue(sk);
> >  
> >  	csk_set_flag(csk, CSK_ABORT_SHUTDOWN);
> > -	if (sk->sk_state != TCP_SYN_RECV)
> > +	if (sk->sk_state != TCP_SYN_RECV) {
> >  		chtls_send_abort(sk, mode, skb);
> > -	else
> > +	} else {
> >  		chtls_set_tcb_field_rpl_skb(sk, TCB_T_FLAGS_W,
> >  					    TCB_T_FLAGS_V(TCB_T_FLAGS_M), 0,
> >  					    TCB_FIELD_COOKIE_TFLAG, 1);
> > +		kfree_skb(skb);
> > +	}
> >  
> >  	return;
> >  out:
> 
> This code change looks reasonable to me.
> But the driver was removed in v7.2 by
> cdae65fc43f2 ("tls: remove tls_toe and the related driver")
> And, as a result it didn't run through our CI.
> 
> So while I think it could go to stable
> It probably needs more eyes on it.

But there isn't anyone around that has even a remote understanding of
what this driver does... Since stable@ seems willing to take patches
that remove broken features [1], maybe we should just do that?

[1] https://lore.kernel.org/netdev/apbqjuv6l20bTjQI@laps/

-- 
Sabrina
