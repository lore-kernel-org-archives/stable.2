Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622D36D500
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742129; cv=pass; b=UnpT6TCsGzfe7my9tVg0By4yNJ3LCL4k2vMcm/8bleuHpPnXEiNyWFboTcdtHl9jQxteeReR0nI9xMZXs+pdodY4h9Zx7iqqxUQhknJi7ghdGhfzdvVL8g7HM0HFz01p/LZSAWKpQ1wQsMYMB5wtP4v68USYyzTG1iR3vScx6NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742129; c=relaxed/simple;
	bh=q8QVdB9NJN+/zi8Xa6uyCMmfy4NxiwhJalxYShKUiSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TES8h9w1orsP46pR06n3Weo9bV7bBp600IqjiWsayWc4U5f5l8Lw+hCzloRpOZpx4LBeoO2oFmxb/Mns+LnxCkDE6XjdBzzM6E2ATEXPw4B9qffXUDs+lHXENoC4GOPFUvTG7In1p15398NBWYsQLk2lfIsqJIH1Nc2zwGnBzZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XksBjP4o; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="XksBjP4o"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664d78637f8so981426d50.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 07:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742127; cv=none;
        d=google.com; s=arc-20260327;
        b=o/WhTeXKy4kHlEd+okhvuCRfCuLI2frdZmIzBHCIRjgfry5/ktuVyxtaxJvfrEpAFF
         M64w261nkapbpGutUXmjVkWbggU0LYaCzcyc72rsNWa+xzIYtfU1N1yFDYgLIB7VYRgI
         s8Kk2AcS2Ehnb5tYbQ1Bn37ZYo/Y3wgVdqB3lwghdcdMV/z7FgeQhxM+ewquh/quTeSg
         l2JCA7wLxNcS/9k66xvMF6gFeoQMlByRRLOCEeII/I1EWxOK8OJUol7h2bSdl39kDYkk
         9hV+ivtRTeqo9+FVgTp58cGIw6qWeQmIba825DzVKMGo4ozFej8On9O9S1/lQwFt/kVT
         l8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        fh=Qkn6XLEkhF09bzwPdDS56q+SkbZedjark7VrNPFHbP0=;
        b=A6h2qiuBjevVZgM9E+lLKUIj2OQQfuL2Njz2KyF+L3hlhTPXLkHai6F+LUJtrsGYyT
         DA6mvhY6CO+Y/jYLHHaTHd2LHcckzET3fJnSnBYdCctMF1/5fV66Nvcoq6AAQvlBR3Ho
         hRegM9tQFzGuk+LKJVc71N6IB2kCsLOUPiYn7sXkUKLueGTZM17p4NbjPS/G7qIEPpfO
         Z+xL/ctwKmvVVQr+U2flpJn12F1P/tP+4MofaZFrumtqOB7ExpJx9fPg12jMwjCRNOQ8
         M10DgtkuEtWrNgmG5UPWQU9yLW3WY6i52e6puyMb/5y0+cZj49jwN86BPc+niT4AXKK8
         79gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782742127; x=1783346927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=XksBjP4onHdQGNQhjSwLsyFa5U7EewqqYv64OBG477NoI+++Tzw60DB7vQAZvZbWUY
         +wnPRwDg7tNhwk/aXmOESi2i4WG0ddy05TpTtLnU2ORZWEBiTZyYntVGdsQ+zCmpBv9K
         Im1tPOFZtf9o+0WBcY7VNiERNX0K7lpExRr7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742127; x=1783346927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=VVpem1UEV4rmjUGS9sKNSygIJdXjwRpH1p5vVOBE9UkWYqUMs0mcHKT2i8cxwfwEgx
         LFNV0pPnXYB713u2nfd88gqAiBcH3moOTVBrIxSz1NpBUxccbA89nQCg9VAfOI9W1/Kt
         Xxl0clk5UdMq+wRSegF6YMGjMLt9ZKCOdXmLuI7jPJEPL2rNlWZNJ8ND3fnvTMMNoWf2
         w9ez1bonPnd+dl7ANHeX+2QRdYR/gBPI94+b2mg+gIL+rcFOZEl03Uuewi8kUY337SGM
         FfbmJCgy6gOKTCdD9HKqQbbpJ7w6PuwghxAdx6uN6QWPpsXy5b/FmMTB+zDQTfaUm+wn
         3+cA==
X-Forwarded-Encrypted: i=1; AHgh+RqP/QJRPO24XQTuFmgg9JcTwZ8gUDHKPHsTmPDoEs3SSo1ZTzIuTvfmc2mYL3uU32/803DP3Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAn0S3JfrDdgjKs6r2tF6gFSGS0h7I4dstDprgNVr+yUYvlye
	9zidHY2v90AXU86hYZo/S0M7Vc5nN5oA3aQEVtiJ4xV8qbuZV3Lbc7jCjKKkMQDLLtdnpkjqWdn
	pBC3ivjZN5Ib4LPQ7AiR13wo+JkT55BxDd2qyzPIZ
X-Gm-Gg: AfdE7cl5I3N103jLRqc3uEF2AkZ6CIYtuKwJUrPLLWgy6A/MPpwVv4GlwOmpAJ5NOb8
	bMYdGPkOyEmwia2ryYt3F8mDpuM5yIsJ5B9sJTh4EtQ6zQZ2cqImCftYfdAqROXpDt79gbreUaO
	Rpr7wyEwrWmmnI0IBXB/C3oE916YykvwMTsOlWi1g4BwjUQgG0XoXFgJBZR4CXOtaRdtKMvMdu1
	C3v0RoqQMoZHZZusJZB8jyW+PKbyysIBvVWFI7rvzVa/VAHYxan6FAsYrUeuvNP3kJe7g==
X-Received: by 2002:a05:690e:11c9:b0:664:cd1c:3c1c with SMTP id
 956f58d0204a3-664cd1c64c7mr3930877d50.0.1782742126728; Mon, 29 Jun 2026
 07:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629102157.737306-1-jhs@mojatatu.com> <20260629102157.737306-2-jhs@mojatatu.com>
 <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net> <CAM0EoM=QsOZ+mbWk7Ysv8-UNMzbmzbYiNXvF9fjEnG1-bDv6YQ@mail.gmail.com>
 <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
In-Reply-To: <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 29 Jun 2026 10:08:33 -0400
X-Gm-Features: AVVi8Cdkj6dZhabBc0jnLqVMZa0vjqL1ozX4LLqAaVAUSsSvVM-qHxGJioR3gI0
Message-ID: <CAM0EoMknehYGAse7AfAN12oEYvQ894YbJrdhv1unOYgpTtvzFA@mail.gmail.com>
Subject: Re: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, toke@toke.dk, Steven Rostedt <rostedt@goodmis.org>, 
	Petr Machata <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 9:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/29/26 3:36 PM, Jamal Hadi Salim wrote:
> > On Mon, Jun 29, 2026 at 9:01=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 6/29/26 12:21 PM, Jamal Hadi Salim wrote:
> >>> The bpf_net_context used by sch_handle_egress() is stack-allocated an=
d torn
> >>> down in that function returned. By the time tcf_qevent_handle() runs
> >>> current->bpf_net_context is NULL.
> >>>
> >>> When a filter attached to a qevent block (e.g. RED's early_drop or ma=
rk
> >>> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> >>> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf =
helper
> >>> bpf_net_ctx_get_ri().  That helper unconditionally dereferences
> >>> current->bpf_net_context resulting in a NULL pointer dereference.
> >>>
> >>> Note: The same holds for actions that invoke BPF redirect helpers
> >>> (e.g. act_bpf running a program that calls bpf_redirect()) during qev=
ent
> >>> classification itself.
> >>>
> >>> Fix:
> >>> Move the bpf_net_context lifecycle out of sch_handle_egress() into
> >>> __dev_queue_xmit(), so that it spans both the egress TC fast path and=
 the
> >>> qdisc enqueue.
> >>> Note: The call is placed outside the egress_needed_key static branch
> >>> to cover the case where clsact static key is disabled. Unfortunately =
this
> >>> adds a small unconditional penalty to the code path _per packet_ only
> >>> guarded by CONFIG_NET_XGRESS (two writes and one read).
> >>>
> >>> As pointed by sashiko [1]:
> >>> The same context must also be set up in net_tx_action()'s qdisc drain
> >>> path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED chil=
d)
> >>> can trigger qevent classification asynchronously from softirq context=
.
> >>>
> >>> This keeps all bpf_net_context management in net/core/dev.c i.e the
> >>> existing boundary between tc core and BPF without requiring any net/s=
ched/
> >>> code to know about BPF plumbing.
> >>>
> >>> Reproducer:
> >>>
> >>>     tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 2=
0KB \
> >>>         avpkt 1000 burst 100 qevent early_drop block 10
> >>>     tc filter add block 10 pref 1 bpf obj redirect.o
> >>>
> >>>     traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle(=
) and,
> >>>     on a redirect verdict, a NULL deref in skb_do_redirect().
> >>>
> >>> Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks=
")
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Could we simplify patch 1 & 2 by just moving the bpf_net_ctx_set() and
> >> bpf_net_ctx_clear() into a tcf_classify_qdisc() wrapper where we don't
> >> end up having to touch the core TX code?
> >>
> >> Untested diff :
> >
> > This is bpf plumbing which doesnt belong in tc really. You already
> > moved most ebpf/clsact stuff into dev.c - let's just keep it there.
> >
> > As a side note: calling a hierachy of N qdiscs we would incur N
> > set/clear cycles for N levels =E2=80=94 and worse, qdiscs like HTB and =
HFSC
> > iterate filters while loop calling tcf_classify_qdisc() per iteration,
> > so each filter chain traversal does set/clear per proto.
> I'm just saying that this is a lot simpler and taken out of the core fast
> path. Also, I think you forgot to Cc Sebastian on the whole v2 given the
> bpf_net_ctx_{set,clear} dance. Imho, having them via tcf_classify_qdisc o=
r
> something similar would be the much better choice compared to sprinkling
> ifdefs since you want to block the TC_ACT_REDIRECT from classifiers attac=
hed
> to qdiscs.

And you are clearly not listening to what i said.
Something similar would be fine - but stop using tc as your dumping ground.

cheers,
jamal
