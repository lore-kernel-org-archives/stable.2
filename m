Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626450;
	b=vkC/JmPRfQXstrbKIqlD8flv+5ez9WDOWfAbTJITorFKDoKPoIkCysueFJEOAiu6Up8B
	 fjxDnuWjFCfFsjNo79Qfesp4bax7icXBZu+WPuFR72UsfeSchi2z6ftWjRULBYP+VNG2H
	 Kcyw3TL8ccXKzSv+YkcorUmbFIF+s8Fi6yJuJrk05UEDMn2y9njHqZ5KDdAJlAU0mBN5t
	 0/Z7UZl8VNFqpSXyGJQJfoPDNoWTguVyq7I2+p7Are1IjZswVlKyvR8JPwPffLheLBlRA
	 2bcgK2RVfRlAOCfzxLRuhu5WrAvYnJaPccEkDUebwma6GGJA0vDCr3NKC+LFfttpHMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626450;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Q8znRvI0VTrl4E0TMpGoTe5ad2gAMpin+AN0qRYm0Gs=;
	b=yJHk18Jvpn1CbKC/LeWgTb2ReFLpVH+HDrNGiEPCzdmv8t52UnQweg0C3xz3lH6+rUGm
	 DYMpGdEYfHzboXB/EXWYAm4OqcYafJj290WR8a76LoX4OwDiRgZqhOqADuGRe2zoYqO+Y
	 YOYZQ+QNLcsFTxSS/9RvIB89ve2K+6wIsJQT8Mc2tH9DO7bGgrGcwJp5JI9ZN7Fijx5pH
	 9/ybeDnxnJ/YOD4PT9wPs61gkBLL6j0BOQpIJeX6cRYTpwsqFIultXr3kk6VDuRKP7Fof
	 cUrMfA8ccBsVQe67splEkFgrMM8c0K3g2/JbmXUS3XbhtlUl+Sq3P72M4wrFOh7fKSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uIDWGIhO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030C606A337;
	Mon,  2 Nov 2026 13:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F030C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uIDWGIhO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 453F62A6B;
	Mon,  2 Nov 2026 05:34:05 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6F93F632;
	Mon,  2 Nov 2026 05:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793626448; bh=9EjYXGrMhWNlI/LRxAdAiu7J1bzQdr57A+5D3tpgm8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uIDWGIhOT2+f2tNAFrP9hW7EypprwudOiPdIi4PtT8zndGm97Y+CzL4YWHKHmJYgY
	 aeKFSFS/ZwS5PdER6XTIqDTBSnlAAagg5zQ1XOmPM3+l0xQUB1nc7KfzAWYV/pMVQ1
	 LunqJYuXgab+ogqbuBKbwxQgMiHoY9sCwGph0MIE=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Mon, 02 Nov 2026 13:32:59 +0000
Subject: [PATCH 06/10] irqchip/gic-v5: Honour ACPI ITS noncoherent flag
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
Message-Id: <20261102-host_gicv5_fixes-v1-6-743b61626fc5@arm.com>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
In-Reply-To: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
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

