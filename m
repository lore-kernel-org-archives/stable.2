Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B4471263
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145717; cv=none; b=gxfIzR5j45O0d7BJMDF1k1s+4MIgeo36hD7iNIUMXEVsH0oy41L8kepvepTnV2kr+Ewm6JAlClAoma1OthyPLdf8oanY88r4lsfW7Ur6qDRrc75JuyX1bz/Kwx7M5dLN64+huuidUGUFEdYsaPinS83xA2B9TMcxn7KhXm0wmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145717; c=relaxed/simple;
	bh=5+Mp4TeDYq2o2TK3O/vdVC//j8jljTpTyZBFtmJvflw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iojmA1Yk1jEDiDhcSCVnrE0jT0WmKVhjiKdZnXc2KjxVuLZc2jv82LFg4evWoPexZARwUb7Skaxh+3nz3nFrhpU8WgE2rER0HLssuAs8ZspowGLRB6Q0QncRLxScNk9PV5eHSF/1nJcewmBKBZxw2d4YInXkBlFAwg16U7MwOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYjhTfry; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYjhTfry"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e987b4a710so2631475ad.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792145715; x=1792750515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vf6qHtCJHYPPUhzxjpIczur0NsiTKA4BX6nz592iMDQ=;
        b=BYjhTfryOnMsL2nJc/pxdvotLlKoa8WSJ+zs5hTyG6HElTUdnmUC/9W2iPP9/AyP15
         CSJpET4eNB6wRyfZe/08CAI6I+18ukOQo7bAeBFfFKurYs6pOcl6yBUvnbopE/fZmdKo
         n4SkE1maVnDEvl54LJQnTmNXTKu8IXMzi7JMqdLHDPPIvO8CDS75My3tdiJqQJt1OcMv
         XoSlq/DDEGupu701v6DxsiaxCNCYp1z3k+GiLErlXfUXGjxzvMU+OC0H5OQ7tdc+mrsD
         svobjx+8d/Vjx+vpaWCYQI1mB7Rsl4VjHvsSnqh5x372jVpxOZk1xMyAoInhhK2z22e5
         V4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145715; x=1792750515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vf6qHtCJHYPPUhzxjpIczur0NsiTKA4BX6nz592iMDQ=;
        b=daXWcu6q0DIf8aKoVyUKkqB0Hk0zgiLAwxWLCGqkXbWyFTywrWfBjp7kDID3xLkoFX
         Y0CnmweX0Xw4Tm8VeRsd68Y7LA95ute2oifMYg7TyLBk9H7Z/PWuVur2wSGiD4izQmDz
         gntQBToXvzKRxUd+fjvhZF9nJf4nrNp11pSUwqHrPpeJOww8m8bMeKbAgifAoJHUbI22
         M5UmViZpjAVHd7PyTOWfDLlRjs5TO2VGQ3/A70/uZ+7dhA07ihgpmu3/6HhoA4pVh8Cb
         UroP601r4KUmXmI4ccryfUHlU5W4VETOFfQrMd7wmvurr48pIRyc74Mbrtlv4jXqN7e9
         RYjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLfgd8oUmhgRsRNX0PLMjJHtXNAiV1DudBbzxuWLGZoOyOoDqus34Jg/j+94GZvJuWcK7HuLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkWi+ZG4L384LjeI9hjhEiAVVGz2IBJ2ORzKwIFhAKalxpX5Ge
	95RFFhh/J+gp22Ovp7cfvac1lhpZrlE6ElYsW1Mfu6X2+2Bdl2PTiryq
X-Gm-Gg: AYBFou2As8K4oDaA9hZyXQkg3PGUpxoydNFoNF868EMJClBH2PCeup/xfw2SBarT55M
	5flD9mT0rkQbcRz0zO8kgErRsP5vVqlopPd5udTmahmexkr4nX765RCOoP4cnjHDWnRkQNTj+8K
	TKbY3l6nY82p3EnhddzIIrLaxNLE1CtnmQ9fsBuJw80gVZUEF2vYsFUvVTxwfKQe3eOzKbtKCej
	KLD9mtCoyGVxl3PFcssVdv6vT66aoh6HuqY8+z57qQbo4gae4T8Rj/ZEeWaj1q9BJKY31erUJvw
	ofzV2euRLrDbWGmfOch/8akhTo5+qrhfq9xjortA+r779elyZVooNEKgfKnTuFrRUn1ilTuMNXt
	s0snaG4u/rQoF3YU39qZR/MC8zv7wZ6+GiVSonwDQRejTX+8U88Y29WRXxYqG4x8oGElBYNtqVh
	WxBZVUL1epmU3HEvFQEuy4tD3CtGatHyF2M/3rb5BG5gHJJfsgbalbf8lMqrlF/9E6a/T9QB4lK
	7JyI7x6AbCj4a9LtZR+og==
X-Received: by 2002:a17:903:2f8b:b0:2df:b004:df28 with SMTP id d9443c01a7336-2e9772b0555mr20367255ad.35.1792145715452;
        Fri, 16 Oct 2026 03:15:15 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e85fd1dsm7876465ad.49.2026.10.16.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:15:13 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: anup@brainfault.org,
	atish.patra@linux.dev
Cc: tjytimi@163.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@linux.dev,
	pbonzini@redhat.com,
	seanjc@google.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] KVM: riscv: Set Accessed bit in dirty-log write fault fast path
Date: Fri, 16 Oct 2026 19:14:58 +0900
Message-ID: <20261016101458.221648-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_riscv_mmu_dirty_log_write_fault_fast() considers a leaf with W
and D set already handled, even if aging has cleared its A bit.
On hardware that faults when A is clear, the fast path returns
true without setting A and skips the slow path that would set it.
The guest retries the same store, but A is still clear, so it
faults again. This repeats indefinitely, preventing the guest
from making progress.

Host reclaim or page_idle can trigger this while dirty logging is
enabled, potentially hanging vCPUs during live migration.

Require _PAGE_ACCESSED in addition to W and D before treating the
fault as handled, and set A along with W and D. The existing
cmpxchg loop retries if aging changes the PTE before the update.

Fixes: 7705be59eb2d ("KVM: riscv: Fast-path dirty logging write faults")
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
Testing:

On a HiFive Premier P550 (EIC7700X, which traps on clear A/D bits),
run:

dirty_log_perf_test -v 3 -b 256M -i 3

While the test runs, repeatedly mark all system RAM idle through
/sys/kernel/mm/page_idle/bitmap.

Before the fix, the test did not complete its first iteration in
over 11 minutes, with lock_stat showing about 16k read-side
mmu_lock acquisitions per second from the fast path.

After the fix, all three iterations complete, each taking about
29 seconds under the same aging workload.

 arch/riscv/kvm/mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 78a1826c466d..042d1e3b3547 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -591,14 +591,15 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
 			dirty_marked = true;
 		}
 
-		if ((pte_val(old_pte) & (_PAGE_WRITE | _PAGE_DIRTY)) ==
-		    (_PAGE_WRITE | _PAGE_DIRTY)) {
+		if ((pte_val(old_pte) &
+		     (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) ==
+		    (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) {
 			new_pte = old_pte;
 			ret = true;
 			break;
 		}
 
-		new_pte = pte_mkdirty(pte_mkwrite_novma(old_pte));
+		new_pte = pte_mkyoung(pte_mkdirty(pte_mkwrite_novma(old_pte)));
 
 		if (kvm_riscv_gstage_try_update_pte(&gstage, ptep_level, gpa,
 						    ptep, old_pte, new_pte)) {
-- 
2.52.0

