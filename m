Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC43DEAD8
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389138; cv=none; b=ZzMe0MCY92+MIpvnE7y2Ax9s7zhqDA2InA+3eXdlICU5fYiwpsCUvRwLttginKZ9IjzlXE88hfBVzfAEFI6iRQF8lbSRtsrkQoiGU2GHRvcpUufgIhRSfXhGKzC+NBn8FoMsK2kT8zsGK78IRwql1Mwl1VZ3W/cUVi85rYYPtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389138; c=relaxed/simple;
	bh=1XNAuaLY5p2QwZ1xZOVagV8DDqx/t5x6UyDOQ78JEtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svscDzin2E9nUmZ9FEn8BmEUZ6pmxNqAESL9n1XEUAF/ehssEuAVlbMOfpYvkbE8Do9h6p8djvkuupQB0wF7L5av1RI5LHTAdGJ8cW2Sn0z/hVKB4MS1jWMbjnii020hwoxUEPta920wPBZ7PrPqZb0YUuYdtXyTkWtopzZdEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBjbeiug; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jYIp5s1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBjbeiug";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jYIp5s1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5dk0+y7YIP6iBUeL3aPYTXXsaNDLnD9g/Qpkl8DKV8=;
	b=cBjbeiugDd8erRbsoRYgKShzE3DGElEzXVFEWGK3TKpxhUf02seZcQCmO63WhHcCHZKWfp
	pNgx1MqANwPjyp5pA+PPqxBfJhkf4iZuHnSMa5An4PfGvm1LDWG3+V0ObyWT+R4xa6maEZ
	RQSwoxQm7aK2K/Exq5kfUYjPZl+jXSg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-6_qNS5PpNrCuLTas_wamgQ-1; Thu, 25 Jun 2026 08:05:35 -0400
X-MC-Unique: 6_qNS5PpNrCuLTas_wamgQ-1
X-Mimecast-MFC-AGG-ID: 6_qNS5PpNrCuLTas_wamgQ_1782389134
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924d5231daso18088965e9.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782389134; x=1782993934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5dk0+y7YIP6iBUeL3aPYTXXsaNDLnD9g/Qpkl8DKV8=;
        b=jYIp5s1asOJJ5vUo7Meax3KhXOaYD6u6UV7L4zTSbe1A9F3S+zvw8jqFgNYQsSkBVV
         olbIYL5kb9APxD3JWELB7yYBjjuBlIwI/uBjmita7AshgAUg1Lap1QorPGz7kqquVmDU
         qqTG8B39sQSwmJpcUnPeOfmhovWg75PgFsoinhXwhtRrNeEQ4OZ839c2COPHw1V+KxGP
         sAJ8KYzhVe6RGcxdTUIhXc7JLwdYvPtmqbv2G+RGyBctUc5rz5PmJMJmzkD1Q6SKZFMm
         qG2FwjSkM9nKUbYZ1Ei6mFwOOz4K8LbTZ8AZJ9iwi6EGlK68agafIjcV98TcMTUDYUly
         h+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389134; x=1782993934;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5dk0+y7YIP6iBUeL3aPYTXXsaNDLnD9g/Qpkl8DKV8=;
        b=ot6ItKakERA6GfcMq5B626maTJ7y+5/jT9B88aDkBs7j5XYF/Q9KbrhkijCIlBS3vh
         f3gF3TsGd0BkxSbJjixI7KKZoSeSHPK+da37jRaJ81HrP3Tsw05ibhTdMeswOuHf1au/
         Akn9lxB1sqyegPFUkhjLY84SJyad3bQqSOj60VegZIaaUhbfMptxAxF/cifilHVmXGcX
         cG+tRf3pvVoSnEDHbVn7BiHxJKPxCt+thNaXzibDGhwzZ5M1G9pXHksBe3b5YCJtMk9y
         Sss2FeYy0GNonSRmIxAjaHut+SX3FKP78BwQlBFoWllK6Jher5kB6+eHZWyVApeOCnjj
         9zMg==
X-Forwarded-Encrypted: i=1; AFNElJ/6sa8yfbvXCXx4tuScpnvBehqQlWQCopDc8SyRQMvA8RKQX8kQGylkuP8JDsv89UKeG7Zst0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcWIdibQg5XmBP5ry71AR531jg/yO+MUVcLs4ZcFC4ekhcWG3
	EWXK0XRP6utUkG3o/8yYLFRh4uu8C04+nveyVjzw+sTT5T3zupM+ghpeH4fObMDrOx/6RKWvhbh
	xvWAtXgTAfjphSijDH1iFP7Bbf4HyHcWrGg3bRoy6TB/qjPgxai2kSIYS
X-Gm-Gg: AfdE7cnSURnC9a1YOLnxCibkJ8SUNIxH70cruNZBrw4165uVw17siEaukN9DovxbYQd
	zWPb0JNG/1RGv2rjlM/j/zZfwhrlYFdTBB/mRUMautwk0keMyQ6EE8+Yy/RiwSNF8nYGaBzMXyk
	BVbE60M4eXASs0DD6O2CN2GkJen5ojfy68+s/viDvAKiGml+7KfBeLcvwF3yv0gNLWd15VGIqCb
	lF5Oaa375m2Z9gPlOxT3q5HGSP1JB4D3/CPWkFYXh6ZYyHvHXyaNU1KVdyNT+LeJUnNvDo8HZ0B
	6lY0h5KFIvZo0JMJhtBOlZXcMd+KTrCDMJ6neLndpWP9wMsGZsnf5siK3aFSNqqerhGNomrqfj0
	=
X-Received: by 2002:a05:600d:844f:10b0:490:ae52:499c with SMTP id 5b1f17b1804b1-49266899ff0mr23855175e9.21.1782389133745;
        Thu, 25 Jun 2026 05:05:33 -0700 (PDT)
X-Received: by 2002:a05:600d:844f:10b0:490:ae52:499c with SMTP id 5b1f17b1804b1-49266899ff0mr23854805e9.21.1782389133345;
        Thu, 25 Jun 2026 05:05:33 -0700 (PDT)
Received: from [10.43.17.131] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm1630033f8f.33.2026.06.25.05.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 05:05:32 -0700 (PDT)
Message-ID: <3c221e35-d642-4036-88fd-d25df7f8807e@redhat.com>
Date: Thu, 25 Jun 2026 14:05:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
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
 <ajwu7xR6V6MAQOFw@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <ajwu7xR6V6MAQOFw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 21:24, Namhyung Kim wrote:
> On Wed, Jun 24, 2026 at 08:47:38AM +0200, Viktor Malik wrote:
>> On 6/23/26 19:10, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
> [SNIP]
>>>>> +	struct args_loop_ctx loop_ctx = {
>>>>> +		.args = args,
>>>>> +		.beauty_map = beauty_map,
>>>>> +		.payload_offset = payload_offset,
>>>>> +		.value_size = value_size,
>>>>> +		.output = &output,
>>>>> +		.do_output = &do_output
>>>>> +	};
>>>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>>>
>>>> bpf_loop() is old and generally not recommended.
>>>> Please use bpf_for() then the diff will be one line change and
>>>> can scale to any number of args. Not just 6.
>>
>> Thanks Alexei, I didn't know about this preference.
>>
>>> One thing we should take care is to support old kernels.  The oldest
>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
>>
>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
>> trace: Collect augmented data using BPF") so we should be good using
>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
> 
> Yep, we'd like to support old kernels.

How much strict are you on this requirement? IMHO, the very least we
need to fix the verifier issue is bpf_loop, so that would still not work
on 5.10 and 5.15 LTS kernels.

We could probably keep the open-coded loop in case bpf_loop is not
available but `perf trace` would still fail on kernels without bpf_loop
for new perf built with Clang>=22. Also, the code would be a bit ugly
and I'm not sure how well the feature check for helpers (bpf_loop) works
on old kernels.

Viktor

