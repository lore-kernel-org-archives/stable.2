Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163675;
	b=H9dcEUHzEU/bHlUCmazTR/VGCq7iwje2qvHvd+cJEmBO5IH+fNoTtolygvtXLGUFdQQn
	 ejubbA6l8FDUFMmduuCpf7gZ9gqwKCEwM9FJdis0ZR/Fi/iE9nb8Bl4IX6T1dWKunZ20/
	 SThTTZTJOOshhwT1a4JNZKBEDM5Cl6luXf5SjHOc+/rz06KZNTpfKkJt2aDK84nKCnxqu
	 cFGpQDzFCYZH4dpZuepUr5BcIFp2pLmdroOVfMX7ILueUXZizw2zUVyzbh32DK6Q7BScK
	 y86Ns+pTUI5ufKqgcGyVf+elJ+yVxSxEFP+/F59q5E9jkQR4RV+rUxTN6QoU/gac/Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=AwH7ysFtsnsarThHtf7y4gBrmg4OuM1XkF+YgRBc5/c=;
	b=yex+qn09IyRA3psZSQr03UWPifPUOnvbbZSepPhMoZQpHxchh54aPVMlnvR5GN5kKfeg
	 yPbrp8BJQHlNCxpSLQ7jkHYO++yKgq8A7pDV2hT6ESDjbB+x00yIsTcB6gl3I/+hUMyy7
	 P2YsZbYxS4V9F4oT2Cxm0XemYPwLLqrYxLcLjHNHnofUKO2d8n5eDM99SE5vRD6RiiRPq
	 OmDZx3V3cPKXGH69bccaFxHG//Gw9X7/JSAUBZs3ypAQ6bM94LAd+GNGwqd/omtguNhII
	 7wnkW+8MMZhAfT/qLt31VpGjV0ULO/lZpRGF9OO7uDCiIT/fT3aFthGBuClxojzdUhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WFYqKf0u;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C542606A31A;
	Wed, 28 Oct 2026 05:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C542606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WFYqKf0u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Aw
	H7ysFtsnsarThHtf7y4gBrmg4OuM1XkF+YgRBc5/c=; b=WFYqKf0uT1ID2zTvEz
	Gu/F9rbVgskRHWiBO4o4/gV5zeFPtmJ5SyxOko8QcE570G0UvG7NqKCIr0Abp01s
	U/yETfsXZd8yPB3TFTANEYyGSWLNgLP70ZVybB+qLrA3T8NC8GWx1Ik51Wbxt2ps
	1675dILWRnCbLfg5hR5TskHeY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S6;
	Wed, 28 Oct 2026 13:00:46 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/12] irqchip/gic-v5: validate MADT IRS records
Date: Wed, 28 Oct 2026 13:00:31 +0800
Message-Id: <20261028050039.121080-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028050039.121080-1-yaojiale02@163.com>
References: <20261028050039.121080-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry5Wr1fJw4xtF1rWr1fCrg_yoWDtFcE9r
	yDXF97JFWrCF18tr12kr13Zry8K34DuFn5urWjqFn5Jw4kuw4fuF12qrZ5Ca1DJF4vyFn3
	GrZxur1S9r47KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyEEUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B6SzGrhgX5V+wAA3q

The ACPI probe validator reads the version from a typed IRS record
without first establishing its minimum size. The accepted record is
later used by the initialization callback for further typed field
accesses.

Reject incomplete IRS records in the validator before either callback
can use them.

Fixes: 35866efa52fe ("irqchip/gic-v5: Add ACPI IRS probing")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 8c0303af71e7..8451b780b0ea 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -1309,6 +1309,9 @@ static bool __init acpi_validate_gic_table(struct acpi_subtable_header *header,
 {
 	struct acpi_madt_gicv5_irs *irs = (struct acpi_madt_gicv5_irs *)header;
 
+	if (BAD_MADT_ENTRY(irs, (unsigned long)header + header->length))
+		return false;
+
 	return (irs->version == ape->driver_data);
 }
 
-- 
2.34.1

