Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8651AFDF;
	Fri, 18 Sep 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751258; cv=none; b=Aa/g7j9vFsZjavre69encmjK1/Lqs/8zccHHsg7iwIGMmzq/9RsSfJa4iCW50lAPicK/T6DDEbhF0q3lXtcAz5WrSqNb08FwHwhP3DVpJpBISlsvQ1bc0SGhU2hDl81oJ1gFlUzy1UNmAuwpOf9SoeBPxR1BUhLiYii//3YipMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751258; c=relaxed/simple;
	bh=9KqTeLpmpAt/SYWbyJGONbejx8uvk0rw6an2fqvZBiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EmqB3SWxtrgvX94PCrQY+oRObY3AOuN//Cjce9uMML4xoqEielntPm2PA4Xdl7nkancfOXnjyaW6VtCXoaR/DKJJaWQM256qpNEBUpzQeyLpEZ3Fgw8MEqDWMMYen1WgLVqTt3ou7ai0G7ttnm50k2yEYoO0KQQtb7+VawLAkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT2SqrcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT2SqrcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953BC1F00899;
	Fri, 18 Sep 2026 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789751256;
	bh=P31W4icnBaQHEkDlX+eUtB5tLta/gaMyYNRj3JwR7ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fT2SqrcGO0qrSy9HtSfOYyd2Ep5s7+jVKap9ZfTRyaBm80BcHBaBlyKOo8yQPXsyz
	 aIsAH8AxmvKvWi0RrF2sWBvsqB5RkZndUkM6VvG4iCf114LnEheEMBpBW9U4HNx1yX
	 /Gi9aBTMirhoOPGSk+An1y7ap0Q7uwgytcTT/uUxouQIf+jbtuXTYt9LKYJ1eQAX/X
	 MlURb6vXpviwx1kpZfm8NdbceXt3X/5Bf70tEQbpwDXLbQSekL6BsCE8DKY4B5UzpU
	 2KHpja1FhXJuNBOfj65nBvbnNat+qdc8FJuCIDyio1JVSJef91+6F48FEkF/2SvUS7
	 LWgkGQH8pjIZw==
Date: Fri, 18 Sep 2026 12:07:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jerry.jiang@amd.com, haijun.chang@amd.com,
	andy.zhang@amd.com, jim.chow@broadcom.com,
	matthew.mcclure@broadcom.com, gbayer@linux.ibm.com,
	Nikola Prica <nikola.prica@amd.com>
Subject: Re: [PATCH v3] PCI: Accept AtomicOps already enabled by the
 hypervisor
Message-ID: <20260918170735.GA1162623@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021a25-3800-4eb1-9dcd-a2c9fd8eedbc@amd.com>

On Fri, Sep 18, 2026 at 02:07:46PM +0200, Christian König wrote:
> On 9/18/26 11:28, Nikola Prica wrote:
> > From: Nikola Prica <nikola.prica@amd.com>
> > 
> > pci_enable_atomic_ops_to_root() currently fails when no Root Port is
> > visible. That is common in passthrough guests (ESXi, Hyper-V): the
> > endpoint is assigned to the VM, but the guest topology has no Root
> > Port above it.
> > 
> > In those setups the hypervisor may already have enabled AtomicOp
> > Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
> > treat AtomicOps as already enabled and return success instead of
> > failing the Root Port walk.
> > 
> > Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> > Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
> > Signed-off-by: Nikola Prica <nikola.prica@amd.com>
> 
> CC: stable@vger.kernel.org # 7.1+
> 
> Bjorn do you want to pick that up? Alternative I can push it through
> drm-misc-fixes.
> 
> Initially I thought that this is a new feature, but it turned out to
> be an regression and we need to get it fixed ASAP.

Let me just talk through this to make sure I understand it:

Prior to 1ae8c4ce1570, pci_enable_atomic_ops_to_root() enabled
PCI_EXP_DEVCTL2_ATOMIC_REQ unless a switch port didn't support
AtomicOp routing, a switch upstream port blocked AtomicOp egress, or a
Root Port didn't support the requested sizes.

1ae8c4ce1570 added the requirement that the Root Port be visible,
which fixed an s390 case where pci_enable_atomic_ops_to_root() enabled
AtomicOps when the Root Port did not support them but was not visible
to the kernel.

IIUC the regression is on systems where the Root Port is not visible
but *does* support AtomicOps.  Prior to 1ae8c4ce1570, we would have
enabled AtomicOps in the endpoint and returned success.  After
1ae8c4ce1570, we return -EINVAL because we can't see the Root Port to
verify its support, so the driver thinks it can't use AtomicOps.

This patch fixes the regression by assuming that if we can't see the
Root Port but the endpoint already has AtomicOps enabled, the
hypervisor or host kernel that *can* see the Root Port has already
verified its AtomicOps support, so all we have to do is return success
so the driver can use them.

I'm happy to merge this for v7.3, and I think we should add something
like this to the commit log to make it clear that it's a regression
worthy of a post-merge window fix:

  After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
  supports them"), pci_enable_atomic_ops_to_root() always fails if the
  Root Port is not visible.  On systems where the Root Port is not
  visible but *does* support AtomicOps, this is a regression: prior to
  1ae8c4ce1570, it enabled AtomicOps in the endpoint and returned
  success.

Is there any problem report for the regression?  I don't see anything
at https://linux-regtracking.leemhuis.info/regzbot/mainline/, so my
guess is no.

> > ---
> > v3: Add Fixes tag
> > v2: Be more strict and only apply logic in headless device case.
> > ---
> >  drivers/pci/pci.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b2879a6be5f8..62729ade496f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
> >  	}
> >  
> >  	root = pcie_find_root_port(dev);
> > -	if (!root)
> > +	if (!root) {
> > +		/*
> > +		 * A hypervisor may expose a headless topology with no
> > +		 * visible root port.  If it has already set AtomicOp
> > +		 * Requester Enable, there is nothing more to do.
> > +		 */
> > +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> > +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> > +			return 0;
> > +
> >  		return -EINVAL;
> > +	}
> >  
> >  	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
> >  	if ((cap & cap_mask) != cap_mask)
> 
