Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929C3D75CF
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869958; cv=none; b=UzL30H3UO7z/IRYr/9XkQkVxZzFJtlGp0QKC65f8E4B/uijiX8P06LqZaigCt1IKFUt4D7GRFevtN161covogyjcdng5VE3OhZmE49UzHPF4w8XY/+s7reokvdCUa0L6eQLXxEhsPcpZbGrsMuP35MRyeVlsolOsZHQS30EpNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869958; c=relaxed/simple;
	bh=0KS9yDRF5ufQr71N4f6ELYPxUEqie2Ct2GuCnnm+4D4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNOny9wrcXcod6tndCF8W/KaVVwslUbhtArXIlIHVWUpKno36u2n/M+VsSiEeVsCEkpE/CysFb655JaS3IYbLZT2IFMCWRDJnSTkv8bqoxauFJbymBeIrIBtbly61JRExMvMxgUY8Mf4WpT4dD46J/Mslge/7huBzAX1V97/lyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGjJ0P1V; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGjJ0P1V"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso2855835e9.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787869953; x=1788474753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfHSf/Xnpm7vI/oia3ddZqw/6ZjMqOWbQV8t0TtjrWE=;
        b=cGjJ0P1V/ejP6XpS6pTvqW0+Rak5crvE0dpMXglt5y5lV4dIOm4wOxzKfzGutVYTlg
         Nu5RP2drKVbc8WvgKPIf6pHLDwsOWAI/7lLkpoUDItpPns561uKtfUhlAjjGRlUvT8Gq
         VqO8oND824Q2EWFSpLKkP239YnG8LlYOb3kS8lJ/b0LGC6HuByMlkI4UMySd6PwVqwRI
         ZqyMZiEDRj1M1WAdHyoKVhF9ceFfQtIzez4EaN87cAyjsBjJ0hFhorRv03e/lkQnPfHp
         izCBohRlA80yZmwO4BIyux0jvN/pzHpd5U4218/htq9gWdGcbQNvGVs4D/wAesTQJ10j
         DYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869953; x=1788474753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NfHSf/Xnpm7vI/oia3ddZqw/6ZjMqOWbQV8t0TtjrWE=;
        b=sEFXBXy6YLUHaz3EZFE2nLjKoHjrM62ZIWGrGaCPq/19MOYn7AE939VZIBfhKrWz8e
         1MtpI/O7FEoJL0+8/wbR/8h0mFlILKPlwm281ZzZ49krFW2iS6wqkybuokeh081LFwp/
         xpgrDd3ycsYBsukNnfB/hSDYWQm9r75dAtJhTWvhNrCMOkiz/+5fqC4IkozrkjUu8Sq+
         I7mKLxOJ0Vfv0c1kon22aOgkbSTwXO0c0r2l/eUMzQWDriY1z6oizNCdZc0LxfbcUYPF
         CK47ZqgTKWVv/81D6XTdc+ipgtkSZ0hTyYgEyvikPftFATS1H0og3Z9XCI8R70Tif26N
         yPMA==
X-Forwarded-Encrypted: i=1; AHgh+RqMfr1kRgkzGTS2cBl9bCcQhA+MuDjzxoxAnBoDW6LnnGinMvUki9Y8ZtC1K7uRGgLRqAfB1es=@vger.kernel.org
X-Gm-Message-State: AFuF++ngD8kWSfBwY6S6RCKLIU9ZOv505h4i2GEqZwG/zTm8EE00ks2u
	hPSJlNt86TWA6xZhqLveSxQOteKuSDkIR5lqk8xBKTDg9TQHlDFuKEcD
X-Gm-Gg: AR+sD11VLZ12JV4STOtfAXSV56Q/7JR9rCnVO5vKzggB95vzTc5xOAxGI/JwutubXKe
	Nm0F/WsAu4ko4aI8Tyv5lHkcsVNaK2K62h9NzrrVol/Kdz3Omf+4FxmD5lXu01z7rDkoLOLEabp
	Q7GGdykpoynVcEuJwYj7KgAirczvz/FWPFe5zHQdpSYQm5BJTLSn6NeOQIm+MFklhy1QsE5g1mt
	WlaQ8nYn8N92E0KA9UFsxbjR3eKLQXbHLsAsqoMdgF8NaqnkCspxccjBfj0ZYFr+GkG2h3YQ4So
	+MD77v4KImitA7dw+n3DAF0cwy/agBMyiRiGWHw2uPnWDbAbbFM0MA203UxtOT+iDbfO3MI7N85
	mZMaK1wj91IBpcOyN8dsNLEPDPxIyNUkMBOOb1zW+UYeoIDpWfTB3FjCU3Ip/JJOya+laW1e08Z
	9l+/YgNCtsONjt0sudQ2S1mPVPlY1F/zkmylM5aOxMy3w=
X-Received: by 2002:a05:600c:1d11:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49b91c25414mr28676775e9.7.1787869952896;
        Thu, 27 Aug 2026 15:32:32 -0700 (PDT)
Received: from krava ([77.78.87.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91ca11d0sm14821055e9.1.2026.08.27.15.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:32:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 28 Aug 2026 00:32:27 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Christian Simon <simon@swine.de>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	stable <stable@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
Message-ID: <apC6-9YqBpOjFLGr@krava>
References: <20260822225444.2774461-1-simon@swine.de>
 <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
 <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
 <CAADnVQKD1eOG7cnDHvFwfJOEGZ0g8wZKEzMri27en7uoA-MT5A@mail.gmail.com>
 <CAEf4BzaB+EDyf2exV8XGq_x4TvhTii7gJnWU0nq3380guaWF7Q@mail.gmail.com>
 <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com>

On Thu, Aug 27, 2026 at 09:55:08AM -0700, Alexei Starovoitov wrote:
> On Thu, Aug 27, 2026 at 9:40 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Aug 27, 2026 at 9:35 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Aug 27, 2026 at 7:56 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 25, 2026 at 6:20 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > > > > > A JITed BPF program can use one private stack per program and CPU.
> > > > > > Sleepable programs can be preempted, allowing another task to run the
> > > > > > same program on the same CPU. The second invocation then reuses and can
> > > > > > overwrite the first invocation's private stack.
> > > > >
> > > > > I'm confused by this. sleepable progs go through __bpf_prog_enter_sleepable_recur()
> > > > > which has per-prog recurison counter. So preemption of the prog
> > > > > doesn't break private stack.
> > > > > If the same prog attemps to execute on the same cpu it will be skipped.
> > > > >
> > > > > syscall prog types go via bpf_prog_run_array_sleepable()
> > > > > that have per prog recursions counter.
> > > > >
> > > > > Looks like we're not doing it for bpf_prog_run_array_uprobe().
> > > > > I'm not sure what the right trade off here.
> > > > > I feel universally checking for recursion is better
> > > > > then selectively disabling private stack for uprobe.
> > > >
> > > > I'd really like to avoid adding this "recursion protection" to uprobe.
> > > > With uprobes, there is no recursion, it's called from well defined
> > > > context in the kernel and you can't have recursive uprobe BPF
> > > > programs.
> > > >
> > > > All you can have is a very valid and possible sleepable uprobe
> > > > interleaving, which the user cannot prevent or work around, they have
> > > > no control over this and it's just a fact of life.
> > > >
> > > >  E.g., a simple scenario, we attach one bpf program (let's call it U)
> > > > to some USDT. BPF program U is sleepable and actually can sleep due to
> > > > page faults (e.g., unwinding Python stack trace requires sleepable
> > > > mode for reliably getting filename strings from Python runtime, which
> > > > are not always paged in).
> > > >
> > > > In such a case, you can have thread A and thread B both hitting the
> > > > same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
> > > > thread A hits it first on CPU X, BPF program U starts executing and
> > > > unwinding Python stack, does bpf_copy_from_user() for string contents
> > > > and causes page fault, is taken off CPU X. Meanwhile thread B hits
> > > > USDT on the same CPU X, kernel runs program U, and it is supposed to
> > > > work completely independently and concurrently (no shared state or
> > > > whatever) from U's execution in thread A.
> > > >
> > > > Yet, if we add this per-CPU "recursion check", we'll just skip U's
> > > > execution for thread B. This is data loss, and it's very bad in
> > > > practice because it frequently just invalidates the entire data
> > > > collection trustworthiness.
> > >
> > > ok. fair
> > >
> >
> > great, thanks!
> >
> > > > So I think we should disable private stack for uprobes (sleepable or
> > > > not) instead. I'm not sure private stack buys us anything for uprobe
> > > > cases.
> > >
> > > why disable priv stack for non-sleepable uprobes?
> > > While non-sleepable bpf prog is executing the same or different
> > > uprobe cannot execute on the same cpu.
> > > So bpf prog can be preempted by kernel execution,
> > > but a user task cannot start preempt bpf prog,
> > > so 2nd uprobe cannot start running,
> > > no?
> >
> > I think that changes on preemptible kernels, this was called out in
> > discussions on previous versions of this patch. So only for that
> > reason.
> 
> my understanding is that preemptable kernel doesn't mean that
> bpf prog can be preempted by user space.
> only by kernel.
> 
> I looked up earlier thread, but don't understand what Jiri meant.
> 
> Jiri,
> please clarify what problem do you see with non-sleepable uprobes?

hum.. non-sleepable uprobe prog is run by bpf_prog_run_array_uprobe
and it disables only task migration, preemption is not disabled and
holds rcu_read_lock (which seems ok for preemption)

so I'm not sure why it wouldn't be preemptible by another task

jirka
