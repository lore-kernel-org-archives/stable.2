Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84C3876B2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033261; cv=pass; b=b3kSQKGou3t4groZqXPneejmgpTF0y8eOoxXPeOOOAmW+2FyZE7rxquyIrhCYrDz5uU1ACRGMVFoGxl4aIsPmYNrPVHaxSGZ5N5p9A/1hYrY+jTKxS7iFMASRBBVppIBmJK+ewApogJNkHnN9QGuZOnWckIrfwb0wO9/0O0dxxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033261; c=relaxed/simple;
	bh=RuqLXsxZPv3YMVww/mAtq9WhAoD2f2lB0hq1V0bjgJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TC1ajKCh3C3yv5Q7zivupAoFMYGjv1fla65gpUJ1i28uKRF8dz3LnDB014xb9OmWpxD3C3N1amQADVimzR0ryPRv18ps6sLrpH8eUTYe+RJnsGeaMCymNWMuMPHAEVwZs6+q2MtXUUkVWhwGKmaRJgiasLfOq4HnhLXcrK2g4gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=IzAx0gVw; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="IzAx0gVw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so17380035e9.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 05:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784033254; cv=none;
        d=google.com; s=arc-20260327;
        b=kKx3IEOvltKu/5KtEdlrjfG9odA8+TC0rHjBFQvWKczBG1QKPNTR7U/rY937qd/qQT
         spHdeorBfItdgECnxHdfvFZJ+UncD28MZTaDqotgwIWvbpkRlBnRI4bQQ7xlRpVRLXS/
         zvBY94ko1SEOPBRxbMyWeBlXfJj/jFzjY859jJg7C0vfX566ij/b7MURlsc2SZ1/IrSD
         X4Q+nKjR0nUrxPAnxSRXt5hCoZEPW/Hl68q91BwOZRG5svdoYOnMtFpyXOnMQKTZQqen
         I9SxQwVUyFbqkLFuAzyQ15fWEQQ0Y3uYTatUiP2MLHakJXU9aSMw8YQegdxkXgynO5kp
         hWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/MNDNgK0tsUOm39QwXFRh2unzQxty2TQlHHny1SWiM=;
        fh=UkyKK7KFpz9U41C+HjEB61YExNSyIj+8YRVRIxEXRbs=;
        b=KNE1WewN5zii1p7oie7HDmU84PBSn6/RIRnJ6EVD1cmRktSRVumfuYqn0nfUl3AQhm
         vUNdFhw8H6bzaI0MF1A+qaKT9qjnVIFfPsPqmF5Yod6Y8xYM9nlc3Un3JIxA2kKZz92A
         Gkrj/FiJ6CVA9yvtXwdOll/aqS82zr/aGgR95NeaQ0QwN7By48X02hsAGAQ1ls65baHi
         cPn8400v7TxfW0U2mNUmyX0BZwcQM/0c6oA/+DfNaXbpBHfLh5byTr7tdMmDucBxbGor
         sqq60n9MUoi9LyqtHvjs4EGBs9Ul1PF2fJdJrpSWYy0fShNddanF0I3zgJwVr9pqIARL
         C69Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1784033254; x=1784638054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V/MNDNgK0tsUOm39QwXFRh2unzQxty2TQlHHny1SWiM=;
        b=IzAx0gVwjmRAyNbVa3pxEsfWbEDQH8Avh0cwZ2qX+2BOglAM+cMB206vRlBTOrrH0e
         XhJ6PQDqTbufEtjSPOlctxLZ+smAv9/u0o60k1Q+gJFNUMr9jVypft70IxyKQ3r3FxSA
         cNnx5tCMeT0VMJRu0RAzvvnOzJnLzncxqJxqVtuZ0+qrVSRQPEfUtanZYU+QtWr4ERl/
         siTnurggfVKDHIdNgkd51kXki4n5iHD9nztg/ykjQ/d3mMTa/Dbell+NgEWNUJ89+xcf
         l4glHaVBuipx+AcrM0VzVexir8V7h67oW8gZl3JmGKGF5Ab4JW33wjf6s3u/uIUR4pDb
         FFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033254; x=1784638054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/MNDNgK0tsUOm39QwXFRh2unzQxty2TQlHHny1SWiM=;
        b=ZxLpuafHVEdA7jlbjhnjXlBTZ6v0KL584Cou27zABdxreMI+J53XF8B7MKBvQeY6G2
         rMWfTB6GN1oVVZ0sUfc/b0XcgtAE3gmmteTjC7ZUtJKYOXYEsv7sD3ejcXNWQD5wr1rV
         /8y7DMJwzv9PXUjeTy7vdr+xvrBQDZAafBSBj3CLIAlCaRuDGqFqjYr4rmYhY8Qti84X
         yObkB7Vtx4Qq61uMIb/mYBcBUu1/eNzKxvpghh737TAnHE0j6GvV3kF9plrKvTmZWRTk
         Aga6UBOv3rnqmBPrzU5TknWcn1G93O5rmB/AyLHg8o9LyIT3+AbDxyfEdq/ngSaArSbn
         kcpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCCVkPZSEcdvB91LoHXJvSH9Zhs9PSTBI90m5XL+ZVoaiapAWWf68XiakFyHbgew5/6NXdQZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94OnSkMPOinjs4JEnueA8UMWf0CklodxqHEuzrg1nmCIyWRbM
	b37MH1F8bFyF7ze6g0xj1msZPfPaP/acC/0E1ZDQ2mPZeP8EEZXLuJDHY7/NGqBjAxZybOKg/V5
	M7U0vAvVYGYfjQEc3rOG7MQ18xVFdNumhPuFy/YyEDg==
X-Gm-Gg: AfdE7cmPGZyjxKJb0nMDDtvknhhRBGXs+PkqeyQp+kbepMyMTV4RExwILHCfVFRz2WF
	klwuzU5YtmKSn20IKcW5qP0HqaIN9yWqmMjdQTHDQv3Sk3qhX6IO1zFV1GKmukBGRwMScWWkVEm
	/1sn3XXGEHLN1oiTeW+lJR3tr8zSIRKcHvTqzX+10F1x1yYgZUTvh3BtGZylRVd9GUVXgLRTAHT
	QaQOEudDvLYjXdHf1W3mEney7pvCyYTqFoe3qfyBTYuVWMk7+O+KrLr2qShn1R+7HH1tw7tJ++x
	MnrUEPRtPUIAZmZzBmAmmuSHiScHArLnc7+45SSQ8gnMvyscwypSkyDUnLh/J8WYzyfWDtLgizp
	/2cXozOBQWCM4Etc=
X-Received: by 2002:a05:600c:285:b0:495:8a1:7670 with SMTP id
 5b1f17b1804b1-495093a0d3amr26269855e9.35.1784033254027; Tue, 14 Jul 2026
 05:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178159067899.108868.8176174463274678253@ultrarisc.com>
 <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
 <20260713073346.1293408-1-xb@ultrarisc.com> <20260713073346.1293408-2-xb@ultrarisc.com>
In-Reply-To: <20260713073346.1293408-2-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 14 Jul 2026 18:17:18 +0530
X-Gm-Features: AUfX_mxbLiprqaTisutAbzYiymshMJFela08xtbT5r4jUbiVD4jCK0B3FsskWws
Message-ID: <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: KVM: Serialize virtual interrupt pending state updates
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:04=E2=80=AFPM Xie Bo <xb@ultrarisc.com> wrote:
>
> RISC-V KVM tracks guest interrupt state with two bitmaps:
>
>   - irqs_pending: interrupts that should be visible to the guest
>   - irqs_pending_mask: interrupts whose pending state changed
>
> The current code updates those bitmaps with independent atomic bitops
> and assumes a multiple-producer, single-consumer protocol. That model
> does not actually hold.
>
> kvm_riscv_vcpu_sync_interrupts() is not a pure consumer. When the guest
> changes guest-visible HVIP state, sync_interrupts() writes both
> irqs_pending and irqs_pending_mask to reflect the new guest state back
> into KVM state. As a result, irqs_pending and irqs_pending_mask form a
> single logical state transition, but they are not updated atomically as
> a pair.
>
> This allows a race where a newly injected interrupt is lost. For
> example:
>
>   CPU0                              CPU1
>   ----                              ----
>   kvm_riscv_vcpu_set_interrupt(VS_SOFT)
>     set_bit(VS_SOFT, irqs_pending)
>                                     kvm_riscv_vcpu_sync_interrupts()
>                                       sees guest-cleared HVIP.VSSIP
>                                       sets irqs_pending_mask
>                                       clears irqs_pending

s/clears irqs_pending/clear_bit(IRQ_VS_SOFT, irqs_pending)

>     set_bit(VS_SOFT, irqs_pending_mask)
>     kvm_vcpu_kick()
>
> After that interleaving, a later flush can update HVIP without VSSIP
> even though a new virtual interrupt was injected. In practice, the
> guest can remain blocked in WFI with work pending.
>
> The same pending/mask protocol is shared by VS soft interrupts, PMU
> overflow delivery, and AIA high interrupt synchronization, so the race
> is not limited to one interrupt source.
>
> Fix this by serializing all updates to irqs_pending and
> irqs_pending_mask with a per-vCPU raw spinlock. This keeps the pending
> bit and the dirty mask as one state transition across:
>
>   - set/unset interrupt
>   - guest HVIP sync
>   - interrupt flush to guest CSR state
>   - vCPU reset
>   - AIA CSR writes that clear dirty state
>
> Use non-atomic bitmap operations while holding the lock. Hold the lock
> across the AIA sync, flush, and pending checks as well, so both bitmap
> words share the same serialization domain.
>
> This intentionally replaces the existing lockless protocol instead of
> trying to repair it with additional barriers. The problem is not memory
> ordering on a single field; it is that two separate bitmaps encode one
> shared state machine while both producers and sync paths can modify
> them. A per-vCPU raw spinlock keeps the fix small, local, and suitable
> for backporting.
>
> Fixes: cce69aff689e ("RISC-V: KVM: Implement VCPU interrupts and requests=
 handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
> Changes in v4:
> - Split the AIA pending bitmap check from the IMSIC VS-file check.
> - Release irqs_pending_lock before the IMSIC check takes vsfile_lock,
>   avoiding sleep-in-atomic on PREEMPT_RT and an ABBA lock ordering cycle.
>
> Changes in v3:
> - Rebase onto Linux 7.2-rc3.
> - Use non-atomic bitmap operations under irqs_pending_lock.
> - Hold irqs_pending_lock across the AIA sync/flush helpers and add
>   lockdep assertions for their locking contract.
> - Protect kvm_riscv_vcpu_has_interrupts() with irqs_pending_lock.
>
> Changes in v2:
> - Expand the race description and user-visible failure mode.
>
>  arch/riscv/include/asm/kvm_aia.h  |  2 +
>  arch/riscv/include/asm/kvm_host.h | 10 ++---
>  arch/riscv/kvm/aia.c              | 45 +++++++++++++++-----
>  arch/riscv/kvm/vcpu.c             | 69 +++++++++++++++++++++----------
>  arch/riscv/kvm/vcpu_onereg.c      | 13 ++++--
>  5 files changed, 99 insertions(+), 40 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kv=
m_aia.h
> index c67ec5ac0a1..1fe146675e2 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -124,6 +124,8 @@ static inline void kvm_riscv_vcpu_aia_sync_interrupts=
(struct kvm_vcpu *vcpu)
>  {
>  }
>  #endif
> +bool kvm_riscv_vcpu_aia_has_pending_interrupts(struct kvm_vcpu *vcpu,
> +                                              u64 mask);
>  bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);

This split is looking very ugly and unmaintainable.

For now, let's not split kvm_riscv_vcpu_aia_has_interrupts() instead let
kvm_riscv_vcpu_aia_has_interrupts() explicity take irqs_pending_lock.

>
>  void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu);
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 60017ceec9d..e2d5808169e 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -209,13 +209,13 @@ struct kvm_vcpu_arch {
>         /*
>          * VCPU interrupts
>          *
> -        * We have a lockless approach for tracking pending VCPU interrup=
ts
> -        * implemented using atomic bitops. The irqs_pending bitmap repre=
sent
> -        * pending interrupts whereas irqs_pending_mask represent bits ch=
anged
> -        * in irqs_pending. Our approach is modeled around multiple produ=
cer
> -        * and single consumer problem where the consumer is the VCPU its=
elf.
> +        * The irqs_pending bitmap represents pending interrupts whereas
> +        * irqs_pending_mask represents bits changed in irqs_pending. Upd=
ates
> +        * to these bitmaps are serialized so vcpu interrupt sync/flush c=
annot
> +        * drop a newly injected interrupt while syncing guest-visible HV=
IP.
>          */
>  #define KVM_RISCV_VCPU_NR_IRQS 64
> +       raw_spinlock_t irqs_pending_lock;
>         DECLARE_BITMAP(irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
>         DECLARE_BITMAP(irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index bafb009c5ce..001e83032f6 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -53,12 +53,15 @@ void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_v=
cpu *vcpu)
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>         unsigned long mask, val;
>
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
> +
>         if (!kvm_riscv_aia_available())
>                 return;
>
> -       if (READ_ONCE(vcpu->arch.irqs_pending_mask[1])) {
> -               mask =3D xchg_acquire(&vcpu->arch.irqs_pending_mask[1], 0=
);
> -               val =3D READ_ONCE(vcpu->arch.irqs_pending[1]) & mask;
> +       mask =3D vcpu->arch.irqs_pending_mask[1];
> +       if (mask) {
> +               vcpu->arch.irqs_pending_mask[1] =3D 0;
> +               val =3D vcpu->arch.irqs_pending[1] & mask;
>
>                 csr->hviph &=3D ~mask;
>                 csr->hviph |=3D val;
> @@ -69,23 +72,35 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vc=
pu *vcpu)
>  {
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
> +
>         if (kvm_riscv_aia_available())
>                 csr->vsieh =3D ncsr_read(CSR_VSIEH);
>  }
>  #endif
>
> -bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
> +bool kvm_riscv_vcpu_aia_has_pending_interrupts(struct kvm_vcpu *vcpu,
> +                                              u64 mask)
>  {
> -       unsigned long seip;
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
>
>         if (!kvm_riscv_aia_available())
>                 return false;
>
>  #ifdef CONFIG_32BIT
> -       if (READ_ONCE(vcpu->arch.irqs_pending[1]) &
> +       if (vcpu->arch.irqs_pending[1] &
>             (vcpu->arch.aia_context.guest_csr.vsieh & upper_32_bits(mask)=
))
>                 return true;
>  #endif
> +       return false;
> +}
> +
> +bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
> +{
> +       unsigned long seip;
> +
> +       if (!kvm_riscv_aia_available())
> +               return false;
>
>         seip =3D vcpu->arch.guest_csr.vsie;
>         seip &=3D (unsigned long)mask;
> @@ -207,6 +222,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
>  {
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>         unsigned long regs_max =3D sizeof(struct kvm_riscv_aia_csr) / siz=
eof(unsigned long);
> +#ifdef CONFIG_32BIT
> +       unsigned long flags;
> +#endif
>
>         if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
>                 return -ENOENT;
> @@ -216,11 +234,18 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcp=
u,
>         reg_num =3D array_index_nospec(reg_num, regs_max);
>
>         if (kvm_riscv_aia_available()) {
> -               ((unsigned long *)csr)[reg_num] =3D val;
> -
>  #ifdef CONFIG_32BIT
> -               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph))
> -                       WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
> +               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph)) {
> +                       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lo=
ck, flags);
> +                       ((unsigned long *)csr)[reg_num] =3D val;

The hvip in guest context is not under critical section so don't bring hvip=
h
under critical section.

> +                       vcpu->arch.irqs_pending_mask[1] =3D 0;
> +                       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pendi=
ng_lock,
> +                                                  flags);
> +               } else {
> +                       ((unsigned long *)csr)[reg_num] =3D val;
> +               }
> +#else
> +               ((unsigned long *)csr)[reg_num] =3D val;
>  #endif
>         }
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e..99c929ec0ac 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -80,6 +80,7 @@ static void kvm_riscv_vcpu_context_reset(struct kvm_vcp=
u *vcpu,
>
>  static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_res=
et)
>  {
> +       unsigned long flags;
>         bool loaded;
>
>         /**
> @@ -104,8 +105,10 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vc=
pu, bool kvm_sbi_reset)
>
>         kvm_riscv_vcpu_aia_reset(vcpu);
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         bitmap_zero(vcpu->arch.irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
>         bitmap_zero(vcpu->arch.irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS)=
;
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         kvm_riscv_vcpu_pmu_reset(vcpu);
>
> @@ -151,6 +154,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>
>         /* Setup VCPU hfence queue */
>         spin_lock_init(&vcpu->arch.hfence_lock);
> +       raw_spin_lock_init(&vcpu->arch.irqs_pending_lock);
>
>         spin_lock_init(&vcpu->arch.reset_state.lock);
>
> @@ -352,10 +356,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcp=
u *vcpu)
>  {
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>         unsigned long mask, val;
> +       unsigned long flags;
>
> -       if (READ_ONCE(vcpu->arch.irqs_pending_mask[0])) {
> -               mask =3D xchg_acquire(&vcpu->arch.irqs_pending_mask[0], 0=
);
> -               val =3D READ_ONCE(vcpu->arch.irqs_pending[0]) & mask;
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       mask =3D vcpu->arch.irqs_pending_mask[0];
> +       if (mask) {
> +               vcpu->arch.irqs_pending_mask[0] =3D 0;
> +               val =3D vcpu->arch.irqs_pending[0] & mask;
>
>                 csr->hvip &=3D ~mask;
>                 csr->hvip |=3D val;
> @@ -363,11 +370,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcp=
u *vcpu)
>
>         /* Flush AIA high interrupts */
>         kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>  }
>
>  void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
>  {
>         unsigned long hvip;
> +       unsigned long flags;
>         struct kvm_vcpu_arch *v =3D &vcpu->arch;
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>
> @@ -376,27 +385,29 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu=
 *vcpu)
>
>         /* Sync-up HVIP.VSSIP bit changes does by Guest */
>         hvip =3D ncsr_read(CSR_HVIP);
> +       raw_spin_lock_irqsave(&v->irqs_pending_lock, flags);

Add newline before and after raw_spin_lock_irqsave() to make it readable.

>         if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
>                 if (hvip & (1UL << IRQ_VS_SOFT)) {
> -                       if (!test_and_set_bit(IRQ_VS_SOFT,
> -                                             v->irqs_pending_mask))
> -                               set_bit(IRQ_VS_SOFT, v->irqs_pending);
> +                       if (!__test_and_set_bit(IRQ_VS_SOFT,
> +                                               v->irqs_pending_mask))
> +                               __set_bit(IRQ_VS_SOFT, v->irqs_pending);
>                 } else {
> -                       if (!test_and_set_bit(IRQ_VS_SOFT,
> -                                             v->irqs_pending_mask))
> -                               clear_bit(IRQ_VS_SOFT, v->irqs_pending);
> +                       if (!__test_and_set_bit(IRQ_VS_SOFT,
> +                                               v->irqs_pending_mask))
> +                               __clear_bit(IRQ_VS_SOFT, v->irqs_pending)=
;
>                 }
>         }
>
>         /* Sync up the HVIP.LCOFIP bit changes (only clear) by the guest =
*/
>         if ((csr->hvip ^ hvip) & (1UL << IRQ_PMU_OVF)) {
>                 if (!(hvip & (1UL << IRQ_PMU_OVF)) &&
> -                   !test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
> -                       clear_bit(IRQ_PMU_OVF, v->irqs_pending);
> +                   !__test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask=
))
> +                       __clear_bit(IRQ_PMU_OVF, v->irqs_pending);
>         }
>
>         /* Sync-up AIA high interrupts */
>         kvm_riscv_vcpu_aia_sync_interrupts(vcpu);

Add newline here before raw_spin_unlock_irqrestore().

> +       raw_spin_unlock_irqrestore(&v->irqs_pending_lock, flags);
>
>         /* Sync-up timer CSRs */
>         kvm_riscv_vcpu_timer_sync(vcpu);
> @@ -404,6 +415,8 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *=
vcpu)
>
>  int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq=
)
>  {
> +       unsigned long flags;
> +
>         /*
>          * We only allow VS-mode software, timer, and external
>          * interrupts when irq is one of the local interrupts
> @@ -416,9 +429,10 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vc=
pu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> -       set_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
> -       set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       __set_bit(irq, vcpu->arch.irqs_pending);
> +       __set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         kvm_vcpu_kick(vcpu);
>
> @@ -427,6 +441,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcp=
u, unsigned int irq)
>
>  int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int i=
rq)
>  {
> +       unsigned long flags;
> +
>         /*
>          * We only allow VS-mode software, timer, counter overflow and ex=
ternal
>          * interrupts when irq is one of the local interrupts
> @@ -439,26 +455,37 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu =
*vcpu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> -       clear_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
> -       set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       __clear_bit(irq, vcpu->arch.irqs_pending);
> +       __set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         return 0;
>  }
>
>  bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
>  {
> +       unsigned long flags;
>         unsigned long ie;
> +       bool ret;
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         ie =3D ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
>                 << VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
>         ie |=3D vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
>                 (unsigned long)mask;
> -       if (READ_ONCE(vcpu->arch.irqs_pending[0]) & ie)
> -               return true;
> +       ret =3D vcpu->arch.irqs_pending[0] & ie;
> +
> +       /* Check AIA high pending bitmap while holding irqs_pending_lock =
*/
> +       if (!ret)
> +               ret =3D kvm_riscv_vcpu_aia_has_pending_interrupts(vcpu, m=
ask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
> -       /* Check AIA high interrupts */
> -       return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +       /* IMSIC interrupt check takes vsfile_lock, which can sleep on RT=
. */
> +       if (!ret)
> +               ret =3D kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +
> +       return ret;
>  }
>
>  void __kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c..cba3682944b 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -298,6 +298,7 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_=
vcpu *vcpu,
>  {
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>         unsigned long regs_max =3D sizeof(struct kvm_riscv_csr) / sizeof(=
unsigned long);
> +       unsigned long flags;
>
>         if (reg_num >=3D regs_max)
>                 return -ENOENT;
> @@ -309,10 +310,14 @@ static int kvm_riscv_vcpu_general_set_csr(struct kv=
m_vcpu *vcpu,
>                 reg_val <<=3D VSIP_TO_HVIP_SHIFT;
>         }
>
> -       ((unsigned long *)csr)[reg_num] =3D reg_val;
> -
> -       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -               WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +               raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flag=
s);
> +               ((unsigned long *)csr)[reg_num] =3D reg_val;

Same comment as above.

> +               vcpu->arch.irqs_pending_mask[0] =3D 0;
> +               raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,=
 flags);
> +       } else {
> +               ((unsigned long *)csr)[reg_num] =3D reg_val;
> +       }
>
>         return 0;
>  }
> --
> 2.54.0
>

Regards,
Anup
