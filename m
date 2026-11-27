Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795739924;
	b=GZw4ETnl8d6EmznNYoJpWohiU8ZhGnH/BFaK3aIO8xTH8a69tc94s+IvwZ28BTkFBqRi
	 CTWXiZEqtLTVLqmp7uzaK9HGdK/NUHccINLegxZSe8xWWRi1ND5+S5seOQYG2BPauwKkz
	 3TvmgI74plX+hT1KNmBjYw8AKfMVYolHAZDBZbF/WFZdPTesvB3Igh+v0U6REAE8LjbLX
	 xeyTSqUEMpNzUz9JqRA343RIBocGcO8X4rZFatPuIGBapxSAv47COLnQsIEb8AdPjLyv4
	 SP3kOso14OiJkZnikxqb5nCS4c1wNe3VbCXDiudhdsVWEH0oKqzbRJnZNOk2sSEwjDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739924;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=53EGzg+ljL57IfVllFbg8vXTdbT+07eXFyQ5UUPuQp8=;
	b=twSVCku7+WaMwGKiiYzwVXebGsAgxjFp4Zqx+vsSmFZAEZL8eXEvs2u479LMHi/DUyR3
	 BRb6LR7TH5J+xjFQfv5zJMxYSBVxJ6SD8v55BQnXfZrv0K3GFxH3pzJpuVnjxYGebb4ce
	 pKwBtzWSxYQOwvxDMx5QgHRwQaN/xwm+vmaGMP6bRU0BCjcXFmtq31CFXI9sRRKnqUws/
	 gOCJ5KnrR2N+LSxTfjYs7kzWK5g/J9xUZfUe60Wnh1fxeU5kPwQS3CLsnXOTCt5lUpstw
	 JPtkFhW772RbKPm69nHIgdepZgtxj/vmyev/kCNdobMZVpOHiLWFjw8zvkz61uCLo+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.173
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14A606A31E;
	Fri, 27 Nov 2026 00:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C14A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07424814|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00513939-0.0306104-0.96425;FP=7198573037001117163|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.kB2GY2V_1795739906;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.kB2GY2V_1795739906 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 08:38:31 +0800
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
Subject: [PATCH v4] x86/cpu/hygon: Work around XSAVES Erratum 1386
Date: Fri, 27 Nov 2026 08:38:17 +0800
Message-ID: <20261127003818.1208038-1-zhang_wei@open-hieco.net>
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
Changes in v4:
- Replace the affected CPU table and the model 00h special case with
  an explicit family and model check, as suggested by Boris.

v3: https://lore.kernel.org/r/20261124142632.844105-1-zhang_wei@open-hieco.net
v2: https://lore.kernel.org/r/20261121105320.478279-1-zhang_wei@open-hieco.net
v1: https://lore.kernel.org/r/20261028235712.383977-1-zhang_wei@open-hieco.net

Codex assisted with the implementation, changelog wording, and patch checks.

 arch/x86/kernel/cpu/hygon.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ec51c2b9a257..0863dbaa6051 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
 
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/cpuid/api.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -170,11 +171,39 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
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
+	if (c->x86 == 0x18 && (c->x86_model <= 0x06 || c->x86_model == 0x10))
+		fix_erratum_1386(c);
 
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 

base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.43.7

