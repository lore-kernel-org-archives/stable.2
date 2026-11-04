Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814511;
	b=NHmsa+CP5zBNAZowCnHxrVlfDZigzTel3cXKjKLs6hRv5VuS8AQwZ+OEgNpnR1et6k1G
	 AhX6iqez5EwYPKNJnFMi7SI4D8xKSgOT96YgbLA2OKteesAlPuEWg+yMxQ1xY6ZV7p6/Y
	 ejT5tCpL1G2Vi5baEhvrDTg96YKtKrIH/Y8/2tf9naaNm/SaYBG2pPabykttWRMBf8bFm
	 TLIyrgLyvmgnkcI/ApXOUTRJmrDqUsScZB2O0wpcMqS4KokYufKnuQ31kdoamSao6u5Di
	 mtCrhHfcKHl/p0umP36Pe1NPz6h89fr22VkXTfg4OenlHdpKYDATos7R86S2wJQB34A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814511;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=9IAWjxD3DMvTDRO0xLFR7+UDIhICAFaUwIwlraihADE=;
	b=NalptonXievFGe68Brbd2Qs4o3xzIHUtDNPtLD0XZJm4JdrfO5XMXGOVqwCckxPt/pDx
	 kgMKwv0fSjD+nUDy9u0PLSmIj5ns51Ikfx+ZhDL1bKxfRyTsWABOVRQdTXve7ECDwVEMd
	 fJoG1bBAsg/Wf0oBTrfD8mRv6zsCyUqYIKNSTM39siipllzZ3sBas1UJrUL4URy5k4wem
	 /kNhzfooOXAaDlsaUDmSApw+JxjANVHMm/xCqL/6C+M0XBqrHIzZ75DGnIc8EKYpn7nPA
	 y9cCHeWIuN53LCaIeCDNbmCIXO2vAAC2HtHwdtPK1stUlVAV+mdRF0xISxYWQpn5Zpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BQLJocJt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818FD606A31B;
	Wed,  4 Nov 2026 17:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BQLJocJt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E6DD1BB0;
	Wed,  4 Nov 2026 09:48:28 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16FA3F673;
	Wed,  4 Nov 2026 09:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793814511; bh=jo2GN/hFb0lgn/s0Tey5xXl+2KKgsiXUYhJCLTe/amA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BQLJocJtCPOH0ThM+oAXzW/2w/9xfgle4dQ2OpUSfez5t9xsISqSdDo3pGf1twLWM
	 keKUokDMp6laEM3ymDUr7iOo1Z1BbdGYsBdiPwFYo+zz9NVlYaQ5Eo3gy7yGj8M8s/
	 lPfP+QP0Sjqe5htLrwhmuyBqarLRCBu4lO9+Jb8o=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Wed, 04 Nov 2026 17:48:00 +0000
Subject: [PATCH v2 06/10] irqchip/gic-v5: Honour ACPI ITS noncoherent flag
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-host_gicv5_fixes-v2-6-e47ad20ea3c8@arm.com>
References: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
In-Reply-To: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
To: Marc Zyngier <maz@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Timothy Hayes <timothy.hayes@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Bischoff <sascha.bischoff@arm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The ACPI ITS probe passes its noncoherent flag to
gicv5_its_init_bases(), but the common initializer checks a DT
property instead. For an ACPI ITS, this always selects coherent cache
settings and skips the cache maintenance required for its tables.

Use the noncoherent argument, which both firmware paths already
supply.

Fixes: a97efa5ba5946 ("irqchip/gic-v5: Add ACPI ITS probing")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 drivers/irqchip/irq-gic-v5-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 866c238f08dfe..c5d057f713134 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -1135,7 +1135,7 @@ static int __init gicv5_its_init_bases(void __iomem *its_base, struct fwnode_han
 			goto out_free_node;
 	}
 
-	if (of_property_read_bool(np, "dma-noncoherent")) {
+	if (noncoherent) {
 		/*
 		 * A non-coherent ITS implies that some cache levels cannot be
 		 * used coherently by the cores and GIC. Our only option is to mark

-- 
2.34.1

