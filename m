Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019121ABC9
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079054; cv=none; b=JRD5IqWUWXy5vvA/DrgI1F3W0Tp+Vy/3QCxq+LbyNfi4U7rEqIN8nWYjyS9zHhEZP1/xPtmHYuawxidJAGZeg8fG0tKxsZwAtJKfjZ3D274mxGFJCaQ7NCT9/97jWLdw3+H/dJDKMKuPPMFDfYKOwF+Q29k1AJiGnff++n8JjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079054; c=relaxed/simple;
	bh=McY3K7VDTMi8ZrzizDGQl15zOhOq9zqWf7jMwHFTh/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp7O90uLoypAOWt8FYx/T6JxlUV0ydyYU0SaSj+/sfoCQ44gwOzGQE5cnZJMiR+cm8IMarRKCKt4QcW1fSutQF/CWXX+RPqRRu2Cp+QEDtw4omfaTgwEHPi4UI4hSZRr5IVfGmHwMrrP4lnXnEfiDWOQLlYTiy/J6A2/gTjp4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7qJ0LqA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7qJ0LqA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so24654455e9.1
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782079049; x=1782683849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnjRZI77pUOXDjzOwMy3Sb5T9hhxUtWhO4PGTTAP6lA=;
        b=o7qJ0LqAKnehxiGNAWJPL8iAZ4Ggxt0b4ZxHMv8Ln6re7Nh/9G0/M98pY7PYwKATxY
         3rNEsaFVPLcFqXfFoqZ7sOaOV8CPdA4t1we6qxGOQd5BRZcHFTi7Iqh2y0pF9MhsXFDz
         9BfrJDlSIRrno5PQ9z/RCeepnmgZhnhXr8cyjqIjq1FRnB2IK3hQXQYS5qWQD+1Pw844
         8PpWNqHhB80j3iI1e7KsR2dWDxB+Nb2tichRwGMKvc3ayAxTEyYecoWXM7MwjudoVHEF
         wqNO44A0LMa994IgSXulQuJQE6/7gAWJ9b22s8ZVDCLVTdPCRaWHAhkPjkno3WWwY6KU
         aoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782079049; x=1782683849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnjRZI77pUOXDjzOwMy3Sb5T9hhxUtWhO4PGTTAP6lA=;
        b=Gt13ZCE9ZZG/UKOXq857M2uEAiQUVcKhdOtGiDs9whvluX8qWqGlmpL9JYAaTI6C7A
         aPoA5LgC00utr2EqRxauCCKIw4Wv1gu6dMM6iS3qIPZqZxXeONVHhnGxaRx+hD04qeA0
         aV2jp6P9K1ChAEG4i1fIXlSJKP1b/R6fXycUOSasoEERE40dplm4JsvsM4dHcdozJIhd
         pTox2aql3Sm3LM+M19hyuoWRq9lJhKn7I3lwC2798dHHexpW3Y7TQb/jNgg1DXMiZ1LX
         /faScTk7rqp8JRr2E9RckP8YzM6TpGDMoyt/N8Xb6UnptPHo2kqzDod0QklvDN6No186
         GiDg==
X-Forwarded-Encrypted: i=1; AFNElJ+g0IzuN0QUlspC/N3GS7mhvKGeuIXzbRPWrVy6vCwcXQBmyHQVu0s9BOx8Xs8ht1KQvzloK0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/zLOs43QZ9QLXBzLw0PVGSv8N4QgBaFgRzWPH0j2+GuKH53x
	TGWe3+wOShjQi3GJg3o+nleZyEA3YH8/bYiL9ugBsZdPMyjbaUgesO94
X-Gm-Gg: AfdE7cnPOkPvMlQ2/GJhwRoKttJcT2WWZdRoZn6PYOevC/R3KFk26wNXj3rLTuwiPLq
	mNic0g9dTIjHFfzzmuUJFV600F2y8GygFu3utMNKk/CbUGhy8wUPDKZULjSv6ZFDia3MWj2xMXR
	iuPHunWmZ+CJnypeLF4bNlehYh/USv2QGGY/qVIBjAVjs6Vc6OyKmQbuFJdFfa7LbPCAzHSuVu2
	AmttDTPG2hiY35xrESWrpJKjCECFAGxUsPkWW9P/zM2I7qDCG8X/6NZ2a+2uILLh72Rc3ZXAYDI
	X2Fa0pAU58LJgvaWLnuJ3WFdYbtXomm3daqxrbkCvltjEMVMy8nerkg3Wbgpa33QEsisViBCyHG
	F/ct5JN63rhSBip1kfq3X8Stfx/60RCezdQ7+gZATfnNz+3J7Fd8FX0O+NQZHuXD7wxgqHfvLwi
	yLCA9y1092ILq65UdHtcSU2mPOGG4jwvHpjQNf1M4OHWvDHvgAQA==
X-Received: by 2002:a05:600c:4445:b0:490:5074:651e with SMTP id 5b1f17b1804b1-49242581c90mr157574355e9.25.1782079049046;
        Sun, 21 Jun 2026 14:57:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240ee9bc2sm171873645e9.1.2026.06.21.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 14:57:28 -0700 (PDT)
Date: Sun, 21 Jun 2026 22:57:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alvin Lim <alvinwylim@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Message-ID: <20260621225727.734e5ecc@pumpkin>
In-Reply-To: <CA+CYLR6Rg-3brg9yCMAKJDr7t=mtu4vP0+aMFs+JhLPWtQxOYA@mail.gmail.com>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
	<20260621134809.7b1b2e3f@pumpkin>
	<CA+CYLR6Rg-3brg9yCMAKJDr7t=mtu4vP0+aMFs+JhLPWtQxOYA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 21 Jun 2026 22:02:31 +0800
Alvin Lim <alvinwylim@gmail.com> wrote:

> > It seems more likely that the wrong addresses are ending up in the host
> > side of the iommu and using bounce buffers fixes that.
> > Using the wrong addresses is likely to lead to major kernel memory
> > corruptions.
> > Mixing up physical addresses and dma addresses, assuming that memory
> > from dma_alloc_coherent() is physically contiguous, or just losing the
> > high bits of the physical address passed to the iommu seem more likely.=
 =20
>=20
> Thank you - this is the right question to ask, and you're correct that
> my commit message overstates what I actually established. I described the
> controller's internal behaviour as fact when it is an inference from the
> failure class, not something I characterised on the silicon. I'll reword
> v2 to claim only what I measured. I also did not instrument the IOVAs
> actually handed to the device, so I won't argue the allocator internals
> with you.
>=20
> But I don't think a host-side addressing bug fits the observations,
> independent of mechanism, for three reasons:
>=20
> 1. The fault is specific to this one controller. On this host the AMD
>    IOMMU also translates for four NVMe controllers (three of them Ceph
>    OSDs under identical load) and the NIC - all doing 64-bit DMA through
>    the same iommu, same kernel, same RAM. Every one of them is clean: the
>    NVMe OSDs deep-scrub to zero errors. Only the six disks behind the
>    ASM1166 corrupt. A host-side bug - phys/dma mixup, a
>    dma_alloc_coherent() contiguity assumption, or high bits lost into the
>    iommu - is device-agnostic: the mapping path doesn't know which device
>    sits behind an IOVA, so it would have to corrupt NVMe too. It doesn't.
>    That selectivity is what points at the controller rather than the
>    kernel.
>=20
> 2. It is load-dependent. Single isolated reads are almost always clean;
>    only concurrent reads corrupt (six parallel dd of one file return six
>    different md5s; serial reads agree). A deterministic host-side
>    addressing bug would not switch on and off with concurrency.
>=20
> 3. The fix holds at scale. Running amd_iommu=3Doff, the controller only
>    ever sees real physical addresses - the top of this box's RAM is
>    0x83e2fffff (~33 GiB, a 36-bit address, from /proc/iomem) - and a full
>    deep-scrub of the 5.4 TiB / 1.43M-object pool re-read end-to-end with
>    zero scrub errors, plus ~4.7 TiB of backfill writes through the same
>    path, also at zero.
>=20
> On your "works with the iommu off, so it supports 64-bit" inference:
> amd_iommu=3Doff does not exercise the 64-bit range on this box. With the
> iommu off the controller is handed untranslated physical addresses, and
> the highest in the map is 0x83e2fffff (36-bit, from /proc/iomem). The
> clean scrub in (3) is therefore strong evidence the controller does
> correct DMA up to ~36-bit - which is also how I know it is not truly
> 32-bit. It says nothing about the full 64-bit range, because no address
> that high is ever presented to it in that configuration.
>=20
> A note on what I actually validated: the at-scale proof above is under
> amd_iommu=3Doff. The submitted quirk is the IOMMU-preserving equivalent -
> it caps the controller's DMA mask at 32 bits and bounces transfers above
> 4 GiB via SWIOTLB. 32-bit addresses are a strict subset of the ~36-bit
> physical range already shown clean, so the quirk is conservative relative
> to what is validated; I have not separately re-run the scrub under the
> quirk itself, as this is a production NAS and I won't deliberately
> re-induce corruption to characterise it.

I'd definitely look at how the iommu code selects the address the target
side uses.
There is something very fishy going on.
With the iommu enabled whether bounce buffers get used should make no
difference - the address the device sees is different from the physical
address. But with a 32bit dma mask it should always generate low addresses
(regardless of the physical address of the buffer).

One possibility is the iommu code uses increasing addresses for each transf=
er
(to get uniqueness) but resets the address when idle.
That would mean the a single thread test would keep using the same address
(so it would stay low) but concurrent requests would keep using forever
larger addresses until the target starts aliasing the addresses (it puts
in the request TLP). At which point the requests should hit invalid iommu
pte (or whatever they are called) and the PCIe read/write should fail.
I'm not sure what the device would see - PCIe writes are 'posted' and
async, host reads of invalid addresses return ~0 and trigger an AER error
(if enabled and if anyone can manage to work out what to do, hint an NMI
into the host is not helpful on a 'nebs' rated server).

One effect of setting the dma mask to 32bits is to force swiotbl bounces
when they aren't needed because the iommu is disabled/absent.
I think you are probably using the wrong shaped hammer :-)

	David

>=20
> This is the same shape as the sibling ASMedia ASM1061, quirked to 43-bit
> DMA (20730e9b2778), and JMicron JMB585, quirked to 32-bit (105c42566a55).
> I submitted the conservative 32-bit lower bound (as JMB585 itself
> shipped) rather than assert a width I did not measure; a later change can
> widen it if someone characterises the true value.
>=20
> If it helps, I'll send a v2 whose commit message states only the measured
> facts - corruption isolated to the ASM1166's disks while every other DMA
> master on the same IOMMU is clean; load-dependent; eliminated by
> constraining the controller's DMA, verified at scale - and leaves the
> internal silicon mechanism as inference consistent with the existing
> ASM1061/JMB585 quirks rather than asserting it.
>=20
> Would that address your concern?
>=20
> Thanks,
> Alvin
>=20
> On Sun, Jun 21, 2026 at 8:48=E2=80=AFPM David Laight <david.laight.linux@=
gmail.com>
> wrote:
>=20
> > On Sun, 21 Jun 2026 18:08:44 +0800
> > Alvin Lim <alvinwylim@gmail.com> wrote:
> > =20
> > > The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> > > support (AHCI CAP.S64A), but on systems with the IOMMU enabled - wher=
e it
> > > can be handed DMA addresses above 4 GB - it silently corrupts data in
> > > transit. =20
> >
> > That seems wrong.
> > If any iommu is disabled the sata cotroller will be passed the memory's
> > physical address which is very likely to be over 4G.
> > So the controller seems to support 64bit addresses - as advertised.
> >
> > But with the iommu enabled the addresses the controller needs to use are
> > different from the physical address - so the controller will almost
> > certainly see sub 4G addresses for buffers above 4G.
> > (The iommu probably allocates 32bit PCIe addresses for all buffers so t=
hat
> > it doesn't have to worry about targets that only support 32bit addresse=
s.)
> >
> > It seems more likely that the wrong addresses are ending up in the host
> > side of the iommu and using bounce buffers fixes that.
> > Using the wrong addresses is likely to lead to major kernel memory
> > corruptions.
> >
> > Mixing up physical addresses and dma addresses, assuming that memory
> > from dma_alloc_coherent() is physically contiguous, or just losing the
> > high bits of the physical address passed to the iommu seem more likely.
> >
> >         David
> >
> >
> > =20
> > > Reads return different, wrong data on each access. SMART is clean,
> > > there are no SATA link resets and no MCE is raised, so the corruption=
 is
> > > invisible until it surfaces as filesystem metadata errors (XFS EUCLEA=
N)
> > > or, on Ceph, mass scrub errors across multiple independent filesystem=
s at
> > > once - i.e. host-level, not filesystem-level.
> > >
> > > This is the same failure mode already quirked for other controllers t=
hat
> > > falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> > > force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> > > ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers"=
).
> > > The ASM1166 currently maps to plain board_ahci with no DMA limit.
> > >
> > > Limit the ASM1166 to 32-bit DMA. 32-bit is the guaranteed-correct low=
er
> > > bound; the only cost is extra SWIOTLB bounce-buffering on transfers a=
bove
> > > 4 GB, negligible for storage. A future change can widen it to the
> > > controller's true addressable width if characterised. Until this land=
s =20
> > the =20
> > > only workarounds are disabling the IOMMU (amd_iommu=3Doff / =20
> > intel_iommu=3Doff) =20
> > > or using an HBA.
> > >
> > > Reproduced on an AOOSTAR WTR MAX (AMD Ryzen 7 PRO 8845HS) whose six S=
ATA
> > > bays all hang off one ASM1166: with the IOMMU on, six concurrent
> > > 'dd ... | md5sum' of the same large file return six different sums; w=
ith
> > > amd_iommu=3Doff they are identical, and a full Ceph deep-scrub of a 5=
.4 TiB
> > > / 1.43M-object pool re-reads end-to-end with zero scrub errors.
> > >
> > > Add a board_ahci_32bit_dma board type (mirroring board_ahci_43bit_dma)
> > > and point the ASM1166 entry at it.
> > >
> > > Fixes: 3bf614106094 ("ata: ahci: add identifiers for ASM2116 series =
=20
> > adapters") =20
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Claude:claude-opus-4.8
> > > Signed-off-by: Alvin Lim <alvinwylim@gmail.com>
> > > ---
> > >  drivers/ata/ahci.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > > index 58f512f8952a..895956c2ca15 100644
> > > --- a/drivers/ata/ahci.c
> > > +++ b/drivers/ata/ahci.c
> > > @@ -48,6 +48,7 @@ enum {
> > >  enum board_ids {
> > >       /* board IDs by feature in alphabetical order */
> > >       board_ahci,
> > > +     board_ahci_32bit_dma,
> > >       board_ahci_43bit_dma,
> > >       board_ahci_ign_iferr,
> > >       board_ahci_no_debounce_delay,
> > > @@ -132,6 +133,13 @@ static const struct ata_port_info ahci_port_info=
[] =20
> > =3D { =20
> > >               .udma_mask      =3D ATA_UDMA6,
> > >               .port_ops       =3D &ahci_ops,
> > >       },
> > > +     [board_ahci_32bit_dma] =3D {
> > > +             AHCI_HFLAGS     (AHCI_HFLAG_32BIT_ONLY),
> > > +             .flags          =3D AHCI_FLAG_COMMON,
> > > +             .pio_mask       =3D ATA_PIO4,
> > > +             .udma_mask      =3D ATA_UDMA6,
> > > +             .port_ops       =3D &ahci_ops,
> > > +     },
> > >       [board_ahci_43bit_dma] =3D {
> > >               AHCI_HFLAGS     (AHCI_HFLAG_43BIT_ONLY),
> > >               .flags          =3D AHCI_FLAG_COMMON,
> > > @@ -1559,7 +1567,7 @@ static const struct pci_device_id ahci_pci_tbl[=
] =3D =20
> > { =20
> > >       }, {
> > >               /* ASM1166 */
> > >               PCI_VDEVICE(ASMEDIA, 0x1166),
> > > -             .driver_data =3D board_ahci,
> > > +             .driver_data =3D board_ahci_32bit_dma,
> > >       }, {
> > >               /*
> > >                * Samsung SSDs found on some macbooks.  NCQ times out =
if =20
> > MSI is =20
> > >
> > > base-commit: 322008f87f917e2217eeac386a9410945092eb2e =20
> >
> > =20

