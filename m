Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC32FDC28
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930668; cv=none; b=avPXTF+tZ2RMTFavsCq+xLSkoeQ2vhY26Gqs9bJUMicboK55pWuIC0mQ3+jpI5eYAgKpO262UcJDfssweS+89GQR6t+rdsWFsWSZtGLjDueWF6gFCHvIYrmaieEg7fMVKekNTwGC1rM5cJKpvXo8D/beqJb4oG411TqGU15XKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930668; c=relaxed/simple;
	bh=QMju5I8ctfa1RrvwFO5E5YnjxpUvLHaeN6eKSgKjHsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soxa2ZrSOCIBdlE4yH4yYn6+gAoY+/jAOZ51zX86Gtrz7zN+OTd3PBs2S7TLIPaySwBKwa4Z+gv7BLPLqKBkWjDSXSHPsBCwKF8AczHl6THKl4XnFnhGIh1JR9mW9JPTltKzl52JPdmI4TELS1LnSUsGrXyXj8bilolPyfoAf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFiByPYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFiByPYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EDC1F00A3E
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 01:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786930667;
	bh=Mdw2WrAprtmri6kq3AXp//k+l34uk9fCAfsJ9EpaFNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IFiByPYaI3JoNtjDZkT8hiAzYCPLJoNGN9l3xxpjRJzpjFwFstKEp06T/8RyLH5Hv
	 h5/wRLrJ6bhx3qMzfHDVxROjE/lpC0xtSxNie/BOS1ciBctwhmP/cmsl29nHtsg6yC
	 jpRh84S/IPtuK2JVnDJZnlpLstBNMNRfIyw7QXYXSodYREVM/kixunSRBjCrW/WQrj
	 ijX6V/bB0d1CxhGOdS3F0z/QF1mx54mmmECeTxaoK7idFadBxOLvcCz/yGxE6jXpUE
	 josURyeziHZXINtzeiXM/WboNjZWmGcbWwcJD8pDlubftA7KcNcq3D72Pfl+KwQo2p
	 Nr+K26dRmqLKw==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1689536f8f.3
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 18:37:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoHD52aHhEB1QL+42W3s60Ygly7p/rMoGy446mn9w0RAJQyOASMorNz0RoFzpEuck9RdldefQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5HIJDXXdP4o4PhFU5FsH5NJ1/c0NpgMnSK+lH0gvj+SCLy0k
	IAMzwdUv5+MeOXl/+HNWzoRaz/dwYBot7gU8vd1+ibXM/Eq6/r//ha57vm6+GdlP8DcK05xnUUH
	wt6vbD6OFiSiyckTxCyY/JJhONGx4iqM=
X-Received: by 2002:adf:e74c:0:b0:47f:f31d:27a4 with SMTP id
 ffacd0b85a97d-4816075d33emr25717249f8f.13.1786930665792; Sun, 16 Aug 2026
 18:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816074125.2105828-1-guoren@kernel.org> <DKQ8V08O8TKD.QHLCPR9W40HE@pigmoral.tech>
 <CAJF2gTRwMXVzxDL=C3JjmtxP3K5aLqki5qZdcyv751BTZ2p=5g@mail.gmail.com>
In-Reply-To: <CAJF2gTRwMXVzxDL=C3JjmtxP3K5aLqki5qZdcyv751BTZ2p=5g@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 17 Aug 2026 09:37:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRkUvBq9_JEBrfffHBmSmVfHWOocnz56QD5hzoOGk0gKQ@mail.gmail.com>
X-Gm-Features: AcwNN1XLTxQ71XnG-AfWlaeXf9W-RSaqjpUxNik7UZ4dK_RBXIFXrwZN662MX-g
Message-ID: <CAJF2gTRkUvBq9_JEBrfffHBmSmVfHWOocnz56QD5hzoOGk0gKQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: spacemit: k3: fix IMSIC guest parameters
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dlan@kernel.org, devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
	stable@vger.kernel.org, Guodong Xu <docular.xu@gmail.com>, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 8:51=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Aug 16, 2026 at 5:01=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.t=
ech> wrote:
> >
> > Hi Guo,
> >
> > On Sun Aug 16, 2026 at 3:41 PM CST, Guo Ren wrote:
> > > From: "GUO Ren (XuanTie)" <guoren@kernel.org>
> > >
> > > The initial K3 device tree used generic/placeholder values for the
> > > IMSIC guest configuration:
> > >
> > >   riscv,guest-index-bits =3D <6>;
> > >   riscv,num-guest-ids    =3D <511>;
> > >
> > > According to the SpacemiT K3 User Manual [1], these values are
> > > incorrect for the X100 cores:
> > >
> > >  - Hypervisor Extension: RVH 1.0, GEILEN =3D 8
> > >  - Advanced Interrupt Architecture (AIA):
> > >     - M-mode MSI: 512
> > >     - S-mode MSI: 512
> > >     - VS-mode MSI: 64
> > >
> > > Therefore:
> > >
> > > - S-mode IMSIC (simsic) only needs guest-index-bits =3D 3 (to cover
> > >   GEILEN =3D 8) and num-guest-ids =3D 63.
> > > - M-mode IMSIC (mimsic) does not implement guest interrupt files at
> > >   all, so the guest-related properties must be omitted.
> > >
> > > Although the KVM AIA driver will re-detect the actual number of guest
> > > interrupt files via hgeie and correct guest-index-bits at runtime, th=
e
> > > device tree should still describe the correct hardware parameters.
> > >
> > > Update the device tree to match the silicon.
> > >
> > > [1] https://www.spacemit.com/community/document/info?lang=3Den&nodepa=
th=3Dhardware/key_stone/k3/k3_docs/k3_usermanual/08_cpu.md
> > >
> > > Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K=
3 SoC")
> > > Cc: stable@vger.kernel.org
> > > Cc: Guodong Xu <docular.xu@gmail.com>
> > > Cc: Yixun Lan <dlan@kernel.org>
> > > Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> > > ---
> > >  arch/riscv/boot/dts/spacemit/k3.dtsi | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/d=
ts/spacemit/k3.dtsi
> > > index 19fc9b49668e..4120eb0c4083 100644
> > > --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> > > +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > > @@ -1127,9 +1127,9 @@ simsic: interrupt-controller@e0400000 {
> > >                                             <&cpu4_intc 9>, <&cpu5_in=
tc 9>,
> > >                                             <&cpu6_intc 9>, <&cpu7_in=
tc 9>;
> > >                       msi-controller;
> > > -                     riscv,guest-index-bits =3D <6>;
> > > +                     riscv,guest-index-bits =3D <3>;
> >
> > According to the IMSIC DT binding, riscv,guest-index-bits describes
> > the number of guest-index bits in the MSI target address, not the
> > number of guest interrupt files actually implemented by a hart.
> >
> > On K3, the per-hart IMSIC stride is 0x40000 bytes (0x200000 / 8).
> > Therefore, riscv,guest-index-bits should remain 6, which satisfies the
> > per-hart stride formula specified by the AIA specification:
> >
> >   2^(guest-index-bits + 12) =3D 2^(6 + 12) =3D 0x40000 bytes
> >
> > KVM already handles the difference between the address space and the
> > actual number of guest interrupt files. It reads HGEIE to find the
> > actual number of guest interrupt files and uses the smaller value:
> >
> >   /*
> >    * Number of usable per-HART HGEI lines should be minimum of
> >    * per-HART IMSIC guest files and number of bits in HGEIE.
> >    */
> >   if (lc)
> >           hgctrl->nr_hgei =3D
> >                   min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
> >
> > I also tested this on K3. HGEIE returned 0xfe after writing all ones,
> > so the driver gets fls_long(0xfe) - 1 =3D 7 usable guest interrupt file
>
> I don't think the reserved per-hart address stride alone is sufficient
> reason to set riscv,guest-index-bits to 6.
>
> As mentioned in the commit log:
> "Although the KVM AIA driver will re-detect the actual number of guest
> interrupt files via hgeie and correct guest-index-bits at runtime, the
> device tree should still describe the correct hardware parameters."
>
> Although K3 reserves a 0x40000-byte IMSIC address window per hart, only
> the first 0x8000 bytes, corresponding to guest indexes 0 through 7, are
> actually implemented. The remaining range from 0x8000 to 0x3ffff does
> not correspond to any implemented interrupt file.
>
> If we describe guest-index-bits =3D <6>, that raises a few questions:
>  - What hardware resource is represented by guest indexes 8 through 63?
>  - What behavior does the K3 hardware guarantee for accesses to the
> unused 0x8000-0x3ffff range?
>  - Shall we let the kernel map that unused range and consume
> additional page-table entries for it?

After re-reading imsic_parse_fwnode(), you're right. I misunderstood
the semantics here. riscv,guest-index-bits is used to describe the
guest-index field in the IMSIC address layout and therefore determines
the per-hart address stride; it does not directly represent the number
of guest interrupt files actually implemented.

Thanks to you & sashiko-bot for pointing this out.

>
> >
> > >                       riscv,hart-index-bits =3D <4>;
> > > -                     riscv,num-guest-ids =3D <511>;
> > > +                     riscv,num-guest-ids =3D <63>;
> >
> > This change looks good to me.
> Thx for the review.
>
> >
> > >                       riscv,num-ids =3D <511>;
> > >               };
> > >
> > > @@ -1168,9 +1168,7 @@ mimsic: interrupt-controller@f1000000 {
> > >                                             <&cpu4_intc 11>, <&cpu5_i=
ntc 11>,
> > >                                             <&cpu6_intc 11>, <&cpu7_i=
ntc 11>;
> > >                       msi-controller;
> > > -                     riscv,guest-index-bits =3D <6>;
> > >                       riscv,hart-index-bits =3D <4>;
> > > -                     riscv,num-guest-ids =3D <511>;
> > >                       riscv,num-ids =3D <511>;
> > >                       status =3D "reserved";
> > >               };
> >
> > For the mimsic part, I already sent a related fix earlier:
> > https://lore.kernel.org/linux-riscv/20260729-k3-mimsic-fix-v1-1-368c0ae=
c04b9@pigmoral.tech/
> Okay, I would remove the mimsic part.
>
> >
> > If you would like, you can pick that patch and combine the two changes
> > into a v2, as Yixun suggested.
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
