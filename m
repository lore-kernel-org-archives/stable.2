Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F91420478
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115656; cv=pass; b=bscjC2HbnMJeI6aEzGg2UivL3JPS1v0FQlY3N78F9g42W3lTgKLbCelU+ZvrQOo/RezjcRiRF9JOgTp/RKZwPA/B7jwTKTxYQuZn5it0i1dlziKbj7kAzH0XYX52Nn7SKSgTHJwfX4MXWf8GSBcjQtFjV6sYXahu4KQfUEnettE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115656; c=relaxed/simple;
	bh=cw2EjOpQbWdRgXTC2nBTmW8PZpemRbVY3jghsUYXriE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS/WKJ1RNIKN5LU9T4gtnYt5+QzTQnSWegtaRA9RtOEhVkERMgbZZ9u9kKehFjURu7pMBqHVZ7BFljsRBgq0KYdhv5QFNfMz4nmqrodDHNxvVuRBpdfGATdnizcywHPeeqG+mWH89UbHKxHgV0x1OCyosOtKOILouZEocpgFW6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr9QChzi; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr9QChzi"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c167aa9500dso473772166b.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115652; cv=none;
        d=google.com; s=arc-20260327;
        b=TMdSkGrR0ysvCtcbHsUdTn253t4bSc/j8NnvIGlj259XwjxTsDX7kwWRrBAazxrMhl
         MD605rpQi86hKf6qXCGx5jixLFqhC8qDUbKA7l6/Wus4567J/PNxPuwpTKC5BPTgyZiq
         J5g7VcnzmUaoohM9PUa/GH7FhnVF79jF+AdZpDa+wi5aghbTBfjpsBXKr4KS02m+Bj0O
         6YqP4udXtjz/qZuJh51fhnnOHyjWYhNr8kGd4K4KvFou5Qxb1caGPwMUJd4HE+nXfEAp
         RKTolcuY4ufxraRsdpkuxr0gV3n2aYsZgRQ6i6sN/6UT2OMtrNIKospAk2vbtzUS1xMU
         5srQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R5SqSs5AqefmAeE5V/Z3L3JqaBFSW0y3Aeu4U20RpPQ=;
        fh=IbBlzmw0C0bNutb+Ld7tyeW06G7nMT+t9Aw8sc0EPnE=;
        b=Wzx5PmOyg43D47Fy+KfOGMA48Ia5Cc8aI/5P8M1NuaNAA1vSfVVFYwDc73aM9Uh3wi
         pjxJ60MMz7wA/9dpBw/D3R7+vF7vShOYxzhVeMmGBPX+4Hc5hxcRiNk8OUfi7tAP7v9G
         20c0dAHa13JyB0knwlEioX+7XRV6CvKWY+jZxP/PApdNCXS410P2VspZ5PoNZ3RUuOJD
         O5O63sMo+zVVg3ghCoozQiLcdhO9zIcWCNzz0/8r7qjAkhGLNUqp0QksiSJ+b3klcz/v
         d2NHHo5dhF7gEuyAMXJVhl9F9wlDzYKMRpwSFQwm+oBbjkpbpKFKHXkssApwjeieUIq+
         9elw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786115652; x=1786720452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R5SqSs5AqefmAeE5V/Z3L3JqaBFSW0y3Aeu4U20RpPQ=;
        b=Sr9QChziq9k8ivp5a/j51klbzCQ6i44YWv2sz53zqxgS6/P7wpgcsoAWLBZa5yzlhQ
         u2JS+fnXlJw6QSnXekQxyQIU/lFaxHJJknGrgHrrB0l+hgYnGVy0aEcmbZtFB2kxQsq3
         Lsr7XPnTutefUC3MfanzeAOJ44RllODvCGN3YOcLF4H46d/6JRVkIGQZTJ83PC9Xsxv+
         nE5nNxnDLpU92H/oygw67KR5r4cD9LI+aRlvbX/R/Ha/RwGHUBUzj5x0BSOJaEF4+aMi
         GANiGZ8x+G7efkOdkmJFEEKRoock+q0Mn/YYPQBgBRgNbzuiplNsjd7RJTn3rQy37RuX
         aRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786115652; x=1786720452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5SqSs5AqefmAeE5V/Z3L3JqaBFSW0y3Aeu4U20RpPQ=;
        b=ZzKC8PgFnaMdBVOEvxs81Co5wtYnMI9CAjb0vXlL9thxWZQIU9f7hgDPTk82o01EjH
         ++LhzJnGFRHVit4/+yCDYH40+JKO1pINlfc4sEDAcA3BxCH7Si8pXei7EFxsk/fmlqoB
         tPbDjngA/RWmcc1pi76Mkf31+rO270Re0/przx+mcxblz8EQSifka0RPEdp16ijbSQFS
         rwCtlQwYg65l5VCPPl9HwgkExIJWevSY9i9qD+73gHPPEO8U05PB6f9BQ4oD7oOj/OAH
         WO15fktZlVtzLpWW2rkLG4bALLVK9MRZcL34lZyvGe7ro73iqODCDsY6iB3GdPjn4YNw
         vFdA==
X-Forwarded-Encrypted: i=1; AHgh+RquHxQKC3JeVzdBer0uU59Y/8okEeHOspk5C+Ts+D4gmlahuznad8ZO2xB8KXkkZyaPaYw6dtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rF+7CGpzSfPU4880HUdHWsxTntIPclUMeP1pHJ4sSBkLJjS/
	837klkX178op3PDsqtehvH9BqTUgAxDpdVr3bDC9rxueGJeRMiXG4Q1tFJ/8+RyeVf3yjOdx62v
	8N3rcezu2LZLUq3TVPJYmI4KkfBO/s0g=
X-Gm-Gg: AR+sD12PCpaO4KouKXhReywt2x/m+jBgbgLsFv9nvZuRIEa/W58eV/zo/qYsrFZGAEZ
	uJjDdyBPDvGGN+Kj62dnGbABe3YYAHP7zE/lIG87XBAR8nNIm7Sz39u1kd+ZzS/NhcQjByCwlrQ
	Z87KrimV5kh2+MfxuxRCaT6zpRIs0KVuFXSpXP1VarkoJHtfNQKMPPovBsRObwqLi/TUqclSbhI
	Kqtvwm1vUoBvolp+8Yh74hmvLdeARHTVC9gKl3A5UZFeYiGmvakBZWdS/ZesY1t/puAxe+SzUgQ
	An84VaoNZ5zggHWltez4DGvKB/UveSlbsYe6E7syeQ6yGepnHN6D8l9/PnB2
X-Received: by 2002:a17:907:9286:b0:c1c:6f0d:5b22 with SMTP id
 a640c23a62f3a-c2039c873a2mr1180266066b.11.1786115652150; Fri, 07 Aug 2026
 08:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806135224.3267890-1-puranjay@kernel.org> <20260806135224.3267890-3-puranjay@kernel.org>
 <20260807100828.GT776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260807100828.GT776954@noisy.programming.kicks-ass.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 7 Aug 2026 16:13:57 +0100
X-Gm-Features: AUfX_mxuITlV6KDGW3daEqhmTeXX9cWKEHeC3fVDfiCi88EOTq-NgZeWz2tSt1E
Message-ID: <CANk7y0gKtCV8ja3MNgqikxEMB4q494s62bCsB5S3xdu8Y4XyCg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] perf/core: Run sched_task() for PMUs with only
 CPU-wide events
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Usama Arif <usama.arif@linux.dev>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:08=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 06, 2026 at 06:52:22AM -0700, Puranjay Mohan wrote:
> > perf_pmu_sched_task() returns early when cpuctx->task_ctx is set and
> > leaves the work to perf_ctx_sched_task_cb(). That one only walks
> > ctx->pmu_ctx_list, so a PMU whose events are all CPU-wide is never
> > visited and its sched_task() callback does not run. With
> >
> >   perf record -b -e cycles -a -- ls
> >
> > armv8pmu_sched_task() is skipped on every switch to a task that has a
> > perf event of its own, and BRBE records leak across the task boundary.
> > intel_pmu_lbr_add() calls perf_sched_cb_inc() unconditionally as well,
> > so LBR records leak the same way on x86.
> >
> > Drop the early return and instead skip the individual CPCs that
> > perf_ctx_sched_task_cb() already handles.
> >
> > That requires the two to agree on which CPC belongs to which path, and
> > they do not. perf_ctx_sched_task_cb() gates on cpc->sched_cb_usage,
> > which perf_sched_cb_inc() sets per CPU for every branch stack user,
> > while the new gate uses cpc->task_epc, which __link_epc() sets only on
> > the CPU the task context is scheduled in on. A task with an event for
> > that PMU pinned to another CPU has an epc on ctx->pmu_ctx_list while
> > cpc->task_epc is NULL, so both paths would run and sched_task() would b=
e
> > called twice per context switch. On x86 the second
> > __intel_pmu_lbr_restore() finds lbr_stack_state =3D=3D LBR_NONE and cal=
ls
> > intel_pmu_lbr_reset(), throwing away the callstack the first one
> > restored. So gate perf_ctx_sched_task_cb() on cpc->task_epc too.
> >
> > For the CPCs that perf_pmu_sched_task() now handles, the callback no
> > longer runs inside the perf_ctx_disable() and perf_ctx_enable() pair in
> > perf_event_context_sched_in(). __perf_pmu_sched_task() disables the PMU
> > around the call itself, so the callback still runs with it disabled.
> >
> > Fixes: bd2756811766 ("perf: Rewrite core context handling")
> > Cc: stable@vger.kernel.org
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/events/core.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 9815894b67e77..675dd05935f35 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3757,6 +3757,9 @@ static void perf_ctx_sched_task_cb(struct perf_ev=
ent_context *ctx,
> >       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> >               cpc =3D this_cpc(pmu_ctx->pmu);
> >
> > +             if (cpc->task_epc !=3D pmu_ctx)
> > +                     continue;
>
> Why isn't this the inverse condition of the below? That is, we should
> call either this or the other, right?

It should be. There's only one epc per PMU on ctx->pmu_ctx_list, so
!=3D pmu_ctx here is really just "task_epc isn't set", and once the extra
term below goes the two are inverses.

>
> > +
> >               if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
> >                       pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in)=
;
> >       }
> > @@ -3921,12 +3924,15 @@ static void perf_pmu_sched_task(struct task_str=
uct *prev,
> >       struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
> >       struct perf_cpu_pmu_context *cpc;
> >
> > -     /* cpuctx->task_ctx will be handled in perf_event_context_sched_i=
n/out */
> > -     if (prev =3D=3D next || cpuctx->task_ctx)
> > +     if (prev =3D=3D next)
> >               return;
> >
> > -     list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry)
> > +     list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry) {
> > +             if (cpuctx->task_ctx && cpc->task_epc)
>
> I'm not sure I see the need for the first part of that clause; why
> isn't: 'cpuc->task_epc' sufficient?

It is, task_epc can't be set without task_ctx. ctx_sched_in() sets
task_ctx first, ctx_sched_out() clears both, and the window in between
is under ctx->lock with IRQs off so the scheduler never lands in it.
That includes ctx_resched() scheduling out a single pmu, which leaves it
open the longest.

Will fix both in v7.

Thanks,
Puranjay
