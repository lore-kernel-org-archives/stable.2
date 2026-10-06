Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3545D915
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293177; cv=pass; b=h3YEcrsnlJqnlczIo057kE/pN6t3Wh07Wo/52VA0lbUVXeDAEEWSyBHJwEIHmjYHFUiNT8hTdcudeTRBKMEtbwFtNzX12NfdQJTNk1pURtJS8ngKjZd7Zrp+/cEK55fdEH19gg3OFvSheoTjcpkhToKg1QElALEQJEYOy5odZnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293177; c=relaxed/simple;
	bh=ZrPuJ0BDzHouXdi/53sJaK5OCu3i1Gml/uJrNjwM3j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=htYqQKP/+3RJ9LHwHZd0sJ3h9pgxkUQ5iPYrhLH5I9mrf5Pl3/lIsMEHBuGaQKZUMVRNivPv4xkgu4SF4TxqNKH2W1BNyAxp+JEGbHn2l8nCedNdmq3fhXX7UEpiT/h2Q74rhXl1mmJ1I+dzUiHvKPJzhjJega84iMRm2OXdj+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyiVk3uV; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyiVk3uV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ab0140ecb2so12130a12.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 06:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791293170; cv=none;
        d=google.com; s=arc-20260327;
        b=RxZLOxphbKeHeGrLPC+tIrC/wylKgjtI+kWh/JKbbPmn3Tg0h/EV7ak6SMlUOxcS2M
         J/WRa99jAqJqudIpQR8e//HcpkqxfQ03Bd0XZXQhAYUX5TmQDCPQFt+VUwfpou26/XTc
         T0SrLzJm467CpDLZuC5F2Ofg6mb+fONSjr3Ue8th4oKqkM4v3SWsst3t65g2cO0Jjc/O
         cp/9tJpd5dIF8T4fdcwK6TcbG2Gkh06LhvLFEmcPAWfa9DunSaKwjR3TVHFjHFNUufuZ
         tCL2Tnevf8RCOEAAustMEvYmF+Pnq22nJGPGESiI2x+lZTWYe3jsOnpp8E5Sbrt8j7o/
         nQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oAt6dbCKDg25n/PouH0XLkKwguQmpceuu7qXIrePQww=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=LsOwxxC1qMLgWkdhVua7xsB39pVKxhk/TdCxA1i6KPHrV+aZ86inb6jdojS773Kt/3
         +1alNHXgEQKR8X8vKNq7ZOs5LNC+IHhpeppk9zYmUcVhCLihK4dDIWJbfTIgkgibpJNJ
         EcXrTE8jMrMEXZvHyMRMKRU5reJCq621zbUsCVjsANj3kjOUkkz1jwJhvT2XgDXhSFRZ
         vXjzs0mDV160NOmA5HvBFhx601K0hFmpWdm1Jetk6ESPMYIk2DWQ6fYezAKRXeItL4EP
         WGZTTCPvAQTg1cIY1FPJ/KWwQsO7crM3A0rn+Kee2cDJKp5Z9VgjCXD71DWkiu3NFOCA
         FWSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791293170; x=1791897970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAt6dbCKDg25n/PouH0XLkKwguQmpceuu7qXIrePQww=;
        b=UyiVk3uVM7HykI81luvRHJ4KK80ag5/MbZ0fRYx52bJc2+zz8ShlWlYwAngy2fyiuh
         QcHeQdn0KCQTkrHYe/FFHc19/79FQLe36tHlBqTuculzZ/Vf86J+dIvopgvsJqd4ueTH
         Yk5oIsYf32Xe5KX3CVcdjSNqONo72qF6yrL0XLwc8brYDU5aIUkca7HYxX7gbxF9dcTY
         ReLq2pUFKdXOAYvqYN6XqAavbJhFrbBXLccGa1Ncynb1oBlPn7twpwxZkBGCwXL8Uaq0
         DVxeUjRRIDa0V99TLtUiL0xPdqS6+PJAi627VtJPIbawetq68XnsfgcPKOF35Zm7Rtx4
         AsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293170; x=1791897970;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oAt6dbCKDg25n/PouH0XLkKwguQmpceuu7qXIrePQww=;
        b=V8cASOOygGQtANbcFjVcppjL+up2MM3jYIOXkp2iqJzeU+BIW8un6T8q0/Xmffuwgs
         ySpJg3R5rG6t1bpPR8hz5fnWMuxqAEpunCwYLEJ95gzF3EeVdiygImE4vYFEexvUiD/h
         PjocUdeTlYfREyKZvweD7kqzxxiHbsDrg1VOdDgm+NJyaA/hgMy/UjllKryyLMmspyg6
         mP3KVfoiceGgLYBi5DCvAPoAU1o1IbatxWGVtXN1uJkzzwzNlPd6QCBXPnXAXHwd8HUK
         c2k0G15gi8lBVoiP9WAZ0sjfKPEkLbhtIQU/GHJBahvMMTxvmTlBq7d4T1x8efl9zriY
         CrFw==
X-Gm-Message-State: AFq9FYLxtEl4mYx/+VxA5dXgaQjGDvGC4vgc1wljiOgWjllZR9iofgfN
	ghgugZdkm8DvPUUEjYxWbDeldv335dMW7UTfvJgsnh0Yy5IIXorm+WFFWiaLn1h3rt1hw0qfym4
	NpeS/Bq7wXOe5cQ6jyirzPcUCU8atoNtHKgb5JA9n3lPafbN+gzHjUXBMB1c=
X-Gm-Gg: AYBFou3MxGz+fnxTpI0CAzJY5qdM8TZA2s2Wu3zJ7ZZ5Y7GNzs7FXpHwrmygrEXgXdm
	CErvfs/0WkB9YdmsfidS7/K3pInqtXU4WzPcHCw+aYR4RR3LWjBDD1nYwvvBynn7N1JhlQQcY76
	HFoHkwrVd6+idDaIQfzwRfJALi8EO6T7mIxkp27guyaZS2GC9wopi5wYq2KoyCeWs+1FQ3m+YBY
	1YL/lA+oXwktwOwMPdsNuHcUqJA8jO4rkhPjItYid+jgO0cUxu3dSoCQXWfsQJZo/9S9pqnWXDt
	TDHB7glkkl1yAQMR04iNA3I+BRwN4B9t1RfZS34lL4ogfngT5za1ycc=
X-Received: by 2002:a05:6402:a21a:10b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6afd907b2cdmr39595a12.4.1791293169786; Tue, 06 Oct 2026
 06:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026100531-budget-lyrics-f08e@gregkh> <20261006132358.3040035-1-smostafa@google.com>
In-Reply-To: <20261006132358.3040035-1-smostafa@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 6 Oct 2026 15:25:55 +0200
X-Gm-Features: AclHuK-Czv12Iqaa6YptMT3LPsDGNngPKVcOfTFEbPYP9pNj0REUwCifkfh2g3M
Message-ID: <CAFgf54rHkBYfBvvxprjt8gU+-i2jGd3kjS881h4wqG5ViNN7LA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Don't use the VMA to size stage-2 block
 mappings for VM_PFNMAP
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this, I used the wrong git send-email command.

Thanks,
Mostafa

On Tue, Oct 6, 2026 at 3:24=E2=80=AFPM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> [ Upstream commit 71cc2c67fb8f8d5aa8154eb482e9846d2214f11b ]
>
> get_vma_page_shift() derives the stage-2 block size for VM_PFNMAP VMAs
> from the VMA layout alone, which does not necessarily match what
> stage-1 maps for that VMA.
>
> Upstream commit 71cc2c67fb8f ("KVM: arm64: Use stage-1 leaf size for
> VM_PFNMAP") drops that calculation and lets transparent_hugepage_adjust()
> derive the mapping size from the stage-1 leaf instead. The second part
> is not applicable here: in this kernel transparent_hugepage_adjust()
> takes a reference on the backing struct page, which is not safe for
> MMIO, and stage-1 has no huge PFNMAP before v6.12 anyway. Only drop the
> VMA-based calculation, so VM_PFNMAP VMAs are mapped at PAGE_SIZE.
>
> Fixes: 2aa53d68cee6 ("KVM: arm64: Try stage2 block mapping for host devic=
e MMIO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 7d04f9670644..c5697cbbfabe 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -904,32 +904,11 @@ transparent_hugepage_adjust(struct kvm *kvm, struct=
 kvm_memory_slot *memslot,
>         return PAGE_SIZE;
>  }
>
> -static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long =
hva)
> +static int get_vma_page_shift(struct vm_area_struct *vma)
>  {
> -       unsigned long pa;
> -
>         if (is_vm_hugetlb_page(vma) && !(vma->vm_flags & VM_PFNMAP))
>                 return huge_page_shift(hstate_vma(vma));
>
> -       if (!(vma->vm_flags & VM_PFNMAP))
> -               return PAGE_SHIFT;
> -
> -       VM_BUG_ON(is_vm_hugetlb_page(vma));
> -
> -       pa =3D (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
> -
> -#ifndef __PAGETABLE_PMD_FOLDED
> -       if ((hva & (PUD_SIZE - 1)) =3D=3D (pa & (PUD_SIZE - 1)) &&
> -           ALIGN_DOWN(hva, PUD_SIZE) >=3D vma->vm_start &&
> -           ALIGN(hva, PUD_SIZE) <=3D vma->vm_end)
> -               return PUD_SHIFT;
> -#endif
> -
> -       if ((hva & (PMD_SIZE - 1)) =3D=3D (pa & (PMD_SIZE - 1)) &&
> -           ALIGN_DOWN(hva, PMD_SIZE) >=3D vma->vm_start &&
> -           ALIGN(hva, PMD_SIZE) <=3D vma->vm_end)
> -               return PMD_SHIFT;
> -
>         return PAGE_SHIFT;
>  }
>
> @@ -1038,7 +1017,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, ph=
ys_addr_t fault_ipa,
>                 force_pte =3D true;
>                 vma_shift =3D PAGE_SHIFT;
>         } else {
> -               vma_shift =3D get_vma_page_shift(vma, hva);
> +               vma_shift =3D get_vma_page_shift(vma);
>         }
>
>         shared =3D (vma->vm_flags & VM_SHARED);
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
