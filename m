Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AB3CA4A0
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705744; cv=none; b=eumfQnkzqOkc50i/VawZIutMOzWJav+Dah+MAP6iDaAGpNqmRx75aIStlZ551AW35jpTDhepszOecJrYSmZ2BGdC198o3cl7u6/j5KAYhad1v6+ayg5NifEqgZrvWbfC+cP/w2j42NwKTtCR4AvHkgRmuU9ETv+OsKhOWVMGBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705744; c=relaxed/simple;
	bh=PS53pggHQszgAXTyeJLWzhz2Iy6aaILaNoIH2bVSKrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSRXufO7O9VHjCIhxKR1zeFNIM39sz9P47xva4zbp2FUNQV4Xq346FXTl5HeZbDcezXf9BiSGjsZyR43VOSEInsw/smRoMdrC3OVJqdeYWtMJPAbTPU2k9THWOS3Y3e3OvD3KNV70MPvCzMBuTuWAYNHwFDsIkyMcNOYFvtMuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cHbUxT/6; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cHbUxT/6"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PS53pggHQszgAXTyeJLWzhz2Iy6aaILaNoIH2bVSKrk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790705740; v=1; x=1791310540;
 b=cHbUxT/6N5ra0eNZlkn9gvqk2qpnnFroUCW3kiR2Je/QSPmpvmxKCwSuo51/iAGZnAker1BA
 2HmMw2ldm6tFFwPd46Od9uoNvSIS+oWmmMCCjy57Q9letEtGRc37sD1ru45+zQpXLI9MYe7QP4j
 Xf2ky9W2RflgXTpup/mMeTaU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id df23dbb90d41c39e;
	Tue, 29 Sep 2026 18:15:27 +0000
X-Mizu-Trace-ID: df23dbb90d41c39e
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b8c42da963so963e87.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:15:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzBt0SnQ+EY2rCIzMxY6I3FM6yr88MoMdhSqFkr1Xm5ou6IXgzPs2WvEZ5xgEYaCp1VCcKOo+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbjO0gDoRXFfMvj/o2sfy0C6uVf6WmgxgpWO9OO3Ha4kVS9Ssr
	/ltYz4sKZRP/LG7hPls31z7IBffebAYEKOT2bU0d5keWU60sHvSxWWy9vQWerlDnc2Glww9ATuq
	+Rr5r7DFDhqDMG11RYkRDUXoxbJ9sTG5e4FVEeE90
X-Received: by 2002:a05:6512:3d04:b0:5b8:d830:be30 with SMTP id
 2adb3069b0e04-5ba2f9ac722mr166505e87.16.1790705724240; Tue, 29 Sep 2026
 11:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929093548.3598547-1-maz@kernel.org> <20260929093548.3598547-7-maz@kernel.org>
In-Reply-To: <20260929093548.3598547-7-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 29 Sep 2026 19:14:48 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyRRJjhaud-OHyAWh0z4Pj=o-jmvN8tJ=3h+Qrb6Lzm5w@mail.gmail.com>
X-Gm-Features: AclHuK9Zph6dxjBIAdQsEIxcU3zk8Se6Fy_owHYC72h8LnPnQU2hVuTRl5zAeJ8
Message-ID: <CA+EHjTyRRJjhaud-OHyAWh0z4Pj=o-jmvN8tJ=3h+Qrb6Lzm5w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] KVM: arm64: vgic-its: Fix MOVALL handling of
 source redistributor
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Yuchao Zhang <ndaugoing@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 10:36, Marc Zyngier <maz@kernel.org> wrote:
>
> The MOVALL command moves the pending state of all LPIs targeting a given
> redistributor to another one. However, we seem to have lost the
> filtering on the source RD, which means we move all LPIs to the target.
>
> Not quite what the spec mandates.
>
> Hack update_affinity() to take an optional source vcpu that is used as a
> filter when non-NULL, restoring the filtering that was performed by
> vgic_copy_lpi_list() back in the days.
>
> Fixes: 11f4f8f3e6e06 ("KVM: arm64: vgic-its: Walk LPI xarray in vgic_its_cmd_handle_movall()")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba < fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  arch/arm64/kvm/vgic/vgic-its.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
> index 9e782a4fea7e5..cc02d9b62bd95 100644
> --- a/arch/arm64/kvm/vgic/vgic-its.c
> +++ b/arch/arm64/kvm/vgic/vgic-its.c
> @@ -319,12 +319,16 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
>         return ret;
>  }
>
> -static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
> +static int update_affinity(struct vgic_irq *irq,
> +                          struct kvm_vcpu *from_vcpu, struct kvm_vcpu *vcpu)
>  {
>         struct its_vlpi_map map;
>         int ret;
>
>         guard(raw_spinlock_irqsave)(&irq->irq_lock);
> +       if (from_vcpu && irq->target_vcpu != from_vcpu)
> +               return 0;
> +
>         irq->target_vcpu = vcpu;
>
>         if (!irq->hw)
> @@ -362,7 +366,7 @@ static void update_affinity_ite(struct kvm *kvm, struct its_ite *ite)
>                 return;
>
>         vcpu = collection_to_vcpu(kvm, ite->collection);
> -       update_affinity(ite->irq, vcpu);
> +       update_affinity(ite->irq, NULL, vcpu);
>  }
>
>  /*
> @@ -856,7 +860,7 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
>
>         vgic_its_invalidate_cache(its);
>
> -       return update_affinity(ite->irq, vcpu);
> +       return update_affinity(ite->irq, NULL, vcpu);
>  }
>
>  static bool __is_visible_gfn_locked(struct vgic_its *its, gpa_t gpa)
> @@ -1383,7 +1387,7 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
>                 if (!irq)
>                         continue;
>
> -               update_affinity(irq, vcpu2);
> +               update_affinity(irq, vcpu1, vcpu2);
>
>                 vgic_put_irq(kvm, irq);
>         }
> --
> 2.47.3
>
