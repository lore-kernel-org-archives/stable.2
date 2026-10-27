Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=161.35.211.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104910;
	b=lLOm9MuSjU0lYIHPjrZh1braSIr2qUDNmJYFC3+Y8yGGxMfII9ehQ+3kP0ULdfcVpF69
	 MxCP8eM1gisvWk/G8uXQNkf4+D5HhDkRiaLKtHgtcPKjjaTknWwRZaOCL1SrfpQdk5m+h
	 AUy947fZHzTybFhcxxFh7u3/wxVukOQRu2yd1PsMtywmld6UoIswQ2pI1esq85rEo+i8e
	 FRTlfv8XmgDXB3oLW09czmForG+gQyMk+USf8BGmluaZLLvRwuBB4VuALXneKh5lGSzcW
	 JLayz46rE9ZFdaSdDwmPnPntcnrIn41vdstlsCif9Mxbancg5CkZFhlyl1t/W1GVeAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104910;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kg+ouP1inntzb40DPZ2N3Waqa5fvmozzmC5lJ72Mkwc=;
	b=Jm9ohIcjlInJxmQmtkPuNIkZjoI9G6WgLIPQV9SS38y2WoczjnpdOKK+IsedrxT2Swqs
	 tsWuWH+giEp5/JjooDz8nTkZxItaqeGQZr1D/Q4XgogNSXhiEfWACIRruE55E424o95qy
	 otHqXU68lIp5N99ZateU5VqNN1626FTeTPJemCeOcwbCc5w2yIZI1IFAlv7Fye6bnH6vM
	 xhbM+cxA9KBXx2WdvIT0FNsimqsRahm7SscZoMZLTmwIVfALUW7adqhvjSxWpKAxdfpRR
	 ILFZInqax5IC/tkQI6YlsRhqm0OmLRP99KbWGtNkIO5MhbhgxaHQSbAxQR6IJ9NAWfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mifar.in;
	spf=pass smtp.mailfrom=mifar.in;
	dkim=pass header.d=mifar.in header.i=@mifar.in header.a=rsa-sha256 header.s=mail header.b=lhAGkfj9;
	arc=none smtp.remote-ip=161.35.211.235
Received: from mifar.in (mifar.in [161.35.211.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD2606A31D;
	Tue, 27 Oct 2026 12:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CD2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mifar.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mifar.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mifar.in header.i=@mifar.in header.a=rsa-sha256 header.s=mail header.b=lhAGkfj9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mifar.in;
 i=@mifar.in; q=dns/txt; s=mail; t=1793104901; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : from; bh=HqzqDhsejiFPsEAPuUDo4MeCwz/8FJd6yOYFsn3N2aE=;
 b=lhAGkfj9jnSNHPSOMon+2acV5VPELYfQxSGSO5OgHgTnYdMu+AugZo65pvqHhNQkVMEPj
 kmVhtzr7mjBKfA7A8XdU99+qMeQtFjRa+zvkmgU2o2uimt66YAh4LFSSxo4+T9GICaeYX/g
 4XHsO175nvlFRCIshMC/0zQpkC9qT8RzHL3wPP3Bbcjfq0DPwbTGJ9LJxjCOaDXIXoU2wMg
 91uBYJ+4BtzgBJKo0N3dQuojbVhqDsCgLw1bo4ERQyDOx4Mk+5UywYpfyjBkXWNztKvJwM8
 j9Y8XmQ3gN2UeP6gWtQpB4hjfcGaDvC0UAgHCcgmtoNa45ymyNs1OTsiqUiw==
Received: from mifar.in (91-159-80-191.elisa-laajakaista.fi [91.159.80.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ED448
	 client-signature ED448)
	(Client CN "mutt.mifar.in", Issuer "ca.mifar.in" (verified OK))
	by mifar.in (Postfix) with ESMTPS id 900263F214;
	Tue, 27 Oct 2026 12:41:41 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:41:40 +0200
From: Sami Farin <lkml20261027@mifar.in>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org,
	kimjw04271234@gmail.com, seanjc@google.com, pbonzini@redhat.com,
	stable@vger.kernel.org
Subject: [REGRESSION] KVM: x86: OVMF boot hang with SMM enabled after commit
 b3e6212dea2e ("KVM: x86: Use active memslots for the per-vCPU MMIO cache")
Message-ID: <20261027124140.upuow4a3kv6kssvn@m.mifar.in>
Mail-Followup-To: Sami Farin <lkml20261027@mifar.in>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org,
	kimjw04271234@gmail.com, seanjc@google.com, pbonzini@redhat.com,
	stable@vger.kernel.org
References: <2026102314-CVE-2026-99082-e5b1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026102314-CVE-2026-99082-e5b1@gregkh>

On Fri, Oct 23, 2026 at 14:45:15 +0200, Greg Kroah-Hartman wrote:
>From: Greg Kroah-Hartman <gregkh@kernel.org>
>
>Description
>===========
>
>In the Linux kernel, the following vulnerability has been resolved:
>
>KVM: x86: Use active memslots for the per-vCPU MMIO cache

Hi all,

(Disclaimer: I am an end user, not a kernel developer. I used an LLM to help
triage and trace the issue, but the findings, traces, and tests below are verified.)

I hit a guest boot hang after updating my host from 6.18.57 to 6.18.58 (Fedora 44).
Windows 11 guests using OVMF with Secure Boot and SMM (-machine q35,smm=on) hang
indefinitely at the TianoCore splash screen, pegging the host vCPU core at 100%.

The issue bisects/points directly to commit b3e6212dea2e ("KVM: x86: Use active
memslots for the per-vCPU MMIO cache"), which was backported into 6.18.58 and is
also present in 7.3-rc kvm/queue.

--- What was observed ---

1. 'perf kvm stat live' shows >99.6% of VM exits are IO_INSTRUCTION:
       VM-EXIT          Samples   Samples%     Time%
       IO_INSTRUCTION     13163     99.63%    99.40%

2. 'trace-cmd stream -e kvm:kvm_exit' shows a storm of 32-bit IN reads on port 0x608
    (the ICH9 ACPI PM timer):
       kvm_exit: reason IO_INSTRUCTION rip 0x7b125f0c info 608000b 0

3. Inspecting the guest RIP shows it is stuck in OVMF's MicroSecondDelay() in
    AcpiTimerLib.c polling a condition that never clears:
       0x7b125f0c:  inl    (%dx), %eax
       ...
       0x7b125f58:  btl    $0x17, %eax
       0x7b125f5e:  pause
       0x7b125f60:  jmp    0x7b125f3f

--- Verifications & Workarounds tested ---

- Booting host kernel 6.18.57: VM boots cleanly.
- Running 6.18.58 with 'smm=off' and standard OVMF_CODE.fd: VM boots cleanly.
- Applying a patch to 6.18.59 that stores the address space ID (mmio_as_id)
   in struct kvm_vcpu_arch and checks it in vcpu_match_mmio_gen(): VM boots cleanly
   with smm=on and smm=off.

--- Suspected Root Cause ---

Commit b3e6212dea2e assumed that:
   "Memslot generations are unique across address spaces, so the generation
    also distinguishes the normal and SMM views."

However, address space 0 and address space 1 maintain separate generation counters
starting from 0. The per-vCPU MMIO cache does not record the address space ID, so
when OVMF transitions between normal mode and SMM, entries cached in one address
space appear valid in the other when their generation numbers match. This appears to
return bogus MMIO/RAM data to OVMF, trapping its delay loop.

Happy to provide additional traces or test patches if needed.

I used the included patches to test 6.18.59. I did not try is patch 1
enough, I tested only both of these.

########### patch 1
     The proper upstream fix requires tagging the per-vCPU MMIO cache with the address space ID (as_id) alongside the generation counter.
     The Flaw in Commit b3e6212dea2e:
     The commit attempted to fix stale MMIO cache validation in SMM by checking kvm_vcpu_memslots(vcpu)->generation. However, its commit message relied on an incorrect assumption:
     
         "Memslot generations are unique across address spaces, so the generation also distinguishes the normal and SMM views."
     
     In KVM, each address space maintains an independent struct kvm_memslots with its own generation counter initialized to 0. They are not unique across address spaces. During early VM boot, address space 0 (Normal) and address space 1 (SMM) frequently have identical generation numbers.
     
     Because struct kvm_vcpu_arch only stores a single GVA, GFN, and generation counter without an address space identifier:
     
         An MMIO access cached in SMM (e.g., GFN 0xFED40000 with gen = 4) matches in normal mode where gen is also 4.
     
         When the guest exits SMM, vcpu_is_mmio_gva() bypasses normal MMU translation because vcpu_match_mmio_gen() returns true.
     
         RAM or device registers in normal mode are treated as stale MMIO, returning invalid data and trapping OVMF in an infinite polling loop.
     
     The Upstream Fix Patch
     
     To resolve the collision while preserving the fix for SMM memslot
     invalidations, as_id must be stored and verified as part of the cache
     key.
     
     Why This Fix Satisfies Both Requirements
     
         Prevents Cross-Address-Space Poisoning:
     
         If an entry is cached in SMM (mmio_as_id = 1), returning to normal execution (kvm_arch_vcpu_memslots_id(vcpu) == 0) causes vcpu_match_mmio_gen() to fail immediately, regardless of what numeric value generation holds in either address space.
     
         Maintains Valid SMM Invalidation:
     
         When the guest is in SMM and an SMM memslot update occurs, kvm_vcpu_memslots(vcpu)->generation increments. Subsequent lookups in SMM detect the mismatch against vcpu->arch.mmio_gen, satisfying the original fix for the write-protect fault warning.
     

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 334962398566..ea3908ca051c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1000,6 +1000,7 @@ struct kvm_vcpu_arch {
  	unsigned mmio_access;
  	gfn_t mmio_gfn;
  	u64 mmio_gen;
+	u8 mmio_as_id;
  
  	struct kvm_pmu pmu;
  
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 87a5e085ef4e..0eb11f2bd8bd 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -375,11 +375,13 @@ static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
  	vcpu->arch.mmio_access = access;
  	vcpu->arch.mmio_gfn = gfn;
  	vcpu->arch.mmio_gen = gen;
+	vcpu->arch.mmio_as_id = kvm_arch_vcpu_memslots_id(vcpu);
  }
  
  static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
  {
-	return vcpu->arch.mmio_gen == kvm_vcpu_memslots(vcpu)->generation;
+	return vcpu->arch.mmio_as_id == kvm_arch_vcpu_memslots_id(vcpu) &&
+		vcpu->arch.mmio_gen == kvm_vcpu_memslots(vcpu)->generation;
  }
  
  /*
@@ -390,7 +392,8 @@ static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
  
  static inline void vcpu_clear_mmio_info(struct kvm_vcpu *vcpu, gva_t gva)
  {
-	if (gva != MMIO_GVA_ANY && vcpu->arch.mmio_gva != (gva & PAGE_MASK))
+	if (gva != MMIO_GVA_ANY && vcpu->arch.mmio_gva != (gva & PAGE_MASK)
+		&& vcpu->arch.mmio_as_id != kvm_arch_vcpu_memslots_id(vcpu))
  		return;
  
  	vcpu->arch.mmio_gva = 0;


############## patch 2

Resetting mmio_gen on SMM boundary transitions ensures stale entries do not linger across SMI/RSM context switches.

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index f623c5986119..6f673b650ed2 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -130,6 +130,8 @@ void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
  	}
  
  	kvm_mmu_reset_context(vcpu);
+	vcpu->arch.mmio_gen = 0;
+
  }
  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_smm_changed);
  
>KVM tags the per-vCPU MMIO cache with a memslot generation so that a
>memslot update invalidates cached MMIO information.  Both the fill and
>validation paths use kvm_memslots(), which unconditionally selects address
>space 0, even when the vCPU is running in SMM and using address space 1.
>
>Commit 56f17dd3fbc4 ("kvm: x86: fix stale mmio cache bug") added the
>memslot generation to the cache key so that a memslot update could not
>leave a stale entry valid.  When commit 699023e23965 ("KVM: x86: add SMM
>to the MMU role, support SMRAM address space") added the SMM address space,
>these helpers were not converted to use the active memslots.
>
>Consequently, an update to the SMM memslots can leave an entry from the old
>SMM address space apparently valid after the vCPU returns to the normal
>address space.  A guest can then cause an access to valid RAM at the same
>GFN to be returned to userspace as KVM_EXIT_MMIO.
>
>Completing that exit through the VMM's RAM address space writes the backing
>page without going through KVM's write-tracking path.  If the page backs a
>nested EPT table, KVM can continue using shadow translations derived from
>the old contents.  The WARN_ON_ONCE() in kvm_mmu_write_protect_fault()
>catches this invalid cache and memslot combination.
>
>Use the vCPU's active memslots when caching and validating the entry.
>Memslot generations are unique across address spaces, so the generation
>also distinguishes the normal and SMM views.  This matches the MMIO SPTE
>cache, which already uses kvm_vcpu_memslots().
>
>On an unpatched current-mainline kernel, a regression test that fills the
>cache in SMM and updates only the SMM memslots fails the intended RAM write
>and triggers the kvm_mmu_write_protect_fault() warning.  With this change,
>the same test completes the RAM write without a warning.  The x86/smm_test,
>set_memory_region_test, and memslot_modification_stress_test selftests also
>pass.
>
>The Linux kernel CVE team has assigned CVE-2026-99082 to this issue.
>
>
>Affected and fixed versions
>===========================
>
>	Issue introduced in 4.2 with commit 699023e239658e62da6f42f47d31b54788521ec1 and fixed in 6.6.160 with commit a63f79d9da9468952396af73e1e53330845cf876
>	Issue introduced in 4.2 with commit 699023e239658e62da6f42f47d31b54788521ec1 and fixed in 6.12.114 with commit 7fd4e64f4bbc8c35ae8f0d2a1fb5b77a76d5b4fd
>	Issue introduced in 4.2 with commit 699023e239658e62da6f42f47d31b54788521ec1 and fixed in 6.18.58 with commit 2566780c684c9c21241d409d790087c73070f312
>	Issue introduced in 4.2 with commit 699023e239658e62da6f42f47d31b54788521ec1 and fixed in 7.2.12 with commit e792a9ace39d2812a5b342a1987186c7bc653204
>	Issue introduced in 4.2 with commit 699023e239658e62da6f42f47d31b54788521ec1 and fixed in 7.3 with commit b3e6212dea2e4328a841ceb37f377583176dc735
>
>Please see https://www.kernel.org for a full list of currently supported
>kernel versions by the kernel community.
>
>Unaffected versions might change over time as fixes are backported to
>older supported kernel versions.  The official CVE entry at
>	https://cve.org/CVERecord/?id=CVE-2026-99082
>will be updated if fixes are backported, please check that for the most
>up to date information about this issue.
>
>
>Affected files
>==============
>
>The file(s) affected by this issue are:
>	arch/x86/kvm/x86.h
>
>
>Mitigation
>==========
>
>The Linux kernel CVE team recommends that you update to the latest
>stable kernel version for this, and many other bugfixes.  Individual
>changes are never tested alone, but rather are part of a larger kernel
>release.  Cherry-picking individual commits is not recommended or
>supported by the Linux kernel community at all.  If however, updating to
>the latest release is impossible, the individual changes to resolve this
>issue can be found at these commits:
>	https://git.kernel.org/stable/c/a63f79d9da9468952396af73e1e53330845cf876
>	https://git.kernel.org/stable/c/7fd4e64f4bbc8c35ae8f0d2a1fb5b77a76d5b4fd
>	https://git.kernel.org/stable/c/2566780c684c9c21241d409d790087c73070f312
>	https://git.kernel.org/stable/c/e792a9ace39d2812a5b342a1987186c7bc653204
>	https://git.kernel.org/stable/c/b3e6212dea2e4328a841ceb37f377583176dc735

-- 
Do what you love because life is too short for anything else.
https://samifar.in/

