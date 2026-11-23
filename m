Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447630;
	b=Zl4qL7a04/8qtVJsdr5fO6xMsQnt1LuryNol9zp4QkbRLmMlIZeh1iGh7xY3EH+kW6a6
	 TsCQvmZY+ptsHaAAepQ+LkGi1VSfBebJWR5gMW96VwSm+CoH4vGcvr7FV3Ah5MJIcg1u0
	 +r47llJgcEP2+ROjpUrutihqkV67PfjLULvN4UaU+VBMGcgcVzsS2N6PNM5WOAvxabn8y
	 KQuhe2D+UUh2nbsenZg8+uZrRadu0ktNVpDZQxw6oTY0fygH49qtKOjwS//9DqJVzjZ08
	 0g29nDGjulzahhyJ9AKgti1zfmNiSdT9XmMcrasZ1hI6rqHOic62bbT6mXrcl8r7Rng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447630;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9TZM6XuQCVdejYnoblYTNL9KeRxvPg2JJEEUf+a0CiE=;
	b=ILA4+T/o1nGBxc5h9eCFdRHAduMKrcu9h6Dqntn+S34gseMzzAxvW1EMD54XnRZumWGH
	 wR8Dtsww+pH8JeG9FkslmNQ7Syf5/+gwNkOAAsAeXeSJKNxWgMMTFyMUEv9+ETynplJbZ
	 CINbBdFLl8UUs6e77szDLt2OzEHRHnWT2wIM7yanqjEP7mwpAWd+b921hHYPU9K5h1LMB
	 R1sJ0fZ6QwevVjc6QhkdKt4/ImrCBMJKsVk5F/U8oYnrhdK17aKhQPCjQzF9b0t3KAUgd
	 sY7gwj7/f3aPSmdcrjkqgXfNMMCxqPkaCVI46z9ZRmdemHKYnRBwov2FPITZbuRteZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9Uq4Xe1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F93606A31E;
	Mon, 23 Nov 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9Uq4Xe1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F14A1F000CA;
	Mon, 23 Nov 2026 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795447629;
	bh=9TZM6XuQCVdejYnoblYTNL9KeRxvPg2JJEEUf+a0CiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e9Uq4Xe1qpaATaiDo5wOIGfM+EwwcSQCdX2R2WULHbjBs1ZKYHp5YWudfo93wnIy5
	 /EhRUZq0GSxcIuK9YxYvHnRR5XYYZ4V2QQ7T4acP62KJQSB0P4u2p+GsiWTqdMR5Fi
	 z+ih5lmoVRpbnEDzOThc0xJ4cyzHo+8go0bQAqSuS2gcJiuVz/EZRvD5IQWJa8vj0J
	 Dvg9kXq7oPJFI6klRrQcc37C/KER5hExgJomgHTE/a0s4Zfgc9yNZhTDqX/6URCxR3
	 ti4Ppj9+UFttR1Ut9xW8NOhqoUUxbYhCt7YJZHZFqIEDcO9rh1rdwELZoH2asAErZr
	 KGA11e44z4i3Q==
Date: Mon, 23 Nov 2026 15:27:01 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Fuad Tabba <tabba@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
Message-ID: <awRaeD7ut2Y5Lv8n@gremlin>
References: <20261123113435.1170711-1-fuad.tabba@linux.dev>
 <20261123113435.1170711-2-fuad.tabba@linux.dev>
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
In-Reply-To: <20261123113435.1170711-2-fuad.tabba@linux.dev>

On Mon, Nov 23, 2026 at 11:34:33AM +0000, Fuad Tabba wrote:
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
> The check also sets run->exit_reason to KVM_EXIT_DIRTY_RING_FULL. On
> arm64, KVM_RUN completes a pending MMIO exit only if exit_reason is
> still KVM_EXIT_MMIO, and on riscv KVM_RUN does the same for its MMIO,
> SBI and CSR exits. If a pre-fault stops on a full ring while such an
> exit is pending, the next KVM_RUN doesn't complete it and the guest
> repeats the instruction that caused the exit. Userspace can avoid that
> by completing the exit with KVM_RUN before pre-faulting.

Thanks for adding!

>
> Fixes: bc1a5cd002116 ("KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to pre-populate guest memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Thanks! LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

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
>

--
Cheers, Lorenzo
