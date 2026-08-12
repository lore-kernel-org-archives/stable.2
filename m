Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C4B432BC9;
	Wed, 12 Aug 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544730; cv=none; b=OEtQHqekrjhn095c3xbpXa0KcNvmaovoX4F72srLCCUn/JzvsvmoIaMgG469SRhDrMl3JZVEUAfmL+eXqf3Uihpd1oinsDDK2kSHO3qUbLBHECoEpOWZ5GiQ49r+ULjBBXIrxSEaOa0bpXQCnTSna/Sjr50VN8q1O+BSXTAF/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544730; c=relaxed/simple;
	bh=FlegEE6R2dmZVclNdJ0BhhQalmHQrTxc+SxCFky9irI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSDosh3rWcbecNovSxhRAv98AObNLLCsBWWjNYtzfoY+n3JbjX9odnb6YPiA+X8ArLPLh/KXtS6n9oMJ1Ltu0H5H5qidwmLRJCf/njLNU5fSNsneeTBLj05ozgD2oXL+nPxpFplH5LzfZHvHoPa7eDDqq2Vd/iPANsxq/Gw4ZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmmx6ZWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmmx6ZWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1CB1F00A3A;
	Wed, 12 Aug 2026 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544728;
	bh=JSqQE2i3L0CpveRAmURpu582s2nkWDSB3uYX5ZL+2T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dmmx6ZWn/yq9Y7rIljHVtJ0HibDK0DhGwtOSaf7ok9f/Lkx2GTab1x6/Po/WqrsGO
	 Ra5AYCnvY04w0XqOtX9O3BzOD3iSGL2VBg7X1yPn0tkLT2ZP7a0LigcolCG3GNKKz2
	 9BD3WrkXkU7J3dRO6g5fxUS7ekzWJbodvB8VY3u3G8cMgSKvDGR9VfprMr2JOUqWvU
	 esdYoSIMpCWDOMAr3yDR/pqeaOcDxziojDhnLHD40NOeiLc3SIDPlKfVfFcel7Fu6K
	 USWmFqCgZ+32oVuFAYxob7DH7W8Ag788QJaM/MLWtW+WiV8p5q3E7XPAq2VKnIbsDl
	 zt5rnw30klA5g==
Date: Wed, 12 Aug 2026 15:25:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Fix life cycle of the nested_mmus array
Message-ID: <anx9wCmr7mW7U58H@gremlin>
References: <20260811122057.754772-1-maz@kernel.org>
 <anxXP_ZTZb_iKu1w@e143914.arm.com>
 <86ik5f1lon.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ik5f1lon.wl-maz@kernel.org>

On Wed, Aug 12, 2026 at 03:02:32PM +0100, Marc Zyngier wrote:
> Hi Joey,
>
> On Wed, 12 Aug 2026 12:21:35 +0100,
> Joey Gouly <joey.gouly@arm.com> wrote:
> >
> > Hi,
> >
> > Small comment / suggestion.
> >
> > On Tue, Aug 11, 2026 at 01:20:57PM +0100, Marc Zyngier wrote:
> > > The nested_mmus array holds the shadow page tables that are used when
> > > a guest is running a nested context. These structures are allocated on
> > > VCPU_INIT for whole guest, which implies that they may have to be
> > > relocated as the array grows.
> > >
> > > Should a VCPU_INIT occur whilst a vcpu is actively running an L2 and
> > > that the allocation requires relocation, that vcpu will still be
> > > running with a pointer to the previous structure, which will have been
> > > freed.
> > >
> > > Fix this by turning the array of structures to an array of pointers,
> > > which is now allocated at VM creation, sized to the absolute maximum
> > > that KVM can handle.
> > >
> > > In turn, each VCPU_INIT contributes S2_MMU_PER_VCPU to the pool. No
> > > reallocation is ever performed, and the life cycle of each object is
> > > much clearer:
> > >
> > > - the nested_mmus array is allocated in kvm_init_nested(), and freed
> > >   in kvm_arch_destroy_vm()
> > >
> > > - s2_mmu structures are allocated in kvm_vcpu_init_nested(), and freed
> > >   on kvm_arch_flush_shadow_all()
> > >
> > > Finally, the freeing of vcpu->arch.vncr_array is made consistent
> > > rather than being done on some failure paths, but not others.
> > >
> > > Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> > > Reported-by: Shen Yongchao <grayhat@foxmail.com>
> > > Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> > > Suggested-by: Karl Mehltretter <kmehltretter@gmail.com>
> > > Link: https://lore.kernel.org/r/20260803224405.41468-1-kmehltretter@gmail.com
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >
> > > Notes:
> > >     Sending this as a first class patch, since the other approaches were even
> > >     uglier than this one. I'm still displeased with kvm_arch_flush_shadow_all(),
> > >     but that's a step in the direction of tightening it:
> > >
> > >  arch/arm64/include/asm/kvm_host.h   |  2 +-
> > >  arch/arm64/include/asm/kvm_nested.h |  2 +-
> > >  arch/arm64/kvm/arm.c                |  8 ++-
> > >  arch/arm64/kvm/nested.c             | 91 +++++++++++++----------------
> > >  4 files changed, 49 insertions(+), 54 deletions(-)
> > >
> > [..]
> > > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > > index 20af94197a8a7..50d6dcc75582c 100644
> > > --- a/arch/arm64/kvm/nested.c
> > > +++ b/arch/arm64/kvm/nested.c
> > > @@ -44,11 +44,15 @@ struct vncr_tlb {
> > >   */
> > >  #define S2_MMU_PER_VCPU		2
> > >
> > > -void kvm_init_nested(struct kvm *kvm)
> > > +int kvm_init_nested(struct kvm *kvm)
> > >  {
> > > -	kvm->arch.nested_mmus = NULL;
> > > +	kvm->arch.nested_mmus = kvmalloc_array(KVM_MAX_VCPUS * S2_MMU_PER_VCPU,
> > > +					       sizeof(struct s2_mmu *),
> > > +					       GFP_KERNEL_ACCOUNT);
> > >  	kvm->arch.nested_mmus_size = 0;
> > >  	atomic_set(&kvm->arch.vncr_tlb_count, 0);
> > > +
> > > +	return kvm->arch.nested_mmus ? 0 : -ENOMEM;
> > >  }
> > >
> > >  static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
> > > @@ -69,8 +73,7 @@ static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
> > >  int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
> > >  {
> > >  	struct kvm *kvm = vcpu->kvm;
> > > -	struct kvm_s2_mmu *tmp;
> > > -	int num_mmus, ret = 0;
> > > +	int num_mmus;
> > >
> > >  	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
> > >  	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
> > > @@ -83,51 +86,40 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
> > >  	if (!vcpu->arch.ctxt.vncr_array)
> > >  		return -ENOMEM;
> > >
> > > -	/*
> > > -	 * Let's treat memory allocation failures as benign: If we fail to
> > > -	 * allocate anything, return an error and keep the allocated array
> > > -	 * alive. Userspace may try to recover by initializing the vcpu
> > > -	 * again, and there is no reason to affect the whole VM for this.
> > > -	 */
> > >  	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
> > >
> > >  	if (num_mmus > kvm->arch.nested_mmus_size) {
> >
> > Sashiko.dev complained about a possible race here, but looking at the
> > code, it seems incorrect?
> >
> > Unsure why it didn't e-mail it.
> > https://sashiko.dev/#/patchset/20260811122057.754772-1-maz%40kernel.org
> >
> > It seems that this code is serialised / protected by
> > kvm->arch.config_lock in __kvm_vcpu_set_target() (which is the only
> > caller of kvm_vcpu_init_nested() via kvm_setup_vcpu())
>
> Yeah, this looks like Sashiko went south again. You'd hope it'd be
> able to follow such a simple code path...

Well, I wonder if this is onto _something_ though maybe badly expressed.

The window is probably super small really but a concurrent MMU notifier
event could possibly get confused because of the nested_mmus growth, and
presumably that doesn't also take kvm->arch.config_lock I don't think?

I attach my original patch that Marc's patch supercedes which goes into
infinite probably-OTT detail (still learning so trying to think through
things a lot :) but maybe useful there for reference.

I think Marc's patch fixes this in any case :)

>
> >
> > So maybe a
> >
> > 	lockdep_assert_held(&kvm->arch.config_lock);
> >
> > makes sense in kvm_vcpu_init_nested()?
>
> Sure, that's never a bad thing to add.

This is still valuable though I think!

We have a lot of asserts like this in core mm, really helpful practice I think.

I wonder if it'd be helpful to have helper functons for this, e.g.:

static inline void kvm_assert_config_locked(const struct kvm *kvm)
{
	lockdep_assert_held(&kvm->arch.config_lock);
}

static inline void kvm_assert_mmu_read_locked(const struct kvm *kvm)
{
	lockdep_assert_held_read(&kvm->mmu_lock);
}

static inline void kvm_assert_mmu_write_locked(const struct kvm *kvm)
{
	lockdep_assert_held_write(&kvm->mmu_lock);
}

etc.?

>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.
>

--
Cheers, Lorenzo

----8<----
From c0ca5794fcfc85d5d5db822999496419d4417522 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 11 Aug 2026 19:34:56 +0100
Subject: [PATCH] KVM: arm64: nv: avoid race on nested MMU growth

When starting up a new VM, kvm_vcpu_init_nested() sets up each vCPU:

kvm_arch_vcpu_ioctl()
  -> kvm_arch_vcpu_ioctl_vcpu_init()
    -> kvm_vcpu_set_target()
      -> __kvm_vcpu_set_target()
        -> kvm_setup_vcpu()
          -> kvm_vcpu_init_nested()

With nested virtualisation this can result in nested_mmu growth in
kvm->arch.nested_mmus[] and kvm->arch.nested_mmus_size.

When this happens, kvm_vcpu_init_nested() allocates a new array then copies
existing nested mmu state into it before swapping this array into
kvm->arch.nested_mmus, all under kvm->mmu_lock.

However it then initialises the entries via init_nested_s2_mmu() and sets
kvm->arch.nested_mmus_size as well as handling teardown on
init_nested_s2_mmu() returning an error, outside of the lock.

An unlucky concurrent MMU notifier event could read these values before
they are in a valid state.

The newly allocated memory obtained from kvcalloc() is zeroed, which is
especially problematic for a kvm_s2_mmu_valid() check as this checks for
the absence of VTTBR_CNP_BIT in mmu->tlb_vttbr which is trivially true of
zeroed memory.

Since everything after the num_mmus > kvm->arch.nested_mmus_size branch is
a no-op if this condition is not true, simplify things by replacing it with
a guard clause on the inverse condition.

The tmp variable is allocated to temporarily store data, but then this is
swapped in to kvm->arch.nested_mmus[] and later operations are performed on
this instead.

Both the copying of existing data and the assignment of tmp[i].pgt->mmu
must be done in a critical section as the former might be mutated under
kvm->mmu_lock and the latter sets the externally visible pgt->mmu field.

However, initialisation of new fields and error handling can be done
outside the lock which simplifies things, and in any case
init_nested_s2_mmu() ultimately acquires the kvm->mmu_lock in parts of its
operation anyway so the lock cannot be held over it in any case.

By limiting the scope over which kvm->mmu_lock is held any potential lock
contention is also reduced.

Error handling is made easier by the fact that no externally visible state
has been altered by this stage as only tmp has been updated.

Fix the race by setting kvm->arch.nested_mmus[] and
kvm->arch.nested_mmus_size in the critical section.

Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/nested.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index f7b1385a5ac6..0c32977463b8 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -92,43 +92,36 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	 */
 	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;

-	if (num_mmus > kvm->arch.nested_mmus_size) {
-		tmp = kvcalloc(num_mmus, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
-		if (!tmp)
-			return -ENOMEM;
-
-		write_lock(&kvm->mmu_lock);
-
-		if (kvm->arch.nested_mmus_size) {
-			memcpy(tmp, kvm->arch.nested_mmus,
-			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
-
-			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
-				tmp[i].pgt->mmu = &tmp[i];
-		}
-
-		swap(kvm->arch.nested_mmus, tmp);
-
-		write_unlock(&kvm->mmu_lock);
+	if (num_mmus <= kvm->arch.nested_mmus_size)
+		return 0;

-		kvfree(tmp);
-	}
+	tmp = kvcalloc(num_mmus, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
+	if (!tmp)
+		return -ENOMEM;

 	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
-		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);
+		ret = init_nested_s2_mmu(kvm, &tmp[i]);

 	if (ret) {
 		for (int i = kvm->arch.nested_mmus_size; i < num_mmus; i++)
-			kvm_free_stage2_pgd(&kvm->arch.nested_mmus[i]);
-
+			kvm_free_stage2_pgd(&tmp[i]);
 		free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
 		vcpu->arch.ctxt.vncr_array = NULL;
-
+		kvfree(tmp);
 		return ret;
 	}

+	write_lock(&kvm->mmu_lock);
+	if (kvm->arch.nested_mmus_size)
+		memcpy(tmp, kvm->arch.nested_mmus,
+		       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
+	for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
+		tmp[i].pgt->mmu = &tmp[i];
+	swap(kvm->arch.nested_mmus, tmp);
 	kvm->arch.nested_mmus_size = num_mmus;
+	write_unlock(&kvm->mmu_lock);

+	kvfree(tmp);
 	return 0;
 }

--
2.55.0
