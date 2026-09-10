Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B64A1DFB;
	Thu, 10 Sep 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050437; cv=none; b=P2ix58T4rfiJlXd5y8qzHdrgesJ5xn3TxWEZ/ssvisn2XelHov7jGsmY5rob5/Cbs6uTV7qfwJ0E5KZtuBE/5KpL0W08CpuXEdm3cRdRDTuZ7fxba+o+erX3E/AJD68Wc/BX1Pru6HH4r3hMSDAvI8r758gA1nqKFqIljkM99Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050437; c=relaxed/simple;
	bh=1uZ4ZGna+PhskcuJmNzd/28vPy7Uw3Ree2Foa3UydOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7GkWJEXLJc8zb6eppH+rLTweMig+h4SzhAGcOtFmWEzyhOhE/WUY6z8l48zTiEvN6OhZOlHV2+4bCZTtTQSVJSDaHc4RIeAE5wpsAxlkXyldji50ahq0F6HxzGwLOPfQjzl+XUTkSq87+92S7xKvj81o5rRfA+GidF4sTqwVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftTz6hzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftTz6hzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E8C1F000FF;
	Thu, 10 Sep 2026 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050435;
	bh=fjmjeL0fo+qZvcOSZUel0KmILfsMo70LzvFm90HVMgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ftTz6hznc8SUZalHQpTx+KZ7om6BFyqwfgpRU/G0qsVbxJFzDmYGK26ur2OE0Jvhv
	 4RwJgwDGFzlGY3HEr4cFqJbMWGfhv/uEFqvlQoo+O2nQciUt3UacNDOq0/GpPeJPoC
	 AEZybWEmuYAn0wtO6KIyjFlPhOQLlUh+DhwvJWTGcinEhb+dyp1717vj+j2zjknY6H
	 Y9Gb1VsKkJdsXRvZk86ndn8YNqG57uz0jahBuzAogFYCxKEwecsySvw2TCWy9EgLdh
	 iL2AuGpdUp/nTJBvlF8wSzUdRq/NPZsQATCGue8GDWreZBdTJ1JNK6Bj5nvOIjhx+0
	 tE2G3hh7kVkww==
Date: Thu, 10 Sep 2026 16:27:06 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, p.zabel@pengutronix.de, claudiu.beznea@tuxon.dev, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/7] PCI: rzg3s-host: Fix runtime PM handling in the
 NOIRQ suspend/resume phase
Message-ID: <rv4yjo55edby5dkinwoz32rdnsnjffjhhwbhs7wvrtvvtz7nkw@gpffv2q3i4kq>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
 <20260814141312.2947972-3-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814141312.2947972-3-claudiu.beznea+renesas@tuxon.dev>

On Fri, Aug 14, 2026 at 05:13:07PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The runtime PM documentation states the following:
> - During system suspend, pm_runtime_get_noresume() is called for every
>   device right before executing the subsystem-level .prepare() callback
>   (in device_prepare()). In addition, the PM core disables runtime PM for
>   every device right before executing the subsystem-level .suspend_late()
>   callback (in device_suspend_late()).
> - During system resume, pm_runtime_enable() is called for every device
>   right after executing the subsystem-level .resume_early() callback (in
>   device_resume_early()), and pm_runtime_put() is called right after
>   executing the subsystem-level .complete() callback (in
>   device_complete()).
> 
> The driver's .suspend_noirq() callback is invoked after .suspend_late(),
> while .resume_noirq() is invoked before .resume_early().
> 
> If:
> - the device is not part of the wake-up path, and
> - its runtime PM status is not RPM_SUSPENDED,
> the generic power domain .suspend_noirq()/.resume_noirq() callbacks
> (genpd_suspend_noirq()/genpd_resume_noirq()) invoke the driver's
> .suspend_noirq()/.resume_noirq() callbacks and call
> genpd_stop_dev()/genpd_start_dev() before and after them, respectively.
> 
> Calling genpd_stop_dev()/genpd_start_dev() allows devices whose power is
> controlled by generic power domains to be powered off and on during
> system suspend and resume, even though their runtime PM usage count does
> not reach zero.
> 
> Since the runtime PM usage count is incremented in device_prepare() and
> decremented in device_complete(), runtime PM operations performed from
> the driver's .suspend_noirq()/.resume_noirq() callbacks are no-ops. The
> actual power transitions are handled by the generic power domain
> .suspend_noirq()/.resume_noirq() callbacks.
> 
> Moreover, attempting to runtime resume a device while runtime PM is
> disabled may return -EACCES. This may cause system resume to fail when
> resuming after a failed Root Port reset, as described in a subsequent
> patch adding hot-plug support.
> 
> Remove the runtime PM calls from the driver's
> .suspend_noirq()/.resume_noirq() callbacks and rely on the generic power
> domain callbacks to power the device off and on.
> 
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v3:
> - none, this patch is new
> 
>  drivers/pci/controller/pcie-rzg3s-host.c | 50 ++++++++++++++++++------
>  1 file changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 830cd7c76699..bbc5bcec03f1 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1961,19 +1961,32 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>  	if (ret)
>  		goto config_reinit;
>  
> -	ret = pm_runtime_put_sync(dev);
> -	if (ret)
> -		goto power_resets_restore;
> +	/*
> +	 * Since:
> +	 * - the runtime PM usage count was incremented by
> +	 *   pm_runtime_get_noresume() in the system suspend/resume code before
> +	 *   executing the subsystem-level .prepare() callback
> +	 *   (in device_prepare()),
> +	 * - runtime PM has been disabled by the system suspend/resume code
> +	 *   before executing the subsystem-level .suspend_late() callback
> +	 *   (in device_suspend_late()), and
> +	 * - the PCIe driver's runtime PM state remains RPM_ACTIVE (it was
> +	 *   runtime resumed in probe()),
> +	 *
> +	 * any runtime PM operation becomes a no-op and may lead to unexpected
> +	 * failures.
> +	 *
> +	 * Let the power domain's genpd_suspend_noirq() callback disable the
> +	 * clocks, as it already does.
> +	 */

I believe you can shorten the comment. Like:

	/*
	 * Since the power domain's genpd_suspend_noirq() will disable clocks,
	 * there is no need to manually invoke runtime PM API here.
	 */

>  
>  	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
>  	if (ret)
> -		goto rpm_resume;
> +		goto power_resets_restore;
>  
>  	return 0;
>  
>  	/* Restore the previous state if any error happens */
> -rpm_resume:
> -	pm_runtime_resume_and_get(dev);
>  power_resets_restore:
>  	reset_control_bulk_deassert(data->num_power_resets,
>  				    host->power_resets);
> @@ -2011,13 +2024,28 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
>  			goto assert_rst_rsm_b;
>  	}
>  
> -	ret = pm_runtime_resume_and_get(dev);
> -	if (ret)
> -		goto assert_rst_rsm_b;
> +	/*
> +	 * Since:
> +	 * - the runtime PM usage count was incremented by
> +	 *   pm_runtime_get_noresume() in the system suspend/resume code before
> +	 *   executing the subsystem-level .prepare() callback
> +	 *   (in device_prepare()),
> +	 * - runtime PM has been disabled by the system suspend/resume code
> +	 *   before executing the subsystem-level .suspend_late() callback
> +	 *   (in device_suspend_late()),
> +	 * - on resume pm_runtime_enable() is called after executing the
> +	 *   subsystem-level .resume_early() (in device_resume_early())
> +	 *
> +	 * any runtime PM operation becomes a no-op and may lead to unexpected
> +	 * failures.
> +	 *
> +	 * Let the power domain's genpd_resume_noirq() callback enable the
> +	 * clocks, as it already does.
> +	 */

Same as above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
