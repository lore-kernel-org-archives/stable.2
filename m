Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B5360EF4;
	Mon, 22 Jun 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111554; cv=none; b=YxjVGETu0eqOaG4VgtKwFnfjzbHNB6OYqBovpzTNbvLdg8hpmNbCSE+EALsOdTrCNfAtloo3zuOhdl6q5ki6KTuX+DoQ1gikkAK7ZzizO1jR8qQH+cICSOoQaZWIboeih13u5Q4TImXwxEq6f7oWaP0lBQtuG/HXOTfrSygn2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111554; c=relaxed/simple;
	bh=Kz4vcDRn2LY8H69ZCHoEMeajjezw/YfJDFkoZDEHYLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQAMlQyUxDNJseV6a+WBETmyFenFbmNUM4jLlYnqkwqDp6J3gwQFUJAh6YyJ/feFDX9DWK9STzXnD2jmCCZDagO6BTyk3jpwjwG+FbpiCczQcbxmo612YYt8mFGIjsEHnstGAlrB4CdqVd9/8oM5A3MjygJmRNiyB0P0qU0iMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8BxzsA53ThqqIAWAA--.34707S3;
	Mon, 22 Jun 2026 14:59:05 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJBxZcAz3ThqPLOuAA--.59305S2;
	Mon, 22 Jun 2026 14:59:04 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Add PIO for early access before ACPI PCI root register
Date: Mon, 22 Jun 2026 14:58:43 +0800
Message-ID: <20260622065843.3961572-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxZcAz3ThqPLOuAA--.59305S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1Dtr13CFy3Cw4kWFWDKFX_yoWrJw4rpr
	9Fkrn5GrWrWFn7Grn8Jwn8uF45J3WkC3y2q3W2g34SvF4jgryUZr4kAFyDuF15tan8KrW0
	qF95t3Wa9F4UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

For ACPI system we suppose the ISA/LPC PIO range is registered together
with PCI root bridge. But the fact is there may be some early access to
the ISA/LPC PIO range before ACPI PCI root register (most of them are
due to abnormal BIOS). Unconditionally register the ISA/LPC PIO range
usually causes ACPI PCI root register fail because of the address range
confliction. So we add a pair of helpers: acpi_add_early_pio() to add
PIO for early access, and acpi_remove_early_pio() to remove PIO before
PCI root register. Since acpi_remove_early_pio() may be called multiple
times, we add an acpi_pio flag to ensure PIO be removed only once.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/acpi.h |  2 ++
 arch/loongarch/kernel/acpi.c      | 28 ++++++++++++++++++++++++++++
 arch/loongarch/kernel/setup.c     |  2 ++
 arch/loongarch/pci/acpi.c         |  2 ++
 4 files changed, 34 insertions(+)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index eda9d4d0a493..c05168aedcaa 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -38,6 +38,8 @@ static inline bool acpi_has_cpu_in_madt(void)
 extern struct list_head acpi_wakeup_device_list;
 extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
+extern void acpi_add_early_pio(void);
+extern void acpi_remove_early_pio(void);
 extern int __init parse_acpi_topology(void);
 
 #endif /* !CONFIG_ACPI */
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 058f0dbe8e8f..8f650c9ffecd 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -16,6 +16,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/serial_core.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <asm/numa.h>
 #include <asm/loongson.h>
@@ -59,6 +60,33 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		return ioremap_cache(phys, size);
 }
 
+#define PIO_BASE (unsigned long)PCI_IOBASE
+#define PIO_SIZE ALIGN(ISA_IOSIZE, PAGE_SIZE)
+
+static bool acpi_pio;
+
+/* Add PIO for early access */
+void acpi_add_early_pio(void)
+{
+	if (!acpi_disabled) {
+		acpi_pio = true;
+		vmap_page_range(PIO_BASE, PIO_BASE + PIO_SIZE,
+				LOONGSON_LIO_BASE, pgprot_device(PAGE_KERNEL));
+	}
+}
+
+/* Remove PIO for PCI register */
+void acpi_remove_early_pio(void)
+{
+	if (!acpi_pio)
+		return;
+
+	if (!acpi_disabled) {
+		acpi_pio = false;
+		vunmap_range(PIO_BASE, PIO_BASE + PIO_SIZE);
+	}
+}
+
 #ifdef CONFIG_SMP
 static int set_processor_mask(u32 id, u32 pass)
 {
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 369262117c63..eaebb52bd36e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -502,6 +502,8 @@ static __init int arch_reserve_pio_range(void)
 {
 	struct device_node *np;
 
+	acpi_add_early_pio();
+
 	for_each_node_by_name(np, "isa") {
 		struct of_range range;
 		struct of_range_parser parser;
diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index b02698a338ee..ccbcea61fcd9 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -65,6 +65,8 @@ static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
 	struct resource_entry *entry, *tmp;
 	struct acpi_device *device = ci->bridge;
 
+	acpi_remove_early_pio();
+
 	status = acpi_pci_probe_root_resources(ci);
 	if (status > 0) {
 		acpi_evaluate_integer(device->handle, "PCIH", NULL, &pci_h);
-- 
2.52.0

