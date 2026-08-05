Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBA37C92A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954913; cv=pass; b=RGR6aF9Vo7a6l0AqyiKpkPmiOa+pH255d14jWiLMTvL92bJhROu3J2fV1Xa8xafx/T4B/tZQtvBzrRjlotCIkkzkFHNUuWjnkyIqAF80b4xePSgzbZLGj4uT7FV1wTq3F+Z/bM/I2IgzhrVKLVCTTwbFVtq9PmfObQbvHesC6yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954913; c=relaxed/simple;
	bh=y7iDB2T1ItqNgNVxSxCRzMPlJGQiP3oIzeC9CjpbaeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/ghOh6splmMdnkMIDt8gASJD5mo0z08dsIfUtutj6PEm0019hS9/xncX7Ab9j1dblQGwXjIjxMn+zW0ZBHW3z5IcmKkJ4/34Ls0+t9jdRkhNLZ+GY7kWJnTeXoj8KXRS4xivhZVjSkVWBtakSV/qdwgW7qTuJCZzuGJBaBqOjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMomXlQ2; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMomXlQ2"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485b358552so1146516b3a.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 11:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785954912; cv=none;
        d=google.com; s=arc-20260327;
        b=GzYXiiOQz98cIiZV52NYnI67rwwTeSiawUJubvNbcTjKoK/YnH67Ge6IMET9GCRP1H
         EY0TTKSxgNEU/VrKivGdqJcTL/1eESbd91STpnTvzENe2TAFORvZ6Q6s8JpHBFFaBSCI
         eSeWi6hguOeBQ0K4CzAKpWy4jnPJwWAGKeDEYoFeQYOuNR0aBpe4+bmu+emDb/gkeSdW
         wlMv80jI1HxLF1x6T26/uFiqYARtqmYr6c5wYUWKATdeHKVOvA4iqDGik0Bx+OmDbC2b
         CKlA3bzo1MUh4OiuEC93sJ7n8kXNTr2BcNtMKn+NbRiuYc5SNeDB8GyMl/VJ4BvZSStR
         22vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=41qka+EIjjsEce/PTgUDMj48v0yLdWjZXwp+NSobgCM=;
        fh=NtUG6oiD7K24KGCmG8i5i7g4q3iRuN/2g3cVxldZwPw=;
        b=LOo+4NdnlDXsgReIwYA1V9GshHLjzbkh1OBXBYfA9wEwNRtjdeDUxPEY4uKD9UGKcx
         S1QAzIVBMnIbc2FriV5TWfOPwO5RiK92TcbDzfd0fVRvX2kgCq7TDIPwDapSlDZ5d+XV
         Ro+tKa6gmyQcr/1WehMWulunuyQw7Oa0g0kcZrx0qS9E6nfa/QH4a44P5rhLw7KcHOX3
         p5+zWZiv+LnTDZUsckcejw369kzGN1lArxkBGId80OJLyb1+7UDtJkue31awQZjMza8d
         ywBFCqdSqnRTTf9MiDZbuxVW3H9PW6+KOEPkzmc1p2gW4Awzt5/nk1gvMltznNDM1+Pg
         V91Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954911; x=1786559711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=41qka+EIjjsEce/PTgUDMj48v0yLdWjZXwp+NSobgCM=;
        b=rMomXlQ2hmX8MLnHl3cTIFLEmn8Rg3DVbHfF7+rIQSx7Q2jZzp174tEEW1a/BWO3NE
         rBNYjv1VqrVZUgz+XPvO6dHweoOLPNOHNunn5hWcrJ4BGY4fg7EpCWav11BKnj2x1JoL
         +AumRFEETL4a+cRwKsxtcU1k2XvPOFSdHmtYhrNtP5pgGedYo4aIezJZOgbRcedPc2lO
         BXkzC71snfZkXo44kuNfJGA1DnLrivdHXl7GUDEiyhIh3a2OwcGru2E6r/tzH9pSzlkT
         38wArcB0nLA71lDZpzNzqomhFN+01C73jenENwslTF02KHvQ86jpZgGNqPGVvDC6cl1p
         XX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954911; x=1786559711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41qka+EIjjsEce/PTgUDMj48v0yLdWjZXwp+NSobgCM=;
        b=kVmvpQ/+8MD3ciJKYlHUbaFm11AzfBKr3boCyb/z4bEUcffgPKCQ03nd2JOGefgZEM
         EElITLJ1HijoccR99oO0pXFk6vFcHSiRmIbLTeN+Po6NbBHvkwU44Z9P+L5k4+2jVypi
         wXi8OHMxxOKzBkE9lxGcb9cbOpEuzc2GOZPSv3q8+fnD/gNJ+YVToJZ9i4AsXMOBIXzy
         l5uHtYaxZS0A7mvesN3zUfUFQH48h9dSTH9k1ULQWQf8MP5Hz5mIXudsSIyICC688Jhf
         x2tWIyNoZj5uctVLkBJV26/3DKywiCOh8RQkzyRNyCo1kAjvx+zdZVbFKB0mv7PPuCjP
         jTDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrX/mCO0hkIFTSxFt0TzjQOG1sMwaz4CkeWgT7suiYSbqp7UN9lu7C9Qtc5pzIQCXCgTE4kVn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlgOUfBcbGyeXAhkVM6v8d7XOCLOI/eOome1DeGyDH4pyZrx/w
	uK0iEFw20RBgU82uW/NkhvUBADCw6dfG9AmvjpJicyYn8EXvL1d0921V9k4HEM7tC9a51yRy6N2
	2438J1h3ktN4vfdCRzTtKz+12/m27Imj07w==
X-Gm-Gg: AR+sD1053rxmO+i+6vUMbZ78jSSrUAzNldr9C1xKRpTMZYm3C6AyPzJdxZ/l/wyRo33
	BUfvURnEu48/F+dVs+vJbhOkXUeundkss9K6CofzqCgkAN6HoeSoI94BNorYKXMznfaTso8LgAY
	R/Oy8teWLlQRbmm6nMe4WVOFMjUinZ9moofKWv15D2gglULAuXEKKCKX3A/QoP8XSnijsosMX8c
	oRiJqg7GlMVPXEmk+QIld7/g3FWd8GI/ovRocbPLlUgpQHLHGxK6sja28VFrrxwJ67wWl/pwLzL
	peFdRPAkENdFPEhXVGtwMB88paOvNSSbpEcAtbDxVRRd7ADceskpXViFmY7LHjXb/d4PtAt5zjc
	4Cs8Vk7jibNrzpJwvy95Cfr/hcUsIiPgmnFmF
X-Received: by 2002:a05:6a00:32c4:b0:84e:2f2e:8c4f with SMTP id
 d2e1a72fcca58-84f2dfcf800mr10473335b3a.10.1785954911439; Wed, 05 Aug 2026
 11:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805092843.516315-1-jolsa@kernel.org> <20260805092843.516315-11-jolsa@kernel.org>
In-Reply-To: <20260805092843.516315-11-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Aug 2026 11:34:58 -0700
X-Gm-Features: AUfX_mwhD9_EnU4ed-9Qb7MSedhAwmUo5Ty62RDX4R8OXzlkjkFpkJucYw2PP34
Message-ID: <CAEf4BzZQXq5CNSkD4-gMOhs5+GU9Sf9Q7sHvLu1BkpqDTQHa5g@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 10/12] bpf: Disable preemption in __bpf_get_stack
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:30=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> From: Daniel Borkmann <daniel@iogearbox.net>
>
> get_perf_callchain() returns a per-CPU perf_callchain_entry buffer and
> releases its recursion slot via put_callchain_entry() before returning,
> so nothing keeps the entry reserved while __bpf_get_stack() consumes
> it below.
>
> A preemptible BPF program (e.g. a non-sleepable raw tracepoint program
> on a PREEMPT kernel, which runs under migrate_disable() but not
> preempt_disable()) can be scheduled out between obtaining the entry
> and the copy. Another task scheduled on the same CPU then reuses the
> same per-CPU buffer and overwrites trace->nr with a larger value.
> copy_len is then computed from the inflated trace->nr and can exceed
> the caller's buffer, causing an out-of-bounds write in the memcpy()
> and in the build_id path.
>
> The rcu_read_lock() taken here alone does not prevent this. It is
> only taken on the may_fault path, and under CONFIG_PREEMPT_RCU it does
> not disable preemption; it merely keeps perf's callchain buffer array
> alive (freed via call_rcu()) and does nothing to stop another task
> from reusing the entry.
>
> Disable preemption around obtaining the callchain entry and copying
> it into the caller's buffer, so the entry cannot be reused underneath
> us and trace->nr stays bounded by max_depth. Build ID resolution may
> fault and is therefore deferred until after preemption is re-enabled;
> by then the instruction pointers have already been copied into buf,
> so it operates only on that private copy. Note, preempt_disable() also
> subsumes the buffer-lifetime guarantee the rcu_read_lock() provided,
> since a preempt-disabled section is an RCU read-side critical section
> for the callchain buffers' call_rcu() reclaim.
>
> Cc: stable@vger.kernel.org
> Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
> Reported-by: Tao Chen <chen.dylane@linux.dev>
> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@=
linux.dev/
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> [ changed Fixes: commit ]
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/stackmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index eabeaef31b63..789fe35b893a 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -817,6 +817,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>
>         if (may_fault)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> +       preempt_disable();

nit: asymmetrical to preempt_enable, I'll move it to before
rcu_read_lock, so we can have proper nesting



>
>         if (kernel && task) {
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
> @@ -828,6 +829,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         if (unlikely(!trace) || trace->nr < skip) {
>                 if (may_fault)
>                         rcu_read_unlock();
> +               preempt_enable();
>                 goto err_fault;
>         }
>
> @@ -836,6 +838,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         /* trace should not be dereferenced after this point */
>         if (may_fault)
>                 rcu_read_unlock();
> +       preempt_enable();
>
>         return callchain_finalize(buf, size, trace_nr, elem_size, flags, =
may_fault);
>
> --
> 2.54.0
>
