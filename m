Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C3374730;
	Wed,  2 Sep 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371800; cv=none; b=kkjP08lx0NkxIaIzFkJwKkTx7yhv9RbKHNBFetXQPJq/QAAy8M5OqdcJRY/phhaJBAy/2QLZu1vQHapFcsF2N1HGxIIcpbsMMjdxvm1Dm8b8ggqNtUckMqpKYDzW8dsh8hMX6yD+djTQIQLwkuMGyRFs9Vr1T2reUuM7iz2fxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371800; c=relaxed/simple;
	bh=bzWHwfqsQDXM0tVfGhFcQoJE70q1pRuWiOSa6aqUEOM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LkRrGsKjoXrjQclusOtcQ9J84UidOyCDp/FYtaLtRm8U2Pl+ULQk8wHhOXomhjxU/UGDuZvZti8eKYfxqpUFqtatB/nUN1R24pWdFKArVNZ74EBZJQUJidqchjnM9bYwqlH5oa1fDtRSuf6ZSZugs7iBKVnizV42+sWFTp9DYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngs7g4Ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngs7g4Ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE78B1F000E9;
	Wed,  2 Sep 2026 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788371799;
	bh=QWeMfYXOTyMFSUAfAZF9yC+OI2pdAboC2YztJrUE0/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ngs7g4RuL2HQstK3A+oCvHnGI5nS1c2TgyKG8tAFHaqb90ukyZkCUxUBssg/CJG8a
	 GePMjAraZw57A9UaS8U5TnPELx2b/abWZBNOvBET6uUpO6MxAvpl7nMDXYXPcpjWcZ
	 7N4mKfsIOYtXmji3pOR5N6Vei1LeXPItNw6voC2MqX4i/7H8uXqWaNVZptXH3Lm+g3
	 nmVGVeZ/zQ58j/f5+E9END4ACoOX7Ym1S5HWz7zvb1MReXKMtmGTHhjw4ec62/zurW
	 U7slqKPTTO2dl68b18GN+5V8TvjlqAGJy3f+W1RCMqEKci+jL6nSQltpq0VVyOZJ3U
	 dh9up44Cw44vA==
Date: Wed, 2 Sep 2026 12:56:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	ley.foon.tan@intel.com, dinguyen@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com, preetam.narayan@altera.com,
	cheryl.bansal@altera.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: altera: Fix resource leaks on probe failure
Message-ID: <20260902175637.GA1993694@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430204330.3121003-3-mahesh.vaidya@altera.com>

On Thu, Apr 30, 2026 at 01:43:30PM -0700, Mahesh Vaidya wrote:
> The chained IRQ handler is installed during probe but is only removed
> from the remove path. If pci_host_probe() fails, the handler and INTx IRQ
> domain remain installed even though the devm-managed host bridge storage
> containing struct altera_pcie will be released, leaving the handler with
> a stale data pointer.
> 
> Interrupts are also enabled before pci_host_probe() is called. If probe
> fails after that point, the controller interrupt source should be disabled
> before the chained handler and INTx domain are removed.
> 
> Install the chained handler only after the INTx domain has been created.
> Disable controller interrupts during IRQ teardown, and tear the IRQ setup
> down if pci_host_probe() fails.
> 
> Fixes: c63aed7334c2 ("PCI: altera: Use pci_host_probe() to register host")
> Cc: stable@vger.kernel.org
> Reviewed-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
> Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
> ---
>  drivers/pci/controller/pcie-altera.c | 35 ++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 3d3519b8d88f..902ae2d81763 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -864,8 +864,23 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>  	return 0;
>  }
>  
> +static void altera_pcie_disable_irq(struct altera_pcie *pcie)
> +{
> +	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
> +	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
> +		/* Disable all P2A interrupts */
> +		cra_writel(pcie, 0, P2A_INT_ENABLE);
> +	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
> +		/* Disable port-level interrupts (CFG_AER, etc.) */
> +		writel(0, pcie->hip_base +
> +			  pcie->pcie_data->port_conf_offset +
> +			  pcie->pcie_data->port_irq_enable_offset);
> +	}
> +}
> +
>  static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
>  {
> +	altera_pcie_disable_irq(pcie);
>  	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>  	irq_domain_remove(pcie->irq_domain);
>  }

This patch appeared in v7.2 as 7a94138caeb2 ("PCI: altera: Fix
resource leaks on probe failure").

While considering this for backporting, sashiko came up with the
questions below.  Can you take a look and see if they make sense?

  This is a pre-existing issue, but does altera_pcie_irq_teardown()
  lack synchronization with in-flight interrupts?

  If a device interrupt fires just before altera_pcie_disable_irq()
  masks it, could the chained ISR (altera_pcie_isr) execute
  concurrently with altera_pcie_irq_teardown() on another CPU?

  Because irq_set_chained_handler_and_data() unregisters the handler
  but does not wait for currently executing ISRs on other CPUs, could
  irq_domain_remove() free the domain while the ISR is still using it
  to call generic_handle_domain_irq(), leading to a use-after-free and
  a kernel panic?

  Would adding a call to synchronize_irq() before removing the IRQ
  domain prevent this race during driver removal or when
  pci_host_probe() fails?

