Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59740B108
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739389; cv=none; b=RxidLMvJEMTq5uDd98EvI4P9CCxALL3YN7TyydLwG2Di8+r2CAA9ICKqHJtdCfMHk6AO/D2v4IOYNTbDxE1ltSF7IbUfrCPqo9xMSQYqlCGhc+wickO6mZ8PHku7NK6H3zcto3RnAaLSv3v0iOGgQj8krcVVDuc9H5jmF4WYQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739389; c=relaxed/simple;
	bh=pYVmR2L8HCGfHM5Pot89Q8QGJU4mVcZDQ+zR6U0/MXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpTYuDWqqbHKM07e4nf6jXtxiFjBBlWQsOgPaQupe+hPlTxnTHBP/lBhm4wI22RLJY/ZBX3A6N8w5DKobWIvHttqvVNBgmYcffu/TcsBtDwAMHIyQ1u8II+pwzgaW2sZH9dI9UrwpoFpLa1HlcgZJBdUpiginaQpyNR0XZDcJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RhNFo5DN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RhNFo5DN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F4D1595;
	Wed, 22 Jul 2026 09:56:23 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83C1F3F59E;
	Wed, 22 Jul 2026 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784739387; bh=pYVmR2L8HCGfHM5Pot89Q8QGJU4mVcZDQ+zR6U0/MXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RhNFo5DNMetW02ZuI3Jel22P1Iz8VPaf0EsWcOfcCePIHqvt+zIfFF+MwrwsKPW6+
	 +LeTu0gLcyKqBdVcWzMI1wb0yENrCONvh4g4akizvXP3r1XzERYjCA1vYljLXCglcN
	 woeSQMAEx1cQvtW/4V2ZfsWvDQQPd411/WBtMaGU=
Message-ID: <acd85a2a-af1f-4ebf-8370-773338d4fd15@arm.com>
Date: Wed, 22 Jul 2026 17:56:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, jpb@kernel.org, catalin.marinas@arm.com,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <amDEmlcyC3Tfmkel@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <amDEmlcyC3Tfmkel@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2026 2:24 pm, Will Deacon wrote:
> On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:
>> Since table access flags cannot be software-managed, if process
>> pagetables are using HAFT then SVA must require the SMMU to support and
>> enable it too, otherwise page aging is liable to get out of whack.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 62df5870ebf7 ("arm64: Enable ARCH_HAS_NONLEAF_PMD_YOUNG")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 6 ++++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 3 +++
>>   3 files changed, 14 insertions(+)
> 
> This looks ok to *me*, but Sashiko raises two interesting points:
> 
> https://sashiko.dev/#/patchset/878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com
> 
> 1. This may break hitless updates when transitioning to a faulting entry.

What does that even mean? We might block traffic in the process of 
_explicitly blocking traffic_!? Whoop-de-do, surely?

But either way, HAFT has bog all to do with EPD0, and it must be cleared 
if HA is cleared, otherwise the CD becomes illegal.

> 2. IORT has HTTU overrides for HA/HD. Does it (will it?) have anything
>     for HAFT? At the moment, it looks like you'll trigger a warning
>     message.

Oh, seems I did miss that fiddly fw_features line, so I guess it has 
half a point that the warning can wonky if both IDR0 and IORT do 
(correctly) report HAFT. Pretty sure we're already a bit broken if IORT 
ever did try to override HTTU _upwards_, though.

> Given Jason's comments, it's probably worth sending the idreg override
> patch as well...

Fair enough, I'm blessed with a moment of calm just now so I should be 
able to find time to have a crack at that tomorrow...

Cheers,
Robin.
