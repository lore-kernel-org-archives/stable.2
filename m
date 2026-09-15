Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD0471CE6;
	Tue, 15 Sep 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461640; cv=none; b=NfFyyL1hIngsqg8g6fgsSZ0wUPdEYALywIj/0Zg0K0yb4CzE9c5CgYRPrruTGqHlzV1ZCtKmbTRw0T4pNfVzp85ui+fTWgwUUOjShmTR9Ho09gTjjgs28V/BemZQzrYuD8cHBC696W3ZJ+tZZvRO09Z6O1m0vcK7ksiR5UIZ4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461640; c=relaxed/simple;
	bh=YB9tTvdfttgm0y/e9cm1iy+NQWJZUfXLYD1+LT7ku0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGYxHDXYlb3VyxtosyCGuR1UdhvET67O2B98s4tfy2l1SJdCV4c4omaSoyKdgPQqw26JCIXW/WXzcGZnn7vl/pcjRzOrb3zNXx9bwB2JIUQqVEdvzaB4r7ZJ3Zez8QUNikp0TERBmnTXFqd/B34/HrjKyXax31t5+HnuzS2D+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJXTrrle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJXTrrle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0811F000FF;
	Tue, 15 Sep 2026 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461638;
	bh=YaJz3oRtYSDLsjYI2XaySS2VvpeIb7deKH/pIqBlhAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJXTrrle5k/IEQm87c9zl8sFgiNk7wV8bmut+1uHg//Uki2ksLFAIm3wK3fCZMGI9
	 R0wrO26KOjXa3b8vVagB9Smf543viDvHKbbdhTTyCeYi98l5XV5raBJdsLPJzR1bbd
	 nQgYPyPJbxtYuoN5ijcRzG2GU2LAJrjS/1dvYeYZ5O6P8OgJ99nza87bUO12vS7LKX
	 jSA74liDXXnB5f6VZG4h71SMwSubPXZHNFxUqWuCePqcPmyLy5eCZbN+piuRMhpYk6
	 Wpvrh80qIdAgsLc+7Rt5UY+iK4W0GcYdZCWuBOQ3pkxfInKqEWGJ0tWSclR9YUBWEY
	 X6nSwhFLEor/w==
Date: Tue, 15 Sep 2026 10:40:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Brian Norris <computersforpeace@gmail.com>, stable@vger.kernel.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v4 2/5] ata: sata_fsl: Fix use-after-free of host_priv on
 probe() failure
Message-ID: <aqkEgcs6NBiZjjgR@ryzen>
References: <20260910171406.131211-7-cassel@kernel.org>
 <20260910171406.131211-9-cassel@kernel.org>
 <34709b8b-71e9-46d2-8732-a802e544701e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34709b8b-71e9-46d2-8732-a802e544701e@kernel.org>

On Tue, Sep 15, 2026 at 11:06:55AM +0700, Damien Le Moal wrote:
> On 2026/09/11 0:14, Niklas Cassel wrote:
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
> > devres action which ata_host_start() registers, so it is called both
> > when the device is unbound and when probe() fails after
> > ata_host_activate() has started the host.
> > 
> > The error_exit_with_cleanup label in sata_fsl_probe() releases hcr_base
> > and host_priv as well, and it is reachable from the two
> > device_create_file() calls done after ata_host_activate(). In that case
> > sata_fsl_host_stop() runs on an already freed host_priv, resulting in a
> > use-after-free and a double iounmap()/kfree().
> > 
> > sata_fsl_probe() also ignores the return value of ata_host_activate(),
> > so probe() returns success even if activating the host failed.
> > 
> > Check the return value of ata_host_activate() and, once the host has
> > been activated, leave hcr_base and host_priv to sata_fsl_host_stop().
> > 
> > Note that if ata_host_activate() fails inside ata_host_start(), e.g. if
> > sata_fsl_port_start() fails, ->host_stop() is not registered and
> > hcr_base and host_priv are leaked. Leaking them is preferable to freeing
> > them twice, and this is addressed by a later patch in this series.
> 
> I would prefer seeing the leak fixed here too so that we have a self contained
> fix in a single commit.
> 
> Or, move the leak fix patch before this one.

I took a third option:

This (temporary) leak was only added by this patch, and was later fixed
by "ata: libata: Do not leave ata_host_stop() registered when activation
fails".

The UAF happened only when the activation succeeded and device_create_file()
failed. Thus, this fix does not rely on ata_host_activate() error handling.

Thus, let this patch only fix the UAF, without adding any error handling to
ata_host_activate(). That way this patch is self contained.

Patch "ata: libata: Do not leave ata_host_stop() registered when activation
fails" will add ata_host_activate() error handling to this driver, and at
this point, ata_host_activate() internals has been fixed. Thus, we there
will never exist any intermediate step where we might leak resources.


Kind regards,
Niklas
