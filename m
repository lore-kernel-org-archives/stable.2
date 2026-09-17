Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E134AD7DD;
	Thu, 17 Sep 2026 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647679; cv=none; b=Y+FNyvblXVIAU6rZi/QEi609eff6SdWjraGK83jyIFzV1iOUdeNyPSIaYH/bvIAFrAWdgB7GGQtBpQ+zlHNYIJyn0De8qxNZ9emTLALkIrGoVRHQnt23fE7NctLJgb7ICAXLNJslsaazzUhtbFMV/lYFwnG+c6aaU0fG6ggURnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647679; c=relaxed/simple;
	bh=6zF090TyhNqrzqDjjcqv/wAA8N8uOlGnIDN6kkNUsmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw5BWOMt6ZUkGR01ck+RYqQa2y1cb7havB4XKQ0Wt2mvol6zVD5E6zA0bjdnf8ShkIUfyDkI4U/f2CQz9UF9EHRfE5ASYYbRDSTOT8U9ZpSaTtGxqS7UXc2gksZmdOj+Jf1kFOIowbyuxSJLJ23VGJMSX3A8dUG4IW6PwJJGNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eeD25FhG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eeD25FhG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wk3cgC/VX0GZYaINFo0t0rF3qUtW+UZ3H1uFlf0guNE=; b=eeD25FhGJ7FMikiedVPkpCtsPY
	WgGhTkZJHltnxp4v1jpJEc68Mt5558OdBTadc3dC8O0pXRIVAAI80wCqN+FT6dehrACUWVf98u8Et
	sc1B2tW/D6MPRezOQ1aD0XMnlqDP8LSgaKOUq6D3fHFea/JDvhjfnxMkecJ3cTHJZWhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7B6q-005fec-Ux; Thu, 17 Sep 2026 14:21:00 +0200
Date: Thu, 17 Sep 2026 14:21:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: dsa_loop: Fix netdev leak in
 dsa_loop_drv_probe()
Message-ID: <498210cb-ea19-4753-9620-48006bd0354e@lunn.ch>
References: <20260917104629.2147418-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917104629.2147418-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 10:46:29AM +0000, Wentao Liang wrote:
> In dsa_loop_drv_probe(), a reference to the configured network device
> is taken with dev_get_by_name().  This reference is dropped in
> dsa_loop_drv_remove() on success, but if dsa_register_switch() fails,
> the probe returns without releasing it, leaking the reference.
> 
> Fix this by dropping the reference with dev_put() when
> dsa_register_switch() fails.
> 
> Fixes: 98cd1552ea27 ("net: dsa: Mock-up driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/dsa_loop.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
> index 7058faf23592..b6b6fcffb406 100644
> --- a/drivers/net/dsa/dsa_loop.c
> +++ b/drivers/net/dsa/dsa_loop.c
> @@ -389,6 +389,8 @@ static int dsa_loop_drv_probe(struct mdio_device *mdiodev)
>  	if (!ret)
>  		dev_info(&mdiodev->dev, "%s: 0x%0x\n",
>  			 pdata->name, pdata->enabled_ports);
> +	else
> +		dev_put(ps->netdev);
>  
>  	return ret;

Please turn the condition around to make it fit the usual error handling pattern


       ret = dsa_register_switch(ds);
       if (ret)
		dev_put(ps->netdev);
       else
  		dev_info(&mdiodev->dev, "%s: 0x%0x\n",
  			 pdata->name, pdata->enabled_ports);

    Andrew

---
pw-bot: cr
