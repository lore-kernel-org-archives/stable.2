Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125836;
	b=x8+dfYmvuxa2teSbupM+oTbBElgB3ckOpAlZPH/mYE08zohv5mRrTxnX4Rd5X3n4KECa
	 ee1de3UQ7BKL1H4kh5e+Zt6FUKOLSTqUXgj01SlVJLo0uywIm0UpBW1JGvuozthmHD2vM
	 HKdxtszHZ13BeDvStB3hfWEdsA1FBEhHpCZAAmBV2a22w7OeR3YQ7afrh+c6PGB2FL/q4
	 qF+8lzVzvOEmLqa2EurN9oKohnNSkmJXDEr/r/S7DBm8cFdMazZZ24qnOjZgoVYwrEQBp
	 TX+j7wGlHU+70ATTFEKyHbgMcI8JDPlhQjkFA9zYC05ENucpiYBs3QEn4p20e4WlP5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125836;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5G5dlJmNinReA7/ecM0YTHSYy6jzMfVBo3rP1dlvGSA=;
	b=uMpwYZFEGU/hKP4/NKbtq0JmwcTvRfKWUSkBCM4GvbGepACvi+8kA/gwQYcsbFWGHmnz
	 Lo4axiCylHbwmaVq6yLEkvS5Ej3S1QyY4OiwbQylSN6ulWA+Dr/aaFL1Z3NYcExj0QDID
	 /zg+CS7URKHrdn3/+kTIThYFQVXiJn0pUdkERhYxmyddP8D8r23bfFd7h6PQ45FcBrvVR
	 x8ZDDDlSWNG3XoR/llXVUfwYOAAEwrB5iI/oGdOhqBblJ+uyd5cssAV22BMWOaQ6M1d2d
	 sO21P40xDMtrj5MqD3r5Lj98BBkK8qSZ16Cs5IMvjD3P1pFLCqor9wx2fqCMdzhkBPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V1YatT/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FD606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1YatT/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C121F008A4
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794125834;
	bh=5G5dlJmNinReA7/ecM0YTHSYy6jzMfVBo3rP1dlvGSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V1YatT/HNDFxAof6DMYsq7uFzNJzww3T6v8VeSzdPfgWasg/HCz1qbGODPIYjmBy3
	 k3p/CjiPfAggNojvZnFP65ZwLqNaRWR/ZSCMObAC72gxeb+hGXTBHSlCEZt3oOsofZ
	 q2Mo5n9IQaIaeRtXhaEykS9ZgrbKKVhHArRJ6ieARHl0P38i/6PrEShl2X/B+TWmAa
	 /9MOGmalJNzd++A3tSD9LBji9t5rwPLlAusNWevVPDfT8+etUeHRSifCIaM7Vh+1jX
	 2p3V7K2iM9EbaAT7CZnU+4bYH6zWFtmxJSBcN9mhCn9Bfj2NIUtsQtcyH2uEItHlbi
	 BHT4/xq4b7LtA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so283671a12.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 00:17:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHZ4oLuTb8iiLXt4iD8hliDhUCQHuoY6hxv7LZuy5Ro5JFCBDTFt/1Hsu2f2EZGheFcTwjy6MY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b7biWV2K6LmwnIju6GtkFthpeVPndETny61IE0nmH437LAfH7
	OaB2dIBhtsMC52YL2rc6DZfAStJRdfVXUaALp4oV3jp47ooZjDlkTMbpMjjPMA+KRg9VZAeU1EA
	h+Fab/7vjonxY7qHZ4IO1iwy93IGYi/c=
X-Received: by 2002:a05:6402:400b:b0:6b6:e8cb:643e with SMTP id
 4fb4d7f45d1cf-6b72244119emr538367a12.23.1794125833477; Sun, 08 Nov 2026
 00:17:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031-fixes-loongarch-v1-1-e0e33e3c008e@kernel.org> <avAr894n6lNGD9C8@kernel.org>
In-Reply-To: <avAr894n6lNGD9C8@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 8 Nov 2026 16:17:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5kDgiaDF3t9BakAeD31JxET+27jcVvNU=ZQDZv_vSBcA@mail.gmail.com>
X-Gm-Features: AclHuK_evHNqSt9o4YcBLRgf6IEwJjqK3z3uypzlyoWpiPLFt8x6t0wFbOv_yL4
Message-ID: <CAAhV-H5kDgiaDF3t9BakAeD31JxET+27jcVvNU=ZQDZv_vSBcA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: restore KFENCE pages through DMW on resume
To: Mike Rapoport <rppt@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 3:59=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> Gentle ping :)
Sorry for the late response, would you mind if I modify it to use
#ifdef? Usually it should be avoided, but I want to signal users that
KFENCE is not a usually enabled feature.

Huacai

>
> On Sat, Oct 31, 2026 at 03:21:46PM +0200, Mike Rapoport (Microsoft) wrote=
:
> > With KFENCE enabled, resume from hibernation triggers KFENCE reports wh=
ile
> > swsusp_asm_resume() copies the image pages, for example:
> >
> >   BUG: KFENCE: use-after-free write in swsusp_asm_resume+0x20/0x94
> >
> >   Use-after-free write at 0x00000000a57ee925 (in kfence-#254):
> >    swsusp_asm_resume+0x20/0x94
> >    hibernation_restore+0x128/0x1a0
> >    load_image_and_restore+0x6c/0xc8
> >    software_resume+0x240/0x260
> >    do_one_initcall+0x68/0x200
> >    kernel_init_freeable+0x26c/0x304
> >    kernel_init+0x20/0x134
> >    ret_from_kernel_thread+0x24/0x1d0
> >    ret_from_kernel_thread_asm+0xc/0x98
> >
> > During resume from hibernation, the image pages that occupy physical pa=
ges
> > used by the restore kernel are first loaded into free pages and then, a=
s
> > the very last step, swsusp_asm_resume() copies them to their final loca=
tion
> > pointed to by pbe->orig_address, which the hibernation core sets to
> > page_address() of the page in the restore kernel.
> >
> > The early KFENCE pool is allocated from memblock and normally occupies =
the
> > same physical pages in the restore kernel and in the image kernel, so t=
hese
> > pages are usually copied by swsusp_asm_resume().
> >
> > The KFENCE pool is remapped into the KFENCE area above vm_map_base and
> > set_page_address() adjusts page->virtual so that page_address() returns
> > the page-table mapped alias rather than the DMW address of the pool pag=
es.
> >
> > Hence, pbe->orig_address of KFENCE pages points to that alias and
> > swsusp_asm_resume() writes them through the page tables. But:
> >
> > * the copy loop overwrites the kernel page tables, so a TLB refill for =
the
> >   KFENCE alias may use a partially restored page table
> > * the KFENCE pool pages that are protected in the restore kernel fault =
in
> >   the middle of the copy
> >
> > Convert pbe->orig_address to DMW addresses before starting the copy.
> >
> > Fixes: 0ca84aeaee15 ("LoongArch: Make {virt, phys, page, pfn} translati=
on work with KFENCE")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> > Reproduced with hibernation in QEMU, the KFENCE reports are gone with
> > this patch.
> > ---
> >  arch/loongarch/power/hibernate.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hi=
bernate.c
> > index 817270410ef98..ff571ab4e8df9 100644
> > --- a/arch/loongarch/power/hibernate.c
> > +++ b/arch/loongarch/power/hibernate.c
> > @@ -59,6 +59,18 @@ extern int swsusp_asm_resume(void);
> >
> >  int swsusp_arch_resume(void)
> >  {
> > +     struct pbe *pbe;
> > +
> > +     /*
> > +      * page_address() of KFENCE pages is mapped by page tables that a=
re
> > +      * overwritten during restore and may be protected by KFENCE, cop=
y
> > +      * through DMW instead.
> > +      */
> > +     if (IS_ENABLED(CONFIG_KFENCE)) {
> > +             for (pbe =3D restore_pblist; pbe; pbe =3D pbe->next)
> > +                     pbe->orig_address =3D __va(virt_to_phys(pbe->orig=
_address));
> > +     }
> > +
> >       /* Avoid TLB mismatch during and after kernel resume */
> >       local_flush_tlb_all();
> >       return swsusp_asm_resume();
> >
> > ---
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > change-id: 20261027-fixes-loongarch-fd3755f33919
> >
> > --
> > Sincerely yours,
> > Mike.
> >
>
> --
> Sincerely yours,
> Mike.
