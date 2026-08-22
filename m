Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D57080D
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430992; cv=none; b=VuCbTpaSHNFWXL2zykhqpiZ699EXw0P254VhWqJZ1Zp/6kNLYKw/6ioMtP1Zq0bjrAcsZ/JhBY4OOLPrrCslgAVagA/VudnJCSX3tZUfgAL8CJVFRfmF69W67nUzTKA9HW0LTh6w1KLIT+auv/24AxNzCbdg0LUAnCkQssiGnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430992; c=relaxed/simple;
	bh=y84m+Iu6nf8xbQGAGvRfeWE/Tk4zPD83obV04xpLUEs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv2FazPUWPX2X/SPFkFkSCGOVNuZVYHSnkJ7LGs6lpaInflUULNxZ7ZOi21gUeIQpa2pqy785e31wJtpuRy4LDm8D1ncYnB1OTv0ylKpqb1394pSsOeDxCJzVjNOH+Wa4RHRDQY88IeUdeAQOCppyPz5KTeXVrV42aamLzdPuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwiHoTgR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwiHoTgR"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so341100066b.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787430989; x=1788035789; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RyREFcSp6THOZZUr0JcrJj2oyrnhg8hVm6f454iOlGo=;
        b=DwiHoTgR/et7kcSjVK/cB7go13uNGRThlOcwArZnu0KjseALrJvTX1nXm2EKSnYTX8
         q7qxsVc1V+lfQPpV3XCyC/WuOGFmcXZsiJ/Bm4Mpv5Q7p/V/SHLXi8qCwUepc3oD+4Ow
         QdJJHxXRQlYjw6LwqiOtTzwnbVcsaTILJ66wipsP/ANvozInrhg1OxnWI9EzWekujcEs
         WJUevpC/hwCiw5uvcaIQR6a7BseBkbYKE4wB3GYUJNsMWTsN41OgCrLgiFfktt716Bc0
         uc/1BovnY1MljbW/ff1bMV5P5zvWjrRlKVGLpvZ7vCEzjQrbxQiJccXHs0YvCTRt0Ho7
         rBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787430989; x=1788035789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RyREFcSp6THOZZUr0JcrJj2oyrnhg8hVm6f454iOlGo=;
        b=UjHkjREvrmhT7LSy8kj/Up1elzFvdf+13zi6zjzmK8E1+w4IZUjS13rAsZCmq2iEOv
         hv6eFB6gzFG570OhAc3cS3P39p42ImKm0fxhGM2ArD/gl9SKY3UK7reSuYfU6r2j3qHu
         P9DIXzIZcXCo5BLOEllY2dmeBoxNPrSpVX1vNtjyzSs8SqExK9A5kJ8wj4SQECJtrjZ7
         pl0NtMZRkvFKdo/enEIKGmTyFGDrn/y0knjoFM4TbmJqt0o/qWFyvEAzUNve4djwGWcX
         4T+tUdUF2/PoEEmPXEqT8tRR7DOWwf/8I0ayw0+BrTmrF0VGepQknZgsxV9QkK29SSOi
         nwcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrY8NhVoLCh05odXMe243gKgAuwMUsGg5LMuXsXC1pXB67G5eocOKtuWCI+Wux0JINVpMTwkqg=@vger.kernel.org
X-Gm-Message-State: AFuF++na7V2GGq+h6pXVwlJrpTPsEHhzeIIR/3wMnNGUtx2XTAHaHXGz
	eoBpJEcz3g31s5RebEErv1Fd1iZh4cMX6NTbpb0mMNwTaRRiR5696Kts
X-Gm-Gg: AR+sD10aOVbnEkLCoRH8M0HBCvrMTuqzcwWKTyJ2N19M2DQy7wPA4yeiEKswApy41Ki
	v2ejwygJ5m9o1JPB+OK7upm8h2LuDAdZS/vAAGQcSRl51TYLsJLYpmr4srGlZMMsYGCMWRHt8GL
	osRDVonEKc2STnExGBnQL+oqCnK93ScNaDTU6vweKJ3oHXuByFXu2xZMirf1zuqmg1WnO+6pkLt
	p0JotbhHspq6Of5dqc0/JT/zlQS5mAd46uP15eJXR/4CUS6kdPxG01MFt5NjMEMf3bNuhDDS9xr
	CH629LWUggsix37ME7AjXwoicPzmC/gY/48+hXeaHbOHxd/kdVFqnUUODBx1UZ9MeUEonOV04Jf
	djjwg3llgC1ABVJFezhHKMnFsHWNwEPiyDATgX1/tr5loUSXyb+lSyAIpyBQBS1GfS0LAdaEZsi
	C/uzvdDm3e6IGPIIPZCCURyEmgkSf7dkM2Ck2aZI3rvCOK2wnDuSdUUjdQUn97y35PmWnl
X-Received: by 2002:a17:906:9c93:b0:c24:6687:bf6a with SMTP id a640c23a62f3a-c2492663ee3mr809408966b.21.1787430988946;
        Sat, 22 Aug 2026 13:36:28 -0700 (PDT)
Received: from krava (85-160-35-241.reb.o2.cz. [85.160.35.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967383e5sm453691566b.45.2026.08.22.13.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 13:36:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 22 Aug 2026 22:36:23 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	tj@kernel.org, yonghong.song@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack
 corruption
Message-ID: <aooIR-oRaN4iIQRy@krava>
References: <20260818203234.1142913-1-simon@swine.de>
 <CAEf4BzbkKwM-uwc1=o2p2v-bjuYNxM++La8Gr5edv5H6sGGqDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbkKwM-uwc1=o2p2v-bjuYNxM++La8Gr5edv5H6sGGqDA@mail.gmail.com>

On Fri, Aug 21, 2026 at 11:06:16AM -0700, Andrii Nakryiko wrote:
> On Tue, Aug 18, 2026 at 1:33 PM Christian Simon <simon@swine.de> wrote:
> >
> > Eligible BPF programs use one private stack per program and CPU. Both
> > bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_disable()
> > to keep an invocation on one CPU, but another task can still preempt it
> > and run the same program on that CPU. The second invocation then reuses
> > and can overwrite the first invocation's private stack.
> >
> > Protect each real program invocation with the existing per-program
> > recursion context. When the program is already active on this CPU,
> > account for the missed invocation and skip it. Return zero when skipping
> > an uprobe-multi invocation so session handling does not suppress its
> > return probe.
> >
> > Skip dummy_bpf_prog in the classic array path before acquiring the
> > recursion context because its active pointer is NULL.
> >
> > Add a regression test that pins two threads to one CPU and overlaps
> > classic and multi uprobe invocations while preserving a sentinel in a
> > private stack frame. Without the guards, the second invocation executes
> > and corrupts the first invocation's sentinel.
> >
> > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/issues/3056
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Simon <simon@swine.de>
> > ---
> > Changes in v2:
> > - Address review comments from sashiko-bot
> >   - Guard the uprobe-multi path as well.
> >   - Remove const from correct line
> > - Add a regression selftest for uprobe-classic/multi paths.
> > - Add the arm64 Fixes tag.
> >
> >  include/linux/bpf.h                           |  33 +++--
> >  kernel/trace/bpf_trace.c                      |  11 +-
> >  .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++++++++
> >  .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
> >  4 files changed, 206 insertions(+), 10 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_private_stack.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_private_stack.c
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 7719f6528445..a94fc9898ece 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
> >
> >  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> > +#else
> > +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
> > +{
> > +}
> > +#endif
> > +
> >  static __always_inline u32
> >  bpf_prog_run_array(const struct bpf_prog_array *array,
> >                    const void *ctx, bpf_prog_run_fn run_prog)
> > @@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> >                           const void *ctx, bpf_prog_run_fn run_prog)
> >  {
> >         const struct bpf_prog_array_item *item;
> > -       const struct bpf_prog *prog;
> > +       struct bpf_prog *prog;
> >         struct bpf_run_ctx *old_run_ctx;
> >         struct bpf_trace_run_ctx run_ctx;
> >         u32 ret = 1;
> > @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> >         old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> >         item = &array->items[0];
> >         while ((prog = READ_ONCE(item->prog))) {
> > +               /* dummy_bpf_prog has no recursion state. */
> > +               if (unlikely(!prog->len)) {
> > +                       item++;
> > +                       continue;
> > +               }
> > +
> > +               if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> > +                       bpf_prog_inc_misses_counter(prog);
> > +                       bpf_prog_put_recursion_context(prog);
> > +                       item++;
> > +                       continue;
> > +               }
> > +
> 
> I think it's unacceptable to skip sleepable uprobe execution just
> because there is the same BPF program attached to a *different* uprobe
> (and all due to a private stack that no one asked for or needs for
> uprobes, really).
> 
> As a short-term fix, we should probably disable private stack for
> sleepable uprobe/kprobe program (and tracepoint/raw_tracepoint), and
> think how we can make private stack less per-CPU dependent.

+1 for disabling private stack for uprobes

thanks,
jirka
