Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715335;
	b=W526DqtShDsQgA9cuSHUv2rpXusCLzWJO2cATGDCpQIhvhdz0R3NM2JGHX2oMdk3PPY6
	 nSQ5VpirK5JYRePHrj9oEQXFeV6CCdOAq+1ufzww9+aVfwLgRq1nYTGXdP8b/1oRt9lMd
	 cGF/ipCULPwbxCV5t02jbNl43U27funsD7XCit3ClhCI1Yq2mkI43hnceO57eKOFJpuUm
	 DVJisl929ers00QyY2mk7p7UIiwh+KYO5EPsCqnmffmYiglP0TGXBEH1+6t5JQmdXFCvD
	 I9NVx57uVPbLcSAoqQSupJXHXwolWTor593itb2U9UHeRIqTvXEcZ33Br8bOmzYbTBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1ghVX/9WedB1zGgVwnwrjX0pgH6Xgl8sLRtSuQ3vRRM=;
	b=aUYJzwSGtk76PwGl2lpZG0y+L3lRYo6GEj8i78OcfQkT9fp9uYTBj2VmKZQmUO4are8C
	 ECnxTxZU10PZC9RbxG88Jz9MHJBoSvzQW+ewOP/JZ1IZSr4b85TyICy8jPs34qyOUlrnV
	 qbbvpX1rWERNdkLsegMqeGBIV2+12HMiaQibmulYRuMLPsIJ2iRKdFTyOV9G+zQfG4rot
	 OvWqPvqK+pCPc1aEZZM3ySj/aft/hpeSWxmcb6q47zUxfk1q8wJnbTXs2GliQ7LZ4EuGb
	 ERdjdFHfa2mzlq/FAWIOOoJ+4tTTZXKkEs9QfCfU74ZFh2weg6aTn7oxsBTiw8ZFejw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hv4S2uj+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60E606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hv4S2uj+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9011F031E0;
	Fri, 23 Oct 2026 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792715335;
	bh=1ghVX/9WedB1zGgVwnwrjX0pgH6Xgl8sLRtSuQ3vRRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hv4S2uj+ABpIyqm15T6gowH2CMUci1BWe2jLHH5wrWHw0wjVndkTLD1aJCgcLErbC
	 345diIQntdqkHk9YR6fBu40TZx3PyIieKvWX+gsxoHgC2a/o8HMKaTBZmOuT6YFiK3
	 619FMsUGgzcmHDWmdCoJ2PCZwsCjM/PtrFVmHY0c8PuSzLWtMrfi0bF2uJE6abnIjl
	 QfvtvhpetN4IqQLH+GbTnx5sadoUdWNFB5wtJyJmrTp2BoYUimnFXog1lLH5Ld5rY7
	 +6roiuZFljP3wihHxau8S0JvKg6nHo7CmjOzobb0Dac6pe3Frcpn6PzXiGE7eBIFN5
	 ItBVFEKQzm60w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] x86/kvm: Use separate percpu variable to track the enabling of asyncpf
Date: Thu, 22 Oct 2026 20:28:50 -0400
Message-ID: <20261023002045.2270144-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023002045.2270144-1-sashal@kernel.org>
References: <2026102116-motion-upchuck-3417@gregkh>
 <20261023002045.2270144-1-sashal@kernel.org>
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
 Documentation/virt/kvm/msr.rst       |  1 -
 arch/x86/include/uapi/asm/kvm_para.h |  1 -
 arch/x86/kernel/kvm.c                | 11 ++++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/msr.rst b/Documentation/virt/kvm/msr.rst
index 9315fc385fb0b..f6d70f99a1a73 100644
--- a/Documentation/virt/kvm/msr.rst
+++ b/Documentation/virt/kvm/msr.rst
@@ -204,7 +204,6 @@ data:
 		__u32 token;
 
 		__u8 pad[56];
-		__u32 enabled;
 	  };
 
 	Bits 5-4 of the MSR are reserved and should be zero. Bit 0 is set to 1
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 5146bbab84d4c..b8ab0069d555e 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -141,7 +141,6 @@ struct kvm_vcpu_pv_apf_data {
 	__u32 token;
 
 	__u8 pad[56];
-	__u32 enabled;
 };
 
 #define KVM_PV_EOI_BIT 0
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 32d3319115e51..8d34f8ceca015 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -62,6 +62,7 @@ static int __init parse_no_stealacc(char *arg)
 
 early_param("no-steal-acc", parse_no_stealacc);
 
+static DEFINE_PER_CPU_READ_MOSTLY(bool, async_pf_enabled);
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
 DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
 static int has_steal_clock = 0;
@@ -242,7 +243,7 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
 {
 	u32 flags = 0;
 
-	if (__this_cpu_read(apf_reason.enabled)) {
+	if (__this_cpu_read(async_pf_enabled)) {
 		flags = __this_cpu_read(apf_reason.flags);
 		__this_cpu_write(apf_reason.flags, 0);
 	}
@@ -293,7 +294,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
 
 	inc_irq_stat(irq_hv_callback_count);
 
-	if (__this_cpu_read(apf_reason.enabled)) {
+	if (__this_cpu_read(async_pf_enabled)) {
 		token = __this_cpu_read(apf_reason.token);
 		kvm_async_pf_task_wake(token);
 		__this_cpu_write(apf_reason.token, 0);
@@ -360,7 +361,7 @@ static void kvm_guest_cpu_init(void)
 		wrmsrl(MSR_KVM_ASYNC_PF_INT, HYPERVISOR_CALLBACK_VECTOR);
 
 		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
-		__this_cpu_write(apf_reason.enabled, 1);
+		__this_cpu_write(async_pf_enabled, true);
 		pr_debug("setup async PF for cpu %d\n", smp_processor_id());
 	}
 
@@ -381,11 +382,11 @@ static void kvm_guest_cpu_init(void)
 
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

