Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5036CDF3
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615467; cv=none; b=Lev1mdm0YvgvM6L+UHtEjPyBPk90Bbq4CeNx5s3m4DRs1OUJYsrERcx7S11S5s0McwNoPkojT6VlWQGFk7NHwi/xgRi0FjAlFcHJXk+fj5Dg0pXTgicABIaiwOxVneXjxb4UgdRLV/XVmvpw7dIY5KzwWcCZcHijHR1jt6t4/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615467; c=relaxed/simple;
	bh=Y7wfNC1739zey9eUhGqmGlRu8bQ7jbWzrvClfA89rHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItMA197cQmBNC/boOW/Vdg/Cggu4GrZ1aXSrHRIDRU9BFJ8/JQJ5MqdKh3eH093ICThFEyva0b7tXfSLJCrVBqbz8lAKc6tjikdS4DRICioYuvkp8kfqIGgqrRV8mpHllyAExlSy5DWh8imBrwEKB7AhrN3R9wgffuj4dRicU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DN+r+cux; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DN+r+cux"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E951570;
	Thu,  9 Jul 2026 09:44:20 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21283F66F;
	Thu,  9 Jul 2026 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783615465; bh=Y7wfNC1739zey9eUhGqmGlRu8bQ7jbWzrvClfA89rHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DN+r+cuxUlrZjcbko1hTwCogobshJCrtb8sXIvzM/p9XKxBe8egqdqv5O5PF3I6sH
	 xoRxu6PUOAdPdDHaXXvUtsPK+yGzlsMvV1QN7SI18foO0kdVrhSjq8gCo26OFvXaN/
	 /VsicGHlgNTtPIxsnfe12LtOj99s3oZv5nsoq6uo=
Message-ID: <f344dd12-6b68-4d3e-bf66-f84fdf748b44@arm.com>
Date: Thu, 9 Jul 2026 17:44:22 +0100
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
 catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <20260703164914.GY7525@ziepe.ca>
 <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>
 <20260703192459.GB1978949@ziepe.ca>
 <f13b30cf-e885-44c6-8e61-7924937eb8ac@arm.com>
 <20260709160440.GL118978@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260709160440.GL118978@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2026 5:04 pm, Jason Gunthorpe wrote:
> On Mon, Jul 06, 2026 at 03:13:01PM +0100, Robin Murphy wrote:
> 
>> Indeed if anyone does want to use SVA on such mismatched hardware and are
>> happy to use a custom kernel with CONFIG_ARM64_HAFT disabled then they can
>> and will continue to be able to do so.
> 
> It seems like we have a chip that is impacted by this. I'm being told
> that the necessary ARM IP is not available in time to properly match
> SMMU and CPU for its particular application.d
> 
> The chip is embedded so those work arounds are possibly OK - but I
> think this issue keeps coming up and ARM should have a better overall
> solution for CPU/SMMU mismatch in the ecosystem since it seems like
> this is going to keep happening..

To be fair, even if new VMSA features were added to the SMMU 
architecture in lockstep with the CPU architecture (which historically 
they haven't been since the SMMU version often needs additional 
consideration - oh, the fun we had with HDBSS...), and the SMMU products 
were developed and released in sync with CPU products (which again they 
have not been, for more than just architecture reasons), then at the end 
of the day from the Linux perspective we'd still have to deal with 
licensees having the freedom to play mix-and-match, so I don't see 
there's much that Arm could really do.

The CPU architecture does now provide FEAT_IDTE3, which platform 
firmware can use to hide visibility of features from an OS/hypervisor, 
so if you did ask, I suspect you'd get the answer that beyond that it's 
up to the OS to decide what it wants to do with what it's given.

> Even if Linux could automatically limit the CPU features to the SMMU
> it would be a big help.

Feel free to propose patches, but given that SMMU details may not be 
known until after userspace is up (since the driver can be a module), 
unless features can safely be toggled on and off entirely dynamically, 
for many cases I don't see that we could ever do much more than letting 
the user pick their preferred policy at boot time via config or command 
line.

Thanks,
Robin.
