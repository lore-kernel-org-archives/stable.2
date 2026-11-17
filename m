Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925398;
	b=p+3xoyg3EbhsrpFppABh4Qs9zBx7rk8ZvRAEQgz8XvAgiYkS15sy/3mF1NwcXmevRuSV
	 raEs+59n4PZOGqwJMtTJASVwxRW4zOSVg2ZNIDccFY5Q7nNxj38cBcJSiFAMp/OhGS9A/
	 e0I9qzTAyEarF2rWdQzv144OseX/2u9fY9PYauvYo7Wuds9DggNzmXbkaqWjNmZVROqan
	 MAG4AjhZRf2E4fk4IWBqYujEuiQho/xIBa+mbyUSgEQSd68/Q9slARY0cZdMjlgmA5zot
	 8yB+yUETw7PsgM1PX3EQ5+qriR8WelTcRbVdR0aFPBiDPNajB1vehNCodXiJaPL5gNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925398;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=krR/5Q7S3O2zHyiJtsN5nMBfN9AbYYB2TldesofTifs=;
	b=Mf9Ug6o4HJ4rAinzSj2L6BdlVVEMe+x1eZKTkk/R6tpz3PPkgfoG7p6wmeztr3ua9Fqj
	 7LCPEqmus2jZ9jtlWfmQh5h10Kn3QTPqd6/XnDQ8vOJnCQxpjSHGUsexO/YxE6umweD7P
	 kjZLkuZCtApe6EthoOfaoXjL36SbRfuYKnky0ZbqPaol98NZVBLN6OU0gvhXWhNjl5yfJ
	 aE/cyUWozHLX9n8bDg0y1SdR414dPp5bghcOtIYa6rSsEjdmkwvMDMbdCQRgQ4AuGAeql
	 ZCxluxncvP3saCIY6bW0aMmT3REB4KYvY8tddZNtUfymBSvDgcpMhpsSiGOJ4+6J9Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTQQFebW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAF606A332;
	Tue, 17 Nov 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTQQFebW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DCC1F000C8;
	Tue, 17 Nov 2026 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794925397;
	bh=krR/5Q7S3O2zHyiJtsN5nMBfN9AbYYB2TldesofTifs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZTQQFebWTEHN9G5+IahBjWCvodO4LWCChSi/sXwTy/zEHhM+ET+J5SFR+XjJTwZYf
	 231iS8BdtJ0P3krxvJChohGHugVLqDGLs2BHR1pmO8x4pggBx663UNxsXmxIJDAOTi
	 VMkI3cOLTiLzMwS1+RDnCEM8HTh9z7ZtSMD+v5CpIsGyvtcB//W7Bdi29UPuuAHcO5
	 C5Ef1N1LaavmkLfIv+s1L8Pbvd1tQSRfPuhMWWNVrtayUxkoL/z/3laF+nyiGK2G3q
	 Nz6b/EzCh6hEgUQ/CIguzrKxPd+TzYjeEgBPDixGTQIkMdgmp4ks6za6QqYA7a5ZB4
	 Y38ihWjRmXVTw==
Date: Tue, 17 Nov 2026 14:23:09 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
Message-ID: <avxfgWNePsGPK9mm@gremlin>
References: <20261117074428.7544-1-fuad.tabba@linux.dev>
 <20261117074428.7544-2-fuad.tabba@linux.dev>
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
In-Reply-To: <20261117074428.7544-2-fuad.tabba@linux.dev>

On Tue, Nov 17, 2026 at 07:44:27AM +0000, Fuad Tabba wrote:
> Pre-faulting can map a dirty-logged page writable, which pushes it to
> the vCPU's dirty ring. KVM_RUN exits with KVM_EXIT_DIRTY_RING_FULL
> before the ring overflows, but the pre-fault loop never checks it, so
> one call can push more entries than the ring has free, which trips the
> WARN in kvm_dirty_ring_push() and overwrites entries userspace hasn't
> harvested. On x86:
>
>   WARNING: arch/x86/kvm/../../../virt/kvm/dirty_ring.c:225 at kvm_dirty_ring_push+0x7a/0xd0
>   Call Trace:
>    make_spte+0x2cc/0x450
>    kvm_tdp_mmu_map+0x5e1/0x7f0
>    kvm_tdp_page_fault+0x12c/0x1b0
>    kvm_mmu_do_page_fault+0x181/0x250
>    kvm_arch_vcpu_pre_fault_memory+0x136/0x1d0
>    kvm_vcpu_pre_fault_memory+0xcf/0x180
>    kvm_vcpu_ioctl+0x455/0x770
>
> Stop the loop once the ring is soft full, with the check KVM_RUN makes
> before entering the guest. Return the pages already processed, or
> -ENOSPC when there aren't any, since a retry can't succeed until
> userspace harvests and resets the ring. s390 has the ioctl but no ring,
> so give kvm_dirty_ring_check_request() a stub.
>
> The check also sets run->exit_reason, and arm64's KVM_RUN completes a
> pending MMIO exit only if exit_reason is still KVM_EXIT_MMIO. If a
> pre-fault stops on a full ring while an MMIO exit is pending, the next
> KVM_RUN doesn't complete the exit and the guest repeats the MMIO
> access. Userspace can avoid that by completing the exit with KVM_RUN
> before it pre-faults.

That's also true for riscv:

	switch (run->exit_reason) {
	case KVM_EXIT_MMIO:
		/* Process MMIO value returned from user-space */
		ret = kvm_riscv_vcpu_mmio_return(vcpu, vcpu->run);
		break;
	case KVM_EXIT_RISCV_SBI:
		/* Process SBI value returned from user-space */
		ret = kvm_riscv_vcpu_sbi_return(vcpu, vcpu->run);
		break;
	case KVM_EXIT_RISCV_CSR:
		/* Process CSR value returned from user-space */
		ret = kvm_riscv_vcpu_csr_return(vcpu, vcpu->run);
		break;
	}

(note that it skips CSR, SBI also with a changed exit_reason).

But the overflow bug only applies to x86 (see below), so is this something
we should worry about at all?


>
> Fixes: bc1a5cd002116 ("KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to pre-populate guest memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  Documentation/virt/kvm/api.rst | 9 +++++++--
>  include/linux/kvm_dirty_ring.h | 5 +++++
>  virt/kvm/kvm_main.c            | 5 +++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e95c9cda085d9..89eb6be9bc6e3 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6544,6 +6544,7 @@ Errors:
>    ENOENT     The specified `gpa` is outside defined memslots.
>    ENOEXEC    The vCPU has not been initialised (arm64).
>    EINTR      An unmasked signal is pending and no page was processed.
> +  ENOSPC     The vCPU's dirty ring is full and no page was processed.
>    EFAULT     The parameter address was invalid.
>    EHWPOISON  A poisoned host page was encountered.
>    EOPNOTSUPP Mapping memory for a GPA is unsupported by the
> @@ -6588,7 +6589,9 @@ case, the ioctl can be called in parallel.
>
>  When the ioctl returns, the input values are updated to point to the
>  remaining range.  If `size` > 0 on return, the caller can just issue
> -the ioctl again with the same `struct kvm_map_memory` argument.
> +the ioctl again with the same `struct kvm_pre_fault_memory` argument.
> +If that fails with ENOSPC, the vCPU's dirty ring has to be harvested
> +and reset first.
>
>  On x86, shadow page tables cannot support this ioctl because they
>  are indexed by virtual address or nested guest physical address.
> @@ -8957,7 +8960,9 @@ Therefore, the ioctl must be called *before* reading the content of
>  the dirty pages.
>
>  The dirty ring can get full.  When it happens, the KVM_RUN of the
> -vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL.
> +vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL, and
> +KVM_PRE_FAULT_MEMORY on the vcpu will process no more pages until the
> +ring has been harvested and reset.

Maybe worth mentioning the exit_reason thing if we keep this arch-generic?

>
>  The dirty ring interface has a major difference comparing to the
>  KVM_GET_DIRTY_LOG interface in that, when reading the dirty ring from
> diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
> index eb10d87adf7d5..729615ae0cf4d 100644
> --- a/include/linux/kvm_dirty_ring.h
> +++ b/include/linux/kvm_dirty_ring.h
> @@ -60,6 +60,11 @@ static inline void kvm_dirty_ring_push(struct kvm_vcpu *vcpu,
>  {
>  }
>
> +static inline bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
> +
>  static inline struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring,
>  						   u32 offset)
>  {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f1407..ac8b94a386e4a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4461,6 +4461,11 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>  			break;
>  		}
>
> +		if (kvm_dirty_ring_check_request(vcpu)) {
> +			r = -ENOSPC;
> +			break;
> +		}
> +
>  		r = kvm_arch_vcpu_pre_fault_memory(vcpu, range);
>  		if (WARN_ON_ONCE(r == 0 || r == -EIO))
>  			break;
> --
> 2.47.3
>

I wonder if this shouldn't just be an x86-only fix, since no other arch is
impacted AFAICT.

arm64 and riscv never map a dirty-logged memslot writable, so they're never
pushed to the rin, and s390 doesn't have a dirty ring at all:

arm64:

static int kvm_s2_fault_compute_prot(const struct kvm_s2_fault_desc *s2fd,
				     const struct kvm_s2_fault_vma_info *s2vi,
				     enum kvm_pgtable_prot *prot)
{
	...
	if (s2vi->map_writable && (s2vi->device ||
				   !memslot_is_logging(s2fd->memslot) ||
				   kvm_s2_fault_is_write(s2fd)))
		*prot |= KVM_PGTABLE_PROT_W;
	...
}

riscv:

int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
		      gpa_t gpa, unsigned long hva, bool is_write,
		      struct kvm_gstage_mapping *out_map)
{
	...
	bool logging = kvm_slot_dirty_track_enabled(memslot) &&
		       !(memslot->flags & KVM_MEM_READONLY);
	...
	/*
	 * If logging is active then we allow writable pages only
	 * for write faults.
	 */
	if (logging && !is_write)
		writable = false;
	...
}

An x86-only version would be pretty simple, something like the below.

This also covers off the retry (RET_PF_RETRY) loop which a generic version
doesn't.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f89e9f8a6cc2..343eb5ad0baa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5129,6 +5129,14 @@ static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
 			return -EIO;

+		if (kvm_dirty_ring_check_request(vcpu))
+			return -ENOSPC;
+
 		r = kvm_mmu_reload(vcpu);
 		if (r)
 			return r;


--
Cheers, Lorenzo
