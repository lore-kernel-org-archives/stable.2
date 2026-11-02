Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626446;
	b=3VxxhvP5QIaj/Dv5rTbZRy1lFEK5OWustp0U0mbMvuyb2dRxL/AEzChxNaigStS1Qkoe
	 vSK3XJatv72iHOAYC1BbbFBW0cGoQAPD80DNLfsxOXYcstfpvsYF/AgbC/XX1sBJp+gO/
	 FCX0aLOFkWFPcipV9eP7iteamXopfrFi33ZzYVOiN4DR+ghACq6ttX0BWeh6rXUApH+JD
	 HzK0ziZyoTrnafl3v9SI/h3FKKQBfxBcFRlGt7rvs/PDZRiSkmDYW/tRbYCxlOUXyZLkX
	 9v5DyYmmxDBdsLSZNY+i0HCGtFv8t2ZQrIRYtBFz5x1Pc3SuSUxoya2GK9ycAzwILNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=/Fb95WO+X8v06jZrkXXHht7WDZPwxevm7hMxulxYxIc=;
	b=KWAtXpn+Y5wf1UoazU4UBBeExVn32sCdnOKMHoe+JSNi7lMpBoCRzXW3sFcpbFhUEe/m
	 B30FU1jqdH3QPjOMPmTIdOOea+Rtpemb9pJnDtN4kD1TbP58/cZec4cDIxZQjw5N7c9vR
	 9ohH5/JwSTw8hiLLIv7VIGTDUlTH3g+g/zQMPDLDWGa54/1bV04KJEI9wDqHNCWWfgVMk
	 ijXpm6JdJcfk49PhVqudG8rU8kSSco8TGfwZSAJhYgBD8EuupX8yzjEBwiRbgxswDEMIW
	 l4LO1fNiSAReL01Fz3wBs1UFCIt2nD7wzsC4T7CQD5Ag5EzDUCv27yWuONA1vCEjZ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Adth/rsi";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C36606A331;
	Mon,  2 Nov 2026 13:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C36606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Adth/rsi
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD0DB293B;
	Mon,  2 Nov 2026 05:34:01 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60E5C3F632;
	Mon,  2 Nov 2026 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793626444; bh=bD9rlQDKHyOiE9nT0AbTN/RbsTQ4e0AyIUIXhcDOhyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Adth/rsihER15P7eY4/ZwvK5D+y69d8JBfI/IO91ZCD9hPWM/98c54qcYUwxMgCvb
	 p7Vyj5pAceGggFM1ueLwKWRmQeVMOr4mQU31xKNg620e9tclfK1O//dWX74r4bIPnC
	 UacSDh3xn0p/UBT20FBc3LHsTnlT0/yxmpfJtQXg=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Mon, 02 Nov 2026 13:32:57 +0000
Subject: [PATCH 04/10] irqchip/gic-v5: Serialise ITS invalidation commands
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
Message-Id: <20261102-host_gicv5_fixes-v1-4-743b61626fc5@arm.com>
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
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The ITS uses DIDR and EIDR to select the translation to invalidate.
These registers are shared by all interrupts targeting the ITS. Event
invalidation can run concurrently for different IRQs, and device
invalidation can overlap it. The per-IRQ descriptor lock does not
serialise the commands, so one CPU can accidentally issue an
invalidation using another CPU's DeviceID or EventID.

Add a raw spinlock to each ITS and hold it across the command register
writes and the STATUSR.IDLE poll for both invalidation paths. A raw
spinlock is required because the forwarding path calls the event
invalidation helper with the IRQ descriptor lock held.

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

