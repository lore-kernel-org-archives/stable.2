Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690E371D11
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961649; cv=none; b=tGRhoT2uGUpDD8p47prdAQoxF50BoSsfhmRkTCsFhagxzXs2L5i3qK+tDRcNskCdgpBIqddoc5rVSsm/ZZ5LeOMWUoktjf9/fXhAfTnJHPg9SjDcfVgRCXNTd1aaAtRRRKVQZkTMDIvH7W0uT+3TvDI1i9iP+cYyfAbhR+fjxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961649; c=relaxed/simple;
	bh=OcY+7/0P/gvQi8VSadBXXsgqQ9SByM7tSMYjbn8eB/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4wD0BKSF2sQsKcKoo3m8MEVwNrOQcsJEbBvZ4WkSgxjtL8bYmxTimIahHGJUDChUJImc+2m6EB0Z8TS49MHNVaLOu+lfU0ra3HUB/BPIUxXX1fyJ8PWShACmdtwMQ4j6H32J8hwKsQALwDFMKzcynTKOCoBGjrsZ143XkRtT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvsU/IRT; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvsU/IRT"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-14b1b157591so145976c88.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961639; x=1791566439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=izTe3vFuNEXuKkViQhMtb+ZI5BaXwvWzbJ/LmOaSmrg=;
        b=cvsU/IRTvs9XYNhpctzW/G1BDBplbwu4gk/DBuMbyRWB5ND2YW4F5lmYT2DnchvroS
         YnbdtNGXYCnsqioCqAZaXY1nUZGvGH5rlXOGIpg/J9DPjqUCuiDhAlVAPj8SamXiMRPp
         5KfeglHOTgAKfTeIfhyw9lJdgKJ1mvG24UvU12RAszxxYrJuebY+PjR0LA653Hz9wmZn
         hQsb00UpUV/i29cftwDYb7OsDyttFjtpJb5dnLV3MayItMDjw7hoIntBtBRoYDegJhtO
         Q5lbPRxU+9jqZfPpijdfnaycCJezx2wU5zEsN2JRngHfv6lAQ1/FyJPFyiwoSlDsW1tH
         svzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961639; x=1791566439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=izTe3vFuNEXuKkViQhMtb+ZI5BaXwvWzbJ/LmOaSmrg=;
        b=bCFYaQv8jYU/tzYHyJ4gNRXrpX3dWFvn77FQ4xhwqaWiPVMsmLUxuW+gcfiKgzJSsK
         nHyT9kG/cTJOZ2klznuXvAu1GI0J+GkUSqzeaEYQaO4OkWJMHZw61fZfj+W1G8PwG0a6
         8EhrIKkhQA9fTDltCmKzSpkkxM04Vyxc73mQkhwKQUU5Hg5nruETZxg0VxHOcDwzk5UA
         4JWBnLxkGCk+Kkgq3bv5rvcSzlUjh0wFh/5xPPbvEi0FAaMzMYHBV0VWeWvmzL4Qhpuz
         /QVrdHu9eVQ9z9Dhsu3gbPrpB0KRRjMHitfyNT9AOQPFHin48iPyXJimEd1tnXwjUL1U
         mYhg==
X-Forwarded-Encrypted: i=1; AKwUvBxWy2k46ZDFIj9/NT4XwUbjE0tEuJanoy9H3/lw8dshWZE496NUBdZoCS0abKNYNKgOA/AZGN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKdCYMcvSEl9wpCzsKHXr3iW8CC30tv+y31tUX/haRuDnamDPe
	A9zNgSnjnJnm4MS2s7nb3ZiuCBOWZN925OK9KnFDRN3wAng0QK/x6oSf
X-Gm-Gg: AYBFou0RriAWY06LRjyZVsgvAhy3TWu0OKhv3fikWv2T9E7M+6cxc89UJrV4gFm7XPp
	1LpTV4GmOuYQoE1l/1tQgE5kkQXghBp6InJemcrHbQzuL4BAs3S/n2vGTzIJ+udJUgKHEen/1+G
	ZyNp+qyhut90N4oDszEAofxFJWR3IR0Zt0MVuC6N3fyJNbFptOKTcIPLxDcKi11YGrtsSvpdIX5
	Fj5q92E6dc+jNqXrhludxHeCzEZmHYLDUbAyjreFcTf+ZQQ45r10kRnQFXYZprfDXS4hONDfvgw
	lp0XgxiyGface3Whxd3WiwSjWxkXSIYgzSIEjd4s4o3VvQjSy7jpY9cUhjWbVQ3L4JYAGFAfeRV
	rTe9iDu/cJAZ0lceS1Ia6XZtBrNTayOkdm3qo4v210K/IquiNcAe6DOCJNDYNKj5Jyhc5d9J64W
	oLR+eLknHozmmOhqsap1RxKDRCwJWxacBWxuwmLuB8qtLSe15sOIo4kBh47GIgVCncf0EnFpM3N
	532VTDa/sH0d8Xmvi0YqQ0rbKXbeeMCC+XzEALfIQ6IuRXQEES9ZKoI+qLXl/IiyktmOvE=
X-Received: by 2002:a05:7301:e101:b0:33e:6714:3945 with SMTP id 5a478bee46e88-34f150658f9mr5329374eec.2.1790961638951;
        Fri, 02 Oct 2026 10:20:38 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f2dfbbsm7816854eec.10.2026.10.02.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:20:37 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kai.huang@intel.com,
	marsy12010123@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: x86: Protect virtualization-enable VM walks with RCU
Date: Sat,  3 Oct 2026 01:20:25 +0800
Message-ID: <20261002172025.3402416-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
---
Changes in v2:
- Rebase onto current kvm-x86/next; keep the same RCU lifetime fix.
- Clarify the scope of the Sashiko finding: the hotplug update of
  tsc_offset_adjustment and the vCPU-load read/reset are unchanged by
  this patch. RCU protects VM/vCPU lifetime; it does not synchronize
  those field accesses. A separate synchronization change would need
  its own analysis and review.

Link: https://lore.kernel.org/r/20260804123243.2213854-1-marsy12010123@gmail.com/ [v1]
Link: https://lore.kernel.org/r/20260804125109.B20491F000E9@smtp.kernel.org/ [review]

 arch/x86/kvm/x86.c  | 6 ++++--
 virt/kvm/kvm_main.c | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1705e7be46ec..6f57374dbb16 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9664,7 +9664,8 @@ int kvm_arch_enable_virtualization_cpu(void)
 
 	local_tsc = rdtsc();
 	stable = !kvm_check_tsc_unstable();
-	list_for_each_entry(kvm, &vm_list, vm_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(kvm, &vm_list, vm_list) {
 		kvm_for_each_vcpu(i, vcpu, kvm) {
 			if (!stable && vcpu->cpu == smp_processor_id())
 				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
@@ -9716,7 +9717,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 	 */
 	if (backwards_tsc) {
 		u64 delta_cyc = max_tsc - local_tsc;
-		list_for_each_entry(kvm, &vm_list, vm_list) {
+		list_for_each_entry_rcu(kvm, &vm_list, vm_list) {
 			kvm->arch.backwards_tsc_observed = true;
 			kvm_for_each_vcpu(i, vcpu, kvm) {
 				vcpu->arch.tsc_offset_adjustment += delta_cyc;
@@ -9735,6 +9736,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 		}
 
 	}
+	rcu_read_unlock();
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9fff2f4bf2f1..750ee2f8c720 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1217,7 +1217,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		goto out_err_no_debugfs;
 
 	mutex_lock(&kvm_lock);
-	list_add(&kvm->vm_list, &vm_list);
+	list_add_rcu(&kvm->vm_list, &vm_list);
 	mutex_unlock(&kvm_lock);
 
 	preempt_notifier_inc();
@@ -1279,8 +1279,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
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

