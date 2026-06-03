Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2937188B;
	Wed,  3 Jun 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487904; cv=none; b=PCHU8OwWuVaJX7nb9I8JKABwUDRWsyKTkHCFyQA39CdH0SbA1dcVzCBAXTnRkWcJJ/X21AHZdFh6lVpSDSaVAYr34IeJt2C+wFbIaF5fqESxMpdDuVv2mPSgPDY45juN67Ovuo9ngib58opfJcHb9gH+sHaFJ7tsHWmOQhFt6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487904; c=relaxed/simple;
	bh=nilUii0OnSY1feyGmlXpylAihTHedlgQ25Y93i1PZBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsPv82Y3HR7M0JrhveIRuaQQc4GcnieuH0FltyFxJysxz9NMkaj9B85IBel+ce3xEnaTzr7lOZKHIVRcaC1xYo4MZ7cBdNBW4nhJaHhDV1ClsbjiY/zEcVfctPQu2e1p89iSqJgqmsU2vo1q3PQIkJO48X9v8GQ89yUarqgspYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sp9GPVuv; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sp9GPVuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3bNByowXrmsiUb5wtqeACPI7CswPK4lCop6zQyCc7Bs=;
	b=Sp9GPVuvTq4nA1zdNoTeeVG+Q1qIlvIcg4K9Sfwaw9A2iOO7qZDBD9FT0w/lp4
	jlLU88ysDjVTfZv6eNnUoNGBgo3oiruzpMP7hgRUGlz9uOGLr7/06/4evVNhBvV8
	Dl5YiqUzpftD0TdXuvZ7VJR91EFHNRkUFO/vl5glEah2Y=
Received: from [IPV6:2409:8a00:dd3:9760:a4ca:4e0f:ae2:5f06] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnb3a5FiBqOcRmBA--.36540S2;
	Wed, 03 Jun 2026 19:57:47 +0800 (CST)
Message-ID: <e62974e5-f341-47e5-9563-354df51aa6db@163.com>
Date: Wed, 3 Jun 2026 19:57:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] HID: core: Mitigate potential OOB by removing
 bogus memset()
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
References: <20260603054344.80160-1-jetlan9@163.com>
 <ah_RiLcNbfyfDHko@beelink>
From: Wenshan Lan <jetlan9@163.com>
Content-Language: en-US
In-Reply-To: <ah_RiLcNbfyfDHko@beelink>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnb3a5FiBqOcRmBA--.36540S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyfWw1rCryxtF4xJw1UKFg_yoW8KrWkpF
	yYyFZ0kryDtrykCF47KF4UAayrtwn5JF17WFWUGw1rZryYkasFqr1I9rWFvrZ8urs7trZ2
	kF4Dtas8uFyYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7GYJUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6xtWH2ogFrvmZgAA3e


On 6/3/2026 3:04 PM, Benjamin Tissoires wrote:
> On Jun 03 2026, Wenshan Lan wrote:
>> From: Lee Jones <lee@kernel.org>
>>
>> [ Upstream commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c ]
>>
>> The memset() in hid_report_raw_event() has the good intention of
>> clearing out bogus data by zeroing the area from the end of the incoming
>> data string to the assumed end of the buffer.  However, as we have
>> previously seen, doing so can easily result in OOB reads and writes in
>> the subsequent thread of execution.
>>
>> The current suggestion from one of the HID maintainers is to remove the
>> memset() and simply return if the incoming event buffer size is not
>> large enough to fill the associated report.
>>
>> Suggested-by Benjamin Tissoires <bentiss@kernel.org>
>>
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> [bentiss: changed the return value]
>> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>> [ Replace hid_warn_ratelimited() with hid_warn() in v6.12. ]
>> Signed-off-by: Wenshan Lan <jetlan9@163.com>
>> ---
> This commit is known for breaking devices. You can't backport this
> without the following 3 fixes:
> 4d3a2a466b8d ("HID: core: Fix size_t specifier in hid_report_raw_event()")
> 206342541fc8 ("HID: core: introduce hid_safe_input_report()")
> 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
>
> Note that this is the same for your 6.6, 6.1 and 5.15 patches.

Thanks for your suggestion, I will send a V2 later.

Wenshan

>
> Cheers,
> Benjamin
>
>>   drivers/hid/hid-core.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 294a25330ed0..6d61bf20ec3f 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -2029,9 +2029,10 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>>   		rsize = max_buffer_size;
>>   
>>   	if (csize < rsize) {
>> -		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
>> -				csize, rsize);
>> -		memset(cdata + csize, 0, rsize - csize);
>> +		hid_warn(hid, "Event data for report %d was too short (%d vs %d)\n",
>> +			 report->id, rsize, csize);
>> +		ret = -EINVAL;
>> +		goto out;
>>   	}
>>   
>>   	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
>> -- 
>> 2.43.0
>>
>>

