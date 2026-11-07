Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050976;
	b=ZDL1Qmj7vFXN9AlolVQP0evf/kcTrQXPu7YAL+vXgDUK/mzDph/5DXJO+9Eoj5M8kUhj
	 OTUlwUmeSd4/sXp3JiPbGQx2R6FjDcyb2ZyDM0I1W0bIPT8kF6nMxCbo7gJAL9OvQDyYk
	 R2b2EzF+pwzmuxsgyRi7SC3/ejae/55HhoDWqXuLUUbGrU7Cut96qh5DhJELcFgHzZ37R
	 uiRF3hPmAX+DbQpE0HVSOPCvTjlsYKTpFE0z6ZdJLDkcj7WdC0gCcJtW4+1QnjueYgNOU
	 DnAM8lOmowHmX9fkjq5rwaFSjkJrjQGcv0NA/rpXgPICGM1n0PrQwRVuxOAITJIRndA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050976;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+KloDIj1+/3TKut/zeZnsN6geYhqh3PVM6Vx1laOyPU=;
	b=nC7fXC/ftNjWYIe1o2/F200ejkFYfTMZF9/+8dc7HrIg3Apov2efmJlp5opZft1qybAt
	 040Gtevn9bMhwO644mK/rlVfnWEbuk47W9GMlemISTNPY55ifv9NbBtCrBlnP9aqPGmAs
	 tH8wrHCqEN/qnxvnesqn3zcDOX0h93spuQEW+wji3sBPTiVo8qLlJciQr7JfzQ61mp+NY
	 gkiCPbpXDH4rTz1TDwrqZs4seldTRQRUtRKecTEGWvG+mdxEvp7whi4nrgrbc9ybMawyQ
	 R7R3dYhWwz0NDeasYmwOBtAKbDt0AXpHiTL9NweQV6WyuqD/TDOzINtbeb58dX9/NCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZELSHJF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZELSHJF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC221F0089F;
	Sat,  7 Nov 2026 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050976;
	bh=+KloDIj1+/3TKut/zeZnsN6geYhqh3PVM6Vx1laOyPU=;
	h=From:To:Cc:Subject:Date;
	b=gZELSHJF/6qqQmr4fgNShYIjv8r/78ROW3iAi+M+bwBNTxU0Qw/pzcLBs/Cf7PPSf
	 aRGQwybZQxPOihsxXyPQrVsekm+wMkwS/iy651pKQLTOhxBsp/DiKm/SASZinc64DX
	 EKYGaynugCNIhow7BfyGOy0hegfCVB/QwObNbyrZdHPM80ITtW8dPr+Eu4jEti/ODC
	 VuJhjUfdU+O9fjY62BAuCwq8yGyrp+llbBjd2rlRcI8FR0Ccf7YQTbysHBlT14hEsA
	 vaHUHrZ+FYycfQvbn/H3POd/f6+v3YavdYHhB7mP1aiMzVV0K254j7/jmMKdV+VhdO
	 ajxue8UtNZzgw==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Use pa_to_nid()/nid_to_addrbase() rather than hard-code" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:34 -0500
Message-ID: <20261107062934-failed-5.10-244eb26bbd15@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 244eb26bbd152896f976db6415550993cd60b46d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062934-failed-5.10-244eb26bbd15@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 244eb26bbd152896f976db6415550993cd60b46d Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@loongson.cn>
Date: Tue, 27 Oct 2026 22:51:23 +0800
Subject: [PATCH] LoongArch: Use pa_to_nid()/nid_to_addrbase() rather than
 hard-code

NODE_ADDRSPACE_SHIFT is 44 now but may be changed in future, so use
pa_to_nid()/nid_to_addrbase() rather than hard-code.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/numa.h | 2 +-
 arch/loongarch/kernel/irq.c       | 3 ++-
 arch/loongarch/pci/pci.c          | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
index bbf9f70bd25f4..c9654ff900a3a 100644
--- a/arch/loongarch/include/asm/numa.h
+++ b/arch/loongarch/include/asm/numa.h
@@ -14,7 +14,7 @@
 #define NODE_ADDRSPACE_SHIFT 44
 
 #define pa_to_nid(addr)		(((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
-#define nid_to_addrbase(nid)	(_ULCAST_(nid) << NODE_ADDRSPACE_SHIFT)
+#define nid_to_addrbase(nid)	(_U64CAST_(nid) << NODE_ADDRSPACE_SHIFT)
 
 #ifdef CONFIG_NUMA
 
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 7bf68a7a5f4b3..29e0f2baaa8c1 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -20,6 +20,7 @@
 
 #include <asm/irq.h>
 #include <asm/loongson.h>
+#include <asm/numa.h>
 #include <asm/setup.h>
 
 DEFINE_PER_CPU(unsigned long, irq_stack);
@@ -69,7 +70,7 @@ static int __init early_pci_mcfg_parse(struct acpi_table_header *header)
 
 	for (i = 0; i < n; i++, mptr++) {
 		msi_group[i].pci_segment = mptr->pci_segment;
-		pch_group[i].node = msi_group[i].node = (mptr->address >> 44) & 0xf;
+		pch_group[i].node = msi_group[i].node = pa_to_nid(mptr->address);
 	}
 
 	return 0;
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index f33c7ea1443d9..0b99b32110a5d 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -12,6 +12,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/cacheflush.h>
 #include <asm/loongson.h>
+#include <asm/numa.h>
 
 #define PCI_DEVICE_ID_LOONGSON_HOST     0x7a00
 #define PCI_DEVICE_ID_LOONGSON_DC1      0x7a06
@@ -43,7 +44,7 @@ int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 
 phys_addr_t mcfg_addr_init(int node)
 {
-	return (((u64)node << 44) | MCFG_EXT_PCICFG_BASE);
+	return (nid_to_addrbase(node) | MCFG_EXT_PCICFG_BASE);
 }
 
 static int __init pcibios_init(void)
-- 
2.53.0




