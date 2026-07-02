Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F34A2E34
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000303; cv=none; b=Hx50Cb20wBOvjgNK2rkjt8Rg4/wF1nKyMwLdqYKY8Vf36v95Ntn63gPCPXIkguQGuxmAO8AYh9senQqiDDHdglHscglMk2/zIxcs5GjD0/k9e3h5SvOZCZfBzhQRiInLRNkKqsTmEIWpaWHeoBL0x9bjI83CIj/MNuyl1XtT2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000303; c=relaxed/simple;
	bh=YaF7ZICnb8hJAzY+mnZWaQj5hjNczNjCsUZqTHZ6QjM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pOZWQXoTboTxdJVuGxRkrTtKRuEjBjozYr312HT/5OBMtQJ4i9mCQU9rlLsCtUBOwJNHY8wqfhrDKSvrtNHZ7UKmdiRh0qQSK2dmWkt5pm8N6NFgu0b9piojs5WrMhrBbct2p6t/Rzih+vBGoNQv4SQxPM1YAYPlsrQjSq7IKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJJWawf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJJWawf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE6D1F000E9;
	Thu,  2 Jul 2026 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000302;
	bh=+XySq/Lhl69f/TAp/yd89SpUsdqY0zZKZ8PymumIVgE=;
	h=Subject:To:Cc:From:Date;
	b=VJJWawf0upK7eVgp1EEP9CH3X1Y+C+d66127n3CbkoF18zW995FZ5zWsU9qqVPz+8
	 5RngsQuWC0XA9l6De89UCFoqjjpYcT386ScfkHNquVnPDMmPSRb633iBchhQPIH6s0
	 L0pO3aEZ6S6uyP+2TlfdaVOLuWaIzF1ORwQ+loN8=
Subject: FAILED: patch "[PATCH] riscv: kfence: Call mark_new_valid_map() for" failed to apply to 6.6-stable tree
To: wangruikang@iscas.ac.cn,pjw@kernel.org,yaneti@declera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:51:52 +0200
Message-ID: <2026070252-appetizer-unclip-195c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8d6c8c40e733b3fcaf92fed0a078bba2f6941a3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070252-appetizer-unclip-195c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d6c8c40e733b3fcaf92fed0a078bba2f6941a3b Mon Sep 17 00:00:00 2001
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Tue, 3 Mar 2026 13:29:46 +0800
Subject: [PATCH] riscv: kfence: Call mark_new_valid_map() for
 kfence_unprotect()

In kfence_protect_page(), which kfence_unprotect() calls, we cannot send
IPIs to other CPUs to ask them to flush TLB. This may lead to those CPUs
spuriously faulting on a recently allocated kfence object despite it
being valid, leading to false positive use-after-free reports.

Fix this by calling mark_new_valid_map() so that the page fault handling
code path notices the spurious fault and flushes TLB then retries the
access.

Update the comment in handle_exception to indicate that
new_valid_map_cpus_check also handles kfence_unprotect() spurious
faults.

Note that kfence_protect() has the same stale TLB entries problem, but
that leads to false negatives, which is fine with kfence.

Cc: stable@vger.kernel.org
Reported-by: Yanko Kaneti <yaneti@declera.com>
Fixes: b3431a8bb336 ("riscv: Fix IPIs usage in kfence_protect_page()")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Link: https://patch.msgid.link/20260303-handle-kfence-protect-spurious-fault-v2-2-f80d8354d79d@iscas.ac.cn
Signed-off-by: Paul Walmsley <pjw@kernel.org>

diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index d08bf7fb3aee..29cb3a6ee113 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -6,6 +6,7 @@
 #include <linux/kfence.h>
 #include <linux/pfn.h>
 #include <asm-generic/pgalloc.h>
+#include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 
 static inline bool arch_kfence_init_pool(void)
@@ -17,10 +18,12 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 {
 	pte_t *pte = virt_to_kpte(addr);
 
-	if (protect)
+	if (protect) {
 		set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~_PAGE_PRESENT));
-	else
+	} else {
 		set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT));
+		mark_new_valid_map();
+	}
 
 	preempt_disable();
 	local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d011fb51c59a..6c14ed7a5613 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -136,8 +136,10 @@ SYM_CODE_START(handle_exception)
 
 #ifdef CONFIG_64BIT
 	/*
-	 * The RISC-V kernel does not eagerly emit a sfence.vma after each
-	 * new vmalloc mapping, which may result in exceptions:
+	 * The RISC-V kernel does not flush TLBs on all CPUS after each new
+	 * vmalloc mapping or kfence_unprotect(), which may result in
+	 * exceptions:
+	 *
 	 * - if the uarch caches invalid entries, the new mapping would not be
 	 *   observed by the page table walker and an invalidation is needed.
 	 * - if the uarch does not cache invalid entries, a reordered access

