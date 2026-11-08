Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138645;
	b=QshO1nSmisosjIUsMPDn5cfJTO+V3uQGXH1JSmicTTOJIF9IFm4Ks9zZH3dgwesAPOaB
	 ATeuPPBd0xk8Gjxh9n6Rw0OlcTpp44QFosbraAH8L+CHw/cp4CO9Wn0joE1r+GeaGzisj
	 3XnJb5HRmHM7OQbnQkwLrgPOYrQhhzmnwKiStU0XHcAC7ZCso597HjZU9P4MZw7x9cbYU
	 Eyi19wor/DlkM6L0dNEvHwhTwRZVty2aF1hmD71N9Nfe33YHUObgKL+ahoGCYXvAjp+mv
	 fkxfAEEl+RyW9tYI3CJ1Hl78rlrAVpUyhy1fbl8Qlx/0NLyeeWe5Wr+cO0orw8v0E9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138645;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iFs5od5bXdQ2LegEpfRcPnj5K0IUuQOJdja1+2xaK9M=;
	b=qgNDve/ns+GQMtLBUKR8RRrxIB729ClqlxLagSzA6oGm9N4BKi6I8Okifi9sN56y5PfK
	 Q8SnqDzYt+zr3iGC9c3bVxISCDk5cM7ZeAHq9uptPNjmR0y9bi+z2hK6D3c1n36MTU32b
	 biUi10066tVA9Sf9pF758E0BGHaVF5Pf99RcRibpV50Ic5lIc7pgDnTSo/FtpkidKBz3t
	 I8+/RjKKf6JvMZKO7Wv0ttyVXFm8H8k9iZlOys4AnPFykHgljMNJpdLemtdLbUiCZd6vk
	 R3C6+2EJ6jA67g4IFVTNxZjSk3tkjg8F89QAm5IFuVMgkr4vBBh11Jhzb/i53ymFL0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX+JTdfk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BE606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX+JTdfk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43511F008A2
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794138643;
	bh=iFs5od5bXdQ2LegEpfRcPnj5K0IUuQOJdja1+2xaK9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EX+JTdfkulIwbmfRHO3BEyl0Mu/jQohxptPSymEDIoS7NCbGzJiGpt00ug2c6rpbo
	 nr2vnWFTrHuuIrYLxBOpkdjUvgnfmx9L/ba9Kf6o8AN1kE71tmQDOGldfr6wFYHUSj
	 1O8yfbtpEgK8TbHGdk30hfMnAa9KodMpxpqTOwZZgsqb5nRyViGomK7vsskZBAMdBQ
	 /P68vjTboM8dbp4jPtnFcpQR454+GA6TYHGcPs/2ugGAZQutcQeMad5I+l9zoz/VA4
	 WVEiUotakbacQLqNf1dOFYzpF1yV15k7BUrmtGvBsdCYsPf3AFbhOxZe/2buEJkbrU
	 dzzF1a0Znwr2Q==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c450ab1483cso7882366b.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 03:50:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzu5UH+28Mo0dbvXpb4ujr4WeUlY6y9H5yZxUiTNyte7fSms2U9yEquJ1pTl2pEfDWOIVXFu0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z81S5Ue4+DGO61Al5uCz/KdCvq3QvsODosq1O2uYZVyoBNFd8yo
	wsysVMppx3rpR3W4uNkpY7QfNvtsYvX184qCHHuSxicLaU8oOAp67+DJGNe3gLIXVE0hRxTcFm9
	Kf5zeAuhj5V/mQMJSH1xgVdu578FHFoM=
X-Received: by 2002:a17:907:2d8d:b0:c4d:4be1:4197 with SMTP id
 a640c23a62f3a-c4d6db2179bmr97283866b.41.1794138642533; Sun, 08 Nov 2026
 03:50:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031-fixes-loongarch-v1-1-e0e33e3c008e@kernel.org>
 <avAr894n6lNGD9C8@kernel.org> <CAAhV-H5kDgiaDF3t9BakAeD31JxET+27jcVvNU=ZQDZv_vSBcA@mail.gmail.com>
 <avBV048xzXRp-cnC@kernel.org>
In-Reply-To: <avBV048xzXRp-cnC@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 8 Nov 2026 19:50:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Paunrio+OX6JchQr3JOfLJW=1D_GGVzCjyAn53291Qw@mail.gmail.com>
X-Gm-Features: AclHuK_oerMpFdYcgrwKmLKMjsGFuCdSpGwy5J6w8hQgR6esaNKhIPEaZQlT5sI
Message-ID: <CAAhV-H6Paunrio+OX6JchQr3JOfLJW=1D_GGVzCjyAn53291Qw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: restore KFENCE pages through DMW on resume
To: Mike Rapoport <rppt@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 6:58=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Sun, Nov 08, 2026 at 04:17:02PM +0800, Huacai Chen wrote:
> > On Sun, Nov 8, 2026 at 3:59=E2=80=AFPM Mike Rapoport <rppt@kernel.org> =
wrote:
> > >
> > > Gentle ping :)
> > Sorry for the late response, would you mind if I modify it to use
> > #ifdef? Usually it should be avoided, but I want to signal users that
> > KFENCE is not a usually enabled feature.
>
> Up to you :)
>
> Do you want me to resend or you can update while applying?
I will update while applying.

Huacai

>
> > Huacai
> >
> > >
> > > On Sat, Oct 31, 2026 at 03:21:46PM +0200, Mike Rapoport (Microsoft) w=
rote:
> > > > With KFENCE enabled, resume from hibernation triggers KFENCE report=
s while
> > > > swsusp_asm_resume() copies the image pages, for example:
> > > >
> > > >   BUG: KFENCE: use-after-free write in swsusp_asm_resume+0x20/0x94
> > > >
> > > >   Use-after-free write at 0x00000000a57ee925 (in kfence-#254):
> > > >    swsusp_asm_resume+0x20/0x94
> > > >    hibernation_restore+0x128/0x1a0
> > > >    load_image_and_restore+0x6c/0xc8
> > > >    software_resume+0x240/0x260
> > > >    do_one_initcall+0x68/0x200
> > > >    kernel_init_freeable+0x26c/0x304
> > > >    kernel_init+0x20/0x134
> > > >    ret_from_kernel_thread+0x24/0x1d0
> > > >    ret_from_kernel_thread_asm+0xc/0x98
> > > >
> > > > During resume from hibernation, the image pages that occupy physica=
l pages
> > > > used by the restore kernel are first loaded into free pages and the=
n, as
> > > > the very last step, swsusp_asm_resume() copies them to their final =
location
> > > > pointed to by pbe->orig_address, which the hibernation core sets to
> > > > page_address() of the page in the restore kernel.
> > > >
> > > > The early KFENCE pool is allocated from memblock and normally occup=
ies the
> > > > same physical pages in the restore kernel and in the image kernel, =
so these
> > > > pages are usually copied by swsusp_asm_resume().
> > > >
> > > > The KFENCE pool is remapped into the KFENCE area above vm_map_base =
and
> > > > set_page_address() adjusts page->virtual so that page_address() ret=
urns
> > > > the page-table mapped alias rather than the DMW address of the pool=
 pages.
> > > >
> > > > Hence, pbe->orig_address of KFENCE pages points to that alias and
> > > > swsusp_asm_resume() writes them through the page tables. But:
> > > >
> > > > * the copy loop overwrites the kernel page tables, so a TLB refill =
for the
> > > >   KFENCE alias may use a partially restored page table
> > > > * the KFENCE pool pages that are protected in the restore kernel fa=
ult in
> > > >   the middle of the copy
> > > >
> > > > Convert pbe->orig_address to DMW addresses before starting the copy=
.
> > > >
> > > > Fixes: 0ca84aeaee15 ("LoongArch: Make {virt, phys, page, pfn} trans=
lation work with KFENCE")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > ---
> > > > Reproduced with hibernation in QEMU, the KFENCE reports are gone wi=
th
> > > > this patch.
> > > > ---
> > > >  arch/loongarch/power/hibernate.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/powe=
r/hibernate.c
> > > > index 817270410ef98..ff571ab4e8df9 100644
> > > > --- a/arch/loongarch/power/hibernate.c
> > > > +++ b/arch/loongarch/power/hibernate.c
> > > > @@ -59,6 +59,18 @@ extern int swsusp_asm_resume(void);
> > > >
> > > >  int swsusp_arch_resume(void)
> > > >  {
> > > > +     struct pbe *pbe;
> > > > +
> > > > +     /*
> > > > +      * page_address() of KFENCE pages is mapped by page tables th=
at are
> > > > +      * overwritten during restore and may be protected by KFENCE,=
 copy
> > > > +      * through DMW instead.
> > > > +      */
> > > > +     if (IS_ENABLED(CONFIG_KFENCE)) {
> > > > +             for (pbe =3D restore_pblist; pbe; pbe =3D pbe->next)
> > > > +                     pbe->orig_address =3D __va(virt_to_phys(pbe->=
orig_address));
> > > > +     }
> > > > +
> > > >       /* Avoid TLB mismatch during and after kernel resume */
> > > >       local_flush_tlb_all();
> > > >       return swsusp_asm_resume();
> > > >
> > > > ---
> > > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > > > change-id: 20261027-fixes-loongarch-fd3755f33919
> > > >
> > > > --
> > > > Sincerely yours,
> > > > Mike.
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.
