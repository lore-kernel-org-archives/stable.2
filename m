Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146C427F93
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842587; cv=pass; b=Qr6iNY5H5WYNWp9q3xZbyt+6+WsWOjzDrJnNZOvpKbLweF3mNIFs9D5td/goyDmLzpzx/tVss/DumKSD54qKXXBk7tquolC5oX3TpdKv/HazxrGAa7p8Yuk07iLuJ6sYxWGYCCvOWKrnP3VqBog/UIcQ+IUagb0w5tKisn76Qdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842587; c=relaxed/simple;
	bh=0mstDLpNE5HqJ37WPV2/6GB6JwYfKQBjPJNFkn1B/H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGmggxZGSCQQBaVnm3WUOFY3YntxQMuwNQC8s5tgg27e23n17TlAYxk7vXxwa/h9dXRbJNOujB4fmbvEcaReT2SAXK8P8bp/Bpg7wcbzxiR3Auzch7UbXrd2114MbmERfBqgGOJLu1EqP1XxMj4qqf1a0QmbXrMD/kfg0Fyi55M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqejJpi7; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqejJpi7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8520161fdb9so2574287b3a.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 07:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787842585; cv=none;
        d=google.com; s=arc-20260327;
        b=qWReRBvvLyWbljFLysxvdR19e1p4MfpRTKKnb1imqrVX3MyCT1YQOHQ3CnayNqR3LG
         ZOO86NoLQ+LqytqcnGf2XKPyN/1VXzF4Z1hV5tzDnxsa6gMrxAsEOGhxYM0oHzDAK9mD
         bxNKwKJ9uF5BB8c58fjk5N9b8KZDh3A7G/Sv1RdLU+B+dr9ycaldpFLJQsu2Fa5JCGzJ
         qHMyIcZFGLUxXx/tn0pLXEF66E+kqvSKNOkmADsTR2d21Q42PEITwGdq7yPktKTTCV9r
         BJqWIeWwzk9iSykka4xDPsGwDPrQZn8w3ni82RLnvuHCBxKy61Vr2UqJyYeKZorqr1wl
         cNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n2MTw88jVLBTmyVxQrGtyl4vuDsvFs0qyxjhjgsnHbI=;
        fh=PgQAizvM2Qe6tgydlk2pEk1aNLCcUZlJto0n2ameo88=;
        b=jrxndkSNDceo7f8e/xuFQDDvkDxizSE8ro1LqCSmtkjSuSpVKhYzZigMc2c5pli//+
         k4v6SpusI2BvHMACS4AFrgr8qJpRk2ksznVxDtvO/qHXTKyqFGReUnwIpe2NS+fzSbC7
         iVu2iB65LF50RwLjnL7vqRRUaxgqe1tiw+Ubas/QI8fRqeL1UljTfetmbPACmCG01QCd
         +MKh/pcq46KmMwNBbQ2AD+e6UHnQs5yTcesI9ooi0Q4Z3e1V0rK9Y1v635WAcv5O36sI
         3M7fQspwFKlZVEJL81c9SbkmtSgKhrtBSCnwu8p6ID9Uxlc4Ifsbn/Fk64aaMrtK5GEd
         HAbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842585; x=1788447385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2MTw88jVLBTmyVxQrGtyl4vuDsvFs0qyxjhjgsnHbI=;
        b=ZqejJpi72YkEooyXZ/y46qcvpKhrepGfPp2G8lrP2ejv2GCOgguXBmpkvVQVzKWuzB
         2YePS/6hypACVMQ6odCH7XZ5eh/ZS/C1VN04tIdHiX0/6GErV8xxEWMNdMARIyalYlXV
         t7hVzBy7jt6DGd5kqIInJd0C5v8UUEmohfTrXThbUYH5SKCxAqnJQRa5mB0p9XzH0wSo
         IeuQUCNwP2Uhft1iF/30b7oMOeAU8b8CCcxapCZbuJpfrfIRwptegSPS3GJef+XxsKYT
         lOvw+Z6e6wHnI2FNbjMnNQ2BpBkInCqrvnGwDllt+RGu6unZ/JZbNQLZogQ9zH4awfbb
         soqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842585; x=1788447385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2MTw88jVLBTmyVxQrGtyl4vuDsvFs0qyxjhjgsnHbI=;
        b=Anb5ceRaBfsmVrhM9Cjo5DPO8BoJZe2iZxHDrN4b7i4FsOBn3auHHEYDkeW6kgDGYs
         pLvtZ/cI/yVDAAPcXMKm+NAUuVseIu7WchfKi3f/A3UNhZt2fXg4Xy0icpnVq+O0giMb
         o5uYDK8OFiOeL30Ecl50mtTPCbKmvFFm5JsdBKzYIxDwGsZhOgtyFt3Bs6u0XkhbVBqR
         wesyIaHnvNq2nQwO0BHTy4r7SMNsQAuFGqY4jvIvKtxWax4aduuKkTf5kS2MwJXk7bbY
         k411QRls/lZ9iMNfJe748WUeCU6OIEq9q05WIkb3XGYlvf8WhFIVsWwqv7F6vpHbX9+N
         eUMw==
X-Forwarded-Encrypted: i=1; AHgh+RoWkPtebywkg8NuL0+yoNVkUayRWpK6jJfmR8RttM3WBq5Cn8o+S00YUrOmTZtucxVoXtdh9p8=@vger.kernel.org
X-Gm-Message-State: AFuF++mCCLhXvd3kIQmGh1Ph+Kp2gSxxE9i6ygDFGDL33lDlwhLG2Rj7
	r186+EO9w9eRHLm3z53CblSE8NNlirrJtPI/tt5RTNhsThL67+LSf7u6ymCjA4rwgzRESHE7Hwe
	1ncOK4E64wyAszVtXltIKIrvS2K5cTIk=
X-Gm-Gg: AR+sD10PtIFg1xHBiyji80dsIHqH2BNQwnOedN2JnbStRUB1MSZia7fkOrpfzMLj3mj
	Z7Bk4VBu3JzmxRz4aB7Fot7Wsuk5pDWYKOBLyFoz7Cq/GVSEQyVJdJv3FmUTcnbAFjxdUJt896V
	BX0gJppZd/l0wHgWviDdtMOmQ1ECkHV+R5MF0vvQnwYdB2pEipDkhKyThG9rirR/0C6YD0N9UWU
	jAvNnmyCYhSTCS3iAvqwW+xLpqaHfvwxWVv3GJi90KRVCaoPe3VBMv8tiWsZNMeVKu05/xeP4Jq
	7ADc1HOHhwtwjx7IB0t+qtdrBnVmBpjwbD5Fh9fHul2P8qOah6Iu2+hC/5OEAlEJjgWwheryXxk
	ogGMyuutKAQ43/BzI5esPY+GalnGioJEdkFEN
X-Received: by 2002:a05:6a00:3984:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-85373bb8dc8mr26253345b3a.8.1787842585290; Thu, 27 Aug 2026
 07:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822225444.2774461-1-simon@swine.de> <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
In-Reply-To: <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 07:56:13 -0700
X-Gm-Features: AcwNN1WJoNUFqCJjOSLU7Hm184I3k4u300g0JamTEyCvcDlP-yF2LMrAI2A8EVc
Message-ID: <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	yonghong.song@linux.dev, stable@vger.kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > A JITed BPF program can use one private stack per program and CPU.
> > Sleepable programs can be preempted, allowing another task to run the
> > same program on the same CPU. The second invocation then reuses and can
> > overwrite the first invocation's private stack.
>
> I'm confused by this. sleepable progs go through __bpf_prog_enter_sleepab=
le_recur()
> which has per-prog recurison counter. So preemption of the prog
> doesn't break private stack.
> If the same prog attemps to execute on the same cpu it will be skipped.
>
> syscall prog types go via bpf_prog_run_array_sleepable()
> that have per prog recursions counter.
>
> Looks like we're not doing it for bpf_prog_run_array_uprobe().
> I'm not sure what the right trade off here.
> I feel universally checking for recursion is better
> then selectively disabling private stack for uprobe.

I'd really like to avoid adding this "recursion protection" to uprobe.
With uprobes, there is no recursion, it's called from well defined
context in the kernel and you can't have recursive uprobe BPF
programs.

All you can have is a very valid and possible sleepable uprobe
interleaving, which the user cannot prevent or work around, they have
no control over this and it's just a fact of life.

 E.g., a simple scenario, we attach one bpf program (let's call it U)
to some USDT. BPF program U is sleepable and actually can sleep due to
page faults (e.g., unwinding Python stack trace requires sleepable
mode for reliably getting filename strings from Python runtime, which
are not always paged in).

In such a case, you can have thread A and thread B both hitting the
same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
thread A hits it first on CPU X, BPF program U starts executing and
unwinding Python stack, does bpf_copy_from_user() for string contents
and causes page fault, is taken off CPU X. Meanwhile thread B hits
USDT on the same CPU X, kernel runs program U, and it is supposed to
work completely independently and concurrently (no shared state or
whatever) from U's execution in thread A.

Yet, if we add this per-CPU "recursion check", we'll just skip U's
execution for thread B. This is data loss, and it's very bad in
practice because it frequently just invalidates the entire data
collection trustworthiness.

So I think we should disable private stack for uprobes (sleepable or
not) instead. I'm not sure private stack buys us anything for uprobe
cases.

As Jiri mentioned, at verification/jitting time we can't tell kprobe
from uprobe, though, so that's a bit of a problem, but it's a separate
discussion we should have. Perhaps having an extra expected attach
type, or type, or some program flag to designate uprobe program as
such would be appropriate, not sure. Let's discuss that.

But please, let's not make uprobes unreliable for no good reason.

>
> > Disable private stack for sleepable programs so they use the regular ke=
rnel
> > stack, which handles preemption correctly. This change is intentionally
> > limited to programs marked sleepable; preemptible non-sleepable dispatc=
h
> > paths require separate protection.
> >
> > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private =
stack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Simon <simon@swine.de>
> > ---
> >  kernel/bpf/verifier.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5e37ca75e5c4..038753ef07a9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stac=
k(struct bpf_prog *prog)
> >       if (!bpf_jit_supports_private_stack())
> >               return NO_PRIV_STACK;
> >
> > +     /*
> > +      * Sleepable programs can be preempted, allowing another task to =
run
> > +      * the same program on the same CPU. Since private stack is per-C=
PU
> > +      * and per-program, the second invocation would corrupt the first=
's
> > +      * stack. Disable private stack for sleepable programs.
> > +      */
> > +     if (prog->sleepable)
> > +             return NO_PRIV_STACK;
>
> This is not true in genreal. sleepable progs can use priv stack.
>
> pw-bot: cr
