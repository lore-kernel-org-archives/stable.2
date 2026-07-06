Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669C4C81
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334804; cv=none; b=euXdZZKMZMcBLj4VwmJhXTpFwj9IJe+TYtMU4PK1PONgMI5ZFdf58fgoT2GBLTnq9uL/Dq+59EpaO+Ogm3ese0qfjw8io7zQmjWmetBDLwuHTexvtXSm6jDoS/VwGLLlrTDBdPZQGZzkpWWVtJLCQVqofazCL8rwol7IA5IKdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334804; c=relaxed/simple;
	bh=yuzFjppwp9KNN3wCQo7F2CNPrgflTNWPoxGurw2XavY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P34dQXkm4M3D/6oxEHqss6I2KgUJhpFm1ODLLw3VKJSCiWUi1Fpe1cRx9/thnPSQh+St/OMx6zu7unV5Kc1r2PNVkUz4E+IaN//nP9SU+kvfsDuuXngg6fcA1yi6JMddwhnGairUy5NlpYeuPyXzaz2BmkkRzKXTwZVBFZbqFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBLhIONg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DY0NMZzc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBLhIONg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DY0NMZzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783334802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sFi86kewc62Xc/M6TiWgR/UEUFUb7kK5SqGbMztc0I=;
	b=SBLhIONgKugfEULj+onbIMAFuk8gfmSPSVuHBfV+jgHFTiUOdMvQxplggCQUG6v4AP0W1I
	HyoV8q1TItm9G1m83kXl+yOuUeKaTW4ai6l9HJWDqZpMKk4TBVaEqUcpI1LdgOZ5F+1u5l
	MXW7Id6+LWn6xeLSnQg/8MB22N4s+S8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Gn-C5yA7O7u1IEBs3iow6w-1; Mon, 06 Jul 2026 06:46:41 -0400
X-MC-Unique: Gn-C5yA7O7u1IEBs3iow6w-1
X-Mimecast-MFC-AGG-ID: Gn-C5yA7O7u1IEBs3iow6w_1783334800
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so24297535e9.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783334800; x=1783939600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sFi86kewc62Xc/M6TiWgR/UEUFUb7kK5SqGbMztc0I=;
        b=DY0NMZzcX2myvq5B8vo7HM59hIJf8T+3WC03PNB//3HZBiK5CBsZZwDbTuBM8v5JO7
         PTPsApdR64TnNQawYYnVK1hc0ua82lwi8qpxnoaF4U/XxKXSoHz++Pxwixe/sG6FWsJb
         JsNPmwEkRGhQzLQ8F8+nb8amnwAtfF9VRE8tHu4g4gfWK9GOI3twMvKMc2CgC1YdMoC7
         0pUPdPOGP9FGCUcXTIqdAa69o6iPvAU7u8kmryPY7wNtuYHDjEtxZcZzhkGpEFoiEU9m
         i1nkvs2XHwbnubCg+WAPuoI4o7sxCMK3Abat1GRF7LE5HjejOaMbD0ICaw1F53PmER/5
         Fqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334800; x=1783939600;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sFi86kewc62Xc/M6TiWgR/UEUFUb7kK5SqGbMztc0I=;
        b=N0kgV5IyHr9oAXkopCHXqr7IrYakxjRScMGTPxVjpGSDLuKS7zC9KfiTMtKNd3yzAI
         JgTXi3j3EFON6/T7XPLBmyiVQN/Yy2wBx6YtiZ2DGaaxUngFwnd3GWP1kI3wn2YQaAis
         H5G9SxcJns4Re7PfES3NjxOARIqsRdxE3rhP0B6Tyy7m1R3xwfggTDOqG1QIy07Wh1IZ
         NK/IIxQFN9n0n1AIAL4KI/KKkmcwf/p0kW/A3lfAJFqFqmroMfmiM1++ttPYvbRnMmYt
         MyOHPxLv9hvQmOZ6bW1FroX/sSwozX5gNfpQ89gjMge1+fzJhdiO6wlqns+25YB52L+M
         NhlA==
X-Forwarded-Encrypted: i=1; AHgh+RouAFbVJNu0kl/c+4+h7DoI/pLnvwH83OFb68M1sgD2LAb9G8peok4BiMfpgiEqPFG9pbK5GWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHL2umoFysAsvTkU3cvy15XQuQ7Z1IAle0LdeoB7W6Doq1+5YE
	R2lh/uANSVt9XkfQ9zy90BBrtdYK7rYEa9lp2Eg2vGmVj8sW/hhkmvEUhpwzDSkm3kYB2aU0cDH
	NCVzK5oLDt4bEnLM21lnfmaDrQy4l4mh9TfN9BD72I7YMCcT+G3kU0T9v
X-Gm-Gg: AfdE7ck6vVee8LaWDbRCptaj7rcThv//18YjcHtVqWvldm15IlFKP9VSHTdG1PKvwcJ
	6NlwSuucIRehWYG96TRhf0BNNr7TVjQ1ZlHf+Q+HDcaSDgbS3oc4+z9Oo9e9uxpq8GRWqNIRsUF
	4XHefTtQrGhGr80UXWE0HUdggi2oRhKfUYMi/vkDn7Uccwczhze6uhQ/zYECK0ofwbq0JKrMTna
	hqx3IJ/W2BD7+M0tK5iVuyeX+yVTNJrY69NByWynjGoaFrTwbqrD2iIrOYeRLv/MdNG8KTbff8h
	QOL/FTTFz27uFcKtN4DaHzmx49uIXeMYvbblS9ppFgy8rHx2WQOiHI9fc3mucA33QMq/uSdp+QG
	nZFoH6d6nuPu9o2GEt7i2O6AWtsOQXM7kmr8b76S/vYX9HA==
X-Received: by 2002:a05:6000:1885:b0:462:fdf2:3a50 with SMTP id ffacd0b85a97d-47aae2c5e48mr12673053f8f.32.1783334799397;
        Mon, 06 Jul 2026 03:46:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1885:b0:462:fdf2:3a50 with SMTP id ffacd0b85a97d-47aae2c5e48mr12672991f8f.32.1783334798903;
        Mon, 06 Jul 2026 03:46:38 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm24722915f8f.37.2026.07.06.03.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:46:37 -0700 (PDT)
Message-ID: <9aedb40b-6c09-43bb-becd-57fbdb4d73b0@redhat.com>
Date: Mon, 6 Jul 2026 12:46:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf trace: Refactor augmented_raw_syscalls using
 bpf_for
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 stable@vger.kernel.org
References: <cover.1783070132.git.vmalik@redhat.com>
 <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>
 <akhKyjlsSg82XN2Z@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <akhKyjlsSg82XN2Z@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/26 01:50, Namhyung Kim wrote:
> On Fri, Jul 03, 2026 at 12:32:15PM +0200, Viktor Malik wrote:
>> The loop for processing syscall args in augment_raw_syscalls has a
>> history of breaking with Clang updates, see e.g. commit 013eb043f37b
>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
>>
>> Now, a similar thing happened between Clang 21 and 22. While the issue
>> is mitigated on the main line by a recent verifier update, it remains
>> broken on the 6.12 and 6.18 stable branches:
>>
>>     [linux-6.18.y]# sudo perf trace true
>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>     [...]
>>     BPF program is too large. Processed 1000001 insn
>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
>>     -- END PROG LOAD LOG --
>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
>>     Error: failed to get syscall or beauty map fd
>>     [...]
>>
>> The reason is that the loop is quite complex and the BPF verifier often
>> struggles to prove that it terminates.
>>
>> Fix the issue by replacing the standard for loop by the bpf_for macro,
>> which uses numeric BPF iterator. This should prevent future breakages of
>> this kind since the verifier has much easier job proving that the loop
>> terminates.
>>
>> Small adjustments were necessary for the loop to make it work.  The main
>> problem is that the verifier has sometimes problems with bpf_for loops
>> that use a carry-over state, such as the `payload_offset` and `output`
>> vars here, since the verifier tries to track their values too precisely
>> and cannot prove loop convergence. To resolve the issue, we (1)
>> explicitly recompute `payload_offset` in every iteration and (2) use a
>> trick with adding a global zero to `output` to help verifier forget its
>> precise state and use a range instead.
>>
>> In exchange, this also allows to drop a few artificial checks to help
>> the verifier, including the changes introduced by 013eb043f37b.
>>
>> Finally, to keep backwards compatibility with older kernel versions
>> which do not have bpf_for (i.e. numeric iterators), fall back to
>> standard for loop in such a case.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
>> Cc: stable@vger.kernel.org
>> ---
>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 54 +++++++++++++------
>>  1 file changed, 39 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index cbdd5ce19a2f..60babc06f381 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> @@ -429,6 +429,8 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>>  }
>>  
>> +u64 ZERO = 0;
>> +
>>  /*
>>   * Determine what type of argument and how many bytes to read from user space, using the
>>   * value in the beauty_map. This is the relation of parameter type and its corresponding
>> @@ -439,12 +441,13 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>   * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>   */
>>  static inline int augment_arg(struct syscall_enter_args *args, int i,
>> -			      unsigned int *beauty_map, void *payload_offset)
>> +			      unsigned int *beauty_map,
>> +			      struct beauty_payload_enter *payload, u64 offset)
>>  {
>>  	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>  	s64 aug_size, size;
>>  	bool augmented;
>> -	void *arg;
>> +	void *arg, *payload_offset;
>>  
>>  	arg = (void *)args->args[i];
>>  	augmented = false;
>> @@ -454,6 +457,12 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  	if (size == 0 || arg == NULL)
>>  		return 0;
>>  
>> +	/* bounds check for the verifier */
>> +	if (offset > sizeof(payload->aug_args) - sizeof(payload->aug_args[0]))
>> +		return -1;
>> +	barrier_var(offset);
>> +	payload_offset = (void *)&payload->aug_args + offset;
>> +
>>  	if (size == 1) { /* string */
>>  		aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>>  		/* minimum of 0 to pass the verifier */
>> @@ -464,11 +473,13 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  	} else if (size > 0 && size <= value_size) { /* struct */
>>  		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>>  			augmented = true;
>> -	} else if ((int)size < 0 && size >= -6) { /* buffer */
>> +	} else if (size < 0 && size >= -6) { /* buffer */
>>  		index = -(size + 1);
>>  		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>  		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>> -		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>> +		aug_size = args->args[index];
>> +		if (aug_size > TRACE_AUG_MAX_BUF)
>> +			aug_size = TRACE_AUG_MAX_BUF;
>>  
>>  		if (aug_size > 0) {
>>  			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>> @@ -497,11 +508,10 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  {
>>  	bool do_output = false;
>> -	int zero = 0, written;
>> +	int i, zero = 0, written;
>>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>>  	unsigned int nr, *beauty_map;
>>  	struct beauty_payload_enter *payload;
>> -	void *payload_offset;
>>  
>>  	/* fall back to do predefined tail call */
>>  	if (args == NULL)
>> @@ -513,7 +523,6 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  
>>  	/* set up payload for output */
>>  	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
>> -	payload_offset = (void *)&payload->aug_args;
>>  
>>  	if (beauty_map == NULL || payload == NULL)
>>  		return 1;
>> @@ -521,14 +530,29 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  	/* copy the sys_enter header, which has the syscall_nr */
>>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>  
>> -	for (int i = 0; i < 6; i++) {
>> -		written = augment_arg(args, i, beauty_map, payload_offset);
>> -		if (written < 0)
>> -			return 1;
>> -		if (written > 0) {
>> -			output += written;
>> -			payload_offset += written;
>> -			do_output = true;
>> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
>> +		bpf_for(i, 0, 6) {
>> +			written = augment_arg(args, i, beauty_map, payload, output);
>> +			if (written < 0)
>> +				return 1;
>> +			if (written > 0) {
>> +				output += written;
>> +				/* guide the verifier to forget range of `output`, which
>> +				 * helps to prove convergence of the loop
>> +				 */
>> +				output += ZERO;
>> +				do_output = true;
>> +			}
>> +		}
>> +	} else {
>> +		for (i = 0; i < 6; i++) {
>> +			written = augment_arg(args, i, beauty_map, payload, output);
>> +			if (written < 0)
>> +				return 1;
>> +			if (written > 0) {
>> +				output += written;
> 
> Woundn't it also need '+= ZERO' here?

IMHO no, the verification of standard loops doesn't suffer from the same
problem as the verification of bpf_for.

Viktor

> 
> Thanks,
> Namhyung
> 
> 
>> +				do_output = true;
>> +			}
>>  		}
>>  	}
>>  
>> -- 
>> 2.54.0
>>
> 

