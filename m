Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792825565;
	b=JfCXgWdsa0tpvqA/d8OCNXSaMTVY4KSPmbL7Seo7u5SrPCHvs+uaeLTia1vI/q/Zni08
	 XOAYL2eFlcUOzhD6GvODKJ2T2riCNGPiobPUbRZcrPH8y//otUHWmcr0BVOEU+oOc5V2Q
	 abEnnMlr7p30TS8rSN/mjq5ifBCsa0RxrzS8EsYtxk+5na6rB6UUX3lDU+hS0nW2gKwnv
	 SOz8/Ysk02rsxPXTUXeRanXZQzkz99l0rcREaG4n50avgppe2ZzJ4FdfcWztGgrNPc8y0
	 DdDstVKKMjfeAu/WeJhd6Ce9BuzEtRdykTBjvoc/cd/zbuRfb8aKbHXqSsRL0hrAWow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825565;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=oqxBdCmRUh/o3pj/13O6zevxwBIO3ke0ZjDeWjPvwqM=;
	b=Y9doDFFnaTW7HbvGrMS6P2uOpJcvGBN5iVhoHgViA4YNHoD3gSY7bWfV73HsRmwinvO1
	 vSgvjXb9ALIPiVmQbMHY00zQQbfaAegFLmgAqbDqsNvRUURMDbCKc0lvUMjLaSkwwlMeH
	 Gc4OZtYPWzE70yAgztC/1jqtjfDdbEUXeMguc4YEb8716wK7OZQLCT4bhy5O07yiB4hZx
	 y8m/U2H9HLgg+TLtJku4ZWfJFeUm52sa0y3dpFnT9ueP6xp2lsTZ9lu5eDxOmdRQuwmqz
	 ZLRW2OZAfLLABDY0U8/mOCtJPdqA66tsg1O5/0Bf+RFMCCs/UoQ5DGq8O3b1CH3BHaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JJ2SrZ8t;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VI0sC5Pk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B6606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JJ2SrZ8t;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VI0sC5Pk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792825563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqxBdCmRUh/o3pj/13O6zevxwBIO3ke0ZjDeWjPvwqM=;
	b=JJ2SrZ8tHjiD+4a4EVkGa1iS+liDwFTBCMR17Llq4wjzCmqIlWEHf/xbhQDwae84tO/Su/
	ITlJC0OKVlzX7RVS8xJZ8JblaCf2Fjz8iGvyl6tUGwexDiu214J/Abftl9YN1c3q3wIKW+
	D3E5Ny83yNSJLiwIvu/pi9/+R4bXuD0=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-zlttvS06OTacAqYbvJKepA-1; Sat, 24 Oct 2026 03:06:02 -0400
X-MC-Unique: zlttvS06OTacAqYbvJKepA-1
X-Mimecast-MFC-AGG-ID: zlttvS06OTacAqYbvJKepA_1792825561
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3580c07911eso4544134eec.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 00:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825561; cv=none;
        d=google.com; s=arc-20260327;
        b=Tkbe+WBpdIU98GdTOR5zIqwWtpv+ZWUbvEoNjW+dov+kxUyTLdSHdCQ2ZXVEEMEMu1
         Mfmr8emLsiolyRGtXeD6uQR+BmErR9N3XwG3A2WKKHVpezW6g2oDqJFKGHGqrXfn08R1
         N/be85zljNscsEhJLi4FzHvqK56MOTweFh5IqBvHzp/1Kl0VL4P5tB93SvPJFkK0/RcV
         D1NSK/DMXhE2OpkiVFrx9UbOy0v6NYmQ4lIzUl6s8fnLIDXYj2XhkGHNZII2vhM7zSQf
         SlijaKCmDY4w0rG1cbolXLN0ScL6bO6puqAkzTTOr/mD8pi+dfMJWcYNWV7OJ+6Wzsv4
         +P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqxBdCmRUh/o3pj/13O6zevxwBIO3ke0ZjDeWjPvwqM=;
        fh=u7GJSJ7rg5VuaEyYrM9BGXSSvs9fWkTGrf9m3qzfb8s=;
        b=B0xVORjYrC1lpx4PfsrkIz95SPxyyhPCZ8bmFkQT/yg65o07vNRfM6/PMkKs54LgX5
         LyiGCWWYhdTZ2TzNApE6AKJpt/lAxHzXRL6hT8ZvENFmrhgWlfXa8cPfx0Cu8m10ybUr
         xy6QWGr69BQLLVevIoFHfzVArZPcyEYcEico8gkKJQ4Vq8/ub57kDY24nbI3OEzaM8iO
         7px5VU/Q4TMgtZXk04w1QgKx1KnJvQ6OiwQDeYZxUA5W4LC3Fxn5xu9+I0MgvKurm4Ey
         lxqv2qGvNZ38wVFGIt9B4PgPKm/kEI5HM2NCi2Z4AlPuiiwssw/tbhVz6z7id4nVi8u6
         9OJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792825561; x=1793430361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqxBdCmRUh/o3pj/13O6zevxwBIO3ke0ZjDeWjPvwqM=;
        b=VI0sC5PkHr6yKoBsfWvmw1q15lUhtPLbRjHBiuIHOHMQnk8XgipowikfYIDZcLeA++
         RiNRGn9WF52/jBJyaBFin/D1ZsiS/EYIKMznxoMBs0jxxMdSngruoWmdJT8ylcobANK9
         p8bVbuMe9lugVXkcy8+p94b0hYmbH0FKyg89A2u/HHzElHqiNT/4bQVt7Yx22HFbMxW9
         yGNoRgf5SaU95Ubydzm7ZLDplv8hZBg0tp+eF4qqIdqH/Ols6XAlly+WM83Ndzu9GydX
         MVf/CCM7fcF8FDsfcgWcg4S1IvcrJ8YV2X9Ra0xbYNM1zx62VGHM/btZAnlD23eOJG+o
         Ui9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792825561; x=1793430361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqxBdCmRUh/o3pj/13O6zevxwBIO3ke0ZjDeWjPvwqM=;
        b=viaGBgfXNkIjjllIuPK4DYsiCWUTo5HPRn6pxDI/XAnBIcQb3ayRmaMrMzrqX8NLP1
         4YSCu6fX7I2ApyvYKzlLJNMRIPaz0HYNQ7JL7rK0CDLU12KgSuKlZaN6M6pXXfYOBozY
         KU/6GAAaeDQ0N/yRckny+JBflhIvohXAObp0TIG5KMfrHpyWqOSGGgwLw5IeGLQXB/4c
         /69yFHZrpboi2uHnra67WKVAbyfgTuumZoTNIN6w9BSbzjOVyHs43nzyMk2VDTFYy9b8
         7Cz6w5CWMLpCuCZ3sIG8IeUE2BxS0ySJvu3H93WIiryuwR6N6x0pE26zEVTaeXRIychM
         qQAw==
X-Forwarded-Encrypted: i=1; AKwUvByVDCJKw3WU583yx5olU/Fqyrnd89780XJQ/puGXtlhA7Ytjdrt4SWodzgfrm0f0log6JYMEp0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbX/a37aQr4u1i1KqlJA38k5cavKagCXOz98+SGlQreaW7CoSr
	q9wkUFeHUQ6KGE8Q/BpsxCYKgRcJdGWbYP/T1/+rXYvsO19tIMmFTzm3IWVpUc9O574dadPYOGu
	+QUkD4PN5Vg5CNe3DWFw19XUdII0+UYVyA8cLEOD5MqK5/Gp/5NiJxLNkaWzZVmG1QSFiNDx29w
	SmpNfrd1+pG+VVABZ3gVYEK3+O9OkH7woU
X-Gm-Gg: AYBFou23ZqADysSq5TkG9VAydou93PaPuFuKW7uACbguCbLVvzkQ8gVzoNXHlziLRqK
	umY1YvgUyqjAe7nVTeS+vq8Dc8jTCPca+6eIx0aT8k1gfZUIGN+XwN0w3j0PFys/U2T4Z0L0jzl
	YYdQMBp+X3jUvEtBZidh4iXU2lCn9FojY2KFBqTAdSJCKJbnknoK2v4vY02pkniEK0bpnv9lCjK
	x3klDDqQgLuE47y
X-Received: by 2002:a05:7022:f90e:b0:165:aced:1fde with SMTP id a92af1059eb24-1991b421e8dmr1507386c88.0.1792825560739;
        Sat, 24 Oct 2026 00:06:00 -0700 (PDT)
X-Received: by 2002:a05:7022:f90e:b0:165:aced:1fde with SMTP id
 a92af1059eb24-1991b421e8dmr1507363c88.0.1792825560145; Sat, 24 Oct 2026
 00:06:00 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-nouveau-gsp-irqdest-v1-1-5dd6131faa14@sudmix.de>
In-Reply-To: <20261023-nouveau-gsp-irqdest-v1-1-5dd6131faa14@sudmix.de>
From: David Airlie <airlied@redhat.com>
Date: Sat, 24 Oct 2026 17:05:48 +1000
X-Gm-Features: AclHuK-0XItFovw3G1bBVKRVCBplwABReOzmq7h2Qp7p5fFLlK5pknGM07AUT98
Message-ID: <CAMwc25pyuJxHJnziCvorWvFb5awsgn9RZeYQ8GXpQ3Vzs7ro6A@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/gsp: only handle GSP interrupts routed to the host
To: joe@sudmix.de
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Ben Skeggs <bskeggs@nvidia.com>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 7:38=E2=80=AFPM Joe Finzel via B4 Relay
<devnull+joe.sudmix.de@kernel.org> wrote:
>
> From: Joe Finzel <joe@sudmix.de>
>
> The GSP's interrupt handler takes every pending interrupt the RISC-V
> IRQMASK enables as its own, without looking at IRQDEST, which says
> whether an interrupt goes to the host or to the GSP itself. One that
> belongs to GSP-RM, pending when the host's handler runs for the message
> queue, is reported as unknown, cleared and masked off with IRQMCLR,
> taking it away from the firmware:
>
>   nouveau 0000:01:00.0: gsp: intr 00040000
>
> NVIDIA's driver reads the interrupts routed to the host as
> IRQSTAT & IRQMASK & IRQDEST (kflcnRiscvReadIntrStatus_TU102() and
> _GA102()). Do the same, with IRQDEST from NVIDIA's register headers
> next to IRQMASK on each falcon.
>
> Seen once in a few boots on an RTX 3070 Ti (GA104, GSP-RM 570.144),
> before the login prompt. There IRQMASK reads 0x01049042 and IRQDEST
> 0x01000040: 0x00040000 is enabled but routed to the GSP.
>
> Fixes: 830531e94712 ("drm/nouveau/gsp/r535: add interrupt handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Finzel <joe@sudmix.de>

This seems very reasonable.


Reviewed-by: Dave Airlie <airlied@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h  | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c       | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c       | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 4 +++-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c       | 1 +
>  5 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h b/drive=
rs/gpu/drm/nouveau/include/nvkm/engine/falcon.h
> index 341f133dc38..eb8adaf07fe 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h
> @@ -63,6 +63,7 @@ struct nvkm_falcon_func {
>         int (*select)(struct nvkm_falcon *);
>         u32 addr2;
>         u32 riscv_irqmask;
> +       u32 riscv_irqdest;
>         bool reset_pmc;
>         int (*reset_eng)(struct nvkm_falcon *);
>         int (*reset_prep)(struct nvkm_falcon *);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ga100.c
> index d5126fe39d2..10e2813a016 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> @@ -27,6 +27,7 @@ ga100_gsp_flcn =3D {
>         .enable =3D gm200_flcn_enable,
>         .addr2 =3D 0x1000,
>         .riscv_irqmask =3D 0x2b4,
> +       .riscv_irqdest =3D 0x2b8,
>         .reset_eng =3D gp102_flcn_reset_eng,
>         .reset_wait_mem_scrubbing =3D gm200_flcn_reset_wait_mem_scrubbing=
,
>         .bind_inst =3D gm200_flcn_bind_inst,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ga102.c
> index b6b3eb6f4c0..96fa26fa612 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> @@ -140,6 +140,7 @@ ga102_gsp_flcn =3D {
>         .select =3D ga102_flcn_select,
>         .addr2 =3D 0x1000,
>         .riscv_irqmask =3D 0x528,
> +       .riscv_irqdest =3D 0x52c,
>         .reset_eng =3D gp102_flcn_reset_eng,
>         .reset_prep =3D ga102_flcn_reset_prep,
>         .reset_wait_mem_scrubbing =3D ga102_flcn_reset_wait_mem_scrubbing=
,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index 94925f1590e..463e463db24 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> @@ -64,7 +64,9 @@ r535_gsp_intr(struct nvkm_inth *inth)
>         u32 intr =3D nvkm_falcon_rd32(&gsp->falcon, 0x0008);
>         u32 inte =3D nvkm_falcon_rd32(&gsp->falcon, gsp->falcon.func->add=
r2 +
>                                                   gsp->falcon.func->riscv=
_irqmask);
> -       u32 stat =3D intr & inte;
> +       u32 dest =3D nvkm_falcon_rd32(&gsp->falcon, gsp->falcon.func->add=
r2 +
> +                                                 gsp->falcon.func->riscv=
_irqdest);
> +       u32 stat =3D intr & inte & dest;
>
>         if (!stat) {
>                 nvkm_debug(subdev, "inte %08x %08x\n", intr, inte);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/tu102.c
> index 11a37963bd4..823532758af 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> @@ -420,6 +420,7 @@ tu102_gsp_flcn =3D {
>         .enable =3D gm200_flcn_enable,
>         .addr2 =3D 0x1000,
>         .riscv_irqmask =3D 0x2b4,
> +       .riscv_irqdest =3D 0x2b8,
>         .reset_eng =3D gp102_flcn_reset_eng,
>         .reset_wait_mem_scrubbing =3D gm200_flcn_reset_wait_mem_scrubbing=
,
>         .bind_inst =3D gm200_flcn_bind_inst,
>
> ---
> base-commit: fb26cf4f1df40a462ea65552a3fbcc8cfafab523
> change-id: 20261023-nouveau-gsp-irqdest-a0819d1eda96
>
> Best regards,
> --
> Joe Finzel <joe@sudmix.de>
>
>

