Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45A20C029
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849723; cv=pass; b=Afj7JYtrQ9abxw6aktOBs0xN+cR6gKYrfAZn+DCgKfYlmZxjR7chQUdz19KjnMNhphVDDgo6vFLDuI/qHmqGQwr+F4cCEvZz0SCEeFTahCPSJyTJN2rzn2tNJSOHOofazCdIWZlzxa4xV7UPRP7SLN8QELDX0XHYU/yYewAfCW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849723; c=relaxed/simple;
	bh=FcmsiJdsM6FOny/oatYZLhV8FSoSl85nDji8uo8ja98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjwQc49rjepE8xo1+HQ9zivW0WDvndaNVZqZfbtHf9PqW90zGJKmBIETdPdoE1KsAhQ1e89GpvXIWIwgzPzRM9K9Hww1VrsJJU5DuyDbdr/y5xmUxUnhrvvgXRKDNeig5HZJCKaEmtPCo/JcViNAEuHsmz8TB0Ve8Jq/MktXHXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2KvPhVJ; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2KvPhVJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca12086c06eso104122a12.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787849722; cv=none;
        d=google.com; s=arc-20260327;
        b=qktBZYOHYwjuxHDt8IKcNnOKsumvnJtYq/LdKRa/tGA1zBHvcbMVXkhEZBbPsWUzdT
         8hHTRrEUBG7jbfoFp5B3aIxdQKOywftSgGWRGn3d9kWNCQuatsIQEPYzxgnbMxpqloY7
         hE+hnqMgynaHgH/105gZ1pNJDNEUKfPwiMHAANpyCWlbcVmjDJ8sLERc5debEDWHJcT9
         8r/Pe5I1q7c3VxbT8CSCq7EjvlUuimZwHoe+050DwI1xzNT+6W6tH8jovaKqg9r0PQ73
         QIvzKS74TZ6cnHi2+thTC5rR2iKSUEJStBHW/NC5X0Lk+9PVVm+zZSvL/XPPlWmm8xV6
         OLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=peld70uZS+AZOWUPOW+UYjUUA6bUakzXmPZM+FZTzT8=;
        fh=nhpxjJATlh5GvQPzHYec446WFCYsr+lI67/u45MgqoI=;
        b=lklPAMU34m5hf7pq2xuOrCa1R/Z20DXwwsuRjpO1LQezXO/X/mHA5z0Qv2c3GunV1w
         Vnp8iAcF93qAIlf3xUk2gJuf8Te5k6WWLJE7bAA+he0FrqZvOflgLkFLXnmVLEV38ltA
         wegcwr4hajDrpuSN1uIc69ecbKYb9NSa6rnRX6pnUc8MVo6DnaZTe3Y+OLB+leD8o4g3
         JOR72T0qCDX74KxpJ4SkCf2Tm9QU1KlRol2PSKOuULkx2MdHVJyE/tDV9CAWh22+JrEJ
         JXGzHyZ4a4hbdhzcllllqGFUNqqHQg3dLWZoGl+gd2pVKWXANWduRplidoKKNNw3YWwo
         gc6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787849722; x=1788454522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=peld70uZS+AZOWUPOW+UYjUUA6bUakzXmPZM+FZTzT8=;
        b=H2KvPhVJbalXcP7QUpt4sLmvq47xdd/H90+arpUdZ3WT9XYXSv9Yk949oHK0VpId+k
         SXApsAdwlVly9CG2kO2CcPKXU5qKMvwGkOW4ZOzi7gN69SKW2oZnE0ATg9Kqe6Gepf5i
         Hb3GS/GEbIhQXi4ZkGA+2cuan+0oRE68wfESYWCKJEle2Ig9XCJNQxngRva5rlFT+niY
         v68yaIHZtMYeZJlNboBK10AY4Z0hD1XgcBekzHouDbv7tIVFazqiiVpS2kx2K5m2AzVM
         W2/aOVICsh6BfGoQ6rP/KwmuRvYIUrmq0p5R9zuxUmokOTSOGAjOqxN3SA17jR9HO0P0
         zQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849722; x=1788454522;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peld70uZS+AZOWUPOW+UYjUUA6bUakzXmPZM+FZTzT8=;
        b=Vbd8LUPFQgo8gCe0wiZC824KYxBPL6mcALsRWrMqE3jnmu3ne/kCAlOn/pBpW0bVGh
         lpuOZ9rwIZ98PtFGoxrpDnS2MjjM8xOcOfvWvIDSsg3Ye8ldtsPQ7EvL9LKmID9PkR/x
         ZyPBk8iY9ryPhwuMdw3zGZHCtUp6oSrgEvkq662H/lc68nwzbu95/wk+ai+p2yTBm4RZ
         +jkwEljvJxVIVv0i8tI9Jr/wYEQ4twVkCz6+ttF2tuSh6flVMTFnyU13l1vTjiahIab1
         xIHo2/Lo3lhLzOR18b16Rm2zz+Fgi5HZeUb6TyQ8Fqfuo9PSqTgUv8b/U/EXPiRWgksu
         jj1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqoxkZ/5JoqplQW9wr6PDUM0YNDMG0CaCcV1PfGwDOxHYQi8gX+eDI19Dg6AGOw3Dimnvk+nHI=@vger.kernel.org
X-Gm-Message-State: AFuF++maiGj/TJT/uZXqAf6rsUYKWJJUHwOQvEo1mS4GGCF55MZZulkF
	TAnMZ/d6aXnUA7ULg8EKvJ7oO47bdPjOI26tOrwRKTjDnRNXW+kabUtun4z9a/nFM3fBKG2oXnx
	Idww7TQeuLJYdE+JQHYsV8CyGmJppn3o=
X-Gm-Gg: AR+sD138EtV8OmGR9I1R5o0/cBZYfXawaeWEckB6Kn43X0TQfwtnKgYEbIMwi8GB4Jf
	eYi40aSfXUINIyNXM38hR/mc6GjDbMyDstSxbdD9oKlzU+J4uQ0yLeM8JqyUmUqHzm3Oaa3QMfe
	P0thFOD47x0b6M2gYgXgvx5xkuz9Hozclp+ecE+zkEthAghYlsHFeTRLTHAm5CYD4mtBqqsNkrz
	hQa7OUoErxhKK9LikctnhU3Cc/Dnf5kgNL9WNeLVTK+aEu8C4S//qKPXopiUXaf3WJF7BHFQJsP
	RKYJUreQL+8maqP2c6UJgZM1FaKeJxu3wpuG6twpg4kWOu71ydLwwPZDOdRABMBvpo+VZ1/P9Um
	Q1QD3PkKYe0ekXx9yREhXLT+Vq0iO2hjNBsIaLea1zQrfN5xYI8yHcfndIt0A
X-Received: by 2002:a05:6a20:918c:b0:3d0:ba81:79b1 with SMTP id
 adf61e73a8af0-3d26277130fmr872772637.0.1787849721482; Thu, 27 Aug 2026
 09:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822225444.2774461-1-simon@swine.de> <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com> <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
 <CAADnVQKD1eOG7cnDHvFwfJOEGZ0g8wZKEzMri27en7uoA-MT5A@mail.gmail.com> <CAEf4BzaB+EDyf2exV8XGq_x4TvhTii7gJnWU0nq3380guaWF7Q@mail.gmail.com>
In-Reply-To: <CAEf4BzaB+EDyf2exV8XGq_x4TvhTii7gJnWU0nq3380guaWF7Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Aug 2026 09:55:08 -0700
X-Gm-Features: AcwNN1W26dr4H2uiTLZyvu1qJBQWg4eRlgH2I0-78g4NmBqI5ET8X12cg68Ln8o
Message-ID: <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, stable <stable@vger.kernel.org>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 27, 2026 at 9:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Aug 27, 2026 at 7:56=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > > > > A JITed BPF program can use one private stack per program and CPU=
.
> > > > > Sleepable programs can be preempted, allowing another task to run=
 the
> > > > > same program on the same CPU. The second invocation then reuses a=
nd can
> > > > > overwrite the first invocation's private stack.
> > > >
> > > > I'm confused by this. sleepable progs go through __bpf_prog_enter_s=
leepable_recur()
> > > > which has per-prog recurison counter. So preemption of the prog
> > > > doesn't break private stack.
> > > > If the same prog attemps to execute on the same cpu it will be skip=
ped.
> > > >
> > > > syscall prog types go via bpf_prog_run_array_sleepable()
> > > > that have per prog recursions counter.
> > > >
> > > > Looks like we're not doing it for bpf_prog_run_array_uprobe().
> > > > I'm not sure what the right trade off here.
> > > > I feel universally checking for recursion is better
> > > > then selectively disabling private stack for uprobe.
> > >
> > > I'd really like to avoid adding this "recursion protection" to uprobe=
.
> > > With uprobes, there is no recursion, it's called from well defined
> > > context in the kernel and you can't have recursive uprobe BPF
> > > programs.
> > >
> > > All you can have is a very valid and possible sleepable uprobe
> > > interleaving, which the user cannot prevent or work around, they have
> > > no control over this and it's just a fact of life.
> > >
> > >  E.g., a simple scenario, we attach one bpf program (let's call it U)
> > > to some USDT. BPF program U is sleepable and actually can sleep due t=
o
> > > page faults (e.g., unwinding Python stack trace requires sleepable
> > > mode for reliably getting filename strings from Python runtime, which
> > > are not always paged in).
> > >
> > > In such a case, you can have thread A and thread B both hitting the
> > > same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
> > > thread A hits it first on CPU X, BPF program U starts executing and
> > > unwinding Python stack, does bpf_copy_from_user() for string contents
> > > and causes page fault, is taken off CPU X. Meanwhile thread B hits
> > > USDT on the same CPU X, kernel runs program U, and it is supposed to
> > > work completely independently and concurrently (no shared state or
> > > whatever) from U's execution in thread A.
> > >
> > > Yet, if we add this per-CPU "recursion check", we'll just skip U's
> > > execution for thread B. This is data loss, and it's very bad in
> > > practice because it frequently just invalidates the entire data
> > > collection trustworthiness.
> >
> > ok. fair
> >
>
> great, thanks!
>
> > > So I think we should disable private stack for uprobes (sleepable or
> > > not) instead. I'm not sure private stack buys us anything for uprobe
> > > cases.
> >
> > why disable priv stack for non-sleepable uprobes?
> > While non-sleepable bpf prog is executing the same or different
> > uprobe cannot execute on the same cpu.
> > So bpf prog can be preempted by kernel execution,
> > but a user task cannot start preempt bpf prog,
> > so 2nd uprobe cannot start running,
> > no?
>
> I think that changes on preemptible kernels, this was called out in
> discussions on previous versions of this patch. So only for that
> reason.

my understanding is that preemptable kernel doesn't mean that
bpf prog can be preempted by user space.
only by kernel.

I looked up earlier thread, but don't understand what Jiri meant.

Jiri,
please clarify what problem do you see with non-sleepable uprobes?
