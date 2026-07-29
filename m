Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200447CA91
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326870; cv=none; b=QFuE7xxDQXw6YJEJuhg3JjUKFOc8AvHJiE2/SDGt4lATmc7waioEGyXlIykY0p8ExLX3cjSu+NFjmZiN5ligy9rnve1ldtmElFrlporY+BXB2OpLrybg92LkGCYtS+FmhQuDo12NGC24oZ42V7vjxaa6pX7ZSWijGOZXSLiIdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326870; c=relaxed/simple;
	bh=WCzra9lAjE/UNBLl8ktL0sQe9sxCI/7POWGw/Z2Tgos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+CsnAurXr/AngN9kyKxyCvwUcQnNMBk3aIpiiR1SjH++iMydf8DYPiXpI+fXPAgxmveSYxCTxU6oKHOnR3vdvUDnwfiUG6r8RBHBJgWlYQEU4l8adviarZ9jUudj8n0z0V9YQldVZT9Djb94hDWf5bm/rU2+C/EGqXGWmYP0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhgl77x7; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhgl77x7"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-cbb92a1213fso221736a12.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326868; x=1785931668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17CsgCdLrjv6bh5C/KKp5JjzHzr2Ra+7+GSbGZ8H4xY=;
        b=rhgl77x7mMlggoygA2Esmj+K6wLm8iU02qD8iPM7xhaMWA6Gm7Nm4AzORj8Shl+qnd
         C6RN5a/fn9UrP/OTehVFP+MBYn37YOsrP3Vw9E0X7XOkmhRJZtX+m+Pn6bINzoL6SI6V
         /ANhfmNOvNUpxI2d5b1LfGn8u2sFnXmHoGY7gkuzJfQmmY+VUpgB4DsqAVnO8L6tzhNr
         +/BPhvcIXUz1ae5RsagbpMe9QnI55sMdlSpj1Em12rotzSOyAPTBzIwqhzsNDnFDyUo5
         36oDBBlnfiT0/bGj8v10wCYdXzXB7A+UqTk8eIf0c+hf/VlytwptxCBLc0pwmrz35pA3
         8VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326868; x=1785931668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17CsgCdLrjv6bh5C/KKp5JjzHzr2Ra+7+GSbGZ8H4xY=;
        b=S1+vxnV0c6p4tBFinUnS66yKv1ceTPzASON/8l7M8jf7EGcGjcGwE72pIKQlGw7gm+
         NQiVqjtagsb+ehXIuQrgMxL+uGwKN9zn1apih0MeVaQPqAceZCaQ1BT3sDuyQH/f456P
         m5aKM36nx51n6C77PJ8EvPtjVvHxGg525amAjGa+XHsU9t617td4hpWSe+FS2B7fRxpq
         E6hPDUYz70zHIynt7nbbcd/R6lsE/usgwA8s1NgUZDuggYK2A+JXNecttZr0ZvlN3JBp
         swIqekpRp7tXIuYe+24NmEbxGZ17xoVqNSKrWPRYkDFKwM4gGjPoDswz/TTXGF4Le22v
         uE3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrnUwpjSvdzGGWd6RFPRkDfPgBWNUBs7MWVCnKJWBViF/zeY5V0qWDXCqU9kCvoyb6PSXIk3u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywuqVv9EIW0PE569CHtwDRfNuBN4np56HJyBq+2zsMvk5LmgUA
	oiBHd4yWUOegt5bmozmXi6pVD7qguOYgFG5DcDSn6jmXxon6pO1M+ztD
X-Gm-Gg: AR+sD12/Ts9xtxFCARmm+erAX63kCnRW6242KL5tDGjr/GRfqUGSTlixDddE1jgn2cs
	PKVJY4bvYRWliMrMh5s+or+VNgpqr0Yo7vojTjG4knCAgwNHeVme6dTmt+h2rEmsGC8/VK3EUWe
	xkuTVw+QK673PdItBBofnpWSJHizUxnC1X4CG1qs4a6YpEpkoSulNs0pXIv+IfK9TNoJ/yr531P
	uZ8F9aIZhr1CO4Z/aRIAlggfSdihctUSMFg9adySNo/ET314jTHh0WPHLhJ7F2vbARLeFl3UHsp
	YUAEmVIbWwbDXVN3Tctk27J8HrAwBSH278KuOpyWm+M9H6iTTiH75MVVuRi0J5z4S9YcO55Cset
	Rdav9rMH/7ffauHWo+qLNQOEfKzbUgmud/RUoz7QTDB3Y+DhH7jNP6FS0YTfTYDwKk1U+PESugJ
	bUvp1d7t/7HZY7uMAyIskwDDVGgS34j3d//yez+cgpllcXAVpMzy6PXx+1+ri9ZyGZknqsBCLy1
	8zB2Fktbh0AzQ==
X-Received: by 2002:a05:6a00:1d8b:b0:846:7507:4e07 with SMTP id d2e1a72fcca58-84e9332c2d6mr6938425b3a.39.1785326868402;
        Wed, 29 Jul 2026 05:07:48 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055133sm1309570b3a.18.2026.07.29.05.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:48 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	stable@vger.kernel.org,
	Bingyu Xian <shanbeeyoo@gmail.com>
Subject: [PATCH v3 3/3] RISC-V: KVM: Widen G-stage fault address to gpa_t
Date: Wed, 29 Jul 2026 20:07:33 +0800
Message-ID: <20260729120733.829457-4-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729120733.829457-1-shanbeeyoo@gmail.com>
References: <20260729075230.743030-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fault_addr in gstage_page_fault() and the fault_addr parameter of
kvm_riscv_vcpu_mmio_load/store() are unsigned long.  On RV32 with
Sv32x4, guest physical addresses are 34 bits, so a 32-bit unsigned
long truncates bits 32/33 at two points:

  - reconstruction: fault_addr = (trap->htval << 2) | ... is evaluated
    in 32-bit arithmetic, dropping bits 32/33 before widening;
  - the MMIO handler call: even with the local widened, the handler's
    unsigned long parameter narrows it back to 32 bits, aliasing
    accesses above 4 GB into the low 4 GB.

Widen fault_addr to gpa_t end to end: the local in gstage_page_fault(),
the (gpa_t) cast before the <<2 shift, and the fault_addr parameters of
kvm_riscv_vcpu_mmio_load/store().  The handlers' internal uses
(run->mmio.phys_addr is __u64, kvm_io_bus_read/write() take gpa_t) are
already 64-bit, so no further changes are needed.

Also in preparation for sharing a common struct kvm_page_fault across
architectures, where fault_addr is gpa_t.  No functional change on RV64.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/include/asm/kvm_vcpu_insn.h | 4 ++--
 arch/riscv/kvm/vcpu_exit.c             | 5 +++--
 arch/riscv/kvm/vcpu_insn.c             | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_insn.h b/arch/riscv/include/asm/kvm_vcpu_insn.h
index 350011c83581..a5c50dd4a884 100644
--- a/arch/riscv/include/asm/kvm_vcpu_insn.h
+++ b/arch/riscv/include/asm/kvm_vcpu_insn.h
@@ -38,10 +38,10 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu, struct kvm_run *run,
 				struct kvm_cpu_trap *trap);
 
 int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
-			     unsigned long fault_addr,
+			     gpa_t fault_addr,
 			     unsigned long htinst);
 int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
-			      unsigned long fault_addr,
+			      gpa_t fault_addr,
 			      unsigned long htinst);
 int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 6c8530b9f29e..28cf9b27bb07 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -17,12 +17,13 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	struct kvm_gstage_mapping host_map;
 	struct kvm_memory_slot *memslot;
-	unsigned long hva, fault_addr;
+	unsigned long hva;
+	gpa_t fault_addr;
 	bool writable;
 	gfn_t gfn;
 	int ret;
 
-	fault_addr = (trap->htval << 2) | (trap->stval & 0x3);
+	fault_addr = ((gpa_t)trap->htval << 2) | (trap->stval & 0x3);
 	gfn = fault_addr >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index f09f9251d1f0..6506411a3f78 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -371,7 +371,7 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu, struct kvm_run *run,
  * Returns < 0 to report failure and exit run-loop
  */
 int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
-			     unsigned long fault_addr,
+			     gpa_t fault_addr,
 			     unsigned long htinst)
 {
 	u8 data_buf[8];
@@ -494,7 +494,7 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
  * Returns < 0 to report failure and exit run-loop
  */
 int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
-			      unsigned long fault_addr,
+			      gpa_t fault_addr,
 			      unsigned long htinst)
 {
 	u8 data8;
-- 
2.54.0

