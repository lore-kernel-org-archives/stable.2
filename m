Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8B3B5821
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334574; cv=none; b=KONSji68vX163THGAZ3z7mDFweRz0BCYkp0fYUUYkSZxmKSR+R/WY4yZ5aNh56KUC3NLPrJ0L5NC86UlOUlkTgI5YYsspgwBgqW0SwLEoo2uuQ1lJl0US40JbysH4PsZ+4X9t+DIjaqhVRf4epO2JFHSgp6hNYVRXbMm044ornE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334574; c=relaxed/simple;
	bh=7jGrrKhau039KGF+D/EhnXv4Eeo8yneBAlwyXwKMYVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bsxxi0U8V/VYg9sI5SylrLtpzEPtmSlzfrHAaxopVEuEy2Oh1J2XibuZ8n4t2/0ZAgVNHBSrcRK+WOdN/3D8X6DMEgopz9DMWezApg23aEDxZD8DlOtEgfJeVOwUP6Mn0l74tNldLCjSZfEiQwrkEwVG3qfCqb6KYL8ZBl4vhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECXPq9MH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0PRgz0r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECXPq9MH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0PRgz0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783334572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCoz5Iovrxw6v/kl19PuthITHE4VsqmzpdZPCtUSOQE=;
	b=ECXPq9MH/gKe8o5Os+a39YHuilWUIkLLu7Vs59eLr/gjlgk5jJmKmx0mRP+HrJtjtgOtO+
	qpd4oN+yj2dONMSCmWjqS8oCnxvsw9cH2H7MvYx6rMiZrwbGpDpbq08ORte1teYs/J82VO
	KOSdAaBn7vJCQDop+h22bx97nJ6/IuY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-pjxEdGbsO0KHQODTl_YmpA-1; Mon, 06 Jul 2026 06:42:51 -0400
X-MC-Unique: pjxEdGbsO0KHQODTl_YmpA-1
X-Mimecast-MFC-AGG-ID: pjxEdGbsO0KHQODTl_YmpA_1783334570
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493d88406cdso8054885e9.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783334570; x=1783939370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCoz5Iovrxw6v/kl19PuthITHE4VsqmzpdZPCtUSOQE=;
        b=X0PRgz0rzaf1cTvKRN936QkwkXAnJjhS5VqSixX0kCdQ4TzC5TV7gXFcWOUDXn2ToC
         YOUM25h3s7wW1pQoLOQfmuhdFTOYG4jguf9tJ5ElmEukxW/6IIKn5QnFgX9SqtrG8/Bg
         +dWZaWGi5CZVEOdT6qHvJWiJ8YNXM72ZvEqbCcZmhaHLHzycX/j6kWCi7CA5ue+VFX1j
         mUsOy7kNNroHAlUYDhtj43TAtRsbj3Ke9kh4VcStTiOCCJ0ETisSDj+sBmcwjxEkHWsS
         wUkUZehhgN0isfEdbhU7oRFCqGqpHtJQYkjZDn0XZhijTccE7P9GbAnFxuQOhvkd+sN2
         38RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334570; x=1783939370;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCoz5Iovrxw6v/kl19PuthITHE4VsqmzpdZPCtUSOQE=;
        b=fie6tF7zmYPfcfA/uwJKPTQyOTf8d2oAkD63n99OpXvzBWgdw9MMEbax+rd1uM2q1j
         TlYVpe8T4D6UxpXIRZFWdjR4cE4tNt83TtU0GjjoTvgT8hYYGrbYagQqvv5tABdnna9m
         GpCj+fvGrJXxobYERg6nrR/8AKK/ra6rpeLELIWyobaip9lM1Sg9V7rd4Yr0LVWKkOm2
         O0LfR4dxib7JCM2/05bx7UnYfSrleQ5W2i23rWp+M/P1Tu8E6GqUQ/FNJ0WdLt6LrjcF
         aI/pHgfs1Nu+QVzVYlKSfZPDkf8jMd0esVWpVBb8xI+aFjiYFsnS1WBGFCK9WUJlSj3B
         Bh5A==
X-Forwarded-Encrypted: i=1; AHgh+RoNy/DQ9CRZFRZr8xJ9KeR21uc53E/yuSmxWn8ohqdqRPVWnLbIsMS8ytmE+xpHWGe2K+4itn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9Kc9PWJwWAKFuQxqtxM1zXbuxMDEGG4yQdBpdhDaIf5lRJtA
	Vor1lfSspz24f52wCqnh66rBisoyAThSStPD9UCDMuEhAu0303MME8Ae6ezHXuxidq5hv0DluPa
	rIgTJCHl+f+NFWlSXf1+6hU0pO7T0QdxvMtvecCYfuNePfvsQSqASaEkO
X-Gm-Gg: AfdE7cmOGVNAAB7tCYQjuOUdxU+S87d6Wxahnin97Qhf86YPOF1xCNMLWHQXPzd1aH+
	tQzvYWrX+scuthRXkoeOXDnfjxD9087FJQse4LlSrekNaD+YcaOzQA7r0sI5vCNHbnR49GYNceD
	x5KsKHE+IUQj3x9DqZ9AZbyJUSKmXcuc/5Niukj0ONYDadgmQ7cn4nLQxgdlW3k1O1mZXKKewbp
	1pYwyTc3teG3k3FVkqFpg3lhJhap8gCxokWuVv4M9yN8H+zGE3xbFxpyT2SWYCarERpH8qXpEEh
	mroWDu6gx9csqaEze0XdKtjMNS7qjvnau4vntXG4bvoEk1vkk6mBFFWZUyFRHD0BZlgsqLfdtGg
	KUVlANwqxUYtXczL8rQkW8njcPyvwGYmMkhqQxejJ/3Zpbw==
X-Received: by 2002:a05:6000:29d4:b0:474:3b3b:5e5f with SMTP id ffacd0b85a97d-47aac4ecba2mr7434432f8f.16.1783334569791;
        Mon, 06 Jul 2026 03:42:49 -0700 (PDT)
X-Received: by 2002:a05:6000:29d4:b0:474:3b3b:5e5f with SMTP id ffacd0b85a97d-47aac4ecba2mr7434389f8f.16.1783334569341;
        Mon, 06 Jul 2026 03:42:49 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm25043705f8f.26.2026.07.06.03.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:42:48 -0700 (PDT)
Message-ID: <e7166e48-ecc1-4dca-af30-07db75199a4c@redhat.com>
Date: Mon, 6 Jul 2026 12:42:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf trace: Factor out BPF loop body
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
References: <cover.1783070132.git.vmalik@redhat.com>
 <20fc67aa2550ca5aff52b3a9a207f2e07f8e0b1d.1783070132.git.vmalik@redhat.com>
 <akhKbOtiracJKkBU@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <akhKbOtiracJKkBU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/26 01:49, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jul 03, 2026 at 12:32:14PM +0200, Viktor Malik wrote:
>> The BPF program in augmented_raw_syscalls uses a for loop to iterate all
>> syscall arguments. The loop body is quite complex and often poses
>> problems for the BPF verifier. As a preparation step for addressing this
>> issue, factor out the loop body into a separate function.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 127 ++++++++++--------
>>  1 file changed, 72 insertions(+), 55 deletions(-)
>>
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index 2a6e61864ee0..cbdd5ce19a2f 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> @@ -429,15 +429,79 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>>  }
>>  
>> +/*
>> + * Determine what type of argument and how many bytes to read from user space, using the
>> + * value in the beauty_map. This is the relation of parameter type and its corresponding
>> + * value in the beauty map, and how many bytes we read eventually:
>> + *
>> + * string: 1			      -> size of string
>> + * struct: size of struct	      -> size of struct
>> + * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>> + */
>> +static inline int augment_arg(struct syscall_enter_args *args, int i,
>> +			      unsigned int *beauty_map, void *payload_offset)
> 
> Can we make it 'struct augmented_arg *payload_offset' instead?

Sure, good idea, that will allow to drop a few casts from the function
body.

Viktor

> 
> Thanks,
> Namhyung
> 
> 
>> +{
>> +	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> +	s64 aug_size, size;
>> +	bool augmented;
>> +	void *arg;
>> +
>> +	arg = (void *)args->args[i];
>> +	augmented = false;
>> +	size = beauty_map[i];
>> +	aug_size = size; /* size of the augmented data read from user space */
>> +
>> +	if (size == 0 || arg == NULL)
>> +		return 0;
>> +
>> +	if (size == 1) { /* string */
>> +		aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>> +		/* minimum of 0 to pass the verifier */
>> +		if (aug_size < 0)
>> +			aug_size = 0;
>> +
>> +		augmented = true;
>> +	} else if (size > 0 && size <= value_size) { /* struct */
>> +		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>> +			augmented = true;
>> +	} else if ((int)size < 0 && size >= -6) { /* buffer */
>> +		index = -(size + 1);
>> +		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>> +		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>> +		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>> +
>> +		if (aug_size > 0) {
>> +			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>> +				augmented = true;
>> +		}
>> +	}
>> +
>> +	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>> +	if (aug_size > value_size)
>> +		aug_size = value_size;
>> +
>> +	/* write data to payload */
>> +	if (augmented) {
>> +		int written = offsetof(struct augmented_arg, value) + aug_size;
>> +
>> +		if (written < 0 || written > sizeof(struct augmented_arg))
>> +			return -1;
>> +
>> +		((struct augmented_arg *)payload_offset)->size = aug_size;
>> +		return written;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  {
>> -	bool augmented, do_output = false;
>> -	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> +	bool do_output = false;
>> +	int zero = 0, written;
>>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>> -	s64 aug_size, size;
>>  	unsigned int nr, *beauty_map;
>>  	struct beauty_payload_enter *payload;
>> -	void *arg, *payload_offset;
>> +	void *payload_offset;
>>  
>>  	/* fall back to do predefined tail call */
>>  	if (args == NULL)
>> @@ -457,58 +521,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  	/* copy the sys_enter header, which has the syscall_nr */
>>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>  
>> -	/*
>> -	 * Determine what type of argument and how many bytes to read from user space, using the
>> -	 * value in the beauty_map. This is the relation of parameter type and its corresponding
>> -	 * value in the beauty map, and how many bytes we read eventually:
>> -	 *
>> -	 * string: 1			      -> size of string
>> -	 * struct: size of struct	      -> size of struct
>> -	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>> -	 */
>>  	for (int i = 0; i < 6; i++) {
>> -		arg = (void *)args->args[i];
>> -		augmented = false;
>> -		size = beauty_map[i];
>> -		aug_size = size; /* size of the augmented data read from user space */
>> -
>> -		if (size == 0 || arg == NULL)
>> -			continue;
>> -
>> -		if (size == 1) { /* string */
>> -			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>> -			/* minimum of 0 to pass the verifier */
>> -			if (aug_size < 0)
>> -				aug_size = 0;
>> -
>> -			augmented = true;
>> -		} else if (size > 0 && size <= value_size) { /* struct */
>> -			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>> -				augmented = true;
>> -		} else if ((int)size < 0 && size >= -6) { /* buffer */
>> -			index = -(size + 1);
>> -			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>> -			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>> -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>> -
>> -			if (aug_size > 0) {
>> -				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>> -					augmented = true;
>> -			}
>> -		}
>> -
>> -		/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>> -		if (aug_size > value_size)
>> -			aug_size = value_size;
>> -
>> -		/* write data to payload */
>> -		if (augmented) {
>> -			int written = offsetof(struct augmented_arg, value) + aug_size;
>> -
>> -			if (written < 0 || written > sizeof(struct augmented_arg))
>> -				return 1;
>> -
>> -			((struct augmented_arg *)payload_offset)->size = aug_size;
>> +		written = augment_arg(args, i, beauty_map, payload_offset);
>> +		if (written < 0)
>> +			return 1;
>> +		if (written > 0) {
>>  			output += written;
>>  			payload_offset += written;
>>  			do_output = true;
>> -- 
>> 2.54.0
>>
> 

