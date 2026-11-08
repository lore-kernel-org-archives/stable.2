Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124793;
	b=Z2Z3EDAj0yRVBoG6cYCEJAwbyZla/t4GlZKiTfRsI4nx0piq46FzU91YePRx4CRS+pQg
	 pi+fNkapoPDfXUY47FXFd41kkOt8aeV2pgwJfgVSVILc9NZceTCKbxtXJ2PswCgd/OSUd
	 lqKMWnw41b8gA8uZch0ELYjfcTltgfs1t6cU9YR/6edXeZOMKQLEu2Yywq8IwBpr7fcYl
	 rBe0rJyE8Ire2pqulAOWMOrNEKCQlaQKw+EizNj0Js6asxtyh1eVMQWVw+llMcbIfVXRG
	 GnPjCb9TCRPY6negETL3a5Wn/8HSMHJT+ugwAx4BgseXiXaFQSB0OxWfQHtU6bnKKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124793;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kiWdoUL35CtK4AqpYlqytBUDE4prNrZdQBOX59MoB6Q=;
	b=Wuvy/2Mlk9r77G7ehx1Qj02wkV1q/Y6bknEdD9E+Hr/zQ4iUpfHXtDRPYGIPzvmeKiuw
	 HLE+pqH73IVLe+DjnrJZsd+FGRrXE5WZTgMEbakM9ne5YpHZA4uoFFryQ+9ekhEEuJq4G
	 /lvyYkFPyxLJbjcZbEwIQ2WBp3FdsGF1NNUU4aUIeZb0ZvOdJ3CuFBrCuQRwx2UB2+Tet
	 2bLQQdH/XAooDI3fIeVPqdx//G8mfnhBmSChhrlODnWulvlljGwzb+T1ZZxfpj6U0i755
	 V+zRtz53kkhyFK1CjRxlPIKBFZ2/+BmmRZvhpHyQ/lnAeKBk4cw+/KC71u043y2JkYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KU8+Oqyd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513E606A320;
	Sun,  8 Nov 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KU8+Oqyd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A93D1F0089F;
	Sun,  8 Nov 2026 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794124792;
	bh=kiWdoUL35CtK4AqpYlqytBUDE4prNrZdQBOX59MoB6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KU8+OqydZHEZXN/+TG8ILc1PNHKh2vWp7gMa7DE6Q1h5MszIKjTR44HBtcSD5xWF/
	 WGQb+vaULnSmHrV7CaaS0xw6Nilxb+LcvNGqrhOHwHA+IswpAaaw6H6kB8MMVmbWy7
	 NjMeqTI4nx5hl8DgP9Qx0ADl3keAj1QN1d5bvyBWM3SHxXHZOFl4jS3/8ercXnnvSl
	 MDE9gs4B9BxhVotzyHHLes3aMGjmRmUgKp4Ouw7tqvNbFALy3tRwoDuy40+ZASca7l
	 AkGfBToogtiaGAraKSFxdcjDeUqWp6G8ZgXqb2ExtwXvbyx0b/t1xz0RNR2/hRqhQk
	 KYmjUyxXj5cSg==
Date: Sun, 8 Nov 2026 09:59:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: restore KFENCE pages through DMW on resume
Message-ID: <avAr894n6lNGD9C8@kernel.org>
References: <20261031-fixes-loongarch-v1-1-e0e33e3c008e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031-fixes-loongarch-v1-1-e0e33e3c008e@kernel.org>

Gentle ping :)

On Sat, Oct 31, 2026 at 03:21:46PM +0200, Mike Rapoport (Microsoft) wrote:
> With KFENCE enabled, resume from hibernation triggers KFENCE reports while
> swsusp_asm_resume() copies the image pages, for example:
> 
>   BUG: KFENCE: use-after-free write in swsusp_asm_resume+0x20/0x94
> 
>   Use-after-free write at 0x00000000a57ee925 (in kfence-#254):
>    swsusp_asm_resume+0x20/0x94
>    hibernation_restore+0x128/0x1a0
>    load_image_and_restore+0x6c/0xc8
>    software_resume+0x240/0x260
>    do_one_initcall+0x68/0x200
>    kernel_init_freeable+0x26c/0x304
>    kernel_init+0x20/0x134
>    ret_from_kernel_thread+0x24/0x1d0
>    ret_from_kernel_thread_asm+0xc/0x98
> 
> During resume from hibernation, the image pages that occupy physical pages
> used by the restore kernel are first loaded into free pages and then, as
> the very last step, swsusp_asm_resume() copies them to their final location
> pointed to by pbe->orig_address, which the hibernation core sets to
> page_address() of the page in the restore kernel.
> 
> The early KFENCE pool is allocated from memblock and normally occupies the
> same physical pages in the restore kernel and in the image kernel, so these
> pages are usually copied by swsusp_asm_resume().
> 
> The KFENCE pool is remapped into the KFENCE area above vm_map_base and
> set_page_address() adjusts page->virtual so that page_address() returns
> the page-table mapped alias rather than the DMW address of the pool pages.
> 
> Hence, pbe->orig_address of KFENCE pages points to that alias and
> swsusp_asm_resume() writes them through the page tables. But:
> 
> * the copy loop overwrites the kernel page tables, so a TLB refill for the
>   KFENCE alias may use a partially restored page table
> * the KFENCE pool pages that are protected in the restore kernel fault in
>   the middle of the copy
> 
> Convert pbe->orig_address to DMW addresses before starting the copy.
> 
> Fixes: 0ca84aeaee15 ("LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> Reproduced with hibernation in QEMU, the KFENCE reports are gone with
> this patch.
> ---
>  arch/loongarch/power/hibernate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
> index 817270410ef98..ff571ab4e8df9 100644
> --- a/arch/loongarch/power/hibernate.c
> +++ b/arch/loongarch/power/hibernate.c
> @@ -59,6 +59,18 @@ extern int swsusp_asm_resume(void);
>  
>  int swsusp_arch_resume(void)
>  {
> +	struct pbe *pbe;
> +
> +	/*
> +	 * page_address() of KFENCE pages is mapped by page tables that are
> +	 * overwritten during restore and may be protected by KFENCE, copy
> +	 * through DMW instead.
> +	 */
> +	if (IS_ENABLED(CONFIG_KFENCE)) {
> +		for (pbe = restore_pblist; pbe; pbe = pbe->next)
> +			pbe->orig_address = __va(virt_to_phys(pbe->orig_address));
> +	}
> +
>  	/* Avoid TLB mismatch during and after kernel resume */
>  	local_flush_tlb_all();
>  	return swsusp_asm_resume();
> 
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261027-fixes-loongarch-fd3755f33919
> 
> --
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
