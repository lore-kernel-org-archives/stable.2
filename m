Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C731D730;
	Mon,  5 Oct 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227162; cv=none; b=Iqs/ikb9Ez2q32XCLzxgPQPhEqGlRB6/SHRZt2KTQ0YXEw01/NFDN7xSLFxMGr0X7QwFGY2eB2ITPhxfC8t+q9n4Pw9Vj6SLaYV+Gz78uSd+YPNLGIdQ527KphTQIMzr4cbihAM8E1keqk1dmQI+Kzqdwrro0KH2cRx7j3YtLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227162; c=relaxed/simple;
	bh=jd3cIebWslGe2SluqUeOouUcjNDtvQn8n5sEySelsZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O8MgJAELuMxJDmFXIBiMWfqgxuy/TpZMoS23YHmQIkY3KpQA1KbmSXHiQp+J8GvocjTBF9SdkOrq0XRbvApsnXgGb4IqqJzxcyh7BV57gMpuf7H+rtVzYVLnHdE17VH+Nbz5O6BFKyvKd9whJRWHDEwX03OwrcWKpLkzyVirBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHHkwOPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHHkwOPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F0E1F000FF;
	Mon,  5 Oct 2026 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791227160;
	bh=SNODs5FbLpBfmraE85X0V3Oi5UUM7z6D6PE8VhoZEoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=nHHkwOPuimd70cQZVRVzcCQ1MH+35tAUZ/tpFxE2p8QJbR9YZG5YKTOa5xAN5GzjV
	 4tW9WcKuG/a90atgTnVKXYmXqT6iZcc9gcEAUYBJHF4gsGCXqsqPvXsO9rLgIz7joC
	 8xVGt0EtEVvsk8p1zgFVzhPcUuDm8Zqg+v57EFVGzfmfosV6HXHBqa1qR1f5KoXU9Y
	 QQbhJGBwEWa63xjLl8gUhPPU+KKT9yu6UambZmUAFCJ2wu+Nribtw4AQr5s2ljSy1P
	 daMYHhqYhSFt1dQckdGBR1I6J2fTYEEA+brz22UvLqQyLW6qeiMjB3gLkd3kyxw8T9
	 xg77jhZ2FI9ZQ==
Date: Mon, 5 Oct 2026 14:05:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	bhelgaas@google.com, jbeulich@suse.com, konrad.wilk@oracle.com,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jan Beulich <JBeulich@novell.com>
Subject: Re: [PATCH] xen/pcifront: check that an AER callback exists before
 calling it
Message-ID: <20261005190559.GA601702@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005133019.284053-1-yhlee@isslab.korea.ac.kr>

On Mon, Oct 05, 2026 at 10:30:18PM +0900, Yehyeong Lee wrote:
> pcifront_common_process() handles an AER request from the backend by
> dispatching on aer_op.cmd to the bound driver's PCI error handler.  It
> only checks that err_handler and err_handler->error_detected are present,
> then for the mmio_enabled, slot_reset and resume commands it calls the
> corresponding callback unconditionally.  Those three callbacks are
> optional -- the PCI core NULL-checks each of them individually before
> use -- and many drivers (for example igb, igc, ice and ixgbevf) install
> error_detected without all of them.
> 
> aer_op.cmd comes from the shared ring, so a malicious or buggy backend
> can send XEN_PCI_OP_aer_mmio (or _slotreset/_resume) for a device whose
> driver leaves that callback NULL and make the frontend call through a
> NULL pointer, crashing the guest.
> 
> Check each callback before calling it, as the PCI core already does, and
> fall through to PCI_ERS_RESULT_NONE when it is absent.
> 
> Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Seems right to me, but I assume the Xen folks will pick this up.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> There is an in-flight fix for a refcount leak in this same function
> ("xen/pcifront: Fix PCI device reference leak in AER handling"); this
> change is orthogonal and applies in either order.
> 
>  drivers/pci/xen-pcifront.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index cffc32d660327..490913676f244 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -599,12 +599,17 @@ static pci_ers_result_t pcifront_common_process(int cmd,
>  		case XEN_PCI_OP_aer_detected:
>  			return pdrv->err_handler->error_detected(pcidev, state);
>  		case XEN_PCI_OP_aer_mmio:
> -			return pdrv->err_handler->mmio_enabled(pcidev);
> +			if (pdrv->err_handler->mmio_enabled)
> +				return pdrv->err_handler->mmio_enabled(pcidev);
> +			break;
>  		case XEN_PCI_OP_aer_slotreset:
> -			return pdrv->err_handler->slot_reset(pcidev);
> +			if (pdrv->err_handler->slot_reset)
> +				return pdrv->err_handler->slot_reset(pcidev);
> +			break;
>  		case XEN_PCI_OP_aer_resume:
> -			pdrv->err_handler->resume(pcidev);
> -			return PCI_ERS_RESULT_NONE;
> +			if (pdrv->err_handler->resume)
> +				pdrv->err_handler->resume(pcidev);
> +			break;
>  		default:
>  			dev_err(&pdev->xdev->dev,
>  				"bad request in aer recovery operation!\n");
> -- 
> 2.43.0
> 
