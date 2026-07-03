Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43321382F03
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069151; cv=none; b=BxIbmXwtbk/XDZ969sFiAJw5pUkjAgpP/bCN2tw0UApJ26mPkykUxpaKUHlr3yx2NSD6fwCtrT/RfbcLiJcphMQSvvBUmtheXvqO6dv5atMIEOYBBTVMUx66M/cPH+NHP92E8prD67i5PkE9/VRp8c541Id93ROD3RG5VhsoVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069151; c=relaxed/simple;
	bh=BGrT6mjr1QtUVwqrL2EvIrfKu7D1HtU94Yv2YrtU2MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8bHcX0K5YxVp5pmrx9wkJVriXpmV+B/6xoZxIw2JKo3aY3wMyNKAuisEHWKj4t+DS+9R82MxBkwD+gqHiTtcqX1utg+vtVrE9rVQg4I/0YzNEBkR4NgPocVjAJU0kUZ+hyEEWtpma2JbHzi/nD0zwhyDLtU9uhPEFXZrUeJinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYQHRcxB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCY02bPl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYQHRcxB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCY02bPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783069147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2LTqgcZL5QIC6ifv5mhWJiQaon6VL2pkLdi6WE7h8A=;
	b=EYQHRcxBBxRD7UzT2X+xlOwNeUiGfnvDgCiTZb4wKGsk3TljF9v188nYA91USo57OQwdCC
	lzKUZbthjSaZIsvKm18bXPpAJFU95n4nVePtZ+EOOnyaSgkBDfOtbHsHcz3KwabhNS1IXE
	j2jDcOzE1aq5ZNedn7VpTA2PWEXlH+I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-uS9DXCGhN2K33700FLG05w-1; Fri, 03 Jul 2026 04:59:06 -0400
X-MC-Unique: uS9DXCGhN2K33700FLG05w-1
X-Mimecast-MFC-AGG-ID: uS9DXCGhN2K33700FLG05w_1783069145
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46fb9079a04so170634f8f.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783069145; x=1783673945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2LTqgcZL5QIC6ifv5mhWJiQaon6VL2pkLdi6WE7h8A=;
        b=NCY02bPljwIbzPY6zz3/irbdtzqYOxQX3xvl7UAtrXTZr7g9pDM5qLtVSQVEQwXAhk
         xtgKGfLV0T1THkcSKCl2msx88VYfcKBbwh3l+JWkeH+CwJwwfievnEQPcrxSO+M1bL8Y
         qd5n3IEn1AX5YfLYrxU4Ft4HKGsJR2sgaZIlcJp6JB13F66HhXZ/2QdAVRwkxI+gX4r2
         POdo0+UUrVAjiah+SMNh4pBh8S5CBsnrEqcU67tBWsQHLZ/basymE4k0y1+g6ARbSXux
         nmuNMcwKcB5pxyt6AUZ3fjEmhaPPef9mJiiO608E6X7C+EkWmIav/vezcMOtGV93o/0T
         w5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783069145; x=1783673945;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2LTqgcZL5QIC6ifv5mhWJiQaon6VL2pkLdi6WE7h8A=;
        b=ru2I+VIAxmkTq15ZoOfQsklU9GD5w4ZUu9+OYr21BTYdkqVLk0xzN/uitMCO59gx5B
         TvdneqoUki/umOXOstQUVooLpgFGNbSfOxIp8gfnUzdI4klwO/ekvfEQcOoftZ88ha/E
         K6iGKp6QiEpxYa1jRrgmHia8m6BB1y+VUdTReNyrsVyjFYHZyS23A39q0tubiPr9u5wq
         eDZdkuWwEFT0ppj1dXq32HhUWpF6B08RVZXJ0U9FoVWyNDKttEfzamldb5soV/6BwyYS
         Sb6+8D0kduxW93LKbJVCdqETpRPK83WTbsdsuPmjDXlE4Q7s1xSqwiJceFybIBMjVakg
         AIHg==
X-Forwarded-Encrypted: i=1; AHgh+RoENZQXkCMm0e2agUXknhA472fM7nrMHQvPL9QLRSGBfy33RJVUFU9v5n7x8lomhy9UmNE6+FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnqVqxUo2OzFogIPmR6fRcK16ReNDVUi2oSqd8O67kStHVYK/
	5kmXimQ0M7paxglGleVCDp4UfGvzsva8n73dSGCy7KWBFgHM85IVmFukFx5Syd8q31BGZtI6gGW
	jyazsDPFYpNCLZIc/nh5NV0eDRsfksccyuJGo6paDwXLZ74fRXQuXwmAU
X-Gm-Gg: AfdE7cnO21CGOI6pYeSiyNZCjikVdnZut/LeyCPSaSxIdSBpeUGeDOQnNxjMI5twA6s
	Lx4YgOMmKNzyUw4e1BF7gqPBlJ3a6fg7U0hYiV8fwAMXK0/Y0UKVRcin1l/8M780JOcz5kjANtJ
	5h/aE2T0CvZLvhEikmx4cD2xjbiQ9R7UF9v3chjgmCnN94qQv2zDScbQUOLOaRy4g5AwjBtlwg4
	Wo/+fTUKH8AuM1Z6pJ8FNldTzlfIVOeZdtZV4FYNepbxDLA1WuBclS+ExHOcsd6lBXesqB2wrMm
	z5eeR8FVqsg/51W+GeezN9fJnzpV3U7s9twb3nZc1lq4vy98tdxQAUJyxAq9DY3lBopv2dWEIfy
	OonP1/cLsOvt9t++juPegxSuSbUsWrmYwS31atXwt
X-Received: by 2002:a05:6000:2c0f:b0:46f:7d90:8121 with SMTP id ffacd0b85a97d-477583280e8mr14001418f8f.14.1783069144605;
        Fri, 03 Jul 2026 01:59:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0f:b0:46f:7d90:8121 with SMTP id ffacd0b85a97d-477583280e8mr14001342f8f.14.1783069143587;
        Fri, 03 Jul 2026 01:59:03 -0700 (PDT)
Received: from [192.168.0.199] (adsl-dyn37.91-127-59.t-com.sk. [91.127.59.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm19404119f8f.32.2026.07.03.01.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:59:02 -0700 (PDT)
Message-ID: <918b004a-4184-44a0-ba36-ac0e0a43da71@redhat.com>
Date: Fri, 3 Jul 2026 10:59:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 <93e70dc7-e52f-444e-b57e-09d149dc4808@redhat.com>
 <CAEf4BzYWdsBDQ3D41=+n_oCO68bVOtKuqQCqZOEVo=j7nK9Ozg@mail.gmail.com>
 <82252ae0-133a-45dc-9622-315236a437ad@redhat.com>
 <CAEf4Bza8vFSkuiD_Vd47-eGuDS40kKvTcHQR=V3OY=c505a9=g@mail.gmail.com>
 <4f43e9aa-2444-407b-ae52-0f4bf889ec17@redhat.com>
 <CAEf4Bzb4niXoqLDWvD211M9eJ+Wo5KT2ezVYtTVABVOGOLe=Ug@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4Bzb4niXoqLDWvD211M9eJ+Wo5KT2ezVYtTVABVOGOLe=Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/26 20:06, Andrii Nakryiko wrote:
> On Thu, Jun 25, 2026 at 11:04 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 6/25/26 19:55, Andrii Nakryiko wrote:
>>> On Thu, Jun 25, 2026 at 4:58 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>
>>>> On 6/24/26 19:19, Andrii Nakryiko wrote:
>>>>> On Wed, Jun 24, 2026 at 3:27 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>>
>>>>>> On 6/24/26 08:47, Viktor Malik wrote:
>>>>>>> On 6/23/26 19:10, Namhyung Kim wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>>>>>>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
>>>>>>>>>> The loop for processing syscall args in augment_raw_syscalls has a
>>>>>>>>>> history of breaking with Clang updates, see e.g. commit 013eb043f37b
>>>>>>>>>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
>>>>>>>>>>
>>>>>>>>>> Now, a similar thing happened between Clang 21 and 22. While the issue
>>>>>>>>>> is mitigated on the main line by a recent verifier update, it remains
>>>>>>>>>> broken on the 6.12 and 6.18 stable branches:
>>>>>>>>>>
>>>>>>>>>>     [linux-6.18.y]# sudo perf trace true
>>>>>>>>>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>>>>>>>>>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>>>>>>>>>     [...]
>>>>>>>>>>     BPF program is too large. Processed 1000001 insn
>>>>>>>>>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
>>>>>>>>>>     -- END PROG LOAD LOG --
>>>>>>>>>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>>>>>>>>>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>>>>>>>>>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
>>>>>>>>>>     Error: failed to get syscall or beauty map fd
>>>>>>>>>>     [...]
>>>>>>>>>>
>>>>>>>>>> The reason is that the loop is quite complex and the BPF verifier often
>>>>>>>>>> struggles to prove that it terminates.
>>>>>>>>>>
>>>>>>>>>> Fix the issue by refactoring the loop body into a callback function and
>>>>>>>>>> calling the bpf_loop helper. This should prevent future breakages of
>>>>>>>>>> this kind since the callback function has no loops. It also allows to
>>>>>>>>>> drop a few artificial checks to help the verifier, including the changes
>>>>>>>>>> introduced by 013eb043f37b.
>>>>>>>>
>>>>>>>> Thanks for working on this.  I encountered this issue before and never
>>>>>>>> found time to take a deeper look yet.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>>>>>>>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
>>>>>>>>>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>> ---
>>>>>>>>>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++-------
>>>>>>>>>>  1 file changed, 96 insertions(+), 61 deletions(-)
> 
> [...]
> 
>>>>>>>>>> +  struct args_loop_ctx loop_ctx = {
>>>>>>>>>> +          .args = args,
>>>>>>>>>> +          .beauty_map = beauty_map,
>>>>>>>>>> +          .payload_offset = payload_offset,
>>>>>>>>>> +          .value_size = value_size,
>>>>>>>>>> +          .output = &output,
>>>>>>>>>> +          .do_output = &do_output
>>>>>>>>>> +  };
>>>>>>>>>> +  iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>>>>>>>>
>>>>>>>>> bpf_loop() is old and generally not recommended.
>>>>>>>>> Please use bpf_for() then the diff will be one line change and
>>>>>>>>> can scale to any number of args. Not just 6.
>>>>>>>
>>>>>>> Thanks Alexei, I didn't know about this preference.
>>>>>>>
>>>>>>>> One thing we should take care is to support old kernels.  The oldest
>>>>>>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
>>>>>>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
>>>>>>>
>>>>>>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
>>>>>>> trace: Collect augmented data using BPF") so we should be good using
>>>>>>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
>>>>>>>
>>>>>>> I'll refactor with bpf_for and will send v2.
>>>>>>
>>>>>> Or I won't. It turns out that just swapping the for loop for bpf_for
>>>>>> leads to -E2BIG from the verifier again. Looking at the verifier log, it
>>>>>> fails to find equivalence between states at the loop head:
>>>>>>
>>>>>>     [...]
>>>>>>     78: (85) call bpf_iter_num_next#84922 [...]
>>>>>> fp-56=map_value(map=beauty_payload_,ks=4,vs=24688,imm=112)
>>>>>>     [...]
>>>>>>     78: (85) call bpf_iter_num_next#84922 [...]
>>>>>> fp-56=map_value(map=beauty_payload_,ks=4,vs=24688,imm=120)
>>>>>>     [...]
>>>>>>
>>>>>> IMHO, the reason is that payload_offset, which points to the
>>>>>> beauty_payload_enter_map entry, gets updated in every iteration.
>>>>>>
>>>>>> This could be probably fixed on the perf side by reworking how augmented
>>>>>> args are stored but at this point, bpf_loop sounds like an easier and
>>>>>> more reliable approach.
>>>>>>
>>>>>> Let me know if anyone has objections, otherwise I'll send v2 of the
>>>>>> bpf_loop approach, with suggestions from Sashiko incorporated.
>>>>>>
>>>>>
>>>>> I'd still try to adapt bpf_for(), it's a much better code structure.
>>>>> You probably need to add a bounding checking/confirming `if ()`
>>>>> condition validating that offset at which you access map_value is
>>>>> always correct. And/or you might need barrier_var() before using i,
>>>>> because bpf_for() macro does bounds checking (check the macro itself),
>>>>> but compiler often will reorder instructions leading to verifier
>>>>> complaints.
>>>>
>>>> I gave it a try but wasn't successful so far. I think that the problem
>>>> is that while it would be possible to add an upper bound condition for
>>>> `payload_offset`, the verifier tracks the value of `payload_offset` too
>>>> precisely (as map_value(..., imm=X) with a concrete offset) and never
>>>> merges states with different offsets. And since there are multiple
>>>> branches inside the loop, each incrementing `payload_offset` by a
>>>> different value, the verifier seems to fork its state on each branch,
>>>> effectively leading to the amount of states growing exponentially and
>>>> hitting the jump limit.
>>>>
>>>> To me, bpf_loop sounds like a more reliable choice in this situation.
>>>
>>> correctly verified bpf_loop would basically have to follow the same
>>> logic, so if it works with bpf_loop, it should work with bpf_for.
>>
>> Are you sure about that? My perception is that the bpf_loop callback is
>> only verified once in a single pass. On the contrary, bpf_for is a
>> normal loop, for which the verifier needs to prove that after some
>> iteration, we get to the state seen in a previous iteration (to prune
>> the state). Which never happens here because the offset to
>> beauty_payload_enter_map (the payload_offset var) is tracked precisely
>> and causes state forks on every condition inside the loop.
> 
> Hey Viktor,
> 
> Sorry for taking so long to get back.

Hey Andrii,

np, thanks for taking a look!

> Answering your question about bpf_loop() vs bpf_for() they are
> conceptually the same from verifier POV, so they are verified
> similarly. Earlier (buggier) versions of verifier did have a loophole
> where we verifier bpf_loop() in more laxed single-shot way, but that's
> not correct. We have since fixed that and it (bpf_loop) now has to
> "prove" convergence just like bpf_for().

Right, this is the piece of the information that I was missing. It now
makes much more sense.

> Anyways, the biggest issue with "normal" unrolled BPF loop is that
> people tend to write it such that there is some carry-over state
> between each iteration (like output variable which tracks advancing
> but bounded offset) which, with fixed number of iterations allows
> verifier to prove everything is bounded.
> 
> This model is really-really bad for bpf_for() because it doesn't allow
> convergence. The trick is to structure each iteration as independent
> piece of calculation where the state outside of bpf_for() loop stays
> as unspecific/imprecise as possible, which at the beginning of the
> loop you revalidate invariants, if necessary (e.g., reestablish
> map_value offset boundaries).
>
> Anyways, it needed a bit of persuasion, but here's the verification
> result and gmail-butchered diff below. The trick is in making output
> imprecise (force verifier to forget its tracked range), so it doesn't
> differ between iterations from verifier POV. That's what the global
> ZERO allows to do. (We've discussed w/ Alexei and Eduard adding
> special instruction to force scalar register into imprecise, it would
> be a cleaner solution here, alas we never got anywhere with this,
> unfortunately).

Many thanks for the patch! Looking at it, I got pretty close during my
attempts, I only missed the ZERO trick, which is obviously crucial. I
was worried I'll have to rewrite the logic much more to get rid of the
concrete carry-over state but this is really neat.

I'm wondering if we could teach the verifier to figure out that it's
tracking a value too precisely in an iterator-based loop and convert it
to a range (sort of a "widening" operation). But I guess that this part
is going to be changed quite a bit with the upcoming verifier change
that Alexei is working on.

I'll take your change and send v2 of the patch (with a fall back to
standard for loop to keep backwards compatibility).

Thanks again!
Viktor

> Processing 'augmented_raw_syscalls.bpf.o'...
> PROCESSING ./util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o/sys_enter,
> DURATION US: 1129, VERDICT: success, VERIFIER LOG:
> verification time 1129 usec
> stack depth 64
> processed 547 insns (limit 1000000) max_states_per_insn 4 total_states
> 38 peak_states 67 mark_read 0
> 
> File                          Program    Verdict  Duration (us)  Insns
>  States  Program size  Jited size
> ----------------------------  ---------  -------  -------------  -----
>  ------  ------------  ----------
> augmented_raw_syscalls.bpf.o  sys_enter  success           1129    547
>      38           172         917
> ----------------------------  ---------  -------  -------------  -----
>  ------  ------------  ----------
> 
> The diff:
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 2a6e61864ee0..8436368ba203 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -429,15 +429,17 @@ static bool pid_filter__has(struct pids_filtered
> *pids, pid_t pid)
>         return bpf_map_lookup_elem(pids, &pid) != NULL;
>  }
> 
> +u64 ZERO = 0;
> +
>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  {
>         bool augmented, do_output = false;
> -       int zero = 0, index, value_size = sizeof(struct augmented_arg)
> - offsetof(struct augmented_arg, value);
> +       int i, zero = 0, index, value_size = sizeof(struct
> augmented_arg) - offsetof(struct augmented_arg, value);
>         u64 output = 0; /* has to be u64, otherwise it won't pass the
> verifier */
>         s64 aug_size, size;
>         unsigned int nr, *beauty_map;
>         struct beauty_payload_enter *payload;
> -       void *arg, *payload_offset;
> +       void *arg;
> 
>         /* fall back to do predefined tail call */
>         if (args == NULL)
> @@ -449,7 +451,6 @@ static int augment_sys_enter(void *ctx, struct
> syscall_enter_args *args)
> 
>         /* set up payload for output */
>         payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
> -       payload_offset = (void *)&payload->aug_args;
> 
>         if (beauty_map == NULL || payload == NULL)
>                 return 1;
> @@ -466,7 +467,7 @@ static int augment_sys_enter(void *ctx, struct
> syscall_enter_args *args)
>          * struct: size of struct             -> size of struct
>          * buffer: -1 * (index of paired len) -> value of paired len
> (maximum: TRACE_AUG_MAX_BUF)
>          */
> -       for (int i = 0; i < 6; i++) {
> +       bpf_for(i, 0, 6) {
>                 arg = (void *)args->args[i];
>                 augmented = false;
>                 size = beauty_map[i];
> @@ -475,6 +476,11 @@ static int augment_sys_enter(void *ctx, struct
> syscall_enter_args *args)
>                 if (size == 0 || arg == NULL)
>                         continue;
> 
> +               if (output > sizeof(payload->aug_args) -
> sizeof(payload->aug_args[0]))
> +                       break; /* can't/shouldn't happen */
> +               barrier_var(output);
> +               void *payload_offset = (void *)&payload->aug_args + output;
> +
>                 if (size == 1) { /* string */
>                         aug_size = bpf_probe_read_user_str(((struct
> augmented_arg *)payload_offset)->value, value_size, arg);
>                         /* minimum of 0 to pass the verifier */
> @@ -510,7 +516,7 @@ static int augment_sys_enter(void *ctx, struct
> syscall_enter_args *args)
> 
>                         ((struct augmented_arg *)payload_offset)->size
> = aug_size;
>                         output += written;
> -                       payload_offset += written;
> +                       output += ZERO; /* forget range */
>                         do_output = true;
>                 }
>         }
> 
> 
>>
>>> Is
>>> it possible to share your bpf_for-based code in some branch to try
>>> locally? I'm sure it can be done one way or another.
>>
>> The change is super-simple, I can as well share it here. It's just the
>> matter of using bpf_for with two additional suggested mechanisms,
>> barrier_var and a bounds check for payload_offset:
>>
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index 2a6e61864ee0..341d77a78949 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> @@ -432,7 +432,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  {
>>         bool augmented, do_output = false;
>> -       int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> +       int zero = 0, i, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>         u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>>         s64 aug_size, size;
>>         unsigned int nr, *beauty_map;
>> @@ -466,12 +466,16 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>          * struct: size of struct             -> size of struct
>>          * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>          */
>> -       for (int i = 0; i < 6; i++) {
>> +       bpf_for(i, 0, 6) {
>> +               barrier_var(i);
>>                 arg = (void *)args->args[i];
>>                 augmented = false;
>>                 size = beauty_map[i];
>>                 aug_size = size; /* size of the augmented data read from user space */
>>
>> +               if (payload_offset + sizeof(struct augmented_arg) > (void *)payload + sizeof(struct beauty_payload_enter))
>> +                       break;
>> +
>>                 if (size == 0 || arg == NULL)
>>                         continue;
>>
>>
>> Thanks a lot for the help!
>> Viktor
>>
> 

