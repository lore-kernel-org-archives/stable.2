Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF8199949;
	Wed, 29 Jul 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324160; cv=none; b=V4cfiPIyMqFB2H0BHz5+EAFMQ01pKrnQrsqmVKCoHZNZQRMX0FjmdW1XIzJeMh3Rm/Vqkd3v0Z/NdKOStZcPYzSMWy5LFOtwEYY7wXFtaP6m5u6som4PqupVZ/3VoMxCLY9Z0+LtCXSjSaGEOqHadNmoqC+zJJnkTQv4QjI03bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324160; c=relaxed/simple;
	bh=n65bQH6zeEINoB60fgeuH8MSETQDZMGuQZCAAEut1rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=skHjbDh8B0hZAsksq+jINgUYcZQeeVg0EbPI6ktI0Rk+7IXRiRN2gE1rR72Rj4ohn/vA29VzgA3wE/AwD4UclJ6tGPXHGGF3p/dsmEJ1zxjO2xbb9THWafzwv4rvLZpf3tAztF1IiUq7baLhwPb8pLAFgtnbZZWL40qF/B8GbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rT2w4J14; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rT2w4J14"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Yq9RcTPQukrz44sSQPDwwqwbVc0C7hhnfU9ii4SNZfY=;
	b=rT2w4J14eUS2GClp77ZiNXc7mj/P5T2aqIW9qZcCpNFwr7JPKAEZZpyC/3N3YCZ5CWZfJ7qQL
	ARJrPAQGKJd9Q7uhsvGUbvq3Ih6VU/7J11WyVjy074cRsuHZ1Je0NJ1dZh6tO257C6vSiSMXimk
	NqfSrlWEXx6GH7no99mjM9I=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h98ns1bBJzLlXF;
	Wed, 29 Jul 2026 19:13:05 +0800 (CST)
Received: from whupemo500009.china.huawei.com (unknown [7.152.184.116])
	by mail.maildlp.com (Postfix) with ESMTPS id 41B39402AB;
	Wed, 29 Jul 2026 19:22:32 +0800 (CST)
Received: from [100.103.109.247] (100.103.109.247) by
 whupemo500009.china.huawei.com (7.152.184.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Jul 2026 19:22:30 +0800
Message-ID: <b3ea698b-95b2-4f5d-ac20-e9e5cdf08712@huawei.com>
Date: Wed, 29 Jul 2026 19:22:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: fix charp corruption on allocation failure
To: Petr Pavlu <petr.pavlu@suse.com>
CC: <samitolvanen@google.com>, <rusty@rustcorp.com.au>, <hannes@cmpxchg.org>,
	<yosry@kernel.org>, <nphamcs@gmail.com>, <liuyongqiang13@huawei.com>,
	<linux-modules@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260728085518.3865621-1-yujiacheng3@huawei.com>
 <dfe25916-0f2e-44ed-8f49-d7448a0e28fa@suse.com>
 <c9643f86-f196-4c99-8129-2314a33a990f@huawei.com>
 <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
Content-Language: en-GB
From: Jiacheng Yu <yujiacheng3@huawei.com>
In-Reply-To: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo500009.china.huawei.com (7.152.184.116)



On 28/07/2026 20:57, Petr Pavlu wrote:
> On 7/28/26 2:22 PM, Jiacheng Yu wrote:
>> On 28/07/2026 18:46, Petr Pavlu wrote:
>>> On 7/28/26 10:55 AM, Jiacheng Yu wrote:
>>>> diff --git a/kernel/params.c b/kernel/params.c
>>>> index a668863a4bb6..e4f2b71dde1e 100644
>>>> --- a/kernel/params.c
>>>> +++ b/kernel/params.c
>>>> @@ -261,6 +261,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
>>>>  
>>>>  int param_set_charp(const char *val, const struct kernel_param *kp)
>>>>  {
>>>> +	char *tmp;
>>>>  	size_t len, maxlen = 1024;
>>>>  
>>>>  	len = strnlen(val, maxlen + 1);
>>>> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>>>>  		return -ENOSPC;
>>>>  	}
>>>>  
>>>> -	maybe_kfree_parameter(*(char **)kp->arg);
>>>> -
>>>>  	/*
>>>>  	 * This is a hack. We can't kmalloc() in early boot, and we
>>>>  	 * don't need to; this mangled commandline is preserved.
>>>>  	 */
>>>>  	if (slab_is_available()) {
>>>> -		*(char **)kp->arg = kmalloc_parameter(len + 1);
>>>> -		if (!*(char **)kp->arg)
>>>> +		tmp = kmalloc_parameter(len + 1);
>>>> +		if (!tmp)
>>>>  			return -ENOMEM;
>>>> -		strcpy(*(char **)kp->arg, val);
>>>> +		strscpy(tmp, val, len + 1);
>>>
>>> What's wrong with the plain strcpy() here?
>>
>> Functionally, plain strcpy() is fine here.  The preceding
>> strnlen(val, maxlen + 1) either finds the NUL byte within the limit or
>> rejects the string, and the new allocation is exactly len + 1 bytes.
>>
>> However, when this patch rewrites the line to use tmp,
>> checkpatch --strict reports the following warning:
>>
>>     WARNING: Prefer strscpy over strcpy
>>
>> Since the line is being rewritten anyway, I changed strcpy() to
>> strscpy() to follow that preference:
>> https://github.com/KSPP/linux/issues/88
> 
> I don't see a benefit to using strscpy() here. The length of the string
> is already known and the tmp buffer is correctly sized, so using
> `memcpy(tmp, val, len + 1)` seems most appropriate to me.

Agreed, memcpy() is more appropriate here since the length is already
known. Changed in v2, thanks for the review.

> 

