Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626444;
	b=KKiSt+TpmCwT5cN1yxj8WTt/o90aMDGVK9og9Ji8gdJG0o+vkSwsJedoeNB+lrj/x8sN
	 8ijGeNe5gcfPiQcszOFjf6Zqh0ND3gxYmQZRaXVtHawDIms0xYVKSc5Vr9HEt1Z5o+Uog
	 nMXWBs5vtqRLFAW3yI2brItkx6qa+YyQcxrAwZzff/WF6CdC3LWiBV5PsO9kwgR4qtBSq
	 rB5NL/lZBCMm42NPLRgxYVDMpxCL8pqhfCCNKjY/PckoMbzHIFv8xQXRgz8nMOvHO8Vxp
	 8EDradq0geZtzsxXEBta42EOJScNxLSjDpRY4J8wuXqTrE16mLUxhim+lXX4D5p5Mvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626444;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=alxGzPQfi7xFVYa0w5MWB3+Rmx+g2BzBmVB8Eeu41Gc=;
	b=fHMUN2PPmoCYtIBZMAVXoZP9MD7D2pACQs/pa44Ovfk2Loo+9CEGsEKJMtqMIWHwiMyb
	 OmMfgQNdSBe8/8uRJnoSZLIujLVZOunHlase1ZMW4LR1ATjccwsvqvAHlQBc/dwwCQcs6
	 qBtRyXghDcORDslCmaoqKPclO66hu8MHLUNDpvJ01jw/3rFSMmAYeZ29LPBQ+g1FeTLOQ
	 CwjLePGI2LYHmSd71um1dBC5XiXSIW8LqV6EAQomtxwf0mBDeIiHHybWfjFdvtzM4tv1m
	 yeLmDhcTOH3xDe4g/o+G9l3kgjmvtacHaw9yZZAuK+X07HwRsso44enUMPjVkPOAqmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y8WQBpyT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3A606A332;
	Mon,  2 Nov 2026 13:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEC3A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y8WQBpyT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F20AA2A6B;
	Mon,  2 Nov 2026 05:33:59 -0800 (PST)
Received: from e133894.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A418A3F632;
	Mon,  2 Nov 2026 05:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793626443; bh=/DcnFSYTB6ZcFv8Cx8gN1oloDDlfm+K2pxLZErDmOkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y8WQBpyTRckWznroREPgE9PC75uv4j9iis5u6pclJVUnpsBUMiewXnFDg4Ce+7apn
	 c95ZRm+3nA8O/gJ+Bg/inbUkJ2J/cXiVEdBFjeCnnIlR+gFmZmb65QHm61eZvKa0jO
	 kJeCzIEayf9InJX3VvGJd2AHhaqYirH0IMsRB6F4=
From: Sascha Bischoff <sascha.bischoff@arm.com>
Date: Mon, 02 Nov 2026 13:32:56 +0000
Subject: [PATCH 03/10] irqchip/gic-v5: Serialise IRS synchronisation
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
Message-Id: <20261102-host_gicv5_fixes-v1-3-743b61626fc5@arm.com>
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

IRS_SYNCR writes are ignored while IRS_SYNC_STATUSR.IDLE is clear.
Calls to gicv5_irs_syncr() for different IRQs can overlap, allowing
the second request to be dropped. Its caller can then observe the
first request completing and assume that its own events have been
processed.

Serialise the request and completion poll with a raw spinlock. We use
atomic polling, as the lock cannot be held over a sleeping wait.

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

