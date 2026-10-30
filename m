Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386742;
	b=U2kZb/gXMgbzjVIBWtnrcdaCjRmmUZY+6I/TeEnf8lEVJ8+DiuYWWkdpGhI8GDTQcyK+
	 J/vTYxitGROo58+X9e0DBLB88QG+v8qy/WMwoBSeK+z4H8GfwUGY7oKmlOsxdZEKa/Std
	 wIZWJWVz3qAC0gowWrQeyInbI40xN3VXmYME72fedq5R5qc20B/EI9IWR9YeYjxY8XDog
	 s3vASjXTlRU9uCmRlLJUpn64t2KWzUU08oKyE4PD7DLXmajcMKY5hf3GhK7Lt6bfbGjWT
	 qBxOMLaQRAyKBuN+YdsSrK5Ik19ayrRMbijJOcJ8ZmiopYO8yHVKlzFhN0BSn6XeG8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386742;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-USESPAMBG:From:To:Cc:Subject:Date:
	 X-OQ-MSGID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mw96Q007DUPAQeKT8Ptwo3yABVaVeFnZ+TFfC0JmVJ8=;
	b=3pBKNawn3BfHXjkGLVL9mhEV02reNLYXgdXgGb1JHRSrrOasNsltrdRcdfHEhT9TRY7A
	 0v1Bg1mIu5F/NDZSLybb12aEnoV1IB/xMvj7Di47b67ID6SkaIzzND4oPhIdwat8JjCaq
	 NzoY7jo5X3zd7CHMR8P72gT2jRamAO5eSrjqVoLlCmLT0i7kbF5rCQrYJy38xKLfM62i5
	 WHgkbU3qDaXy1tUgZ36xeb5doPcrbcXepHrDghjSaDr5rNLA1RUvGQ7C8VGbHel41MmFn
	 /wTIOFQOi68HUfBvYBL6MRCHDFbwD80JzhmwXTYVEuV4TRQRbw/GKlwIXkAzjmqAw/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cyyself.name;
	spf=pass smtp.mailfrom=cyyself.name;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yMDR21xP;
	arc=none smtp.remote-ip=162.62.58.69
Received: from out162-62-58-69.mail.qq.com (out162-62-58-69.mail.qq.com [162.62.58.69])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EF606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 309EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yMDR21xP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793386730; bh=mw96Q007DUPAQeKT8Ptwo3yABVaVeFnZ+TFfC0JmVJ8=;
	h=From:To:Cc:Subject:Date;
	b=yMDR21xPnfephXqAxRXDTKMF0f3O1t4bQN2gVuUDIo6viJU566JwQSPmE/pncAFwa
	 SvgRZpbWDZXmn3O/e5IRmD60yrM3kaJ8DIW3eZeThfz0158r+nMwfx+nx8vEq3ofLf
	 TzApOeLWcJC3rppCMCxe8TsQa6W3+9K8NAuxG8oA=
Received: from cyy-pc.lan ([240e:37c:221f:3500:33ac:ff07:4262:aa6f])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id EAC2CE97; Sat, 31 Oct 2026 02:58:44 +0800
X-QQ-mid: xmsmtpt1793386724t5a8cffea
Message-ID: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
X-QQ-XMAILINFO: MDJWyUmJdVqKyq6UzhUWUXe+4k6nld/Qa5hXvirgeodHiPQTqx5ZGiPGbDNjZX
	 4qgBqJX7f5EYtOIGRcELlt5Hu7bZsdvzNlHnZi/R9D0bt8PMemZzy67lQIoYR8QQwNclLy4UbYLv
	 4jU6O+u/VH0cvmaBHCZe8eBAjqjd2x49hPuLybfqomJq7EEaCIxShYmBj0q+oL5svh8QUmbDvKPT
	 nCvSLFhLySRNnDW4EFHt0b/z+ewKh/1/dN3UpDzI4EMSIIpaB1vXGOV0lf29SuN2z9VNyxGk9d9e
	 pFLmJM2W9S1BwVoT9VWOGgKI8czYvBkXH8lie1HnO4NMunCByORRYn/tuslVApvIiXXO5CEKn2W9
	 F28keu9gS1gEKEODEH1d/fkqeD6SLBofCPpTZRKyje4vqClWdi2UO0S6wxpVW36o06hKrXla2FyE
	 lydfhHbkztV5R0hUYJdDunm8Q7Eqyv5/ahZhzAZmh/gqxXMBlWYDJcNUHIhUsE4dMg3mbJLgLKuO
	 JaY9YaTX/AMcsmrJRG7DacKsHQuSuJsQAq3gc5iJD7WWRB/PwDXNgrIyGbFeVrUPSdcAI9536qHl
	 vJeCSNqIuWT9sDZVmdtONJj8WfAjz1WTHtpwJs8BVS0mqUfnAx6N73wJTUoKc2kmCaJNpXqejTXs
	 j/uAtOTRr8Ve+/X+kAu+TofzdTeSsKi9ynS3rlyw1f49eT4Z5smOxqVzTJWqa9nJwj7GshoWCHnl
	 YyjRp8MDgTZNgz5kcWETZgpQS7ycJZ4oI3BiXgYdNF7pctMl1bP0ti3CK4WvlIrjuGBwIfXB5VZB
	 dZphAlVex5klG+9gNA3rdAmyvVlZ20WzwsYocIM84gBvTsvod/viMgjWJyDrQmUriEN87IdVNWrS
	 ltOB2ifHzWtCXzn8q94zbrgLejWikVtOEcQ2QXES/KSVC9yF3tl8qY91cSqHgD2xqqLhv4xds6Xa
	 4PbxkxsOFACNC3Vz0y0a2KwxQaQlnzJOlQ01bTMC7x+RqiHaSNzeXG6L5/IUL53OiRwjtrzHPPqk
	 9ndeif1q2Y1zdx8Fx9r0xAt9AIL0N3/AicUjVU4Q4g8fPVwRdvloiJX3ro9xwlLhjV0DJEsBAwqv
	 8+8P9zqo5zfLEBCAUJBlfNSFvTzg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-USESPAMBG: true
From: Yangyu Chen <cyy@cyyself.name>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Fix G-stage page table memory leak on VM destroy
Date: Sat, 31 Oct 2026 02:58:36 +0800
X-OQ-MSGID: <20261030185836.4018167-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.53.0
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

kvm_riscv_mmu_free_pgd() tears down the G-stage with
kvm_riscv_gstage_unmap_range() over the whole guest physical address
space. That function looks up each address with
kvm_riscv_gstage_get_leaf(), which walks down to the leaf PTE, and then
clears only that leaf. kvm_riscv_gstage_op_pte() frees a page table only
when it is called on a non-leaf PTE, which never happens here, so every
page table below the PGD is leaked when a VM is destroyed. With 4 KiB
mappings this is one page per 2 MiB of guest memory that was ever
mapped, plus the upper-level tables.

The leaked pages are not slab, vmalloc or page cache, so they show up
only as unaccounted used memory. On a SpacemiT K3 host, a workload that
creates and destroys tens of thousands of small VMs leaked 0.5-1 MiB per
VM and ran the host out of memory after about 20,000 VMs.

Add kvm_riscv_gstage_unmap_all(), which calls kvm_riscv_gstage_op_pte()
with GSTAGE_OP_CLEAR on every PGD entry. That recursively clears all
leaf PTEs and frees each page table below the PGD. Use it in
kvm_riscv_mmu_free_pgd().

Tested with a reproducer script that builds a minimal KVM host kernel
from a source tree and boots it under QEMU 11.0.2 (TCG, rv64 with H,
Sv57x4 G-stage). Its init creates 10 VMs one after another. Each guest
writes one word in every 2 MiB of an 8 GiB RAM region (anonymous memory
with MADV_NOHUGEPAGE, so 4 KiB G-stage mappings) and then shuts down,
so each VM needs 4096 last-level page tables (16 MiB). MemFree lost per
VM, after one warm-up VM:

  before:  16415 kB  (RESULT: LEAK)
  after:    1636 kB  (RESULT: OK, noise)

The bug was found while investigating the host OOM, and the fix and
reproducer were written with the help of an AI coding assistant
(Claude). The analysis, fix and test results above were reviewed by
the submitter.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Cc: stable@vger.kernel.org
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
How to reproduce:

The reproducer script is at
https://gist.github.com/cyyself/23abb87a8ad9ee8c64ce03cca78669fc
and needs riscv64-linux-gnu-gcc, qemu-system-riscv64 and cpio. Run it
from the top of a kernel source tree:

	$ cd linux
	$ /path/to/kvm-riscv-gstage-leak.sh

It builds a minimal riscv64 KVM host kernel (allnoconfig + KVM) into
.kvm-leak-build/ and boots it under QEMU (TCG, -cpu rv64,h=true) with a
static test program as /init. The test creates 10 VMs one after another.
Each guest touches one page in every 2 MiB of 8 GiB of guest RAM, so it
needs 16 MiB of last-level G-stage page tables. The test then prints how
much MemFree each VM leaves behind. The first run takes about 1.5
minutes, mostly kernel build; reruns take about 10 seconds.

Without this patch:

	10 VMs, each touching one 4 KiB page per 2 MiB of 8 GiB guest RAM
	MemFree 2037664 -> 1873512 kB: 16415 kB lost per VM (a leaking kernel loses ~16384 kB)
	RESULT: LEAK

With this patch:

	MemFree 2054080 -> 2037716 kB: 1636 kB lost per VM (a leaking kernel loses ~16384 kB)
	RESULT: OK

The exit status is 0 for OK, 1 for LEAK and 2 if the test could not
run. IMAGE=<path/to/Image> boots an existing kernel instead of building
one. That kernel needs CONFIG_KVM=y, CONFIG_BLK_DEV_INITRD=y and
CONFIG_DEVTMPFS=y.

I also tested VMs that select Sv39x4, Sv48x4 and Sv57x4 through
KVM_CAP_VM_GPA_BITS, and four VMs with mixed modes alive at the same
time, destroyed one by one while the remaining VMs kept running and
were checked for correct guest memory contents. With this patch, no
memory was lost in any mode and no guest data was corrupted. Without
it, every mode leaked about 16 MiB per VM.
---
 arch/riscv/include/asm/kvm_gstage.h |  2 ++
 arch/riscv/kvm/gstage.c             | 22 ++++++++++++++++++++++
 arch/riscv/kvm/mmu.c                |  3 +--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1b77..90ec9e0b34b1 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -80,6 +80,8 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 				  gpa_t start, gpa_t size, bool may_block);
 
+bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage);
+
 bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
 
 bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base_gfn,
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index e5002cb9cbef..c912cdc2021f 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -456,6 +456,28 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 	return flush;
 }
 
+/*
+ * Clear every G-stage mapping and free all page tables below the PGD.
+ * kvm_riscv_gstage_unmap_range() only clears leaf PTEs and leaves the
+ * page tables in place, so it cannot be used to tear down a G-stage.
+ */
+bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage)
+{
+	u32 level = gstage->pgd_levels - 1;
+	pte_t *pgd = (pte_t *)gstage->pgd;
+	unsigned long i, page_size;
+	bool flush = false;
+
+	if (gstage_level_to_page_size(gstage, level, &page_size))
+		return false;
+
+	for (i = 0; i < kvm_riscv_gstage_pgd_size / sizeof(pte_t); i++)
+		flush |= kvm_riscv_gstage_op_pte(gstage, i * page_size, &pgd[i],
+						 level, GSTAGE_OP_CLEAR);
+
+	return flush;
+}
+
 bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end)
 {
 	int ret;
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 371fccaf9df0..87838a0f6bb9 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -784,8 +784,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 	write_lock(&kvm->mmu_lock);
 	if (kvm->arch.pgd) {
 		kvm_riscv_gstage_init(&gstage, kvm);
-		flush = kvm_riscv_gstage_unmap_range(&gstage, 0UL,
-			kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), false);
+		flush = kvm_riscv_gstage_unmap_all(&gstage);
 		pgd = READ_ONCE(kvm->arch.pgd);
 		kvm->arch.pgd = NULL;
 		kvm->arch.pgd_phys = 0;
-- 
2.53.0

