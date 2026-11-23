Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433684;
	b=luqLbEVPchsqveim6Oxj69x+6J8+WfN9wHPIaEcq0CNyI4USy2QWwH+gK2EO+NKiaUXj
	 qrYOw+IwowVDiYHO+MFvpqTDAF+qsz/sv2ZLQTyjOagqFRhUfVM17J+tnd25KHWLz0tOr
	 SsBgQTIXeD3zNB2cRfrrcsjriPJLm0pCFsmJy+oy4CL5C4wrXUGzL1Ioy/V66c8CBh/4c
	 JZbM/dxbF9oBVnyKNRp2Dn+jWZJhmABKlzKNTbg3CTadUtySqeYnV69FIqLJZgVneFX8R
	 5USZvdBqcm+HuqFxWZrlTLfj2XdcTz6fqoujJIqi310lMyg7+Kml67jGzFPPZbUdyyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433684;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fmxcbhG1chT0b9F6QCQYXCbAO+nUWqbQ4u1W0a/I5sc=;
	b=EVz3ZFYYjy6FIa6a6cI5x3nozb3HjSpm3sv4fmsA5NOpsFw4Y1sZGNaTCVH+q1jUxoEm
	 6XQ5fyEw7oAZGtBvtWto2dCfAKaNPI3X19NqJ8NPxj8OUuZ7oHme2CRG6zZNPiCFkJp/s
	 QnTSic/2kDj+4Gx8gUy7C1T0jTINYGYcieSkWKAox4aYLBBZpeEHNEPHGzq8IeCT2HMg9
	 nRmw2UrIixXqmThxbzXXgnkVa2lqqslWe2YhCBVQveoST0Ygh6u8XcY7foVHaREsKQDdJ
	 jtJsOGInXbJ0G4UHU8YudjE+6pgMSRynnli1z25OnF4EaWbqfjfvfQUNxM8Io1XMRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EJMipN2q;
	arc=none smtp.remote-ip=91.218.175.82
Received: from mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56A606A33F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F56A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EJMipN2q
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GFdOLbAuUR9hfwY/LXg7YohW2tjrVa6l2cMuco/EPYU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795433681; v=1; x=1796038481;
 b=EJMipN2qWlyGuNiXFej4NzeZIFFlv//5wKRgeR75WdOZ8XYgAGUZb1I4M+3TukEc/GAAojt2
 KV0ItrVp7sDbIoRuljsxgyun/twxcfpPvGanlG0q9/UmUOa/8gCtCzFYWPXwyymIybXSSt0ilyl
 kZFz4VWJEgsATXViJ9pTm4Bc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1ec6cd2606eb83c4;
	Mon, 23 Nov 2026 11:34:41 +0000
X-Mizu-Trace-ID: 1ec6cd2606eb83c4
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty ring is full
Date: Mon, 23 Nov 2026 11:34:33 +0000
Message-ID: <20261123113435.1170711-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123113435.1170711-1-fuad.tabba@linux.dev>
References: <20261123113435.1170711-1-fuad.tabba@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-faulting can map a dirty-logged page writable, which pushes it to
the vCPU's dirty ring. KVM_RUN exits with KVM_EXIT_DIRTY_RING_FULL
before the ring overflows, but the pre-fault loop never checks it, so
one call can push more entries than the ring has free, which trips the
WARN in kvm_dirty_ring_push() and overwrites entries userspace hasn't
harvested. On x86:

  WARNING: arch/x86/kvm/../../../virt/kvm/dirty_ring.c:225 at kvm_dirty_ring_push+0x7a/0xd0
  Call Trace:
   make_spte+0x2cc/0x450
   kvm_tdp_mmu_map+0x5e1/0x7f0
   kvm_tdp_page_fault+0x12c/0x1b0
   kvm_mmu_do_page_fault+0x181/0x250
   kvm_arch_vcpu_pre_fault_memory+0x136/0x1d0
   kvm_vcpu_pre_fault_memory+0xcf/0x180
   kvm_vcpu_ioctl+0x455/0x770

Stop the loop once the ring is soft full, with the check KVM_RUN makes
before entering the guest. Return the pages already processed, or
-ENOSPC when there aren't any, since a retry can't succeed until
userspace harvests and resets the ring. s390 has the ioctl but no ring,
so give kvm_dirty_ring_check_request() a stub.

The check also sets run->exit_reason to KVM_EXIT_DIRTY_RING_FULL. On
arm64, KVM_RUN completes a pending MMIO exit only if exit_reason is
still KVM_EXIT_MMIO, and on riscv KVM_RUN does the same for its MMIO,
SBI and CSR exits. If a pre-fault stops on a full ring while such an
exit is pending, the next KVM_RUN doesn't complete it and the guest
repeats the instruction that caused the exit. Userspace can avoid that
by completing the exit with KVM_RUN before pre-faulting.

Fixes: bc1a5cd002116 ("KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to pre-populate guest memory")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/api.rst | 9 +++++++--
 include/linux/kvm_dirty_ring.h | 5 +++++
 virt/kvm/kvm_main.c            | 5 +++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d9..89eb6be9bc6e3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6544,6 +6544,7 @@ Errors:
   ENOENT     The specified `gpa` is outside defined memslots.
   ENOEXEC    The vCPU has not been initialised (arm64).
   EINTR      An unmasked signal is pending and no page was processed.
+  ENOSPC     The vCPU's dirty ring is full and no page was processed.
   EFAULT     The parameter address was invalid.
   EHWPOISON  A poisoned host page was encountered.
   EOPNOTSUPP Mapping memory for a GPA is unsupported by the
@@ -6588,7 +6589,9 @@ case, the ioctl can be called in parallel.
 
 When the ioctl returns, the input values are updated to point to the
 remaining range.  If `size` > 0 on return, the caller can just issue
-the ioctl again with the same `struct kvm_map_memory` argument.
+the ioctl again with the same `struct kvm_pre_fault_memory` argument.
+If that fails with ENOSPC, the vCPU's dirty ring has to be harvested
+and reset first.
 
 On x86, shadow page tables cannot support this ioctl because they
 are indexed by virtual address or nested guest physical address.
@@ -8957,7 +8960,9 @@ Therefore, the ioctl must be called *before* reading the content of
 the dirty pages.
 
 The dirty ring can get full.  When it happens, the KVM_RUN of the
-vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL.
+vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL, and
+KVM_PRE_FAULT_MEMORY on the vcpu will process no more pages until the
+ring has been harvested and reset.
 
 The dirty ring interface has a major difference comparing to the
 KVM_GET_DIRTY_LOG interface in that, when reading the dirty ring from
diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
index eb10d87adf7d5..729615ae0cf4d 100644
--- a/include/linux/kvm_dirty_ring.h
+++ b/include/linux/kvm_dirty_ring.h
@@ -60,6 +60,11 @@ static inline void kvm_dirty_ring_push(struct kvm_vcpu *vcpu,
 {
 }
 
+static inline bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
 static inline struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring,
 						   u32 offset)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f1407..ac8b94a386e4a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4461,6 +4461,11 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 			break;
 		}
 
+		if (kvm_dirty_ring_check_request(vcpu)) {
+			r = -ENOSPC;
+			break;
+		}
+
 		r = kvm_arch_vcpu_pre_fault_memory(vcpu, range);
 		if (WARN_ON_ONCE(r == 0 || r == -EIO))
 			break;
-- 
2.47.3

