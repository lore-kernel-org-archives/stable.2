Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A6314D06
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105038; cv=none; b=rcjFdH98zza5lORaqUqWPSF2fCgPomN5GoiFAEtvGifQNExx1m6OFjVzFrawqxkRovLstMMXP5DPqSrlB3i3HB+B54Cn8v/kx712gBjHgaYAd0kllQHPe50ULgaZ2/ZfJKC6waECGi7e7XET3kCiAZCTJkn+qq1VsyuCjzVd+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105038; c=relaxed/simple;
	bh=EVj/nJjoDMSSbQCOLNFtXva5XAladq3bBJePirYqfas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJOzqN4fok/emBkgqNnUoEJcnrI2Tbp8dJdSwtQgKhd2uzzQDCqjmCiD6PZNGk9hdNLdXJIw7OcYYaw5IKndaZZ88Hw/fw4Ohb5h6nh0o4kx+kAnLcrA19zLXj5dNMiuoIMIbYPPud5OpkCbaXWk46XTRv+ZygSrBlVcrePOQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ApfJI2W6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ApfJI2W6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8ED22D7;
	Fri,  3 Jul 2026 11:57:11 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6E7C3F905;
	Fri,  3 Jul 2026 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783105035; bh=EVj/nJjoDMSSbQCOLNFtXva5XAladq3bBJePirYqfas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ApfJI2W6Dx1v89BrkpaA+IivzEXpoA/C6HWy29MyKt+dwodqdvzesqJh0FhCHxrkZ
	 HzjY99MkITrRuWRSNz1vn6CdJhMDyAFV/9nnSr0JjElv9gqUAuElmPfXoVW1wbGZXK
	 lcQbhN305LF4d8wOzD+lptwW/xscZD3DX0+3bzUo=
Message-ID: <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>
Date: Fri, 3 Jul 2026 19:57:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
 catalin.marinas@arm.com, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 stable@vger.kernel.org
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <20260703164914.GY7525@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260703164914.GY7525@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2026 5:49 pm, Jason Gunthorpe wrote:
> On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:
> 
>> @@ -211,6 +213,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>   	if (system_supports_bbml2_noabort())
>>   		feat_mask |= ARM_SMMU_FEAT_BBML2;
>>   
>> +	if (system_supports_haft())
>> +		feat_mask |= ARM_SMMU_FEAT_HAFT;
> 
> I fear this is going to make SVA stop working on systems it currently
> does work on, so it might be a major regression.
> 
> SMMU HTTU is not a commonly implemented feature.. I think of all the
> NVIDIA ARM chips only one supports it. Given that a quick internal
> check is raising concerns this will be breaking for us. We need to
> check in more detail which cores have HAFT.
> 
> Breaking already deployed SVA would be a major functional regression.
> 
> I think this should start by just enabling SMMU HAFT when CPU HAFT is
> on, when possible. Maybe print a warning on the mismatch instead of
> failing.
> 
> Since we can't break already deployed SVA a full solution would either
> have to somehow turn off CPU HAFT or we ignore the gap in the AF
> updates..

TBH I do not know how bad the implications of 
pmd_young()/pmdp_test_and_clear_young() returning a false-negative are, 
but if we aren't considering mismatched CPUs harmless then surely the 
same must apply for SVA. In the POE/GCS cases all that can really be 
broken is users' expectations, if they've opted in to additional 
security features, but also opted in to SVA wherein those features can't 
protect against DMA. Here, though, it's the kernel mm layer itself 
that's impacted, and I'm not confident to say that that isn't more serious.

This came about as a sudden "oh crap" moment when answering an internal 
query about SMMU features, and it seemed prudent to do _something_ for 
the sake of correctness ASAP. Making HAFT depend on !SVA could only 
easily be done at the config level, which seems arguably even more 
over-reaching, and given that CPUs supporting HAFT aren't common yet - 
at least from Arm it seems to be only the big cores of the latest C1 
generation so far - in a pinch this felt like the least-worst option for 
the short term. If someone has time to look into whether it's possible 
to dynamically switch arch_has_hw_nonleaf_pmd_young (and whatever else) 
post-init, then that's an obvious follow-up, but I can say for sure that 
that someone is not me...

Thanks,
Robin.
