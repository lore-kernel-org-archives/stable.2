Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605EF379C47
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621023; cv=none; b=X0Q7c8sKB7FW2eyo5V9bpMl4l5Ex83/SxRZ0BBi1gUSLbAC42rYiXYn2J22AwRF4lRh+i0mkCtuoip1zzNaDsUUFovFg3dMOe1J1vpzg2QFa4Ma41bukAh8CaCpi/b/xjo47J4niHsmToN+cQk/nGcV1sv6GAUcm5sIwCEqLKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621023; c=relaxed/simple;
	bh=2mJGIwyj/xSapbZTBjcCCPDQG9hmyLml1tmEw/lAXg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=au+quTy+f2UHGZRIJF7dpvNMXHNIGgGD6S+PkZfHuxVq8o4bnHk0HYnIfB8g3xygrQ6I2xZkTyEsz2b6b3N0H87dGEVEGGPCL4JKzB4xbzPOmn/zonImndjWGbMH/nxRQCJo//1B2CHtsGLAl0991CizjtAzXtRIiHmgg9XSHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV6uVKpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV6uVKpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA1D1F00ACF
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788621017;
	bh=+ngsQXI4zC+888E4/OJjdNvUmB+wO5RAGN8skdj0V40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nV6uVKpLTHEp92ojh5OIDyFlT2qxb10Gzvnd+exrHrBkT8Gf1sVt9N/BdHtO+mEoH
	 S2JLnrgI1wAvdUENdAdM1pZ+MKRqpnfUgDKTR1XAaM8T7i8I0HImhUbBxnBqpinB8x
	 ezMftbRgj4MsAZmGLM6KwFvfkexUlg1+N/88EUKqvDLQIeWXL9+dwjNlbqd+p+VDB1
	 vCmOOoQIsQPHFFPBYSqdWMEZ7BVbViGnxIcv97KWDAtXI21zQTy6H/MsVoUG3/1BaM
	 c7lAPoY7nLb99+DVD1/5Rhi6NH77XXVTLA51EbrNFv+KF3T1TJKEKPloyXctBCTa/o
	 eDAkMEF/BYykQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a68ca482e2so2723282a12.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 08:10:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxHQoSGyj1bxXDlgHgvGvY0RPW5FikvKdgpw+2HBxp34X+4lqMPL5sodQXE7ql0CiCplEtkrO0=@vger.kernel.org
X-Gm-Message-State: AFuF++kVEOOzBt1L1/HQhf+ahYQe4Rx0RqVSUqVbYGx0UtS3T8NVo8pY
	KbzPnABXZ92coSxJNeYopOraOPKOJJLQ9YTJKPYtLZ8/79rPJw7KiYgrVTqSZIsGe/aXS7izkWU
	5Hm3ls6ROm0Fuf/jcZVawn3xQ6SGkiLU=
X-Received: by 2002:a05:6402:2b91:b0:6a6:32f5:90b0 with SMTP id
 4fb4d7f45d1cf-6a7e8f973f7mr7958295a12.18.1788621016394; Sat, 05 Sep 2026
 08:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828093604.56622-1-zeng_chi911@163.com>
In-Reply-To: <20260828093604.56622-1-zeng_chi911@163.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 5 Sep 2026 23:10:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Jc4txZ-cQO-h6yZmfk3YEgeEptKtRQcDO=US3sies0A@mail.gmail.com>
X-Gm-Features: AcwNN1UKvRHYPv7HdHEqhee4ixh5TS5UumQJLZJh8j4AXNvX5xvnzRkPfAjWnIM
Message-ID: <CAAhV-H4Jc4txZ-cQO-h6yZmfk3YEgeEptKtRQcDO=US3sies0A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Validate MSI data before routing it to EIOINTC
To: Zeng Chi <zeng_chi911@163.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, yury.norov@gmail.com, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zengchi@kylinos.cn, stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Fri, Aug 28, 2026 at 5:36=E2=80=AFPM Zeng Chi <zeng_chi911@163.com> wrot=
e:
>
> From: Zeng Chi <zengchi@kylinos.cn>
>
> pch_msi_set_irq() passes e->msi.data straight into eiointc_set_irq() as
> the irq number.  The MSI data comes from userspace, either via a
> KVM_IRQ_ROUTING_MSI entry set with KVM_SET_GSI_ROUTING (used by irqfd
> and KVM_IRQ_LINE) or directly via KVM_SIGNAL_MSI, and is never checked
> against EIOINTC_IRQS.
>
> eiointc_set_irq() uses the value with __set_bit()/__clear_bit() on the
> 256-bit isr bitmap, eiointc_update_irq() then indexes sw_coremap[] and
> the per-cpu coreisr/sw_coreisr bitmaps with it.  A data value >=3D 256
> therefore reads and writes memory past the end of those arrays, i.e.
> any process holding a VM fd can corrupt kernel memory beyond the
> loongarch_eiointc allocation.
>
> Reject MSI data that doesn't fit in the EIOINTC irq space.  The DMSINTC
> path is unaffected as it decodes the vector from the address and masks
> it.
>
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260531140921.1B1181F00893@smtp.kern=
el.org/
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>  arch/loongarch/kvm/intc/pch_pic.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index e7b77705c516..81fb534ce8dd 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -78,6 +78,9 @@ int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_=
irq_routing_entry *e, int
>                 return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level)=
;
>         }
>
> +       if (e->msi.data >=3D EIOINTC_IRQS)
> +               return -EINVAL;
> +
>         eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
>
>         return 0;
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
