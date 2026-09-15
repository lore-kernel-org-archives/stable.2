Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48142BEAA;
	Tue, 15 Sep 2026 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465794; cv=none; b=ifADOsTJcufM2iAX5dNGApUF3pa9McO8XoNCbrRgETPPvMmKPZTXUR7AmVMZne7e8IWfVFgtRmtRPtLNefFug1MqbdnXpoESpmfBBVdfo3RcZmUHYwb7wDbZZMubqcwdjuf+vXXVx46DsYoOOZHfIqz6HWumFACaiI0AwdYMdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465794; c=relaxed/simple;
	bh=Tvidg9IblJT1e2OPxJ2x1ggZYLbakwMurf67tnZl6fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A95TnE3FCZ5svlowQQvLAqk7m9NNvxUJx06ARz0pJh8gOzhzCrSxInyecYWkkPB/xQxRXFbuT+7XlhCAGnsX0Py7BEIih8NuWUQ9st/JpEoiDP+WvwlfdRSJ5/1iz3/mgPqX+umAfEYR2DYIFqvuCYenqXOXakQnCBM+n+XfEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQui7bFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQui7bFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6116B1F000FF;
	Tue, 15 Sep 2026 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789465793;
	bh=J70Hs3GYYGmVmRppJ1Bo++8Zy/dlo2/65YMV7fl8Unk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jQui7bFzO9WyxpW0B5ZuFu7e6HEoxr7pQByWuoIvT+GacXzFH9hkYBE0i9gInRTn8
	 hJhX1G323zFdE4m8mY5s9CBnHLKbgFXMWgt5H6cq78+Sq7WtA8goXp91rDOz88sYTD
	 x/Txx7bklnUnVSn10kPLCNZfEHbJG8gKYOrjZbdxK3G/SjNoJwpXFInDlqNHIyUJ5u
	 6YDQkHNDgeW5RAHXSsFuhCSgtYGh79Yq2tjnNMZ5n81PA3jbapRiwBlHV1UE9ZPgNK
	 9dhAbmGeBbY5eO4q8WJVVmvqY4z0K6eVYSDQcwS/qmvBr4cj/OpHqVe33+UMX+tQo4
	 OdxGpoLrTnNvg==
Date: Tue, 15 Sep 2026 11:49:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Brian Norris <computersforpeace@gmail.com>, stable@vger.kernel.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 3/6] ata: sata_fsl: Fix use-after-free of host_priv on
 probe() failure
Message-ID: <aqkUvKT_WswSVVzP@ryzen>
References: <20260915084127.692494-8-cassel@kernel.org>
 <20260915084127.692494-11-cassel@kernel.org>
 <e5245a11-d6a0-42d8-a6ef-1b5ca9622413@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5245a11-d6a0-42d8-a6ef-1b5ca9622413@kernel.org>

On Tue, Sep 15, 2026 at 03:50:50PM +0700, Damien Le Moal wrote:
> On 2026/09/15 15:41, Niklas Cassel wrote:
> > sata_fsl_host_stop() releases hcr_base and host_priv:
> > 
> > 	static void sata_fsl_host_stop(struct ata_host *host)
> > 	{
> > 		struct sata_fsl_host_priv *host_priv = host->private_data;
> > 
> > 		iounmap(host_priv->hcr_base);
> > 		kfree(host_priv);
> > 	}
> > 
> > ->host_stop() is called by the driver core through the ata_host_stop()
> > devres action which ata_host_start() registers, so it is called both when
> > the device is unbound and when probe() fails after the host has been
> > started.
> > 
> > The error_exit_with_cleanup label of sata_fsl_probe() releases hcr_base
> > and host_priv as well, and it is reachable from the two
> > device_create_file() calls which are done after the host has been
> > activated. In that case sata_fsl_host_stop() runs on an already freed
> > host_priv, resulting in a use-after-free and a double iounmap()/kfree().
> > 
> > Add a separate error label for the failures happening after the host has
> > been activated, which only detaches the host and leaves hcr_base and
> > host_priv to sata_fsl_host_stop().
> > 
> > Note that ata_host_detach() is dropped from error_exit_with_cleanup, as
> > that label is now only reachable while host is still NULL.
> > 
> > Fixes: 6c8ad7e8cf29 ("sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Looks good.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> One nit below that is worth fixing I think.
> 
> > +	/*
> > +	 * Once the host has been activated, hcr_base and host_priv are
> > +	 * released by sata_fsl_host_stop(), which is called by the driver core
> > +	 * through the ata_host_stop() devres action registered by
> > +	 * ata_host_start(). Releasing them here as well would result in a
> > +	 * double iounmap() and a use-after-free.
> > +	 */
> > +error_exit_detach:
> 
> The label should really go above the comment block to clearly show this is the
> explanation for what is done in this label block.

You are right, that seems to be the convention.

Will fixup when applying.


Kind regards,
Niklas
