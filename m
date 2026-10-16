Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7973F1054;
	Fri, 16 Oct 2026 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145428; cv=none; b=jMXHk3MtdEgGiXaNFStNpVQC9jpXEZ694pBDyaovzERzjprVT6yg9zBICs9WdoWHkuntAJDZsIaCw6IjsDwTENm53Vap6enorrkaHpVecsiOyXuQqNhlTCu0Ug3NMnICvpvmBwyRu4tMeYGXA7sdWiFEFyXNzSE9GEpmOByHu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145428; c=relaxed/simple;
	bh=5fLqioD0ao+XA2PssWwErpeR94sUcN5aFx0YSu5l8Js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oH1HvZ+ZKBCByV+rMILt0Y+nXWTmlr0as3YXBZikQOUUbQoim5iTXxx0XuxipEZ9DHS8Dqfv1LQ5YVQRvLLcwoavlvUrAy2nskWfQ6n9eAzyAwl3fozZ1pB2m8TPVfwlPkmP+X/F40sLYZ6eZDYYWjV43mx5CMTt5C6D7Jp4fKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j5gfz5nCdzb0pbZ;
	Fri, 16 Oct 2026 18:10:19 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.140.201])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j5gfy1DSbzb0pbZ;
	Fri, 16 Oct 2026 18:10:18 +0800 (CST)
Received: from l440.zhaoxin.com (l440.zhaoxin.com [10.29.8.13])
	by zhaoxin.com (8.30) with ESMTPa3933d93ac6a63e0e34370cbc9f75106
	Fri, 16 Oct 2026 18:10:17 +0800
X-Eyou-Smtpauth: weitaowangoc@zhaoxin.com
X-Eyou-EnvelopeSender: WeitaoWang-oc@zhaoxin.com
X-Eyou-From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
From: "=?UTF-8?B?V2VpdGFvV2FuZy1vYw==?=" <WeitaoWang-oc@zhaoxin.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	den@valinux.co.jp,
	linux-kernel@vger.kernel.org,
	WeitaoWang@zhaoxin.com,
	wwt8723@163.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3] x86/apic/msi: Fix MSI interrupt affinity configuration
Date: Sat, 17 Oct 2026 02:10:16 +0800
Message-Id: <20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <weitaowang-oc@zhaoxin.com>

The two step update sequence in msi_set_affinity() is required for MSI
interrupts which cannot be migrated atomically, i.e. devices which do not
provide MSI masking. The MSI message update writes address and data
registers separately, so such a device can raise an interrupt in between,
which results in a message built from half updated state: A stray
interrupt on a stale vector and a possibly lost device interrupt.

The update sequence is selected by a per interrupt quirk flag, which is
set for interrupts which cannot use reservation mode. Reservation mode is
only enabled for maskable interrupts, i.e. devices which provide MSI-X or
mask support, so the quirk flag is the inverse of the reservation mode
bit.

The removal of the quirk flag replaced the flag check with a reservation
mode check, but dropped the negation of the removed condition:

    - if (!irqd_msi_nomask_quirk(irqd) || ...)
    + if (!irqd_can_reserve(irqd) || ...)

As the quirk flag is the inverse of the reservation mode bit, the
replacement inverted the condition and selects the wrong update path for
every interrupt: Non-maskable interrupts take the direct update path
again, which reopens the race, while maskable interrupts needlessly go
through the two step update.

Restore the original condition so that the direct update path is selected
when reservation mode is enabled, which also matches the comment above the
check: Direct update is possible when the MSI is maskable, which is the
case when the reservation mode bit is set.

Fixes: b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Reviewed-by: Koichiro Den <den@valinux.co.jp>
Cc: <stable@vger.kernel.org> # v6.1+
---
Changes in v3:
 - Rework the changelog as requested by Thomas:
   https://lore.kernel.org/all/87jynid352.ffs@fw13/

Changes in v2:
 - Change the Fixes tag to b56ebe7c896d ("x86/apic/msi: Fix misconfigured
   non-maskable MSI quirk")
 - Update commit messages for clarity

 - Link to v1: https://lore.kernel.org/all/20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com/
 - Link to v2: https://lore.kernel.org/all/20260930155213.4380-1-WeitaoWang-oc@zhaoxin.com/

 arch/x86/kernel/apic/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3e79db..da5f44a80313 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -62,7 +62,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 * - The interrupt is not yet started up
 	 * - The new destination CPU is the same as the old destination CPU
 	 */
-	if (!irqd_can_reserve(irqd) ||
+	if (irqd_can_reserve(irqd) ||
 	    cfg->vector == old_cfg.vector ||
 	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
 	    !irqd_is_started(irqd) ||
-- 
2.32.0


