Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259613BD653
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237281; cv=none; b=KAjT5Avokxh/R4PWUk4QZE6TtgX9Mzy4HWvSERlQoqpGyrzhq+9z771Tq+bQ9UVUTv8Y7umv6Ds6ZoP95/vfz4Co6BIuJ3kpwt+LftwDiNFgh6Iqplh4vnBFawRUxJQXKkcZkuh+zEhROQ7HrU+TE8tKIyq5UMN8vS4gUNXpoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237281; c=relaxed/simple;
	bh=iRkl3pQoS1G3AewbQwpmyHvMydRGnhwIEx5duYABjRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GRFtKmT2ZFYplKWAa62BHvJpZcB2yyqUOZAqElB33Usnvc9q6dYpw+Do25x0Ok67pP9N6O7fKtMaTSByupQKaEz/TuJnGXwBbip+FMM2zGIqEO9lNY91kE78Vt+16fTAk3jmVu3wOYNYQGF6P9KBSHECdSZsalp5m6yM8rhdrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P90q+FND; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P90q+FND"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-398e10200a6so450279a91.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790237278; x=1790842078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOvLdVAqIzEI0jpywFTRHK7Tdgrb3wuhoBjpWMIpUXc=;
        b=P90q+FNDA4WZ7lnx4dNATCeuz4jwMZNvAZpkWZoYgxacwN8dY8Z050aPWSuLGlfih9
         QGQa64P6JYmTQyhpaUbSvN00IQPgGEa3OGg6lf8LkkRvkmRcKRFYlHScTaCrVmWLKgJD
         iRyH/xd6GgN1Unb4p3JJqfxNadnKjKwaq5TBkb4GEImsW+jyfcSqpDkxDb4dcGmgCMXN
         I/3bbQVVQWlRKIVyJwfBXezWgV8d1PGnzikb1QFwKChEwKy6ECrcOdRIDOwDdzshuwVa
         bpQ6TfCZt5G7pdUfWPgGfvNvoUbmPBqy+LoOgaoa//Sh97OTvncVU9IMgZZWjE3Hx6Z4
         PppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790237278; x=1790842078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOvLdVAqIzEI0jpywFTRHK7Tdgrb3wuhoBjpWMIpUXc=;
        b=bStDJNB1SHXhgzZjfAWbPH1Q2h10MPOA/nlv9OLeOtEIHoozXzSeMeE6msKtQnnIgz
         jbXrS1fAPIPNDIXqqvthdLldZ7AFZmYf8dfgkGUxDjXRcY0y9DCEXAu0cS3jZ0AvF0yD
         fjAzPrT2zsFJyPeTdOguzHZ+Tle/l0MhU8jhkVQLmBtuO9WG3yIY8dcwejsShq8aoU3z
         Nr8akQcSCTB2owijigqSzBEZ+ixAz1hnCaV+CiNIfjhtKNxNF3nPzslCwjFI4M+AVbVY
         qEUSIYHLEUzrSPCvSF5FYhrB6wgZsZw7WMXvd+MZzOlhc1zbfwRDix3O/ImCdaXlYeLD
         Fh7A==
X-Forwarded-Encrypted: i=1; AKwUvBzDon6OY9J0wwyrLM82VUefJQk7mxC7GLpAqmCVP18e0bIKI3nR2tV9roCcTc/w5FEXT8GUqSw=@vger.kernel.org
X-Gm-Message-State: AFuF++nI0l90CkGJYOKqov0GAvhFvTlpPXGNfFEZPfw2MqI0BlQO+Ujk
	XlzYaL1VHuTxhTCARI2JQtKfd8vIWIEwp3+2YaAFsGvJTIhh527EQ+JC
X-Gm-Gg: AYBFou3c10RHYKDWDCiWstKmdGeaIMUrNui4o2Qvhs8CDHZRzGHEMlSHgNoQtFUdyf6
	1BapQ8F7sYUNakzVa6lqsXP7xdzMCE2is/OQkzcoF1Y4OtqO3dgyZexZGNA6EagFQsWJgs/fCbr
	yYFGVEOmp7rt5ySPIc9PXFEo+PWStqZ6MIVU/k2/LFMrerqdiR4GXrLKJEzm9NF3ENtEKOuFLQH
	IhN5da2Gc7dKrHeumTHubhUe11vnULIKii7twgtT8siJ9eG7i0a04w4x+oez4AiQ7JK7XkGOLO8
	U8ztPN9duQ7FdM8al1fVy+qTyye9+P+80MmX0rIxHJVL5OO2eQLPiv4YpRNKu6GyUo0xj1jFnIo
	eMyLmRM1HHZk7dAeUIQXZH39FTeYLEHjSQ2xbgg6LOJTdOekFJajfJVzLgnmV4EYnSxDoK+7WWh
	mDtffeFdfwVwnhKaVWdr3WKKvAyB2jmQXVe47igXOX8+zkTW21uE6D2y1cmIyqVSnZKUvsE5WmC
	G3F3x75nPFFB8gv1R1OLuB0MYFjZzgQIY5YZwwY
X-Received: by 2002:a17:90b:3c0e:b0:39b:92bb:9eef with SMTP id 98e67ed59e1d1-3a098ce1c3emr1521749a91.22.1790237278174;
        Thu, 24 Sep 2026 01:07:58 -0700 (PDT)
Received: from HXDQXTDYHN.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976cacbesm3418356a91.13.2026.09.24.01.07.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 01:07:57 -0700 (PDT)
From: Jinmeng Zhou <jinmengzhou22@gmail.com>
X-Google-Original-From: Jinmeng Zhou <zhoujinmeng@bytedance.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	feng.wu@intel.com
Cc: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmeng Zhou <zhoujinmeng@bytedance.com>,
	Guixiong Wei <weiguixiong@bytedance.com>
Subject: [PATCH] KVM: x86: Wake blocked vCPUs before offlining a CPU
Date: Thu, 24 Sep 2026 16:06:48 +0800
Message-Id: <20260924080648.51014-1-zhoujinmeng@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Posted-interrupt wakeup state is tied to the physical CPU on which a vCPU
blocks. CPU hotplug migrates sleeping tasks before KVM's CPU offline
callback, but the vCPU remains on the old CPU's wakeup list and its posted
interrupt descriptor still targets the old physical APIC.

If a device posts an interrupt after the old CPU becomes unavailable, the
wakeup notification cannot make the blocked vCPU runnable. The vCPU cannot
repair the stale notification destination because that happens only after
the vCPU is scheduled back in.

Add an architecture hook to KVM's CPU offline path and a corresponding
optional x86 vendor callback. After CPUHP_AP_SCHED_WAIT_EMPTY has migrated
tasks away from the dying CPU, have VMX set KVM_REQ_UNBLOCK and wake every
vCPU on that CPU's posted-interrupt wakeup list. The vCPUs then unblock on
online CPUs and the existing load path rebuilds their wakeup-list and
posted-interrupt destination state.

Fixes: bf9f6ac8d749 ("KVM: Update Posted-Interrupts Descriptor when vCPU is blocked")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/vmx/main.c            |  1 +
 arch/x86/kvm/vmx/posted_intr.c     | 23 +++++++++++++++++++++++
 arch/x86/kvm/vmx/posted_intr.h     |  1 +
 arch/x86/kvm/x86.c                 |  5 +++++
 include/linux/kvm_host.h           |  2 ++
 virt/kvm/kvm_main.c                |  5 +++++
 8 files changed, 39 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e213c9ae3e301..27df8ebc97785 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -17,6 +17,7 @@
 KVM_X86_OP(check_processor_compatibility)
 KVM_X86_OP(enable_virtualization_cpu)
 KVM_X86_OP(disable_virtualization_cpu)
+KVM_X86_OP_OPTIONAL(prepare_cpu_offline)
 KVM_X86_OP(hardware_unsetup)
 KVM_X86_OP(has_emulated_msr)
 KVM_X86_OP(vcpu_after_set_cpuid)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a94..f230843e8566a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1509,6 +1509,7 @@ struct kvm_x86_ops {
 
 	int (*enable_virtualization_cpu)(void);
 	void (*disable_virtualization_cpu)(void);
+	void (*prepare_cpu_offline)(unsigned int cpu);
 	cpu_emergency_virt_cb *emergency_disable_virtualization_cpu;
 
 	void (*hardware_unsetup)(void);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4c52ab8d07869..b3d61a85ba3bc 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -894,6 +894,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.enable_virtualization_cpu = vmx_enable_virtualization_cpu,
 	.disable_virtualization_cpu = vt_op(disable_virtualization_cpu),
+	.prepare_cpu_offline = pi_wakeup_cpu_offline,
 	.emergency_disable_virtualization_cpu = vmx_emergency_disable_virtualization_cpu,
 
 	.has_emulated_msr = vt_op(has_emulated_msr),
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4a6d9a17da238..2d6cca1606bd1 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -266,6 +266,29 @@ void pi_wakeup_handler(void)
 	raw_spin_unlock(spinlock);
 }
 
+void pi_wakeup_cpu_offline(unsigned int cpu)
+{
+	struct list_head *wakeup_list = &per_cpu(wakeup_vcpus_on_cpu, cpu);
+	raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
+	struct vcpu_vt *vt;
+	unsigned long flags;
+
+	/*
+	 * CPUHP_AP_SCHED_WAIT_EMPTY has already migrated tasks away from the
+	 * dying CPU.  Force blocked vCPUs to leave the block loop so that their
+	 * PI wakeup state is rebuilt on an online CPU before the old notification
+	 * destination becomes unreachable.
+	 */
+	raw_spin_lock_irqsave(spinlock, flags);
+	list_for_each_entry(vt, wakeup_list, pi_wakeup_list) {
+		struct kvm_vcpu *vcpu = vt_to_vcpu(vt);
+
+		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+		kvm_vcpu_wake_up(vcpu);
+	}
+	raw_spin_unlock_irqrestore(spinlock, flags);
+}
+
 void __init pi_init_cpu(int cpu)
 {
 	INIT_LIST_HEAD(&per_cpu(wakeup_vcpus_on_cpu, cpu));
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index a4af39948cf04..41414c583a063 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -11,6 +11,7 @@
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
+void pi_wakeup_cpu_offline(unsigned int cpu);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe4736..ea0ded5d64509 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9820,6 +9820,11 @@ void kvm_arch_disable_virtualization_cpu(void)
 		__module_get(THIS_MODULE);
 }
 
+void kvm_arch_prepare_cpu_offline(unsigned int cpu)
+{
+	kvm_x86_call(prepare_cpu_offline)(cpu);
+}
+
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.bsp_vcpu_id == vcpu->vcpu_id;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6e..d24fd09881dbf 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1685,6 +1685,8 @@ void kvm_arch_disable_virtualization(void);
  */
 int kvm_arch_enable_virtualization_cpu(void);
 void kvm_arch_disable_virtualization_cpu(void);
+/* Called after tasks have migrated away from an offlining CPU. */
+void kvm_arch_prepare_cpu_offline(unsigned int cpu);
 #endif
 bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d8..2169130302ca0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5610,6 +5610,10 @@ __weak void kvm_arch_disable_virtualization(void)
 
 }
 
+__weak void kvm_arch_prepare_cpu_offline(unsigned int cpu)
+{
+}
+
 static int kvm_enable_virtualization_cpu(void)
 {
 	if (__this_cpu_read(virtualization_enabled))
@@ -5647,6 +5651,7 @@ static void kvm_disable_virtualization_cpu(void *ign)
 
 static int kvm_offline_cpu(unsigned int cpu)
 {
+	kvm_arch_prepare_cpu_offline(cpu);
 	kvm_disable_virtualization_cpu(NULL);
 	return 0;
 }
-- 
2.39.5

