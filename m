Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BF42466A;
	Mon, 24 Aug 2026 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578161; cv=none; b=QPfYnfO2154qLlBIl7v0kYW8uYSZ0hy2COz9jl8CqnXcfooaRZD2deNnszdl630Qv7iYZxRd3Bw0fPJJoFsiEEFzgZn5CeV5QrfFN2TQVN4MfnGj/ui9IB2Il3zHrun/d4jwREzvmTuFxEoC2SnTq9Nsa3H873ixxCSUOq2A53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578161; c=relaxed/simple;
	bh=g29b7wvYfjaQmk7+nbFnx5PBJnBN8iu7Rf4k6W8M4xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR6O8ybrAwNcbKtoXB3vcYojBYgHW+hdVkX8jcf+41XzkRhmunislZmDebjyrS0eeUgu97jsbo7z2StC4sQ6Gx/Qu+vsqJ4t0489UzoaIwZnE7plnw7x5b1R7UivsxapRW9E2RfeAtHCQ66kGcg2eC+RZk+WongngrUQA2WPSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/oshU4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/oshU4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072771F000E9;
	Mon, 24 Aug 2026 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578160;
	bh=lEgYKKEkha5zVelFKuaU6d4W/gqiYgaF9FnZq2+a+Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F/oshU4Il1Bt2lQkvGtNOAp6PSQO58YZxwo/DMx+p9l1JiOviAMbhb8tc9egUBgiS
	 NVKQzJ3MihmJvtgtMMoaVv0AXT/GFQAmRkQKcbLeKUmw/QWJvG0pwFAnfWIReBGuXu
	 vdYeViL60lKXaV8vyoONOrDUG11QfUevJffrwTG17JQly1GKZ8lYrTwdJRgJmqCuds
	 sBCSM6CvNZfuXDU8V+kphQWICyI0aF8ujjIiGTKZMI0lSHitlvAyIj/1ulOBAB8+tY
	 I4wQtbS3snLfcQJnvzDoqqFVXOTTErOS11hpSnhdcrAHxh3z6/97zsLgGlBe12kInT
	 oOqOSPA3jCsiA==
Date: Mon, 24 Aug 2026 14:29:14 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Christoffer Dall <christoffer.dall@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: Fix spurious warning for benign stage
 2 teardown race
Message-ID: <aoxETjo-1vbTuLuZ@gremlin>
References: <20260822-kvm-arm-nested-virt-fix-v2-0-ac4059a0eaa6@kernel.org>
 <20260822-kvm-arm-nested-virt-fix-v2-1-ac4059a0eaa6@kernel.org>
 <dycpfrkpphjy5xnb57t2zvdmlpkx76lbow7w23l3d2fwgbfjjj@lbk4uh7awc2p>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dycpfrkpphjy5xnb57t2zvdmlpkx76lbow7w23l3d2fwgbfjjj@lbk4uh7awc2p>

On Sun, Aug 23, 2026 at 01:38:18PM +0800, Yao Yuan wrote:
> On Sat, Aug 22, 2026 at 06:46:53PM +0800, Lorenzo Stoakes (ARM) wrote:
> > A batch of kernel warnings were triggered in the L0 host kernel when using
> > kvmtool to experiment with nested virtualisation.
>
> ...
>
> > Fixes: ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page tables")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/arm64/kvm/mmu.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 74e7e7f7564c..31e049ded093 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -59,19 +59,25 @@ static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
> >   * long will also starve other vCPUs. We have to also make sure that the page
> >   * tables are not freed while we released the lock.
> >   */
> > -static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
> > +static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
> >  			      phys_addr_t end,
> >  			      int (*fn)(struct kvm_pgtable *, u64, u64),
> >  			      bool resched)
> >  {
> >  	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
> > +	phys_addr_t addr = start;
> >  	int ret;
> >  	u64 next;
> >
> >  	do {
> >  		struct kvm_pgtable *pgt = mmu->pgt;
> > +		/*
> > +		 * We may be raced on PGT teardown when we release the
> > +		 * kvm->mmu_lock. That's fine as the PGT is legitimately no
> > +		 * longer present.
> > +		 */
> >  		if (!pgt)
> > -			return -EINVAL;
> > +			return resched && addr > start ? 0 : -EINVAL;
>
> Hi,
>
> I can understand the addr checking makes sure only return 0
> when the mmu_lock is dropped at least once and get pgt =
> NULL, may a variable like drop_lock = true when
> cond_resched_rwlock_write(&kvm->mmu_lock) happens can have
> better readability, but depends on you and others' opinion.

Yeah good point, also the condition is resched && next != end, so this was far
too forgiving already :)

So perhaps:

static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
			      phys_addr_t end,
			      int (*fn)(struct kvm_pgtable *, u64, u64),
			      bool resched)
{
	...
	bool lock_dropped = false;
	...
	do {
		...
		if (!pgt)
			return lock_dropped ? 0 : -EINVAL;
		...
		if (resched && next != end) {
			cond_resched_rwlock_write(&kvm->mmu_lock);
			lock_dropped = true;
		}
	} while (...);
	...
}

That keeps it simple and clear and we don't try to infer anything too
complicated from the state just 'the lock was dropped'.

>
> Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

Thanks :)


>
> >
> >  		next = stage2_range_addr_end(addr, end);
> >  		ret = fn(pgt, addr, next - addr);
> >
> > --
> > 2.55.0

--
Cheers, Lorenzo
