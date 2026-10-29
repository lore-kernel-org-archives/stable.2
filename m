Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246033;
	b=AabizwQlR8AANeDCsTqfcV6y1JyE94nVBo8+A8MQYOhm4arSdhRsEaXBZDIVTidwRBJO
	 UDEaXW8a/8ZqsXh+spsuB6zfqYsh/mWEUibo5v49A1FD3+5dmYYlmd3EuAiyZ/02gwKZC
	 eL4emdohuTHRB8ijyg9c1Rh3Isv/NkrwEn2teqe7tqeiXTLWJnZNsWI9pWdv4eGtGvR4G
	 WC8nwDTJmzp+FhBtWC25mmiLxDEMF/m9pWIkKJjtT2CLvNvL30WkObDk3L/p6fvICHeRY
	 T7X8PLZAya+1fj9nnHPfbkVpeNsgExWHeWbU8hli7K3v3aEqRmu+3UBWcsTaLTrTpzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246033;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=UY7MooYqNCJjJHtEgJ9cEZN73LfDNc9l0RKZDYXUwoA=;
	b=u6+mqBuhnH9EjsCbyCBfzXD2ge+KmJK1LCWeQBs+OvzZwioGeEZ0HoOGIXRj738Z5GQg
	 dcKtwduvgc15Zw2IwXe1BAfhV5cOg+4pLQfBSJAOidAteP46mKnAOfVzYzZQTrBdrn987
	 N7t57uG1k3isLvpGKVAVIE+8JQsIj/6P0RDsC1h7/5s6+8ygEci11YB9R5d5SzoaZuKVP
	 +sBjilSX8ykzlLIEftrxyDZ4DHzj1UDdofjw4CWc41T/K0yPO4JcJ3ZbrS+2AKMYM/pDU
	 jOZCyHf0EHc5Z7NLkpE0l16p6sHnE27STPn1ywyFgq0Nue6XfJCdH3SfCynv3bnabWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ayjl8lBk;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF4606A326;
	Thu, 29 Oct 2026 03:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0CF4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ayjl8lBk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=UY
	7MooYqNCJjJHtEgJ9cEZN73LfDNc9l0RKZDYXUwoA=; b=Ayjl8lBkWnUJmKwyLE
	WqO1vFqQKKQq60H22r2WVq532gIaoDTbzCfRSMPDzX5cwzNfNz15wDS++pu1u3tc
	sLuhr0YsSjHKHCoWyAVFQcCjumnGR3/5R4BSJCe7ieHBsc+UJGcoPL+/j1nBT10z
	tdGI+ZY9bBxPP8mJRY6FMt58g=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S10;
	Thu, 29 Oct 2026 11:53:05 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 08/20] ACPI: riscv: validate interrupt controller MADT entries
Date: Thu, 29 Oct 2026 11:52:39 +0800
Message-Id: <20261029035253.2333852-9-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15Ww17ZrW7XrWxJrW8JFb_yoW8XFy7pa
	yUKw1Yyr45tr4fWw17Kw15XFy3G3yUGFsIvFWUua4IqrsrKFW5XF90qF1a9r95Ja1vgw4a
	vr4vyFyUuFW8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPPEfUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wFMhmriwyFalQAA3B

The PLIC and APLIC MADT callbacks cast generic subtable headers to
fixed-size records before checking that the complete records are
present. Truncated firmware entries can therefore cause out-of-bounds
field reads.

Reject entries that do not contain the complete controller-specific
structure before registering an interrupt controller.

Fixes: e77b8dc02a1c ("ACPI: RISC-V: Initialize GSI mapping structures")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/acpi/riscv/irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index da2c42e0ebfd..1f6fee5c5746 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -220,6 +220,9 @@ static int __init riscv_acpi_aplic_parse_madt(union acpi_subtable_headers *heade
 {
 	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
 
+	if (BAD_MADT_ENTRY(aplic, end))
+		return -EINVAL;
+
 	return riscv_acpi_register_ext_intc(aplic->gsi_base, aplic->num_sources, aplic->num_idcs,
 					    aplic->id, ACPI_RISCV_IRQCHIP_APLIC);
 }
@@ -229,6 +232,9 @@ static int __init riscv_acpi_plic_parse_madt(union acpi_subtable_headers *header
 {
 	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
 
+	if (BAD_MADT_ENTRY(plic, end))
+		return -EINVAL;
+
 	return riscv_acpi_register_ext_intc(plic->gsi_base, plic->num_irqs, 0,
 					    plic->id, ACPI_RISCV_IRQCHIP_PLIC);
 }
-- 
2.34.1

