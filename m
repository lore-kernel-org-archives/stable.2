Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362957;
	b=VfAHQiqnWyP2ZEokcuM653JPi9xgV9IKd9k6T5y3UX44bSN+2ILT29zGsN3mt6zFz1Jh
	 nQwWvIHb7NQ9FlzG4/d4iv/FT6fhOZG5kgLOZx9/+zUhbdkMyaSn77kZaC63bawHX9xMq
	 NwgYsE2BLFkORp3exVlgWnPW9S1ukAPZmFs5rADpF+rXJbHK+SG4krzpauCHRHEdIHkFR
	 GseRYfHfplT4r/FQaxQ7M/1GScnLyERuY32RC6XYWuWTSBgSA8Q9XxmsIsyOKKs/MtdUQ
	 hf5rirCgUbJi1UtdlPYdLe48LM/TNeDnEEoUaWdpV6S5MvWRGZdCxfffjIDPt5foAZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362957;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ozKkQ66GTPTFaP2i/XZselufjhb8L+XHpiB5nI/Lt3o=;
	b=wV8sYc8T0WoG8m+s2M7zYjSqWNOuXFdxZh0S66texl5cKiYSYzk2jPtWCLCrhuAc+rxG
	 4aRqGKJ5RJNUgElxtQVzKT2dR20hDOVOrJ+hKOrXoADV8hUAv5pugGSW3Z3wo9PFLzvnU
	 TEPKtbDsC+lUqpDoLZnnGpQ7R33O9Mxo5/T/9UuAkIh/bvaTc8vzOzsNVXUjnlzQkFv3q
	 mDGihWZ7rk4qjA1ZoBKaiafaiYWyMGw8jL5ONmKzqsdg+YscJih6nmmtzhjPRjTBXs5IN
	 8gvflF0RiuW9q4piPjz1Cfo7RLgmYtqOOTV8jbYNgzVHzT+/Lpf4/fVXHwtzZyFRQ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4+Qoq8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D396606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4+Qoq8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9251F0089F;
	Wed, 11 Nov 2026 02:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362956;
	bh=ozKkQ66GTPTFaP2i/XZselufjhb8L+XHpiB5nI/Lt3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4+Qoq8nP7wzY/SlmRUgACc99eaEBA5YgxToj0gtXqh3M/N86ym/htA+TdVyXvLus
	 iNOI1dbpx49NRF6Wj6+WH2jlUYvuFszusE5xfezPpsIfNB5JhK6UDcQwxDL26XFaGD
	 yVYOIlos/nPj/SBeYAOFqiKKUgT0uaFIbpP2q4ZSTNkGNlM/NLkAUDO/C8VL4RQ5SK
	 fpFBLuZgiVHoTz35mGnO5mLrrVWn2sXNkgdrX4JC8AwpC05gYlYR+0CVEhbPJGe9I6
	 0S0ufzVQRViU5KFQW91EAq6ywLMtDFi1Yvu8RH09ONPwqFXEP0Ur8uxRUKhLpNOISh
	 h6SuVEMkliJwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: Validate the host vCPU's VM before reading it under pKVM
Date: Tue, 10 Nov 2026 21:09:14 -0500
Message-ID: <20261111020855.514128-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051844-failed-6.12-cf533b4d3630@kernel.org>
References: <20261107051844-failed-6.12-cf533b4d3630@kernel.org>
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

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit cf533b4d3630b229d78ad55567c5db2f365052a2 ]

On an MTE-capable host under pKVM, enter_exception64() reads the VM's
MTE flag through vcpu->kvm, which for a host vCPU is a host-writable
pointer nothing validates. The host can point it at any address in the
hyp linear map and read back bit 1 of that word through PSR_TCO in the
vCPU's CPSR, or panic the hypervisor with an unmapped one.

Get the VM through a get/put pair around the read: a loaded vCPU's is
the hyp VM, an unloaded host vCPU's is read once and pinned, and a
pointer the host never shared leaves TCO clear.

Fixes: ea7fc1bb1cd1b ("KVM: arm64: Introduce MTE VM feature")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260914070536.877D91F000FF@smtp.kernel.org/
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Joey Gouly <joey.gouly@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261001135711.1640520-3-fuad.tabba@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: Replaced pkvm_get_loaded_hyp_vcpu() with a lookup through the existing host_ctxt->__hyp_running_vcpu pointer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/exception.c             |  5 ++-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h | 28 +++++++++++++++
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h     |  2 ++
 arch/arm64/kvm/hyp/nvhe/pkvm.c             | 42 ++++++++++++++++++++++
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 424a5107cddb5..e20979138305a 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -92,6 +92,7 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 			      enum exception_type type)
 {
 	unsigned long sctlr, vbar, old, new, mode;
+	struct kvm *kvm;
 	u64 exc_offset;
 
 	mode = *vcpu_cpsr(vcpu) & (PSR_MODE_MASK | PSR_MODE32_BIT);
@@ -131,8 +132,10 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 	new |= (old & PSR_C_BIT);
 	new |= (old & PSR_V_BIT);
 
-	if (kvm_has_mte(kern_hyp_va(vcpu->kvm)))
+	kvm = vcpu_get_kvm(vcpu);
+	if (kvm && kvm_has_mte(kvm))
 		new |= PSR_TCO_BIT;
+	vcpu_put_kvm(vcpu, kvm);
 
 	new |= (old & PSR_DIT_BIT);
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
index 4fdfeabefeb43..f55950ee2a7e4 100644
--- a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
+++ b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
@@ -13,6 +13,34 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 
+#ifdef __KVM_NVHE_HYPERVISOR__
+#include <nvhe/pkvm.h>
+
+/* Under pKVM a host vCPU's ->kvm is host-writable. */
+static inline struct kvm *vcpu_get_kvm(struct kvm_vcpu *vcpu)
+{
+	if (is_protected_kvm_enabled())
+		return pkvm_vcpu_get_kvm(vcpu);
+
+	return kern_hyp_va(vcpu->kvm);
+}
+
+static inline void vcpu_put_kvm(struct kvm_vcpu *vcpu, struct kvm *kvm)
+{
+	if (is_protected_kvm_enabled())
+		pkvm_vcpu_put_kvm(vcpu, kvm);
+}
+#else
+static inline struct kvm *vcpu_get_kvm(struct kvm_vcpu *vcpu)
+{
+	return vcpu->kvm;
+}
+
+static inline void vcpu_put_kvm(struct kvm_vcpu *vcpu, struct kvm *kvm)
+{
+}
+#endif
+
 static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_mode_is_32bit(vcpu)) {
diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index 24a9a8330d190..1a9dc0c3b7db1 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -69,5 +69,7 @@ int __pkvm_teardown_vm(pkvm_handle_t handle);
 struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
 					 unsigned int vcpu_idx);
 void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
+struct kvm *pkvm_vcpu_get_kvm(struct kvm_vcpu *vcpu);
+void pkvm_vcpu_put_kvm(struct kvm_vcpu *vcpu, struct kvm *kvm);
 
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 7c464340bcd07..ba7d6280efa49 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -262,6 +262,48 @@ void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_spin_unlock(&vm_table_lock);
 }
 
+static struct pkvm_hyp_vm *pkvm_get_loaded_hyp_vm(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *running_vcpu = host_data_ptr(host_ctxt)->__hyp_running_vcpu;
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+
+	if (!running_vcpu)
+		return NULL;
+
+	hyp_vcpu = container_of(running_vcpu, struct pkvm_hyp_vcpu, vcpu);
+
+	if (vcpu == &hyp_vcpu->vcpu || vcpu == hyp_vcpu->host_vcpu)
+		return pkvm_hyp_vcpu_to_hyp_vm(hyp_vcpu);
+
+	return NULL;
+}
+
+/*
+ * A loaded vCPU's VM is the hyp VM. An unloaded host vCPU's is mapped at
+ * EL2 only while pinned, so it's read once and pinned; the pin fails for
+ * memory the host isn't sharing.
+ */
+struct kvm *pkvm_vcpu_get_kvm(struct kvm_vcpu *vcpu)
+{
+	struct pkvm_hyp_vm *hyp_vm = pkvm_get_loaded_hyp_vm(vcpu);
+	struct kvm *kvm;
+
+	if (hyp_vm)
+		return &hyp_vm->kvm;
+
+	kvm = kern_hyp_va(READ_ONCE(vcpu->kvm));
+	if (hyp_pin_shared_mem(kvm, kvm + 1))
+		return NULL;
+
+	return kvm;
+}
+
+void pkvm_vcpu_put_kvm(struct kvm_vcpu *vcpu, struct kvm *kvm)
+{
+	if (kvm && !pkvm_get_loaded_hyp_vm(vcpu))
+		hyp_unpin_shared_mem(kvm, kvm + 1);
+}
+
 static void unpin_host_vcpu(struct kvm_vcpu *host_vcpu)
 {
 	if (host_vcpu)
-- 
2.53.0

