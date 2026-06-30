Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEE43CEFC
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831111; cv=none; b=pzvi91CnXzyu4HRRhXc/tv+DElUZwqqlC2sXVYNHmLSrjtftdJv9iXyBfvP8bnBQvmcuf/umTqBSBCJA/zBStTRmU1U+R6pQUiIu2G3RiHt9rZJNXRioAanv6wxwf4A1nJSdeJJtlLl4iszgpmKJFBXmNV28ileSm6UY00WU8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831111; c=relaxed/simple;
	bh=E4G4LPQQ3Dkwous6BybFpxhhimjU64PRxq0Qq1ULgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtdN0h/DHy6o+akKFDJ5/9oe1DAVbRos0+MdM5cvsDtk5fyusxawZgrkQEsf8X/NRF8pSyICCLV+bpnYtQrDSrpY2K/IK1SJsuc4ws70CWlby9KjURkrX4gS7Nn/r3OSJfcssX9v4lEHmUn8vhHtT2Pi54XknUY3LVkjho/9ZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8qWks1u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8qWks1u"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c9b1db4964so54645ad.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782831107; x=1783435907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5yhTYmczFL2uCxVu8k1+oZGQNpSYllSaCHFjNudZdlY=;
        b=m8qWks1uZrFBAwtdPhExOW5q9tYlhy5g5Kb15Uki+MRwjQWWXAwvSGYhFsqrBkr/9l
         cd/a/WPoWXFGaiXhScvgPindWJ1czbrpMU3s29NVYTC1hOyMZt81NQg6lsx4Us2/Y1pO
         bPD8yZse3v8bKZtvEDh5rwTRxENEk+/rhAD/AkY0cpc1kwDamEzSbBYAe3Ev5rvbiHwn
         aObXNA6R6zCcR3eKhbgSfp2EiTFt/bpfJQxi4KH49p/IKsW9Cfbj4VNzZzlBkSQA8Vte
         qDyULteM2dyGpMCSC7DYLQpocZBxuIf0YQXitZCxT8tr707Q7KbF5P6md8bRbD4EkNXM
         uUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831107; x=1783435907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yhTYmczFL2uCxVu8k1+oZGQNpSYllSaCHFjNudZdlY=;
        b=hKo1E97QUKqTIvmjPmsVrFDUKwwbyEQy0XaFI1hSTxkaLtUY6t+3j9m1YNFuYN8lt1
         qtIK/ycApRM0ov238wtPyXWBwraLSNnagpef1j3o3+65n4D04DBFMoAiuP6S9MsDZGXU
         0ExBp8rfubMjCasb9X0aMF4hlpZwsEjZqwLkh2BGO0+2dMUktrSPRq4y/o1wzz5zM2gp
         c47T9/X/yAv7YTyfMgOXz3yDYhghyZ0VOvGYNprhNR7/pKYi4XwK3lercNunu+1WOHEZ
         kUNKDaNy7qi5ZIJbKY+gOc3oaX+KyaB7hQzC9JqdtfIyMqum9Thpwmtn5OOFgOJfVo6Q
         SjOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8hUwrD9zX5yuENRUvzYyXg9viZV9y5Rs8cQNseq39aS7XBBQSQ4u3xykfVFS1ij22noSgffw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmbJAJW68W6jgLb3qXSNnX0UGB+vxk/zdaZ6Pz9FRxfOzKsmE
	IXMEKeEWCtzDP3v0oGXBURbVr9imPWtUAaDfC/eUEvOquJ2qBH2t2fGKSxsJWklyDQ==
X-Gm-Gg: AfdE7cnPPbr5TZkaJLpebzU7A8srXaZIDFlJslvb1QTAwZ+rZFHF+DvpCvpCsxMztit
	WNWg0f3hDz8MZq7uQQTwt/xhadAY/8Ya8whVuRJpGtsF1n4LGBHpbILlatsXIWyK23ZNJdi4cWE
	lkAzHBKMLmVVScijsJ2u7HDfkhHH9jicNerauaono53sAD4SakEcVYGVfB/eb2sRHvrfTPZE6DH
	5TymHAY89q6LdORMrhYOf7CMHh6+ZCV7yYFPeJM5wWJGRUo4V8bLH0csATCxKZnAmU3YgWnWMz/
	97lAc6GKZMsfS5Qmqj+KXSi2i9IymnDo0kAe/B6C1nEsau/4cmS+Bh1POcVe4udE9RCID72IZW+
	0R4iPNvivTTbKYv7m8GDzGq/odQ9djWPkic1sTSHJu9i8d8ooBM6ng4i+u9M3S1l4DwsbpdimwT
	uBcGftKdZ9GxOG6yvf3BoWbu2KPpBxLc7DUU9FSAbPX/gI32w=
X-Received: by 2002:a17:903:ac6:b0:2ca:4f33:e87a with SMTP id d9443c01a7336-2ca5d8db7b3mr287655ad.17.1782831106989;
        Tue, 30 Jun 2026 07:51:46 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382d64c6sm15636325ad.82.2026.06.30.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:51:46 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:51:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akPX_N0P2EcI_jbV@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPB6l-fuJUcg4a2@google.com>

On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> On Mon, Jun 29, 2026 at 11:15:33PM -0700, Nicolin Chen wrote:
> > When transitioning to a kdump kernel, the primary kernel might have crashed
> > while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> > driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> > and setting the Global Bypass Attribute (GBPA) to ABORT.
> > 
> > In a kdump scenario, this aggressive reset is highly destructive:
> > a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
> >    PCIe AER or SErrors that may panic the kdump kernel
> 
> Can you please clarify more on those errors, what conditions will
> trigger that?
> For example, patch 4 disables the EVTQ to avoid events as there might
> be a lot, why are they not fatal also?
> 
> > b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
> >    the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> > 
> > To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> > and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> > flight DMA using the crashed kernel's page tables until the endpoint device
> > drivers probe and quiesce their respective hardware.
> > 
> > However, the ARM SMMUv3 architecture specification states that updating the
> > SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> > 
> > This leaves a kdump kernel no choice but to adopt the stream table from the
> > crashed kernel.
> 
> In many cases the patches assume that the CDs/STE might be corrupted,
> but still attempt to retrieve them with some validation
> (log2size/split...)
> However, the base address might be broken, TLBs state is unknown...
> 
> IMO, although that might improve the status quo, there are still
> heuristics, in addition to noticeable complexity to transition the
> stream tables. I wonder if FW can deal with AER in that case before
> booting the kdump kernel.

I guess we're reading the base address from the HW register itself so
that should be fine? CDs are in-memory so that's why they could be
corrupted?

About the TLB state, I'm not sure what might pollute it, since this is a
kexec, I don't expect any non-kernel entity to gain program control
before the kdump kernel.. Hence, IMO, we can't configure FW to deal with
AER here..

Thanks,
Praan
