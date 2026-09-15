Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6E440A24;
	Tue, 15 Sep 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455729; cv=none; b=aC11+J5aNbMqtLZcCSazbWwDqKN7cV7vFhDAzNFEoWAGhP0ui+FENAArf6kvbUP9xaXPD8mrdJhl2KEbPe9Zt3d2v9U8XlKJfVNy9gwQu4tGkFDvkS862CS3oj6vlFOK8CVqf6WHhTo34x3a0elyztzJeyzcqD1JlOvIUEkr3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455729; c=relaxed/simple;
	bh=5QejxhhhrjxhurF21rR3mtASC9z8/pTldgpDUvKQiWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvnk4b2p5PNrREqbDxOJs6lbkvDIeAd0TRM880c5Z0vIc2fQq88rLLAwzSbI2ksQ1/GrwHGOIVXrdvGcla4kIu+QK8Buao9RMBd1fLp8ueQSCq+lEJhGAMXUOO6gYnurppIIlh9PT8SGisLc1SGCjUR677Fxr5bVc7JlDxO97Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRcf7YWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRcf7YWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617FC1F000FF;
	Tue, 15 Sep 2026 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455727;
	bh=BFaFvx45tg9q2foNkycuX3E8yE8Hbpo+wg9dSs9F8fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FRcf7YWfFN3pOd0uI9YkJQ6MOUV/+BdSYNxxySNLSSfzSy1T5hvaZS+21E41bOdvn
	 oCAxrqTzib0CSpgD/555UBJtPMr/mpKoUU2sKQIrJQ/Y4NkiukjcJryxCImywuAAq9
	 QkFjzok3NiIDI/j+THV3avbpJuQeNgtz9XJvNeOLxKl8Wp+H9RLm2N0wfCCEcnQJcL
	 WeGsPVsYP1GxeUe3mzHrc24kIZdVeHgwK5B9IJqCnxQgI+TsSdwQxxC72rgo9PlgqN
	 FPRgUn3qocSgopFGgexMIVmRdEjCGmAP6C07kBeLNn6J46ZyQyafydxSru+3eloWQj
	 ifgVqKFlBQRlg==
Date: Tue, 15 Sep 2026 00:02:06 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: Fix PCI device reference leak in
 cdns3_pci_probe()
Message-ID: <aqjtblfa0Yt5gT1U@hu-petche-lv.qualcomm.com>
References: <20260914112320.4176773-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914112320.4176773-1-make_ruc2021@163.com>

On 26-09-14 19:23:20, Ma Ke wrote:
> cdns3_get_second_fun() looks up the second PCI function with
> pci_get_device(), which returns the device with a reference held, and
> hands it back to its callers. Neither cdns3_pci_probe() nor
> cdns3_pci_remove() ever drops that reference, so the second function's
> pci_dev can never be released.
> 
> The cdnsp-pci.c driver handles the same situation correctly:
> cdnsp_pci_probe() jumps to a 'put_pci:' label that calls
> pci_dev_put(), and cdnsp_pci_remove() calls pci_dev_put() as well.
> 
> While at it, also add the missing NULL check in cdns3_pci_remove().
> pci_is_enabled() dereferences its argument, so if
> cdns3_get_second_fun() returns NULL, the current code may crashes.
> cdnsp_pci_remove() guards with "!func ||".
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

If you have used LLM tools, please add Assisted-by tag for it, otherwise:

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter

> ---
>  drivers/usb/cdns3/cdns3-pci-wrap.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> index eb5760f75b9d..d18c15fb9365 100644
> --- a/drivers/usb/cdns3/cdns3-pci-wrap.c
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -89,7 +89,7 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
>  	err = pcim_enable_device(pdev);
>  	if (err) {
>  		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
> -		return err;
> +		goto put_pci;
>  	}
>  
>  	pci_set_master(pdev);
> @@ -98,8 +98,10 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
>  		wrap = pci_get_drvdata(func);
>  	} else {
>  		wrap = kzalloc_obj(*wrap);
> -		if (!wrap)
> -			return -ENOMEM;
> +		if (!wrap) {
> +			err = -ENOMEM;
> +			goto put_pci;
> +		}
>  	}
>  
>  	res = wrap->dev_res;
> @@ -160,11 +162,13 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
>  		if (IS_ERR(wrap->plat_dev)) {
>  			err = PTR_ERR(wrap->plat_dev);
>  			kfree(wrap);
> -			return err;
> +			goto put_pci;
>  		}
>  	}
>  
>  	pci_set_drvdata(pdev, wrap);
> +put_pci:
> +	pci_dev_put(func);
>  	return err;
>  }
>  
> @@ -179,8 +183,10 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
>  	if (wrap->devfn == pdev->devfn)
>  		platform_device_unregister(wrap->plat_dev);
>  
> -	if (!pci_is_enabled(func))
> +	if (!func || !pci_is_enabled(func))
>  		kfree(wrap);
> +
> +	pci_dev_put(func);
>  }
>  
>  static const struct pci_device_id cdns3_pci_ids[] = {
> -- 
> 2.43.0
> 

-- 

Thanks,
Peter Chen
