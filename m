Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814506;
	b=rqHdU0DIL+aJUTKS2PTTipl2vs6/Zx7u/XyLrw/YVqIi4e12uPKcN3422hop6KjvWxAn
	 ASAU3zpvXtlRsdlkL5mZpuOsw0Cuu8cJXvj4+t3i4F1oMf10bduIfigh5BKsWAxF/NM+9
	 Nf2toZ5Vgv2Emx+yoKUiVU5DPjT/m7xeDqiCtCYAorxj64cWNYv8IBy/A/dIHMDNsoCWM
	 aCk3y09SRXPanxjm+naSfNMRc85trPC9yHI7ayRKylZkpMuSXIshi4UZLXleZPlIQ2arg
	 2TcuNG/g8nIlBZNN4qqm0JlDNY7+9wBCXpiSQTm/z7ebWapQsENTmIHw/sEms2J1roQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814506;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=5mDmVcyfUCeEAX8H66OPCvcSV/Zj8eOdzhf6RFoRR/s=;
	b=cZYgHCIawxshIVFNdcaitsmBUEGP+EMvTOX2UonuvM2p9ydiYucOBt9Fix1k3et1x2pg
	 iI/wbAOtHWFhuuSi5fuQgfzEeK7yl5/6mbomz+DOiETo/OScLKemIEyVDh6PR7e+EapO6
	 iMPcUD8nrk7kKkx9ZnDzvGf/yWxOhI8Dfu1Gh/8R/RJJnZUCFMH3BUn/w+qE9MMjXUpFc
	 Uc2juJTIyDytS31gEB0qSnUmOPrnCBIJXhA57GNmqQTcQpurs9uqM+5AsP6Ucm86P5yeI
	 +XpnYz2RGZnKtiMnH8dkzVP/khpIATnHIoyiu4UDRrRk4FTmP3Iph0avOItPqoTSa+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YjKyDO0M;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B56606A32E;
	Wed,  4 Nov 2026 17:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B56606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YjKyDO0M
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D711F91;
	Wed,  4 Nov 2026 09:48:22 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74D473F673;
	Wed,  4 Nov 2026 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793814505; bh=rtHBnwtVq7g8hs8r3SVgFVZrZGzkMLR5iSHNEjAFp9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YjKyDO0M4UEGryr6fyL6FBYC6HZ6eECnV3V+dxb5ODIgwnY3mebUd21YeLEU1TtSe
	 rAVvji1D/DD+l1pUmuO2P8FVfcf1XM2G+XjZim4HHiGReUxiwdSzJesyNhlq2ApjfF
	 mRZ32i4fTeOM6h/djSfu9/l0VO/ebe7nLZn/42IE=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Wed, 04 Nov 2026 17:47:57 +0000
Subject: [PATCH v2 03/10] irqchip/gic-v5: Serialise IRS synchronisation
 requests
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
Message-Id: <20261104-host_gicv5_fixes-v2-3-e47ad20ea3c8@arm.com>
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

IRS_SYNCR writes are ignored while IRS_SYNC_STATUSR.IDLE is clear.
Calls to gicv5_irs_syncr() for different IRQs can overlap, allowing
the second request to be dropped. Its caller can then observe the
first request completing and assume that its own events have been
processed.

With GICv5 ITS KVM support, gicv5_irs_syncr() is also called while
restoring the host ITTE in gicv5_its_set_vcpu_affinity(). The callback
runs under the IRQ descriptor lock via irq_set_vcpu_affinity(), so it
cannot sleep.

Serialise the request and completion poll with a raw spinlock, and use
atomic polling because the synchronisation runs while holding the IRQ
descriptor lock.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Cc: stable@vger.kernel.org
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 drivers/irqchip/irq-gic-v5-irs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index 4edf787f3f97f..ead76560ea08f 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -10,6 +10,7 @@
 #include <linux/log2.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/spinlock.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v5.h>
@@ -22,6 +23,8 @@
 #define LPI_ID_BITS_LINEAR		12
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct gicv5_irs_chip_data *, per_cpu_irs_data);
+/* Synchronization requests must not overlap in an IRS Domain. */
+static DEFINE_RAW_SPINLOCK(irs_sync_lock);
 static LIST_HEAD(irs_nodes);
 
 static u32 irs_readl_relaxed(struct gicv5_irs_chip_data *irs_data,
@@ -507,10 +510,11 @@ void gicv5_irs_syncr(void)
 		return;
 
 	syncr = FIELD_PREP(GICV5_IRS_SYNCR_SYNC, 1);
+	guard(raw_spinlock_irqsave)(&irs_sync_lock);
 	irs_writel_relaxed(irs_data, syncr, GICV5_IRS_SYNCR);
 
-	gicv5_wait_for_op(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
-			  GICV5_IRS_SYNC_STATUSR_IDLE);
+	gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
+				 GICV5_IRS_SYNC_STATUSR_IDLE, NULL);
 }
 
 int gicv5_irs_register_cpu(int cpuid)

-- 
2.34.1

