Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09F45DF6B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666434; cv=none; b=Owg8I/gdYt7fZjTrmpcUSd3M/Zy2btfXf2SdPgguU+cnBQp2bcKCRLC1/1uyuV+mkA28sWq+IHbc/f2E0vcRx6hN49eh4p9DhQnWcVN3IQAwoVDwpDsNir/rEmpfJJqlsE8M/sx+JHxlxrij9ysdX3MnRGjb3mGo7qfHQWVRuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666434; c=relaxed/simple;
	bh=WL6G5fRip4zwHjSNpHlb7Hhgnbv9hopZ3aOL7VY3lBg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3tNqs88h6kDPH6nojuk6UXruHb0KGd8jtvC2OX2f/6WJoq2ReQhi4xBiqcznBrjrjT3npzsX2PY++9NY/X/SIKkcBd8S6jP8n6xT/3194uUrbaVEL/3YEtVmrDfwgIcHSwIIudZEvwDbL6B67nFmYb+FkfeXcxQG9NfnNCbbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHEZWHu1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHEZWHu1"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1600d040e4so132112066b.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787666431; x=1788271231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qsh0KNYqBVy/sX3rRgWdY2x2iy5n6QfKTwdmTWIU4kI=;
        b=eHEZWHu1aRgDkebNgc8jGAJpte2URzhvpkPhWmV1pwTi338A6pX+0M+cqXnLqLtVrA
         olnk+Joif16qnvk4xoRMBHJ/nyVZlOtLk2JsAUhfMTeTjk5dcR4qLD5VOpVXjXV8vcF2
         Ws+8K8W2URttrHfoANuDk+31RqRmQpr8ncFFu7iiAV9I+ZTYvcH7QnlmCyOLVDqYtpSn
         3QuVIQ6WAQsvA1dz6VMjbGRW5U8NAOyGFONe/DyqspLyb69dclggiWQxV0eIr4FRpwNY
         PQBaWdp2+mUmFtr7rTk4W204vLFIqmCF4LssSuXCtnXANXcM6X8Vd/dYDj/tCwh90I96
         FiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666431; x=1788271231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qsh0KNYqBVy/sX3rRgWdY2x2iy5n6QfKTwdmTWIU4kI=;
        b=qUNZoAInkEOpWaxhdOAnjhGqVRN3kmj7q8vVLjjpqD1p4T3q9o/kwufXm1pRueev8H
         Q2G80tVAJ3/hQtPLyRXdIOsunq0BNft0yxGNro6AX3tMOhWKgGt9kgMfCxBxMq/vPev1
         9ipRcQZUks+R4ZxSg7WwtbMfvhZ4bklhmCnNbZtx7xh4H/dBL2uo98ZzJRQOvGgDzijh
         67tl3AuixyxlEGMsvj04DfXqSQrw0VI0hY5VAsdV7jj4oBH4zsPa1OOiXTDGrIFQvuEy
         0SaKgkJuAPKQOk+Rix5sJr8OcecIH53+h5Sfssla7SjXSyDjiqoclYjzJZXrxFMNMMlI
         yeMg==
X-Forwarded-Encrypted: i=1; AHgh+RpSgMMXJRfiQMW0gq+ybsJsTyyJIP6AXf+7Q52jw4wb+duNtP+uI6oS8WniW805Ry0Ae/4WLbc=@vger.kernel.org
X-Gm-Message-State: AFuF++l1VsDZ4eaq4/bsKcS/OqCLqR7EG99PukiPaTTFZtjzC/yz2l/k
	hgwfm69J5X+TKfKpXjdo1OxYyKSE5sbJ+1/smVVqyWsVUvulB3AzCxwQ
X-Gm-Gg: AR+sD12D3ivZg/GY9OvG5gC6eFDZvna8+a7eTZFWAJQJtyTBZpPOwprURiV3I5dnCgB
	DbbUB8NBjXe2GetVVqkZve1L2X30JDkELCyWjyEUTlKC8citgn/UGQsvkx+/Kes4Gli55bPUVCZ
	PJNmjxDV0nsRZQbEuUUdIYSWUJEn3Ww3qfCobjE7VZgaJ2HF/DhnK8mNEmnit+Objxin6eijFUm
	9fv7TyydyTMtG1XTldB4RL3IGra2gfbpnrIU7ODXiuyWjkbNxzx888DtMoIOIbaGHJY/dsq3k2x
	BHWlrwfr8ypYn64oCxr5wm3HUiS517d+ZIDcaL0M2AUXR7Go5vrRjDNh5+S/gNrKvISQ5ptYrAK
	qqWzlrrp2HUxJs4l97+cNv8/SInDZr1X6B3ILOmJXov4Ij/0m1aJNGaTznuyDcl3eK15nguw096
	VfG9V9sJx2yue6Px1BsvZWjrNSeC1qr0+zQPiD/Lud75eCWSwYBlaM5yY1sok=
X-Received: by 2002:a17:907:1c0b:b0:c24:bf32:dc57 with SMTP id a640c23a62f3a-c24e2b3a5a7mr734687766b.7.1787666430276;
        Tue, 25 Aug 2026 07:00:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2da49bsm15887852a12.29.2026.08.25.07.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 07:00:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 25 Aug 2026 16:00:26 +0200
To: Christian Simon <simon@swine.de>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, tj@kernel.org, yonghong.song@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack
 corruption
Message-ID: <ao2f-rBgT0SqX6Pw@krava>
References: <20260818203234.1142913-1-simon@swine.de>
 <CAEf4BzbkKwM-uwc1=o2p2v-bjuYNxM++La8Gr5edv5H6sGGqDA@mail.gmail.com>
 <aooIR-oRaN4iIQRy@krava>
 <CAE_y42AS2egu9athNHmqSYVP7wc8E4fhLg5T51tDTVx6QL3LMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE_y42AS2egu9athNHmqSYVP7wc8E4fhLg5T51tDTVx6QL3LMQ@mail.gmail.com>

On Sun, Aug 23, 2026 at 12:05:40AM +0100, Christian Simon wrote:
> On Sat, 22 Aug 2026 at 21:36, Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Aug 21, 2026 at 11:06:16AM -0700, Andrii Nakryiko wrote:
> > > On Tue, Aug 18, 2026 at 1:33 PM Christian Simon <simon@swine.de> wrote:
> > > >
> > > > Eligible BPF programs use one private stack per program and CPU. Both
> > > > bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_disable()
> > > > to keep an invocation on one CPU, but another task can still preempt it
> > > > and run the same program on that CPU. The second invocation then reuses
> > > > and can overwrite the first invocation's private stack.
> > > >
> > > > Protect each real program invocation with the existing per-program
> > > > recursion context. When the program is already active on this CPU,
> > > > account for the missed invocation and skip it. Return zero when skipping
> > > > an uprobe-multi invocation so session handling does not suppress its
> > > > return probe.
> > > >
> > > > Skip dummy_bpf_prog in the classic array path before acquiring the
> > > > recursion context because its active pointer is NULL.
> > > >
> > > > Add a regression test that pins two threads to one CPU and overlaps
> > > > classic and multi uprobe invocations while preserving a sentinel in a
> > > > private stack frame. Without the guards, the second invocation executes
> > > > and corrupts the first invocation's sentinel.
> > > >
> > > > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > > > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > > > Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/issues/3056
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Christian Simon <simon@swine.de>
> > > > ---
> > > > Changes in v2:
> > > > - Address review comments from sashiko-bot
> > > >   - Guard the uprobe-multi path as well.
> > > >   - Remove const from correct line
> > > > - Add a regression selftest for uprobe-classic/multi paths.
> > > > - Add the arm64 Fixes tag.
> > > >
> > > >  include/linux/bpf.h                           |  33 +++--
> > > >  kernel/trace/bpf_trace.c                      |  11 +-
> > > >  .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++++++++
> > > >  .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
> > > >  4 files changed, 206 insertions(+), 10 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_private_stack.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_private_stack.c
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 7719f6528445..a94fc9898ece 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
> > > >
> > > >  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
> > > >
> > > > +#ifdef CONFIG_BPF_SYSCALL
> > > > +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> > > > +#else
> > > > +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
> > > > +{
> > > > +}
> > > > +#endif
> > > > +
> > > >  static __always_inline u32
> > > >  bpf_prog_run_array(const struct bpf_prog_array *array,
> > > >                    const void *ctx, bpf_prog_run_fn run_prog)
> > > > @@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> > > >                           const void *ctx, bpf_prog_run_fn run_prog)
> > > >  {
> > > >         const struct bpf_prog_array_item *item;
> > > > -       const struct bpf_prog *prog;
> > > > +       struct bpf_prog *prog;
> > > >         struct bpf_run_ctx *old_run_ctx;
> > > >         struct bpf_trace_run_ctx run_ctx;
> > > >         u32 ret = 1;
> > > > @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> > > >         old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > > >         item = &array->items[0];
> > > >         while ((prog = READ_ONCE(item->prog))) {
> > > > +               /* dummy_bpf_prog has no recursion state. */
> > > > +               if (unlikely(!prog->len)) {
> > > > +                       item++;
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> > > > +                       bpf_prog_inc_misses_counter(prog);
> > > > +                       bpf_prog_put_recursion_context(prog);
> > > > +                       item++;
> > > > +                       continue;
> > > > +               }
> > > > +
> > >
> > > I think it's unacceptable to skip sleepable uprobe execution just
> > > because there is the same BPF program attached to a *different* uprobe
> > > (and all due to a private stack that no one asked for or needs for
> > > uprobes, really).
> > >
> > > As a short-term fix, we should probably disable private stack for
> > > sleepable uprobe/kprobe program (and tracepoint/raw_tracepoint), and
> > > think how we can make private stack less per-CPU dependent.
> >
> > +1 for disabling private stack for uprobes
> >
> > thanks,
> > jirka
> 
> Thanks for your guidance. I have just posted v3 of the patch set, which
> disables private stacks for sleepable programs.
> 
> I am still unsure why non-sleepable uprobes would be unaffected. On a

I think we need to disable both sleepable and non-sleepable uprobes

problem is that we can't say if kprobe program is going to be attached
as uprobe or kprobe, so we'd need to disable both kprobe/uprobes, which
I'm not sure is a problem

I don't see how tracepoint/raw_tracepoint are affected by this problem,
because they have either retursion context or bpf_prog_active check

jirka


> preemptible kernel, their execution paths use migrate_disable() rather than
> preempt_disable(), and rcu_read_lock() does not prevent preemption with
> preemptible RCU. It therefore seems possible for a task to be scheduled out
> while running a non-sleepable uprobe, after which another task could invoke the
> same program on the same CPU and reuse its per-CPU, per-program private stack.
> Am I missing another mechanism that prevents this?
> 
> Cheers,
> Christian
> 
> ---
> v3: https://lore.kernel.org/bpf/20260822225444.2774461-1-simon@swine.de/
