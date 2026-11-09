Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209685;
	b=mgZlq5VQCQErgq5lKpLVsq1H9dIihXPlCSfoj6LQYYbv2yxwbitEZe161oFOxyEPpOrb
	 e80tCmZ+SjslkpWv483txxmtScgbbKQMvKPMjSKUkwHHf5gr6QrZ1KH5F/8wZ8fHqDHN5
	 hQkoa88h74aBv4jEAkYTENcpPLc4X5D8lnJM+9eEff8S6fzAsC1xSdJVP9ciI/d86Dfv+
	 mM/U8Q4ksZ/PsNqxrEoqhLmZps+7Ghmros1i1dvNG96YJjQGplwAHp1mlNtlQfplh2yUr
	 4uQ1n1uDJeH0k4jEN+wf5bsfpsODORjMhVIrUg8Fbc4Nf26Z+dGR0+Yfw/E0w5Aqj4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209685;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=a95Lvz3SDK8ZS729zd2rB/xsCq3OYVLB1fhStb7IHBs=;
	b=EclhxVhz7gVfUFduLvb/StiuvDmd771/dvW8/y/kY5q567uyv4EbQTk7lDjb37iSg27J
	 qdXYudwPcoqkbmNAun+d+y43JHdTmboYL7+0nODP1Nszm8gbCQPzjNFJWSaGQ8Ez66Wzr
	 o1bMnKwHaVXhAqU4sVXsz7lSpvJCBKeF+Cce346i6Vo552HxD8fAiGfczSvgPAggl+5kz
	 9lwYB0ilvzVeEBmjCY35Y7q37diBk2/BD5Nrf1g9aqrer4tYBeI9Dnu6kyDJSeznrsGkF
	 ms+/NpfjriGYfabmb1wzsupp0RXAvODrzdB7u2kxnuysQNrssgvyGariN277+xC7IuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Otl2njGB;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2146071868;
	Mon,  9 Nov 2026 07:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE2146071868
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Otl2njGB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794209685; x=1825745685;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pNdl/FdSJJn3Fq+2HjjDtY3efpYOAux+p61fbQUhrII=;
  b=Otl2njGBnjfPtFxbh/xAegCebDUanEXYmG5hagW81hsqcwvdnLwN4ZKi
   inDyGSV4Ao2uCOVsSbe8usBID7q6ZtLMsq8RsAdQDoYMVMupNctJ4fdZ3
   SMFiUr6SzBd+oLpXPtIGDHkyR0axlPzCdraMjHnVa77dFzpFDZg5MYjj2
   aJwf0vPFo+TeL5TVszn2WA1idkBytLkUu5FuZrzhyfbaFpG2nGw5cSrPf
   JDQwOEF4QEHjQ/CjdNUZCHRAWjWtdUKHBakCwGOnPy0RRXstxACBf9iot
   06r66ERrQkLV5hCHHFGYq9WPUgiU98dfYBa9nL3jeUzs7HMCq6vcy6Ljm
   g==;
X-CSE-ConnectionGUID: 3y+6CAwdT7OrdiBBY5lx+Q==
X-CSE-MsgGUID: SQc6bjmoT2yi8//tO7cj/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2942562"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2942562"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:34:44 -0800
X-CSE-ConnectionGUID: JKbjXGVcQzGXy9xbUZOcUQ==
X-CSE-MsgGUID: XqqTaNZ8QXK0GbtMWu8PVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7847193"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:34:42 -0800
Message-ID: <7f86b03e-1c99-44ed-8d07-3502a21821fc@linux.intel.com>
Date: Mon, 9 Nov 2026 15:34:40 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Set FPD when tearing down a PASID entry
 with fault_ignore
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
 <20261104051059.1345010-2-baolu.lu@linux.intel.com>
 <87o6c3uedj.fsf@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <87o6c3uedj.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/2026 6:01 AM, Vinicius Costa Gomes wrote:
> Lu Baolu<baolu.lu@linux.intel.com> writes:
> 
>>   static void
>>   pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>>   				    u16 did, u32 pasid)
>> @@ -253,7 +238,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>>   
>>   	if (!pasid_pte_is_present(pte)) {
>>   		if (!pasid_pte_is_fault_disabled(pte)) {
>> -			WARN_ON(READ_ONCE(pte->val[0]) != 0);
>>   			spin_unlock(&iommu->lock);
>>   			return;
>>   		}
>> @@ -266,6 +250,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>>   		 */
>>   		pasid_clear_entry(pte);
>>   		spin_unlock(&iommu->lock);
>> +		if (!ecap_coherent(iommu->ecap))
>> +			clflush_cache_range(pte, sizeof(*pte));
>>   		intel_iommu_drain_pasid_prq(dev, pasid);
>>
> I think it's worth documenting in the commit message why both of these
> are needed, removing the warning and adding the flush.

Yes. I will add the following to the commit message:

  Also drop the WARN_ON() for a non-present entry without FPD. Since
  commit 75ed00055c05 a concurrent teardown can see such an entry before
  it is zeroed. Flush the cache after clearing an FPD-only entry, as
  other PASID entry updates do on non-coherent hardware.

Thanks,
baolu
