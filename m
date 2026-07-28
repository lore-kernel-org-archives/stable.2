Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917D433E79;
	Tue, 28 Jul 2026 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241359; cv=none; b=LK59Xf3NAy6RXOqST5I910vXhJYLOmdKve3OavBsVuMQENBvE+guK/Tb/pNdnBCGAaIXz73nc50JFFj+AWJgdiHgCvGPZnDD6Adur8wEFx1fPQAHKkMDK5G65L3q1oiP87UUz4/ZZly6drpbdH9dFC4CiTq+vACPO02OnYek9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241359; c=relaxed/simple;
	bh=lPlW4VfY1i8WP63Cql62FW0Y2MadtfkTl4jZzNaD4ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nynn5aXXIdTw/fNkbPqm+TPSo9KvDkHDVv2Hv+VJIKMEdI1pTWXNg9xbLCM2+F4lP4S66DB2JIZjFGqlM2FkClQSEZ6DDE3ROgAoi4yqe7G8cNuJhruNp6UMsM5RE1SmvDzM+A9LOPgEzcG98vh6oR3wdbbp5UAoRKlmFzWE0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XmPtayir; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XmPtayir"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8ML0WC6GRaNOOkIw5COF6WGDDIeLwlOHGsn4lC5k480=;
	b=XmPtayirw6smnZsE679gJI8UEtJOhixO+xZqM1tAPuC2vynpStix/ElS0G0LIan13fetOOa51
	pc99CnHwMJpBqo+DlWMFbRU+pDFeXZKdIvhaJsL/KX6VxeHAwBVHfZ5b41Qa4pP/bOj5mulJyA0
	gtZVbzVwPLcJZGIaT78x78A=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h8Z9K1M1Qz1T4Fq;
	Tue, 28 Jul 2026 20:12:53 +0800 (CST)
Received: from whupemo500009.china.huawei.com (unknown [7.152.184.116])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CB1340538;
	Tue, 28 Jul 2026 20:22:22 +0800 (CST)
Received: from [100.103.109.247] (100.103.109.247) by
 whupemo500009.china.huawei.com (7.152.184.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jul 2026 20:22:21 +0800
Message-ID: <c9643f86-f196-4c99-8129-2314a33a990f@huawei.com>
Date: Tue, 28 Jul 2026 20:22:19 +0800
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
Content-Language: en-GB
From: Jiacheng Yu <yujiacheng3@huawei.com>
In-Reply-To: <dfe25916-0f2e-44ed-8f49-d7448a0e28fa@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemo500009.china.huawei.com (7.152.184.116)

On 28/07/2026 18:46, Petr Pavlu wrote:
> On 7/28/26 10:55 AM, Jiacheng Yu wrote:
>> param_set_charp() stores charp parameters in allocated memory after slab is
>> available, and releases the previous value when the parameter is updated.
>>
>> The previous value is released before the replacement allocation succeeds.
>> If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
>> left as NULL.
>>
>> Failing zswap's compressor update before zswap is initialized can later
>> trigger:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   RIP: 0010:strcmp+0x10/0x30
>>   Call Trace:
>>     zswap_setup+0x3b1/0x490
>>     zswap_enabled_param_set+0x5b/0xa0
>>     param_attr_store+0x93/0xe0
>>     module_attr_store+0x1c/0x30
>>     kernfs_fop_write_iter+0x116/0x1f0
>>
>> Allocate and copy the replacement first, then replace the parameter value
>> only after allocation succeeds.
>>
>> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
> 
> It makes sense to me for param_set_charp() to have commit-or-rollback
> semantics. The set callbacks of other standard parameters behave this
> way, with the exception of array parameters.

Thanks. That is the intent of this patch.

> 
>> ---
>>  kernel/params.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/params.c b/kernel/params.c
>> index a668863a4bb6..e4f2b71dde1e 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
>> @@ -261,6 +261,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
>>  
>>  int param_set_charp(const char *val, const struct kernel_param *kp)
>>  {
>> +	char *tmp;
>>  	size_t len, maxlen = 1024;
>>  
>>  	len = strnlen(val, maxlen + 1);
>> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>>  		return -ENOSPC;
>>  	}
>>  
>> -	maybe_kfree_parameter(*(char **)kp->arg);
>> -
>>  	/*
>>  	 * This is a hack. We can't kmalloc() in early boot, and we
>>  	 * don't need to; this mangled commandline is preserved.
>>  	 */
>>  	if (slab_is_available()) {
>> -		*(char **)kp->arg = kmalloc_parameter(len + 1);
>> -		if (!*(char **)kp->arg)
>> +		tmp = kmalloc_parameter(len + 1);
>> +		if (!tmp)
>>  			return -ENOMEM;
>> -		strcpy(*(char **)kp->arg, val);
>> +		strscpy(tmp, val, len + 1);
> 
> What's wrong with the plain strcpy() here?

Functionally, plain strcpy() is fine here.  The preceding
strnlen(val, maxlen + 1) either finds the NUL byte within the limit or
rejects the string, and the new allocation is exactly len + 1 bytes.

However, when this patch rewrites the line to use tmp,
checkpatch --strict reports the following warning:

    WARNING: Prefer strscpy over strcpy

Since the line is being rewritten anyway, I changed strcpy() to
strscpy() to follow that preference:
https://github.com/KSPP/linux/issues/88

> 
>>  	} else
>> -		*(const char **)kp->arg = val;
>> +		tmp = (char *)val;
>> +
>> +	maybe_kfree_parameter(*(char **)kp->arg);
>> +	*(char **)kp->arg = tmp;
> 
> Sashiko reports [1] that there is a pre-existing use-after-free window
> between freeing the old parameter and updating kp->arg. However, this
> issue doesn't appear to be valid because any concurrent access to
> a writable charp parameter should be protected by kernel_param_lock().
> This is documented include/linux/moduleparam.h [2].

I agree.  Writable charp parameters are expected to be protected by
kernel_param_lock(), and this patch does not change that locking model.

> 
>>  
>>  	return 0;
>>  }
> 
> [1] https://lore.kernel.org/linux-modules/20260728075803.AA13C1F000E9@smtp.kernel.org/
> [2] https://github.com/torvalds/linux/blob/v7.2-rc5/include/linux/moduleparam.h#L124
> 

