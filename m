Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530414;
	b=yxZdi39BUWxkAiEyq+gMxFu2FcpCmg78ogh3C6MgVv60qqun0bGfLsebVlxwjbVJku4e
	 NAy0wwokeOVO9ya2BKgghLyLKo1umHap82aeFR0JvGEtol01ULIjajR7lVKsFyWOD0NuC
	 4NPn6D6kP2RXFNcoTdxuzGs7zjMekP/EE1rjHXnQf9koZbv5NY+3LE9ZqUuJrgw//2uLW
	 RzAFvR02olOdckHnjY8C6UhBs80QzfB4x8jrxnuaAwPEdpCrqFqqUQkyTKjVFVhjf2ljg
	 Y8nKZLEgByOytHNuISYj08E2Y2IT9u3M+vadbHJGEYvJtYqlZj4JW2Odg8Vy3987IkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530414;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lSJ8idID075Lrq50XU2h31Hf6+IOl1gV9gV+AgGjEBI=;
	b=5UF5wuO7qBznCRArqtsscP2Xn2fEMn2GeLuFhzW8NXse+GvUcvhaGKVmumbSC/r9TS+B
	 /+aNkgPe0HuCSrHV3NNhvvEpJxZp07xKTOJZXt0/UgzrH7uNS7JqhinjVopn/zSSUlzKY
	 0d7nUy2U5w8CuDwa8ZVvwPyb4/9F+e/Fw1ZZA3LWpXBpyawhHpl8Rv+dM1NetMDkQsjhN
	 Bh/GdPqzEjx+OUqgTdmqN3ukADRSW33iItjwPI4PwRAvXdsDBafnwF34qWdD4QUdxxsDB
	 3fM4rVKeE1Hwr9sOXCpUzqxXi4/s0EwVSjiktMZYcQzpD83XDWPVpNknISO/sj4KDbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.217
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44F606A31E;
	Tue, 24 Nov 2026 14:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA44F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0724083|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00540879-0.0168623-0.977729;FP=12386842953067793899|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k9CxAJc_1795530395;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.k9CxAJc_1795530395 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 22:26:40 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: x86@kernel.org
Cc: puwen@hygon.cn,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	david.laight.linux@gmail.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	yangzhen@hygon.cn,
	dengqiming@hygon.cn,
	Tina Zhang <zhang_wei@open-hieco.net>,
	stable@vger.kernel.org
Subject: [PATCH v3] x86/cpu/hygon: Work around XSAVES Erratum 1386
Date: Tue, 24 Nov 2026 22:26:32 +0800
Message-ID: <20261124142632.844105-1-zhang_wei@open-hieco.net>
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

The failure mode is documented as Erratum 1386 in "Revision Guide for
AMD Family 19h Models 00h-0Fh Processors", Publication #56683 [1].

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

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/revision-guides/56683.pdf

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Tested-by: Qiming Deng <dengqiming@hygon.cn>
Reviewed-by: Zhen Yang <yangzhen@hygon.cn>
Cc: stable@vger.kernel.org
---
Changes in v3:
- Match Family 18h model 00h explicitly because a model field of zero
  in an x86_cpu_id entry is treated as X86_MODEL_ANY.

v2: https://lore.kernel.org/r/20261121105320.478279-1-zhang_wei@open-hieco.net
v1: https://lore.kernel.org/r/20261028235712.383977-1-zhang_wei@open-hieco.net

 arch/x86/kernel/cpu/hygon.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ec51c2b9a257..6670dc8bb22f 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
 
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/cpuid/api.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -170,11 +171,56 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
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
+static const struct x86_cpu_id erratum_1386_cpus[] = {
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x01, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x02, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x03, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x04, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x05, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x06, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x10, NULL),
+	{}
+};
+
+static void fix_erratum_1386(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on affected Hygon processors. Clear the feature
+	 * flag only on microcode revisions without the fix.
+	 */
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
+	/*
+	 * Model 00h is a valid Hygon processor model, but x86_match_cpu()
+	 * treats a model value of 0 as X86_MODEL_ANY. Match Model 00h
+	 * explicitly.
+	 */
+	if ((c->x86 == 0x18 && c->x86_model == 0x00) ||
+	    x86_match_cpu(erratum_1386_cpus))
+		fix_erratum_1386(c);
 
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
-- 
2.43.7

