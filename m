Received: from mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0A52842F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688182; cv=none; b=Yc1tWgOSDPmAzjugfBs9T8ZGFfskgh7/PFU3SzIKwbfxJBr7QYQiCUjGVDRJzu4P4euq8hyyq2Wop3JWvz7nfdt11f/lYevEmWtgLT9ygvEpiHVcdjIbkwd+GE5e23JKe+pjDtnF548HoG8tQmnQgnsJ3bfnIgNzxNVcbkQ1Hk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688182; c=relaxed/simple;
	bh=A/v7LPhRkH6ascBEThHb/vODFW80MSZ8BAktCxFOPL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTE1nrszeSPKnPfg43lPI5BkdFLWhu6oBuFQT4Bue27OjLWv8xv4sf2A8RoNSTj68VH6dUZlSD5mpajipm+LjOctQU8UP3anhgvvrblrXFUwQv5+OC4ncR5UcwU5peFXrw/Pk14fLILTUeMKqqKw7CAvSaBoSGI64MBbio2qaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sMnCy4RM; arc=none smtp.client-ip=95.215.58.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sMnCy4RM"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A/v7LPhRkH6ascBEThHb/vODFW80MSZ8BAktCxFOPL4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790688178; v=1; x=1791292978;
 b=sMnCy4RMQuxkKRFgCROZurqm5EqnTEBqWha6eH4EYWLC/2kABJEDuDCQveePq9qDgcRqv3ni
 AAMVdiSv0Rd7EuKqlp7s3v5nR/a2mj6Ipg4GHEsJcMYWDBBTF0y/AUeBoBvIWklbd1cXsFfK7A7
 zUAaq4TXtuCk959S+qAiE/Uw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1fdefb5d1d58a880;
	Tue, 29 Sep 2026 13:22:58 +0000
X-Mizu-Trace-ID: 1fdefb5d1d58a880
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b8ea0ca5baso7695e87.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:22:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwgTo8qYrdovfTk1Mlxw93z5UTlF5XkYQRd4H3jq2NniFhnn3nOhXhngpoHvZVgD0wq6tE8oYA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhOQrVmXRIhprDqR/+Bk3AXSsVffzE4+UlPZzQjz8ayrniTocw
	78U/QALw+2HnhNIitmynY+V9r7R9uRP7cxS/0rGwDGsq2W8HPwEkkpZn6on01epvpkBfk4J/DdC
	MyHMQoH5tAvaMcHBcdefgKtWPIG0EB2lAxfUSs1JE
X-Received: by 2002:a05:6512:628d:b0:5ae:b1b3:145a with SMTP id
 2adb3069b0e04-5ba2e7b40d0mr148813e87.6.1790688173434; Tue, 29 Sep 2026
 06:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929093548.3598547-1-maz@kernel.org> <20260929093548.3598547-3-maz@kernel.org>
In-Reply-To: <20260929093548.3598547-3-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 29 Sep 2026 14:22:17 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzzX9g1+kgX_hBZ8gKQ1hbGbNjHrm0QMjQMmM0j-=SoXQ@mail.gmail.com>
X-Gm-Features: AclHuK_L9SaIlRtG-n3tXUkF9oIjgxk-0gMREksoQR95sfSSAdxHohLUu-uHe4Y
Message-ID: <CA+EHjTzzX9g1+kgX_hBZ8gKQ1hbGbNjHrm0QMjQMmM0j-=SoXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] KVM: arm64: Turn vcpu->arch.pause into a counter
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Yuchao Zhang <ndaugoing@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 10:36, Marc Zyngier <maz@kernel.org> wrote:
>
> We have situations where we can call kvm_arm_halt_guest() without
> holding config_lock, which means that halt and resume can overlap in
> funny ways when called from separate contexts, and result in situations
> where a vcpu is resumed while other parts of KVM assume it is halted.
> Consequences are left to the imagination of the reader.
>
> Fix this sorry situation by turning kvm_vcpu_arch::pause into an
> atomic counter, which makes the races described above harmless.
>
> Fixes: 3b92830ad41b2 ("KVM: arm/arm64: implement kvm_arm_[halt,resume]_guest")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba < fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  arch/arm64/include/asm/kvm_host.h |  7 +++----
>  arch/arm64/kvm/arm.c              | 21 ++++++++++++---------
>  2 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 27fe0cd5b2d7a..66ea2372f9870 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -889,11 +889,10 @@ struct kvm_vcpu_arch {
>         /*
>          * Don't run the guest (internal implementation need).
>          *
> -        * Contrary to the flags above, this is set/cleared outside of
> -        * a vcpu context, and thus cannot be mixed with the flags
> -        * themselves (or the flag accesses need to be made atomic).
> +        * Contrary to the flags above, this is updated outside of
> +        * a vcpu context, and thus cannot be mixed with the flags.
>          */
> -       bool pause;
> +       atomic_t pause;
>
>         /*
>          * We maintain more than a single set of debug registers to support
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 5f5dd8bead4b9..9a4871cd796bc 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -561,6 +561,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>         kvm_arm_pvtime_vcpu_init(&vcpu->arch);
>
>         vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
> +       atomic_set(&vcpu->arch.pause, 0);
>
>         /*
>          * This vCPU may have been created after mpidr_data was initialized.
> @@ -835,6 +836,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>         return ret;
>  }
>
> +static bool vcpu_can_run(struct kvm_vcpu *vcpu)
> +{
> +       return !kvm_arm_vcpu_stopped(vcpu) && !atomic_read(&vcpu->arch.pause);
> +}
> +
>  /**
>   * kvm_arch_vcpu_runnable - determine if the vcpu can be scheduled
>   * @v:         The VCPU pointer
> @@ -850,8 +856,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>                       (kvm_timer_should_notify_user(v) ||
>                        kvm_pmu_should_notify_user(v)));
>
> -       return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
> -               && !kvm_arm_vcpu_stopped(v) && !v->arch.pause);
> +       return ((irq_lines || kvm_vgic_vcpu_pending_irq(v)) && vcpu_can_run(v));
>  }
>
>  bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
> @@ -1014,7 +1019,7 @@ void kvm_arm_halt_guest(struct kvm *kvm)
>         struct kvm_vcpu *vcpu;
>
>         kvm_for_each_vcpu(i, vcpu, kvm)
> -               vcpu->arch.pause = true;
> +               atomic_inc(&vcpu->arch.pause);
>         kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
>  }
>
> @@ -1024,8 +1029,8 @@ void kvm_arm_resume_guest(struct kvm *kvm)
>         struct kvm_vcpu *vcpu;
>
>         kvm_for_each_vcpu(i, vcpu, kvm) {
> -               vcpu->arch.pause = false;
> -               __kvm_vcpu_wake_up(vcpu);
> +               if (atomic_dec_and_test(&vcpu->arch.pause))
> +                       __kvm_vcpu_wake_up(vcpu);
>         }
>  }
>
> @@ -1033,11 +1038,9 @@ static void kvm_vcpu_sleep(struct kvm_vcpu *vcpu)
>  {
>         struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
>
> -       rcuwait_wait_event(wait,
> -                          (!kvm_arm_vcpu_stopped(vcpu)) && (!vcpu->arch.pause),
> -                          TASK_INTERRUPTIBLE);
> +       rcuwait_wait_event(wait, vcpu_can_run(vcpu), TASK_INTERRUPTIBLE);
>
> -       if (kvm_arm_vcpu_stopped(vcpu) || vcpu->arch.pause) {
> +       if (!vcpu_can_run(vcpu)) {
>                 /* Awaken to handle a signal, request we sleep again later. */
>                 kvm_make_request(KVM_REQ_SLEEP, vcpu);
>         }
> --
> 2.47.3
>
