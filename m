Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575E4BB5B8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446463; cv=none; b=KUdz4pU2vZsluMWzrXEahJ+5YijRMRvSEuWPuCWHwZOuXTTsAI6kaLe+RpT+hfdbcKgEtHiTzmESstDO1fl9KgpEv+bpqDWXU/hr3FWcDq2wAYGKaTS3ZSErxIke+1A92+2CdN2HcStJlNfLu5mmCZGnnteiovR624SVGJvF4ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446463; c=relaxed/simple;
	bh=z5nknTvTwu5D7utswemMmtOFOIYR2P8Nd/CDX6HW1DY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YfSQjipvaPbYhFtleoQ7TquNgtEAqNZavruIbmPTwByDx7bBfXlF3OIX53YAzAEyYVRmuguFepMT4fFxqMBJKRTBZkvoNXvir2TslyUu7Pkx19xZn1gqgcH2v+j165UfZzLxAW/1NKuz1h59/vMi8OmAhkPZUXh6lqQQMBR6V74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oh/8pKTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oh/8pKTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B021F00A3F;
	Thu,  3 Sep 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446453;
	bh=qAGhPtngs8oiViNziVec6Zrh0iJiXBhBP/gbZsOCqQQ=;
	h=Subject:To:Cc:From:Date;
	b=Oh/8pKTxGa3XVsOwDLhbN2O6MSnn4JwUSEsv2tAnsiQDpF+VmtfODNJf+H5MTiFXP
	 zvsztWMQwy91Mc/DgrTqXW6mOzJsY3lsLKqGXFQKqDXygWOQii39o2mgK4AWNyRtyn
	 CuTxW8PnpizBRHTzn58/TNlrOHlepTiUQXSwY+sE=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Fix PMU event info array size overflow" failed to apply to 6.18-stable tree
To: 2045gemini@gmail.com,anup@brainfault.org,naveed@digiscrypt.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:19:52 +0200
Message-ID: <2026090352-cage-storage-a216@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 735bc20c24187ca419c9d5e63860a54b91be34bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-cage-storage-a216@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 735bc20c24187ca419c9d5e63860a54b91be34bd Mon Sep 17 00:00:00 2001
From: Guidong Han <2045gemini@gmail.com>
Date: Thu, 30 Jul 2026 17:25:33 +0800
Subject: [PATCH] RISC-V: KVM: Fix PMU event info array size overflow

SBI PMU EVENT_GET_INFO stores guest-controlled num_events * sizeof(*einfo)
in a 32-bit integer. On RV64, num_events = 0x10000001 makes 0x100000010
truncate to 16. KVM then allocates one entry but loops over the original
num_events, causing out-of-bounds reads and writes. A nested guest
triggered:

BUG: KASAN: slab-out-of-bounds in kvm_riscv_vcpu_pmu_event_info+0xa4/0x142
Read of size 4 at addr ff600000074d46b0 by task init/1
Call Trace:
[<ffffffff8006471c>] kvm_riscv_vcpu_pmu_event_info+0xa4/0x142
[<ffffffff800690c0>] kvm_sbi_ext_pmu_handler+0xca/0x268
[<ffffffff8006779e>] kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
[<ffffffff8006008c>] kvm_riscv_vcpu_exit+0x48c/0x540
[<ffffffff8005ea0a>] kvm_arch_vcpu_ioctl_run+0x37e/0xc80
Allocated by task 1:
 __kmalloc_noprof+0x19e/0x4b0
 kvm_riscv_vcpu_pmu_event_info+0x72/0x142
 kvm_sbi_ext_pmu_handler+0xca/0x268
 kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
 kvm_riscv_vcpu_exit+0x48c/0x540
 kvm_arch_vcpu_ioctl_run+0x37e/0xc80
The buggy address is located 0 bytes to the right of
 allocated 16-byte region [ff600000074d46a0, ff600000074d46b0)

Store the shared-memory size in size_t and reject multiplication overflow.
Allocate the guest-driven array with GFP_KERNEL_ACCOUNT so it is charged
to kmemcg, and use __GFP_NOWARN to suppress allocation failure warnings.
Use kvcalloc() to allow vmalloc fallback and an unsigned long loop index
to match num_events.

Reported-by: Naveed Khan <naveed@digiscrypt.com>
Closes: https://lore.kernel.org/kvm/178345245327.72065.13249716450708539854@digiscrypt.com/
Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
Cc: stable@vger.kernel.org
Signed-off-by: Guidong Han <2045gemini@gmail.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20260730092533.1369531-1-2045gemini@gmail.com
Signed-off-by: Anup Patel <anup@brainfault.org>

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index f241cfb6eb3a..752f1014d633 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -12,7 +12,9 @@
 #include <linux/err.h>
 #include <linux/kvm_host.h>
 #include <linux/nospec.h>
+#include <linux/overflow.h>
 #include <linux/perf/riscv_pmu.h>
+#include <linux/slab.h>
 #include <asm/csr.h>
 #include <asm/kvm_isa.h>
 #include <asm/kvm_vcpu_sbi.h>
@@ -479,13 +481,14 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
 {
 	struct riscv_pmu_event_info *einfo = NULL;
-	int shmem_size = num_events * sizeof(*einfo);
+	size_t shmem_size;
 	gpa_t shmem;
 	u32 eidx, etype;
 	u64 econfig;
 	int ret;
 
-	if (flags != 0 || (saddr_low & (SZ_16 - 1) || num_events == 0)) {
+	if (flags != 0 || (saddr_low & (SZ_16 - 1)) || num_events == 0 ||
+	    check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) {
 		ret = SBI_ERR_INVALID_PARAM;
 		goto out;
 	}
@@ -500,7 +503,8 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		}
 	}
 
-	einfo = kzalloc(shmem_size, GFP_KERNEL);
+	einfo = kvcalloc(num_events, sizeof(*einfo),
+			 GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!einfo) {
 		ret = SBI_ERR_FAILURE;
 		goto out;
@@ -512,7 +516,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		goto free_mem;
 	}
 
-	for (int i = 0; i < num_events; i++) {
+	for (unsigned long i = 0; i < num_events; i++) {
 		eidx = einfo[i].event_idx;
 		etype = kvm_pmu_get_perf_event_type(eidx);
 		econfig = kvm_pmu_get_perf_event_config(eidx, einfo[i].event_data);
@@ -525,7 +529,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 		ret = SBI_ERR_INVALID_ADDRESS;
 
 free_mem:
-	kfree(einfo);
+	kvfree(einfo);
 out:
 	retdata->err_val = ret;
 

