Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603622;
	b=i/DCNLkF50NLc6WvJt6VxQFQr6Q8JjYWayIH+ZXKn4C53bg0ANOPo1pjiMQKlzxfxJbv
	 TOZzCNFSxbLMwTW63OkLU8ndo4OLE2PJUFNjEtWV2lzbsbP3c7GAjWOOS1WkHalYFMiLg
	 KYEylD9yK7ChQXX52/XfVHa+a2NPsCME+GzO82qPveSLXFe9aLOktJWdKCcXdlHr+ud+4
	 s1+SHjKwbuR18Z7f9qx4idlMTpu3B+ZrcmPBuB13tG7TqwJayhgaa7jO7cp8b5JILQd+4
	 ySYa4qHkr1mCWVc8lZJiG3tuqtKYk3/LWarnk18N32h0Rce0spde9xxD6BqetbxK+3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603622;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=h3eiV5A+QKOWy2w7+4LROeS6gt8on5LmWdPqXtFAEYw=;
	b=B8XNBCqWD3Uqa6W5xhgAPNKCunZNF57jv1erPR4SyHLdKlpnQJAinSQtUDchvoNmFTnf
	 +GM5/KKK0d4XU5s73kVWazpCFcIzOwvxSAJ63cLGapYNeMseFU5pmVTSOb/oWhOjGtwr4
	 pdECaW1Y/4lkn/zANMs+0uFT7QZUDs7TfRYCu2DtlgnIm9mqSGCo2OhWLUgLtSVO8/UfY
	 cBUqvMgmuOImsBBpfE8U1n3W7TktniAeQEP84ciXuNAOUcb7GFRy2iJtJmYN/+D5nIWVQ
	 QTSe0P3rSZXSIauPmgiLsy8caagUPar9bAt/EyYSnOJ9p/t2WrwRM9YKMOcI6JWTiJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=an2SYGpK;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DC606A319;
	Wed, 21 Oct 2026 17:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 062DC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=an2SYGpK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h3eiV5A+QKOWy2w7+4LROeS6gt8on5LmWdPqXtFAEYw=; b=an2SYGpKUCjS7R9P87RF9hMYLe
	Q1JI6xOM2I36oPaXd4mVUU7JFWPcgkT2aA/GCZkLJdyHoCJS0gbz18EETAY+/eHdA/5NwqoPTETl2
	8Uu6WscrR+qkL53xgwaleLCi/NYycM6miFtAKObxGQNnLJvyZb0INuZyHTUHTDc6hpXI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJa5E-00C8V2-JM; Wed, 21 Oct 2026 19:26:36 +0200
Date: Wed, 21 Oct 2026 19:26:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Grzeschik <mgr@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v3 3/3] net: fealnx: bound card_idx to prevent
 out-of-bounds access
Message-ID: <d9d7342b-49fd-4256-9829-bf1e3f88f973@lunn.ch>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
 <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>
 <CH3PR11MB566895CD7DE8923616D891C85BE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB566895CD7DE8923616D891C85BE5662@CH3PR11MB566895.namprd11.prod.outlook.com>

> > +	if (card_idx >= MAX_CARD_IDX) {
> > +		dev_err(&pdev->dev, "card_idx is too big %d, aborting",
> > card_idx);
> > +		return -ENODEV;
> > +	}
> >  	card_idx++;
> card_idx can reach 100000 is it ok? 

It is one of those stupid LLM issues which never happens, but
$DEVELOPER wants to fix it anyway.

If you unbind and bind the device lots, you can eventually get
card_idx to overflow. Assuming card_idx is a 32 bit int, and it takes
10ms to unbind/bind, you could make it overflow in about 18 months.

100,000 iterations makes it around 16 hours, which is feasible, so i
hope the submitted has tested it. But probably not, it is just
pointless LLM churn wasting all our time.

     Andrew
