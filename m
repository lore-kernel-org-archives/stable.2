Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794551414;
	b=vZjpGYwiBPWQt9U8O4mD0xV6atBgEzW9VgZCjMWvA3H0UXJfx+IM31OIZF1oCav2mip4
	 7vxlAm1Kv2y3kEg5vh/tsefJMSOHxDXTvvWKPB+8lkAkxm1XKmOL/lLJEA+SOiIf/Ksr5
	 a1UzJ9Oferq4ZKcAFjWy5aj+XX0nEp/f4eXuDtuuaD9IuvrZCaoHptMmFtMlcLwr8PDzR
	 OkDqtNcrAdY7pGV04y+IOd5CIdbp2zCUEHbMFYy+mcWR6L33+dKCxEhILm9gmzLVjyoph
	 2hg7/H16YD0GE9NdpyOxlE/P9JkyZS9zUpm8bwON+3tZeJPQL2aXxhAcDgyBx0EP1PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
	b=K8a+0/jtjfLGNggoPj4rgeDKb5Sc8TdyTlgFDjIFolk3kFAh44LwgoA8b1QjSI0lQ+3e
	 l1FuQ6v3n6xH0SzmoGeAcgjtlGiAWPOScVVRjonbUltaZYOVv9cao6Ur+wgs25fanVRg+
	 FqUAphHk3SyzBGCxqA/WKP8Q+/V2P1LVlXNPfvD8rZ05/DcoCoIuJIzQrONnV3ywIVDiq
	 xwGIiW4Ny778/WdzkGoXqpw6iB9aIGOCmUCx+SDdiGylNrIpTSVntsPdCCvw6DHcpu1Cz
	 N9dheeJbiqFgf4WvTKOZ+sdMbppnA42DmKOtz64LNjTW+cOvSI8vuErwmzJHCwehpWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=CISkgUyd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7F606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=CISkgUyd
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3acd239776cso8214581fa.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:30:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794551412; cv=none;
        d=google.com; s=arc-20260327;
        b=A5c++g+MhvmDqeQJpRwsxk6ClMnTi+11686INiO/EkpAh+KHaSzP0EEwrEIqd4gqlx
         ohdE6ORvHgDE3IzkK+VdbqIJBdA0x48kGGfiW+hL/LNqfJyV69rSwsNspQt7hmqPhQoh
         vCgsJM8hgvzmMUaah/q8Zhgn2sdOsxEY7LRCwA/XpdDWjp11Pco6og6LLqxNretlqIYj
         ZKWa1gV+wjYE0ZUhJPXJ1YPrrwCsGIxAkupx8U1O9NCfw5Y2uCBw0lx0VGspP1oPjgqN
         103gRb9HoWtryJL7IlI3gYg/SeT4I4bkTOwF2Us8SggF2JbIJSHB6QODT++Lr9uuAfxe
         HvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
        fh=YulxbTTzN/5OKFTMZEUOtFfu5ty2oPvQDB57Xnr/6LU=;
        b=f9ggRn8/DylZB+Uiu4+ZYv0/hQRzHxI8L5ITgQPR3Zp2xWQTCSly0wQj5cIVI5p1Fm
         BjgQ8IYxHNc4d2cFZWbzuft5AploI89RcxxkumWLpsbIHkLiyOmKjEEJq/ggcHK8dEea
         EDIf0fE3oMIU7YcqFQ2Aw8AAxVjZrsry2NaTT+TMJ22M9C5c0n4oqb57Wikt9ex1j9Bj
         pNF8ozZ36kMpav1CiOMvbqoPyt21UbgKB0VJ/NTX7w4rYx0SyVCzgCWOXvvE/kgQwps8
         +o62ECYNDxDiId/UghyEOVlOA28GY6Ff14fevwKW5+2EE5NeoCKOi6o4FJ0WIc8nRvBG
         GBFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794551412; x=1795156212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
        b=CISkgUydz5u2X77u78uCB1fRwoqbwfnH7RNmDCopYJjHDuyVTgOKMzYZCTkmUevY3g
         3K5gvlQXqrBOx+waPEU20+MtV3M9UX4Ii1fRaHcNSwqHFX/t58xEIIo43Q5/5oat3alL
         UFWy4s0BgaccGuhvrccPxulBiqx7gFYq9Yi+vvFNKVVZiNyeV/5V2Blol/QBCuMOJ6ir
         ZeLzky/15YFIooTxDnd5PsFWe7BzdueFp5Fpw8AldUWc4Zoj5yPa8n8UVjdDd7H4zd7j
         Z3qky2hKscrFwxxJYOYEm+t9zLlgaXK9fnKUk1rCo2A5XxFP0oHrA/TpJMTUZNjV3FSU
         vVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551412; x=1795156212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
        b=VHpURvAMBv2SNBrX44r9lfdceoCH23s0g39f0tf4vtuTYF8NsZTeIIQgUCEYUXlqD5
         HtpPpBvGZF2uBbL7S1YpouDpIW4FF43YRMsaV3KKgl7mZvI67A1rgQTy648BlhU077Kt
         CUliKCU1Kj/2KhBnCDjqT8PY33wg8XYgs6WlapYZxtt3nGweetOJtAiM3Y7YWbDPVYvn
         BEcJc1hYWqJ9N13t9C/Eb5WKZlxs+etIudGCqS3HO14WtriRfAkakmZwOqEunCm58G44
         Rth+TtlewYJ7jj7hOlMVY927JlaAT9AXl9THNvMPz7cGm+V6rh/GPNIctnMpjM8+B5Ek
         67rw==
X-Forwarded-Encrypted: i=1; AL+hErGJPYZHlUOqHyx0RHTuOFlIIX6EcPJqNMlf4AWBMccBbeGQ9tnjOIJY84ThHq+YFoQ9Qh6wPHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BdbATqH6cQd5/JwvHqOGq89CI6kRcIcSoRx1WFbbKJ62g/HAF
	QIc+silWHiDPYphdT7EJzpisS/VdKSZmleImGbNPQKwISDRTQX6p+Lztq4qmmzsdoMnJJyT17IQ
	9zFIkcgBoVf+9DylFiyfIzIx1KD4ar7OfFwzMHQ1LYA==
X-Gm-Gg: AYBFou0bcTqRWc7lodVlsgz7BM5526vI74X+IRrAvSKcMyy+fnj7uwBK0usDjAbYVgL
	bM21s+UvJaRsfWDq2VOxplskCFvd6GRkXKW0JYqid0VtzkehxhN8dGGA+FF/5BYmK70Q1p2M29P
	xoq5ICfGA94wK8bUM+hTxW1eX9KuFP069up0pWjaCrPKgwWko5nzZ8Qwj1MyQW552mL6ybeW6kN
	pSXQ7QQyyqkzdX2Gvih+jTDvdGjKPkEPEB4wE0+ekKzRFfjNgETOG1U7xFKrofHBsCxFf34tehI
	ycXHfTynapCL6OanqNDJqLhYekMHG4B92bJrD49q4DyFWBi5/zT6Q5jsVUR84RJe807mIpMQXfB
	I8Wras6tAhPG4/qFx9LZU5a4Tp/UNB989zcd2ngqv30VKjX6+wYn0oRu+Z3veXGSAarAjDabzUf
	jRV2B0rIQ2t0ZNcYVjOmEOTGACShUhQGS1W4k1ya1/2H++gK8OmOGa3rD4
X-Received: by 2002:a05:651c:a182:b0:3ad:f0bb:344c with SMTP id
 38308e7fff4ca-3ae2b4cd92dmr4405361fa.10.1794551411872; Thu, 12 Nov 2026
 22:30:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022025248.477832-1-jinyue.li@linux.alibaba.com>
In-Reply-To: <20261022025248.477832-1-jinyue.li@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 11:59:59 +0530
X-Gm-Features: AclHuK8NiJX_tgbZANqAwiOjegb650NzlAml5enSgYn0fBkXeJUfWcHpMs2vGKY
Message-ID: <CAAhSdy13okqRhJLCygqZajrwDTa64gJt=SnCcZPRQxRd5E=WKQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix double free of the split page cache
To: Li Jinyue <jinyue.li@linux.alibaba.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, wang.yechao255@zte.com.cn, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:22=E2=80=AFAM Li Jinyue <jinyue.li@linux.alibaba.=
com> wrote:
>
> kvm_riscv_mmu_free_pgd() frees pgd_split_page_cache after dropping
> mmu_lock. It is reached from kvm_arch_flush_shadow_all(), i.e. from the
> MMU notifier ->release() callback, which can run concurrently for the
> same VM from exit_mmap() and from mmu_notifier_unregister() in
> kvm_destroy_vm(). The stage-2 teardown is serialized by mmu_lock and the
> second caller finds kvm->arch.pgd already cleared, but both callers then
> go on to free the cache, and kvm_mmu_free_memory_cache() does not
> tolerate concurrent callers:
>
>   BUG: KASAN: double-free in kvfree+0x28/0x32
>   ...
>    kfree+0xc4/0x428
>    kvfree+0x28/0x32
>    kvm_mmu_free_memory_cache+0x178/0x246
>    kvm_riscv_mmu_free_pgd+0x20e/0x2b4
>    kvm_arch_flush_shadow_all+0x1a/0x24
>    kvm_mmu_notifier_release+0x36/0x7c
>    __mmu_notifier_release+0x182/0x66a
>    exit_mmap+0x7f8/0x8c4
>    mmput+0x7e/0x2fc
>    do_exit+0x57a/0x22b4
>   ...
>   Freed by task 15956 on cpu 3 at 8926.103524s:
>   ...
>    kvm_mmu_free_memory_cache+0x178/0x246
>    kvm_riscv_mmu_free_pgd+0x20e/0x2b4
>    kvm_arch_flush_shadow_all+0x1a/0x24
>    kvm_mmu_notifier_release+0x36/0x7c
>    mmu_notifier_unregister+0xf0/0x328
>    kvm_put_kvm+0x32a/0x7b8
>    kvm_vm_release+0x3a/0x50
>    __fput+0x330/0x974
>
> The cache only feeds huge page splitting from VM ioctls, so it does not
> need to be released together with the page table. Free it from
> kvm_arch_destroy_vm() instead, which runs once after the MMU notifier
> has been unregistered, as arm64 and x86 already do. The error path in
> kvm_arch_init_vm() is not affected because the cache cannot have been
> filled at that point.
>
> Found by syzkaller.
>
> Fixes: 6c7f75ef096a ("RISC-V: KVM: Add the split page cache for ioctl con=
text")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as fix for Linux-7.4-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 2 --
>  arch/riscv/kvm/vm.c  | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 3e955d808743..74dece22d172 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -798,8 +798,6 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>
>         if (pgd)
>                 free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage=
_pgd_size));
> -
> -       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }
>
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb76..a7e1b518257a 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -54,6 +54,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>         kvm_destroy_vcpus(kvm);
>
>         kvm_riscv_aia_destroy_vm(kvm);
> +
> +       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }
>
>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --
> 2.25.1
>
