Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593971;
	b=SbyxbziPUG7b27/SiR4QDU+kn5mmSA8oqEj0ttaD9w2uea3dSg5zjY+eOieaVk+tyVUp
	 6psIsZMgjVWhUbCF0vAIa9vqvkE5aL1HeAlaZGYlO0+Z8iXZAUPZeJNRWkZP7ULQidtcM
	 hfzQt8snSX7gdRk6DLm8rhfldPXnP078WuyFXhZ32B3WytnM7BK7DLYGgwK63gz4cGnYw
	 5eerG1lhkOHLKi+gll1n1PWVgg2AqmmtfjIaD4FVW2RqcVxjK/+Qd4hc7s8nLf5Ew48Me
	 AoLuRWd2CnUc/BP4YPnyuI3JRXQpPT6HpcF++sH/WtRvSbO86AUMI5oOAO1wrVFRlPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593971;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=zUYwdbG4sGnh4rJtyaEXbUadbRzgXptSYV1kw+ac9sY=;
	b=sOvbKju//CKmd7wi4CamNYba5dDx2aVMKzgGqHXUFm/vkClRjhzlvX5iU0IyQ0NyCVtT
	 fmc2jVna8/B/pKzqtp7jrFo9nRrXU8/ZY43Hqbs35jAAHtTXTIYMuzBeZD3lN5qnaqoBU
	 kFw303+TTF2xyP1BepGkNypvIZZLHkgbte9jZO5sgeeY46zJ7ZtHal/2b1tlV4AjhpuZo
	 md23o9M+TAzUBwccmB6G4WZ95XvkXL7K/+OqDOdYJalQtg+ZWl3oEBGZgu5eUJwpu8Avl
	 NataVvEz86wIwbVrTZNwUhbEVX1XWtXccqrYtI7f5CidGenBsy6oE9huDsQzqs6Nt+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NvYW3HF5;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DA60A260A;
	Wed, 21 Oct 2026 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900DA60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NvYW3HF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zU
	YwdbG4sGnh4rJtyaEXbUadbRzgXptSYV1kw+ac9sY=; b=NvYW3HF5Ijz9XZuj7l
	Q0K7sVcjeyI/HaQQG4kklvscq+teEvEVA+QgJmH+TNZz4R4gPQDICcGlNys+8N00
	nocSKLlszd1vIJeDg/ZbzqZlKPj8S7dSBj96+4N8Wr1HArYM6++p4KtjoWNX79Xy
	FIeDZodLljPdd7NFZ4brKHtlQ=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3998G0NhqjItXBw--.10228S5;
	Wed, 21 Oct 2026 22:45:30 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Julien Grall <julien.grall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 3/6] irqchip/gic-v3: validate MADT records before use
Date: Wed, 21 Oct 2026 22:45:21 +0800
Message-Id: <20261021144524.364143-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021144524.364143-1-yaojiale02@163.com>
References: <20261021144524.364143-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3998G0NhqjItXBw--.10228S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryxXF43ZF48Jw4xXrW5Jrb_yoW5Zr1rpF
	47Kr909w43trWag393Jw4DZFW5Ars2yFZFqFWxCa43Kw4rKryjvFWI9FyYgF1xJF1ruw42
	vr4FqF4UCFW8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7GYLUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQoHQWrY0Aoi-AAA33

The GICv3 ACPI paths cast generic MADT headers to distributor,
redistributor, and CPU interface records before confirming that the
required fields are present. Truncated records can therefore cause
out-of-bounds field reads while probing or setting up virtualization data.

Validate fixed-size distributor and redistributor records before their
first field access. Use the version-aware GICC minimum size for CPU
interface records so valid entries from older ACPI revisions remain
accepted. Validate the distributor in the version callback, which runs
before the probe callback uses the same record.

Fixes: ffa7d6166a96 ("irqchip/gic-v3: Add ACPI support for GICv3/4 initialization")
Fixes: b70fb7af6715 ("irqchip/gic-v3: ACPI: Add redistributor support via GICC structures")
Fixes: 1839e576968f ("irqchip/gic-v3: Parse and export virtual GIC information")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v3.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6e1fa5b247fc..89b9ef5927eb 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2299,6 +2299,9 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 			(struct acpi_madt_generic_redistributor *)header;
 	void __iomem *redist_base;
 
+	if (BAD_MADT_ENTRY(redist, end))
+		return -EINVAL;
+
 	redist_base = ioremap(redist->base_address, redist->length);
 	if (!redist_base) {
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
@@ -2325,6 +2328,9 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
 
+	if (BAD_MADT_GICC_ENTRY(gicc, end))
+		return -EINVAL;
+
 	/* Neither enabled or online capable means it doesn't exist, skip it */
 	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
@@ -2391,6 +2397,9 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	struct acpi_madt_generic_interrupt *gicc =
 				(struct acpi_madt_generic_interrupt *)header;
 
+	if (BAD_MADT_GICC_ENTRY(gicc, end))
+		return -EINVAL;
+
 	/*
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC. The redistributor is only known to
@@ -2437,6 +2446,9 @@ static bool __init acpi_validate_gic_table(struct acpi_subtable_header *header,
 	int count;
 
 	dist = (struct acpi_madt_generic_distributor *)header;
+	if (BAD_MADT_ENTRY(dist, (unsigned long)header + header->length))
+		return false;
+
 	if (dist->version != ape->driver_data)
 		return false;
 
@@ -2457,6 +2469,9 @@ static int __init gic_acpi_parse_virt_madt_gicc(union acpi_subtable_headers *hea
 	int maint_irq_mode;
 	static int first_madt = true;
 
+	if (BAD_MADT_GICC_ENTRY(gicc, end))
+		return -EINVAL;
+
 	if (!(gicc->flags &
 	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
-- 
2.34.1

