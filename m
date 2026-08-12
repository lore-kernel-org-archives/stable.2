Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4736212D;
	Wed, 12 Aug 2026 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515807; cv=none; b=gOWypJJ83CrCPj63cBJ6Z9T1WTVpZ6DKw2popG98z++AHA9jFp7LeZYqU2gKbwsOi4HuHrChyk1ZHkUoO7w1Ge9dsR9xyAam21Xsd4iG022vmDfHnuRwaf7pFX21nbFEXjAeuSsQuTqQzcs1z3tJOClp/vt2By1cckuZautgWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515807; c=relaxed/simple;
	bh=qkuq5vZsF5wjDrh2OYpRp5eiPsClWjXvSY81f8/SBTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKFGUt8/AoMgGPKMLiuFRk3tUnyGde7fN6enlGCJjauhkQIJAt2VtJnKITZShRYtzK5mK1AcXMzGTo6DBv6m4MIoORky3n4MetMF1KqcGq8FDJIejO1HVDn78TI4CCLD6Qz4j2XGzoViVJsz3Hdmz+9aL4nR4HwNoQ4Bauy2Afc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redrisc.com; spf=pass smtp.mailfrom=redrisc.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redrisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redrisc.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07452478|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00740962-0.00245956-0.990131;FP=12855025378607845755|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=shaoqing.qin@redrisc.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ik.PRue_1786515773;
Received: from thinkpadx1.localdomain(mailfrom:shaoqing.qin@redrisc.com fp:SMTPD_---.ik.PRue_1786515773 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 14:23:08 +0800
From: Shaoqing Qin <shaoqing.qin@redrisc.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shaoqing Qin <shaoqing.qin@redrisc.com>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: mm: mark KASAN vmalloc shadow mappings as valid
Date: Wed, 12 Aug 2026 14:22:50 +0800
Message-ID: <20260812062250.181-1-shaoqing.qin@redrisc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_KASAN_VMALLOC, KASAN allocates shadow memory for vmalloc
mappings on demand. After installing new shadow PTEs, KASAN calls
flush_cache_vmap() for the shadow address range.

RISC-V uses flush_cache_vmap() to mark newly valid kernel mappings. If
an access subsequently faults, the early exception handler checks this
mark, executes sfence.vma when required, and retries the faulting
instruction.

However, flush_cache_vmap() currently recognizes only vmalloc, module,
and vmemmap addresses. KASAN shadow addresses are outside these ranges,
so creating a KASAN vmalloc shadow mapping does not mark it as newly
valid.

On implementations without Svvptc, an invalid PTE may remain cached
after the PTE has been made valid in memory. This caused a store page
fault in __memset() while KASAN was unpoisoning shadow memory for a DMA
atomic pool vmap mapping. The page table dump showed that the PTE in
memory was already valid and writable.

Recognize the KASAN shadow range and mark these mappings as newly valid,
allowing the existing fault-time sfence.vma and retry mechanism to
handle the stale invalid PTE.

Tested on a single-core RISC-V FPGA without Svvptc using Sv48 and
CONFIG_KASAN_VMALLOC=y. The kernel boots successfully through DMA
atomic pool initialization after this change.

Fixes: 503638e0babf ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Shaoqing Qin <shaoqing.qin@redrisc.com>
---
 arch/riscv/include/asm/cacheflush.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index c2b0a2928f06..056aaf894644 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_CACHEFLUSH_H
 
 #include <linux/mm.h>
+#include <asm/kasan.h>
 
 static inline void local_flush_icache_all(void)
 {
@@ -57,7 +58,9 @@ static inline void mark_new_valid_map(void)
 static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 {
 	if (is_vmalloc_or_module_addr((void *)start) ||
-	    (start >= VMEMMAP_START && end <= VMEMMAP_END))
+	    (start >= VMEMMAP_START && end <= VMEMMAP_END) ||
+	    (IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
+	     start >= KASAN_SHADOW_START && end <= KASAN_SHADOW_END))
 		mark_new_valid_map();
 }
 #define flush_cache_vmap_early(start, end)	local_flush_tlb_kernel_range(start, end)
-- 
2.53.0

