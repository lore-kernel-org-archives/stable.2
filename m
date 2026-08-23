Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6B2F3632;
	Sun, 23 Aug 2026 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787463512; cv=none; b=UWguAOlECM2HHmrZIRtHisVi6NYLj9nxSF/gkUQdcGFeQssxD4qKsU/Pmq51FT8gnjTB/+ZrE+mr6ue/8wTubh9227OdPeAK5LLGsS5x7V12vhX/UgFKDHEDY7LdNkc8FP6kDi5tHF1gkmAbQEXsDjs5vjyb/s3hypgdmv1Z1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787463512; c=relaxed/simple;
	bh=8OuvN8KSQm8wUw/oMr6mFLhFJi1gNWi88uVLLsdVmmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFOoxcVOMyEs5De8XqTs+/vGU8xlmudXCRrK719XxbiT18lamUyZ7jr39P0iEraVJmInhv5yfPz4kLG0G6ZdMMW0pTlmR72o/uxWe9mUS0RvauI8MRFzgPAY63jWAruskglIfpuC0jLQppkptqnFJG1Wd7M5AfGwSDYe1qvnCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yx3fEGVH; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yx3fEGVH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787463499; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=bhied+RrHvfAlPalGsWSr2PGKdyWrajPn0cro9XXUAU=;
	b=Yx3fEGVHFk+BhjFgip0fPIPLHCg4MFmW84g7CGUO9FvJoNiSVHjtnSpweIze4aAsWRZesmmK7ut52fsutHqSx0xxFufJqpqfeuUKpLhkshiDlhvZzazwma2MujUfnPXkk63Nb+rI+xjvFpEwv3LufHWBrSR3bjJTBDDrLzed5u4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X9PtKmb_1787463498;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X9PtKmb_1787463498 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 23 Aug 2026 13:38:19 +0800
Date: Sun, 23 Aug 2026 13:38:18 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Christoffer Dall <christoffer.dall@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: Fix spurious warning for benign stage
 2 teardown race
Message-ID: <dycpfrkpphjy5xnb57t2zvdmlpkx76lbow7w23l3d2fwgbfjjj@lbk4uh7awc2p>
References: <20260822-kvm-arm-nested-virt-fix-v2-0-ac4059a0eaa6@kernel.org>
 <20260822-kvm-arm-nested-virt-fix-v2-1-ac4059a0eaa6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822-kvm-arm-nested-virt-fix-v2-1-ac4059a0eaa6@kernel.org>

On Sat, Aug 22, 2026 at 06:46:53PM +0800, Lorenzo Stoakes (ARM) wrote:
> A batch of kernel warnings were triggered in the L0 host kernel when using
> kvmtool to experiment with nested virtualisation.

...

> Fixes: ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page tables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/arm64/kvm/mmu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 74e7e7f7564c..31e049ded093 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -59,19 +59,25 @@ static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
>   * long will also starve other vCPUs. We have to also make sure that the page
>   * tables are not freed while we released the lock.
>   */
> -static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
> +static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
>  			      phys_addr_t end,
>  			      int (*fn)(struct kvm_pgtable *, u64, u64),
>  			      bool resched)
>  {
>  	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
> +	phys_addr_t addr = start;
>  	int ret;
>  	u64 next;
>
>  	do {
>  		struct kvm_pgtable *pgt = mmu->pgt;
> +		/*
> +		 * We may be raced on PGT teardown when we release the
> +		 * kvm->mmu_lock. That's fine as the PGT is legitimately no
> +		 * longer present.
> +		 */
>  		if (!pgt)
> -			return -EINVAL;
> +			return resched && addr > start ? 0 : -EINVAL;

Hi,

I can understand the addr checking makes sure only return 0
when the mmu_lock is dropped at least once and get pgt =
NULL, may a variable like drop_lock = true when
cond_resched_rwlock_write(&kvm->mmu_lock) happens can have
better readability, but depends on you and others' opinion.

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

>
>  		next = stage2_range_addr_end(addr, end);
>  		ret = fn(pgt, addr, next - addr);
>
> --
> 2.55.0
