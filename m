Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188A423EA2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625957; cv=none; b=HHMi1OW2lL6sqSoKi2z/oj5+48f2OLWesovqAPSkN+HWIUiAIyNbOMxTNpaDmsKD1RprywWK1Oxrn2oQZvn03pMu8diBLJUo+kozc26V65dcV/XaFNr5AJH0WWVrJlRYvAbPHnL3R9yhXl8b383xUlfM9aX9ra737tOkXPTqsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625957; c=relaxed/simple;
	bh=rbq93EyDhFZfv07sIH5xHZpeMEQ6yMzh874KrqTNz8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RheFR0PmKcMGqdV+0bCnV7U/B1xRzkd7eoew/P1XeSA3PHaraD4gSMweFjn6zGEX8teXjg6XDHCbelYB4oJxbv99tb0ipDlVZbreTO6ldtweiTOyJMcZrULPz9PwWGr2LtJ8ZQwS4L00fnR7V2oYbK4YHz6VL5qX2jTMpa/U+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vh8VapsP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vh8VapsP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789625956; x=1821161956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbq93EyDhFZfv07sIH5xHZpeMEQ6yMzh874KrqTNz8M=;
  b=Vh8VapsPpGg9ME6c0SJv/1Mx1vdbG3Zb9liqpRv7C47sb/KnTkFYSgYY
   T6i27NB2sU6boCpqHqtS7nIY5ZRGUWtqZU/HAY7OHsZAvKE5cmUf7whh9
   pvoH/CBwtrZLyWENJMx/KEt0+tsrHqjaPnf8GCOVsQDZjwWHDJt6KLNQc
   1gD4zBr2khfiTz2Wggs30PmBTqS7vSrIr6BGSel8d/RRZs8dgW5jKavGp
   7AlOgy7nGSyPOiNSJ7VU3MSTMQbdlHWB/PuVkk8nlD7F+O5kHCVNlF2jO
   jfbzyIx8NiPiOloEHIBK3ozQV6eVwM1eeOSURHktIP+Ut1jBsLo5DSNtg
   g==;
X-CSE-ConnectionGUID: EIjK8zFJQ9ybwLAKLJBINg==
X-CSE-MsgGUID: wNYgiOtkRi2ksrsXachnIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107519959"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107519959"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:19:15 -0700
X-CSE-ConnectionGUID: 3r/4Pr2iTeSqwwo1I9uT2g==
X-CSE-MsgGUID: WzIqisipSuCsjacruRjLDA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 23:19:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7BD0D99; Thu, 17 Sep 2026 08:19:11 +0200 (CEST)
Date: Thu, 17 Sep 2026 08:19:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gil Fine <gil.fine@linux.intel.com>
Cc: gil.fine@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] thunderbolt: Fix DMA credit limit to use host
 router value
Message-ID: <20260917061911.GW106095@black.igk.intel.com>
References: <20260916225755.45127-1-gil.fine@linux.intel.com>
 <20260916225755.45127-2-gil.fine@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916225755.45127-2-gil.fine@linux.intel.com>

On Thu, Sep 17, 2026 at 01:57:54AM +0300, Gil Fine wrote:
> Currently, when allocating credits for a DMA tunnel, we reserve credits
> based on the baMaxHI parameter taken from the router that owns the
> ingress adapter of the current hop.
> In a host-to-host topology with a hub in the middle:
> 
>   [Host1] <-> [Hub] <-> [Host2]
> 
> this incorrectly uses the hub's value instead of the host router's.
> The DMA engine limit is defined by the host router baMaxHI.
> 
> Fix this by alway use the baMaxHI of the host router instead.
> 
> Fixes: 6ed541c53edc ("thunderbolt: Allocate credits according to router preferences")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
> Assisted-by: LLM
> ---
>  drivers/thunderbolt/tunnel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index 7a033df7f916..0625b1ff3820 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -175,7 +175,8 @@ static unsigned int tb_available_credits(const struct tb_port *port,
>  	pcie = tb_acpi_may_tunnel_pcie() ? sw->max_pcie_credits : 0;
>  
>  	if (tb_acpi_is_xdomain_allowed()) {
> -		spare = min_not_zero(sw->max_dma_credits, dma_credits);
> +		spare = min_not_zero(sw->tb->root_switch->max_dma_credits,
> +				     dma_credits);

This will make the KUnit tests fail now because sw->tb is NULL.

I think that what we want to do is to make this whole thing a patch series
that adds the shared buffer support so that:

 1. Adds the tb to KUnit tests so that they will pass.
 2. Adds the fixes here these are needed for hosts that do not support
 shared buffers.
 3. Adds shared buffers.

Does that make sense? It means no 7.3 but 7.4 is possible still and you can
always include these in your branch so whoever internal needs can pull them
there. Let me know what you think.
