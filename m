Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246033;
	b=ymIojDoSLSbRzzY1tWvEWj4FXjYWjoA9iqj+vc2ofLEmg9sCXrcHXMb5wOvHED52QoZd
	 WT5uUdYnbIeqmFVa2lrWitA+aVZuhSrZ0Q3by2HPJDGxHgR6lKfC4o1OCd+SWwp8glVgu
	 +DUp+e2TNe3d10zSiRhEoF5HgCx/DzCDN3Nklufe8VMDUcbs9RznydN6bVqaKiVPzdqm0
	 x9/YCN+5OhgWSudPP45GmnhaeI0XS7qAmutajB74zX+Ii1WYrPSZFNpOep1L58ZJiJAfM
	 YrVdIyIKQRawdQvcU9lIw546wfDnHVlzI0CnqXmmdyIe70T0eRI6r0uC8AcKsbmrgLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246033;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=mw9T2EB/SxtZoCtzyHz1gLKbCKIVEvLwZOs7MyBa88c=;
	b=3p8Pe2catO+lq+ufUF56HOhBEQXqzpy3aZvclQhfJ2imRkMpG8DybgljO+UzgDqVBp+2
	 otR3yC8BqdFRLxZs2+AJyMfvlNeo9jvKYWy22RmppjWEOzKl/729GFK1xMDbxFZmla8QC
	 Tsy23bYab6mTLA81i3eA0XLlD6mIVonzfCT1THubmyffhCVVPMZsEEmYghhlVJCNpLN+x
	 uuqZhgETBUA0d7w0EpIBbnEUNme8sXn1dg75pcp1t+zWv4pgf24hw9o5D2d7dBWlTDyvW
	 mRZ/8HlQZYJrGdzCZsZTJo8s6z2vY0l17lAK2re0zl8RlrIIBFodnOno0nAKKotPA3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EdUHF6SF;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D11606A327;
	Thu, 29 Oct 2026 03:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D11606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EdUHF6SF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mw
	9T2EB/SxtZoCtzyHz1gLKbCKIVEvLwZOs7MyBa88c=; b=EdUHF6SFQgaDHU7kPY
	lrnp6kWbhdX7xlB2Hxfnx3rsaYe64ZC7WOGZWuTDY60FpDZX128O30xyHLTBiFfT
	KB6d/Ca5rdiCX7zqwJQC4PNpynWqaEBdQ9F4J5YqMs/dHaH0D7LlA/3QeZZti5Ff
	q92g+3D6Jn40UAgNcDWo7NwA0=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S5;
	Thu, 29 Oct 2026 11:53:00 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Hanjun Guo <guohanjun@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Julien Grall <julien.grall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 03/20] irqchip/gic-v3: validate MADT records before use
Date: Thu, 29 Oct 2026 11:52:34 +0800
Message-Id: <20261029035253.2333852-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029035253.2333852-1-yaojiale02@163.com>
References: <20261029035253.2333852-1-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryxXF43ZF48XrW7Ary7Wrg_yoW5ZryDpF
	4UK3s0yw43tr4agws8Jw4UZFW5Ars2yFZFqFWxCa43Kw4rKryjvFWIvFyYgF1xJF4ruw42
	vr4FqFyUCFW8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jw9N3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRxLhWriwxzjNwAA3c

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
index 94873646d46f..3d10818593df 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2301,6 +2301,9 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 			(struct acpi_madt_generic_redistributor *)header;
 	void __iomem *redist_base;
 
+	if (BAD_MADT_ENTRY(redist, end))
+		return -EINVAL;
+
 	redist_base = ioremap(redist->base_address, redist->length);
 	if (!redist_base) {
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
@@ -2327,6 +2330,9 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
 
+	if (BAD_MADT_GICC_ENTRY(gicc, end))
+		return -EINVAL;
+
 	/* Neither enabled or online capable means it doesn't exist, skip it */
 	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
@@ -2404,6 +2410,9 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	struct acpi_madt_generic_interrupt *gicc =
 				(struct acpi_madt_generic_interrupt *)header;
 
+	if (BAD_MADT_GICC_ENTRY(gicc, end))
+		return -EINVAL;
+
 	/*
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC. The redistributor is only known to
@@ -2450,6 +2459,9 @@ static bool __init acpi_validate_gic_table(struct acpi_subtable_header *header,
 	int count;
 
 	dist = (struct acpi_madt_generic_distributor *)header;
+	if (BAD_MADT_ENTRY(dist, (unsigned long)header + header->length))
+		return false;
+
 	if (dist->version != ape->driver_data)
 		return false;
 
@@ -2469,6 +2481,9 @@ static int __init gic_acpi_parse_virt_madt_gicc(union acpi_subtable_headers *hea
 		(struct acpi_madt_generic_interrupt *)header;
 	static int first_madt = true;
 
+	if (BAD_MADT_GICC_ENTRY(gicc, end))
+		return -EINVAL;
+
 	if (!(gicc->flags &
 	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
-- 
2.34.1

