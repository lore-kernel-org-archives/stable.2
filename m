Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402A370AEB
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846803; cv=none; b=HrKBAurceP2guH7NxMPydhufmyfIfZs8q61+J6ML2S7tU0VgQSurcx1TT+8K5Vrmmi55o/O77jAsxvzu4yDeheXL+9xU7BC1Gv6WJFMHB26g+320Es0NlJ8PyPkB9l1hZI4pe8spMiO6YqzAPTsfblzk1h0Z5fYwj0PDnRlSU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846803; c=relaxed/simple;
	bh=idO556sDrm3ldFuEUC4lIp2Ss0pdAz8zQvcAGhvLrxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJ6lAFkfNlZRrHUc2WMYRTSOr3LSQsBbHOfDbcs89PNmzXJ0xDS6R5uoBHyJ9Gx5bsLe81QbRS3qKX5q69HE2eQrVHX5VU3S6tPMdDTbEziXsjkl8iEF4OPMpEwMwokmnD7SQu5hj15NnVTSC2gkiqUf4p5j1dzefuDRZIpUU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUDFcq26; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUDFcq26"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4158522a91.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785846801; x=1786451601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yHn45zO1GjaznES41N0dea4F7Pab8fcItqkDUu6RnHE=;
        b=WUDFcq26TMXQURnhBq5iRhLoQ2KdeqQlqdUk+MJa+SK7qZ0i8C1ZTVGxyHFbF7SLFS
         HTvHf+OZ+OAwAnoxwW5STQ0+1pVyNFUDnTYtYcD70RDMv2M58HxDV/d1AEc5n/HCoVDw
         UDSA47Yy6ReUiuL7q84xbZDpkZ8ymIC038q+EAG5ovP7PpvLhnks8qqfjzDVj3Loh8/i
         6xsmIghY0sqRw0OA6+sr2ecmXFzXG7o8YcjuEyeQm5CwqhN+4frSZ1TANztIgCk9Rx50
         8STvUvxJW2gAgkl64ys5qqCoidugw7juf243WHFwAg0S99Jm3H4bXcM+PsPfIA/ctHqk
         MKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846801; x=1786451601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHn45zO1GjaznES41N0dea4F7Pab8fcItqkDUu6RnHE=;
        b=oWQtxgRTpNKQr+q1yn3j2I6e6YsihCKiLxEgCzlKJeUQdq7dPVw5zmzeP6JBZEtsv6
         bpjQqhNNqY5pMWChoZK6K5VLvcqN+WuIy01JA9s39u0+TOUZ92gBMhTPL6sYaENCywcw
         c5GjAI1XOmtWhIn9c6Lf/GEjgUbd2CmGBSecE0Dve30T3GjadXV7K7gHbJlq7ZuoS0EN
         6wIwGG6KBJRiESytQt0yaulASZm/FA95IKZsOpoA/Z+WRDpy2fg1u8XtLLpcXSAxdbrq
         Qb++Fk2cE3RU8aAWHyZptHZpWpsDolCs0jYlNnXjeyHr+k1aABsXG45At1sKEO6il+Zs
         544Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqta/0kjmTEEmm7lJbRSnZFSRCbHC3Qiaohw4Iiko619aN1aFjEH5jAZx3QkzmUkhO7/4/Z3VY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4MPO7tOZi43xKd9wqhrTpmfJ9QDQoSLUd/u2n/ybLMnEzErpS
	db4XL3CjaqpFKIHNpyKKW3PqglWRTD7VZClYaleA3EUD6ecloaO28YvV
X-Gm-Gg: AR+sD12PKnaNLERC27FaU2U+E33QpmAUiabIgRDF5w1bTR5nIcfwi/ZfjiBBwAI4Etc
	qwPA19wLdpXn2HpGbg8JWB1/nl71nb4AYzsP2l/6lEu6aAl61ATTmZgHatTW+Z8Ji5KR8PULx2I
	sUn3gfeiMMqlzgVHsNQYp5UBljqfg5yeCAdjIJDlERWIMxrSL2MqojzLBFlK2ablXiCml6Qjkx4
	8kkTESd6NTQG9fMhBcBwNw58qMyH2xkMdK9jaJKIiHHLvU2ZXonPIaqrfefMK0cPf7vBM+3tDIA
	lfoPIRnHWI31ZaZu63HySqG1jvuDhO8TsN4TPB0GDMtxlGDO+wjTJNuo7cCQiSnDEyCY5RswbrZ
	TtzAEKbQ2MtfHdvqVXuQaKFPl8gqRYtzZxpi8oFN7u6V50AMF8xO0O6eeFrBNO8Nx5Nx/94AzMT
	QWGq0cWbYxBxdCJePBMZDEGFC3LTE+uZ95KUYC4OojkmRu6oqhm9Na3cHz6qpRHfwX0bk4TzmjV
	MrFDJxHvctOUWHzUeN3YpeCOp52pDUrewM9ngJ4NUC26A==
X-Received: by 2002:a17:90b:2692:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-38fbc437d5dmr12397243a91.11.1785846800876;
        Tue, 04 Aug 2026 05:33:20 -0700 (PDT)
Received: from chcpu15.cse.ust.hk (191host116.mobilenet.cse.ust.hk. [143.89.191.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b0f82csm3246001a91.2.2026.08.04.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:33:20 -0700 (PDT)
From: Qi Zhang <marsy12010123@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kai Huang <kai.huang@intel.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Qi Zhang <marsy12010123@gmail.com>
Subject: [PATCH] KVM: x86: Protect virtualization-enable VM walks with RCU
Date: Tue,  4 Aug 2026 20:32:42 +0800
Message-Id: <20260804123243.2213854-1-marsy12010123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

Protect the vm_list walks in kvm_arch_enable_virtualization_cpu() with
RCU, publish and remove VMs with RCU list operations, and wait for
pre-existing readers before tearing down a VM.

The change that introduced kvm_usage_lock replaced kvm_lock with a
dedicated usage-count mutex when enabling virtualization.  Because
vm_list mutators do not take the usage-count mutex, this left the x86
walks without lifetime protection.

During CPU online, the hotplug thread can load a VM from vm_list.  A
concurrent close of the last VM file can then remove that VM and destroy
its vCPUs before the hotplug thread dereferences the stale VM or vCPU.
Reacquiring kvm_lock from the CPU-hotplug path would restore the lock cycle
that the same change fixed.

KASAN reported:

  BUG: KASAN: wild-memory-access in kvm_arch_enable_virtualization_cpu+0x25f/0x870
  Read of size 4 at addr dead0000000000f0 by task cpuhp/3/31
  Call Trace:
   kvm_arch_enable_virtualization_cpu+0x25f/0x870
   kvm_online_cpu+0x1a/0x50
   cpuhp_invoke_callback+0x291/0xfd0
   cpuhp_thread_fun+0x256/0x4a0
   smpboot_thread_fn+0x287/0x6c0

Fixes: 44d174596260 ("KVM: Use dedicated mutex to protect kvm_usage_count to avoid deadlock")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
---
 arch/x86/kvm/x86.c  | 6 ++++--
 virt/kvm/kvm_main.c | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47cb9eba113b..811014d04d40 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13140,7 +13140,8 @@ int kvm_arch_enable_virtualization_cpu(void)
 
 	local_tsc = rdtsc();
 	stable = !kvm_check_tsc_unstable();
-	list_for_each_entry(kvm, &vm_list, vm_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(kvm, &vm_list, vm_list) {
 		kvm_for_each_vcpu(i, vcpu, kvm) {
 			if (!stable && vcpu->cpu == smp_processor_id())
 				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
@@ -13192,7 +13193,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 	 */
 	if (backwards_tsc) {
 		u64 delta_cyc = max_tsc - local_tsc;
-		list_for_each_entry(kvm, &vm_list, vm_list) {
+		list_for_each_entry_rcu(kvm, &vm_list, vm_list) {
 			kvm->arch.backwards_tsc_observed = true;
 			kvm_for_each_vcpu(i, vcpu, kvm) {
 				vcpu->arch.tsc_offset_adjustment += delta_cyc;
@@ -13211,6 +13212,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 		}
 
 	}
+	rcu_read_unlock();
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..92df17710881 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1198,7 +1198,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		goto out_err_no_debugfs;
 
 	mutex_lock(&kvm_lock);
-	list_add(&kvm->vm_list, &vm_list);
+	list_add_rcu(&kvm->vm_list, &vm_list);
 	mutex_unlock(&kvm_lock);
 
 	preempt_notifier_inc();
@@ -1260,8 +1260,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
 	kvm_destroy_vm_debugfs(kvm);
 	mutex_lock(&kvm_lock);
-	list_del(&kvm->vm_list);
+	list_del_rcu(&kvm->vm_list);
 	mutex_unlock(&kvm_lock);
+	synchronize_rcu();
 	kvm_arch_pre_destroy_vm(kvm);
 
 	kvm_free_irq_routing(kvm);
-- 
2.43.0

