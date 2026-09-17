Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE934F6460;
	Thu, 17 Sep 2026 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648443; cv=none; b=Zg6xqrDAUEo7aHEb6sKIeoJXpnj0n6fd5tJ0GmY2SSZ2j8QHWIFqzVvzjA+zATpBdW0KbQi1ct8v8vZp9CVbwNNhTIbIiZk4Z9fzinZLtNemtS1Mg5vO+fV398WsqL+z00u7O5V5KO1QJevS71vKEK5Niejavh4jQugK7ryG6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648443; c=relaxed/simple;
	bh=2MjY0fevG7tLMdtfZDUDsgXmq7VsTJ9NcnV+9w9zIIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB/HBuUeeWUOtCL5NLatz6YqY5n39mRJKTLBaEUSQ4lhfLpoxl0nRsgcMFOYJY0Z82ATBGXmdLm01lkerbsAv4PoRiHwITVZh4ho7ydtgW1FNJa5oaN9tKEuez78RLOR5iOP3Kcsit7MOAKLwMXYToU+2J/j63dum+sd/C+jUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bzmaNwRh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bzmaNwRh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xA/hMnCQPu6NcDOT+QBYo9ThF3mGo2Y2HXYxu8R6mGk=; b=bzmaNwRhGcgTNUqIhKhtXyHm59
	5B0recGA9Q2JHnU7gr6SOKWiCBwXlZ2PUPzG56iBjr/3QsL7ErMn5HgUgbu8wsJR5lqme2cGaVRqM
	jrdxRsFMbA/m4+t6NqMhJ19JoOLZsU9kmyOch9k9HRo8L5J5OEctG6zfWD9F3f5+p6wg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7BJ7-005fsj-A5; Thu, 17 Sep 2026 14:33:41 +0200
Date: Thu, 17 Sep 2026 14:33:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, o.rempel@pengutronix.de, olteanv@gmail.com,
	pabeni@redhat.com, woojung.huh@microchip.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: Fix parent_mdio_bus reference leak
 in ksz_mdio_register()
Message-ID: <f97c909e-71c5-4565-9574-136f3d9a4c06@lunn.ch>
References: <20260917104757.2147497-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917104757.2147497-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 10:47:57AM +0000, Wentao Liang wrote:
> of_mdio_find_bus() returns a mii_bus whose embedded struct device has
> its reference count incremented. When ksz_mdio_register() fails after
> the parent bus has been stored in dev->parent_mdio_bus, that reference
> is never dropped, so the parent MDIO bus device leaks on every probe
> failure.
> 
> Drop the reference before returning from the error path.

What about the happy days path? Where is this reference dropped when
the driver is removed?

> 
> Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 144373e13bea..fcf3a29ffca3 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2807,6 +2807,11 @@ static int ksz_mdio_register(struct ksz_device *dev)
>  	}
>  
>  put_mdio_node:
> +	if (ret && dev->parent_mdio_bus) {
> +		put_device(&dev->parent_mdio_bus->dev);
> +		dev->parent_mdio_bus = NULL;

Is setting dev->parent_mdio_bus to NULL required? If an error is
returned, does it ever get used?

    Andrew

---
pw-bot: cr
