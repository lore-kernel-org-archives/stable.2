Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76B23741
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786927883; cv=none; b=QtuzBu4W52l4jTGzwdOjgBvsxpn37Zj7vIQFtjHp0w4CfnGnZc1U7Jaw+lqDyXlZV1M3KANXvAB7lfUCISqoIjqrHT5Wz35+0WvFdMlTfoGUw16oOIZkFe3vWPOF+V6EfIpU7zDcY9bLXQDt2awg/fOv5uFskHM0lw6ltxZjAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786927883; c=relaxed/simple;
	bh=doXuL1EmQFsFUTuzqzEkyqw3QjIMey0buz+8dUHN0sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9FhFzstTW21qaJGPA4keX6mmx78upEMqTuyQKu4wZbkVvBy0TcHcaVB9pU6uI+/a0o8D1oShrr+yaLO0yxkOhiKQlyVDN9yUseSDlBEjb3pSCW+aBe0sun5OLvlp7f3aaokLP7FKWVbDvFo0WQ2oZ6g0IodBp2PDrAX0jtT0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXqgszus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXqgszus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DDE1F00A3F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786927882;
	bh=PYq3lsa/Oi8dnPmiPAXKaQHT4eRBFtxYWtEVJj/IqnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FXqgszusNuufG8bfQmvMJQzOZNlcHYKRUauGQiJ21jfuY7BqgIC9qXrHBsSQJK51k
	 8cyQ27Tshn517HN3kMaQsHGaG032tTVOMtK8PfeeYyMgdJ7PHI4GQE8P3Tr/CFavvZ
	 uc69e1KU3y0B07wbsdPnUg6brShi2xOYe74nO3ag3Frze079nCEIVL/0JSo5uTTg/8
	 ZEP91GJjEpFp9AUGMvKUaPQp56u53yWOfXxndDIZf7qjWsiKTJYZt1wr5Q8nasX+St
	 bO29tXKEt9qg3rijdNFzsrVn4pJXnFZx7//6WzF71KtAThgDXZoXKV6Rj9W+0WSa1G
	 LYymYESB4KjPw==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f84023916so2666123f8f.3
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 17:51:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq2Of9RNtG2JK9pSyHQ95tbHoeXWev5l60dC+jlssVPnzo3EICTEvAJnLzngmx6QPW1Soj576c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPU0eMzBaJgzpzR7LHnXKLwVt7gwL0UnTsyhPtO45eMaJf03dh
	2BgqAG57b/QGYyCegn8PMU6otO2+5qUQxve4nS29zyYk70Cie2h+9QhSbTB85Bkso87y/fnNKnC
	Kbl2OJme+VwvQlyWMew4puX/JnJ879iA=
X-Received: by 2002:a05:6000:2c09:b0:47f:9760:4d2e with SMTP id
 ffacd0b85a97d-481607618e8mr27937060f8f.24.1786927880559; Sun, 16 Aug 2026
 17:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816074125.2105828-1-guoren@kernel.org> <DKQ8V08O8TKD.QHLCPR9W40HE@pigmoral.tech>
In-Reply-To: <DKQ8V08O8TKD.QHLCPR9W40HE@pigmoral.tech>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 17 Aug 2026 08:51:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRwMXVzxDL=C3JjmtxP3K5aLqki5qZdcyv751BTZ2p=5g@mail.gmail.com>
X-Gm-Features: AcwNN1WU1MNdBpQY-vPRrNvDmBPPyD6eTSwnIFNd601KbR74IzZdtewLxNO4yDA
Message-ID: <CAJF2gTRwMXVzxDL=C3JjmtxP3K5aLqki5qZdcyv751BTZ2p=5g@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: spacemit: k3: fix IMSIC guest parameters
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dlan@kernel.org, devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
	stable@vger.kernel.org, Guodong Xu <docular.xu@gmail.com>, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 5:01=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.tec=
h> wrote:
>
> Hi Guo,
>
> On Sun Aug 16, 2026 at 3:41 PM CST, Guo Ren wrote:
> > From: "GUO Ren (XuanTie)" <guoren@kernel.org>
> >
> > The initial K3 device tree used generic/placeholder values for the
> > IMSIC guest configuration:
> >
> >   riscv,guest-index-bits =3D <6>;
> >   riscv,num-guest-ids    =3D <511>;
> >
> > According to the SpacemiT K3 User Manual [1], these values are
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
> > - M-mode IMSIC (mimsic) does not implement guest interrupt files at
> >   all, so the guest-related properties must be omitted.
> >
> > Although the KVM AIA driver will re-detect the actual number of guest
> > interrupt files via hgeie and correct guest-index-bits at runtime, the
> > device tree should still describe the correct hardware parameters.
> >
> > Update the device tree to match the silicon.
> >
> > [1] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=
=3Dhardware/key_stone/k3/k3_docs/k3_usermanual/08_cpu.md
> >
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
>
> According to the IMSIC DT binding, riscv,guest-index-bits describes
> the number of guest-index bits in the MSI target address, not the
> number of guest interrupt files actually implemented by a hart.
>
> On K3, the per-hart IMSIC stride is 0x40000 bytes (0x200000 / 8).
> Therefore, riscv,guest-index-bits should remain 6, which satisfies the
> per-hart stride formula specified by the AIA specification:
>
>   2^(guest-index-bits + 12) =3D 2^(6 + 12) =3D 0x40000 bytes
>
> KVM already handles the difference between the address space and the
> actual number of guest interrupt files. It reads HGEIE to find the
> actual number of guest interrupt files and uses the smaller value:
>
>   /*
>    * Number of usable per-HART HGEI lines should be minimum of
>    * per-HART IMSIC guest files and number of bits in HGEIE.
>    */
>   if (lc)
>           hgctrl->nr_hgei =3D
>                   min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
>
> I also tested this on K3. HGEIE returned 0xfe after writing all ones,
> so the driver gets fls_long(0xfe) - 1 =3D 7 usable guest interrupt file

I don't think the reserved per-hart address stride alone is sufficient
reason to set riscv,guest-index-bits to 6.

As mentioned in the commit log:
"Although the KVM AIA driver will re-detect the actual number of guest
interrupt files via hgeie and correct guest-index-bits at runtime, the
device tree should still describe the correct hardware parameters."

Although K3 reserves a 0x40000-byte IMSIC address window per hart, only
the first 0x8000 bytes, corresponding to guest indexes 0 through 7, are
actually implemented. The remaining range from 0x8000 to 0x3ffff does
not correspond to any implemented interrupt file.

If we describe guest-index-bits =3D <6>, that raises a few questions:
 - What hardware resource is represented by guest indexes 8 through 63?
 - What behavior does the K3 hardware guarantee for accesses to the
unused 0x8000-0x3ffff range?
 - Shall we let the kernel map that unused range and consume
additional page-table entries for it?

>
> >                       riscv,hart-index-bits =3D <4>;
> > -                     riscv,num-guest-ids =3D <511>;
> > +                     riscv,num-guest-ids =3D <63>;
>
> This change looks good to me.
Thx for the review.

>
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
>
> For the mimsic part, I already sent a related fix earlier:
> https://lore.kernel.org/linux-riscv/20260729-k3-mimsic-fix-v1-1-368c0aec0=
4b9@pigmoral.tech/
Okay, I would remove the mimsic part.

>
> If you would like, you can pick that patch and combine the two changes
> into a v2, as Yixun suggested.

--=20
Best Regards
 Guo Ren
