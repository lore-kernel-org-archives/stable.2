Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637584;
	b=LoJpja6/3m9stJGy6JP88xKWzAv05tTEh9Rl6KpKFHWwtoGTt8R2CFxBO2jgHrxU03ie
	 2Nkx9Rh9NoRZxMegKY/TyumnmhHwadZ3yHePmgXOgZE7ks8V5f47eSahIEOeI7g9aBBZ4
	 XZVH1NmyRxyoqzeYtO/0pVVBB/CcKEDQ1rU0CIy8taYGfktnO2vAr4ZuZdMpuPqVu8bBH
	 trpvAhb/kLNsf48B+RwDlbORIyHIX86nBYmljG0xMpRXL6ELlwJMoRTA/Jmwiy2m4w/zu
	 Ca7iA//EmJreTs6a9WaaXBC17a6hGT2g6ZSiBWSgnLdHLHivyn6ABYsJiNIsEeYJ0Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637584;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DejVP3KnOQCw446A7rW8sW1DdnpwryfI3tnU/3cckYc=;
	b=o0aO/xwqeTtwJXkVe6ced2xzGdtvfGDz3c3+IaG4doY3nC7nNP+eFLJu3+1gW9eUceLu
	 FAWNc2527ot5cllGPbSTyNOWQXehDiiTrK+K9DNxsdo9YQjRuCDZjvu1etYBsD2elq2Wo
	 pllpvqpvahHFA3t898PkeMAm5whz2pBC8bYDJyhoekKlxftP67T3xUypFAZdh6qervWwR
	 Whe4hccmbuQ58EaQ4nybbNvbNnf0nFGChNxZ6MjDRbWZNmOAwQVJB0UwLZlJDPKCi/oJR
	 8/qV8snNLs7cM4b3wDaOFxTwMDRP8Tj23G1DalCNp6kUiLnpIMBClpwSbMzmTQRWdUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K7HDombO;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52058606A31A;
	Thu, 22 Oct 2026 02:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52058606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K7HDombO
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792637573; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DejVP3KnOQCw446A7rW8sW1DdnpwryfI3tnU/3cckYc=;
	b=K7HDombO92t7FztwmrYMJx2aLWg66iDabeqziplSln86brrtfQ31QcoYDr56JpdTfImgfewQi+xfgJb04ILwzSdk8xhTi8dE1y5DslISaxX3OTScitgyQpPvE8RJzRz/4zY1/Dixak+XaJ1qJeKNO+YDwXIgMfflr6/0kVYxkkI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=jinyue.li@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XDHoSgz_1792637568;
Received: from aa8c952a0f58..(mailfrom:jinyue.li@linux.alibaba.com fp:SMTPD_---0XDHoSgz_1792637568 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Oct 2026 10:52:53 +0800
From: Li Jinyue <jinyue.li@linux.alibaba.com>
To: kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	wang.yechao255@zte.com.cn,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Fix double free of the split page cache
Date: Thu, 22 Oct 2026 02:52:48 +0000
Message-Id: <20261022025248.477832-1-jinyue.li@linux.alibaba.com>
X-Mailer: git-send-email 2.25.1
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

kvm_riscv_mmu_free_pgd() frees pgd_split_page_cache after dropping
mmu_lock. It is reached from kvm_arch_flush_shadow_all(), i.e. from the
MMU notifier ->release() callback, which can run concurrently for the
same VM from exit_mmap() and from mmu_notifier_unregister() in
kvm_destroy_vm(). The stage-2 teardown is serialized by mmu_lock and the
second caller finds kvm->arch.pgd already cleared, but both callers then
go on to free the cache, and kvm_mmu_free_memory_cache() does not
tolerate concurrent callers:

  BUG: KASAN: double-free in kvfree+0x28/0x32
  ...
   kfree+0xc4/0x428
   kvfree+0x28/0x32
   kvm_mmu_free_memory_cache+0x178/0x246
   kvm_riscv_mmu_free_pgd+0x20e/0x2b4
   kvm_arch_flush_shadow_all+0x1a/0x24
   kvm_mmu_notifier_release+0x36/0x7c
   __mmu_notifier_release+0x182/0x66a
   exit_mmap+0x7f8/0x8c4
   mmput+0x7e/0x2fc
   do_exit+0x57a/0x22b4
  ...
  Freed by task 15956 on cpu 3 at 8926.103524s:
  ...
   kvm_mmu_free_memory_cache+0x178/0x246
   kvm_riscv_mmu_free_pgd+0x20e/0x2b4
   kvm_arch_flush_shadow_all+0x1a/0x24
   kvm_mmu_notifier_release+0x36/0x7c
   mmu_notifier_unregister+0xf0/0x328
   kvm_put_kvm+0x32a/0x7b8
   kvm_vm_release+0x3a/0x50
   __fput+0x330/0x974

The cache only feeds huge page splitting from VM ioctls, so it does not
need to be released together with the page table. Free it from
kvm_arch_destroy_vm() instead, which runs once after the MMU notifier
has been unregistered, as arm64 and x86 already do. The error path in
kvm_arch_init_vm() is not affected because the cache cannot have been
filled at that point.

Found by syzkaller.

Fixes: 6c7f75ef096a ("RISC-V: KVM: Add the split page cache for ioctl context")
Cc: stable@vger.kernel.org
Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>
---
 arch/riscv/kvm/mmu.c | 2 --
 arch/riscv/kvm/vm.c  | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 3e955d808743..74dece22d172 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -798,8 +798,6 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 
 	if (pgd)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
-
-	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }
 
 void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb76..a7e1b518257a 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -54,6 +54,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_destroy_vcpus(kvm);
 
 	kvm_riscv_aia_destroy_vm(kvm);
+
+	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.25.1

