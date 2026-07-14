Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2693A254C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999164; cv=none; b=riwcuDHfNpC7FXEIgnhLV+NzdG4rg+nEvPaYvH2LyIDvE1RiDWbsYzrbSfUR1kfAgKiIwf67mRgv47812jQQbCBmqgtwWmJFfT6nlSDQADEFPiwQMlp2iaouvGj0Si6qiJRH87pqjv4Q8yrLXM0RY5AQYSAyRHWSkos1YTatQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999164; c=relaxed/simple;
	bh=6RrHeppzkzfU+SHIqDJ1xWIS0q8JFrR+C+V0L1kHG4I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EZtVSvZoivP9oBoMBVQrnxT1usYu6Tuu4Pblxl4c65EXzG1YGb8frS/BWVXH2Kc7vZXrf/m2XgcPKEkhRkHdAxcPhcEq8WwLMtvG59vscqwbJsk3+8ByygZMU/tMXI1xzZ1WM5UnokLFZfdTnR/s4tOGUPP0n19egtcnu+Pw1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTZZ/MhG; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTZZ/MhG"
Message-ID: <6d591685-ee60-49a8-b883-f3d0a9395dd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783999150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FqoW5vhqKhg1zCd1cbexcf+W2Xlo42P5CIW3iiN/l8=;
	b=jTZZ/MhG7gSRciEDdAyQd5WQHLnVHJ2ua3YHVc82LoamHLJkYvBKJ6AFiCYr9SXhBN/Oiy
	HC1zILZj5BvOio8jZhF129F77OKclZ58t7MXJlWtSdDCX43Qb/sjropOe4VMVMJvO0rX8t
	DAmphx8ZxQcoFp8qxUP9bfCrvi+2k3c=
Date: Tue, 14 Jul 2026 11:19:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, kernel@xen0n.name, lixianglai@loongson.cn,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] LoongArch: KVM: EIOINTC: clamp ipnum to valid range
 in INT_ENCODE mode
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org
References: <20260714012452.1021833-1-cui.tao@linux.dev>
 <20260714012452.1021833-2-cui.tao@linux.dev>
 <69470d5d-6c67-c42d-b8f8-8c115599703e@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <69470d5d-6c67-c42d-b8f8-8c115599703e@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/14 10:32, Bibo Mao 写道:
> Hi Tao,
> 
> Thanks to catch this, there is similar modification which can be located at:
> https://lore.kernel.org/lkml/20260709082109.1361767-5-maobibo@loongson.cn/
> 
Hi Bibo,

Haha, looks like we raced to the same fix :) I came across it while
debugging VM migration (the LOAD_FINISHED restore path). Your patch
takes priority — I'll go ahead and drop my series.

Thanks,
Tao

> Regards
> Bibo Mao
> 
> On 2026/7/14 上午9:24, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> The IP-number decode in eiointc_set_sw_coreisr() and eiointc_update_irq()
>> clamps ipnum only in the default (1-hot) mode. In INT_ENCODE mode the raw
>> ipmap byte (0..255) is used as the index into sw_coreisr[cpu][ipnum],
>> whose second dimension is LOONGSON_IP_NUM (8), so any ipmap byte >= 8
>> accesses the array out of bounds.
>>
>> The value is guest-programmable through the EIOINTC virtual extension
>> (VIRT_CONFIG enables INT_ENCODE and the IPMAP IOCSR write is unvalidated)
>> and is also restored unvalidated from a migration stream via the
>> LOAD_FINISHED control attribute, resulting in a host slab out-of-bounds
>> access reachable from an unprivileged guest.
>>
>> Clamp ipnum to [0, LOONGSON_IP_NUM) in INT_ENCODE mode as well.
>>
>> Fixes: 3956a52bc05b ("LoongArch: KVM: Add EIOINTC read and write functions")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kvm/intc/eiointc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
>> index 2b14485d14a7..0c34d7ab264d 100644
>> --- a/arch/loongarch/kvm/intc/eiointc.c
>> +++ b/arch/loongarch/kvm/intc/eiointc.c
>> @@ -17,6 +17,8 @@ static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
>>           if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>>               ipnum = count_trailing_zeros(ipnum);
>>               ipnum = ipnum < 4 ? ipnum : 0;
>> +        } else {
>> +            ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
>>           }
>>             cpuid = ((u8 *)s->coremap)[irq];
>> @@ -42,6 +44,8 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
>>       if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>>           ipnum = count_trailing_zeros(ipnum);
>>           ipnum = ipnum < 4 ? ipnum : 0;
>> +    } else {
>> +        ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
>>       }
>>         cpu = s->sw_coremap[irq];
>>
> 

