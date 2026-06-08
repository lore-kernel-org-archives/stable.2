Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F4332EA7;
	Mon,  8 Jun 2026 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934631; cv=none; b=ef8T/sQtWikmrMqzpB6Z0AcU7uHY0NuTUmu0IPRdlg2iB5dtVhDAvBjov+QqQr6t/0qMW0/UREso/0K7xxP9CUPthgQToHoY/dDeUbsL7DwLO9+TZZJB7RzoljvUDwu1GaVGL636KG3KF6yceM5bFt6jnyMyp2o0EqsU5Fe1C44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934631; c=relaxed/simple;
	bh=aCdiaS58bUQL7UzePzNnvYQIC4XpFG8cK0MyqOyoThk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDI7xSfXSerTXtX7qGH+1ftIP6E+L0xoIHsQloeCWykpzHnlKozw25s6igWLkXh94BIj9pQwNJlrDCeov2Bof8Hpd9hwiCtwWkkKJJ903uH0WR3KP8oLDyz3U213fgirdNMi1giVaLYCxR3cn/Z3Ge/j7EYQX+x3PBUzgydDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MFUxWWsa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRYelcvQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MFUxWWsa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dRYelcvQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C11477A00C2;
	Mon,  8 Jun 2026 12:03:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 12:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780934626; x=
	1781021026; bh=zRsyJ98tISk+ATAEz4XJUroqoFu+sTEph+r90M7pkMQ=; b=M
	FUxWWsapxmAIkodmv5sxGWvRMBAYCE/MzQ18g7k/cV0iFFIw7eETOLLJjaX0xNWW
	g4ttF8Wg1ymOmeF/BHzyYJXx06rL0CTGmW0gdRESmWmOcdGSs8a0UJiWI0h+4MaV
	g0DfTWNT7c+QqAhIP3G7aQ1Epa/XKq/FyFwGIkYMNOG48Dwxn1eV5emHr6mz8v7i
	He9erul3fTcCThBX6QZKi6DDh9hkzuSY6soytT7NBsrkqIzJWTJnaNC8qea6Kn2l
	vGqrs2cM+EgJGFliRLPR+bG0Vkfypf2r05sDpINJS7dcnzw6rV+UG5MaBIPQ7/Q8
	xP/ZjZoO3SX01qUc8YhXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780934626; x=1781021026; bh=zRsyJ98tISk+ATAEz4XJUroqoFu+sTEph+r
	90M7pkMQ=; b=dRYelcvQwQzo2hGhgIFZlsHDoTOxbHSR3cLgLLOoKTM2X8HoBgl
	TbndtHpHH8fE2Mz6gfva1AVb8nATlIPC/K+cT7CMasnkeVZYw4em3megL8zVRLC+
	v9Awzt06ZK6eaahLTdN1xYEkDsFS4NZ2j2fgbOEW3vDWqmWRcs9PE00hszWyK3EJ
	uTyBwKMs/GFGz5a5QnA+Ny8RLc5dgQDoUjSQhhUgcEoTvC02qbbQ501fdNO9r3Pd
	HK0a6dVjDsAPuW5KY6lrEd+C+k3Ip1U+pJ1MNReSzo6uObt1hF4Z5OnW8t7z3HeU
	EeW5rB1J0OivA+C+3aXj9SFw90qRpcmE54A==
X-ME-Sender: <xms:4ecmaqofTAipvZ771gHudUl1oDmmmeuHooC3W4rzjm9mgmiz0VonHQ>
    <xme:4ecmaqN0QryWmr4xkeDYWETiWm-vBDubA7RNQXLg6uod505eeFg4WLebi98x7VYs2
    KfgSm85u2ycQo_GWlSjlnGkqmBHhOY8Bzk0L1CQ7MluzFOjQjjpBA>
X-ME-Received: <xmr:4ecmauex5AN7TjKrBY-nI4UJwui1lo6jtkWHxW_zU5swDzTRTnWOhtw5IJKFR1KeAPn2NZjQ_ulwuQfEkCPM_Q0>
X-ME-Proxy-Cause: dmFkZTEJiTZtvJ9ShH977Sp0pLa2KXTz8geBKwqEjOwfs1HT95RnTXnpfB2e0UrDPHqxOw
    gJagGpYftydsSYAXc3/4LsGnpDiMhbMHLIDw34IdjYyZJMPi30S/lHorwaPy++tNt2jIqy
    NspRvWuMUl4QG2QbPpe+V2/R3rgk64UEXOzKAAkzZeS90QbBgIw4cOgCYoM9YpdhHOyyal
    66LNTuu8f9C87eEbeY4fMAFIr+CijbfO3VggQZMrWqWQZi+gZstFvB+Gev2py/MQJ2w858
    kydruTmmi4QM7roIkOAax14wn4ggct6s7qcS4oJl3g1no7liM91wULWI2Dm1VdBzvTcPbm
    h0qVp5g9xPGSlgXEnI2W2JqijSMe2NJh9N1iRZqp37HuqgtBSoKC+d9iZ29OsfvMsr5yzt
    cb7NMNt8hcOByE/F+lp0YFZlURIy70RVvWJCalKMqdM2R7r0S+KnsBO1kQ7OtCDEXgcmVM
    qPK5xdnJ2+QUA034VyFOt+P+rO1eQ/I8SeLHl5WiFB+i9oSnGtlATjhEk12q0aYCjUOqnk
    D9cTnQgsjEN2GAO3Y0/oW6MZFzK9954DI+MfNCpC2aXSaUXXYAEDT93kYbYBdUJrxZirU7
    tpn7qFwU2YQ9YU6qWKpqzLHTrXG6sZ5yQKMjp4qjW2VOJQdN9HKw37/kg7rQ
X-ME-Proxy: <xmx:4ecmagUbKJ7-KNBSfEedX_qMP-UVLF86SzNvTEb_GnLHF2b786Z96A>
    <xmx:4ecmavAMj2fvl7aF_FBQTUoSvORfEorKV7ZLwpA-qpuOVrSdctTVwA>
    <xmx:4ecmar6gMv2Ic-FeQW1gmkt6FA7jdj4dzMrOW5zqIUtyQXDKwXpKEg>
    <xmx:4ecmam1GEbsFS93YclIP8xe_zQ6Wo7SbCfMiZdNm-tQFW_yQfQ_5Yw>
    <xmx:4ucmahgT7ABmLKCiUfTS0E62hOt4TK5S2Ms7XKZlZ2C1Bbo_htCqRwdl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 12:03:44 -0400 (EDT)
Date: Mon, 8 Jun 2026 18:03:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Zijing Yin <yzjaurora@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: af_key: initialize alg_key_len for IPComp
 states
Message-ID: <aibn3tkGc3Iz1r5n@krikkit>
References: <20260608144453.3553219-1-yzjaurora@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608144453.3553219-1-yzjaurora@gmail.com>

note: fixes for IPsec should go to the "ipsec" tree, not net

2026-06-08, 07:44:41 -0700, Zijing Yin wrote:
> pfkey_msg2xfrm_state() handles the IPComp (SADB_X_SATYPE_IPCOMP) case by
> allocating x->calg and copying only the algorithm name:
> 
> 	x->calg = kmalloc_obj(*x->calg);
> 	if (!x->calg) {
> 		err = -ENOMEM;
> 		goto out;
> 	}
> 	strcpy(x->calg->alg_name, a->name);
> 	x->props.calgo = sa->sadb_sa_encrypt;
> 
> Unlike the authentication (x->aalg) and encryption (x->ealg) branches of
> the same function, the compression branch never initializes
> calg->alg_key_len.  IPComp carries no key and the allocation only
> reserves sizeof(struct xfrm_algo) (i.e. no room for a key), so the field
> is left containing uninitialized slab data.
> 
> calg->alg_key_len is later used as a length by xfrm_algo_clone() when an
> IPComp state is cloned during XFRM_MSG_MIGRATE:

The patch looks correct, but do we want to start fixing random bugs in
code that we're trying to get rid of and that nobody actually uses?

If we do, then:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
