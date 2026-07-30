Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF7439343
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419034; cv=none; b=Ok/xZmKXOB+njNp/sbr1pcZNoeAhQXQ8fQwXKytCikONDB0ylqSC5gSR4c8mMBWOL7Y0CVp4w4euF9otrqDb8XWE1P7lsg4k4WEGL/J/nUOcjAL/1TKsniBw2nahLQRUNe8L9qJqYMVGOWNxLtH92+fdjpofeurLy/oAO6U9A0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419034; c=relaxed/simple;
	bh=IjUWUxvhZnzai6pgDuX7LgOB658l0XXeyj263Uv8xcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbarJv386Mcn3k1M69OH5hENzoOT6hJdW91n1ofHn+IMAm2kkpUmq+hulM5k8bcJuyzgIKncatyJBVR4igUPDskBGsTAvaliDq6U0ZQRc/l95ejj24Gjz46fFmoJvyhUJRkpENSm6T6qoIMi/v/pg8qLKNG3ilvYGoQfOeyFp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ls3V21wX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ls3V21wX"
Message-ID: <6a20bbdd-2557-4db8-8839-e2f53857ced9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785419020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSUgRH1bkQ5B4oh0ZVWuwBgDEXcmcvDDnq0a/P5vrsQ=;
	b=Ls3V21wXHbtGvyQz8L2ldqSAAri+UREahyAkxB6rics/4Y8xopWC41GTkFtFrSkO/2ehFj
	e2HsaG/qOEAb727k5eVx159xZYBOyiuO+614OyvFQ+HYHGphu5EBYkqlVFMoK6AW4kLCY2
	dx/PMRxRnIFV49oSVLM70LSxjc9uoSw=
Date: Thu, 30 Jul 2026 21:43:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bpf-next 05/11] bpf: Disable preemption in
 bpf_get_stackid
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 stable@vger.kernel.org, Tao Chen <chen.dylane@linux.dev>,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>,
 STAR Labs SG <info@starlabs.sg>, Arnaud Lecomte <contact@arnaud-lcm.com>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-6-jolsa@kernel.org>
 <78c72a5b-0db5-47da-8b35-e6a2e6976d7c@linux.dev> <ams3yHvqyXrWAbBV@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <ams3yHvqyXrWAbBV@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/30 19:38, Jiri Olsa wrote:
> On Wed, Jul 29, 2026 at 06:30:26PM +0800, Leon Hwang wrote:
>> On 29/7/26 16:38, Jiri Olsa wrote:
>>> The get_perf_callchain call needs disabled preemption plus we need
>>> it disabled as long as we access its returned trace entries buffer.
>>>
>>> Note the bpf_get_stackid_pe function is executed already with
>>> preemption disabled.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
>>> Reported-by: Tao Chen <chen.dylane@linux.dev>
>>> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>  kernel/bpf/stackmap.c | 19 +++++++++++++------
>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>> index 43b1e5436047..e48ddb4edd47 100644
>>> --- a/kernel/bpf/stackmap.c
>>> +++ b/kernel/bpf/stackmap.c
>>> @@ -624,30 +624,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>>  	struct perf_callchain_entry *trace;
>>>  	struct stackid stackid;
>>>  	bool kernel = !user;
>>> +	int err = -EFAULT;
>>>  	u32 max_depth;
>>> -	int err;
>>>  
>>>  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>>>  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>>>  		return -EINVAL;
>>>  
>>>  	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
>>> +
>>> +	preempt_disable();
>>
>> Better to use the guard-style guard(preempt)() in this series.
> 
> we prefer to call stackid_install with preemption enabled


Understand.

I wonder if we could avoid the "goto out".

scoped_guard(preempt) { ... } might work here.

But "goto out" is fine with me as well.

Thanks,
Leon

> 
> jirka
> 
>>
>> Thanks,
>> Leon
>>
>>>  	trace = get_perf_callchain(regs, kernel, user, max_depth,
>>>  				   false, false, 0);
>>>  
>>>  	if (unlikely(!trace))
>>>  		/* couldn't fetch the stack trace */
>>> -		return -EFAULT;
>>> +		goto out;
>>>  
>>>  	err = stackid_fastpath(&stackid, map, trace, flags);
>>>  	if (err != -ENOENT)
>>> -		return err;
>>> +		goto out;
>>>  
>>>  	new_bucket = stackid_new_bucket(&stackid, map);
>>> -	if (!new_bucket)
>>> -		return -ENOMEM;
>>> +	if (new_bucket) {
>>> +		preempt_enable();
>>> +		return stackid_install(&stackid, map, new_bucket, flags);
>>> +	}
>>> +	err = -ENOMEM;
>>>  
>>> -	return stackid_install(&stackid, map, new_bucket, flags);
>>> +out:
>>> +	preempt_enable();
>>> +	return err;
>>>  }
>>>  
>>>  const struct bpf_func_proto bpf_get_stackid_proto = {
>>

