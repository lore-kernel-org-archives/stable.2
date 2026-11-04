Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796055;
	b=wCnt9nzHa1LXN4n1Bv1P62e4xEa4kM3aeh+6wG+Q1naT/AnHiy3RPdQymLfIR3+9kRiZ
	 Lnum0c3W70UkfNu9GaZzXsW6MU35gwoQpEufh2D1jsqXWDlmOyxwLqFK6Jt8ZipVRLVYt
	 SYkg/ciGSqJgPUt0zGvmIwfu2im2pUvJzETqNUwltcgdFGQT+TAdwywpDMXP0OtKYzV44
	 IknAkEnkN++dIDi/s7l+SO74HNsA1YrqIbAYAiWQokxrSJQuKyJCuO7H3ZnurjzSQcsHi
	 qzAaCmCzQhSgmhZpIu0WfKHCMUdmwi5xdl4Nds2wKWgVWNA5oKztbffF70zjmYUQU5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796055;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Qu7Yw+WD0W+wi9N7j2myB2cji10J5fDY+ApcA841Sz0=;
	b=UQHZMRNFxbFa2q1G5Zjx/LP3GHwv+7RaoUOeJ+1fpuxjks3zaAvobyjAC1W4h0D9pYQ6
	 pXLlIOC7aBOpQCVxolUCM6s0BZ5ZBMzrz1C3UCrgEWLAs9KBTTTbswN9HO21c4P3+fsu3
	 81+nvW/m++OktjkBWb2nYYQn2nBPgKSYzhdUuUxHVvHpw9YwGTpe9GY6PihnIjaLHl3W+
	 Y7oC/xuHAyEim91LWfeCj3+Cd6LDy38GpoWVYzvLy6su2/IF38+SSVsZML9gpc3bkVUbG
	 UDagzaUiGVGrcktnnWS/X9c1gzY2WeolIKE5IP7TUEN6maiSzUkFjDQKgF9L8aVeZ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Z8d/Rftc";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6AF606A33C;
	Wed,  4 Nov 2026 12:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA6AF606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Z8d/Rftc
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39E42247;
	Wed,  4 Nov 2026 04:40:43 -0800 (PST)
Received: from [10.57.15.10] (unknown [10.57.15.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9316B3F628;
	Wed,  4 Nov 2026 04:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793796046; bh=5+mieZXs7MNZ6sx1ZeGlRyjEfTaZXcaiheHN4KGpcWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z8d/Rftc+Q2HeWZuWw7ukw5Gdmi0vl/xhp9ZizZjw5lfOEn+oQcL441mnR/5kg0cu
	 i0U6AgxBZee+rjErsMfHAv0kHpCQqkVphcjRBIaN0pzAIt1E+1oN8jIAqoF6V/1Cv6
	 SbR4JSBoLZVfaYUjz0XVmjAKT71XZPO4aLqMw0cs=
Message-ID: <d7135fe4-5e92-4c42-8d6b-3afbc3b1bb33@arm.com>
Date: Wed, 4 Nov 2026 12:40:42 +0000
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
Subject: Re: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Michael Kelley <mhklinux@outlook.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Claire Chang <tientzu@chromium.org>,
 Konrad Rzeszutek Wilk <konrad@kernel.org>, Giorgi Kobakhia
 <gkobakhi@asu.edu>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <CGME20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862@eucas1p1.samsung.com>
 <20261103155016.1107958-1-m.szyprowski@samsung.com>
 <MN2PR02MB686381EADCEECF16B23214D0D4692@MN2PR02MB6863.namprd02.prod.outlook.com>
 <8276a107-7115-48e3-a40a-2660fe1beaa5@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <8276a107-7115-48e3-a40a-2660fe1beaa5@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-04 7:37 am, Marek Szyprowski wrote:
> On 03.11.2026 22:18, Michael Kelley wrote:
>> From: Marek Szyprowski <m.szyprowski@samsung.com> Sent: Tuesday, November 3, 2026 7:50 AM
>>> All other paths creating a swiotlb pool ensure that nslabs is a multiple
>>> of IO_TLB_SEGSIZE, and the swiotlb code relies on that. Since commit
>>> 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization") a
>>> restricted pool can have an arbitrary size taken from the device tree.
>>>
>>> If the pool size is not a multiple of IO_TLB_SEGSIZE, the last segment is
>>> partial and swiotlb_release_slots() reads mem->slots[index + nslabs],
>>> which is one past the end of the slots array when the freed buffer ends
>>> at the end of the pool:
>>>
>>>   BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
>>>   Read of size 2
>>>
>>> Round the pool size down to a multiple of IO_TLB_SEGSIZE, wasting a bit
>>> of memory, and warn about it.
>> I'm not familiar with the macro scenarios where a device has a
>> restricted pool specified in DT. But I wonder if it would be better to
>> round up instead of down. DT has specified that the device should
>> have a restricted DMA pool of a certain size, and rounding down gives
>> the device a smaller pool than was requested. Could DMA operations
>> then fail because of not having a large enough pool? Rounding down
>> also allows the pool to end up being size zero, which this patch
>> detects and results in a definite failure at device initialization time.
>>
>> What's the tradeoff in rounding up instead?The device restricted
>> pool at least as large as requested. Presumably, being larger than
>> requested doesn't cause any problems for the device or its driver.
>> The downside is using up to 256 KiB more system memory than
>> expected. In an embedded system with only a few MiB of system
>> memory, maybe that's a relatively big problem. I don't know the
>> scenarios well enough to judge whether using a bit more system
>> memory is better or worse than the device not having all the
>> restricted pool space it said it needed for DMA.
> 
> The main problem with enlarging the restricted pool is that the memory
> has been already allocated (reserved) by the generic of_reserved_mem
> code before the rmem_swiotlb_device_init() is called. There might be
> even another reserved region just after the one being processed by
> rmem_swiotlb_device_init(). The reserved region might be specified in
> the device tree exactly, by pointing its base address and size. In
> such case the rmem_swiotlb_device_init() really cannot do anything
> else than using the provided already allocated region partially.
> The only thing that might be improved is freeing the 'wasted' part
> of the region back to the memory allocator if You think that
> printing a warning is not enough.

Realistically, the granularity of any physical memory protection system 
is going to be based on at least 4KB pages, so I don't see much excuse 
for any restricted pool not being aligned to at least the current 2KB 
segment size - if anything I reckon we could just consider it a DT error 
and fail the init rather than worry about rounding either way.

Note that freeing parts of a restricted pool for any other use would not 
be a thing anyway, as they are by definition not a "reusable" region.

Thanks,
Robin.
>> Your commit message also mentions "wasting a bit of memory".
>> What is wasted in the round down case? The rounding down is
>> done before the pool memory is allocated. I would have thought
>> the wasting would occur in the round up case, where the restricted
>> pool is given more memory than the device said it needed.
>>
>> Michael
>>
>>> Reported-by: Giorgi Kobakhia <gkobakhi@asu.edu>
>>> Closes: https://lore.kernel.org/all/20261026032007.1957949-1-gkobakhi@asu.edu/
>>> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
>>> CC: stable@vger.kernel.org
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   kernel/dma/swiotlb.c | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>> index 2c57b49ac7c0..a68f35192582 100644
>>> --- a/kernel/dma/swiotlb.c
>>> +++ b/kernel/dma/swiotlb.c
>>> @@ -2007,6 +2007,19 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>>>   	 */
>>>   	if (!mem) {
>>>   		struct io_tlb_pool *pool;
>>> +		unsigned long aligned_nslabs = ALIGN_DOWN(nslabs, IO_TLB_SEGSIZE);
>>> +
>>> +		if (aligned_nslabs != nslabs) {
>>> +			dev_warn(dev, "Restricted DMA pool size %zu is not a multiple of %lu, rounding down to %lu bytes\n",
>>> +				 (size_t)rmem->size,
>>> +				 (unsigned long)IO_TLB_SEGSIZE << IO_TLB_SHIFT,
>>> +				 aligned_nslabs << IO_TLB_SHIFT);
>>> +			nslabs = aligned_nslabs;
>>> +		}
>>> +		if (!nslabs) {
>>> +			dev_err(dev, "Restricted DMA pool is too small\n");
>>> +			return -EINVAL;
>>> +		}
>>>
>>>   		mem = kzalloc_obj(*mem);
>>>   		if (!mem)
>>> @@ -2034,7 +2047,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>>>
>>>   			mem->cc_shared = true;
>>>   			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>> -						   rmem->size >> PAGE_SHIFT);
>>> +						   (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
>>>   			if (ret) {
>>>   				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
>>>   				kfree(pool->areas);
>>> --
>>> 2.43.0
>>
> Best regards

