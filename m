Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D12BD022;
	Thu,  1 Oct 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871819; cv=none; b=PZIjShoZXz2C5lvKHlFaZzqHYAvNPx1h16TNqzP8d1jN/vNVCM5ZwCaquUptt6ewTAm1mTSCJTVp9IH7bn5hUTUw72AkobJXRCsYHZPS7ZfTH+d8iEWSSvBnSWWgU0FG0Tm3mhi1e+6isFysbyaTmj/+YsslKuBnuam/u8MWWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871819; c=relaxed/simple;
	bh=2YNI7pB6efh2PLKthQqPV3hJUbC1LkdRRgWLeml4KcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qzvhozV6DRW+gv2TIeI2LH0EujLAgSJtvDYsFypPhknt0+5Yr+XKkazlFwbmntyTWzde9Sz+ZpimgrQTrR9u5NL43g+vMV8iOr44qeWSyZtw9zY5lqpz8UpOdV3jpZ27uk5Pxt+9sQQH8qmpjY8vqiFWMHWFHh8oxQ53XRYMdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD0Z2qnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD0Z2qnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AC31F000FF;
	Thu,  1 Oct 2026 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871814;
	bh=oViQG46mglwKreUchYO11Hqs4mHMpQhSXG2+xTbUjf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RD0Z2qncsM3PctrR28TbKTitwf8mKG575RALyVD7/tjLtXEsdVQlsm6e5TYqxWi5T
	 Z0FQlJl1vaQlrGUrOvRSCjyeYswJQVXZ1ViTzK9h9w0cu2hPTuiwrFwvY/3MoUGCnD
	 G2SkmxJYWtNlt9aRxBMiNDVq+Q759QxUoS0Z/oEgoyhsvTUGeK+g+GHyc4tkiXq5sw
	 V+evUQNpMI28kcTLBfrVo0dqnxTgBZwAbkFajEJt+NtXtf2D3b3Ln6Oc5gEscpV5Lb
	 ofEAJrIFJ205rzH3WiyKPq8uAZx50JUZ8rEkh/6MEMrDSbRq86l0xv9ROYIaZMDitb
	 Sw3lrRQ+0TgNg==
Date: Thu, 1 Oct 2026 11:23:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nikola Prica <nikprica@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jerry.jiang@amd.com, haijun.chang@amd.com, andy.zhang@amd.com,
	christian.koenig@amd.com, jim.chow@broadcom.com,
	matthew.mcclure@broadcom.com, gbayer@linux.ibm.com,
	regressions@lists.linux.dev, Nikola Prica <nikola.prica@amd.com>
Subject: Re: [PATCH v4] PCI: Accept AtomicOps already enabled by the
 hypervisor
Message-ID: <20261001162333.GA2692735@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921111903.978687-1-nikprica@amd.com>

On Mon, Sep 21, 2026 at 01:19:03PM +0200, Nikola Prica wrote:
> From: Nikola Prica <nikola.prica@amd.com>
> 
> pci_enable_atomic_ops_to_root() currently fails when no Root Port is
> visible. That is common in passthrough guests (ESXi, Hyper-V): the
> endpoint is assigned to the VM, but the guest topology has no Root
> Port above it.
> 
> In those setups the hypervisor may already have enabled AtomicOp
> Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
> treat AtomicOps as already enabled and return success instead of
> failing the Root Port walk.
> 
> After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
> supports them"), pci_enable_atomic_ops_to_root() always fails if the
> Root Port is not visible.  On systems where the Root Port is not
> visible but *does* support AtomicOps, this is a regression: prior to
> 1ae8c4ce1570, it enabled AtomicOps in the endpoint and returned
> success.
> 
> Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Nikola Prica <nikola.prica@amd.com>

Applied to pci/for-linus for v7.3, thank you!

I tweaked the last paragraph to be more explicit about the regression
behavior (as I understand it):

  After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
  supports them"), pci_enable_atomic_ops_to_root() always returns
  failure if the Root Port is not visible, so drivers don't use
  atomics when they could.

> ---
> v4: Updates commit log to make regression point clear
> v3: Add Fixes tag
> v2: Be more strict and only apply logic in headless device case.
> ---
>  drivers/pci/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..62729ade496f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  	}
>  
>  	root = pcie_find_root_port(dev);
> -	if (!root)
> +	if (!root) {
> +		/*
> +		 * A hypervisor may expose a headless topology with no
> +		 * visible root port.  If it has already set AtomicOp
> +		 * Requester Enable, there is nothing more to do.
> +		 */
> +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +			return 0;
> +
>  		return -EINVAL;
> +	}
>  
>  	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>  	if ((cap & cap_mask) != cap_mask)
> -- 
> 2.34.1
> 
