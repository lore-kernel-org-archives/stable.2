Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231850;
	b=p15XB8orlYV4yjEnECBBAwayj38PmNjJPuPAYfCA7TzFMYYnV1D5tlWe30O87sIbAk48
	 M8hFUx1bhgiF3ggKn/IxQTH8B252CUSFwSA1IMwFo4Td6AaYbjbW65EKZseLFQBq54w2m
	 HUVg7i94doOEsp0ARBuKJY12mR2YAYh7LAmcRge9DPoxd07uKUm2HXk0bJCG8HJ/tCO7Z
	 BB48y90FBH6f5iGG2MPj+2UzuU92bIrLXIk1Rz2qaZ0aFpPmIlb4Y4zYPvIPBiK2L3HoB
	 J3NJOwf8KthJuBVxEU56h/ct5RqR/7tu7BAPg5aPgWjt+bPl2IEmqeDF07eKiG0IlJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231850;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wy9CJ/y0JguXD4knEC3K+vSUhevvAsn5QvrIqf5UXXk=;
	b=uhV6tHY4VSjXN8PjUm4z29REBHnEGgTAnnPMIiJXbIQwct3ngGs+ul51uCghqd1QodUu
	 YLKYdhOiq+UPzQDAVUZoIlwMvmpsAFqUttS4vTALVi9UwrO75Pox0J2PRMWBu6SNr1FA9
	 xZKpdq/2cNcMTL4YvLK5DB9C9Im1wgsRbc0lGdV4deno0p60Dn6ZDFk/DYfjvmazymesn
	 Fv6P3zpij6fnva+oQH/szImVsjc87ZP4PK2kkgvd+P68I7sY5ODaMZo9+mDjW4vC5mtkK
	 jZ30rW7LPsTFEn7icEQ5EdJUMLBihO9SXHCUpIBPUDYWNxJ422MMytbYjKEvtRyMDzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.74
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB51606A31A;
	Wed, 28 Oct 2026 23:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FB51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07946176|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00518608-0.0160223-0.978792;FP=7180752150399191531|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jrnSxiR_1793231833;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jrnSxiR_1793231833 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 07:57:18 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: x86@kernel.org
Cc: puwen@hygon.cn,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	yangzhen@hygon.cn,
	dengqiming@hygon.cn,
	Tina Zhang <zhang_wei@open-hieco.net>,
	stable@vger.kernel.org
Subject: [PATCH] x86/cpu/hygon: Work around XSAVES Erratum 1386
Date: Thu, 29 Oct 2026 07:57:12 +0800
Message-ID: <20261028235712.383977-1-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
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

The XSAVES malfunction described in AMD Erratum 1386 also affects
certain Hygon Family 18h processors. Under specific conditions, XSAVES
may fail to save XMM register state, allowing stale register values to
reappear after the state is restored.

None of the affected processors enumerate supervisor XSAVE state
components. XSAVEC is therefore equivalent for their enabled state
components and is not affected by the erratum.

Family 18h models 00h through 06h and model 10h are affected. Other
Family 18h models contain the fix in hardware.

For the following model and stepping combinations, the minimum
microcode revisions containing the fix are:

  Model  Stepping  Microcode
  04h    0         0x9040000f
  04h    1         0x9041000f
  06h    0         0x9060000f
  06h    1         0x9061000f
  10h    0         0x91000004

These are the only known steppings for those models.

Disable XSAVES on affected processors unless a matching model and
stepping entry identifies a sufficiently recent microcode revision
containing the fix. This allows the x86 FPU code to use XSAVEC
instead.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Tested-by: Qiming Deng <dengqiming@hygon.cn>
Reviewed-by: Zhen Yang <yangzhen@hygon.cn>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/hygon.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ec51c2b9a257..0967b0f181dc 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
 
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/cpuid/api.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -170,11 +171,50 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_VMMCALL);
 }
 
+#define X86_MATCH_HYGON_MODEL_STEP_UCODE(model, step, ucode) \
+	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_HYGON, 0x18, model), \
+			    step, step, ucode)
+
+static const struct x86_cpu_id erratum_1386_microcode[] = {
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x00, 0x9040000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x04, 0x01, 0x9041000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x00, 0x9060000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x06, 0x01, 0x9061000f),
+	X86_MATCH_HYGON_MODEL_STEP_UCODE(0x10, 0x00, 0x91000004),
+	{}
+};
+
+static void fix_erratum_1386(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Affected processors enumerate no supervisor XSAVE state components,
+	 * so XSAVEC is equivalent and is not affected by Erratum 1386.
+	 * Disable XSAVES unless the microcode is known to contain the fix.
+	 */
+	if (c->x86 != 0x18)
+		return;
+
+	/* Models affected by Erratum 1386. */
+	switch (c->x86_model) {
+	case 0x00 ... 0x06:
+	case 0x10:
+		break;
+	default:
+		return;
+	}
+
+	if (x86_match_min_microcode_rev(erratum_1386_microcode))
+		return;
+
+	clear_cpu_cap(c, X86_FEATURE_XSAVES);
+}
+
 static void init_hygon(struct cpuinfo_x86 *c)
 {
 	u64 vm_cr;
 
 	early_init_hygon(c);
+	fix_erratum_1386(c);
 
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
-- 
2.43.7

