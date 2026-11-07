Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048234;
	b=DxAGigtDstaRgx1Yb5iTVzGSucQQpXKx21bz/BtxG03XC7a9eoc1ZdzJWTd5qB3uzbHt
	 ipW1jNjTxeF/mvIzJ1OJ3cOSyYeL0+MPgOoGfnR0PC9BbCMJIRx2z1AefA2mOj6vEiR6J
	 cSlRDA/lUVCpeSHaa499E90TUjkpWNWorej1U1CTkt/oENDlikyJya2sHLgQaS99if0P/
	 RVMRA12ZAzgF/xhJGZAxM7SHRts1gnp+KpJK5giig1EQGUcKu9UdtMlxCk8D2W5Xcjgnz
	 vAuVLH1gSXtpUDZHreP9Hus75MVypbr/wFcGSR1XIgQDjVpwt8iem+l8DI7tkdBK3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048234;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=akR23PBxOZDQ50YiRnqXpqiRfzgSrYZ2MqqItgy/7U4=;
	b=TZvk9PUmWAM1RpPf4P9t6SRua4jFYECWOrevoIfDKP94znLR7TyMFdIsK6ItNgLSSuhR
	 hVfSvbjTaztDTM4jirLTR2CWOd5K+vXrljrR+MgZklvTHb33ZDvbKoLQ+TGSscHB0sMCQ
	 A+PJG2aGvC1p8NnPir2/QuazERwU3Zh3KWYwa7U48dG0aUUIeN5spPXuCOiSz/CdG0GDp
	 DVV4haKkXsFruSTxU2PjkA91II4tHkxVnh9ORxxOkUou+X5bTxabq3A3+x/NH6xctwmZA
	 1pjWBLVBCGVs7ZesAqJJjBu2ozCIqRCasZLxezO8kQvKaNdFbvM2V2/0LVurfPc2aHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Neq7nFkK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED07606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Neq7nFkK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1B31F008A2;
	Sat,  7 Nov 2026 10:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048233;
	bh=akR23PBxOZDQ50YiRnqXpqiRfzgSrYZ2MqqItgy/7U4=;
	h=From:To:Cc:Subject:Date;
	b=Neq7nFkKdDtKSR3+SO06j0plJmXLAnyudpHXGZyxzkYm99BSFc1g5gsOyd2F5JYXU
	 +c0zxalDCPCIGzlXgsSGc6g5hGDnR1juBTew/bsOPow+CXsDDXlFAxKp8h/AMbzxUY
	 8vWB5EkmjsSRqaMtsb/cYLuhyoN+tRIGdvcrSk6RYDZ3iQkk2/wM+mRjdiZWwrOYER
	 ZJ+fnwyHQWhEaVVNpEBVeh2S0rrrtkwuGJOo/ZctJ6CkE1jQfA6PVHg/2nmc1DbpNa
	 UYEoCPKkF2j+/bTya2n9nOvP+Rq8fFuWLS8K/NgIp9iTokderUGQKb3OTelKzxH0Wb
	 jgUHNoZT0f9xw==
From: Sasha Levin <sashal@kernel.org>
To: fuad.tabba@linux.dev,
	sashiko-bot@kernel.org,
	vdonnefort@google.com,
	joey.gouly@arm.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Validate the host vCPU's VM before reading it under pKVM" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:52 -0500
Message-ID: <20261107054352-failed-6.1-cf533b4d3630@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cf533b4d3630b229d78ad55567c5db2f365052a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054352-failed-6.1-cf533b4d3630@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cf533b4d3630b229d78ad55567c5db2f365052a2 Mon Sep 17 00:00:00 2001
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 1 Oct 2026 14:56:55 +0100
Subject: [PATCH] KVM: arm64: Validate the host vCPU's VM before reading it
 under pKVM

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
---
 arch/arm64/kvm/hyp/exception.c             |  5 ++-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h | 28 ++++++++++++++++
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h     |  2 ++
 arch/arm64/kvm/hyp/nvhe/pkvm.c             | 37 ++++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 754e2dc1df54a..6e60d890afa4a 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -70,6 +70,7 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 			      enum exception_type type)
 {
 	unsigned long sctlr, vbar, old, new, mode;
+	struct kvm *kvm;
 	u64 exc_offset;
 
 	mode = *vcpu_cpsr(vcpu) & (PSR_MODE_MASK | PSR_MODE32_BIT);
@@ -109,8 +110,10 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
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
index c904647d2f760..5ddb407149667 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -83,6 +83,8 @@ struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
 					 unsigned int vcpu_idx);
 void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
 struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void);
+struct kvm *pkvm_vcpu_get_kvm(struct kvm_vcpu *vcpu);
+void pkvm_vcpu_put_kvm(struct kvm_vcpu *vcpu, struct kvm *kvm);
 
 struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle);
 struct pkvm_hyp_vm *get_np_pkvm_hyp_vm(pkvm_handle_t handle);
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 459bd9eb7e4bc..0e90de74778cf 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -304,6 +304,43 @@ struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void)
 
 }
 
+static struct pkvm_hyp_vm *pkvm_get_loaded_hyp_vm(struct kvm_vcpu *vcpu)
+{
+	struct pkvm_hyp_vcpu *hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
+
+	if (hyp_vcpu &&
+	    (vcpu == &hyp_vcpu->vcpu || vcpu == hyp_vcpu->host_vcpu))
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
 struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle)
 {
 	struct pkvm_hyp_vm *hyp_vm;
-- 
2.53.0




