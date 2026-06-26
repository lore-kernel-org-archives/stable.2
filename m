Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E53BD241;
	Fri, 26 Jun 2026 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489788; cv=none; b=fQ7a3DVUYCjxJohv/rRzMvk6fdSe8DHGWoxRRPeR0kOH/KBS9YnfVsvfHgXTO9f50j0vAh5p83VKdIDi/VDLbVA94nji1AbqAGEgFIaidnjqzppHcBQV30tb4I8iM/UBck68wEeszcNiVHkjxXxAxAYyrbotW+xrPSfx8oPY52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489788; c=relaxed/simple;
	bh=jWf1MStijQPKcnSM3z+OEQbw5Gy9SRweKjVitITEGLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEeM4F3NYb4yQ3Urc58HTLawihXOQOdHuc7LLGQZydAHAPGw1EkiF3yLKab6AHlqUs4VGpYjf5L7oVZPKbsPiEgghmQDvsuLzUQ370C5Mwwzq8afCDN0TjxHsk4+efXakchuZ4Pq6u+vsc3LsYOOMwAP6mawik0WgChVlnLkOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jgc4Qmxw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jgc4Qmxw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gTeUwUU17Ccc7ENC5gMv0IOc+stImvQB65bzW9W2AmM=; b=jgc4QmxwJXE7IRUYeF6HTVKpTr
	xbgYZUcGDRDwuR2Znqroc99br7SnWah0wxmSLCSkNMo+Y497C0GJIKNkm9KG5a160zayI7ZJhnEIm
	lFLcCCJEbaeJxgfkSWGaLKrHc7uf9I+9EIkcL4cj7Pqb4QQ2cfpysOuHai3enBk96OoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd90w-009OC2-Ge; Fri, 26 Jun 2026 18:02:46 +0200
Date: Fri, 26 Jun 2026 18:02:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: cadence: macb_mii_init: fix double of_node_put
 on mdio_np after   macb_mdiobus_register
Message-ID: <40ee8ddb-74c5-44f6-9dba-0c50337e05fa@lunn.ch>
References: <20260626151449.50969-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626151449.50969-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 11:14:49PM +0800, WenTao Liang wrote:
> After macb_mdiobus_register succeeds, the mdio_np reference ownership is
>   transferred to the mii_bus device (stored in mii_bus->dev.of_node). When
>   the subsequent macb_mii_probe fails, the error path jumps to
>   err_out_unregister_bus which calls mdiobus_free (releasing the node via
>   fwnode_handle_put) and then falls through to err_out which calls
>   of_node_put(mdio_np) again, causing a double put.
> 
> Move the of_node_put to only execute on paths where the reference was not
>   transferred (i.e., before successful macb_mdiobus_register).
> 
> Cc: stable@vger.kernel.org
> Fixes: ef8a2e27289e ("net: macb: fix probing of PHY not described in the dt")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index a12aa21244e8..c58e089e5888 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1170,6 +1170,9 @@ static int macb_mii_init(struct macb *bp)
>  	mdiobus_unregister(bp->mii_bus);
>  err_out_free_mdiobus:
>  	mdiobus_free(bp->mii_bus);
> +	of_node_put(mdio_np);
> +	return err;
> +
>  err_out:
>  	of_node_put(mdio_np);

This does not look correct.

You say if mdiobus_register() is successful, mdiobus_free() will
release the reference.

If macb_mii_probe() fails, we have successfully done
mdiobus_register(). It does a goto err_out_unregister_bus, which calls
mdiobus_unregister(), mdiobus_free() releasing the reference, and then
with your patch of_node_put(). This looks like a double put to me.

I think i already said this once, consider the risk of your patches,
particularly if you cannot test them.

	Andrew
