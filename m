Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712917;
	b=QBmpTgCL2ztFItTfC1V71zZNnuB1Krut7Qrc4KI29AvNXy3vNZWvHQYdofB+YKsrVTla
	 VVBofmHXr5uUnVyDM+SIe9P+5+K1MFnMZFUyiYDOc1IvS47t+3WRelQGR7hh5z8qFYpM4
	 IHYLt4p3kzKSCmfaP/HMtoAAllSEXwoMmQjj3M6osOZu9iem/tLdLMaiZf+E7zf0LZRun
	 8E001gSsnvmIg10OyneO2xJ57R02zzD/sxMIl7XNN1jT+4MkIn6O+PDdB9NK10wExy0N5
	 8t6XrJyh4XfAaFxNHs/BH86lPSj+CNVbUTro22m9JjQ/lXRLJxf7AwprpynyPlkdAmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712917;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+uoxgyDFnCdrgeijqlfXbpy87aAJna0xcrA+qkSLBOs=;
	b=c5S3RBjTKhj7/HXcdFkdyeu9yV22zNeQdvjsuR6wlVSOo19GKEiuIKfDBNbQ/X4tRRTg
	 K0qnldSHuJK+mstez9pIjjSUulCYKshUjwyqprEVq1oNkf3XiT4LW8mBmT0QmfiYgVKFo
	 cdpqD+bVI6v766Gr74Bt5gleXxIcIyfFBBm/+ScnQbOX8d7dHUixPKcTWbajnT5uS+t8S
	 AGkPpgh5PU5pqzrUuqeD9ch00ZX1ob+lQhWeJkkOcGF8v0LhtbPQEtYOxPhNxEqbvb/eN
	 qq9EicqUfOya8z0ndEp3wZLFKxb520fo7Uq5wzvtqaSzmfKMYHApom5nycTVM3TGJVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY3vihc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D4606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY3vihc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8542D1F01825;
	Thu, 22 Oct 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792712917;
	bh=+uoxgyDFnCdrgeijqlfXbpy87aAJna0xcrA+qkSLBOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WY3vihc1lN9Wq0TGwQMJYapF5E3huhRExj98rLt61itPdHIv4DNhub06NiKXygngx
	 jymYxPPDTBwQl4MHsBCWyyXVlLhVZQVOVc4e2UvONjPI2g/pExc9d3Qj8JcwHF7v6j
	 wfnEx4rEvAv9AEor9vwNR9zDvadrjSDn25XI6YrwStCYCaC0Jl7GDL1IKMmr7CUx3k
	 rlxZJscEmKXFv4KkVky5jdXcIPcWlBnWzKoYqycubw0+n6grVnht0HZhU13RMpTNjK
	 4Kbo561m4izi8oEDoNrd1Rc4zw+jSyzdtoW7l8t0E3gL45GVzXXms+u7b6mSvtVYdM
	 7oRwnt/6RXiIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] x86/kvm: Use separate percpu variable to track the enabling of asyncpf
Date: Thu, 22 Oct 2026 19:48:34 -0400
Message-ID: <20261022233056.2182401-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102115-flatterer-resolute-532f@gregkh>
References: <2026102115-flatterer-resolute-532f@gregkh>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

[ Upstream commit ccb2280ec2f9e805d70f57a3a1c5deff0d532cb3 ]

Refer to commit fd10cde9294f ("KVM paravirt: Add async PF initialization
to PV guest") and commit 344d9588a9df ("KVM: Add PV MSR to enable
asynchronous page faults delivery"). It turns out that at the time when
asyncpf was introduced, the purpose was defining the shared PV data 'struct
kvm_vcpu_pv_apf_data' with the size of 64 bytes. However, it made a mistake
and defined the size to 68 bytes, which failed to make fit in a cache line
and made the code inconsistent with the documentation.

Below justification quoted from Sean[*]

  KVM (the host side) has *never* read kvm_vcpu_pv_apf_data.enabled, and
  the documentation clearly states that enabling is based solely on the
  bit in the synthetic MSR.

  So rather than update the documentation, fix the goof by removing the
  enabled filed and use the separate percpu variable instread.
  KVM-as-a-host obviously doesn't enforce anything or consume the size,
  and changing the header will only affect guests that are rebuilt against
  the new header, so there's no chance of ABI breakage between KVM and its
  guests. The only possible breakage is if some other hypervisor is
  emulating KVM's async #PF (LOL) and relies on the guest to set
  kvm_vcpu_pv_apf_data.enabled. But (a) I highly doubt such a hypervisor
  exists, (b) that would arguably be a violation of KVM's "spec", and
  (c) the worst case scenario is that the guest would simply lose async
  #PF functionality.

[*] https://lore.kernel.org/all/ZS7ERnnRqs8Fl0ZF@google.com/T/#u

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20231025055914.1201792-2-xiaoyao.li@intel.com
[sean: use true/false instead of 1/0 for booleans]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 81d99abe2bd8 ("x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/virt/kvm/x86/msr.rst   |  1 -
 arch/x86/include/uapi/asm/kvm_para.h |  1 -
 arch/x86/kernel/kvm.c                | 11 ++++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/x86/msr.rst b/Documentation/virt/kvm/x86/msr.rst
index 9315fc385fb0b..f6d70f99a1a73 100644
--- a/Documentation/virt/kvm/x86/msr.rst
+++ b/Documentation/virt/kvm/x86/msr.rst
@@ -204,7 +204,6 @@ data:
 		__u32 token;
 
 		__u8 pad[56];
-		__u32 enabled;
 	  };
 
 	Bits 5-4 of the MSR are reserved and should be zero. Bit 0 is set to 1
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6e64b27b2c1ee..605899594ebb8 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -142,7 +142,6 @@ struct kvm_vcpu_pv_apf_data {
 	__u32 token;
 
 	__u8 pad[56];
-	__u32 enabled;
 };
 
 #define KVM_PV_EOI_BIT 0
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 99e0768ccaae7..014bfe7fb91cc 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -65,6 +65,7 @@ static int __init parse_no_stealacc(char *arg)
 
 early_param("no-steal-acc", parse_no_stealacc);
 
+static DEFINE_PER_CPU_READ_MOSTLY(bool, async_pf_enabled);
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
 DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
 static int has_steal_clock = 0;
@@ -244,7 +245,7 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
 {
 	u32 flags = 0;
 
-	if (__this_cpu_read(apf_reason.enabled)) {
+	if (__this_cpu_read(async_pf_enabled)) {
 		flags = __this_cpu_read(apf_reason.flags);
 		__this_cpu_write(apf_reason.flags, 0);
 	}
@@ -295,7 +296,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
 
 	inc_irq_stat(irq_hv_callback_count);
 
-	if (__this_cpu_read(apf_reason.enabled)) {
+	if (__this_cpu_read(async_pf_enabled)) {
 		token = __this_cpu_read(apf_reason.token);
 		kvm_async_pf_task_wake(token);
 		__this_cpu_write(apf_reason.token, 0);
@@ -362,7 +363,7 @@ static void kvm_guest_cpu_init(void)
 		wrmsrl(MSR_KVM_ASYNC_PF_INT, HYPERVISOR_CALLBACK_VECTOR);
 
 		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
-		__this_cpu_write(apf_reason.enabled, 1);
+		__this_cpu_write(async_pf_enabled, true);
 		pr_debug("setup async PF for cpu %d\n", smp_processor_id());
 	}
 
@@ -383,11 +384,11 @@ static void kvm_guest_cpu_init(void)
 
 static void kvm_pv_disable_apf(void)
 {
-	if (!__this_cpu_read(apf_reason.enabled))
+	if (!__this_cpu_read(async_pf_enabled))
 		return;
 
 	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
-	__this_cpu_write(apf_reason.enabled, 0);
+	__this_cpu_write(async_pf_enabled, false);
 
 	pr_debug("disable async PF for cpu %d\n", smp_processor_id());
 }
-- 
2.53.0

