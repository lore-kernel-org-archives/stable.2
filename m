Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6C73A75B6
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132977; cv=none; b=r9/IliVsiU0oDTtdORwtxK8Jss3BZDIPBqY7sCX6WgtaPMecZFZ+FMwHaX9Rg92dvQFQqE+MvTtGHSMXBhanBODtCK26nxzL9hsUabapMap3iocUAkqhaFdW878ISFLIrELbGQW7SYaPAZlquvmDMtEQCKmmO/RokkWoylo86nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132977; c=relaxed/simple;
	bh=SxcSQ1NSpSlgBCYxqD4dSZGF3j6hotDzPtKHdDh2lso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgZIhtsGmYWohvlVOOdToDi4dhpc5TyPE1jWMSV1RCVbhpty/BaV6tANIPX7Wqnj2mfEnFSdWgKhsnCL0mcRLuTbf5cZ+S/Q7lq2VJ5BEwpES8Df+npPteWd923GOY+NxLP7OnHB8t22MyKbj+m3/kpKPiU85tP3HXX78197ODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/B2MJUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/B2MJUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A581F00A3F
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782132975;
	bh=4kxQAJns5ULHTfmP/tLpdiKX20DeUmiIVMcduWLzqeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m/B2MJUtnvVLNSDh5h28f7WFIsl309t2NpBX1dQuZYia2gUm7ni/8kaVZCTNwcEBo
	 P7Q1wLc9BH0rfxDYBWJfsw9aomedqDDfwcqXLyG/nN/ONBBYcNkgKgTQWf5Ls9YIWX
	 M+A0cAwOs0D0KgHO0+Gc2VWyV+Lc2N58fEMsVMHmN4VlvhNEghIaF9sAuoXTnUH6ff
	 VqOw9gm29ZXZZ7fwnoQkMTFvV2DDmhNQZ+x1drL4Aq/bSzatmF44lyatMpmdH3GJTy
	 Hk6zr8PJoZVAskB6OvVynuDlzcEvgznRY12qV6ichNlQMRrmcy735mVBpEAL1gSi8v
	 A9quyuenbNlaw==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eeea039ebso2457622f8f.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:56:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+M4AaxD1/3CTtXnF9yE9GuYiRavO9i/4AJViFr4DeC6R8BNpSptOieGeHz+Omb2m8uuORuiLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NN+Xc2b9zlh9MJc4ojGtVmDOF2PpoWiFD+tYKn92uzYoGpVr
	5Woow6wNopp6mLOZrYGJ6NyDPtxYh1zLziVyb83TETKO2l/uTbk+istxSbXNUW3XfWcqIYhFo1Q
	IAhhbLUo9CkaJQFjSHiXafpYaB/6TN5k=
X-Received: by 2002:a05:600c:45d5:b0:490:bb3e:30c2 with SMTP id
 5b1f17b1804b1-4923f56c0bbmr212453205e9.18.1782132974312; Mon, 22 Jun 2026
 05:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622065910.3961592-1-chenhuacai@loongson.cn>
In-Reply-To: <20260622065910.3961592-1-chenhuacai@loongson.cn>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 22 Jun 2026 20:56:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSMwhSb3ho4u4EQGwGtcBx9OChrkgSThgUELs+rwWnEFA@mail.gmail.com>
X-Gm-Features: AVVi8CeE0VQzi5aGA_095-aPQbMrkVLvsIz2acGTxRFotKLzt7ZkzQ9Cm8qC1Z0
Message-ID: <CAJF2gTSMwhSb3ho4u4EQGwGtcBx9OChrkgSThgUELs+rwWnEFA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Report dying CPU to RCU in stop_this_cpu()
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 2:59=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> This is a port of MIPS commit 9f3f3bdc6d9dac1 ("MIPS: smp: report dying
> CPU to RCU in stop_this_cpu()"). smp_send_stop() parks all secondary
> CPUs in stop_this_cpu(). And the function marks the CPU offline for the
> scheduler via set_cpu_online(false) but never informs RCU, so RCU keeps
> expecting a quiescent state from CPUs that are now spinning forever with
> interrupts disabled.
>
> As long as nothing waits for an RCU grace period after smp_send_stop()
> this is harmless, which is why it went unnoticed. However, since commit
> 91840be8f710370 ("irq_work: Fix use-after-free in irq_work_single() on
> PREEMPT_RT"), irq_work_sync() calls synchronize_rcu() on architectures
> without an irq_work self-IPI, i.e. where arch_irq_work_has_interrupt()
> returns false. Any irq_work_sync() issued in the reboot/shutdown/halt
> path after smp_send_stop() then blocks on a grace period that can never
> complete, hanging the reboot:
>
>   WARNING: CPU: 0 PID: 15 at kernel/irq_work.c:144 irq_work_queue_on
>   ...
>   rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>   rcu: Offline CPU 1 blocking current GP.
>   rcu: Offline CPU 2 blocking current GP.
>   rcu: Offline CPU 3 blocking current GP.
>
> This issue needs some hacks to reproduce, and it was not noticed on
> LoongArch because arch_irq_work_has_interrupt() usually returns true.
>
> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring
> the generic CPU-hotplug offline path, so RCU stops waiting on the parked
> CPUs and grace periods can still complete. LoongArch shuts down all CPUs
> here without going through the CPU-hotplug mechanism, so this report is
> not otherwise issued.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() o=
n PREEMPT_RT")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index c191c680de66..5d792256bbb9 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -707,6 +707,7 @@ static void stop_this_cpu(void *dummy)
>         set_cpu_online(smp_processor_id(), false);
>         calculate_cpu_foreign_map();
>         local_irq_disable();
> +       rcutree_report_cpu_dead();
>         while (true);
>  }
>
> --
> 2.52.0
>
Thanks for the heads-up and the fix. The reasoning is clear =E2=80=94 the
parked CPUs never report quiescent state to RCU, which can stall grace
periods and hang the reboot path. The change looks correct and
minimal.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
