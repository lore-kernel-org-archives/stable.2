Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66C1A8F7B;
	Wed, 15 Jul 2026 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094068; cv=none; b=oZLELezftuTnL8xkVyIdUDE6fBYMBEA26UDzDSryXE/v20Qa/rojpesLE23HQX7V0ZluwhcnFJhGMV5OMZu0SRXDoIv8VZ0ibnUgqXjrYn9cvfJk2xkcTl+VpfIADM6ydIhDWCEka3F65MGPz6t37ETr5+6LQ1CS0wBNi0tT6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094068; c=relaxed/simple;
	bh=MqgU87tnw3x0VinNOOZYu2BJQGAzPMXZxgnk/r+TJm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ8fTmWiaQbrPEu0pWq9/a8ymCecv8D/WDqn6UCajcc/xa+tlRY2kdqY4DbV5LfSnvM5AUyGxyqVdHcHWcX3BVTl6urHtKV3HMpSx60xW/gP3vx2CCu9MtRJlhehCuhV/16wSZ8wHJgjP41cOlktDvsIHvGP+X2X6T9bvkCbG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH4aTfvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH4aTfvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26371F000E9;
	Wed, 15 Jul 2026 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784094067;
	bh=hMQq0jJEQshTzjxnb1XfDCm8LASdaJ7clh2uWi+5Tsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AH4aTfvDY5e8DVBk0K2mX2cWVmPb+J7VHhpunZwIEDTNnFrO5WVUXGGmcFU/dQ1Ke
	 Yj9YWaZRJsivMAhj0+0a+C/cbDat6h1jV++jjlpXYlSUVn1KB98ZxUyV8IXI9T1GCI
	 2B2lhwXSZ8DCodJEu4Bcn1X7X0Rt2kj7F07FT9hjlOzfQQpkECoKE3iBz1PeWlWPOl
	 kR9tng4/1i/fHV6IcH7KzySOPRYBjnyY4G0LPykQzJJrHpWfFyBuYTlkNIe7V6n/fR
	 ruWs+8DAhXYmuYYfCqAfrk9Dk+0RDmgHSjSFCSrnge7TGpH0pm5L/Ti3t79QK6YIWY
	 nFFuiD6yTZrIw==
Date: Wed, 15 Jul 2026 07:40:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Soeren Moch <smoch@web.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Message-ID: <6ayf4vt5wiftgz4myxpyze2wmmuxf5miakq6ffz2k3r6beiztu@lh5z5zjnljad>
References: <20260427115804.134231-1-smoch@web.de>
 <2cbqhvfjszzuanp4i3rohntkxpfgftfjvzt66te3wkohsvw26g@yv4txuy74tvu>
 <465b1dcc-8e96-4edb-aebd-52937b8076d0@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <465b1dcc-8e96-4edb-aebd-52937b8076d0@web.de>

On Wed, Jul 08, 2026 at 10:52:22AM +0200, Soeren Moch wrote:
> On 06.07.26 12:29, Manivannan Sadhasivam wrote:
> > On Mon, Apr 27, 2026 at 01:58:04PM +0200, Soeren Moch wrote:
> > > Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
> > > the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
> > > 
> > > Even though the Root Port MSIs won't be received by the iMSI-RX controller
> > > due to design, this chipset has some weird hardware bug that prevents
> > > the endpoint MSIs from reaching when the Root Port MSI capability is
> > > disabled.
> > > 
> > > Hence, always keep the Root Port MSI capability for this chipset.
> > > 
> > > Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
> > > PME and others won't be received by default. So users need to use
> > > workarounds such as passing 'pcie_pme=nomsi' cmdline param.
> > > 
> > > Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug")
> > This is not the correct fixes tag. Correct one is:
> > f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> Thanks for the fix of the fixes tag!
> > > Cc: <stable@vger.kernel.org> # 7.0.x
> > > Signed-off-by: Soeren Moch <smoch@web.de>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > @Bjorn: Can you merge this patch for 7.2-rcS with correct fixes tag?
> I can send a v2 of the patch if you prefer.
> 

That'll help.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
