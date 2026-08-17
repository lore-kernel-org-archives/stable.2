Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AC23A99F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786928163; cv=none; b=FXwDfhMn31Rf8RDUZhWBSnozkcHjQiqFwRfAosE9mqYs/s+pWAl+qPtu6KA32ddAjbWnDGZ3GElPmVZH4WZE6vXSp7Iygo1gPttsdWnHrkn+wiZTuNSt4DI2i7eQYNh107MOGsxF5zFNSNcUQzVTgVc3E9GeedMBBFWT8QKU7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786928163; c=relaxed/simple;
	bh=KC8UUdmIE/Ltr3CJ3Si1ywx2jVlKmv8hOHz+JeQtCUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoeStRXLyyy5Li1TOvOdm73PmmoCuwaIHghMPTmaYA75PDXfst10/qf/fYYeMy0lblwLzM9kmy7z56HjC3lje+0hVaeYP/0Aowg+nEiZy+iASzqd4HSFBTSZBsPaxDqMwZDA/sztiZHFh+W4DpyIkKycyG/C9XSXhQh5v6thABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K83dJ6EE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K83dJ6EE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CFB1F00A3D
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786928161;
	bh=r5Eq/rNnDykdzzrPy34h6zrlHsN1zXEpsuTuZzQJUeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K83dJ6EE3WngNkItbVUPztbGMbxz3gk9xLHZgaDDE7pw/FktUXqN8PMDaHGQoYuha
	 smbqsyK/SKYyidDtJ+/yDe7dJrgH5ie4QUXeieKzRkW3977D+peQbKjy6VaTWUwcIE
	 WyEge/f1vko2T4pvrqueWPiPNmmq6fXy0IxKD3ZqZNnStEBfivMu/oxxnG0rZJStHz
	 6vBi8n7cLMDQZBmvJjkO3Rt11KqwRMtsRNKA5BRJqhzbVGFAZwyLbsMiIY5guB3fms
	 KTAiN3kzV7rmk6hWYCgdcMXE1t2cUhw6SKthc7kvdddgOIe9+ITO1RoS+0pbAx2kwT
	 QmvZIq7fdbi6w==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso27374025e9.3
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 17:56:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqX/tv8asWBz0QdtcR/XP/W1cCSOPY4NAU1XeTY9dn+GfUZj7hTjXcl4tQLzUEwr16E7vtgiI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmLZlI6yU2JGspiPUz2/iKVqqQ1rGyFliXkM7NGO54PTLzuwd
	84f32PUc/J6yBEN/tsE3jPcNufEeTLGqWyJiJ/q6/LsfOyCfKpySI2SHasBZGTbSFm2auMRpotZ
	uNK340HKr7JGWucZvVZtUQoWPHifDwLs=
X-Received: by 2002:a05:600c:19d1:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-499879ae4f4mr313180965e9.15.1786928160326; Sun, 16 Aug 2026
 17:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816074125.2105828-1-guoren@kernel.org> <20260816084034-GKC318749@kernel.org>
In-Reply-To: <20260816084034-GKC318749@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 17 Aug 2026 08:55:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTXn6HMGcUFsm2y1FekRXHEOockTv3JWDwq3OfJRJ8k8w@mail.gmail.com>
X-Gm-Features: AcwNN1XdN1EseW_kz3Aepyd6qgzvXrqCYj75XYIr84-1wXSCGEE2tintqRNc3Jk
Message-ID: <CAJF2gTTXn6HMGcUFsm2y1FekRXHEOockTv3JWDwq3OfJRJ8k8w@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: spacemit: k3: fix IMSIC guest parameters
To: Yixun Lan <dlan@kernel.org>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	spacemit@lists.linux.dev, stable@vger.kernel.org, 
	Guodong Xu <docular.xu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 4:40=E2=80=AFPM Yixun Lan <dlan@kernel.org> wrote:
>
> hi Guo,
>
> On 07:41 Sun 16 Aug     , Guo Ren wrote:
> > From: "GUO Ren (XuanTie)" <guoren@kernel.org>
> >
> > The initial K3 device tree used generic/placeholder values for the
> > IMSIC guest configuration:
> >
> >   riscv,guest-index-bits =3D <6>;
> >   riscv,num-guest-ids    =3D <511>;
> >
> > According to the SpacemiT K3 User Manual [1] these values are
> > incorrect for the X100 cores:
> >
> >  - Hypervisor Extension: RVH 1.0, GEILEN =3D 8
> >  - Advanced Interrupt Architecture (AIA):
> >     - M-mode MSI: 512
> >     - S-mode MSI: 512
> >     - VS-mode MSI: 64
> >
> > Therefore:
> >
> > - S-mode IMSIC (simsic) only needs guest-index-bits =3D 3 (to cover
> >   GEILEN =3D 8) and num-guest-ids =3D 63.
> ..
> > - M-mode IMSIC (mimsic) does not implement guest interrupt files at
> >   all, so the guest-related properties must be omitted.
> >
> Cc Junhui
>
> There is already one fix for IMSIC [1], but it's actually too late to
> pick for v7.3 .. I'm not sure how best to handle this, would it possible
It's not for v7.3; we could merge it in the next window.
The mimsic part is a separate fix; we could do these separately.

> on your side to pick Junhui's patch and rework to combine them to
> send a V2? or I could pick his patch first ..

I would remove the mimsic part, but I won't include it in v2. Because
there is no update for the mimsic patch, v2 makes it confusing.

>
> https://lore.kernel.org/all/20260729-k3-mimsic-fix-v1-1-368c0aec04b9@pigm=
oral.tech/
>
> > Although the KVM AIA driver will re-detect the actual number of guest
> > interrupt files via hgeie and correct guest-index-bits at runtime, the
> > device tree should still describe the correct hardware parameters.
> >
> > Update the device tree to match the silicon.
> >
> ..
> > [1] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=
=3Dhardware/key_stone/k3/k3_docs/k3_usermanual/08_cpu.md
> >
> no blank line and use "Link: https://.. [1]" format
>
> > Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 =
SoC")
> > Cc: stable@vger.kernel.org
> > Cc: Guodong Xu <docular.xu@gmail.com>
> > Cc: Yixun Lan <dlan@kernel.org>
> > Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> > ---
> >  arch/riscv/boot/dts/spacemit/k3.dtsi | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts=
/spacemit/k3.dtsi
> > index 19fc9b49668e..4120eb0c4083 100644
> > --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > @@ -1127,9 +1127,9 @@ simsic: interrupt-controller@e0400000 {
> >                                             <&cpu4_intc 9>, <&cpu5_intc=
 9>,
> >                                             <&cpu6_intc 9>, <&cpu7_intc=
 9>;
> >                       msi-controller;
> > -                     riscv,guest-index-bits =3D <6>;
> > +                     riscv,guest-index-bits =3D <3>;
> >                       riscv,hart-index-bits =3D <4>;
> > -                     riscv,num-guest-ids =3D <511>;
> > +                     riscv,num-guest-ids =3D <63>;
> >                       riscv,num-ids =3D <511>;
> >               };
> >
> > @@ -1168,9 +1168,7 @@ mimsic: interrupt-controller@f1000000 {
> >                                             <&cpu4_intc 11>, <&cpu5_int=
c 11>,
> >                                             <&cpu6_intc 11>, <&cpu7_int=
c 11>;
> >                       msi-controller;
> > -                     riscv,guest-index-bits =3D <6>;
> >                       riscv,hart-index-bits =3D <4>;
> > -                     riscv,num-guest-ids =3D <511>;
> >                       riscv,num-ids =3D <511>;
> >                       status =3D "reserved";
> >               };
> > --
> > 2.43.0
> >
>
> --
> Yixun Lan (dlan)



--=20
Best Regards
 Guo Ren
