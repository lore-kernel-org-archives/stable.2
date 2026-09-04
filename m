Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A339733E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532712; cv=none; b=FQrXWDE4iVSYfcOrBuVY84R40jcByyTcpfaH47x4VwWmL41JOy2XoVi2FXaM/DhTqyFcJjmX2kodARcZ25jZ4T4Ng3OqOGmp+792z5HTh0kZpIbSCoHbcPkuDZ0dCSzRxCVei5b4TxsQw8dH9ir7xW7mq06hsY6ud/dnNnwOPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532712; c=relaxed/simple;
	bh=J1g/3JijUybAzf6Tq3gcEcWM9RbNvSD7R4ifvJjbb0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWbWFc88KJeXDoA6Sjd99ndfcJSN5kio17AujR8zmE1Wemy4JoULWZ9JL72VMtkx6bTEjcfcLGHkVFZAtOSTs/UAi+uSv27XCb9/9A0kDZuf9pyASz99DMbKPg0Vg6IjeJ2v0we6caGtNLkj/ElRodOMXkQ5TdPC+UG/5W4X++I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiG00Z5C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiG00Z5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF541F00A3E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532710;
	bh=35hah3ul6tI29YPkX4PeIj+oqlMkJqdL3z01PNAAsrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SiG00Z5CF353Uf2DYrIXUx4/MBmlozwYEdDH7eVn9n9Wv4TcwENDhU1IL2HV3sx0n
	 nlqqRVfViv2HW3/KM6Uc+jpa4BYuk7oLLai2YSffkRLwYZK6JZZ0rCWvhIm86lNIhn
	 Vium3ZebWOCTWfPp/sY/R0I9avFQ3kfFK1LlMIf+vpolf+7123/GNu+8D2Hx11tMPH
	 Xm7XN9WefnHv7H5OzvHUtaXg3NNTBG3O1eg1gjpYMv2VW2jedR3vbNbLXD259VYADo
	 QkJDm+ADRJkZ9EnL5zovA317pkiTZkWhC1lMK6zQnT8IYe+TKZyVAdsSfxV+VTuIM6
	 GfubG7/rchZKw==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48584dc164fso1028923f8f.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 07:38:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxqu8M0QwAggGEoG253TqhyN3KX9fd4dhZELfDkfdgNJPky3ksjcHTpNVnLN3IwSNmh/pqDCv4=@vger.kernel.org
X-Gm-Message-State: AFuF++kXI8+X3EY79DF2MWODeR8O2+IwwUTFYriuxfwUYotj//lePOp+
	kkUbKptxhFJvimxlf/8Q1MINJwTM2nclP4jDY92hyh2BTewulMhAmv1IdXNp2uo90Zf7guVVu0P
	rsASgl2RQlkwE1qIGNOMTlPsxuVYJSAM=
X-Received: by 2002:a05:6000:4555:b0:482:e1ce:d45c with SMTP id
 ffacd0b85a97d-485872c2589mr5731713f8f.21.1788532709395; Fri, 04 Sep 2026
 07:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-nr_mmios-v1-1-3a19dc74fab8@kernel.org>
In-Reply-To: <20260904-nr_mmios-v1-1-3a19dc74fab8@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 4 Sep 2026 22:38:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSbRMUBd0+WXpiq8O61V+kkZ9hkJYVwBOeA4gjo-P4dGw@mail.gmail.com>
X-Gm-Features: AcwNN1WZc5yAPQLWYeJULNrT1Af-ctH-VxYkMfhSomePh3lXqSn4VGAGpBjdZrI
Message-ID: <CAJF2gTSbRMUBd0+WXpiq8O61V+kkZ9hkJYVwBOeA4gjo-P4dGw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-imsic: Fix MMIO regset lookup loop bound
To: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I didn't notice this:

https://lore.kernel.org/linux-riscv/20260718033646.001.7e022554-caplitmus-r=
v@iscas.ac.cn/

Please abandon this patch.

On Fri, Sep 4, 2026 at 10:32=E2=80=AFPM GUO Ren (XuanTie) <guoren@kernel.or=
g> wrote:
>
> The nr_mmios is the number of entries in the MMIO resource array, while
> j is the index used to iterate over the array. Testing nr_mmios directly
> makes the loop condition permanently true whenever at least one MMIO
> region exists.
>
> So, change
>   for (j =3D 0; nr_mmios; j++) {
> to
>   for (j =3D 0; j < nr_mmios; j++) {
>
> Fixes: 21a8f8a0eb35 ("irqchip: Add RISC-V incoming MSI controller early d=
river")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> ---
> This patch fixes an out-of-bounds access in the RISC-V IMSIC MMIO
> resource lookup.
> ---
>  drivers/irqchip/irq-riscv-imsic-state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index b8d1bbbf42f7..008dfcf343e5 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -896,7 +896,7 @@ int __init imsic_setup_state(struct fwnode_handle *fw=
node, void *opaque)
>                 index =3D nr_mmios;
>                 reloff =3D i * BIT(global->guest_index_bits) *
>                          IMSIC_MMIO_PAGE_SZ;
> -               for (j =3D 0; nr_mmios; j++) {
> +               for (j =3D 0; j < nr_mmios; j++) {
>                         if (reloff < resource_size(&mmios[j])) {
>                                 index =3D j;
>                                 break;
>
> ---
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> change-id: 20260904-nr_mmios-868e369de25b
>
> Best regards,
> --
> GUO Ren (XuanTie) <guoren@kernel.org>
>

--=20
Best Regards
 Guo Ren
