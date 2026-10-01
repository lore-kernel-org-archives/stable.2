Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B8503BE0;
	Thu,  1 Oct 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873492; cv=none; b=eiBWaR1J+qj/qmVOQWL3Xt+67eNGmJTIqPpTYUlhO0N9mfce+Cwp6kdKZAmx2USOz4t8e/WIF2zLjpSs33FjLRYXDsdr/2osnDXd3OfVyHE0JGCcZzzUZQuzc1FVQ4z8EfxKtYeXMMUyYK+8WsoyHbWVC0OR6fkPcARXPp798zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873492; c=relaxed/simple;
	bh=H0CSkhQD16gPNXn8pC/4mJP4ST5oLYUGTyqxeMAHWoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uXc2pPK9SysouYAXrTq+t2q9LvmZlQyaypnIuOTE93vCjhiphQtMKVk48ty7AKKVqQ0ZztYKrW81NvsltH9/JBzXSmL87dtnfPXzhxcf5DLH8T1gCTS6hUEqEsh3jbWT5AcUD75q6xeVAg/uqA9J2or1Tl8WR1j2dW2QFFaRRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCghPi0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCghPi0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125AF1F000FF;
	Thu,  1 Oct 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873479;
	bh=0gQhePCGzDzi1xrts4goAORw8luq0xZKrY+cPeL1LDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XCghPi0HC0lyp76IZgg5LSM2hs9Ix5G0vHlbnMTS8Kscr3Rn/wqsJ4PObWECt4fmb
	 JjAYqrvzsBrEPF4KmhNWmn6FqYZp5KC9vXNTBG5QGBNlKsWip4hhTgI8YoCfN3ju1o
	 du7gU6yPSNULtTD7f7453MBgG22siy5kuTbOfcIR5G0fjOZFTY3kWu5KMv/v1ZV55/
	 RyVz2Hr1CtmnVsj5l69gbGzFAYkNB9IZMm2c2UjWhhVhS9JB4vlsfvXQKXyKlTKWKP
	 LEY+1CmUI8pEtq+vT2Rkcc3Fdo3WiG//NSDx4sF2N9TvLrZUqK7Fbz+V1abxnGOFu7
	 0wQu3M1SDxVyA==
Date: Thu, 1 Oct 2026 11:51:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Corentin Labbe <clabbe@baylibre.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Message-ID: <20261001165118.GA2699753@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001164610.GA2695820@bhelgaas>

On Thu, Oct 01, 2026 at 11:46:11AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 29, 2026 at 02:05:49PM +0400, Alexey Charkov wrote:
> > of_regulator_bulk_get_all() allocates the consumers array and hands it to
> > the caller, who is expected to free it at an appropriate time.
> > PCI pwrctrl never did, leading to a memory leak.
> > 
> > Add an explicit kfree() for the consumers array.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I assume this will be merged via a non-PCI tree.

After reading farther through my email, I see this was posted
separately, so I applied that to pci/pwrctrl for v7.4.

> > ---
> >  drivers/pci/pwrctrl/generic.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
> > index d56171e0ee24..4b6cbbb52248 100644
> > --- a/drivers/pci/pwrctrl/generic.c
> > +++ b/drivers/pci/pwrctrl/generic.c
> > @@ -63,6 +63,7 @@ static void devm_slot_pwrctrl_release(void *data)
> >  	struct slot_pwrctrl *slot = data;
> >  
> >  	regulator_bulk_free(slot->num_supplies, slot->supplies);
> > +	kfree(slot->supplies);
> >  }
> >  
> >  static int slot_pwrctrl_probe(struct platform_device *pdev)
> > 
> > -- 
> > 2.55.0
> > 
