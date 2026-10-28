Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163749;
	b=YgzcE2IUzIwE+zdO+BHsTEd0RhXpsNQtiZF0f+4Hh9PJkaWvHHyqrZhtv7jSBeKPZEQF
	 qah1A71fT2Yfj1MMwsiSfqxL6L58G50ob8eIQJ+J7YnFoae47QQwhl8eYbFjionUlChhB
	 17cujiYCI5XA14J7fzSFQDAvHvYlasOhrXz2Da7ur4O6oPtANSts5chRb083K0jdCNJX9
	 +8QDUTkvM0REEcMzb5lIc1GF/8y9nW1lm9BvCf1SCdgSuHfWSyRi9H9zFr05/TAoB/FMv
	 SpCUL1WXK3QSlNXm1pxvy1YznoNNc8a58w2tz1cS511RjbB6FLp+skyymrMIFpwbHsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163749;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2OoM9aqdEMWmFV24OBqNFCnNw9L/ZSPQ/qm/z6qoipM=;
	b=K6weBUgms4AcD7ZJ1JD4D0maoV/KCtSo/yVeBo9KTpUcCgnaaIyJ+BZXjiwKad8R6D1E
	 rnKefyKsZQZU8Cweu2eu0144hFMJBnc0aSan8zR/oAYWL6TUPbFpfQlZaVkYBJx+iNrUA
	 8zpXUVERwOIXv6QZvjxnq4e2QJnpVw0z+cqwrRFXJI1kiWY0uUCSRT1sHjJF8Z/CI4c2P
	 sK+nCI9Fg2wECIZazH0wtko/rmvf4PrnGixQZL6zSiz1thvX8EqWE6f9Ae9tl91g0/Lcq
	 PbINaesLD+rnlcXzHAUlSXT2+VuKqzOvxavU/PFy1HMBasNTOWGMSvwIUGDz7e+3JhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N8TIAltF;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF8606A327;
	Wed, 28 Oct 2026 05:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFF8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N8TIAltF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2O
	oM9aqdEMWmFV24OBqNFCnNw9L/ZSPQ/qm/z6qoipM=; b=N8TIAltFsTqJoP2abj
	xeHlFG4XEHZ9TDV4Erbx0qdUYy0k+v79kgJSytxE3At1kFbauel/rOlh9tNpREu9
	RIr7mU5JhCv34XRxiNz1WUWwxTxbGsWBMYwHB80hzqHh0xkGSovCbE0pT3RasCuN
	XABx3Uu4jelnXzY9bF3MwRLHM=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v2KngeFq+hfDCw--.20542S2;
	Wed, 28 Oct 2026 13:01:28 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 12/12] irqchip/riscv-intc: validate MADT RINTC entries
Date: Wed, 28 Oct 2026 13:01:27 +0800
Message-Id: <20261028050127.122684-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3v2KngeFq+hfDCw--.20542S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryfuF45KrW8Xr4rJr4xJFb_yoW8Gr1kpa
	y8trW2vr4Yya1Svr17Kw1rJFy3Aw1DCF9FqFWUCay3Xr4FgrWDXFy2yw1FvFn7Gay2ga12
	9r4FgFyru3W8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uv-erUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wid12rhgajPTgAA3O

The ACPI initialization callback copies fields from a typed RINTC record
without checking that the complete record is present. Reject truncated
entries before allocating or reading per-controller data.

Fixes: 7023b9d83f03 ("irqchip/riscv-intc: Add ACPI support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-riscv-intc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 0595144116e2..6884fa413df0 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -344,6 +344,10 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	int count;
 	int rc;
 
+	rintc = (struct acpi_madt_rintc *)header;
+	if (BAD_MADT_ENTRY(rintc, end))
+		return -EINVAL;
+
 	if (!rintc_acpi_data) {
 		count = acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, riscv_intc_acpi_match, 0);
 		if (count <= 0)
@@ -354,7 +358,6 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 			return -ENOMEM;
 	}
 
-	rintc = (struct acpi_madt_rintc *)header;
 	rintc_acpi_data[nr_rintc] = kzalloc_obj(*rintc_acpi_data[0]);
 	if (!rintc_acpi_data[nr_rintc])
 		return -ENOMEM;
-- 
2.34.1

