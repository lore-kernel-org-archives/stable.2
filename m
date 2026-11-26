Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702009;
	b=LE766o+vjd3s9OfQggW2IAS5W62aSm0psjUMnchNtYknG/rL5Ea5cFpRoUXquG1rxOu+
	 MBGdjGCCX+IQVdPn9LU+P9agKcBtNZ5su15xxTwfyi46sy5rcVpNvkrnhB6jOjvj+aD9e
	 qDWJR7XfhX6BvVhKMFycUqi6bg7+VOluGQ8ZBXJG9Q56cgZQmEgbveCyW0DygAolQ7P8l
	 Gtu5KXjrqWKOYhNeAzvD4r/x9iOXOrm/DXcwF/yjbW/+TH9dD45rggOOWkOazakUvTezU
	 /i4kglytE1a5mzeRRSJBrPsHXt5NAB1ZXjCnkevKjYSFFSv0ayEnMtKjOlaMY9muGUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702009;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OOfWWga3i3IweeJhS2lLSdRp47VjlukP2YJhMBAP40I=;
	b=IHUqGo6jnRTfp8Gfv5j95b3tnujX8g02+Nul4aW6+06MEtKSlzOqsVhrZlzXWg6QOSxz
	 bexgdH6IMjnx0sp1IcLxLQsaw5c8BSPTEVWgjuv8k8rxOPpKgALHVhzLo9u3Mnv7nWmyu
	 +3dhC2lrqerh6RfCg9IprhXCzCBkKb+JVLeDP9sZq1ex7xd9nAMD9/iXvIAp2pAuVKxG3
	 PaHs9qUuy6x99PMaRO6GQfJZmRMcyoyVqz4H85vjGhqHIkd2CHqWjpV3VbpL1L63cr1ia
	 3S52hJ95NFP6BmXkPbXkIv/+AUaqDpUoaPVPoxCiqxm2y46o94aTyW9EclgpczElp7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA35606A31E;
	Thu, 26 Nov 2026 14:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA35606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1252609|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00578009-0.000105196-0.994115;FP=7468072167885343146|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.kAphqXC_1795701994;
Received: from 192.168.43.25(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.kAphqXC_1795701994 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 22:06:36 +0800
Message-ID: <e03f3be5-d012-48fa-99d4-f0610e040204@open-hieco.net>
Date: Thu, 26 Nov 2026 22:06:33 +0800
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
Subject: Re: [PATCH v3] x86/cpu/hygon: Work around XSAVES Erratum 1386
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 david.laight.linux@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 yangzhen@hygon.cn, dengqiming@hygon.cn, stable@vger.kernel.org
References: <20261124142632.844105-1-zhang_wei@open-hieco.net>
 <20261126044720.GDawe52PLY9WWihaLw@fat_crate.local>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20261126044720.GDawe52PLY9WWihaLw@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/26/2026 12:47 PM, Borislav Petkov wrote:
> On Tue, Nov 24, 2026 at 10:26:32PM +0800, Tina Zhang wrote:
>>   static void init_hygon(struct cpuinfo_x86 *c)
>>   {
>>   	u64 vm_cr;
>>   
>>   	early_init_hygon(c);
>> +	/*
>> +	 * Model 00h is a valid Hygon processor model, but x86_match_cpu()
>> +	 * treats a model value of 0 as X86_MODEL_ANY. Match Model 00h
>> +	 * explicitly.
>> +	 */
>> +	if ((c->x86 == 0x18 && c->x86_model == 0x00) ||
>> +	    x86_match_cpu(erratum_1386_cpus))
> 
> So this can be:
> 
> 	if ((c->x86 == 0x18) &&
> 	    (c->x86_model <= 0x6 || c->x86_model == 0x10))
> 
> and you don't need the _cpus table?

Yes, that covers all affected Family 18h models, including 00h.
I'll use that check and drop erratum_1386_cpus[] in v4.

Thanks,
Tina




