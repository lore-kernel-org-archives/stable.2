Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B463630AC;
	Sat, 19 Sep 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858975; cv=none; b=ZwHaP0CncVAZIchWZu2EWkKGKT6JX1DZ+XSpspC1NoB846IPJT5CJZeq8/0jcmJJFRBTaEg3dm7sDBsgNRM0Qkqa6L2opTetUSUPXcv+datBM95GqIBCiVJxy5I511yb4F/351oslyiBhnnDkfvCaqrgCsd/2lWDAhG9s11/+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858975; c=relaxed/simple;
	bh=aLcHy+tRIvfthrGREUYSdcd+VtIPry1piG+pXHYG38g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCiMtaxSthJ1AXjPVBdoAdqky12brShupTohPidt3Y85V1i/1wYwTkNjGEukx7c8F7RVUWS6gulYrYaELzBlNQMk7gjsJih7t/hpz7Nk0F3txUPGUeWaNmvm+u+eIE0AzP3gT8tIYs8WVRXqBphjGgMmpdkmRdK0HiFfZrr5BL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuJIstdr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuJIstdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B46A1F000FF;
	Sat, 19 Sep 2026 23:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789858973;
	bh=UdaaWIUOK9NvtNlCweVVV4He/hsXV40fNOtj8Y5b8LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DuJIstdrDYIQK29WTnhvCenUcGbEDVptA6TEKHI18CDKRiJblksJji/AEZKHMY9kH
	 MigDsgiO1/NADHC6uHVq2iy2UR8Re1kO+y9ovKI9dMBtLSVgjKSucp/Kx050vbd6Fu
	 0jO0R7mx1hdeDJ2xRS2MRO+ra2+hrc1lfgyTXyEMxR30z96MQBRJS2rZXXv8VDjHUD
	 JPL+mEWg9fUSIIDpmIpEzikNFSZIy5iIAkq4HCH3eHMGsB71BIOyw0yv6uUhkcF2d2
	 wCNVltg7MWYP4s9Nkc64QRAdlxafTkb57rtTLT9GFfqe55zwixEP7V1xjdLb/bW6lR
	 jyG/fEIwrCppw==
Date: Sat, 19 Sep 2026 16:02:51 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Hardik Garg <hargar@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	mhklinux@outlook.com, ssengar@linux.microsoft.com,
	romank@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mshv_vtl: Check per-CPU register page before mmap
Message-ID: <20260919230251.GB1008213@liuwe-devbox-debian-v2.local>
References: <20260911175146.1370148-1-hargar@linux.microsoft.com>
 <3f771293-f5df-4e74-aca7-5d34966d00e0@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f771293-f5df-4e74-aca7-5d34966d00e0@linux.microsoft.com>

On Tue, Sep 15, 2026 at 10:11:36AM +0530, Naman Jain wrote:
> 
> 
> On 9/11/2026 11:21 PM, Hardik Garg wrote:
> > Register-page setup is optional for each CPU. If allocation or
> > registration fails, mshv_vtl_configure_reg_page() warns and leaves that
> > CPU's reg_page NULL, but initial context setup continues successfully.
> > Meanwhile, successful setup on another CPU sets the global
> > mshv_has_reg_page flag.
> > 
> > mshv_vtl_fault() checks this global flag before selecting the requested
> > CPU's register page. With mixed setup results across online CPUs, the
> > check passes even for a CPU with no register page, reaching
> > get_page(NULL) when userspace faults in that mapping.
> > 
> > Check the selected per-CPU register page before taking its reference and
> > return VM_FAULT_SIGBUS if it is absent.
> > 
> > Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> > ---
> >   drivers/hv/mshv_vtl_main.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> > index fc993560a45c..3296ab5c0243 100644
> > --- a/drivers/hv/mshv_vtl_main.c
> > +++ b/drivers/hv/mshv_vtl_main.c
> > @@ -912,6 +912,9 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
> >   		return VM_FAULT_NOPAGE;
> >   	}
> > +	if (!page)
> > +		return VM_FAULT_SIGBUS;
> > +
> >   	get_page(page);
> >   	vmf->page = page;
> 
> 
> LGTM. Thanks.
> 
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Applied. Thanks.
