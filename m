Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91583CB571;
	Thu, 24 Sep 2026 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268252; cv=none; b=rtqyXLDm9HEbVASwqqREVvMcvh0EsqafgyG94/Fm9a/lpQf6wZz+MFhWQDily/33qt01M5xTCOh20dz3MHiWtjiPJ0UA+ysFbFPtsFhdEsGRYSh8KoCa1tZw2xj1kIjm7kk27C6CbNa81mlJDsoTaZWLXUEzUNRReJMBV+egq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268252; c=relaxed/simple;
	bh=GcGxAuHjegieUhml6jhBvnFuF/HH3L+FUtaOGvDFm8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2ai8v8RKXgXUoG+L3j1XIOl6lIlSzd82wsNBVzUOYlOKHbmII65X2mzHscOS9vaQNjUehr0q4dEwQCGbVcJDYObsSFuE4Rn/WWDMY+ZYFBnwyCWgzQ2PcyWNdYieJbuXYDCU6OQsYFYVKEANMNyNu/2N3k3aibJM4bfsQqRG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4HkTsIfL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4HkTsIfL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ahg9seQPPv3QHPFNI00LWYz0svWliPsZtiwzoOpE8Ew=; b=4H
	kTsIfLHuWIpfSB3ipqT2ISLVJ0B1rBPYMRiJXiS6D0z68mcpwagQYyqErCt/7GAv+SpS0NPYNniBm
	zg12SQZB/NxMLyErTwL9TwOmGy42i0aCCpt/KJHLNxZdrNfnI7V2vbvyzZR8Q01KhthvnaYoETHKC
	//RgQhcVGfU2SfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9mXw-0072Sg-LG; Thu, 24 Sep 2026 18:43:44 +0200
Date: Thu, 24 Sep 2026 18:43:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Petr Machata <petrm@nvidia.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Message-ID: <95c9fa4a-79e5-47fe-9de5-2c6cd186216d@lunn.ch>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>

On Thu, Sep 24, 2026 at 10:44:21AM +0000, Жамбакиев Радий Рикардинович wrote:
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> fealnx_remove_one() frees the DMA rings before unregistering the
> netdev, while the interface may still be up, which leaves a
> window where freed memory can be accessed.
> 
> Call unregister_netdev() first so dev_close() stops the Tx/Rx
> engines, deletes the timers, and frees the IRQ before the rings are
> freed. While at it use dev_err() instead of printk() for the 
> unknown-device case.
> 
> Found by Linux Verification Center (linuxtesting.org)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> ---
>  drivers/net/ethernet/fealnx.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
> index bdc38aac5850..d7cd1644a375 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c
> @@ -678,20 +678,23 @@ static int fealnx_init_one(struct pci_dev *pdev,
>  static void fealnx_remove_one(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct netdev_private *np;
> +
> +	if (!dev) {
> +		dev_err(&pdev->dev, "remove for unknown device\n");
> +		return;
> +	}

I know you are just moving code around, but is that possible?  We try
avoid defensive code. It is better to actually understand the code and
stop bad things happening.

     Andrew

