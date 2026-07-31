Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F909428472
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504807; cv=none; b=Wb5mAgjEwSAp0KzmoSIhNdeG889yWIcev2OUy3RQhEMyx6g4+mxZkECWSkkFbDHpAUIF+KF+lXehmJUniKO1GC98j65T93S5bTGLsU2W1QBETMfcLlmv9ADrOlERXnl/izsXrymQVFTQHAr9aozQTOIfxDXqzc2JDCYjMt2kSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504807; c=relaxed/simple;
	bh=0ZXFcIjG4oWdc8p3JZX7VCpAbX3Lg3JdKcHl6N16W/A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfYH6dSd/JwikDvncLDdeqvxRND6MqMkQahWgRJ2wwkImCXGtsltsoY9SQN2ttVS/5DJMboqIBrDeQAQo/QIqfpR0qSxtSxTN3+eEiTlc+07owQzy1AVnTUpuMaYhC+2JYSIlq+/eeqr5ib1Ot04riKk4xOGSmosbSfmnQ1maQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVvCOzrY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVvCOzrY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so1854773a12.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504804; x=1786109604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I3TcsUSrg3jSqVgcyvCRrweMraU7LG5frrobAi0eaGc=;
        b=WVvCOzrYeNWp4E9GpHfx2Mf1NeMIcO16iQdyq/LGA2hb2jH0rCvkb5hgPZljMWqL2o
         Im5E4IVW+IecPbIiti0Yr2BP9Nrg5Lw0BOnVQdZl1RHZTroKhyVawLduiluWxTfjGz1v
         w81i9q8qIBtdLnDzh1xWDQCA1ammUjmXE2LDVXl/te+y0g4RlAlSDNOOAN5f/wl32LYm
         kuxgKbAymLz9aPQtlLxvUsppaMHUu3JO8sBKpjVMpvXfM1pXHJ1VBtW03VD7HDharP9G
         tQDoJkAFgXbg/1WQZ8Daqf6d2Kr4eKOlbPNXLs3rYY4o4DyQKxuqOuvhhWUbrtrN4Rjj
         6tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504804; x=1786109604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I3TcsUSrg3jSqVgcyvCRrweMraU7LG5frrobAi0eaGc=;
        b=qW8SXPfQiEtLzIid2sZ1uyefl+p5ZcRaw199V/6in78TAdnekK9paExVxPrtmiGNGG
         7zWv/IMwOC1mv5Eyws1DzLX0WZPpjAoP5QpS+hNNPm3DCFVfUWfNXObCouGzno0f94RQ
         7mnTG/oRkc2+UNTCOa+TLkbVJzWZ9rNH/6xEjZ+lZRIkYSqtVa0VcE4atdqJq2PVQ3C6
         csQGYz6xWEpgu6xJh6o6tdCZjGQQGSIMIUhVXeBahgcPyTVCK21Gml/XZPDTVgp9DWJl
         u/1besN0EgSRNXwwsYLPbSz2fnWvkMEeNiMfmsf4IU8qid1xzR7eGGmLb52F3QCdWp03
         ViBg==
X-Forwarded-Encrypted: i=1; AHgh+RqBy2seoVVK2zcX44km8SA54VDaBwm6Ygdmh0sUyRWP4oc4zj0SAahA6HL67+Jk+tyHr6vnc2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByEoaBXdWm5To5HzzsddTLf2o1P8QLsd9QJNVY+bI6x7GlBUB
	+9u0N+dgvkjNjJ+74V6PvWXzOal0kWWyJ0LHbxAGSnzUcqs37rPzqn5T
X-Gm-Gg: AR+sD12EV4485sj7JnpRv+hb6bS/iMnH9HjG7gTQiz9UQRevqvE9hEOPS4QC1cEiznu
	2mwtEPiuU0mbTyfWDm5S2pAf0wA57mgI+PFxWOjHwIOMI0sZjcGWk4CeoMIMbDcuozNZ5y98lQP
	WkARYIcWiUJxduxzzFsXqAGjPxnExmZSiuenEEv3MN2mwpUGs72spx3Azd7wlK1gz+Z3LW3V8ml
	LpTogLwjUHVCBCQm53aOZnmt+ySqwFMBpHMZW7o117yBqr52pjWVSIwT/aaw5bSKxkVYkEyubto
	L3slCUVCqASv5Bkzy/BaSZm48i412vy/3sw7WSj8fxNVBW7V9k+epGKaZ56umctPho0X48p4/OA
	lHfYgbpcn5lm1Jyc2RxC/F1cyP3eWDBa/Bjf4U9+WbO0yUfYPi9tZx1WmHO2BQgc+llo/S7ANYA
	pzlLtQh/QdOEbUm8UEa6khq6oMxf4hdgIPbIN96KNZm2AngFM=
X-Received: by 2002:a05:6402:a6ca:20b0:6a0:9b5a:af7d with SMTP id 4fb4d7f45d1cf-6a09b5ab525mr766276a12.11.1785504803482;
        Fri, 31 Jul 2026 06:33:23 -0700 (PDT)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5b1bebsm1969846a12.12.2026.07.31.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:33:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 Jul 2026 15:33:20 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>, STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: Re: [PATCHv2 bpf-next 05/11] bpf: Disable preemption in
 bpf_get_stackid
Message-ID: <amykIPWvF882t_gF@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-6-jolsa@kernel.org>
 <78c72a5b-0db5-47da-8b35-e6a2e6976d7c@linux.dev>
 <ams3yHvqyXrWAbBV@krava>
 <6a20bbdd-2557-4db8-8839-e2f53857ced9@linux.dev>
 <CAEf4Bzbe1tETVtVMxkaURSoW1PmVfWnR9Kd9iwaPskzCwij7rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbe1tETVtVMxkaURSoW1PmVfWnR9Kd9iwaPskzCwij7rA@mail.gmail.com>

On Thu, Jul 30, 2026 at 03:52:14PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 30, 2026 at 6:43 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > On 2026/7/30 19:38, Jiri Olsa wrote:
> > > On Wed, Jul 29, 2026 at 06:30:26PM +0800, Leon Hwang wrote:
> > >> On 29/7/26 16:38, Jiri Olsa wrote:
> > >>> The get_perf_callchain call needs disabled preemption plus we need
> > >>> it disabled as long as we access its returned trace entries buffer.
> > >>>
> > >>> Note the bpf_get_stackid_pe function is executed already with
> > >>> preemption disabled.
> > >>>
> > >>> Cc: stable@vger.kernel.org
> > >>> Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
> > >>> Reported-by: Tao Chen <chen.dylane@linux.dev>
> > >>> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
> > >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > >>> ---
> > >>>  kernel/bpf/stackmap.c | 19 +++++++++++++------
> > >>>  1 file changed, 13 insertions(+), 6 deletions(-)
> > >>>
> > >>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > >>> index 43b1e5436047..e48ddb4edd47 100644
> > >>> --- a/kernel/bpf/stackmap.c
> > >>> +++ b/kernel/bpf/stackmap.c
> > >>> @@ -624,30 +624,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
> > >>>     struct perf_callchain_entry *trace;
> > >>>     struct stackid stackid;
> > >>>     bool kernel = !user;
> > >>> +   int err = -EFAULT;
> > >>>     u32 max_depth;
> > >>> -   int err;
> > >>>
> > >>>     if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> > >>>                            BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> > >>>             return -EINVAL;
> > >>>
> > >>>     max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> > >>> +
> > >>> +   preempt_disable();
> > >>
> > >> Better to use the guard-style guard(preempt)() in this series.
> > >
> > > we prefer to call stackid_install with preemption enabled
> >
> >
> > Understand.
> >
> > I wonder if we could avoid the "goto out".
> >
> > scoped_guard(preempt) { ... } might work here.
> 
> +1, came here to say the same, I think it should be
> 
> scoped_guard(preempt) {
>    ... do all the things with direct return ...
> }
> 
> /* we got new bucket here */
> 
> return stackid_install(...);

looks good, will check on that

thanks,
jirka
