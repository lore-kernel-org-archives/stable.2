Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DB3D47DD
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961802; cv=none; b=V/sueceL59sl43ognnrjn3F3hSKYNtMeLaHQXHpQDLNfa/z3H0E1o4FDFmOprqtGj9f3h92CSqeRak4Pm1iB9/rQNEfOw1E1KusJ8fRH5s4B9hhbgohLSnvvcFCcNusHuVklNeS8KDnRIg7mJn9Y4FLBQ0btXkax0yloKrX2zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961802; c=relaxed/simple;
	bh=1G3eGfnllRZ6sY3D2eS7/x5qExSAZGpFlR8NP5yqxog=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDNBY2SoJasv/ylcKhV39uEBkdwrjnV3j4I3rFka23l3NnBlTqVCV2GiZ9CUIWd/VqizUKOSbnFJqxB+lLjh12RUTUZjrPlwSMXeGHbeHi0lP1yZX+XrCc+yF2oLp3nEFclfJaXfFBbwP70AUDTYLLIMAQxFFdrjBtLJgNs8TZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0c7vX15; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0c7vX15"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso7868725e9.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785961798; x=1786566598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ul0FjFTuJIbCFAmP9N/qJSNmBrccWs8JRIa5IIQi3S8=;
        b=V0c7vX15Kq4dfYpSD/MKu1fhNtkuuhuASb0GK1Lb3MTcrP7bZW4CkIviT2xAcbMIgR
         dmWMuW1Ll40Sr/8rVAgdQ1lM4fSkpI0WQFophnvSvaPnasf51ZViX7jFJQkgC9lGlAhb
         qxV2TY4TGVTq/lNqwVp6ut5CMCsZq8juvvOFHzbSUKHnIaBXB9QSl7ZYPrlTE44Ttd5g
         nTixQq3/GAcIEXuce4a1gLe7IoetvWu0KZo/Q11U7ACnad/PC6m3FPZaFb1N27LyaQsg
         jf4mwSx1wdG78MqP909N0bD1qdZQL+bUnsp/xRW1Py7uu1ew9+XX1Om/d2ONmssjdSRn
         YFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961798; x=1786566598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ul0FjFTuJIbCFAmP9N/qJSNmBrccWs8JRIa5IIQi3S8=;
        b=XsJXbceZlxD2UAbPaTzTVCococJJGXaVNEvn7xMBqAV8Ly3kuzrJbr7lYl06cFAj6w
         NSKsV81kQzsD5/7DkwJU9REGPLXUbCawlKGBM/21QRHUJyXYSxCgmv8QslHiUCTmi49S
         0P4UAeES4aKgltKnZJHyKPYmBqwwxmdH57BypWXmDITP6B7uAnYcqGmNfrwa8mVAm6eg
         GKxbnbo+/4x0RuFDcMEiOnbSWoBSfWPki2zElrKf+1mKBQ38D1FQUlI9CVcMeF0W2kZR
         qM66PZB3B+wirmfCVQcBwr+4rCQR4ir632aOIIC361i2+93oP67+VAv5GveB/8barN5D
         vXQw==
X-Forwarded-Encrypted: i=1; AHgh+RrlFtrY4FrO/6wNS7CXCqHceKN4HassQbOmSoMvGIbjZro44xdM8kFs2D3ZYz/6N/oaQdmQHYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVo3lVwiNNGZKXmYrnW+fXouhnOUiMQfM/IZA7AnbQw602Gb+
	j3gylf1b06YwX/j1TKq0quDhv8r6B+XIk5Sxghqi2aQdVPEH7OTZX/co
X-Gm-Gg: AR+sD13sH/3vtszSxSXwHp4jtEAeyJeES4oQpta8IQ8+OtE0buPu8ioYIsqy1oQStnX
	xgLMlf1kbz5yAHopDkPVBs5ZUQ/8KINwSmVzGYkdJ2S9y2dZxLWPMmnBCLjqTt9UiNL28mRYitZ
	0NYDU72PczEmlIiD3buw/cypUrjC915QDR1PyyMJiGbubpygP7qJfWJQ41+lh/KZhcxi1Ew076O
	gZ2HqCEI4aCOVcjKkov70MkvP0MIe8vkSedHVdFLGx99h5fXFGXfWOainguj/4HbOZrEz3f7imH
	UFpnut7r6XHeAPV4ZzkMY6yrn9cryQt147vPU3bqsNpWf+GxFUM0ro/nmg0TERaCzfSCcHToGKS
	9qjLlDDv6YNs0C6VzksUDZxmGag7OxqfLYhxeWhi7HK2k5lutMejqYnQDDS04+KAqVY8B6zqGI4
	JDDtFmMkG1pkKugblHaclVkaL9O0wgQ8WeHI1/bsq4oSxbVVg5VGpCJSK8/Dc=
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-4994e7ba99emr144346045e9.10.1785961797646;
        Wed, 05 Aug 2026 13:29:57 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954221f32sm6276925e9.9.2026.08.05.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:29:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Aug 2026 22:29:55 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: Re: [PATCHv4 bpf-next 10/12] bpf: Disable preemption in
 __bpf_get_stack
Message-ID: <anOdQzvkS_JZG2Op@krava>
References: <20260805092843.516315-1-jolsa@kernel.org>
 <20260805092843.516315-11-jolsa@kernel.org>
 <CAEf4BzZQXq5CNSkD4-gMOhs5+GU9Sf9Q7sHvLu1BkpqDTQHa5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZQXq5CNSkD4-gMOhs5+GU9Sf9Q7sHvLu1BkpqDTQHa5g@mail.gmail.com>

On Wed, Aug 05, 2026 at 11:34:58AM -0700, Andrii Nakryiko wrote:
> On Wed, Aug 5, 2026 at 2:30 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > From: Daniel Borkmann <daniel@iogearbox.net>
> >
> > get_perf_callchain() returns a per-CPU perf_callchain_entry buffer and
> > releases its recursion slot via put_callchain_entry() before returning,
> > so nothing keeps the entry reserved while __bpf_get_stack() consumes
> > it below.
> >
> > A preemptible BPF program (e.g. a non-sleepable raw tracepoint program
> > on a PREEMPT kernel, which runs under migrate_disable() but not
> > preempt_disable()) can be scheduled out between obtaining the entry
> > and the copy. Another task scheduled on the same CPU then reuses the
> > same per-CPU buffer and overwrites trace->nr with a larger value.
> > copy_len is then computed from the inflated trace->nr and can exceed
> > the caller's buffer, causing an out-of-bounds write in the memcpy()
> > and in the build_id path.
> >
> > The rcu_read_lock() taken here alone does not prevent this. It is
> > only taken on the may_fault path, and under CONFIG_PREEMPT_RCU it does
> > not disable preemption; it merely keeps perf's callchain buffer array
> > alive (freed via call_rcu()) and does nothing to stop another task
> > from reusing the entry.
> >
> > Disable preemption around obtaining the callchain entry and copying
> > it into the caller's buffer, so the entry cannot be reused underneath
> > us and trace->nr stays bounded by max_depth. Build ID resolution may
> > fault and is therefore deferred until after preemption is re-enabled;
> > by then the instruction pointers have already been copied into buf,
> > so it operates only on that private copy. Note, preempt_disable() also
> > subsumes the buffer-lifetime guarantee the rcu_read_lock() provided,
> > since a preempt-disabled section is an RCU read-side critical section
> > for the callchain buffers' call_rcu() reclaim.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
> > Reported-by: Tao Chen <chen.dylane@linux.dev>
> > Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
> > Reported-by: STAR Labs SG <info@starlabs.sg>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > [ changed Fixes: commit ]
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/stackmap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index eabeaef31b63..789fe35b893a 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -817,6 +817,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >
> >         if (may_fault)
> >                 rcu_read_lock(); /* need RCU for perf's callchain below */
> > +       preempt_disable();
> 
> nit: asymmetrical to preempt_enable, I'll move it to before
> rcu_read_lock, so we can have proper nesting

ugh, nice.. thanks

jirka

> 
> 
> 
> >
> >         if (kernel && task) {
> >                 trace = get_callchain_entry_for_task(task, max_depth);
> > @@ -828,6 +829,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >         if (unlikely(!trace) || trace->nr < skip) {
> >                 if (may_fault)
> >                         rcu_read_unlock();
> > +               preempt_enable();
> >                 goto err_fault;
> >         }
> >
> > @@ -836,6 +838,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >         /* trace should not be dereferenced after this point */
> >         if (may_fault)
> >                 rcu_read_unlock();
> > +       preempt_enable();
> >
> >         return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);
> >
> > --
> > 2.54.0
> >
