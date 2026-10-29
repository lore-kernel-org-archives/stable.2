Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246015;
	b=k1LaVL2H8L22ewKsnaeeCL1GJoJsLx78+LdhmqBgjHFJlgfRkScnblLXPjFkoQeADAhX
	 qWCyTfhB6XBTD0mt4GdsBXxFC2Fbo28xuhKAgMIxt0cLBWXS9UzOp5d6JiWswLXQ58+3p
	 O2HuIv8a988y7VjwQ41Ux3VXNs2Ip+DlOA/RjXBtpwzQKfgXmedc3+ocg1NuQYbj8l1Dy
	 PmjB1AsQC/s0fG03dDvDOCG1LT09/7CuFHh3lYCdyUG3QahAPl1Ie25jHViWX04EJuZBt
	 V8RaQFn/9F0BIMZ7mYOwbu2jxlRbOWxQiD5a3syw2GM8GLTZLJbkYHhknPM2tHC3q0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246015;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=LB8YpEUiZFUdxUpS3Yk2h4wJXrpFEdTYw4E3JAzYZ/A=;
	b=ZGwYkE5/RWniO24wQFzpm7cVkh2HaAn+RULILT60k7N6i8I37zvt5OpcVNTrX8HVq/e7
	 Nxu2fhNMHzm6Q8yTTJPr3LEU1mt3ReDoNR3682nplfHEz0Vkz311Kg7Ix7txFcP3994Mo
	 LEGHE7yPYlHoaMLWlRdBNBHRaOITLC+QtOeFWc3A15DxLC3RcVYFpZDFgmSEB3yhRtRMo
	 26x9mSTgKzLATOqh7fRKvyACkZZRNzdOKBt7JZdSQJbiDp1pTlnvvct5b0wzIoKIbzJfS
	 j1MBdZ+2+JeSrWwn85McpCupy4U2aC3UXN3iyfHUynG1z2j/12v9mKcKT8KKNaoiaxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z3pfWb1D;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E94606A31F;
	Thu, 29 Oct 2026 03:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E94606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z3pfWb1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LB
	8YpEUiZFUdxUpS3Yk2h4wJXrpFEdTYw4E3JAzYZ/A=; b=Z3pfWb1Dc6Qtm9LC9u
	iGe0hL57h4NuGis6KhNmHydKYwS2atUFVut3lpSai1+pj1iOf0e7tddizVrBvkQT
	qvH01dn/kYngO9Oqdp4rPBcLlaEcxVhzcVns8ctKo/d3jEGNwQvtiWgd8pEPbChS
	dJ7ywngz+xrBjEX6+fEz6Sclc=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S4;
	Thu, 29 Oct 2026 11:52:59 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Hanjun Guo <guohanjun@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 02/20] irqchip/gic-v3-its: validate MADT ITS entries
Date: Thu, 29 Oct 2026 11:52:33 +0800
Message-Id: <20261029035253.2333852-3-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWDGw15Jw45Gr4UGF47XFb_yoWkArb_Cr
	98WFn7JF4qgr48Kr1xKr4UZryY93W09w1v9r4vvaykKrZ5Z3W7ZrZrZas8Zr4DGFn2yFn3
	Grs0kr1Skr1ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8FoGPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRtKhGriwxvjHAAA33

The MADT ITS callback reads the translator base address and ID without
checking that firmware supplied a complete generic translator record. A
truncated entry can therefore cause out-of-bounds reads.

Reject incomplete ITS entries before accessing their typed fields.

Fixes: 3f010cf19732 ("irqchip/gicv3-its: Probe ITS in the ACPI way")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 282e4bafb084..8af88eca14c2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5736,6 +5736,9 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 	int err;
 
 	its_entry = (struct acpi_madt_generic_translator *)header;
+	if (BAD_MADT_ENTRY(its_entry, end))
+		return -EINVAL;
+
 	memset(&res, 0, sizeof(res));
 	res.start = its_entry->base_address;
 	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
-- 
2.34.1

