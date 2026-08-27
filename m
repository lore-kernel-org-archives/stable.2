Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20183002AB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800481; cv=none; b=b7HfEzADi3k9oFpmkj5c79S7/D04JGnuAU0pvq+0C4foxRwkCZMoR105pXJaEOAqnCiL9sKZ6SdktawMurD3R+vazAFnIyWceBkM/DEUFqReIK4Pktt6fczCtAgEOl1xAyMl3TBB94/tOzQT0WcQeJKtlu0+lwJdHVVXlJbvkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800481; c=relaxed/simple;
	bh=Q+gna+bhb0/2/IY4g7WWY69+Ql80/XbKIgWH/Re8wWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq4hwP5ebHz+0CCPiVbaCWHUWVTuCdoy0UrFd1YrWGF3axvRDg1bXlUXNFEdEcB6oqfHiymLkBpqw/gOjccZmcwAxVKVgpwA6obSaFwvKawfCBmYVvgdJ8bp9vPKkwMevIIrexng1OsRPcQrsqWUMvW8bU5PSZ1WvsouAgLTEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hngsiTok; arc=none smtp.client-ip=95.215.58.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hngsiTok"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q+gna+bhb0/2/IY4g7WWY69+Ql80/XbKIgWH/Re8wWI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787800477; v=1; x=1788405277;
 b=hngsiTokeRW405P3xGZOCh9PQ6pOkNuA4h+QYA8O+ZdauqoWgCsW/s1BW7pipsuZtZZTp6qC
 u1J18C/XyvXXyYdsQg6OeO05ih8zpMylkM8Hv5KmANxD7Qv/gJKw5oy1GYAHlC8pac10lIGSU/Y
 z3doDqVZA0jTOePzvt8e+Pc0=
X-Envelope-To: stable@vger.kernel.org
Received: from [10.42.12.33] (116.128.244.169)
	by smtp.migadu.com with ESMTPS id 1fabd41ce34882da;
	Thu, 27 Aug 2026 03:14:37 +0000
X-Mizu-Trace-ID: 1fabd41ce34882da
X-Migadu-Flow: FLOW_OUT
Message-ID: <522f3a12-697c-4e1d-9ec8-4edb05e31862@linux.dev>
Date: Thu, 27 Aug 2026 11:15:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260824014736.35026-1-hao.ge@linux.dev>
 <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr


On 2026/8/26 17:24, Petr Pavlu wrote:
> On 8/24/26 3:47 AM, Hao Ge wrote:
>> If codetag_load_module() fails, err is never set and load_module()
>> returns 0 after the module has been torn down.
>>
>> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  kernel/module/main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 46dd8d25a605..afb810f0154c 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>  			goto sysfs_cleanup;
>>  	}
>>  
>> -	if (codetag_load_module(mod))
>> +	err = codetag_load_module(mod);
>> +	if (err)
>>  		goto sysfs_cleanup;
>>  
>>  	/* Get rid of temporary copy. */
> 
> This looks ok to me but there appears another bug related to this code
> that would be good to fix at the same time. If the module is
> a livepatch, the preceding call to copy_module_elf() allocates
> mod->klp_info. However, if codetag_load_module() fails, the code doesn't
> free it.
> 

Yes, I missed that. Thanks for catching it!
I've folded your suggested fix into v2 (already sent) and tested it.

Thanks
Best Regards
Hao

> I think we want something like this (not tested):
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..c1b34dc1e89a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3581,8 +3581,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  			goto sysfs_cleanup;
>  	}
>  
> -	if (codetag_load_module(mod))
> -		goto sysfs_cleanup;
> +	err = codetag_load_module(mod);
> +	if (err)
> +		goto livepatch_cleanup;
>  
>  	/* Get rid of temporary copy. */
>  	free_copy(info, flags);
> @@ -3592,6 +3593,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  
>  	return do_init_module(mod);
>  
> + livepatch_cleanup:
> +	if (is_livepatch_module(mod))
> +		free_module_elf(mod);
>   sysfs_cleanup:
>  	mod_sysfs_teardown(mod);
>   coming_cleanup:
> 
