Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1BB353A7A
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620742; cv=none; b=bFU4RTbQP7ppo3oMysrCqNgLrjl/5SVom8T0i76bbm6CSybao4HJ5WOL1pX+PhHRebKj+ux1YQ7JOeCpIWYs8/mWq5IG4eyLLqg+tKquIuWwCe4MGr2MNKJ1huFiGd8Ok9wPQXceQZaTecGKiShZjkRiyDhfsg4ynJPribEbC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620742; c=relaxed/simple;
	bh=yQX0pN/kRO1NwvgfUxNl+jugCOWG6zLB4VuV/c6J+bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtZi+Fj035xjaXDS9FPShbKy8z19CTtvaBpjmyefCBSbKXOQBak3dNh7IkL8oY0IP+Y8Y9an4FZM2HYelUuX17R89iHNT5VrmV1LhI+OpYQVoe/14Hw5QAqOmtpVtG7jNm9Ko6qaNeaZPhkvNjRF/BEnDhOTiy3zcwkLMdkcVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn7qbPHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn7qbPHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DCC1F00A3F
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788620740;
	bh=/jZ9KGVQ5iKPjZkKaI8bnnI5o0Vm2Cvi//ZuID7cLv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bn7qbPHl/LyTiyne76i581lMejAG7Em4Cmjt07J/egiYOI3ajCBzj5KN3rQMCGtju
	 cH8oa7s6dEN4JRlVtARQzLjC1fT1k9UbcpgdsS3P3yqOHYe0fJ5l56AgcXHC3qIfgm
	 ecsejymKVUB9C5/QbFIGaN8HCnEn8ObM+AsrHxPoS3QZ+VixD3kp9mDFVJzwifUCmb
	 Utk8pKStemd/3Cd/vJCQxtFmjGkiAHcRb9t4qylzZFjVb0S05QA7yjxL/jm3PQhoQT
	 Yq1QcsmY+yKX0uG9yTf5vokKK+Z0beOHWrZkC1eIkVwc3uua1755goO1WaeROhDiS6
	 1j584kdGnpIyA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2488458a12.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 08:05:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMdKEjOZ1vvLiJS4rJC8LgakAcmHeRLXiVYQRGvy/CeGJARovlrCYKfeCn+s9Pgws+j/hE2VQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nX/YRnkxkbEkqMtgyrPPWlHK6OTlRSg4k7OSgCLNhlOGY2lUNe
	AxwCW1o4RMrpi3J/rlsvjLa87pAxDL21wHA8nEObVy/k/lRhWfjvQrNbCM8vUzu9JOM3yNrHRv6
	GabKciOgglJ9fi7Spa5GhGy8wTC1dGJg=
X-Received: by 2002:a05:6402:21cd:b0:6a3:87b7:b5a9 with SMTP id
 4fb4d7f45d1cf-6a7e90aacd1mr4325493a12.12.1788620739425; Sat, 05 Sep 2026
 08:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825014806.3926864-1-guanwentao@uniontech.com>
In-Reply-To: <20260825014806.3926864-1-guanwentao@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 5 Sep 2026 23:05:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Bz3JWc=JkP99PVPe6iVNONMGEb557gyO-rKvJkjSksA@mail.gmail.com>
X-Gm-Features: AcwNN1XPmEoTBWfKY8iGGv9aogL8vaUXzAChR0jViYazGj0pg3-Omt5_OV3fB00
Message-ID: <CAAhV-H4Bz3JWc=JkP99PVPe6iVNONMGEb557gyO-rKvJkjSksA@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: rethook: Do not save/restore percpu base
 register in trampoline
To: Wentao Guan <guanwentao@uniontech.com>
Cc: kernel@xen0n.name, yangtiezhu@loongson.cn, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Tue, Aug 25, 2026 at 9:48=E2=80=AFAM Wentao Guan <guanwentao@uniontech.c=
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
> change it (kernel C code cannot write a global register variable). The
> same flaw existed in the pre-rethook kretprobe trampoline since v6.3;
> it was carried over when rethook replaced it. Drop both the save and
> the restore. Drop the restore to solve the issue, and drop the save
> to keep the code tidy and for a privileged reader, neither matters much,
> so no need to clear it.
>
> Fixes: 3f5536860086d ("LoongArch: Add kretprobes support")
> Cc: stable@vger.kernel.org # v6.5+
> Assisted-by: Kimi:Kimi-K3 # debug and root-cause analysis
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> changelog v3:
> return to v1 patch, remove the save/restore both.
> Drop the restore to solve the issue, and drop the save
> to keep the code tidy and for a privileged reader, neither matters much,
> so no need to clear it.
>
> changelog v2:
> according sashiko report, keep cfi_st u0, PT_R21
> Link: https://sashiko.dev/#/patchset/20260824082524.3801394-1-guanwentao%=
40uniontech.com
>
> v1 link:
> https://lore.kernel.org/loongarch/20260824082524.3801394-1-guanwentao@uni=
ontech.com/T/#u
> ---
> ---
>  arch/loongarch/kernel/rethook_trampoline.S | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/rethook_trampoline.S b/arch/loongarch/=
kernel/rethook_trampoline.S
> index 2e009fbea53f2..1601894446845 100644
> --- a/arch/loongarch/kernel/rethook_trampoline.S
> +++ b/arch/loongarch/kernel/rethook_trampoline.S
> @@ -24,7 +24,6 @@
>         cfi_st  t6, PT_R18
>         cfi_st  t7, PT_R19
>         cfi_st  t8, PT_R20
> -       cfi_st  u0, PT_R21
>         cfi_st  fp, PT_R22
>         cfi_st  s0, PT_R23
>         cfi_st  s1, PT_R24
> @@ -59,7 +58,6 @@
>         cfi_ld  t6, PT_R18
>         cfi_ld  t7, PT_R19
>         cfi_ld  t8, PT_R20
> -       cfi_ld  u0, PT_R21
>         cfi_ld  fp, PT_R22
>         cfi_ld  s0, PT_R23
>         cfi_ld  s1, PT_R24
> --
> 2.30.2
>
