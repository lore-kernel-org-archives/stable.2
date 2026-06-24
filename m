Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C825B0AF
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296857; cv=none; b=HqbnzovHOv7A59i7FiWMlknekv2cKDq4UVREQEuodQJp15lMOy9Sgln4DQFQ6eyUPy3Q2WZ7fvxbym3kRSflvfPvvbz+p79D1cBVw68u7aol2WkMSqyXwmPsvkxLJz3Lm8qU+0OoRW1g55Ye65c+dcnCy6yW2gPh/2RILvK1JPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296857; c=relaxed/simple;
	bh=u9bP9bxHwZ38dfDOc4/LO+WOtIHwdP4W5THrVrDL0eY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tyKz4FPGlP5uDs9Y6InlVDN7JcHksH2forZUBQAqmfEs1MnxhjdHv66pmSRC5XN+I0+bOSzZ/ZtDIiFSdzPe3ZOMFVlxRJHYtMyA7HK8MHeAi5oCXaXlYQEDF7mbmMjOopv+1DiV2khkbIqMB8yTiZtacL7BXQQovLc5LtyQQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkNVZRRY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sFA0mv4V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkNVZRRY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sFA0mv4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782296854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtLnMoB8gHVYBGEeThpU9JHStgWwhRjg4tGsBmPG9Ow=;
	b=OkNVZRRYv9OrA9sUPvH/L9BVl1jZ9bCycpL+0sWDRuPD2C00vFwvgfxIJp1WyT1H37axNH
	IXVrzMK2LuBhauCgfV/u0Ah6iGvdsE+2E6YQsbL0TDVvuujX8YWYixyTmrUhqmDKmm6ncY
	OiZidRhppV3yPfPfT5NfW9arUzHjCfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-giXyyluRNoS-Rtrpc0TGQQ-1; Wed, 24 Jun 2026 06:27:31 -0400
X-MC-Unique: giXyyluRNoS-Rtrpc0TGQQ-1
X-Mimecast-MFC-AGG-ID: giXyyluRNoS-Rtrpc0TGQQ_1782296850
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49246459bc4so4723455e9.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782296850; x=1782901650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BtLnMoB8gHVYBGEeThpU9JHStgWwhRjg4tGsBmPG9Ow=;
        b=sFA0mv4VhPE3vGImEWViZxkSk890Octn1qh2/oNbF+RTh1xV9cl2B4fZ5qvfXYHkR5
         nkhfnTKi1tyPPSRHDm+RlwDMQJunwmz2ZZAokPzUje+RNgMjRCuiavS2PyV5crbyHXsP
         Y+JDkC6p8Mi4EL9etQCje87bHx+qggXaEKXs+p58AXYIOsI9XxChrsh9dM1J/alaD0i2
         mSafwl1cCYwDfXtPG8bS0MTcqBCa00Bpgo33jJ22IW8ElRfT1Q7aPc4oZjDwHevo7HoO
         7GPrl+rG3MopVSBKqlndfsQfc1JAYM3y96jooacgccK0snQvjpf1qTOERjJXp5p6hE8k
         qrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782296850; x=1782901650;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtLnMoB8gHVYBGEeThpU9JHStgWwhRjg4tGsBmPG9Ow=;
        b=cwPIr3y9ZhvVagiHWXdPtqbbe1bV5b5jtnl329p2UUkCKCSlKH283su1ZU/+SQkj0/
         m4SwURK73yvj04Sx5BxFZ0oMFwmmLXPT6f1dWVzj6S42Tk/we+m+CF/Jbpb9KmmerAKJ
         iJwpFi3fb3zOzvU/z3tb6XmNgK/ZgssxYam9NDT6INFY/0whd/IWG4ToVvCjSGBVILSJ
         eSJUeCgUlO1bsdW9V4QDX/JsgX+JVgBH3N/j/heia/+15/ajVNAfOry5TlJgQLo5OvL3
         tzGO0SaXdBaw70lby3dnin2AVS15aLLtaDe9rXBjRjYYPCC+fuJcwkrPpeRu9XU6UpnF
         bsgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+681DMmFom9C19R5O2+SeUgqyEGfqwf2S0RALB9N9D3s+XVArNgHLPITBlyCU6EEtQ4+a+1xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yjA78Enirr28qgWSxSzye5oOTljrm6qAMoiqGJhwulQpxwv8
	itNNUCo/M+k90518b3CcKSmLq/VAhNFycmP8vxeR6Emal8Ri+FlO7Vg7W3Ml63jc+UGnsuM53kr
	5JRs9PgUhlF9xROesa5cyxibbFrl1p8NY0sVp5bOAk6CtZ3QPxrTz4l77
X-Gm-Gg: AfdE7cnkfPdNBZxkGwuc81rpF1Vpp9DK6S7l4wE9n8x91dwudkD9YJJiUYc7DOdJKr/
	tqPMb2J2K79XAg05wwCPJtVpxaYqRzhlL5fQHk8l9sKWEXjBtRZH6TSxgbsm3sVbPR+/ZvKnnxw
	nwukamOZr0rN6OQdc9LrvSEuQ3Xt+YJKIrC0aSeMeNjyI2RxOr61qh3mU26MLh7jHDxcJRldUkV
	te3aS01XtDFDZGPkQRPUhreivW3d5yh0FTjeLDxilMNoX8RCu/UHd9atVO9pBWfTKy0UsfSbvvZ
	CDrCCs3XfLHh6aSzCfTbrZc703cNYPxM6nkZ1i5FDberAQd2vLyz55qy0YLHr0NHdKlTyXRl0O6
	+BabmvPVC3mqclzwsakfucwfQiWgooXrfTRt8IQYPRkXhuw==
X-Received: by 2002:a05:600c:1c25:b0:492:488c:f627 with SMTP id 5b1f17b1804b1-4925b359bc7mr109806965e9.11.1782296849984;
        Wed, 24 Jun 2026 03:27:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1c25:b0:492:488c:f627 with SMTP id 5b1f17b1804b1-4925b359bc7mr109806615e9.11.1782296849514;
        Wed, 24 Jun 2026 03:27:29 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923392dsm704470295e9.2.2026.06.24.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 03:27:29 -0700 (PDT)
Message-ID: <93e70dc7-e52f-444e-b57e-09d149dc4808@redhat.com>
Date: Wed, 24 Jun 2026 12:27:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
From: Viktor Malik <vmalik@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com> <ajq98dm4gAwEzkMb@google.com>
 <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
Content-Language: en-US
In-Reply-To: <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 08:47, Viktor Malik wrote:
> On 6/23/26 19:10, Namhyung Kim wrote:
>> Hello,
>>
>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
>>>> The loop for processing syscall args in augment_raw_syscalls has a
>>>> history of breaking with Clang updates, see e.g. commit 013eb043f37b
>>>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
>>>>
>>>> Now, a similar thing happened between Clang 21 and 22. While the issue
>>>> is mitigated on the main line by a recent verifier update, it remains
>>>> broken on the 6.12 and 6.18 stable branches:
>>>>
>>>>     [linux-6.18.y]# sudo perf trace true
>>>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>>>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>>>     [...]
>>>>     BPF program is too large. Processed 1000001 insn
>>>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
>>>>     -- END PROG LOAD LOG --
>>>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>>>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>>>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
>>>>     Error: failed to get syscall or beauty map fd
>>>>     [...]
>>>>
>>>> The reason is that the loop is quite complex and the BPF verifier often
>>>> struggles to prove that it terminates.
>>>>
>>>> Fix the issue by refactoring the loop body into a callback function and
>>>> calling the bpf_loop helper. This should prevent future breakages of
>>>> this kind since the callback function has no loops. It also allows to
>>>> drop a few artificial checks to help the verifier, including the changes
>>>> introduced by 013eb043f37b.
>>
>> Thanks for working on this.  I encountered this issue before and never
>> found time to take a deeper look yet.
>>
>>>>
>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
>>>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++-------
>>>>  1 file changed, 96 insertions(+), 61 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>>> index 2a6e61864ee0..6d553ed3ac23 100644
>>>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>>> @@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>>>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>>>>  }
>>>>  
>>>> +struct args_loop_ctx {
>>>> +	struct syscall_enter_args *args;
>>>> +	unsigned int *beauty_map;
>>>> +	void *payload_offset;
>>>> +	int value_size;
>>>> +	u64 *output;
>>>> +	bool *do_output;
>>>> +};
>>>> +
>>>> +static long process_arg_cb(u64 i, void *ctx)
>>>> +{
>>>> +	/*
>>>> +	 * Determine what type of argument and how many bytes to read from user space, using the
>>>> +	 * value in the beauty_map. This is the relation of parameter type and its corresponding
>>>> +	 * value in the beauty map, and how many bytes we read eventually:
>>>> +	 *
>>>> +	 * string: 1			      -> size of string
>>>> +	 * struct: size of struct	      -> size of struct
>>>> +	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>>> +	 */
>>>> +	struct augmented_arg *augmented_arg;
>>>> +	struct args_loop_ctx *loop_ctx;
>>>> +	int aug_size, size, index;
>>>> +	bool augmented;
>>>> +	void *arg;
>>>> +
>>>> +	/* Bounds check for the below map access to help the verifier */
>>>> +	if (i < 0 || i >= 6)
>>>> +		return 1;
>>>> +
>>>> +	loop_ctx = (struct args_loop_ctx *)ctx;
>>>> +	arg = (void *)loop_ctx->args->args[i];
>>>> +	augmented = false;
>>>> +	size = loop_ctx->beauty_map[i];
>>>> +	aug_size = size; /* size of the augmented data read from user space */
>>>> +	augmented_arg = (struct augmented_arg *)loop_ctx->payload_offset;
>>>> +
>>>> +	if (size == 0 || arg == NULL)
>>>> +		return 0; /* continue */
>>>> +
>>>> +	if (size == 1) { /* string */
>>>> +		aug_size = bpf_probe_read_user_str(augmented_arg->value, loop_ctx->value_size, arg);
>>>> +		augmented = true;
>>>> +	} else if (size > 0 && size <= loop_ctx->value_size) { /* struct */
>>>> +		if (!bpf_probe_read_user(augmented_arg->value, size, arg))
>>>> +			augmented = true;
>>>> +	} else if (size < 0 && size >= -6) { /* buffer */
>>>> +		index = -(size + 1);
>>>> +		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>>> +		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>>>> +		aug_size = loop_ctx->args->args[index];
>>>> +
>>>> +		if (aug_size > TRACE_AUG_MAX_BUF)
>>>> +			aug_size = TRACE_AUG_MAX_BUF;
>>>> +
>>>> +		if (aug_size > 0) {
>>>> +			if (!bpf_probe_read_user(augmented_arg->value, aug_size, arg))
>>>> +				augmented = true;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>>>> +	if (aug_size > loop_ctx->value_size)
>>>> +		aug_size = loop_ctx->value_size;
>>>> +
>>>> +	/* write data to payload */
>>>> +	if (augmented) {
>>>> +		int written = offsetof(struct augmented_arg, value) + aug_size;
>>>> +
>>>> +		if (written < 0 || written > sizeof(struct augmented_arg))
>>>> +			return 1; /* break */
>>>> +
>>>> +		augmented_arg->size = aug_size;
>>>> +		*loop_ctx->output += written;
>>>> +		loop_ctx->payload_offset += written;
>>>> +		*loop_ctx->do_output = true;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>>>  {
>>>> -	bool augmented, do_output = false;
>>>> -	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>>> +	bool do_output = false;
>>>> +	int zero = 0, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>>>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>>>> -	s64 aug_size, size;
>>>>  	unsigned int nr, *beauty_map;
>>>>  	struct beauty_payload_enter *payload;
>>>> -	void *arg, *payload_offset;
>>>> +	void *payload_offset;
>>>> +	long iters;
>>>>  
>>>>  	/* fall back to do predefined tail call */
>>>>  	if (args == NULL)
>>>> @@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>>>  	/* copy the sys_enter header, which has the syscall_nr */
>>>>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>>>  
>>>> -	/*
>>>> -	 * Determine what type of argument and how many bytes to read from user space, using the
>>>> -	 * value in the beauty_map. This is the relation of parameter type and its corresponding
>>>> -	 * value in the beauty map, and how many bytes we read eventually:
>>>> -	 *
>>>> -	 * string: 1			      -> size of string
>>>> -	 * struct: size of struct	      -> size of struct
>>>> -	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>>> -	 */
>>>> -	for (int i = 0; i < 6; i++) {
>>>> -		arg = (void *)args->args[i];
>>>> -		augmented = false;
>>>> -		size = beauty_map[i];
>>>> -		aug_size = size; /* size of the augmented data read from user space */
>>>> -
>>>> -		if (size == 0 || arg == NULL)
>>>> -			continue;
>>>> -
>>>> -		if (size == 1) { /* string */
>>>> -			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>>>> -			/* minimum of 0 to pass the verifier */
>>>> -			if (aug_size < 0)
>>>> -				aug_size = 0;
>>>> -
>>>> -			augmented = true;
>>>> -		} else if (size > 0 && size <= value_size) { /* struct */
>>>> -			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>>>> -				augmented = true;
>>>> -		} else if ((int)size < 0 && size >= -6) { /* buffer */
>>>> -			index = -(size + 1);
>>>> -			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>>> -			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>>>> -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>>>> -
>>>> -			if (aug_size > 0) {
>>>> -				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>>>> -					augmented = true;
>>>> -			}
>>>> -		}
>>>> -
>>>> -		/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>>>> -		if (aug_size > value_size)
>>>> -			aug_size = value_size;
>>>> -
>>>> -		/* write data to payload */
>>>> -		if (augmented) {
>>>> -			int written = offsetof(struct augmented_arg, value) + aug_size;
>>>> -
>>>> -			if (written < 0 || written > sizeof(struct augmented_arg))
>>>> -				return 1;
>>>> -
>>>> -			((struct augmented_arg *)payload_offset)->size = aug_size;
>>>> -			output += written;
>>>> -			payload_offset += written;
>>>> -			do_output = true;
>>>> -		}
>>>> -	}
>>>> +	struct args_loop_ctx loop_ctx = {
>>>> +		.args = args,
>>>> +		.beauty_map = beauty_map,
>>>> +		.payload_offset = payload_offset,
>>>> +		.value_size = value_size,
>>>> +		.output = &output,
>>>> +		.do_output = &do_output
>>>> +	};
>>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>>
>>> bpf_loop() is old and generally not recommended.
>>> Please use bpf_for() then the diff will be one line change and
>>> can scale to any number of args. Not just 6.
> 
> Thanks Alexei, I didn't know about this preference.
> 
>> One thing we should take care is to support old kernels.  The oldest
>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
> 
> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
> trace: Collect augmented data using BPF") so we should be good using
> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
> 
> I'll refactor with bpf_for and will send v2. 

Or I won't. It turns out that just swapping the for loop for bpf_for
leads to -E2BIG from the verifier again. Looking at the verifier log, it
fails to find equivalence between states at the loop head:

    [...]
    78: (85) call bpf_iter_num_next#84922 [...]
fp-56=map_value(map=beauty_payload_,ks=4,vs=24688,imm=112)
    [...]
    78: (85) call bpf_iter_num_next#84922 [...]
fp-56=map_value(map=beauty_payload_,ks=4,vs=24688,imm=120)
    [...]

IMHO, the reason is that payload_offset, which points to the
beauty_payload_enter_map entry, gets updated in every iteration.

This could be probably fixed on the perf side by reworking how augmented
args are stored but at this point, bpf_loop sounds like an easier and
more reliable approach.

Let me know if anyone has objections, otherwise I'll send v2 of the
bpf_loop approach, with suggestions from Sashiko incorporated.

Thanks,
Viktor

> It should be then
> backported to stable kernels down to 6.12 LTS.
> 
> Viktor
> 
>>
>> Maybe we can factor out the loop body and call it from different
>> mechanisms like open-coded loop, bpf_loop or bpf_for depending on the
>> kernel version.  But not sure it'd fix the verifier issue though.
>>
>> Thanks,
>> Namhyung
>>

