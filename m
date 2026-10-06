Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5E49C4DF;
	Tue,  6 Oct 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302089; cv=none; b=VKwDAUZ6l27V1yXuwjQ/g3zdySXILyU8bUCVdi3lRvzRH0SpaNesAxfsftgZ0L60jLTklOOqlal9Ud26T7D6LGQ28NyrxTUateysQOAF7IvC9pePJNNGPNugHGeQdS9tUMAelKVYLL7J4YC6xHQSotdchz8jGHPpGBwhp0Ux5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302089; c=relaxed/simple;
	bh=vYDzEwXZ1IV+3fpCFqnbA405TlaexK4ROIl/0m07UgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fGAuwgqS3Y2gbQm4zYVjEB4JDQ4iKfx39ycxmZDE6nHvrf7d6XCzZvDzpSphYSem1kNfj30zl3/H6dbt42bWUhb6P7StuHEgqptoT6OLp5W1sfD3EnH3OFsjh+6m+YGalxSTd+ZFMK5A4cU3P1NgmYu7fKGFRvMhCPiHB3aJcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmnqSnp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmnqSnp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832FE1F0089B;
	Tue,  6 Oct 2026 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302087;
	bh=clRq7rLolI7UK6CY7Y84Un2wUkXIEjH+9LwAXBd+654=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=kmnqSnp8AQWKgKdWrXoR3wDP+wjZUfn0pa14Qbsbq0r/YRFOUxfueCxsdsEknVCXS
	 t7PP0lZ60nZVeVas9F+t2Vfv5o2EPyNvh2FhdIqQilg6Zh2lHGXbDkPTowRhjGmder
	 z8oDV+mQ8xqoyLn7+5SUpvn6xTr/npXpvaWIPXEJeOMumGmQV4CNCbJWcj74piLf2t
	 iKdg4RCQQPts16smNQbEtxsGsVa0akn/c0KWEkXDHjMetIynK0hp6K/npScVIlNyKo
	 mwc97d3hDfTvfazgVZx+atdqMV2MlxNiB1/Xf4caiVOm7ghajAcl3q/Y4e3VJD+Ct8
	 ClVrQlwJl7IhQ==
Date: Tue, 6 Oct 2026 10:54:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	bhelgaas@google.com, jbeulich@suse.com, konrad.wilk@oracle.com,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xen/pcifront: check that an AER callback exists
 before calling it
Message-ID: <20261006155446.GA684274@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006023443.338194-1-yhlee@isslab.korea.ac.kr>

On Tue, Oct 06, 2026 at 11:34:43AM +0900, Yehyeong Lee wrote:
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
> Check each callback before calling it.  When mmio_enabled or slot_reset is
> absent, return PCI_ERS_RESULT_RECOVERED so recovery proceeds, as the PCI
> core does for a missing callback; returning PCI_ERS_RESULT_NONE would
> instead make xen-pciback tear the guest domain down.
> 
> Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> v2: return PCI_ERS_RESULT_RECOVERED for an absent mmio_enabled/slot_reset
>     instead of PCI_ERS_RESULT_NONE, which xen-pciback treats as fatal and
>     uses to tear the domain down.  (Bjorn acked v1; the ack is dropped here
>     because v2 changes the value returned for an absent callback.)
> v1: https://lore.kernel.org/all/20261005133019.284053-1-yhlee@isslab.korea.ac.kr/
> 
> There is an in-flight fix for a refcount leak in this same function
> ("xen/pcifront: Fix PCI device reference leak in AER handling"); this
> change is orthogonal and applies in either order.
> 
>  drivers/pci/xen-pcifront.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index cffc32d660327..5c6f7796d204a 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -599,11 +599,16 @@ static pci_ers_result_t pcifront_common_process(int cmd,
>  		case XEN_PCI_OP_aer_detected:
>  			return pdrv->err_handler->error_detected(pcidev, state);
>  		case XEN_PCI_OP_aer_mmio:
> -			return pdrv->err_handler->mmio_enabled(pcidev);
> +			if (pdrv->err_handler->mmio_enabled)
> +				return pdrv->err_handler->mmio_enabled(pcidev);
> +			return PCI_ERS_RESULT_RECOVERED;
>  		case XEN_PCI_OP_aer_slotreset:
> -			return pdrv->err_handler->slot_reset(pcidev);
> +			if (pdrv->err_handler->slot_reset)
> +				return pdrv->err_handler->slot_reset(pcidev);
> +			return PCI_ERS_RESULT_RECOVERED;
>  		case XEN_PCI_OP_aer_resume:
> -			pdrv->err_handler->resume(pcidev);
> +			if (pdrv->err_handler->resume)
> +				pdrv->err_handler->resume(pcidev);
>  			return PCI_ERS_RESULT_NONE;
>  		default:
>  			dev_err(&pdev->xdev->dev,
> -- 
> 2.43.0
> 
