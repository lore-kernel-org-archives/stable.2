Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320555;
	b=jazu6YvrCjU3NnnpUSCxhjZpDip/ZHUqAD6OHNaA+Gse4j0u5W1HBJsLxvc6QS9wjoN9
	 yWRncGNzBbti4tHxEJbMGpKdQFuhXseddoUskDn6nprpyuPOmNoe4dLP85COgS++8st3s
	 Rjs4Rpxie/tVjfIy7l0BxCdev7TlBnnAdUlQ+whRSVXy+mGQBYQhXsYRckKA00XTllvSP
	 3ChqYpCEk2lUS+9WYmyasyVhtHZAoDm3YYhNiQMwK4U/VZRQECvU38ztpjQeFYIgFuFir
	 Vz/mqjFQECPGUJq3VW55iogh4Tt7weNWZ/rqrMM8tYY0x2arUtJi5k0lTga1i0IZq0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320555;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AIYmoG2ZPhdsPOSGAKvMRGDsvTlHJm2tfagrMZ0h6+E=;
	b=haI81llh4d+hmntsPjEuiw8zOxuUJbUWj6xw9/vM/2wrLlm7j+zATpY4T2g3+BJzO1M1
	 6X+NTE15N5cWuR2Uq3NP+S0Kzoke2mMFww/UZFA5SqyYuhAccPQta95C3K1KDRyF+m34/
	 +CHYHiu2K4ygdRyeh+21pXAdpy0yA+dLR7ya6fa0yVABu5kWUpT6YdAQwanoNFKPfVgy5
	 uT/5fe3bPewWM9ZtgB+SSUZb7uF0wCRsYb54oVdXaigLyJUTjE8fL5nuQRSMMjJbYc4dL
	 VDAAR7YnFqB1/bQ9v3zotyWhJ32vX4mCUGkb+Yan0s0e5qBpovnAdeONK4BAokSEn8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLutfqhQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE0606A325;
	Tue, 10 Nov 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLutfqhQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE24C1F0089F;
	Tue, 10 Nov 2026 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320554;
	bh=AIYmoG2ZPhdsPOSGAKvMRGDsvTlHJm2tfagrMZ0h6+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MLutfqhQmJMPBfQRVeyFBDU38p+SbvJq26SP6tRR8X3nTowgeWvkIgFkjEscpShhN
	 QPjaeep4T1pWmb0KBVrDmVr1rejK9/RtWGyI0s35lO3GQlPDoxuJy0muqBDA+7MtK7
	 QzZn47pNtf+AQotB1glSYUN6JsUOkWBiwYcfAALas71fhQPgQpK1hhn+BeqUD8+ImU
	 MwQGR8H3CI9DobyIHL6BQFbPyZSC6BhygkQf2pt09xzlX7aFb73H9S41CVBFzm+YVR
	 bpr0jSKmXzqhd9sfKsTP9WUkDF9BEo7FZPqgMlUBD3Q94YTuNXjGf/pUH01bIwD8rp
	 CeOAlZWlhyhdQ==
Date: Tue, 10 Nov 2026 14:22:26 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Wei-Lin Chang <weilin.chang@arm.com>, 
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
Message-ID: <avMiLt3ZXjYesS3X@gremlin>
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev>
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
In-Reply-To: <20261110110724.3614412-2-fuad.tabba@linux.dev>

On Tue, Nov 10, 2026 at 11:07:23AM +0000, Fuad Tabba wrote:
> Pre-faulting can map a dirty-logged page writable, which pushes it to
> the vCPU's dirty ring. KVM_RUN exits with KVM_EXIT_DIRTY_RING_FULL
> before the ring overflows, but the pre-fault loop never checks it, so
> one call over more such pages than the ring has free trips the WARN in
> kvm_dirty_ring_push() and overwrites entries userspace hasn't
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

If you have a local repro maybe worth sending a regression test for this?... and
I type that, then check the 2/2 and see that you already did :) ok haha thanks!

>
> Stop the loop once the ring is soft full, returning the pages already
> processed, or -ENOSPC when there are none, since a retry can't succeed
> until userspace harvests the ring. kvm_dirty_ring_check_request() fills
> in a KVM_RUN exit, so test the ring's state directly. The stub for
> !HAVE_KVM_DIRTY_RING is for s390, which has the ioctl but no ring.
>
> Fixes: bc1a5cd002116 ("KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to pre-populate guest memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Yikes, nasty. Thanks for addressing this!

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  Documentation/virt/kvm/api.rst | 9 +++++++--
>  include/linux/kvm_dirty_ring.h | 6 ++++++
>  virt/kvm/dirty_ring.c          | 2 +-
>  virt/kvm/kvm_main.c            | 6 ++++++
>  4 files changed, 20 insertions(+), 3 deletions(-)
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
>
>  The dirty ring interface has a major difference comparing to the
>  KVM_GET_DIRTY_LOG interface in that, when reading the dirty ring from
> diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
> index eb10d87adf7d5..88b4f2a009274 100644
> --- a/include/linux/kvm_dirty_ring.h
> +++ b/include/linux/kvm_dirty_ring.h
> @@ -60,6 +60,11 @@ static inline void kvm_dirty_ring_push(struct kvm_vcpu *vcpu,
>  {
>  }
>
> +static inline bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
> +{
> +	return false;
> +}
> +
>  static inline struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring,
>  						   u32 offset)
>  {
> @@ -81,6 +86,7 @@ int kvm_dirty_ring_alloc(struct kvm *kvm, struct kvm_dirty_ring *ring,
>  int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
>  			 int *nr_entries_reset);
>  void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset);
> +bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring);
>
>  bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu);
>
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index 572b854edf740..f73f92102cb7a 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -40,7 +40,7 @@ static u32 kvm_dirty_ring_used(struct kvm_dirty_ring *ring)
>  	return READ_ONCE(ring->dirty_index) - READ_ONCE(ring->reset_index);
>  }
>
> -static bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
> +bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
>  {
>  	return kvm_dirty_ring_used(ring) >= ring->soft_limit;
>  }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f1407..da1b76ceb65e3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4461,6 +4461,12 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>  			break;
>  		}
>
> +		/* Like KVM_RUN: only the iteration crossing the soft limit uses the reserve. */
> +		if (vcpu->kvm->dirty_ring_size && kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
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

--
Cheers, Lorenzo
