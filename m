Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135512;
	b=O/Bw1Y80WTqnzOkxh6PhNcX1MryDajV8SrmW1dCBi0x2o/I+jr+5senzVEuil33cF9Du
	 jIf5N/xbgliQOzKNT0zqN2pomfuzS6v7OXfLKW9h7vbbDFSI9HAR0Hj+ItHawT85l2KhL
	 WObkArqPOHqO/8dp+qJGVDz0l1xFoZ7Dek+ZE6n6iYR4CaPEPqrbD2bmmwjmP3MEwrob2
	 KhWKkkUVr8SpTnxXJOrPRmzheyR+0Lvdd5iRfrvT6M9/5lR3VEqHITIql1evGSgQz6MqM
	 we6bC2WVX21qq/+cjxVSfspakpX99Lvr3lXNc4BFF6V2Yawz4X2fcPCexhVsoIiU6Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135512;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xZpTSZLjpiXRLgQz+yKgZHrReimr9BjYFib1X4thl4Q=;
	b=Jr51QnZcfGFpofpM/w6LenRXibTNYCZ5nE356iAZMQSJfWQJUYjLfEDP4RJmlfr8bCVO
	 Dkd9oCNMwzt4cqzFGrfANsLhAl+lvqYCSiGmSC7DngUqKIS+xQBm3mcCIeQg2YR4j0Cl0
	 j3HTMaURNb85qBx221d97Pn1SH3J32RKC+1WZRiEDJuRJLqQ4xMUIbjyYuPDNwX/cXNBJ
	 FAr9U+Ax6DmOz30JiQnby4MYpjofGQzf3pQZnzMXoFS9N5HarfmZR4TGuscn+PxAADWyj
	 w8oWReWubtBL3pRQ4ebmY4K0JyiEw4MqCGBkVjiFar2vMTW9qB+eUWK3dviuMyabBiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXNiNxgM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52948606A31C;
	Sun,  8 Nov 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXNiNxgM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB911F0089F;
	Sun,  8 Nov 2026 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794135511;
	bh=xZpTSZLjpiXRLgQz+yKgZHrReimr9BjYFib1X4thl4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cXNiNxgMl+fncHz5npPyFiFoO3qsK1M/5wj4XkAyv/9pmjUgjLTCzb3xH2NrYgk2M
	 e9IO4PN3DtpdqPZLm7ps39m/edZLXv64LsV47kBRTV1t0Ho4CcSrnUPgtU+CwYpSpG
	 DRyeQlAdLSvfcHlqoev4xuoxb5fOlx2r6VlmXAM+511X/uq5WhPaTbN9jQKpCjycrd
	 JmCsg/g12HHxX+pzceICghVbWCeDhkcnpVdxKrXH/YjRksQREeJMrXRpD5evTdkmTx
	 nvFpWlxzurTZYslUV95Czjnd7IQUMgFNSi3isQNX6RR7cUQnSfawu3lNm5B30+4G9L
	 AH+Y071Nq3jJA==
Date: Sun, 8 Nov 2026 12:58:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: restore KFENCE pages through DMW on resume
Message-ID: <avBV048xzXRp-cnC@kernel.org>
References: <20261031-fixes-loongarch-v1-1-e0e33e3c008e@kernel.org>
 <avAr894n6lNGD9C8@kernel.org>
 <CAAhV-H5kDgiaDF3t9BakAeD31JxET+27jcVvNU=ZQDZv_vSBcA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5kDgiaDF3t9BakAeD31JxET+27jcVvNU=ZQDZv_vSBcA@mail.gmail.com>

On Sun, Nov 08, 2026 at 04:17:02PM +0800, Huacai Chen wrote:
> On Sun, Nov 8, 2026 at 3:59 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Gentle ping :)
> Sorry for the late response, would you mind if I modify it to use
> #ifdef? Usually it should be avoided, but I want to signal users that
> KFENCE is not a usually enabled feature.

Up to you :)

Do you want me to resend or you can update while applying?
 
> Huacai
> 
> >
> > On Sat, Oct 31, 2026 at 03:21:46PM +0200, Mike Rapoport (Microsoft) wrote:
> > > With KFENCE enabled, resume from hibernation triggers KFENCE reports while
> > > swsusp_asm_resume() copies the image pages, for example:
> > >
> > >   BUG: KFENCE: use-after-free write in swsusp_asm_resume+0x20/0x94
> > >
> > >   Use-after-free write at 0x00000000a57ee925 (in kfence-#254):
> > >    swsusp_asm_resume+0x20/0x94
> > >    hibernation_restore+0x128/0x1a0
> > >    load_image_and_restore+0x6c/0xc8
> > >    software_resume+0x240/0x260
> > >    do_one_initcall+0x68/0x200
> > >    kernel_init_freeable+0x26c/0x304
> > >    kernel_init+0x20/0x134
> > >    ret_from_kernel_thread+0x24/0x1d0
> > >    ret_from_kernel_thread_asm+0xc/0x98
> > >
> > > During resume from hibernation, the image pages that occupy physical pages
> > > used by the restore kernel are first loaded into free pages and then, as
> > > the very last step, swsusp_asm_resume() copies them to their final location
> > > pointed to by pbe->orig_address, which the hibernation core sets to
> > > page_address() of the page in the restore kernel.
> > >
> > > The early KFENCE pool is allocated from memblock and normally occupies the
> > > same physical pages in the restore kernel and in the image kernel, so these
> > > pages are usually copied by swsusp_asm_resume().
> > >
> > > The KFENCE pool is remapped into the KFENCE area above vm_map_base and
> > > set_page_address() adjusts page->virtual so that page_address() returns
> > > the page-table mapped alias rather than the DMW address of the pool pages.
> > >
> > > Hence, pbe->orig_address of KFENCE pages points to that alias and
> > > swsusp_asm_resume() writes them through the page tables. But:
> > >
> > > * the copy loop overwrites the kernel page tables, so a TLB refill for the
> > >   KFENCE alias may use a partially restored page table
> > > * the KFENCE pool pages that are protected in the restore kernel fault in
> > >   the middle of the copy
> > >
> > > Convert pbe->orig_address to DMW addresses before starting the copy.
> > >
> > > Fixes: 0ca84aeaee15 ("LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > > Reproduced with hibernation in QEMU, the KFENCE reports are gone with
> > > this patch.
> > > ---
> > >  arch/loongarch/power/hibernate.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
> > > index 817270410ef98..ff571ab4e8df9 100644
> > > --- a/arch/loongarch/power/hibernate.c
> > > +++ b/arch/loongarch/power/hibernate.c
> > > @@ -59,6 +59,18 @@ extern int swsusp_asm_resume(void);
> > >
> > >  int swsusp_arch_resume(void)
> > >  {
> > > +     struct pbe *pbe;
> > > +
> > > +     /*
> > > +      * page_address() of KFENCE pages is mapped by page tables that are
> > > +      * overwritten during restore and may be protected by KFENCE, copy
> > > +      * through DMW instead.
> > > +      */
> > > +     if (IS_ENABLED(CONFIG_KFENCE)) {
> > > +             for (pbe = restore_pblist; pbe; pbe = pbe->next)
> > > +                     pbe->orig_address = __va(virt_to_phys(pbe->orig_address));
> > > +     }
> > > +
> > >       /* Avoid TLB mismatch during and after kernel resume */
> > >       local_flush_tlb_all();
> > >       return swsusp_asm_resume();
> > >
> > > ---
> > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > > change-id: 20261027-fixes-loongarch-fd3755f33919
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
> > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
