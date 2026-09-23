Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9156C653
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192406; cv=none; b=pLi3n+3WpCsFv7+HZ6FuMNzEAXlfkiNV1cIpMDeNEXLM+mWF75yW+Wj9DnSPSs6kdAlMydpdaxcdAKHbzcGTntCDXfg1hL6CiWvNeIYm8l+0ZjrBRmqULRvmQRD6Z4Xx2/XwniPSbyBS2IvXLcDaYa/2wN81pJE9sV4CZi7FHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192406; c=relaxed/simple;
	bh=8q5LOhzHXz3Yz0fy85hHf0cIzNFEPBBRVDjkf2/J8z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmP5ebHSbdsGbgpj86ox6KnyPBrOoy87lB+dVQGZKJQ6Fp9MVMNjJpjAx9I4cjbJE1eMBH2ujQ5LIlJ8onoIjRyjiCZqM7lNF9BfDBSkZn9KAm68E8IZ/u9QfHioSr1r4GTiDLJ+8nKA9Cn247ioLNOU1iF4wCVmSwLi/lyW/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AS8GvWbq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AS8GvWbq"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8q5LOhzHXz3Yz0fy85hHf0cIzNFEPBBRVDjkf2/J8z0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790192400; v=1; x=1790797200;
 b=AS8GvWbqdFnt4U0XkQOCwhYVwcHWIuPjjH5XgBQiFFaz/IrSy7Ic9+RaKnT7VLQ5rW9YzdHv
 O3Q32YxyYOU4yOhmzdFFG/BR+y0Bp/iUsAoZG67ee97vToXiGK8Vk99dy9X1YzQ/pz62o1vxkPD
 KvimbyqmG1lVM3DWgLHHtX70=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3b748deefaaee9b6;
	Wed, 23 Sep 2026 19:40:00 +0000
X-Mizu-Trace-ID: 3b748deefaaee9b6
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso2158e87.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:39:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDMjUWhFqwQ9oRuWdLdxFwJYnIvazFTtU0Qy7I4aGKv35/7xEx7Ou5MpBszY/jSoLufPe9Qbg=@vger.kernel.org
X-Gm-Message-State: AFuF++mZs/tvJRYnCgFyDP3Z9cep4RtJpDEXZrLmlAojQNvAGCitvSa/
	S5C1kGJxsRj4m9/NSc1BH4lQNbpwQyTuOVQTY9qBv1aGl9eBjx/4rQewNfrfig04DJaAY2+Ivh4
	Wu7oDrMNhNqXh5XG9gqYk9cYkU8NOnWWM+9xZY2KP
X-Received: by 2002:a05:6512:a8c:b0:5b8:d049:c45f with SMTP id
 2adb3069b0e04-5b8dda20690mr52878e87.14.1790192395743; Wed, 23 Sep 2026
 12:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922130821.1666713-1-vdonnefort@google.com> <20260922130821.1666713-7-vdonnefort@google.com>
In-Reply-To: <20260922130821.1666713-7-vdonnefort@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 20:39:19 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzcpo+LB4WMa+wqVQv3L6KUcYsg-XJmr2y7G32O_uqJpw@mail.gmail.com>
X-Gm-Features: AclHuK8Z6SY4cBU4eJy41QhCQFrZb6shCMogQ4bHwKy9JKLhaeBBpmmDsIysMxw
Message-ID: <CA+EHjTzcpo+LB4WMa+wqVQv3L6KUcYsg-XJmr2y7G32O_uqJpw@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] KVM: arm64: Use kvm_s2_fault_vma_info in pkvm_mem_abort()
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, kernel-team@android.com, 
	qperret@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 14:08, 'Vincent Donnefort' via kernel-team
<kernel-team@android.com> wrote:
>
> To paraphrase Marc in commit 08f97454b7fa ("KVM: arm64: Fix protected
> mode handling of pages larger than 4kB"), pkvm_pgtable_stage2_map()
> assumes the address passed as a parameter is aligned to the size of the
> intended mapping, while HPFAR_EL2 gives the IPA minus the bottom 12
> bits, regardless of the system page size configuration.
>
> To fix this alignment, bring support for kvm_s2_fault_vma_info in
> pkvm_mem_abort() and use its members where possible. They do contain the
> page-alignment we need to fix the fault on system with pages larger than
> 4K.
>
> Also, add a check at the start of pkvm_pgtable_stage2_map(), it does not
> support !PAGE_ALIGNED arguments.
>
> Fixes: ea03466e806f ("KVM: arm64: Handle aborts from protected VMs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba < fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  arch/arm64/kvm/mmu.c  | 24 +++++++++++++++---------
>  arch/arm64/kvm/pkvm.c |  3 +++
>  2 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index ee0fcca838c1..167b769107ee 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1374,9 +1374,11 @@ static bool fault_supports_stage2_huge_mapping(const struct kvm_s2_fault_desc *s
>         if (map_size == PAGE_SIZE)
>                 return true;
>
> -       /* pKVM only supports PMD_SIZE huge-mappings */
> -       if (is_protected_kvm_enabled() && map_size != PMD_SIZE)
> -               return false;
> +       /* pKVM only supports PMD_SIZE huge-mappings for non-protected VMs */
> +       if (is_protected_kvm_enabled()) {
> +               if (vcpu_is_protected(s2fd->vcpu) || map_size != PMD_SIZE)
> +                       return false;
> +       }
>
>         size = memslot->npages * PAGE_SIZE;
>
> @@ -2167,12 +2169,12 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>  static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>  {
>         unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
> +       struct kvm_s2_fault_vma_info s2vi = {};
>         struct kvm_vcpu *vcpu = s2fd->vcpu;
>         struct kvm_pgtable *pgt = vcpu->arch.hw_mmu->pgt;
>         struct mm_struct *mm = current->mm;
>         struct kvm *kvm = vcpu->kvm;
>         void *hyp_memcache;
> -       struct page *page;
>         int ret;
>
>         hyp_memcache = get_mmu_memcache(vcpu);
> @@ -2180,12 +2182,16 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>         if (ret)
>                 return -ENOMEM;
>
> +       ret = kvm_s2_fault_get_vma_info(s2fd, &s2vi);
> +       if (ret)
> +               return ret;
> +
>         ret = account_locked_vm(mm, 1, true);
>         if (ret)
>                 return ret;
>
>         mmap_read_lock(mm);
> -       ret = pin_user_pages(s2fd->hva, 1, flags, &page);
> +       ret = pin_user_pages(s2fd->hva, 1, flags, &s2vi.page);
>         mmap_read_unlock(mm);
>
>         if (ret == -EHWPOISON) {
> @@ -2195,7 +2201,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>         } else if (ret != 1) {
>                 ret = -EFAULT;
>                 goto dec_account;
> -       } else if (!folio_test_swapbacked(page_folio(page))) {
> +       } else if (!folio_test_swapbacked(page_folio(s2vi.page))) {
>                 /*
>                  * We really can't deal with page-cache pages returned by GUP
>                  * because (a) we may trigger writeback of a page for which we
> @@ -2215,8 +2221,8 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>         }
>
>         write_lock(&kvm->mmu_lock);
> -       ret = pkvm_pgtable_stage2_map(pgt, s2fd->fault_ipa, PAGE_SIZE,
> -                                     page_to_phys(page), KVM_PGTABLE_PROT_RWX,
> +       ret = pkvm_pgtable_stage2_map(pgt, gfn_to_gpa(s2vi.gfn), PAGE_SIZE,
> +                                     page_to_phys(s2vi.page), KVM_PGTABLE_PROT_RWX,
>                                       hyp_memcache, 0);
>         write_unlock(&kvm->mmu_lock);
>         if (ret) {
> @@ -2227,7 +2233,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>
>         return 0;
>  unpin:
> -       unpin_user_pages(&page, 1);
> +       unpin_user_page(s2vi.page);
>  dec_account:
>         account_locked_vm(mm, 1, false);
>         return ret;
> diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
> index 8e4c6e4bec12..c298a5b9b12a 100644
> --- a/arch/arm64/kvm/pkvm.c
> +++ b/arch/arm64/kvm/pkvm.c
> @@ -414,6 +414,9 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>         u64 end = addr + size;
>         int ret;
>
> +       if (WARN_ON_ONCE(!PAGE_ALIGNED(addr | size)))
> +               return -EINVAL;
> +
>         lockdep_assert_held_write(&kvm->mmu_lock);
>         mapping = pkvm_mapping_iter_first(&pgt->pkvm_mappings, addr, end - 1);
>
> --
> 2.55.0.1082.g2b9226bbc0-goog
>
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
