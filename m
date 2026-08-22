Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B133A71A
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439956; cv=pass; b=PHQ08oz0Nrr2m1D/GSKl7BkRkKA+WkfMA/Vr+z++msPutwGXZUXcpofQyhF/akt6W3PIPHe51/UybsIsjyA6YhvzgnluvCQaKKSux7xMj4+13yhmgxpXgNJQwufvuDqXzYvgNOqlPGgMwylfiQHbkhmNppKSVt5AtzsA01zL2XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439956; c=relaxed/simple;
	bh=UqnduKFL2EbeAMHusd31PGewkBZnevh95wDwasLzMdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIWRlTpY2G16sT5m4u+hRjDCY+nTYx6AdJiCa/aXnmCgKLd5gNuqCbOZUAWRHD40LJJkZoHYaOPjZm08Hlf2tP3VhMvNlZX+ozA4sm5VmmhgGv6vCtOd63F/k6WelSRA3P7O28VXAZ7E5fJ6YpPU+Jkkco3IlWAsAVXxCGWVPBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=l3vpH/Yt; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="l3vpH/Yt"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c74722e27so32568001fa.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 16:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787439952; cv=none;
        d=google.com; s=arc-20260327;
        b=gJAKMYLhmBV5QQstVY7YdAopM1jTKHG6Opv/OTzeWKZxr2P532aZ5O/uuDGmuBj9gP
         HXsV0w6GFytdBOVq99fqW1c00aREHMzsWGIfp52JMk1621F3WLh0DezzWm1fXZGRpqJZ
         jlMOUyRv3stSEnv73ydCh4YJ+P/W8PAQNHHIS4E3+nBqfdBMVja3weIjtQI3KT9fsE8L
         YtRdn/KTKB5upQz+arVcDGyjzQPKon5bOX415xpR4ciTgADeCu6qSlTK6YSs2MPGJa12
         wjg7kwDqly2Uy2Y71QLLBgS0iJOVrhxvPsRmDszMSb6IqVy05heC/dM39473nVy4jinM
         pwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fy5rnWq1kDaaG2oX4KMDDzKQA8TMmgosJ6lz3AIHqbI=;
        fh=ZY7vXvLGyBjlO/9TBUVkKMnIAlmWVr3TIEik6fY9K3Y=;
        b=iMNZ/icxUf3L73c6qlbxsvJvoXwsBoKtuxYsOOcoR0K4mOmYbsNPhcdWIgNjDzuIak
         GhErJY1GU1YqtvGnnFQUUDaYQabR4WK3YCHhd2qipn4aLMoYUfAqi86UrNTM91M5CPhn
         UjYYOa4IFJqMgXKrIyX+Xsl9zhPZNgGUspScdtPeOtqXO7jY0tWBx8DB799iG3R8mHel
         yemgo2PlLLjTST6x+jvICnZFWnZu7S38TaWbtfyjySbjxwt9J7hTQ8FDtas1ABNFgFFu
         2vozeq9oR2vYVnQJ7KiwUkja2kAs4xLlp4/GqWvUElJ+8BPqhuOhCnK7bmqZ77B4Eb3u
         xElg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787439952; x=1788044752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fy5rnWq1kDaaG2oX4KMDDzKQA8TMmgosJ6lz3AIHqbI=;
        b=l3vpH/YtlHBCXJLFJadodQE49/8elsxLCMPWwbtnvh9O984PTIscVFO8JMcD1WokDR
         dqfXFKKBffyQsemLK5Nsn/6B99yQQ0fIKVYA8poV7cph/PgU5bI3epFYXXV9xJf3udFm
         78ZNko/8IgKAqYjGKLWfDiidTHCRexP3zhtOh9Jj+hVKZo2wNvHQiDm9q9KYwlmVZ6Fq
         xDT2B42y2ZAZziDzAA5Zh2Y9l+TWG6fu/wg1GRnluNRShnyswqceo04ez6MN03x6u2mw
         cFNfkP5ovjP+Azl7d6681YLgBsz2EO6DuMUgXW+JJfYcaCvNRKLJ7Og4hi1PULzA1iBM
         VULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439952; x=1788044752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fy5rnWq1kDaaG2oX4KMDDzKQA8TMmgosJ6lz3AIHqbI=;
        b=Ua2VCRpJgGZWH5wI0bfjbWE8PHGLgZ9HxJBeGlGMAW7t5C7/gmquCKRi/Y8yx5TI+K
         Tsx3xcS3vwamGCMWvSkNSJyebN5noWG2IuFQuRgrS5ENq/d26+IJqA2sCtqPwPj5mbVE
         0F9yxLnNHc8XhIn/k2x22I63FVNmyoP8KY5ls+see+rnwrLq5yLRKCJ34MIh4YfSmcLU
         30q3RtAevQM6Foy6BL6mCQE2S3xXP+LrpEar7FyRAQgSwmcBkuxIZMbGnZ8KKgurRbfm
         o3ECZCC6G3Fnua5cicWvNi+yyUDdRqBe3hicdpjJzAFFEWRnWAksZ6BdQD10Gu4KJ8zp
         vHxw==
X-Forwarded-Encrypted: i=1; AHgh+RprGCC6L3YbiumeULXouy39lySWn835KMbFgSFpMlWCPoVAwbhOO2TasXM8Uz40vmWwMIcW9jY=@vger.kernel.org
X-Gm-Message-State: AFuF++kS4FYXxArg73V7uxFuADHLxwgVaIAp5qIXxxpXGqRR+n61revt
	hFazDquxRCtLCdjqi9b1YfNxpayPlI4PZiQjVduSYoQ59uthexPhcO0RUYOKx4NNmf3erXLxljn
	0xy1fCG4w8LKtlyp9rnPeBf6D20vdxvt3x9sU+Y5N7w==
X-Gm-Gg: AR+sD10NAF6dgbCrY1+KPH3GFRqkS6fj6Yor480teq+kMQ0l5FyXiUmIUtohEywLvOa
	z5NQ98PjeANMmMXAXIODRSwiOR3GEHCfOvLR0VfM+dpD98d3M3yP5mX4olkNHNVXhq/iMXrZB6x
	JIsGegNHI3RCO+hEVIYviJtT7JYUKu3aT8Xr9ogA4N5N3KJtVMj5y3aPj3tM1zHRO5La3fkKfHT
	sSfhPbmZ/GN8ZG02I7MELxrTc7tTuBfar2PRlixGVr+EX6zOFXK1AQ3137beRR2gv7PdlGSfd/T
	Rj6bYs3h7ITsBGLdLWDbVolTsdjUoa0lydMPQmY9zETs8EcN2zBO6/CGKjRax6B04yDCB83/wY6
	mPTU=
X-Received: by 2002:a05:651c:1508:b0:3a1:749:3031 with SMTP id
 38308e7fff4ca-3a1b0a79fdbmr22421211fa.0.1787439951826; Sat, 22 Aug 2026
 16:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818203234.1142913-1-simon@swine.de> <CAEf4BzbkKwM-uwc1=o2p2v-bjuYNxM++La8Gr5edv5H6sGGqDA@mail.gmail.com>
 <aooIR-oRaN4iIQRy@krava>
In-Reply-To: <aooIR-oRaN4iIQRy@krava>
From: Christian Simon <simon@swine.de>
Date: Sun, 23 Aug 2026 00:05:40 +0100
X-Gm-Features: AcwNN1Vv-nf0VBmihVMfV-S3aCvE9tNB2MNJNhpZKzPLBL03QOqHYXXBhMbep4c
Message-ID: <CAE_y42AS2egu9athNHmqSYVP7wc8E4fhLg5T51tDTVx6QL3LMQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack corruption
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	yonghong.song@linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Aug 2026 at 21:36, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Aug 21, 2026 at 11:06:16AM -0700, Andrii Nakryiko wrote:
> > On Tue, Aug 18, 2026 at 1:33=E2=80=AFPM Christian Simon <simon@swine.de=
> wrote:
> > >
> > > Eligible BPF programs use one private stack per program and CPU. Both
> > > bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_disable=
()
> > > to keep an invocation on one CPU, but another task can still preempt =
it
> > > and run the same program on that CPU. The second invocation then reus=
es
> > > and can overwrite the first invocation's private stack.
> > >
> > > Protect each real program invocation with the existing per-program
> > > recursion context. When the program is already active on this CPU,
> > > account for the missed invocation and skip it. Return zero when skipp=
ing
> > > an uprobe-multi invocation so session handling does not suppress its
> > > return probe.
> > >
> > > Skip dummy_bpf_prog in the classic array path before acquiring the
> > > recursion context because its active pointer is NULL.
> > >
> > > Add a regression test that pins two threads to one CPU and overlaps
> > > classic and multi uprobe invocations while preserving a sentinel in a
> > > private stack frame. Without the guards, the second invocation execut=
es
> > > and corrupts the first invocation's sentinel.
> > >
> > > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > > Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrume=
ntation/issues/3056
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian Simon <simon@swine.de>
> > > ---
> > > Changes in v2:
> > > - Address review comments from sashiko-bot
> > >   - Guard the uprobe-multi path as well.
> > >   - Remove const from correct line
> > > - Add a regression selftest for uprobe-classic/multi paths.
> > > - Add the arm64 Fixes tag.
> > >
> > >  include/linux/bpf.h                           |  33 +++--
> > >  kernel/trace/bpf_trace.c                      |  11 +-
> > >  .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++++++=
++
> > >  .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
> > >  4 files changed, 206 insertions(+), 10 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_pri=
vate_stack.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_private_=
stack.c
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 7719f6528445..a94fc9898ece 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struct bp=
f_run_ctx *old_ctx)
> > >
> > >  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const vo=
id *ctx);
> > >
> > > +#ifdef CONFIG_BPF_SYSCALL
> > > +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> > > +#else
> > > +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog=
)
> > > +{
> > > +}
> > > +#endif
> > > +
> > >  static __always_inline u32
> > >  bpf_prog_run_array(const struct bpf_prog_array *array,
> > >                    const void *ctx, bpf_prog_run_fn run_prog)
> > > @@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog=
_array *array,
> > >                           const void *ctx, bpf_prog_run_fn run_prog)
> > >  {
> > >         const struct bpf_prog_array_item *item;
> > > -       const struct bpf_prog *prog;
> > > +       struct bpf_prog *prog;
> > >         struct bpf_run_ctx *old_run_ctx;
> > >         struct bpf_trace_run_ctx run_ctx;
> > >         u32 ret =3D 1;
> > > @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_pr=
og_array *array,
> > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > >         item =3D &array->items[0];
> > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > +               /* dummy_bpf_prog has no recursion state. */
> > > +               if (unlikely(!prog->len)) {
> > > +                       item++;
> > > +                       continue;
> > > +               }
> > > +
> > > +               if (unlikely(!bpf_prog_get_recursion_context(prog))) =
{
> > > +                       bpf_prog_inc_misses_counter(prog);
> > > +                       bpf_prog_put_recursion_context(prog);
> > > +                       item++;
> > > +                       continue;
> > > +               }
> > > +
> >
> > I think it's unacceptable to skip sleepable uprobe execution just
> > because there is the same BPF program attached to a *different* uprobe
> > (and all due to a private stack that no one asked for or needs for
> > uprobes, really).
> >
> > As a short-term fix, we should probably disable private stack for
> > sleepable uprobe/kprobe program (and tracepoint/raw_tracepoint), and
> > think how we can make private stack less per-CPU dependent.
>
> +1 for disabling private stack for uprobes
>
> thanks,
> jirka

Thanks for your guidance. I have just posted v3 of the patch set, which
disables private stacks for sleepable programs.

I am still unsure why non-sleepable uprobes would be unaffected. On a
preemptible kernel, their execution paths use migrate_disable() rather than
preempt_disable(), and rcu_read_lock() does not prevent preemption with
preemptible RCU. It therefore seems possible for a task to be scheduled out
while running a non-sleepable uprobe, after which another task could invoke=
 the
same program on the same CPU and reuse its per-CPU, per-program private sta=
ck.
Am I missing another mechanism that prevents this?

Cheers,
Christian

---
v3: https://lore.kernel.org/bpf/20260822225444.2774461-1-simon@swine.de/
