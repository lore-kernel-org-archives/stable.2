Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B307391E43
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575570; cv=pass; b=CLHAIJZ+r/YFIIDDxE7XNg0xNC2XDcsJ4vLhq5NBbTd80ly7ws9qTM/j+iD21HdbOqr0kEGBtC+fLp6+R09NGrN2v3XdfCJOrOLyno1QLZF7ZZy+Cj6ixBe6fR8XjluGIPfTzA6oaIbsSFAqsl/7EdCrT9JS1sqVyzND2Z2HhVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575570; c=relaxed/simple;
	bh=2EtykzROyNRHqI7dfO5p5LrMDJMmvauTWDJWnEKfhB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npmkYCY13B3gwm8P7pREkqCdYVAeNdBOGdQ+lY2R56gKEFhcPPJcSPrjhpO+jUoCH/i6bpMVf8wTcIBR4L197UXcOWCohfl7FrXHMmSJ1orQfcy/lkuHfSD+JIZiqXJzXPb/pHePcilamTmSZyS46rtaFVp6c6CTuBuHZYQ+Sps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=vgeKcVP+; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="vgeKcVP+"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcbb82dbadso10434e87.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 12:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791575561; cv=none;
        d=google.com; s=arc-20260327;
        b=jyPavdLEHZ2Rk1rT0VNl3pU9d4Ltys6MMEkgGtI47Hsbs/lRJdVpemTsFHSx9Z9Pqa
         0Okj/VZbKs2Gq/U35Acz2BwC57MvCCVuaFCOHoyiRIW5l3i0yo+cz1qJxz2uH3Oy6a/V
         t+ibG9IIO00vJbbHGIvNRNYuzU5DS9ju+mE7sX4OQPtnGC/Y5BlS5BSXure12VsbsCas
         WyXWev2i2fA+LucWiq0mrG9ksB+UKAspNqHyrn6FCiKMNFh5NK4x6kKM9LNz4LEtMOd3
         2ti3hnjpDmiDIcZvHd2E1v1/SNkkXeLLvxg4yTqaJkcafEWditJYO3fWjbS4AQZQJBWI
         KuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8IOkLqKGpOfZvqZ//aJaXg6rNYWnLDF+R3NnxinhKE=;
        fh=QFVfh7AVhHH3WFqvxm4f1eq4w/7DVo/OykhiPjEcAJI=;
        b=pzrS4tZntGsbGF2/h4qIPPwKP5lWKFNQYpsIFBDjiL06aePwCaRTQyhbLeQleL4fl/
         yVOUSE0+VAuLViMtl1GTdtcEMQyrMJHOnVzb+DUgJOjcLzmV8uM58bkAQ7h44VX/cI1k
         jqRuBy2kwcEaO4kl2zo2acKnEpfNkE6e7mG9aRIaSVkvR3L9XRal3yPntD7jWa1yDXke
         yW/EtmN7l6I/TJQ6OJKERPsIX8H4A9KMIyysHGDUsf3pHAPLVrMnbarz3Go74s04kQoL
         v144J/Nf+VlL7xUdC6IFhqOIt5baWMXxzHXmeqUn69iBGsUG/xgpfGTywMWBW3oKx0DM
         CnHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791575561; x=1792180361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8IOkLqKGpOfZvqZ//aJaXg6rNYWnLDF+R3NnxinhKE=;
        b=vgeKcVP+wYgPLz4NnmhxxWhXCbKuyKqA6W8IcW3o+VF5mZCXBQBDJLRlwQPQFMGrYW
         t9BcnlqXQlX8FDX/GNgdfMOEy5ZrPIcy19wRyvvRdmC4hw5iZu08kf/Imv5b1+VPuvst
         iLUxsqFX1a8hnnty2iXltM6zcIK9UJ46mIOj0ecbTVQflv22tkmWeLuaucANb92pL6rM
         uzTyymxQDvgGS5p+xNhmmlCYuBDaGO0ClSS9kT2ktk8lFFGBJNqKE04cfjjdgusMGa8B
         lJr+7wojnVcdKqymP5urAH1m5IZRI1w2Ze4rSu7Fk5FIyZJIgtkEgYyDl6OS30gt11AD
         9Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575561; x=1792180361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8IOkLqKGpOfZvqZ//aJaXg6rNYWnLDF+R3NnxinhKE=;
        b=a1YUhlhODPJOBuYOyO7ctyKyesXV59WV0UbIkrSJ8hA8PZZxiZAecl2M8JM10MxJzo
         NfhF1AlZbUiNMKzul/KOdublpTc+GdtLPfLbcLf5U4kroSK0JLxLZypYAPZM72wyRd3j
         O9BzkhB/F2ae4jX6oIHLQM4aRHciVSHe7cLdOtHpTjUgp4ydUsd8yWbiy95ecWSWuMLf
         hFQ60RYsdEc14eewqdiHMkqpwhVucZAwzMO5Zw8gz2Uu09kdxAyPVCEwvIgU7RrUTH4B
         PLIBeTX1G2jlL45WFk2Ljmm+wUYuSBtpLmxZbkkQd52QjoN5+4zPuECbr0QLtW1Qey7h
         MHbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwk7dF4jKJ0qOR5b4CZAXIFEmBFxZIbl2iYHtFV2zQeS4k+cjyUarxl7nbBH+/2srLl9M1LSds=@vger.kernel.org
X-Gm-Message-State: AFq9FYKH9JfHO1Sw7UqFU15/bjP9ses0EAQz8KLp1RVAaAtkphe7+2vC
	jweT7TGWu/TF4bPCiRKbF4aFxbzZRMBOnhwFfDGZXQxLHOnpv19OSRrg1kZzGaKnJd7uUAPLx91
	HGrGE/kmKYxOnb2sS2IimpTCpX8taJmDK3WkgKGIMPQ==
X-Gm-Gg: AYBFou3rhlpZ8stfISZb6kFkTZW6zccl7/fpHERv4S7P3F8me2N7rvxzqUnRZsKQ+jb
	2IwUr16PCgunbu39s8kyQdZK5c0decRjBWqRSBEDugo+xGmYCrvLtUMsyAI8RjDC3b3JPtIWYbV
	O+kH4EOexe3QLDc9fOy/TXoJIYT68wMcDR1mqdxop1q61sAiv0NYlAqJJ804kEp6CZ+byRPAtQ4
	ahvZt5nRu2N1RfKQfiQZMVF6Vz3N+YPgNS8rQKTYNP/SdlZq6M+OFT6FMO9d2xNBlBRMCN6Gqec
	ZP6tJSiPup0TPWY+v8CoLLXTJpPsuIvRiRE+Znly8dkJd09Sjk2XOJRgFfQsvWlsuswc5gEGp8C
	uFnEOwUSgSZxKv9xbFC7q8a6sYHb5oFvvA0M14QGxxvZ7lUGgBOKuAy1bw1DGRzeuRqq6Ks0Qsg
	==
X-Received: by 2002:a05:6512:6c4:b0:5ba:3888:7055 with SMTP id
 2adb3069b0e04-5bcde8d8587mr987668e87.48.1791575560885; Fri, 09 Oct 2026
 12:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
In-Reply-To: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 21:52:29 +0200
X-Gm-Features: AclHuK9LE_K8n8SBL5vcZdIBUie1cZWxyC_Q9G86b62TjkF_wne6tghiR0d8MC4
Message-ID: <CAAhSdy0CWoLshP7GyONS2E-wYOZF8hEjbBosOnc74LvtjkUbDg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:20=E2=80=AFPM Xiaofeng Yuan
<yuanxiaofeng@eswincomputing.com> wrote:
>
> The SBI IPI handler walks vCPUs with kvm_for_each_vcpu(), which
> iterates by vcpu_idx (creation order) rather than vcpu_id order.
> Since vcpu_id can be assigned out of order by userspace, a vCPU whose
> hart_bit falls outside the XLEN-bit hart_mask range may be reached
> before vCPUs the mask actually targets. In that case the handler jumps
> to "done" and stops sending IPIs, leaving valid target vCPUs without
> an interrupt.
>
> Replace the early "goto done" with "continue" so vCPUs outside the
> hart_mask range are skipped without aborting the loop.
>
> Reproduced with a minimal userspace VMM driving KVM inside a QEMU
> (RISC-V virt) guest: three vCPUs are created with ids 100, 0, 1 (in
> creation order) and sbi_send_ipi(hart_mask=3Dbit0, hbase=3D0) is called
> from vcpu_id 1. Before this change the IPI is dropped and the ecall
> returns SBI_ERR_INVALID_PARAM; with this change the IPI is delivered
> and the ecall returns SBI_SUCCESS.
>
> Fixes: 0611f78f83c9 ("riscv: KVM: Fix SBI IPI error generation")
> Cc: stable@vger.kernel.org
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_replace.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_=
replace.c
> index 506a510b6..c2f1f7f26 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -64,8 +64,17 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>                         if (tmp->vcpu_id < hbase)
>                                 continue;
>                         hart_bit =3D tmp->vcpu_id - hbase;
> +                       /*
> +                        * kvm_for_each_vcpu() walks kvm->vcpus[] by
> +                        * vcpu_idx, i.e. the creation order, which has
> +                        * nothing to do with the vcpu_id (hart id) space
> +                        * that the SBI IPI operates on. vcpu_ids need no=
t
> +                        * increase along the iteration, so harts outside
> +                        * the hart_mask window must be skipped instead o=
f
> +                        * aborting the loop.
> +                        */
>                         if (hart_bit >=3D __riscv_xlen)
> -                               goto done;
> +                               continue;
>                         if (!(hmask & (1UL << hart_bit)))
>                                 continue;
>                 }
> @@ -76,7 +85,6 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>                 kvm_riscv_vcpu_pmu_incr_fw(tmp, SBI_PMU_FW_IPI_RCVD);
>         }
>
> -done:
>         if (hbase !=3D -1UL && (hmask ^ sentmask))
>                 retdata->err_val =3D SBI_ERR_INVALID_PARAM;
>
> --
> 2.34.1
>
