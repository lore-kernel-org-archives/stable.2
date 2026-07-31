Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E068444709;
	Fri, 31 Jul 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513736; cv=none; b=p1WaSkiS+ISk65NJ9bdT5du70b0SP+b+z+FlAOCXbDAS0S7rvewrhpwdM4usF5eGesCykALkgv2dTfSNxvQ5Xr9fltobwHH7JvL3OY1y5tg7Ka2y8ovOWArREqw3Mb5uHZ+3HPHaL8TznGSDwSRi7HgZRERXCgtSGlnPEKmGQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513736; c=relaxed/simple;
	bh=aUrsj6hOs7zgVK4qJTB8J6079mkyoSTCyi7JwIAKk58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt2Fus0moINS5fwDk9L9WaIaxBUkoEPvpm0h55iIszQ+/CFAphwZbPqniM29kADwneWJAUjEcqArYKWiq9MF0XxkXbKzypsya4FUPZzr2aehnZL4x1KAeWFAAC7Cg1TlJxXZNIsFdpk45egvT3aF+JWTJPou8XMGhADtZ8hpBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E541F00AC4;
	Fri, 31 Jul 2026 16:02:10 +0000 (UTC)
Message-ID: <d1a5c1c4-4a9f-4dc7-b709-4f89a25ad4c9@tuxon.dev>
Date: Fri, 31 Jul 2026 19:02:08 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: rzg3s: Fix IRQ domain initialization error
 handling
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 stable@vger.kernel.org
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 7/27/26 12:58, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
> parent interrupts before creating the INTx irqdomain and initializing
> MSI support.
> 
> If any subsequent step fails, such as obtaining an INTx IRQ,
> creating the irqdomain, or initializing MSI, the error path returns
> without removing any chained handlers that were already installed.
> This leaves stale handler and data pointers attached to the parent
> interrupts.
> 
> Fix the error path by unwinding the chained handler registration before
> returning. Also clear the chained handlers during
> rzg3s_pcie_teardown_irqdomain() so that teardown fully mirrors the
> initialization sequence.
> 
> Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Restricted the code to max 80 columns.
> - Moved calling irq_domain_remove() under err_cleanup_intx label.
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 49 +++++++++++++++++-------
>   1 file changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index f51b5d7c1998..70f1faf7e422 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1006,22 +1006,35 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
>   	.xlate = irq_domain_xlate_onetwocell,
>   };
>   
> +static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *host,
> +					   int count)
> +{
> +	while (--count >= 0) {
> +		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
> +						 NULL);
> +	}
> +}
> +
>   static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
>   {
>   	struct device *dev = host->dev;
>   	struct platform_device *pdev = to_platform_device(dev);
> +	int i, ret;
>   
> -	for (int i = 0; i < PCI_NUM_INTX; i++) {
> +	for (i = 0; i < PCI_NUM_INTX; i++) {
>   		char irq_name[5] = {0};
>   		int irq;
>   
>   		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
>   
>   		irq = platform_get_irq_byname(pdev, irq_name);
> -		if (irq < 0)
> -			return dev_err_probe(dev, irq,
> -					     "Failed to parse and map INT%c IRQ\n",
> -					     'A' + i);
> +		if (irq < 0) {
> +			ret = irq;
> +			dev_err_probe(dev, ret,
> +				      "Failed to parse and map INT%c IRQ\n",
> +				      'A' + i);
> +			goto err_cleanup_intx;
> +		}
>   
>   		host->intx_irqs[i] = irq;
>   		irq_set_chained_handler_and_data(irq,
> @@ -1033,21 +1046,29 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
>   						     PCI_NUM_INTX,
>   						     &rzg3s_pcie_intx_domain_ops,
>   						     host);
> -	if (!host->intx_domain)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Failed to add irq domain for INTx IRQs\n");
> +	if (!host->intx_domain) {
> +		ret = -EINVAL;
> +		dev_err_probe(dev, ret,
> +			      "Failed to add irq domain for INTx IRQs\n");
> +		goto err_cleanup_intx;
> +	}
>   	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
>   
>   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		int ret = rzg3s_pcie_init_msi(host);
> +		ret = rzg3s_pcie_init_msi(host);
>   
> -		if (ret) {
> -			irq_domain_remove(host->intx_domain);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_cleanup_intx;
>   	}
>   
>   	return 0;
> +
> +err_cleanup_intx:
> +	if (host->intx_domain)
> +		irq_domain_remove(host->intx_domain);
> +	rzg3s_pcie_clear_intx_handlers(host, i);

If you have it like this it worth squashing these lines in the same function, e.g.:

	rzg3s_pcie_teardown_intx(host, i);

defined something like:

void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
{
	if (host->intx_domain)
		irq_domain_remove(host->intx_domain);	


	while (--count >= 0) {
		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
						 NULL);
	}
}

> +
> +	return ret;
>   }
>   
>   static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
> @@ -1055,6 +1076,8 @@ static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
>   	if (IS_ENABLED(CONFIG_PCI_MSI))
>   		rzg3s_pcie_teardown_msi(host);
>   
> +	rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
> +
>   	irq_domain_remove(host->intx_domain);

And use the same function here, replacing:

-	rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
-
-   	irq_domain_remove(host->intx_domain);
+	rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);

Btw, the order b/w rzg3s_pcie_clear_intx_heandlers() and irq_domain_remove() was 
revered here compared with the order from rzg3s_pcie_init_irqdomain().
Thank you,
Claudiu
