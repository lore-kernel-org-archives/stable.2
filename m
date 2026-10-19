Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421674;
	b=V6D11IVyIjUXIlmFaPjLTOfnKtwhAQcAFbxiGatCPqyGipHWUZvHas6wahilaRMce56m
	 N252G6ReVDxfjza0JE32fqRs5l71C8JwvPH6vWZxtNg0cimYW5J8wlesaepSj51AjBBJV
	 DvKRTyjYep419syBaOcTmzRkFry+7dBsg5W+O3FQOC7/QgXUmIPb8lHttThiuoPEhdlTF
	 of4v1w0NybbhvKgvhk66jcvIkE95fNzKJrvq2Yci55tBSTMJB4CsDlUKRxW9XKm8NFIup
	 Eqs+tQOKr+vkhMV+4Di4nglmDaAH1PpJs0KYPw94JPwKXGJdC620fqXBEcK3RQoDDyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421674;
	h=Received:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=pLtXWGlAP6785wBBieTrTxHzSzJh4HhsM6hJJ7PEjp8=;
	b=kbaG4jCwttG+6vggUY9CENS4ccRII/KftBrSpM/yVQZW1Eak/Ggb/+PYeR/D0YE/TG7R
	 TDLWjCfD8jJhyFcqUQgzm1NvlJvkG52ceEOuOjaayiYrX6JeUeWpTfgSMPrw4pCR+Ac7E
	 ZYeQGw5CtppLPfnd1sMd1TA7Kaov2kwvEnltSg2E0tv1dm3Fj8Z9r9jB4i9HK0ZfwjMgV
	 iUiKrr2j8QI7Eysj6WRzZAhHgRCJrhYy++cYecY1N/Q86WLsu7U7qzYAVLQPIL19vm96Q
	 TpbwkeBUVauRxzVv4GJRB9/j5zQGkWP6gO7Yzm2Zi+yU6tbV61/AtaCzvhXEVR/t7Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=nIJ8RI1h;
	dmarc=pass header.from=ispras.ru;
	spf=pass smtp.mailfrom=ispras.ru;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9F606DA6C;
	Mon, 19 Oct 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=nIJ8RI1h
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9319353A72;
	Mon, 19 Oct 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421674; cv=none; b=GAfR8qt6w5hYvpTdcf1dxj406mwI63+eK7JxEfpplen2Fm9zAOmgt1smerNu4HEmbbu+0TIdoMAI9wc/5VEaazkGUykHUVb/L0AiProxkdS5JxAmCZY1XBG89730kPZNkQtyjynQ3s2kh8VMlPp77KB3YakAecvtP9vtQpJt8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421674; c=relaxed/simple;
	bh=LM1zuW0/sF9KudJhepQZV11i0V1W2FAt5hhXmWJVX2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjeOk8sODb7uS+CLMHYiJgj3VSwGCDzO9qVWOxb0/9n3urKdOGIcjCre4/O8GBgLh8JP/yCTrIS3PO696BqIHNgh2r/viWiRtRxznOOIqUyOBMRhndkcpAtkBLN5WM0w+dg+am8yYgtKRqV++Eh1CVV/kFfEo7zyL3jlAOJfxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nIJ8RI1h; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id D0552406E9BE;
	Mon, 19 Oct 2026 14:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D0552406E9BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1792421183;
	bh=pLtXWGlAP6785wBBieTrTxHzSzJh4HhsM6hJJ7PEjp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIJ8RI1hOhWHG/aBK2gZginkmEg3SsEMwaS8mbNlE0UqniEVA/HhZC0jJYCrXPvxO
	 Efxl2MCFN0IUCQacpjizJd1Aszn7EOHFlVpFM6aRvxiTG4hF1xOnYsHey/iP6A1WdF
	 5s/p5DUSo3PUzA/6ws7jBdS9Kf7BxLMMu9VWYG6Q=
Date: Mon, 19 Oct 2026 17:46:23 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, Denis Benato <benato.denis96@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jijie Shao <shaojijie@huawei.com>, 
	Eric Dumazet <edumazet@google.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Michael Grzeschik <mgr@kernel.org>
Subject: Re: [PATCH net v3 3/3] net: fealnx: bound card_idx to prevent
 out-of-bounds access
Message-ID: <atYrfvH_e1GLnfa9@fedora>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
 <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>

On Mon, 19. Oct 13:43, Жамбакиев Радий Рикардинович wrote:
> diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
> index b5e96c7037f3..d5931c0314fc 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c
> @@ -41,6 +41,7 @@ static int rx_copybreak;
>  /* interoperability.                                            */
>  /* The media type is usually passed in 'options[]'.             */
>  #define MAX_UNITS 8		/* More are supported, limit only on options */
> +#define MAX_CARD_IDX		99999
>  static int options[MAX_UNITS] = { -1, -1, -1, -1, -1, -1, -1, -1 };
>  static int full_duplex[MAX_UNITS] = { -1, -1, -1, -1, -1, -1, -1, -1 };
>  
> @@ -489,6 +490,10 @@ static int fealnx_init_one(struct pci_dev *pdev,
>  	int bar = 1;
>  #endif
>  
> +	if (card_idx >= MAX_CARD_IDX) {
> +		dev_err(&pdev->dev, "card_idx is too big %d, aborting", card_idx);
> +		return -ENODEV;
> +	}
>  	card_idx++;
>  	sprintf(boardname, "fealnx%d", card_idx);

There is a compiler warning with a W=1 build the testing bots will
soon complain about:

drivers/net/ethernet/fealnx.c:498:35: warning: '%d' directive writing between 1 and 11 bytes into a region of size 6 [-Wformat-overflow=]
  498 |         sprintf(boardname, "fealnx%d", card_idx);
      |                                   ^~
drivers/net/ethernet/fealnx.c:498:28: note: directive argument in the range [-2147483647, 99999]
  498 |         sprintf(boardname, "fealnx%d", card_idx);
      |                            ^~~~~~~~~~
drivers/net/ethernet/fealnx.c:498:9: note: 'sprintf' output between 8 and 18 bytes into a destination of size 12
  498 |         sprintf(boardname, "fealnx%d", card_idx);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

