Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049961;
	b=z02WB5RBEERuqA11sDNNCgVEJ9d8vml/bhwaic9mYNh1KLpnRMSJZQBafrf7D2QoeJ2f
	 c5MRy5/yxvXTfjoAHLSOTTvy78vlV1FNaVFs0j1IsVsWX3mnwt0hDkR5cwFuVezhN9JyF
	 bY9H93+Y1k/tMwCGyFM0JU8iYbSwpHvFZ+OUMw75AOo8GuvQzOKdJ/x6uKr59ThLPvpP/
	 Bvfd1+6E6iaSqYb3GHEXTizFwNYoZT2Ugs5IOhs6syKQ8MNWrHKA7+p33jieJFcHcB8Gv
	 ifRj2eB9aRHRmtOE2U0oK+TkjVGXcynE20zwEMqtDW1PtXIMRP9J/PGjUW8Swk0mZAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UIXnGHBZzB/CRaVD23vHxVnLAJvixCT/0up3Sobeou0=;
	b=2n/uK44+6bzH9f3ITwWQNMsPssBUtOX3Tq0IV5EPsa8H9S+Ancnq43nXS1VICW0D+aLq
	 nLYNqt+MMiIZbBAwb43T480YdoeXjrB8xFlklL8Mm6BN+CjWXZUSKA4rVzeLHhYtxHrN2
	 FbbKHEg8cuD70xnHHOeKJbmv9iInG2h7ABKUkbOfyeecrAll649Cy5VD5rQaHP1UsQMzD
	 PjByolgWTLIaUSmKHWLzT1EGwfJ8Af636LkBtcOpNIBVkesNQ/dCfIf3CUEHEdIMnCFDJ
	 AmLaAjPsk7avm1GLrVAX/zB1/Hs6dgs0p9Bq5QgHEtfnw4s3dCq/suvmEe3Q0JqEURA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0AT9XUn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0AT9XUn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB981F0089F;
	Sat,  7 Nov 2026 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049960;
	bh=UIXnGHBZzB/CRaVD23vHxVnLAJvixCT/0up3Sobeou0=;
	h=From:To:Cc:Subject:Date;
	b=B0AT9XUneZ01pz2PqZxXnRS7Zr6+ucTpeWKM9n6YGfOUKetTEbFoOic7MSnHW33r7
	 tvimpA4uC8BnUqFRkgMNon/niIEguBSXIq5djgW3hncf5KoBRrwERIdh6p8b8GN+2t
	 3yyYcma9/Q+3q2TIEHOmBxMqiiGM+NjxzSwMpzm62DbMbQcRnt48R2FxOXW8KLjoFl
	 c/GxVqNfYT9XWjpr6nWpb2XpvrIBARZLOkNG2ddJlAKooWcaenNfkU+LJ9hOSCRDn4
	 VLEUKzorqRKXWDiw5GcYvH9XfLtmtuiyBeHHqrK/5r13Uc4/N1RPOOsZ6xJ0xTPXUt
	 mnmbHNNSkSeqg==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Use pa_to_nid()/nid_to_addrbase() rather than hard-code" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:38 -0500
Message-ID: <20261107061238-failed-5.15-244eb26bbd15@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 244eb26bbd152896f976db6415550993cd60b46d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061238-failed-5.15-244eb26bbd15@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




