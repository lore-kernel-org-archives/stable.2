Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794572206;
	b=bKIzqNxU+gdM2r/lgvot1RLifUhjUXmPOzsoDMdlD3ClBcSawq0KmhmkEEZRLQREkwLI
	 ucSVGb/9VJTrI11ifgbWnRiYDAvyb58ENNmTnucOCTXjcpFyAAYWSAlm/CTSunBLmM5hq
	 SPDMCMjSUOg/3NFN7HBGv2kmk/52NDEwQR/sEP263gKXP1e4w8Npu3OTRgZQNOabpRG/N
	 eRCcCo+rKtBVqeqtyvc9GyEK8hpuPp5e5xk8QnQQTRplqMWwJUEpNNob9FPaKxXluuHyj
	 /r46EywfWb/pQTI6CGZZzJbzQW+f3kBrRAdV5L5j4CPlsYvV3S8CQxWJiB2Aj/jkNIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
	b=VWGfB6eePYwQqzhtDIwQ1rdRu9ZUIPINWgWoFtOjsJH+lq/8BehpVPxDMkqVwRqIgAM9
	 hvXnH/7fg5iW2uaXfcj4HE7P2Pm+OqaRYKKy+alSd45bG2Jgy/qvLtIKu1hclkCuda4JY
	 ashbRFwe5aIKlhgAJKQt2XPXBoV6oahSsFtsnQ/ErNfaJ1I1KTAZkX/5TZC7BfkrUzSyr
	 A2lwWMy/74u4O2gMH/oRlLsyjrwVyyrviLz23Z0V3T4YUATMN26FaYTtaA1QxaxPj/s8l
	 452a3pxRyrXSb/GZspA4iPZs/kYc1Qz5vwKMA6iARM6hDav5Op+TFBapcOO3zCFFEUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="e/Zx56Yb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F834606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F834606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=e/Zx56Yb
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b571979178so1870815a12.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794572205; cv=none;
        d=google.com; s=arc-20260327;
        b=gH1UiWcB5lXgNOq4hE+C1zQcyOFy4HYqbF1OSRjD/RqcLayUWvZYsmZkGnTqk2Pima
         s5WOxy9NWgRMAE+1CKra8Pi6E++y4/NydxR2L2hdlBG8tJM/gzgdreuwLN58jDBthF1V
         F0DuAjZRLh8P5jfpxdqgWW7vMkPCD91YJydBtZUH5tP0gFYet22ajcLHNkju8p8ZWD/5
         ozc2LH/JR0o+DBJRlfWFZqUJgbhaggjXb7sUIptdnVcJpYbhTf6Mt6Qh6LVY2dSVOI+Y
         1u/bUAFfrzCWGjbu4nalgyXE7AMnqItVpRtaIS/TCFFDfitMRPUKN7jScNZ97otLL7jg
         xAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
        fh=Ui44Rc4Xu+nOuYilKprXVNEwK7Rzreb9eGvdFzi9G38=;
        b=roiEBlqa34FqC49OeOueNkd1P1GrMN4GHJMtQHEdDrG8ICLQDtcAQwVxMWuZuIuX6W
         40BzNtis3eExVfPhCVYKVUKfs8DrGcm5a5LMt+SiMLm+8ULvUY1o5K4vSikuxVEE+oAI
         yv+zigs+cJrxYFspSRloLtqz1CGLI9QDLRoWtw1Fi+w+djDTJ+R4wN9+QqCFNWmL6SCc
         3wfMuS8RpGSG1008mR+ZS4CeH1QB2I7zM4gDObUUphN/PAO++hkEbI7Cqzm9I49mcEmy
         thbcOYOsuK2+CCCblFmQdV0f2uOzwPa0tc7vwBccyxogR47+a5ufKxpl1NIXJXk8LfJf
         GpWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794572205; x=1795177005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
        b=e/Zx56YbBCjgsMtG5kmlIHcHvE1J6P4joVmzF9dfp0gpew/WcvK+LQo86o3z5cIQyI
         yK/1GAJiVW9CEyH9ubTAy6Wzcuk5LfuDIOU4HSPzBZO5VsDaBgG2mvNLrS2jZjQJafOb
         5uoSaa7DjtWrkm4WowzVwxq7KrrQiGO5+QN2QGNBX+f9fsL/G6ONSjLQou0mIqQ6dBZe
         nNvWPGqi8QX9PFdJFbuKvu5RxG62KdLZmrUdVIhSKPNC/tw+lME1WznJ1/o993s+XHQ2
         37yB4jGRiscVgqNWd5/ZqJaK6+rBt172tp8VegOdRm6TG5pTfXaby5H26I5BjOqDhAui
         MNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572205; x=1795177005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
        b=PhFbWcc7Ap9WAbPP6AzBduZDnppCHFiMI3i4nh7/qYpN4lf56BBVBu2gqt/jJqgdHp
         hUW62QNp3Dh/2EGM8vlk5K1Lwa0QLciwbB7w3iDw08IQXSCW9XNk22SXB70nw0MfhkYI
         k6trAQcoJ+3ZZnb37F2TMOOcl1bHz0hItIrBI1MHc9X5tj11qriLSKy4Qhy/aKK3WCP+
         zujU51Xiw9+iXNOnjytzOr1Juhl4iL+BMHS15h37M0Z+nIHNwCmGRLc3VZ2M7h5IlTpV
         8a64M2IY47JFVLSLd1lUhqOfN7Cbe82XqxBVOE3gcYrZ4Tj0Rjbl5NUiZy7XlI0NoHwb
         E+Og==
X-Forwarded-Encrypted: i=1; AL+hErEHie6n3l/yTx6rohv3CBmlqJIY0WES/TljWDQXinN2FdH+BmzXb0aYEjwAUOYdSVQFqDFT5yk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hTNw5a94cjuT+HHjEmCqfn9+kBgGlD/3bZlKp2gjb8MluTOgU
	aP+SX6U3hSzrP4a8JjbO+wyBzygvJzzIHd5k+VQh6ptdAggNy7RLVFKtparXlNCMIhClI98Sqi4
	B9f0L9WI0Lw59XuHeyQm07nncCjX0a8sQ07r47Dlcpw==
X-Gm-Gg: AYBFou3/A6GnH7khhv01ASYTojD13EyOjNdVni4rpK3VJ7JZm7IhRGEnN8Xg+EUFpZe
	Q6ra7J03ks9anIzqcyhTNfJTxXuUY9Ay3cFv8CdXlQXmP6O+kHk5MjqXAWzUm6gRSXy8sBbF3qY
	kpG8ZDkcy9+AcP6o4YjVvaCTpdB9CAeGnfkrM4tXbBTiArMigybDTHvjrBlVWREqMSu7ZpjLiia
	AIfIWAgizdZqitrSoEQw3Y5SZnOy0MpolsgyCdItOcMqkALGKaTFWsVcq39ThW7RTs1bDd+mwG7
	243BqqPTFQ6yNAB/6a/WrvgMNc5PiUfYRRgsq5oaiVqqoRM9TQ++OxoNBnK8t28ejJhKUfCNBD5
	JzajFEzsBPLhF4j/o2OMI6aIXf7TYGUpM7LEjWQqZ2o73JlJlfAQEXOZNkk1GbVx8D5LMLlboZk
	dSUjcgNSlZ3waiCPKFZbSXWvLhEOTL07k4Nw4Yi9O8KIlDnKYxCFMcPxtrTOAa3ckwZ7pwcfDB1
	/E3
X-Received: by 2002:a05:6402:5177:b0:6b6:fddc:dbc1 with SMTP id
 4fb4d7f45d1cf-6b7c08b08admr1438436a12.6.1794572204712; Fri, 13 Nov 2026
 04:16:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
In-Reply-To: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 17:46:32 +0530
X-Gm-Features: AclHuK-Kyzf_3Aa78LNIir_Q7TGPINiFuQF__Q3gkCjYhZcKlm3MtE70aN1T8Lg
Message-ID: <CAAhSdy3K1AFB-DWKznNru+x2hNiP5_M+uTZEZBHWwdvLfJrNQA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix G-stage page table memory leak on VM destroy
To: Yangyu Chen <cyy@cyyself.name>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 12:28=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wro=
te:
>
> kvm_riscv_mmu_free_pgd() tears down the G-stage with
> kvm_riscv_gstage_unmap_range() over the whole guest physical address
> space. That function looks up each address with
> kvm_riscv_gstage_get_leaf(), which walks down to the leaf PTE, and then
> clears only that leaf. kvm_riscv_gstage_op_pte() frees a page table only
> when it is called on a non-leaf PTE, which never happens here, so every
> page table below the PGD is leaked when a VM is destroyed. With 4 KiB
> mappings this is one page per 2 MiB of guest memory that was ever
> mapped, plus the upper-level tables.
>
> The leaked pages are not slab, vmalloc or page cache, so they show up
> only as unaccounted used memory. On a SpacemiT K3 host, a workload that
> creates and destroys tens of thousands of small VMs leaked 0.5-1 MiB per
> VM and ran the host out of memory after about 20,000 VMs.
>
> Add kvm_riscv_gstage_unmap_all(), which calls kvm_riscv_gstage_op_pte()
> with GSTAGE_OP_CLEAR on every PGD entry. That recursively clears all
> leaf PTEs and frees each page table below the PGD. Use it in
> kvm_riscv_mmu_free_pgd().
>
> Tested with a reproducer script that builds a minimal KVM host kernel
> from a source tree and boots it under QEMU 11.0.2 (TCG, rv64 with H,
> Sv57x4 G-stage). Its init creates 10 VMs one after another. Each guest
> writes one word in every 2 MiB of an 8 GiB RAM region (anonymous memory
> with MADV_NOHUGEPAGE, so 4 KiB G-stage mappings) and then shuts down,
> so each VM needs 4096 last-level page tables (16 MiB). MemFree lost per
> VM, after one warm-up VM:
>
>   before:  16415 kB  (RESULT: LEAK)
>   after:    1636 kB  (RESULT: OK, noise)
>
> The bug was found while investigating the host OOM, and the fix and
> reproducer were written with the help of an AI coding assistant
> (Claude). The analysis, fix and test results above were reviewed by
> the submitter.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Good catch. Thanks for the fix.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.4-rcX

Thanks,
Anup

> ---
> How to reproduce:
>
> The reproducer script is at
> https://gist.github.com/cyyself/23abb87a8ad9ee8c64ce03cca78669fc
> and needs riscv64-linux-gnu-gcc, qemu-system-riscv64 and cpio. Run it
> from the top of a kernel source tree:
>
>         $ cd linux
>         $ /path/to/kvm-riscv-gstage-leak.sh
>
> It builds a minimal riscv64 KVM host kernel (allnoconfig + KVM) into
> .kvm-leak-build/ and boots it under QEMU (TCG, -cpu rv64,h=3Dtrue) with a
> static test program as /init. The test creates 10 VMs one after another.
> Each guest touches one page in every 2 MiB of 8 GiB of guest RAM, so it
> needs 16 MiB of last-level G-stage page tables. The test then prints how
> much MemFree each VM leaves behind. The first run takes about 1.5
> minutes, mostly kernel build; reruns take about 10 seconds.
>
> Without this patch:
>
>         10 VMs, each touching one 4 KiB page per 2 MiB of 8 GiB guest RAM
>         MemFree 2037664 -> 1873512 kB: 16415 kB lost per VM (a leaking ke=
rnel loses ~16384 kB)
>         RESULT: LEAK
>
> With this patch:
>
>         MemFree 2054080 -> 2037716 kB: 1636 kB lost per VM (a leaking ker=
nel loses ~16384 kB)
>         RESULT: OK
>
> The exit status is 0 for OK, 1 for LEAK and 2 if the test could not
> run. IMAGE=3D<path/to/Image> boots an existing kernel instead of building
> one. That kernel needs CONFIG_KVM=3Dy, CONFIG_BLK_DEV_INITRD=3Dy and
> CONFIG_DEVTMPFS=3Dy.
>
> I also tested VMs that select Sv39x4, Sv48x4 and Sv57x4 through
> KVM_CAP_VM_GPA_BITS, and four VMs with mixed modes alive at the same
> time, destroyed one by one while the remaining VMs kept running and
> were checked for correct guest memory contents. With this patch, no
> memory was lost in any mode and no guest data was corrupted. Without
> it, every mode leaked about 16 MiB per VM.
> ---
>  arch/riscv/include/asm/kvm_gstage.h |  2 ++
>  arch/riscv/kvm/gstage.c             | 22 ++++++++++++++++++++++
>  arch/riscv/kvm/mmu.c                |  3 +--
>  3 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index aaf080ba1b77..90ec9e0b34b1 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -80,6 +80,8 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage,=
 gpa_t addr,
>  bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>                                   gpa_t start, gpa_t size, bool may_block=
);
>
> +bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage);
> +
>  bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end);
>
>  bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base=
_gfn,
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index e5002cb9cbef..c912cdc2021f 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -456,6 +456,28 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>         return flush;
>  }
>
> +/*
> + * Clear every G-stage mapping and free all page tables below the PGD.
> + * kvm_riscv_gstage_unmap_range() only clears leaf PTEs and leaves the
> + * page tables in place, so it cannot be used to tear down a G-stage.
> + */
> +bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage)
> +{
> +       u32 level =3D gstage->pgd_levels - 1;
> +       pte_t *pgd =3D (pte_t *)gstage->pgd;
> +       unsigned long i, page_size;
> +       bool flush =3D false;
> +
> +       if (gstage_level_to_page_size(gstage, level, &page_size))
> +               return false;
> +
> +       for (i =3D 0; i < kvm_riscv_gstage_pgd_size / sizeof(pte_t); i++)
> +               flush |=3D kvm_riscv_gstage_op_pte(gstage, i * page_size,=
 &pgd[i],
> +                                                level, GSTAGE_OP_CLEAR);
> +
> +       return flush;
> +}
> +
>  bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end)
>  {
>         int ret;
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 371fccaf9df0..87838a0f6bb9 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -784,8 +784,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>         write_lock(&kvm->mmu_lock);
>         if (kvm->arch.pgd) {
>                 kvm_riscv_gstage_init(&gstage, kvm);
> -               flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> -                       kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), =
false);
> +               flush =3D kvm_riscv_gstage_unmap_all(&gstage);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
>                 kvm->arch.pgd =3D NULL;
>                 kvm->arch.pgd_phys =3D 0;
> --
> 2.53.0
>
