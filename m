Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780697;
	b=EPbpaa2jcjr0qKSWIY6UoAqJxjW+R+fpL2aXAKh3AW5RE0Z4gKe3jVmB+e2S1KQ5fY/8
	 HDY4WX1arsSqO7VJNyMuXRBEHkb0l1l8leFcz/BGQdYLVzJk6XjYKWrD/stQt+km6FzSR
	 K9M0kw6it4N6AuJiw0SLzfM5aK5qb65CE4L7Vgsx9QJOo10enVAawpV7Ox+q+czi2Xdws
	 WAS9V/ZPd/2NDHQzdBplWgPj519tGGoetIjrUVxPl5Tmar59MyCA+R2BtsP0hdASzxhzn
	 rCFlNa3UvyQorzfROtmXseGtAnCbaAwEAZaVU5EWnU+AEfctfQS5IiWD0uocYZUAwkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780697;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=wOSam9agbw1+dzF6MgDQrdgzWaJav+iyppZ1shM/GUA=;
	b=OFdhRWq3g9M1yAzmQpgExleDbkQ1yms4rKSdUu/ppVvAqBeBG0lnK+lUIdQC/ljyYPfz
	 DJPUHX0o0tuX6VNz5/rBYUJb0MAoJYX69XqmYH+22qZxYyox4kb6lnesaY+P5bEw+YxFZ
	 B3L6vV3bRdOJOFLs7vgRJC8nXFwIkMu6Fn9ZdNZKbzNAm/ig2Ewd79216AdnmgGFYFiY7
	 j6pJAe6cApuZBJP3hlKwxYfi8VttivakEpLFYkt/rI0qVklezLcA6RY3F/8SqSxTSFMHW
	 78M6kCeq/IwtxKd9TQccKQv/0qu2NNiUpFAw81kbwgFpqvnGjgqXc/HOhTky+K9VYNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tF4dse+7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA24606A31C;
	Fri, 27 Nov 2026 11:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA24606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tF4dse+7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6781E1756;
	Fri, 27 Nov 2026 03:58:13 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98EC3F632;
	Fri, 27 Nov 2026 03:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795780696; bh=xXErXhUett0rBMIuptXq/Dm31j/RK5+84KbmHuA57kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tF4dse+7YvhP7rH5RzPUNzAGGI5TCy35roJFW+HWFcJt5TEkyG5bFhKgeIMf9Goq6
	 gWJ8yLjNdSs+NagBnpbSY9i7NtcwEd2ljuRrj9UhbQ8X8qEGpwuxd9cOtLXzTmP6wU
	 y3cfMWCwlQoS/kXesVN8c671I5aCxUmDZWiEvOq4=
From: Leonardo Bras <leo.bras@arm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Jintack Lim <jintack.lim@linaro.org>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Top up the mmu memcache on user fault for NV
Date: Fri, 27 Nov 2026 11:58:04 +0000
Message-ID: <awlwTGHVjoO72YFw@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-fix-nv-cache-topup-v1-1-a22c936872fe@kernel.org>
References: <20261126-fix-nv-cache-topup-v1-1-a22c936872fe@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Thu, Nov 26, 2026 at 05:28:29PM +0000, Lorenzo Stoakes (ARM) wrote:
> The S2 user fault path tops up the MMU memcache (used for page table
> pre-allocation as the point at which page tables are installed may not
> allocate) except when:
> 
> * It's a permission fault AND
> * dirty page logging is disabled AND
> * pKVM is disabled
> 
> At which point it is assumed no page table will be allocated.
> 
> However nested virtualisation adds another edge case - the mapping size of
> a shadow S2 is clamped to that of the guest's own S2. If the guest
> hypervisor replaces a block mapping with a table, a permission fault on the
> shadow block has to be mapped at PAGE_SIZE, which requires a page table to
> collapse the block into.

Can you please expand on how would that happen?

IIUC when a guest hypervisor replaces a block mapping with a table, it 
calls a tlbi in the range, and L0 will trap and remove the Shadow S2 entry, 
then next access shouldn't be a permission but a translation fault.

What am I missing?

Thanks!
Leo

> 
> With the memcache empty, kvm_mmu_memory_cache_alloc() hits its
> guest-triggerable WARN_ON(!nobjs) and falls back to a GFP_ATOMIC allocation
> under mmu_lock, with a BUG_ON() if that fails.
> 
> Therefore, also top up the memcache for permission faults taken on a
> shadow S2.
> 
> Note that dirty logging had a similar issue, addressed in commit
> 56fd1fc526e6 ("KVM: arm64: Top up stage-2 memcache for dirty logging
> faults").
> 
> Fixes: fd276e71d1e7 ("KVM: arm64: nv: Handle shadow stage 2 page faults")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/arm64/kvm/mmu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index a0d4981ebb99..e09a8f2c0482 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -2256,16 +2256,18 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd,
>  
>  	/*
>  	 * Permission faults just need to update the existing leaf entry,
> -	 * and so normally don't require allocations from the memcache. The
> -	 * only exception to this is when dirty logging is enabled at runtime
> +	 * and so normally don't require allocations from the memcache. One
> +	 * exception to this is when dirty logging is enabled at runtime
>  	 * and a fault needs to collapse a block entry into a table.
>  	 * Under pKVM a permission fault can also collapse pages into a block,
>  	 * which needs a fresh mapping object, and the hypervisor requires the
>  	 * min-pages memcache even when the install allocates nothing.
> +	 * With nested, a shadow stage-2 block may also need to be collapsed
> +	 * into a table if the guest's own stage-2 mapping has become smaller.
>  	 */
>  	memcache = get_mmu_memcache(s2fd->vcpu);
>  	if (!perm_fault || memslot_is_logging(s2fd->memslot) ||
> -	    is_protected_kvm_enabled()) {
> +	    is_protected_kvm_enabled() || s2fd->nested) {
>  		ret = topup_mmu_memcache(s2fd->mmu, memcache);
>  		if (ret)
>  			return ret;
> 
> ---
> base-commit: 012e4bc01e339a65dc7c59181b5efb33b171d12c
> change-id: 20261126-fix-nv-cache-topup-9ab1fd829014
> 
> Cheers,
> -- 
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
