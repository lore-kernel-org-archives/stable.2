Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677924;
	b=fOx6afgkrNsvG2tsnv5T72xZQc3teUrfuM12Wn3OZeK/Fvys+gYiIvh+7SP38F9iZpgE
	 D+je3rQ8yOiSUsb7vTXJahpPUdMf49V231zR6O9YAJcQu/cs5Re3rKXNAGdR0kt9R3LHm
	 VT+WK4IaPLIsCHp+xdZ5oqfc8xxT7o27Kg2JiSGnyvdP7mNHwxQarERRbZCQOsKV2CSFs
	 O+VORWa0Vs+GafKDdvaXq4pUBi1T26RNGA81otcclCpVyZ32jgTD5gi5fdy5XnMfYQBrC
	 ykVMbHALa/lAaZE9eSomfQVhi7ioWz+vzqQGeg0hJ0J3QBPM1roPPrHAPzJLRRYOrRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677924;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=N3QVgukA5qJJPhjxPDWIGy+6WZwkUo9uICIUUy2pb5A=;
	b=WmJeEsra7rgpjMAjs2Lail1NVVWBYCNHBtQxlnwsgSIJjtPbSQcJGaVHp2OoAGXlj4Vi
	 n1GhnkwJhwXl3Z7/U01vAXG6wALZf8z8EtFYqRdeHFAqJ24i7s/CTEwO/mxXQ701K+qQZ
	 4t4FDJDM0J8GDZZGr/FD+s7sSXorK2du+eT7cbX3LHbeIuwNuPaf1akDJGDgwQcTwlO/o
	 L/YVhz4WRYc5f+kZmuVA9ejs4msrj9RtAbpVg8AYrdIPREHjEL+nlBxDGESc7HOIinkEl
	 EpBFdlJphdy35FviPOM0ur+wGNMnlhlwh3ZgMO6V4OkUOkwlGnANdwpDqff0iY3rugQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="bV/nqyeX";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF97606A31E;
	Thu, 26 Nov 2026 07:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF97606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bV/nqyeX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20406339;
	Wed, 25 Nov 2026 23:25:19 -0800 (PST)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277EA3FA7A;
	Wed, 25 Nov 2026 23:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795677922; bh=W8p9IFPoop55wdnARjeEf3Xh8Vk1OfULBvf4VJtucz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bV/nqyeXXxc44EKXd7FYgJAAx/VLSTXikazIrO+oFBmosOUrdsSad1saMJJ2P4k7s
	 JGIMTopBlXZvbvTd3Q0JC+vM4m86TVz72p40U0e4LjGpRx3UxLidvnS3TH+FFNLA3q
	 7UfZ6pgrOGQPCRmlk7W7FyrySvr+CldXOwZvT/Iw=
Date: Thu, 26 Nov 2026 07:25:05 +0000
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Aashish Sharma <aashish@aashishsharma.net>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ricardo Koller <ricarkol@google.com>, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Do not free split_page_cache in
 kvm_arch_flush_shadow_all()
Message-ID: <b3qbghvxkqs5ntr6cptcbih2cocvnqyu5lousloeazdun4625s@thr2qxpszw2u>
References: <20261124224959.685002-1-aashish@aashishsharma.net>
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
In-Reply-To: <20261124224959.685002-1-aashish@aashishsharma.net>

On Tue, Nov 24, 2026 at 02:49:59PM -0800, Aashish Sharma wrote:
> kvm_arch_flush_shadow_all() is called from the MMU notifier ->release()
> callback, which can run concurrently from __mmu_notifier_release() and
> mmu_notifier_unregister(), as well as concurrently with VM ioctls
> accessing split_page_cache under kvm->slots_lock. Calling

I don't think VM ioctls can race against ->release(). VM ioctls keeps
current->mm and KVM fd alive, so ->release() cannot be called.

However ->release() can be called in parallel if the last mm and KVM fd
reference gets dropped at the same time so there is still a race.

> kvm_uninit_stage2_mmu() there invokes kvm_mmu_free_memory_cache()
> without locking, which is not thread-safe and can double-free
> split_page_cache.
> 
> Call kvm_free_stage2_pgd(&kvm->arch.mmu) directly instead.
> kvm_arch_destroy_vm() already calls kvm_uninit_stage2_mmu() once after
> mmu_notifier_unregister() completes and all VM references are gone
> (see commit a3ca3bfd01b7 ("KVM: arm64: Destroy stage-2 page-table in
> kvm_arch_destroy_vm()")).
> 
> Fixes: e7bf7a490c68 ("KVM: arm64: Split huge pages when dirty logging is enabled")
> Cc: <stable@vger.kernel.org> # 6.6.x: a3ca3bfd01b7: KVM: arm64: Destroy stage-2 page-table in kvm_arch_destroy_vm()
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: Aashish Sharma <aashish@aashishsharma.net>

Can we just remove kvm_uninit_stage2_mmu()?
That's one less function to keep in mind.
(skip split_page_cache freeing in kvm_arch_init_vm because no one can
use it yet, and keep kvm_free_stage2_pgd() in kvm_arch_destroy_vm()
because of a3ca3bfd01b7)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 21cd872ea394..6f04f21497d8 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -303,7 +303,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	return 0;
 
 err_uninit_mmu:
-	kvm_uninit_stage2_mmu(kvm);
+	kvm_free_stage2_pgd(&kvm->arch.mmu);
 	kvm_destroy_nested(kvm);
 err_free_cpumask:
 	free_cpumask_var(kvm->arch.supported_cpus);
@@ -354,7 +354,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (is_protected_kvm_enabled())
 		pkvm_destroy_hyp_vm(kvm);
 
-	kvm_uninit_stage2_mmu(kvm);
+	kvm_free_stage2_pgd(&kvm->arch.mmu);
+	kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
 	kvm_destroy_mpidr_data(kvm);
 
 	kfree(kvm->arch.sysreg_masks);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a0d4981ebb99..f3bfff15f193 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1117,12 +1117,6 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
 	return err;
 }
 
-void kvm_uninit_stage2_mmu(struct kvm *kvm)
-{
-	kvm_free_stage2_pgd(&kvm->arch.mmu);
-	kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
-}
-
 static void stage2_unmap_memslot(struct kvm *kvm,
 				 struct kvm_memory_slot *memslot)
 {
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 78d5b18dbd2d..9b455533e128 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1480,7 +1480,7 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 		if (!WARN_ON(atomic_read(&mmu->refcnt)))
 			kvm_free_stage2_pgd(mmu);
 	}
-	kvm_uninit_stage2_mmu(kvm);
+	kvm_free_stage2_pgd(&kvm->arch.mmu);
 }
 
 /*

Thanks,
Wei-Lin Chang

> ---
>  arch/arm64/kvm/nested.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 4d83281a7a28..2440ad9fed87 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1472,7 +1472,7 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
>  		if (!WARN_ON(atomic_read(&mmu->refcnt)))
>  			kvm_free_stage2_pgd(mmu);
>  	}
> -	kvm_uninit_stage2_mmu(kvm);
> +	kvm_free_stage2_pgd(&kvm->arch.mmu);
>  }
>  
>  /*
> 
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
> -- 
> 2.56.1.831.g720f3f5937-goog
> 
