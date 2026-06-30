Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464344102A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833601; cv=none; b=PYxlf3Aun5Kgf9uVf/OHFT34867oNXSJNhnhOEEMS1XLY6j2qTuVLibwuxuYgXki3PWKR9cN417DKvRD7M3p9RBAMwg9gZZuNWvZKIcO9XylViPoCNt2JN8mYwUuuOF93+2CiUPH98cSt9AjZymEh0YQ6KVoJ8U74tZ3rmQnXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833601; c=relaxed/simple;
	bh=u5e4tGlqn778Ahe+mUV5OcGjPTxwzcOru7Knys+GwPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAIDDR9zMUQQebIVoNil7G7ocjyIHydOGZlekhTER3dGRtpIKln0+IUbwiGpa9n3xTkFHMDudjunN+49McuO4vsUjWNE5fDWKWShMoa1DG7SUNCTmIlOC1DZY2GWAWg6juffHdb9foHT4vH3M0SQZcxpDriuu2Yz9nMCGxI/0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BB8lZFFf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BB8lZFFf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso54675e9.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782833598; x=1783438398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7y23lwVc1qU9pQQZzwFQKSERGQYoPnAW1oWXpZxS+y4=;
        b=BB8lZFFfqZoV4yC2oYhJQMccUlR67bqBys9VwzeITYPhYj4sJxSRqKX6Ngle4c14+r
         Sa2Jd4g3M0U3SQPPN+ypwJhbPahlqOD+wbVLz34prFM9P/6xgkKmQuKbaJ2TLTFLK3Cs
         yZrgwQONifm0rJr0re5FfwiQHIbltnCntKQjiaQk4UFifjRBB1STJK0iWvBjq0r3U+zj
         cAQWrlT49afMcNdCr4df7XPzidQF3sSfVc7cGvVzOjh1v3NxlcRMchcdyobum0MGamVM
         qnz2pBcZULFdGS+DHun0iCap5VUEwmfmnbjKdho4ZIayTwDrvXUU/QolC5n0zZ5AwDf3
         A6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833598; x=1783438398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7y23lwVc1qU9pQQZzwFQKSERGQYoPnAW1oWXpZxS+y4=;
        b=TtCq86JvFWzV4N06CosncbPdDs6aBAa/hcB1wrtvM/WVeC5+47YzdoKxetEPILa+St
         gtOEE9Cc2b2Wl2m7QEhZrqZSYXHPJfl4+Elj9SckxdohxAhsAlExOSEYMUnmBr1bchu8
         rMbt0eD76Nv3rvJF6ifayPAyG0tDhzfiB3ewOSysGUA2Hhxb+sk90Qjyf080NiPqfiLJ
         YbTDgx3lNkl17I4s/eaOLTyxitHBjo/9TYqDTYzdyWl+I9Q6c/8Mul1Wv3r5MPFBziBe
         TEqrqFSedVSBvdBBTt1XGT2lRNWwfMLmIqw+gjvofgrVD/M4u7ZHrWyIXZGuFeF/H0eu
         zQMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/awflJQl0MiXPvq/ctorKkrU+7995krx0w9uh2xpVCw1gqB21kOb/Xc39EFUA8Y/RdHN8TEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlChZelzeuKr4KRfz6m/BDyh0PiqGMtSUGo9+ZX0ANbrsadBi
	3Yeshj3PdIy/8fJ7fUCdeCeS0d1aC8RfK7wn4N+ePpSP6nLSgnQxN0zXLdpYFagdbHBHYh6zEuZ
	PqugeyA==
X-Gm-Gg: AfdE7clfcDms5WT08c+CdjfQS6WeQo8zIfXXK8pcvvWBsrgQClpNDnGo42lZA6CyO8N
	lfNeq0JpVvq90ehU6PsmiX6gndd10CfcoIYnzOeoo6V4crcjUnet5OBNNQl5Ku3SE3ci59/QvB0
	WqdbBt/um3tLGet6SVoLqf7pZfXh4GBG4niqjdez7hs+sbuIKgrmDzVRVPPHcmmW5P7BcNxSuVQ
	VAkZeowZRdmY0wdAKBYs61URgnwH5Q5LTAqwP4aLuvxI2Dps8bYo2FHkpF7MY4wNEu7eCLgHdJf
	C0GZQMK5PuDeXOrH1DmM/KW8gnzc+fcdhY7xugagBbKvTRX1LhoOMJdIFEM7h/SRE9lcnaVhCcU
	bIZpmv+jR3ifaIrRFsGRbnzK0/QUwlxFQ9VWf4TIcmY52iNmcMu8a7tKbEz9v4rCsRGkLsSNz8H
	VU6su+K/r21uAM4J5br7OEy+o1DRVHyNlL100+gSvs/pS1xqVXi0cvjAswi4LPug==
X-Received: by 2002:a05:600c:5290:b0:48a:5d55:c194 with SMTP id 5b1f17b1804b1-493bde1e099mr224345e9.7.1782833597416;
        Tue, 30 Jun 2026 08:33:17 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c9f78sm3528615e9.5.2026.06.30.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:33:16 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:33:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akPhuF9pAWaBXzpi@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPX_N0P2EcI_jbV@google.com>

On Tue, Jun 30, 2026 at 02:51:40PM +0000, Pranjal Shrivastava wrote:
> On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> > On Mon, Jun 29, 2026 at 11:15:33PM -0700, Nicolin Chen wrote:
> > > When transitioning to a kdump kernel, the primary kernel might have crashed
> > > while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> > > driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> > > and setting the Global Bypass Attribute (GBPA) to ABORT.
> > > 
> > > In a kdump scenario, this aggressive reset is highly destructive:
> > > a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
> > >    PCIe AER or SErrors that may panic the kdump kernel
> > 
> > Can you please clarify more on those errors, what conditions will
> > trigger that?
> > For example, patch 4 disables the EVTQ to avoid events as there might
> > be a lot, why are they not fatal also?
> > 
> > > b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
> > >    the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> > > 
> > > To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> > > and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> > > flight DMA using the crashed kernel's page tables until the endpoint device
> > > drivers probe and quiesce their respective hardware.
> > > 
> > > However, the ARM SMMUv3 architecture specification states that updating the
> > > SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> > > 
> > > This leaves a kdump kernel no choice but to adopt the stream table from the
> > > crashed kernel.
> > 
> > In many cases the patches assume that the CDs/STE might be corrupted,
> > but still attempt to retrieve them with some validation
> > (log2size/split...)
> > However, the base address might be broken, TLBs state is unknown...
> > 
> > IMO, although that might improve the status quo, there are still
> > heuristics, in addition to noticeable complexity to transition the
> > stream tables. I wonder if FW can deal with AER in that case before
> > booting the kdump kernel.
> 
> I guess we're reading the base address from the HW register itself so
> that should be fine? CDs are in-memory so that's why they could be
> corrupted?

For example patch#1 verifies log2size and split and both are read
from HW registers. Same for the base address or other addresses as
the page tables, they  might be corrupted due to a buggy driver.
My point is that, it is really hard to assume that the previous state
of registers/STE/page-tables were valid or even consistent, when the
kernel crashed and did not transition the state gracefully.

> 
> About the TLB state, I'm not sure what might pollute it, since this is a
> kexec, I don't expect any non-kernel entity to gain program control
> before the kdump kernel.. Hence, IMO, we can't configure FW to deal with
> AER here..

Similarly for TLBs, the kernel might have panicked in the middle of an
unmap or free domain. (not to mention what that means for RPM where
a device reset with unknown TLBs)

Why can't the FW deal with it? As I mentioned above in the previous
reply I am not sure I understand what situation leads into this, when
does a device trigger SError to the system vs when not which is observed
as an event in that case.

Thanks,
Mostafa

> 
> Thanks,
> Praan
