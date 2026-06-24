Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA938A701
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283670; cv=none; b=MnQW+kPCVvso/1jkgvO8R8398oxXnEr24rKcFUSAO0oQqzDDRAugAFMorVoN68wptOm9V1hskKiUEEHIHVfm998ll/dpa7wFsJWZ1umnoqd3JNWB5Zd/oLFLc3t9LGg1juMAg11zhLcFxHDMTzhfDw9brFdilpW7h8fgu3MZ178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283670; c=relaxed/simple;
	bh=9KOIoHENInRIyFr1V0E2ePyNkctr48xJ/8SrVJv7he8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INDNdWF1mfoU/CkWcgWtDdAYCCbjv9oy7ArXx6rMUGIDu9nDbbghfVrEewfIJIGKF3Qz7bgvcHemr7c/SOEHe3HmzOTRLvsy5cRIRwKqmuYAyvYkyT1YZU+WjJXiT1OHzP8ZKc8TXgp+ECSXCCATGIuJ/9oqHSrgUmDaGS8EHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwjH70CQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jp3RmmY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwjH70CQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jp3RmmY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782283667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0igFXozW1XpGYfz7uHbcb09PTKxi8TUnE588/OdtT/U=;
	b=gwjH70CQHh1leGNVZ3+6WaiPSFYkxihZRxLF/JHs5RJqjsbY34D4tPlnxrlk/gyEPTlxke
	Pb7b7RGgBrmzNObkE59TchwwY7qHY9fRH7lMF7ws5hKJdZw+SmN+JPf2A+DOSt7hWfpd0K
	d6gjqgkbR1Ku6veCgo5CpIIA2WPZ+ag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-69kH1oX5NSSvgguZiZI8sQ-1; Wed, 24 Jun 2026 02:47:43 -0400
X-MC-Unique: 69kH1oX5NSSvgguZiZI8sQ-1
X-Mimecast-MFC-AGG-ID: 69kH1oX5NSSvgguZiZI8sQ_1782283662
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so471576f8f.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 23:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782283662; x=1782888462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0igFXozW1XpGYfz7uHbcb09PTKxi8TUnE588/OdtT/U=;
        b=Jp3RmmY5aPGA/bSGns3n7h0yBBcn580t+b2P/Tw14WY9G1WdJAyOcZasK3h/bQcuys
         d/j2uiOyDIVU3gqBCuxMeEIcaSF40fjCkri1Ufoa0CEBYzUfYMNLq2+U4jhtsMfwx94c
         /o+EpuiOvpZWviUzHO5kZRaM1501Gl7kG8Nk3KtisELBZPEYkrHhIwtDD73yj+0n8GLF
         MhPyZnklcTtdJGBx4dQFP50PJ4z1bDeEmxfFFcDjcIA6rMItYU3wq+YjA76YZVVvlgB8
         9UVtYdq1mPbdYWsILOs/8Hq7ux9YjF6Nw/iZLy1o3QkQ71l45RXBswrRF3VVfFO8xQLg
         wvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782283662; x=1782888462;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0igFXozW1XpGYfz7uHbcb09PTKxi8TUnE588/OdtT/U=;
        b=phJ+k4bumwbk17yg9N/OOgcLz9QZ0dXS+0R9Vcb2bELmkO5g+I1ghsrWcmckiDLiMe
         URoFdljOycZS7s501XIPqqQC6Dlqh1S4Q+HvEC2nT30WMtK+ruTFFnfeNVVklgscPUQt
         f7+6nokWbidYPoX8X6fnmW0f/rO7CMQLRZsOvHdm9JgtnhR1nTHtnIqkDddsoUTTh/8m
         7X3hVkUVX/T79kXYimipk1fwKukZQJH7QE2ciBXHHhrRdaw2V8oPt2CgCx1IZxmtlBVJ
         8D5uvdxTrUKzd39YlRyAUwW2rFrrMQ3gKlNuAfdX+Y9RnCL1j4gMkMLDaqrlBZYFXRH5
         7PDw==
X-Forwarded-Encrypted: i=1; AHgh+RqUMEfTFAvWxJ08BaB62VrSLqA14Q2tPgsMSTQdEg/P5oj7voySAYNxYAUFuxK7knk3xZRQv84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86ryH38W4aMbACFUN2m4Kxj3KtkFZWFjiXLnsIURsAzHZHae8
	jlWTU4u70nAQLpTfaTKunUhWsoAznVUtqQvFcEh0gTuUjPXIHRkBphp6NK/o3gih92O/AkYjAGU
	cB0J6D9bT0DNpIHZqYjJIUnWOujEFU//pwhMFlnXnDnwKGrQTag0ovbha
X-Gm-Gg: AfdE7clHwsFtEp7nQVTQUvFk6tbspp6pbw7jviNHThlDpZLztQhyly26pRr6qSt8VtK
	XeFz0p8razDfv0Rr4F5k8PadLGk9aSRQEA1FtXSUnqjo37/9AFZHwXbbuSq49Xl8p/nahlUjWlQ
	3rYpCssbxtq5YgpGZF8yjDfT961z/8xgd7YDfAHT/SFwBVGqh5lQWJHGZ4duTaZBzaGfEGzqTSN
	H8/hBZT4yQjkRGeQDEHaVVIIPhY1QX92bKsL2T1vQUVQ6fr77JsI9CJRkRmQi/pilHUP71OmM/E
	i117+lq83Fm9hOisroEK6ar8I4z1yeg7KqwhP3FD3lO39nKOLb/6gOFRNRpmaCFCCebTZAvm7lQ
	XoQrBiSrEvZYaEazfpVDyQmHxmjjT9QmtSdID1hlpV5/mmw==
X-Received: by 2002:a05:6000:2683:b0:465:4305:6460 with SMTP id ffacd0b85a97d-46a7f66caefmr10121774f8f.9.1782283661679;
        Tue, 23 Jun 2026 23:47:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2683:b0:465:4305:6460 with SMTP id ffacd0b85a97d-46a7f66caefmr10121727f8f.9.1782283661201;
        Tue, 23 Jun 2026 23:47:41 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c6csm4270068f8f.14.2026.06.23.23.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 23:47:40 -0700 (PDT)
Message-ID: <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
Date: Wed, 24 Jun 2026 08:47:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <ajq98dm4gAwEzkMb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 19:10, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
>>> The loop for processing syscall args in augment_raw_syscalls has a
>>> history of breaking with Clang updates, see e.g. commit 013eb043f37b
>>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
>>>
>>> Now, a similar thing happened between Clang 21 and 22. While the issue
>>> is mitigated on the main line by a recent verifier update, it remains
>>> broken on the 6.12 and 6.18 stable branches:
>>>
>>>     [linux-6.18.y]# sudo perf trace true
>>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>>     [...]
>>>     BPF program is too large. Processed 1000001 insn
>>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
>>>     -- END PROG LOAD LOG --
>>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
>>>     Error: failed to get syscall or beauty map fd
>>>     [...]
>>>
>>> The reason is that the loop is quite complex and the BPF verifier often
>>> struggles to prove that it terminates.
>>>
>>> Fix the issue by refactoring the loop body into a callback function and
>>> calling the bpf_loop helper. This should prevent future breakages of
>>> this kind since the callback function has no loops. It also allows to
>>> drop a few artificial checks to help the verifier, including the changes
>>> introduced by 013eb043f37b.
> 
> Thanks for working on this.  I encountered this issue before and never
> found time to take a deeper look yet.
> 
>>>
>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
>>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
>>> Cc: stable@vger.kernel.org
>>> ---
>>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++-------
>>>  1 file changed, 96 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>> index 2a6e61864ee0..6d553ed3ac23 100644
>>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>> @@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>>>  }
>>>  
>>> +struct args_loop_ctx {
>>> +	struct syscall_enter_args *args;
>>> +	unsigned int *beauty_map;
>>> +	void *payload_offset;
>>> +	int value_size;
>>> +	u64 *output;
>>> +	bool *do_output;
>>> +};
>>> +
>>> +static long process_arg_cb(u64 i, void *ctx)
>>> +{
>>> +	/*
>>> +	 * Determine what type of argument and how many bytes to read from user space, using the
>>> +	 * value in the beauty_map. This is the relation of parameter type and its corresponding
>>> +	 * value in the beauty map, and how many bytes we read eventually:
>>> +	 *
>>> +	 * string: 1			      -> size of string
>>> +	 * struct: size of struct	      -> size of struct
>>> +	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>> +	 */
>>> +	struct augmented_arg *augmented_arg;
>>> +	struct args_loop_ctx *loop_ctx;
>>> +	int aug_size, size, index;
>>> +	bool augmented;
>>> +	void *arg;
>>> +
>>> +	/* Bounds check for the below map access to help the verifier */
>>> +	if (i < 0 || i >= 6)
>>> +		return 1;
>>> +
>>> +	loop_ctx = (struct args_loop_ctx *)ctx;
>>> +	arg = (void *)loop_ctx->args->args[i];
>>> +	augmented = false;
>>> +	size = loop_ctx->beauty_map[i];
>>> +	aug_size = size; /* size of the augmented data read from user space */
>>> +	augmented_arg = (struct augmented_arg *)loop_ctx->payload_offset;
>>> +
>>> +	if (size == 0 || arg == NULL)
>>> +		return 0; /* continue */
>>> +
>>> +	if (size == 1) { /* string */
>>> +		aug_size = bpf_probe_read_user_str(augmented_arg->value, loop_ctx->value_size, arg);
>>> +		augmented = true;
>>> +	} else if (size > 0 && size <= loop_ctx->value_size) { /* struct */
>>> +		if (!bpf_probe_read_user(augmented_arg->value, size, arg))
>>> +			augmented = true;
>>> +	} else if (size < 0 && size >= -6) { /* buffer */
>>> +		index = -(size + 1);
>>> +		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>> +		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>>> +		aug_size = loop_ctx->args->args[index];
>>> +
>>> +		if (aug_size > TRACE_AUG_MAX_BUF)
>>> +			aug_size = TRACE_AUG_MAX_BUF;
>>> +
>>> +		if (aug_size > 0) {
>>> +			if (!bpf_probe_read_user(augmented_arg->value, aug_size, arg))
>>> +				augmented = true;
>>> +		}
>>> +	}
>>> +
>>> +	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>>> +	if (aug_size > loop_ctx->value_size)
>>> +		aug_size = loop_ctx->value_size;
>>> +
>>> +	/* write data to payload */
>>> +	if (augmented) {
>>> +		int written = offsetof(struct augmented_arg, value) + aug_size;
>>> +
>>> +		if (written < 0 || written > sizeof(struct augmented_arg))
>>> +			return 1; /* break */
>>> +
>>> +		augmented_arg->size = aug_size;
>>> +		*loop_ctx->output += written;
>>> +		loop_ctx->payload_offset += written;
>>> +		*loop_ctx->do_output = true;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>>  {
>>> -	bool augmented, do_output = false;
>>> -	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>> +	bool do_output = false;
>>> +	int zero = 0, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>>> -	s64 aug_size, size;
>>>  	unsigned int nr, *beauty_map;
>>>  	struct beauty_payload_enter *payload;
>>> -	void *arg, *payload_offset;
>>> +	void *payload_offset;
>>> +	long iters;
>>>  
>>>  	/* fall back to do predefined tail call */
>>>  	if (args == NULL)
>>> @@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>>  	/* copy the sys_enter header, which has the syscall_nr */
>>>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>>  
>>> -	/*
>>> -	 * Determine what type of argument and how many bytes to read from user space, using the
>>> -	 * value in the beauty_map. This is the relation of parameter type and its corresponding
>>> -	 * value in the beauty map, and how many bytes we read eventually:
>>> -	 *
>>> -	 * string: 1			      -> size of string
>>> -	 * struct: size of struct	      -> size of struct
>>> -	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>> -	 */
>>> -	for (int i = 0; i < 6; i++) {
>>> -		arg = (void *)args->args[i];
>>> -		augmented = false;
>>> -		size = beauty_map[i];
>>> -		aug_size = size; /* size of the augmented data read from user space */
>>> -
>>> -		if (size == 0 || arg == NULL)
>>> -			continue;
>>> -
>>> -		if (size == 1) { /* string */
>>> -			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>>> -			/* minimum of 0 to pass the verifier */
>>> -			if (aug_size < 0)
>>> -				aug_size = 0;
>>> -
>>> -			augmented = true;
>>> -		} else if (size > 0 && size <= value_size) { /* struct */
>>> -			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>>> -				augmented = true;
>>> -		} else if ((int)size < 0 && size >= -6) { /* buffer */
>>> -			index = -(size + 1);
>>> -			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>> -			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>>> -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>>> -
>>> -			if (aug_size > 0) {
>>> -				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>>> -					augmented = true;
>>> -			}
>>> -		}
>>> -
>>> -		/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>>> -		if (aug_size > value_size)
>>> -			aug_size = value_size;
>>> -
>>> -		/* write data to payload */
>>> -		if (augmented) {
>>> -			int written = offsetof(struct augmented_arg, value) + aug_size;
>>> -
>>> -			if (written < 0 || written > sizeof(struct augmented_arg))
>>> -				return 1;
>>> -
>>> -			((struct augmented_arg *)payload_offset)->size = aug_size;
>>> -			output += written;
>>> -			payload_offset += written;
>>> -			do_output = true;
>>> -		}
>>> -	}
>>> +	struct args_loop_ctx loop_ctx = {
>>> +		.args = args,
>>> +		.beauty_map = beauty_map,
>>> +		.payload_offset = payload_offset,
>>> +		.value_size = value_size,
>>> +		.output = &output,
>>> +		.do_output = &do_output
>>> +	};
>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>
>> bpf_loop() is old and generally not recommended.
>> Please use bpf_for() then the diff will be one line change and
>> can scale to any number of args. Not just 6.

Thanks Alexei, I didn't know about this preference.

> One thing we should take care is to support old kernels.  The oldest
> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
> 5.17 and bpf_for (bpf_iter_num) was 6.4.

The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
trace: Collect augmented data using BPF") so we should be good using
bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?

I'll refactor with bpf_for and will send v2. It should be then
backported to stable kernels down to 6.12 LTS.

Viktor

> 
> Maybe we can factor out the loop body and call it from different
> mechanisms like open-coded loop, bpf_loop or bpf_for depending on the
> kernel version.  But not sure it'd fix the verifier issue though.
> 
> Thanks,
> Namhyung
> 

