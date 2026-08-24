Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7613EC685
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564680; cv=none; b=fxqtBYQE0qjgv4qEPjYC1wp0CzsqgYq3dyc0M8YsHbp7FvoC4yxf+Nr/rbRwdzaopZ6iPyGXTVnQeLHAt/49udfG5W4tSdEvCgjAoBLLrmu5+klRpXdmxtivyqSYfa9bXzm90x3gtseG+H43UNe1ZF6EtebsbrJjREQFTagYB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564680; c=relaxed/simple;
	bh=LT3f8R4EhrNeK9o9qYtC2RxZDSoShR4tG/NsoTDCpq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWaFFrnMsFvtYnFDyOXiO6gfyhiqzf9Yu52RqkJA4VTu6JV3xsIAlw2puBAnmoHqKT/8BIJNf90AA/9StfWUNa9FKL+/e2jqHE8lRB65dEjQVPivpjw9rhBTiiSsvWpDHxid5YVNqDOwVCFbO4aY68/P/cH3e1EIuue5jD6/CIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FesdooMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FesdooMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02BB1F00A3A
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787564676;
	bh=WG5UuXNQ5Bw4+uoqYB0cYhO/66ndwt+J+PmLGUGsLkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FesdooMAINCdqFFP0VjP3ZGuxwWvkyyHwfZritUZT9/zJlp032waMfxa0+hp+ZbzE
	 gUyfaHbTsL0WHZENFX9pALETOvX1x14z1pERlp3uJgdoN3O0F0hn6NXgq5FElolJVS
	 k7y5BX2xLTuHyNZU6kEumqCVUbA9u4PIT1QPqh6Ar0XiftPOKDF/GA20F9ItPHOHG1
	 /dT1plTsH91BEVNhkuWAL94wmYvPEYBdRIXW8eccqHna0/SwsMsdn5B1w7AXernQvH
	 AVQLGY0LzZC24FQMkBkK/JpGxbbqdlYzYjerhQ8/9E9hZnGyJdWKa51M49jkUc40Q2
	 9PXR1KFPWt4VA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so364814866b.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:44:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq6mOvXseFtNJm+l/OAcJTZ5ZrIQm5z+q7Mf61fl1MYGypStyRcYEcYC0RUSAG61KqmrWMXUJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lTN2KxqgCa+25qr5oI1D2gjegWtOjuGUPkUWFv1mfNmcj1ILsH
	Ru5NQL6jcUmo4Tlo0Ry0V2S8+0hWIhBcLhTOKkj9Lq73Xd3yCKdsRsQRTgOA1irSRA6vh8XZzZ2
	IykHEW6NM+kRy18L8Fm4f0iyHKxIevlU=
X-Received: by 2002:a17:906:9c8a:b0:c21:792:8257 with SMTP id
 a640c23a62f3a-c246a5f67e6mr2786311766b.15.1787564675379; Mon, 24 Aug 2026
 02:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824093348.3814991-1-guanwentao@uniontech.com>
In-Reply-To: <20260824093348.3814991-1-guanwentao@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 24 Aug 2026 17:45:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7dO4V_McOvX-KyPXEwGHvu8n1inMcdVFyKLof7_Qfh3A@mail.gmail.com>
X-Gm-Features: AcwNN1WY4Y2F3GnJSwlJflZVyhCOGYQ2VT_50CElsxSA0lflAqKg3a1cmmaaNXM
Message-ID: <CAAhV-H7dO4V_McOvX-KyPXEwGHvu8n1inMcdVFyKLof7_Qfh3A@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: rethook: Do not restore percpu base
 register in trampoline
To: Wentao Guan <guanwentao@uniontech.com>
Cc: kernel@xen0n.name, yangtiezhu@loongson.cn, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Wentao,

On Mon, Aug 24, 2026 at 5:34=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> The rethook trampoline saves $r21 ($u0), the percpu base, into its
> frame at entry and restores it at exit. In between,
> rethook_trampoline_handler() may schedule via preempt_enable_notrace();
> if the task migrates to another CPU, the frame's $r21 names the old
> CPU's percpu base, and restoring it poisons $r21 on the new CPU. Until
> the next user->kernel transition heals $r21, this_cpu_*() accesses
> (runqueues, RCU per-CPU data, timer tick programming, FPU ownership)
> hit the wrong CPU's percpu area.
>
> Under kretprobe-heavy preemptible load this corrupts scheduler and
> timer state: scheduling-while-atomic splats, wrong-CPU RCU warnings,
> WARN_ON_ONCE(rq !=3D this_rq()) in nohz_balance_exit_idle(), and CPUs
> parking in the idle loop with the constant timer never re-armed (hard
> lockup). Reproduces on a Loongson-3A6000 with kretprobes on VFS paths
> plus heavy file churn (OS install / unsquashfs).
>
> By convention $r21 always holds the current CPU's percpu base in kernel
> mode: exception entries reload it only when coming from user mode, and
> RESTORE_SOME() restores it only when returning to user mode; the
> context-switch path never writes it. The live $r21 at trampoline exit
> is therefore already correct, and nothing in between can legitimately
> change it (kernel C code cannot write a global register variable).
> Drop the restore; keep the save so that the pt_regs view handed to
> handlers stays fully initialized.
>
> The same flaw existed in the pre-rethook kretprobe trampoline since
> v6.3; it was carried over when rethook replaced it.
>
> Fixes: 3f5536860086d ("LoongArch: Add kretprobes support")
> Cc: stable@vger.kernel.org # v6.5+
> Assisted-by: Kimi:Kimi-K3 # debug and root-cause analysis
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> changelog v2:
> according sashiko report, keep cfi_st u0, PT_R21
> Link: https://sashiko.dev/#/patchset/20260824082524.3801394-1-guanwentao%=
40uniontech.com
I don't think AI is correct here, if "leaking" a random stack value is
unacceptable, then "leaking" $r21 is better?

Huacai

>
> v1 link:
> https://lore.kernel.org/loongarch/20260824082524.3801394-1-guanwentao@uni=
ontech.com/T/#u
> ---
> ---
>  arch/loongarch/kernel/rethook_trampoline.S | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/rethook_trampoline.S b/arch/loongarch/=
kernel/rethook_trampoline.S
> index 2e009fbea53f2..94adead8faa5c 100644
> --- a/arch/loongarch/kernel/rethook_trampoline.S
> +++ b/arch/loongarch/kernel/rethook_trampoline.S
> @@ -59,7 +59,14 @@
>         cfi_ld  t6, PT_R18
>         cfi_ld  t7, PT_R19
>         cfi_ld  t8, PT_R20
> -       cfi_ld  u0, PT_R21
> +       /*
> +        * $r21 ($u0, percpu base) is deliberately not restored: in kerne=
l
> +        * mode it must always hold the current CPU's percpu base, and
> +        * restoring it from the frame would poison it with the old CPU's
> +        * base if the handler scheduled and we migrated.  The save side
> +        * stays so that the pt_regs view handed to handlers remains full=
y
> +        * initialized.
> +        */
>         cfi_ld  fp, PT_R22
>         cfi_ld  s0, PT_R23
>         cfi_ld  s1, PT_R24
> --
> 2.30.2
