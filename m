Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C783FE37B;
	Tue, 13 Oct 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901661; cv=none; b=GlQFlkymKA3J69R24RFtA7NcOnhrgJcLX+n4TauXf1H8oUPRCQbleOrAc6HSpD2LDjfs38q6STpoOk7+aAZ2/G5f53DiurSK3e1oV6XsXbGFMeM+nelc/3WkaC+TlWSweL87ySIErmyAgMCat6SqiUAmzV2/9xk0RncO8OaKy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901661; c=relaxed/simple;
	bh=HsyTZHsW3XX/Pry6+WWWklvNeptcBaxn9z09USBbVt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNgBL6TwBmMZGf4X8bbH27JVh8JD2KU/60sDUoPnX/Ne2AP7OClnwIRe2iEJ9WFq6aQexQpB+iYStgkvBi+/0wUv5n1J/7eHgVDJ+u8wUHH41DcoEbb0eTlceF1sXCXTbx+Bs76ZnsB0AwmRc20IX/9ycZlib6xRzh8MafsVKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8506568AFE; Tue, 13 Oct 2026 16:27:36 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:27:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] nvmet: pci-epf: report transport errors in command
 completions
Message-ID: <20261013142736.GE14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-5-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-5-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I think this looks good.  Damien/Niklas, can you test this on hardware?

On Mon, Oct 12, 2026 at 04:12:31PM +0200, Andrea Parri wrote:
> When the PCI endpoint target fails a command itself, the host receives a
> successful completion. This happens for a data length above MDTS,
> malformed PRPs or SGLs, a buffer allocation failure, an SQ that is not
> live, and a failed DMA of the command data. A write whose data cannot be
> fetched from the host is thus reported as written, though nothing was
> executed.
> 
> Each of these paths sets iod->status and calls
> nvmet_pci_epf_complete_iod(), which then reloads iod->status from
> iod->cqe.status. The nvmet core only fills that field when it completes
> the request, which these paths never do, so it is still zero and
> nvmet_pci_epf_cq_work() posts a success status to the host.
> 
> Drop the reload. Every path already sets iod->status before completion:
> nvmet_pci_epf_queue_response() copies it from the request's CQE, and
> the transport error paths set it themselves.
> 
> Found by code inspection. Build-tested only (x86_64, W=1): no PCI
> endpoint hardware was available to run it.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/nvme/target/pci-epf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index c683450df4227..4c5fff232fb99 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1152,7 +1152,6 @@ static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
>  	unsigned long flags;
>  
>  	/* Print an error message for failed commands, except AENs. */
> -	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
>  	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
>  		dev_err(iod->ctrl->dev,
>  			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
> -- 
> 2.53.0
---end quoted text---
