Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814509;
	b=nEyrlSq4O/29B89RT9Z5qoxbf9lmaiVbCNTi/usFMlOwMI4MVKI3uciGe6BsSukYvmXB
	 fg1mr1tsl23dnjW/1YTgBghNAzcY+GuEImGrpB9SEDuHQiWJ0mSwjbmDBVQL16jP45w12
	 FOuWhNdKMqqLPl69TaNUHbMr1JnLQYvZQWWJlsvFG86PKsi34t1MoBr1yabbHaz1L7M1f
	 G6wzx6XYpVoISC0J7uOT9XzyX1bWnzpcRj8VJKWeXoh+yk+P8vkN79WEG/0WA+y8CfSRE
	 5der4kMEKuGwOCk1jC00IyfBOgrCYO8GDLLRJDeT+344us1T4zlv6gRQWtQb2Mn22kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814509;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=GnvmlyONKXG3StzZQZPrfT4CiPWcvQaogfM+6aIAoTc=;
	b=oWkeWm3suLQDAODcA0cvNvywIBJXcCu47+Q++uYRjcZQHJBMCRQUOp1UwEFIzNqKAukt
	 GyowQpTrjayubI4XE7oqn7H4UBZNRo1oNkFUDMG1JM6S+ZZRPQ3OqAE9KVrA7vbykOFcY
	 8SCyMyouhnHesPoZWDlgrI2g8F2iZvGnJZ5rHS1g6P+909ySBBWdf9YxO2VFPfOczvDDb
	 tuLTI6O8YrH5m98xPwTLLXYSgCKz6+q87fl3CsOaz2r90OuRnTFEvSuD1XH07c+pxnSRL
	 YV5sIDhF5HDM7T/Ce79ZJ02viRfqvvgyLRXBXDuAW7N3YAAQ6FHq/exqvCszpWM5vig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TTKJdmTZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B245606EEA6;
	Wed,  4 Nov 2026 17:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B245606EEA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TTKJdmTZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D3A01BB0;
	Wed,  4 Nov 2026 09:48:24 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E9953F673;
	Wed,  4 Nov 2026 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793814507; bh=rTqtMW7FtCRoFiBrDDt6O3rKl4yH9JU2QTGJr1Aay+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TTKJdmTZZJQSqwQwYKDnTDr96PLOb5pZ0BlxD9O7uFxM+VICCbc4aBaPsVl2xdg36
	 04wI2ukogdFx5Fm6/T9JWtxtCF1R8hTeB+o0WzIvGURW4W8yxbzuXQizlKxaKwbObA
	 sUMxdlwTk43AB84vqaq7pyLRBvWwDwbKdKLicE2g=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Wed, 04 Nov 2026 17:47:58 +0000
Subject: [PATCH v2 04/10] irqchip/gic-v5: Serialise ITS invalidation
 commands
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
Message-Id: <20261104-host_gicv5_fixes-v2-4-e47ad20ea3c8@arm.com>
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
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The ITS uses the shared DIDR and EIDR registers to select the DeviceID
and EventID whose translation is to be invalidated. Event
invalidations for different IRQs can overlap, as can an event
invalidation and a device invalidation. The per-IRQ descriptor lock
does not serialise these commands, so writes can interleave and cause
an invalidation to use the DeviceID or EventID of another IRQ being
invalidated concurrently on a different CPU.

Serialise the command register writes and STATUSR.IDLE polls for both
invalidation paths with a per-ITS raw spinlock. The KVM
gicv5_its_set_vcpu_affinity() callback calls the event invalidation
helper via irq_set_vcpu_affinity(), which holds the IRQ descriptor
lock. This path cannot sleep, so use atomic polling.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11
Cc: stable@vger.kernel.org
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 drivers/irqchip/irq-gic-v5-its.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 28e39b065de0e..6d98f3dbe34b6 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v5.h>
@@ -28,6 +29,8 @@
 struct gicv5_its_chip_data {
 	struct	xarray			its_devices;
 	struct	mutex			dev_alloc_lock;
+	/* Event and device invalidation commands share DIDR. */
+	raw_spinlock_t			inv_lock;
 	struct	fwnode_handle		*fwnode;
 	struct gicv5_its_devtab_cfg	devtab_cfgr;
 	void	__iomem			*its_base;
@@ -129,6 +132,8 @@ static int gicv5_its_itt_cache_inv(struct gicv5_its_chip_data *its, u32 device_i
 	eidr = FIELD_PREP(GICV5_ITS_EIDR_EVENTID, event_id);
 	eventr = FIELD_PREP(GICV5_ITS_INV_EVENTR_I, 0x1);
 
+	guard(raw_spinlock_irqsave)(&its->inv_lock);
+
 	its_writeq_relaxed(its, didr, GICV5_ITS_DIDR);
 	its_writel_relaxed(its, eidr, GICV5_ITS_EIDR);
 	its_writel_relaxed(its, eventr, GICV5_ITS_INV_EVENTR);
@@ -371,6 +376,9 @@ static int gicv5_its_device_cache_inv(struct gicv5_its_chip_data *its,
 		  FIELD_PREP(GICV5_ITS_INV_DEVICER_EVENTID_BITS,
 			     its_dev->itt_cfg.event_id_bits)	|
 		  FIELD_PREP(GICV5_ITS_INV_DEVICER_L1, 0x0);
+
+	guard(raw_spinlock_irqsave)(&its->inv_lock);
+
 	its_writeq_relaxed(its, didr, GICV5_ITS_DIDR);
 	its_writel_relaxed(its, devicer, GICV5_ITS_INV_DEVICER);
 
@@ -1112,6 +1120,7 @@ static int __init gicv5_its_init_bases(void __iomem *its_base, struct fwnode_han
 		return -ENOMEM;
 
 	mutex_init(&its_node->dev_alloc_lock);
+	raw_spin_lock_init(&its_node->inv_lock);
 	xa_init(&its_node->its_devices);
 	its_node->fwnode = handle;
 	its_node->its_base = its_base;

-- 
2.34.1

