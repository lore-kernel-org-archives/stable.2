Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536846;
	b=vds98LsfOdPUFCUKN3qUN/l03YAadVLZ2NqT4wthqjY0r741agG9r++ysxgXhuLoMipp
	 67zS5Uw0LHaschMgIgqWKJRCYqcz3CbcJJeco7foQd23q6L8oCnwlKFFaIoFkS8bAziDK
	 2HUrHKwuG3KthsgsFTtP/2UcCFFry+D+amLK3t02/1+MGC1qeMhhUnUWuiGvSecIfz1jQ
	 HQ3Lk5oQKYLZUuTMF8c96tTGouxYQvrgMZ/cnBznT9iuGp5lQRljHEEGiQZCvm6kjyoeA
	 HCJsv6P/u8VWVllnAclm5Zy1B8eRj4grAQ0PU4kn6+5OJt/kbwneo6WVN+uRIsIjyxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dQikJs3tAZcEmwxlSrn7mkXPOYqnZk22VZjMpUZ2Exw=;
	b=i4Pd6cxj58yQzm4HtRSV9HvYli4XIJsfch27dgakNXydxOI+sC2lqaTqpW4FrH2qkaI/
	 nIqJZ7210nKh63o+yY5eh1jtDXGrpY/Y5rIB1ylwmRLWncwmM4Ltf8nRarwW9N+z3PNJ/
	 I4g2dWb6EoPUZ82udSKcJOZhy1klB6hN4FAsi90lkJzLQXNn/MtT5K8u/N2gPTPpskHzC
	 OlW8+A7BGEhUQ6Fb9wyPUD9Hy4X6PZjG1OouYSPSLLtdUNO+hIjdkgyRP8Fb4Ap2KtYT4
	 +O/8bNEgSRBQZWzTYyeuyuu/sb0QfM/PSBqmgaKVpn4/AVW6zpp/d8nh6zrZETXYMQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=obZteLxB;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58EF606A323;
	Tue, 24 Nov 2026 16:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B58EF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=obZteLxB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AADA339;
	Tue, 24 Nov 2026 08:14:02 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A653F86C;
	Tue, 24 Nov 2026 08:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795536845; bh=ltgWtDNEaiaIx+gDXAFo8x6FP+hEhcgrtp2ANPfd7W0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=obZteLxB9CDGNMX1F+5/fMECUT48J03pJTQ7qvsZIlQoYMUBLzeQHGCNLGPThq5Me
	 qoKfJZje+93+IKHfjP2krxgbGReT2/WY7uYt2eDCnf/hvAzXShc/hDSzrWBSDBw/d5
	 tsx8/t3QnouXMqtzwbu9EimdsKRwIhIgYOdkldiQ=
Message-ID: <d5dfd9a2-4ac6-415c-b719-699b264fa39d@arm.com>
Date: Tue, 24 Nov 2026 16:13:52 +0000
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
Subject: Re: [PATCH] swiotlb: clear read bounce buffers on confidential guests
To: Shukai Ni <shukai.ni@kuleuven.be>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
Cc: "jo.vanbulck@cs.kuleuven.be" <jo.vanbulck@cs.kuleuven.be>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "kas@kernel.org"
 <kas@kernel.org>, "carlos.bilbao@kernel.org" <carlos.bilbao@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261123205302.1034348-1-shukai.ni@kuleuven.be>
 <3a70a26adccc47b1bae3a22e4907174271703a10.camel@intel.com>
 <9bc0d7ed-0799-45dc-8d74-25ed66851a20@kuleuven.be>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <9bc0d7ed-0799-45dc-8d74-25ed66851a20@kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 10:56 pm, Shukai Ni wrote:
> 
> 
> On 2026/11/23 23:18, Edgecombe, Rick P wrote:
>> There is an existing usptream position around coco driver hardening, 
>> that the
>> drivers should be fixed. In some ways this another thing that could be 
>> fixed in
>> a driver? The driver could zero memory before sharing it for 
>> DMA_FROM_DEVICE.
>>
>> But the swiotlb was supposed to be sort of a generic solution to the 
>> problem of
>> not inadvertently sharing private memory. Instead of marking an entire 
>> page as
>> shared (which might have private contents elsewhere on the page), the 
>> bounce
>> buffer allows for only sharing the minimum specified.
>>
>> So you could maybe look at this issue as fitting into the general 
>> problem of not
>> inadvertently sharing the private data inside the buffer. But also 
>> that is
>> covering for driver gaps.
> 
> Thanks for looking at this, and we had very similar thoughts when 
> writing the patch. Our impression was that in many cases the driver
> doesn't own the buffer (page cache, dm-crypt, O_DIRECT), so fixing it
> there seemed hard, which is why we tried swiotlb instead. But we may be
> missing something.
> 
>> It seems like the fixes commit was arguing that copying the contents 
>> to the
>> swiotlb buffer was more transparent. So this patch kind of goes back 
>> against
>> that argument. That seems to be another point that the drivers should 
>> be fixed.
>> If this is essentially more of a potentially behavior altering kernel 
>> hardening,
>> then I wonder about putting it behind some kind of hardening config like
>> CONFIG_INIT_ON_ALLOC_DEFAULT_ON.
> 
> As far as we can tell, keeping the old contents for DMA_FROM_DEVICE
> was never really promised. Before ddbd89deb7d3, swiotlb
> didn't do it. That commit was mainly about not returning stale bounce
> data to the caller, which zeroing should still prevent.

SWIOTLB is an implementation detail of the DMA API. If some future CoCo 
environment happens to be able to share a buffer in-place with less 
overhead than bouncing then it will be free to do so, and drivers which 
do not sanitise DMA_FROM_DEVICE or DMA_BIDIRECTIONAL buffers will 
continue to leak data...

Note in particular the case of DMA_BIDIRECTIONAL, which means the caller 
expects the buffer to either be written and read, or read and written, 
or read, or written, or any or all of the above. How is the DMA layer 
going to know whether the initial buffer contents are meaningful and 
must be preserved, or stale and potentially leaking something?

Also how is the DMA layer to know if a driver is intentionally making 
DMA_TO_DEVICE mappings of random (or targeted) kernel memory for the 
sole purpose of malicious sharing? If people want to use device drivers 
in CoCo environments then the onus being on auditing and hardening the 
individual drivers themselves doesn't seem too unreasonable.

Thanks,
Robin.

> In case it helps, we have a PoC on SEV-SNP that leaks MariaDB data from 
> a LUKS-encrypted disk through this path, and we're happy to share it.
> 
>> Ohh, but I guess the problem is the buffer getting copied could have 
>> come from
>> userspace? So then you would have to fix userspace... But then this 
>> patch could
>> also potentially break userspace if there is any partial write 
>> assumptions. Oh
>> boy.
> 
> Yes, a short read into a pre-filled user buffer would now see zeros. We
> did a pass over the drivers commonly used in CVMs and didn't find any
> that rely on the old contents being kept, but we'd be glad to hear if
> someone knows of a case.
> 
> Thanks,
> Shukai
> 

