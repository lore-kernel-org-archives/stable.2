Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABFB334C39
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682318; cv=pass; b=lBoiYGNG12VX8rGaVH3x/HcakjyXmuGf3tCeRLMqh8hQ+VIbs2HyfnbV0EMw6zKjA7e+9tKWxtgPbUXg9wKWaO1cS9lTX9OgD00eesvZr7axK/jFpCREu8aLKYJIP0hCKeCR3LCqdPy3P7JzuvBEjaf1PVUbsCXqZsyTh/btRQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682318; c=relaxed/simple;
	bh=edvAyAV2B7rRFLTXUn3ZaH2JUJ3C/Mmk1zUbHa27RwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lG6tCIPM4q0Xzb4wLwvbldI5GpjS5FqTZwBpc3CYpEi+pWgj6Lb8TofgVcOoyucTwcYylwp/N3HHCBwCWMrBlqGHZWg1lj+hwMXBkvVyZBdPjp81hBVGuhe+dsy0MrQUXQn4EaLp21nIM1Z59Ti8X0fH0wUSy/2bGOYAE+54fNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0yKpFPP; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0yKpFPP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8535a9be75eso154413b3a.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682317; cv=none;
        d=google.com; s=arc-20260327;
        b=o1QP26BqKS3/p7iAMn5tg7dKAUlBdC9yAw0bQnNOgpOEIRk4G8VbGwAb9yxGVJXlja
         ps7xeWv8AKcxazY4Y5Cf1tHDIYAuysytpWLRbsZSz5omzRBYdpq0+fr53D1C1TquSnCW
         PQd7KP21/+jGPFuJPt8/3ka24T7g6PbH18Z19OoTN4Cv6QxizxJSF0h1+Qw6ythSqzpi
         0kzverTX+WhdTDOBqjlzwJWO83v3Zbt8+iAMg0SpjwBov2/4OU1Wj8GPm0oKxqKnf4F7
         fLjPEt2Gnt9zNnc5JKAVDnHg+F6JdIXkrscGcqT4Y4pohDAkVjhyUR37g6nKqjrcwvJ5
         4D6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/1Pr9NkaXBmIiFBKFLsBDr4+QWaBpFdxaq8v2gBmK4=;
        fh=eYJHx5+NXjLbNzPLter/zwC7xImPQAlJ0V9AdoHz5PY=;
        b=jurTcr3WXcXLzJORdNg9kQeaIGyBkQCIrvjeFhw4PI1u+JInaUnMxCzGOeWcm1M1cv
         bD5QqeJGGA5Z5stGY23LzIq0oOM/lb8fHIu8oxe8xpAYmlg/7Hh2gV3TmJbf+cxqroiy
         CWSbx+dZsieU7SNWSzL+HUutGt+ZtZ1RyhHQ5X9pT/eSmAfCGz4Bkgoe7Drcz1P+mGRA
         k/qljNCkZgY2LZ1LJErDk8PIq0Q+byFdtgqjxSFv/F5F1e1oL9MTgkyeUJ1uWUIBpq75
         AsmH8N8gJsPXaqMLMe6jC9liyElK2lH4ASaO3bwYkhtV807EWk1Xs9dZ688US88FZXcY
         /nxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682317; x=1788287117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/1Pr9NkaXBmIiFBKFLsBDr4+QWaBpFdxaq8v2gBmK4=;
        b=h0yKpFPPxRlRjnF+bFM1vrotOykjC2RKUcdR10My1iljuViSBMqb1M0+ZuLGUB+Hm4
         KFzkkUdeXYLKXhS2ltrbc8hJ1ndKXS3C4ZPXwZ688iMh99e3peHgFwkZ/DnASHorixFo
         /kEXXoNH4PDEmCnsH2puwPQwsb3lR4S9rb1ULL1AfaVvnSCvyGC/3T5+YyXkfsGfh7Ye
         IwGeyKS/1LGUuKdQA7rPImpIg9iq8+ClF4KQL0G2dfwKu7g1M7TPwIFlkQN9VpSiIGSH
         HHoFzOekZomYmgWeOd0xQ7XcsEpUPZEGJAMBJ607sg5QZ8cB/YXPZwKyVVmvr0QHhqLr
         gIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682317; x=1788287117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/1Pr9NkaXBmIiFBKFLsBDr4+QWaBpFdxaq8v2gBmK4=;
        b=r/KfseAJr4kcp94kFVsnefeHzN8EQI2njJF6VaF6BFMi8qJQhsmgu3n8mm99vgI29U
         CWlxejMWbldmb94/G1JBS1pQefWCcZlQqqG8k+NH2eT8fNaKvTdcHqzXp29Q8wV35KIk
         +0vM0KXEIa6ANkKQplIKdCeZxXo2YiD35mnuWttFRp8XvWhXfSHaUZ44KOXcyQ4oZaPZ
         ketlSsD1uFkqS4QkoxsbpySsYf1ek3i7kK9D6EBvrPrnmYNqxCt6vTNTRDW6mQudlE5t
         Rjj3NfVDpGgH06T0Bkod6njL/tXS7H3+e6cAuhDAEKeZvuOYbBn5lqR3Twdxi9+kMhX9
         cx5w==
X-Forwarded-Encrypted: i=1; AHgh+Ro4rqCoVmhxv64vYQOL8aDBlxBQOHwl+eg9Iyv/nNdEDjNTeJH9iSAcPRHdfEyu2NBqoOl6fF0=@vger.kernel.org
X-Gm-Message-State: AFuF++lVViY78dNbRxtc+ScT5Q0hX55tOBTCXemWhVUYmIKuqElWkDfU
	92eWSD3QAzD4/0UB3NBfPWdJRQE39OMKI2HTSeH+HwE3UKLPsL+KOai1Dpwsgyk6jhEYbadAs6G
	BvqtYoiBuPFtVfS7jzlmtHdHfb8/TVg8=
X-Gm-Gg: AR+sD130gMfCQFhjpKvT8aHPII00zsJ8g0i6c8sVvwhIuPvnM5tbLhIO7psy+Cr8ffk
	KwDhhjwCbKTBKfJnNPFJTdSVqp9jIG4kxSiY1WLgJhPZ85s/X1N7XS9OGj9VTNuh/PHAgX9jH8m
	Ddu94l9ijR9i7EcucFqxfvcQJHaiXv+ZZPtXD2UHeeQjzYwjbB+0MvgmDYgAmZbrOYHi3nvqgOr
	MZrZlYLBTXZ+dqxSthuSkn2pWl3VednbjEcZ8NVHWlB5mBEFjGhT6ZElGcAZtHPnpspZmMyX8Nf
	0EYIix61TiVjSMklFUPJ2zz/ASjV8WvXClSUGJJhuwVgFMZiKwM1W4ktx1WX3DTf77Bpzly1Co/
	x8pAHyt/uZXvrF/GTi8OdNwUYWrTJQht0t/88OQP/PA==
X-Received: by 2002:a05:6a21:4514:b0:3c3:88a5:83db with SMTP id
 adf61e73a8af0-3cf7607aa02mr845026637.5.1787682316507; Tue, 25 Aug 2026
 11:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818203234.1142913-1-simon@swine.de> <CAEf4BzbkKwM-uwc1=o2p2v-bjuYNxM++La8Gr5edv5H6sGGqDA@mail.gmail.com>
 <aooIR-oRaN4iIQRy@krava> <CAE_y42AS2egu9athNHmqSYVP7wc8E4fhLg5T51tDTVx6QL3LMQ@mail.gmail.com>
 <ao2f-rBgT0SqX6Pw@krava>
In-Reply-To: <ao2f-rBgT0SqX6Pw@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 11:25:01 -0700
X-Gm-Features: AcwNN1Ubykf5Gnf0-64UjfJ-P4ZUe9OrImEiLJNVde-Q11fNcy5dc189CLBU-Ag
Message-ID: <CAEf4BzZfQwOTS8HGryFR0V7FKxtAbbs=qe+2eYk=RTj7gNK09Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack corruption
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	yonghong.song@linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:00=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Aug 23, 2026 at 12:05:40AM +0100, Christian Simon wrote:
> > On Sat, 22 Aug 2026 at 21:36, Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Fri, Aug 21, 2026 at 11:06:16AM -0700, Andrii Nakryiko wrote:
> > > > On Tue, Aug 18, 2026 at 1:33=E2=80=AFPM Christian Simon <simon@swin=
e.de> wrote:
> > > > >
> > > > > Eligible BPF programs use one private stack per program and CPU. =
Both
> > > > > bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_dis=
able()
> > > > > to keep an invocation on one CPU, but another task can still pree=
mpt it
> > > > > and run the same program on that CPU. The second invocation then =
reuses
> > > > > and can overwrite the first invocation's private stack.
> > > > >
> > > > > Protect each real program invocation with the existing per-progra=
m
> > > > > recursion context. When the program is already active on this CPU=
,
> > > > > account for the missed invocation and skip it. Return zero when s=
kipping
> > > > > an uprobe-multi invocation so session handling does not suppress =
its
> > > > > return probe.
> > > > >
> > > > > Skip dummy_bpf_prog in the classic array path before acquiring th=
e
> > > > > recursion context because its active pointer is NULL.
> > > > >
> > > > > Add a regression test that pins two threads to one CPU and overla=
ps
> > > > > classic and multi uprobe invocations while preserving a sentinel =
in a
> > > > > private stack frame. Without the guards, the second invocation ex=
ecutes
> > > > > and corrupts the first invocation's sentinel.
> > > > >
> > > > > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > > > > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > > > > Closes: https://github.com/open-telemetry/opentelemetry-ebpf-inst=
rumentation/issues/3056
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Christian Simon <simon@swine.de>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Address review comments from sashiko-bot
> > > > >   - Guard the uprobe-multi path as well.
> > > > >   - Remove const from correct line
> > > > > - Add a regression selftest for uprobe-classic/multi paths.
> > > > > - Add the arm64 Fixes tag.
> > > > >
> > > > >  include/linux/bpf.h                           |  33 +++--
> > > > >  kernel/trace/bpf_trace.c                      |  11 +-
> > > > >  .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++=
++++++
> > > > >  .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
> > > > >  4 files changed, 206 insertions(+), 10 deletions(-)
> > > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe=
_private_stack.c
> > > > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_priv=
ate_stack.c
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 7719f6528445..a94fc9898ece 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struc=
t bpf_run_ctx *old_ctx)
> > > > >
> > > > >  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, cons=
t void *ctx);
> > > > >
> > > > > +#ifdef CONFIG_BPF_SYSCALL
> > > > > +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> > > > > +#else
> > > > > +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *=
prog)
> > > > > +{
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  static __always_inline u32
> > > > >  bpf_prog_run_array(const struct bpf_prog_array *array,
> > > > >                    const void *ctx, bpf_prog_run_fn run_prog)
> > > > > @@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_=
prog_array *array,
> > > > >                           const void *ctx, bpf_prog_run_fn run_pr=
og)
> > > > >  {
> > > > >         const struct bpf_prog_array_item *item;
> > > > > -       const struct bpf_prog *prog;
> > > > > +       struct bpf_prog *prog;
> > > > >         struct bpf_run_ctx *old_run_ctx;
> > > > >         struct bpf_trace_run_ctx run_ctx;
> > > > >         u32 ret =3D 1;
> > > > > @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bp=
f_prog_array *array,
> > > > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > > >         item =3D &array->items[0];
> > > > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > > > +               /* dummy_bpf_prog has no recursion state. */
> > > > > +               if (unlikely(!prog->len)) {
> > > > > +                       item++;
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > > > +               if (unlikely(!bpf_prog_get_recursion_context(prog=
))) {
> > > > > +                       bpf_prog_inc_misses_counter(prog);
> > > > > +                       bpf_prog_put_recursion_context(prog);
> > > > > +                       item++;
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > >
> > > > I think it's unacceptable to skip sleepable uprobe execution just
> > > > because there is the same BPF program attached to a *different* upr=
obe
> > > > (and all due to a private stack that no one asked for or needs for
> > > > uprobes, really).
> > > >
> > > > As a short-term fix, we should probably disable private stack for
> > > > sleepable uprobe/kprobe program (and tracepoint/raw_tracepoint), an=
d
> > > > think how we can make private stack less per-CPU dependent.
> > >
> > > +1 for disabling private stack for uprobes
> > >
> > > thanks,
> > > jirka
> >
> > Thanks for your guidance. I have just posted v3 of the patch set, which
> > disables private stacks for sleepable programs.
> >
> > I am still unsure why non-sleepable uprobes would be unaffected. On a
>
> I think we need to disable both sleepable and non-sleepable uprobes
>
> problem is that we can't say if kprobe program is going to be attached
> as uprobe or kprobe, so we'd need to disable both kprobe/uprobes, which
> I'm not sure is a problem
>

I don't think it is, private stack is most critical for struct_ops
where we can have intentionally recursive calls (sched-ext had/has
such use case, I believe), I think it's much less of a problem and
risk for normal uprobe/kprobe (and other tracing programs for that
matter)

> I don't see how tracepoint/raw_tracepoint are affected by this problem,
> because they have either retursion context or bpf_prog_active check
>
> jirka
>
>
> > preemptible kernel, their execution paths use migrate_disable() rather =
than
> > preempt_disable(), and rcu_read_lock() does not prevent preemption with
> > preemptible RCU. It therefore seems possible for a task to be scheduled=
 out
> > while running a non-sleepable uprobe, after which another task could in=
voke the
> > same program on the same CPU and reuse its per-CPU, per-program private=
 stack.
> > Am I missing another mechanism that prevents this?
> >
> > Cheers,
> > Christian
> >
> > ---
> > v3: https://lore.kernel.org/bpf/20260822225444.2774461-1-simon@swine.de=
/
