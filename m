Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708010;
	b=HCxlMKgGLFcFD8iPsblzKlmhERVC1uxibQIi7gmXI2yrPkGeC+bC5FOmV5aksX09dwdT
	 EHzuhfJx/+sTZ4vfNW/tWz7DYofchEPT/BmFHD+bdQdQeDILZhZlXzSjA4x7ph0PDljZ4
	 rXbBfQ0WWFEi8hX3i94CrievbR/MJlgEVY9g2zGYINDVPn5F2jktAClxORCyyD7aJZetV
	 eL2k2+/tzd3cu6cWyINC8svphpxYw+tfNfhAEL+6jP3YNtPPWcxuFD+2cIvd1kQEcUAlB
	 QYOthWJEeNOa3oNp6ErLSJU0QsuW2UfTZ6GlAjd4yFyLOh6rPh7qSbaUqpBJNyerLIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O5uAHb9kmGDCAnsJegP9D6Y2Iol5FUyk6rZAtZMtykY=;
	b=tuwzYKd3mhvskfAyALFcLNdmf3SjvgxxwRiIu5YRUFwOfrQb+1KCe4UCqa8lI1+0PkhM
	 4rJoOuX2zGzFjHhQ0MXrzQ5uezEQDkVo86M0wELmYts7lGSRKt8aXdTVUBOdrXzkbO8IK
	 iWDGQK8QqH2IkN2dyZGjD/XjzAesMf3GgKkF4F5DBHysfN469O7/Uv+jLEO6PYJCmLDhD
	 n2V+pTwIQvVNAgRVrSsIIaPoJMbYBbJMKOYxEfqBOecWuyLaCvV6WvQ4A4sckw+h52bZj
	 pubdzMXVLWDWdsPuFVABoE76Lhail8dE8j/qnA2xyBngavc6R2aMBlBt6HcUnnnLa1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThOXPHJw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A4606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThOXPHJw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC841F01825;
	Thu, 22 Oct 2026 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792708009;
	bh=O5uAHb9kmGDCAnsJegP9D6Y2Iol5FUyk6rZAtZMtykY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ThOXPHJwUmfsX28GlytNLOlpufDs/2jQkkTrwldP4H9prO4dXiNCcNJuz9nef2TOq
	 1qAUVhtDm6+qROcFGs4SeQpIBvgOk7rxuMXGQoEYVm933QvMtumUjxIIMg5kii+QVf
	 pCxI0JPeahbY6X4VvGTPfHOP0C76doRAQAOtiLz+23GseEfn/1rheDPwqBtif4NFBW
	 aPlNCtL3R8KSaAbHzpJ4hXCxZ5uWPIRmZ0apm4BGKrZv1qd4sEhiRjtLx9vZinLI/k
	 PNDfF8axaA50icRNZwOJXNYSAjZbG5Cgv3Z9TRyQ7pnYuIt0CWV0NuvItsThlxx2hb
	 PLdYpad/Dzr6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] x86/kvm: Use separate percpu variable to track the enabling of asyncpf
Date: Thu, 22 Oct 2026 18:26:46 -0400
Message-ID: <20261022220231.2081230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102114-railroad-feisty-2a38@gregkh>
References: <2026102114-railroad-feisty-2a38@gregkh>
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
index b5ef2c2899f2a..20059d236ff7f 100644
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

