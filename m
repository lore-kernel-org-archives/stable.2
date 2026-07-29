Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD6445ACC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321052; cv=none; b=ZlrG6Bd9uzIGWqk9tTy3NXF85ByRMU+JvjP1+bpHn1dXMXzHk17XOE/Qzj5JZZC+nc73h04XeceAdRc/25uNrCYUPqB4EXNAkgeQFHBt8ohPPxVygkUwVYiU2w4TWUkTffG7I6H+ZzAR8f3IW/E8kf2gYuJ0OhLspFnJ4OzdoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321052; c=relaxed/simple;
	bh=Cy5N6zlZ9b+XmpW0/6GyguVpMPAiNxmOBSnwgn+3+Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/48RzF3SEPfrAbRMs6m+a3xraOc9DF10Auto9G4mkzptevQ5wYYoYHggauAg7NbHDmPic2sD8bUzdCgNvaC9rTJOKlANHHAQeWnAc6dsmSPSYa7sKRv3tnpvKYs9vd3THwBoza1WAUXaV1dokDqzwZM87+XSYWLwG+iKcqPWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MIFf0q+r; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MIFf0q+r"
Message-ID: <78c72a5b-0db5-47da-8b35-e6a2e6976d7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785321038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71w+xsKQcAmFscJxORmgtr1I//z8WEmDAbZZVSyKA/Y=;
	b=MIFf0q+rSw0bKogI3sLsiUryXnbi1Hm9iZxeHrsxku8YDQ9pVX//EzteoZMnaHmTZFx4VZ
	UMtvyFBP5MPgJJBnH9B6gWag9fkAiMBelsa54NRqQe+u/H+XzsjX2YGajlc2/SuQw7rcaa
	Iu19o0+TIBmVSNpGFu/sayBWn/fmbCo=
Date: Wed, 29 Jul 2026 18:30:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bpf-next 05/11] bpf: Disable preemption in
 bpf_get_stackid
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, Tao Chen <chen.dylane@linux.dev>,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>,
 STAR Labs SG <info@starlabs.sg>, Arnaud Lecomte <contact@arnaud-lcm.com>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-6-jolsa@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260729083807.1588544-6-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/7/26 16:38, Jiri Olsa wrote:
> The get_perf_callchain call needs disabled preemption plus we need
> it disabled as long as we access its returned trace entries buffer.
> 
> Note the bpf_get_stackid_pe function is executed already with
> preemption disabled.
> 
> Cc: stable@vger.kernel.org
> Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
> Reported-by: Tao Chen <chen.dylane@linux.dev>
> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/stackmap.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 43b1e5436047..e48ddb4edd47 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -624,30 +624,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  	struct perf_callchain_entry *trace;
>  	struct stackid stackid;
>  	bool kernel = !user;
> +	int err = -EFAULT;
>  	u32 max_depth;
> -	int err;
>  
>  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>  		return -EINVAL;
>  
>  	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +
> +	preempt_disable();

Better to use the guard-style guard(preempt)() in this series.

Thanks,
Leon

>  	trace = get_perf_callchain(regs, kernel, user, max_depth,
>  				   false, false, 0);
>  
>  	if (unlikely(!trace))
>  		/* couldn't fetch the stack trace */
> -		return -EFAULT;
> +		goto out;
>  
>  	err = stackid_fastpath(&stackid, map, trace, flags);
>  	if (err != -ENOENT)
> -		return err;
> +		goto out;
>  
>  	new_bucket = stackid_new_bucket(&stackid, map);
> -	if (!new_bucket)
> -		return -ENOMEM;
> +	if (new_bucket) {
> +		preempt_enable();
> +		return stackid_install(&stackid, map, new_bucket, flags);
> +	}
> +	err = -ENOMEM;
>  
> -	return stackid_install(&stackid, map, new_bucket, flags);
> +out:
> +	preempt_enable();
> +	return err;
>  }
>  
>  const struct bpf_func_proto bpf_get_stackid_proto = {

