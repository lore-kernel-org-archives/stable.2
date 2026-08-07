Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686238553F
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112152; cv=pass; b=RA/cka40ZHzXlMo5QjBw8PWdXkUV/KSakzs0GGOmPoHfmO51C4fO/Hc4NfRVKKQ57lODCJiKXAWz7S5ljzlbDxb5Wt2GD9U9zGNY7lMOPieYCykd+u7inEtg9R9sMBIsGYk78/TunyGymTEQw6kqMVJGrAKjCKzQy/496hiM8EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112152; c=relaxed/simple;
	bh=8nIgFryYz2DrargIZD0GNMzp+E0YqW98PtHpUo3w5m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHsXU0z2aVvbzCzBJUZ3FhNCeqRiPcpZJi25OJ+Y9F2zhVdkH/l3b1VAVLsZ1T95bOIDJKBnwrPSdhcMI9DhDi70VQp6x1TrxWXFSx9ngln/kkDMrzHdzFUXgLodfZ31ifxJWF4GXuwbV4Q+bNeKXNy2Q2yUVXMtw8PKAAWlTw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxqrp1H3; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxqrp1H3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1600d040e4so298791066b.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786112135; cv=none;
        d=google.com; s=arc-20260327;
        b=iwsszZTng1WwcmNFzEZlhiI6JU43MKUVVbc1CMa/HZUIQVutLbX60xfNgQuxd89fYA
         3JOE2N8SIXv3CVTPW+IMvrBKa5CTcvPP750v5Ye4oMWeXgiJnFIjjzmnHBI36z5me73V
         ERoOPbCHtcaViYzAZvbJrbbSflEJbv+sXK8UOmd/zsJbDlwDftUhNnqulATJQ+Glnm6f
         Lw1ay2rTAehWQ0lDxfxTqRcT7z2aXWPiR5OECrkggpHOIQ1tU5NrV91ReJzDuhCuWZ/p
         zcccNuhzjxiFehuBX9cx6qztScVa4UStenjVHYzhyB7WedHIS3/0tdI2l+srbO+uQKkP
         hvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        fh=VMmv2VoRWvhaAwwvHx4SQlDH497BkKgv7ZcgWZYFNNI=;
        b=UBe/BgFJ3yzMGHgxjDFaX/8PnnDLk6WehPxtsNUFsG+5YJSX4SxBZlgReB8tDQGYID
         ZK9KOLXRe6APWt6tEgLbh83R2J24zLGXYWbWJCfm+veEXmuvTHhi3sVcNrtVUni57Esu
         28i35rVx0cJqKrJLUicnkHXpkPAHvdRTO8o1RHR1JfxMJVo0qsTDkvoU0DG1UxAzvBXT
         EX/p1hFfFTKpSn+G6cMO40ZSDqVAknkqC48EY6Uh7hFvXD+GJz7SFhMemDHsbSflp9EO
         Yg9YJIs6gfZNmYJuYZEO8H1aX4ARiPPV7fFR217WgMbaNv8Mz4QTIn6W2uYJF997NlPq
         HElw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112135; x=1786716935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        b=Vxqrp1H3W7lDss+3/JdOl8YpDjax42CqChmA8tp84UAvP5jrpNRTVzvrdklCi3hlq9
         aqdkIGC0jMlPRwyEWktr1QlsqhR7bbCnQ3XGjsHSuJ77RKohnyUc9ObKajFp2lfPCsw7
         YuhAhTDZ8TE6CljHcBlNLz32EgW2YC0Tl1hnYSNy1rN++3RbYydMCWbirw6ljPTyKZJV
         t8ypbtuzfC9mvLl4fIhCi26bmqcrgfeBVNqhPzLsNDMQ/cO1klvovGlN5OuGenmtJanj
         Jm32TEx1fxBT5u3Ow7EGRB023C+B//BkstwuClXXIZHCZ/H4RMJJw1dZ7CfPdxRizZIV
         LAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112135; x=1786716935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzS5XFrgTuiPjNnu38gbVxPmnnD5h/HbpvqKJVfoMMI=;
        b=MvJWgwx/X6a7Sp5NgC5tBhwTSAzCXeVjYNFhIKKDBZR+fo8KhX6MRM4ayafixcq6Ag
         9HgnBJbiP2TovnEMB/dX/Ywpt0V7MZetxlaOcxLQA58k3H12mGQ6wgWyS8tAGIlzHoYP
         yPUcI6vvI/1pVHdQ1iHwWMiHT9ljp0rGn4aZOC1YTdirDJNBmUWFIoKoplRuz6bqbelS
         dUtEL9MLOtHq/heUltByzEKe/F/Ufe1QYSnmxjTC3XzB8E65+2x40YCqJTHSiZwv+xwv
         3wNJxFUhSK6nMonaGDFz9lULbFC/et0EvKYS5dlnGWkkoCfAIqfYlPI9r1RdW15JVV0B
         0mDQ==
X-Forwarded-Encrypted: i=1; AHgh+RquhiLAKPtO2lS+zUulmSfV37kdrir3l4IYSv3EWfkP1CIrxKcw1a9T6dXWYs25SnNLH2vn/vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wMizAgAG3hlIt3MLqEVc3B62/177jkp7JplUqF0SrR8lHshk
	yj+hO5dEaN527qF3ibaFhONqGolwKVUc1Of/WonOZeaDCQq6g4tTh21QfQCQIl3zaZg5+Wa5LkV
	PQf2AMIRGWhiVue4FHjqWGCxYTUKTizI=
X-Gm-Gg: AR+sD11xP5FpBimdK7/mo1q45XuHAp9JIExGY4XWQfNCs2uGGtLdalgKVLlTCKpMN/T
	B3im29lsEDoGnOwGV6kprN0XWCkCRLtsNTxC0lne99OQk8FR2X5gjbp0f+J+nw8mAREsdhja409
	VRFGaK4q8KgIX2iVj/W7ShhxlyBwulnV1ydeuRWdCEiJ3skg/ZkSPVFahfJ+sGQ/OFniku8qIXx
	SYe7/OPPT40Ps1cAoq3v3id6UmUr0mB9vwWKVyeHEpml/FOOASuTdDj0zX7lZkwUlN4GyFK8z40
	JDk6S2pIdqGVvpy7YtlDhlFNdkOrSViy+WYal/BsvzJO7++NwYWPxPCKUaXS
X-Received: by 2002:a17:907:a606:b0:c1f:df40:1d83 with SMTP id
 a640c23a62f3a-c2057e093demr807232966b.5.1786112134646; Fri, 07 Aug 2026
 07:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806135224.3267890-1-puranjay@kernel.org> <20260806135224.3267890-2-puranjay@kernel.org>
 <20260807093951.GS776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260807093951.GS776954@noisy.programming.kicks-ass.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 7 Aug 2026 15:15:21 +0100
X-Gm-Features: AUfX_mwZEiydqK_HU1_ia3MF27eq51puWHtYC7ZlluNhh2_0hfgI6nV6cPYk91Q
Message-ID: <CANk7y0hq3w+bRNmuT1PWvhZb=ob=6Y5keN7-25vRSbx5nxakNA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
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

On Fri, Aug 7, 2026 at 10:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 06, 2026 at 06:52:21AM -0700, Puranjay Mohan wrote:
> > perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
> > cpc->task_epc is only non-NULL while a task context is scheduled in on
> > this CPU. __perf_pmu_sched_task() therefore always passes NULL:
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
0
> >   pc : armv8pmu_sched_task+0x14/0x50
> >   Call trace:
> >    armv8pmu_sched_task+0x14/0x50 (P)
> >    perf_pmu_sched_task+0xac/0x108
> >    __perf_event_task_sched_out+0x6c/0xe0
> >
> > Pass &cpc->epc instead. __perf_init_event_pmu_context() sets its ->pmu
> > when the PMU is registered; ->ctx stays NULL until a CPU-wide event
> > attaches. That is enough here because armv8pmu_sched_task() is the only
> > in-tree implementation that dereferences the argument at all, and it
> > only reads ->pmu. The oops therefore needs BRBE, which arrived in v6.17=
.
> >
> > Fixes: bd2756811766 ("perf: Rewrite core context handling")
> > Cc: stable@vger.kernel.org
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/events/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b282de3e7d7ca..9815894b67e77 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3907,7 +3907,8 @@ static void __perf_pmu_sched_task(struct perf_cpu=
_pmu_context *cpc,
> >       perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> >       perf_pmu_disable(pmu);
> >
> > -     pmu->sched_task(cpc->task_epc, task, sched_in);
> > +     pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
> > +                     task, sched_in);
>
> This can be written like: cpc->task_epc ?: &cpc->epc.
>
> However, if cpc-task_epc is always NULL, then this all seems like an
> overly complicated way of writing: &cpc->epc. What gives?

Nothing, you're right, it should just be &cpc->epc.

I wrote the ternary expecting patch 2 to make cpc->task_epc reachable
here, but it does not.

Will fix it in v7.

Thanks,
Puranjay
