Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258420;
	b=Bz6GdkcxkS4gqE2Mu7+YP3jkAjN7J3jiX+Sqo+DrKg6lZs5VNERnUMHv7CNBajuvqLEw
	 dvB+xhddT2JTFY+9lpWcXTED8jA0OQ35usZOt8IuB1xqQ8yL6Yeu1D894raGbme1mVkVt
	 sEY7jzyYJlF5ZKHQNwWpRW9q6A1jUy01tlgOSmyQ/UjEIV4xPcgALmXwWBWtiqrH/W66F
	 gL4ioTitCJqW9Pe5VEeN3aaYfDzeH4VGfG5PcpVuLxnzxUMKoQVPKwpl86yocelMR5fca
	 cXRZNBB2noGfOb4agl97utRW7rxmyk70xgFTyMsIMx9uHPc3A6b8nmz0aqvtMsXbS5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258420;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=l50CAtQzNadHFSzuTTVRJIlupCKXXjl5rlQxFti5jps=;
	b=zWzl4GotwBr6jARWTU6ke6gevNqfkC++WNIJakuiuU3v5q+gRjtK42nMYzH9ITEPALJH
	 6fQ/7gnmTlWYg+skzp0+YmoRTc95+Iq8M1BMEWqUmYuyNtstQt4lUFFBC0j6qNkSzqZAS
	 i7UICSZur340erTYQoajqqENa7Rmg27i5jX/0deFJQUYhqTkM3sHkf4+hwEa4dpAFtKgO
	 of6Wlrpo9i2ijP2X6Mnooxx6G7j9yL30l0WugzmI3LW600k5wXrOP4/MPpxJisg0kTpls
	 6EmCqWdmuHCCiLLtKW3QlQqrLejqvxaV5/ZUZ8oOQ6eA4ErfTKT0F/GRyv6152+w9Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.219
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1D606A320;
	Sat, 21 Nov 2026 10:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE1D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07258849|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00391736-0.0256318-0.970451;FP=12386842946356973035|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033065158064;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k75knxJ_1795258402;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.k75knxJ_1795258402 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 18:53:27 +0800
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
Subject: [PATCH v2] x86/cpu/hygon: Work around XSAVES Erratum 1386
Date: Sat, 21 Nov 2026 18:53:20 +0800
Message-ID: <20261121105320.478279-1-zhang_wei@open-hieco.net>
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
Changes in v2:
- Keep the workaround self-contained in hygon.c while following the AMD
  implementation pattern.
- Describe the affected processors in an x86_cpu_id table instead of using
  open-coded family and model checks.
- Add a reference to the public Erratum 1386 documentation.

 arch/x86/kernel/cpu/hygon.c | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ec51c2b9a257..2546b44af981 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
 
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/cpuid/api.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -170,11 +171,51 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
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
+	X86_MATCH_VENDOR_FAM_MODEL(HYGON, 0x18, 0x00, NULL),
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
+	if (x86_match_cpu(erratum_1386_cpus))
+		fix_erratum_1386(c);
 
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 

base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.43.7

