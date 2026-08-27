Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C637C108
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848535; cv=pass; b=dX/kRZqIYOCOnHi8Ddok9mCC/RoK8wzLZKwW5ImskLiNLZk+qHjg2Y45OeeEnomr4uTUImNcsvkE2K4o1yEXJ2INQ5CoF8LZS+FJHH5VDzhxrhnZLiiVrjiukUS+mY4J0+/QI73GGHYHH16zkddIzHRE3kKWTCj0oZ+6hEGQ6B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848535; c=relaxed/simple;
	bh=A8g4Pymc1MEXz3s6wr9IMDJPVnfJWtg9yfQCM6OV9iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrdNO9hKuCfz1D/Vd7Zr+42l17zrCsgpIj2iiLT9vhLNU7ltvFcViUWZVYBvyYwaaDYeMLXkLoVNB+1TmiZBjXLBaSlluv/dervOm8MdgcAaGaL4Z6wPbK8algYeCCudYeF+3BKJPtXOfB1K69CIoozpTVor1QW8HgxVG+e1sKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzT4efA2; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzT4efA2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d049069377so849985ad.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848533; cv=none;
        d=google.com; s=arc-20260327;
        b=kM/jKt1w4tWIpEc1LXL3VNfag9EM+FBp24KtCrzwvC1vtG4MJSt0op87GJJ9wjipk7
         NRWVdlMR3bv9MaVa50dpmWbAGVxh2kj3WWUADxKUKSoqaJrec3saO+Qfavm71/vuXwm8
         lwPH7DBXukQ4gQ5CxLgS4uq8jm8VMfzEKrX1f3l5ERI8B3JlvZs2K5Xn1zer764F0FRg
         jltleuqBvMvruty7WPFGyoXpKDIlhG6S4FxGsNecLXv+BFuMevW1tTre9avsnNlp8k+U
         ttdxZhJbwCvxqTsrAc8+9LNFp6Qfa95xiuUQB9WQBIIN8lhac7tqYrUU9bMxNEQClsWx
         Ez5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rpc0eHrdIxpOXoVsl6L+vsh/x6xcGHAy9PMg+4n6EIU=;
        fh=Q39RejPo/hL0Yv6O3dYz8oFL4DoZySioVQMef7B1mZU=;
        b=Ysfdz9b1vRLV8DBXqowVILvDLEGygR/jh4L+TMG7gOPbeAGcvZlOwNCdKPJFHxCK1x
         hbtalILlxfmM7mBq/Yv9h/EPOlR4n17BNEm3saNyTGjj4ABbbRxC+lT4gJcj0sV1aIgF
         SeXPsOgx9cl2reIZb8sY7YatmB3bMfMtS23ZeuCBMlYqw9XsBMeM7yoU85J3GcLU9H12
         PavbMa7qrSUP3Wr7vsK9JcZHSo5tgE3GlQDaYxw1WF9ccygaBCkGSpE+qGM6ggBbt6zI
         KN031LWvwMoRaUR13GmP020ua+oTy1daFYA5xh4FrqWTZoVgGH5uQw4e/3lsxEo+kW1C
         7M7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787848533; x=1788453333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rpc0eHrdIxpOXoVsl6L+vsh/x6xcGHAy9PMg+4n6EIU=;
        b=UzT4efA2fiprP1kC8M2qprS74ZTn4n5B6AFBj/UOpsa8GwN310l3PA3oeyIYoOax9I
         6JmTbaGrHL0cX/aLbB1tcoBRgQjZJpoRN52OomnLCmYYBCecqLz9QkCYPLC8s7bSo5cy
         qMD8wn1UPo01BpZcBN6hq87rWVDcLkmjiK2uNRgO5VWbmcZnYikHZ/G8S8cyPU/ZdlbX
         kBIpxXG/T8P4Tq6lS0LNXCpbVRlZn5PTM0dGDfkQJCITFK/GO9S3/o1C79DVFSsc16pD
         zV2NDtdlfVc6mgrXBvYxvsSEt9BNeLYgDFFtQNSsAjbv8I+ZBdpKwAoVfMiqtcVM+Ucs
         9KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848533; x=1788453333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rpc0eHrdIxpOXoVsl6L+vsh/x6xcGHAy9PMg+4n6EIU=;
        b=P9H47l63lANKKH2uL9b/fq27hDHzxgMKo6/leJgLwwrXmj41yPGufS70TX+2F6Z0ZZ
         XECGAIQHzXC7UHkvp7TA6cSDd7GWRuV+/EvhY9EuOTPIVB5zrSyXPJsMhgLtCT8MJOrM
         nYRMr/IrwnBdi4ynoHPrbitxkjfTKlNbiyPHKxaxV1QddJQFIqP3tnEFcXemyh9cwmgY
         saM7W+TR58gvBlHptFlIoeVXippaYjkUonyuK7Q91oKOti/CNyhKjSS70l2/3EUdfNSL
         FyIzf6N9e5311ZsBu6yHZ439wkY5bhKPFs/TTR4g4Qo8YuZs1ySX/+rwVA4m/LJIkZ1F
         vWqg==
X-Forwarded-Encrypted: i=1; AHgh+RoIfxCeCiBUQXy3NZiY0PcMg1fkPglw7zB/ibSkvu9d+Nto90lEC8iyvyE2X++udsipPNzv1qA=@vger.kernel.org
X-Gm-Message-State: AFuF++km0r6CXHjpHNK8daeDIsINL1ew7v8XQRzeteC2bcZrxXLby5me
	ZkSOM5lJFJA2UVKMutwRQKTgc0jNz0t35Fqi6AX5oC7mgTxjt453qoI3Pls0O+buprQ0/+K6vi0
	WhP1uJppp3cCjAfd4oIMMY7tfRW/aIpQ=
X-Gm-Gg: AR+sD11latkjOnBRrRal2XlCnPC2OVrabJwfzU3XqEBsh0hgFVduk2XPU+i4NS/UmPA
	u1/AkSXbkMyIgmHGVJA22kOSWolAybx7kTSjTjvIYDlc+gjbvoR5Owv5x8aBCRUJSDgqSlqTrAM
	knN+2jQZhvxAXSeCUvEmdPfUNRRYz+njOAwl15B1+pddtCsxz5JgHru5Lp7pwyybj1vRDlMzJR/
	qfC/7rrJ8kKGhh9gczqq/wsGoRjlhBnLqYwwr7aHw0gqOIwcRKvYhePxWK2eihjTWw8CiEQeco7
	4/K10zoCYcUS6QoxqnKy03eYUvBQdYvO3CHuqf9GOfmhWs8ERna/Cs6WBB1s7DukEzwyP/DfCGb
	+LZmh67AwzennWB3HowJ4u8xBq13S5XnCKPrsyVsnxsRfS5em2n4kfLZZk8j5RzNrvrLwUrQ=
X-Received: by 2002:a17:902:f70f:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2d74dc0da0bmr5053105ad.4.1787848533014; Thu, 27 Aug 2026
 09:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822225444.2774461-1-simon@swine.de> <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com> <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Aug 2026 09:35:21 -0700
X-Gm-Features: AcwNN1UD7kCYmFQWu6pjFf0INYDYIBRN0LWvAetdFdlQdjr9z-bGvTU59CvqtiY
Message-ID: <CAADnVQKD1eOG7cnDHvFwfJOEGZ0g8wZKEzMri27en7uoA-MT5A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, stable <stable@vger.kernel.org>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > > A JITed BPF program can use one private stack per program and CPU.
> > > Sleepable programs can be preempted, allowing another task to run the
> > > same program on the same CPU. The second invocation then reuses and c=
an
> > > overwrite the first invocation's private stack.
> >
> > I'm confused by this. sleepable progs go through __bpf_prog_enter_sleep=
able_recur()
> > which has per-prog recurison counter. So preemption of the prog
> > doesn't break private stack.
> > If the same prog attemps to execute on the same cpu it will be skipped.
> >
> > syscall prog types go via bpf_prog_run_array_sleepable()
> > that have per prog recursions counter.
> >
> > Looks like we're not doing it for bpf_prog_run_array_uprobe().
> > I'm not sure what the right trade off here.
> > I feel universally checking for recursion is better
> > then selectively disabling private stack for uprobe.
>
> I'd really like to avoid adding this "recursion protection" to uprobe.
> With uprobes, there is no recursion, it's called from well defined
> context in the kernel and you can't have recursive uprobe BPF
> programs.
>
> All you can have is a very valid and possible sleepable uprobe
> interleaving, which the user cannot prevent or work around, they have
> no control over this and it's just a fact of life.
>
>  E.g., a simple scenario, we attach one bpf program (let's call it U)
> to some USDT. BPF program U is sleepable and actually can sleep due to
> page faults (e.g., unwinding Python stack trace requires sleepable
> mode for reliably getting filename strings from Python runtime, which
> are not always paged in).
>
> In such a case, you can have thread A and thread B both hitting the
> same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
> thread A hits it first on CPU X, BPF program U starts executing and
> unwinding Python stack, does bpf_copy_from_user() for string contents
> and causes page fault, is taken off CPU X. Meanwhile thread B hits
> USDT on the same CPU X, kernel runs program U, and it is supposed to
> work completely independently and concurrently (no shared state or
> whatever) from U's execution in thread A.
>
> Yet, if we add this per-CPU "recursion check", we'll just skip U's
> execution for thread B. This is data loss, and it's very bad in
> practice because it frequently just invalidates the entire data
> collection trustworthiness.

ok. fair

> So I think we should disable private stack for uprobes (sleepable or
> not) instead. I'm not sure private stack buys us anything for uprobe
> cases.

why disable priv stack for non-sleepable uprobes?
While non-sleepable bpf prog is executing the same or different
uprobe cannot execute on the same cpu.
So bpf prog can be preempted by kernel execution,
but a user task cannot start preempt bpf prog,
so 2nd uprobe cannot start running,
no?

> As Jiri mentioned, at verification/jitting time we can't tell kprobe
> from uprobe, though, so that's a bit of a problem, but it's a separate
> discussion we should have. Perhaps having an extra expected attach
> type, or type, or some program flag to designate uprobe program as
> such would be appropriate, not sure. Let's discuss that.

we don't have sleepable kprobes.
So disable sleepable && [ku]probe type is enough. no?
