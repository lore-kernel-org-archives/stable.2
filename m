Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558001;
	b=wRe8Tr1G+I6oMrRBPrtolUsbW/YkDYjWTuUedqAodklHl8zwvcWbxKzjBY/fxYew5GZJ
	 kDYjODkhUHeONGTlWtIS/i5UEVzw+au3bZfTqvBaCumQm8k31j8m9FKx8yn+dhXM4OcQI
	 d019PtamtqetSKNzGjuPovAfCybEvUEJnGasVBdUCb9Qjs3F9phmohvmlfTws0WZOdQOT
	 KhovDTWr31C9PB/b4u7MPQp6heypMvNPOhRmJSQsc+bI+Oef0fTIeCDLFVjEObFDyqWfe
	 pdeJ/NLtNB2uIvv+zglCpSIccgieDzpz26B2XqquifRhflsyut13BE+FlD6XrN5PBqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558001;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=ylL32ZA+eS78yzSptteM2YgqxrCDp8OR2zVucYyFWyA=;
	b=VLqa3tuNf6bbTy8f6fSTkQGTAdQuV2pp9Pt58sGoAH1oclHkDU6DR9IBOtZ1xavNEucI
	 qFf4wYknhrwCZfRY/0MWns8WobqERdf2nXpRlsE6Ujt1qq2tdf+UDEgxCcr9/hbXY0GeY
	 c6YuRT3lilxncSeaftbIlcULhO9DcZjBLYM/C2scC5+wEvY+JDmuRWhZAvJvyX8BXT6nG
	 d8QbBtu+maYqdwElrLTnTWJuyX8Dh71WTYOtyZCxi8NDsIYuhM96NXkv7iqXFSDtolhdt
	 l+ap2lLPKzyUe6In3uF/UJwVtqq6eczblALR+pUv1QxS0temyqdbkAP860RN7gqbFSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=M3I78Ut2;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0597606A31C;
	Fri, 13 Nov 2026 08:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0597606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=M3I78Ut2
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ylL32ZA+eS78yzSptteM2YgqxrCDp8OR2zVucYyFWyA=;
	b=M3I78Ut2h1XzAqRsE6LbAjmsrN6fR2fuGwcNvCl6wBD+WoVt+ymegCUNqBcsK57fm9atPMBpB
	J+I8PGKpQY35yJYinAI/nmqnhffoMHFKpwrAm7oxY6xidGyrC8s9TC6Z/Ft4u0UoCh6sFLOltCY
	HIPmxuJM0PIsqR/ryTQlu08=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jQqtf5FCJz12LJQ;
	Fri, 13 Nov 2026 16:19:54 +0800 (CST)
Received: from kwepemk300003.china.huawei.com (unknown [7.202.195.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B120140579;
	Fri, 13 Nov 2026 16:19:48 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 kwepemk300003.china.huawei.com (7.202.195.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 13 Nov 2026 16:19:42 +0800
Message-ID: <c900aca6-e1a1-4155-a900-ff4abc270427@huawei.com>
Date: Fri, 13 Nov 2026 16:19:41 +0800
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
Subject: Re: [PATCH v4 3/3] mm: hugetlb: fix GFP mask propagation to CMA
To: Qi Zheng <qi.zheng@linux.dev>, <muchun.song@linux.dev>,
	<osalvador@suse.de>, <david@kernel.org>, <akpm@linux-foundation.org>,
	<azpijr@gmail.com>, <lance.yang@linux.dev>, Qi Zheng
	<zhengqi.arch@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<stable@vger.kernel.org>, "Oscar Salvador (SUSE)" <osalvador@kernel.org>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <1c5e8c4ae230dc238a16f2f42d65bffac6244ad3.1794379434.git.zhengqi.arch@bytedance.com>
 <7def88b4-cba5-4e8b-9e68-6069c492b582@huawei.com>
 <1cd3c151-24c2-4fec-8356-99853f8d6971@linux.dev>
 <9b46d8e0-104e-4659-8dec-67eb6f059dac@huawei.com>
 <dbfa9791-5a4e-4837-a2cc-ac506826761c@linux.dev>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <dbfa9791-5a4e-4837-a2cc-ac506826761c@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk300003.china.huawei.com (7.202.195.93)



On 11/13/2026 2:56 PM, Qi Zheng wrote:
> 
> 
> On 11/13/26 11:56 AM, Kefeng Wang wrote:
>>
>>
>> On 11/13/2026 10:30 AM, Qi Zheng wrote:
>>>
>>>
>>> On 11/12/26 7:27 PM, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 11/11/2026 2:46 PM, Qi Zheng wrote:
>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>
>>>>> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
>>>>> during the first MPOL_PREFERRED_MANY allocation attempt even though
>>>>> the caller clears __GFP_DIRECT_RECLAIM.
>>>>
>>>> MPOL_PREFERRED_MANY is only used for the partner allocator. Without 
>>>> your
>>>
>>> It's doesn't seem so.
>>>
>>> Gigantic surplus allocations already use MPOL_PREFERRED_MANY, following
>>> eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages"),
>>> which predates 9bda131c6093.
>>>
>>> alloc_buddy_hugetlb_folio
>>> --> MPOL_PREFERRED_MANY
>>>      --> gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
>>>          folio = alloc_surplus_hugetlb_folio(h, gfp, mpoli->nid, 
>>> nodemask);
>>>          --> alloc_fresh_hugetlb_folio
>>>              --> only_alloc_fresh_hugetlb_folio
>>>                  --> alloc_gigantic_frozen_folio
>>>                      --> hugetlb_cma_alloc_frozen_folio
>>>                          --> cma_alloc_frozen_compound
>>>
>>> Before 9bda131c6093, cma_alloc_folio() forwarded the caller's GFP mask.
>>> The conversion to cma_alloc_frozen_compound() replaced it with
>>> GFP_KERNEL, re-enabling direct reclaim during the preferred-node
>>> attempt.
>>
>> Oh, I forgot about that commit. The naming and some of the comments 
>> are misleading because alloc_buddy_hugetlb_folio/ 
>> alloc_surplus_hugetlb_folio
>> can allocate both buddy and gigantic folios (which can be allocated from
>> CMA).
>>
>> Maybe rename alloc_buddy_hugetlb_folio to hugetlb_alloc_surplus_folio,
>> or other names...
> 
> Naming is difficult. ;)
> 
> The Hugetlb implementation seems quite messy in many places; let’s focus
> on fixing the issues first.
> 

Indeed. thanks for you confirm.
