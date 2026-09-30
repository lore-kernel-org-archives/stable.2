Received: from zxbjcas.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B543DEB1;
	Wed, 30 Sep 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.127.214.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754798; cv=none; b=VWpxvefCMIpxehR6Zeq1OARHQwyKZ5tQWCg2AQ8MROyPGrJfnL3mDYe/RTQnjURZ+552LkI9GblGIMbajwauXmr9L5Dq+UX7iwK70Xf8bx+LhHR11KTTe1mdYVVhndd3gsd80bHRePXFQpLRd5YXX4MGvbV5B+h17eod9RHYI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754798; c=relaxed/simple;
	bh=l/huL85Muhhw619ot6PGQrERTL6C1cXK8DTbTlcclME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLt+4LEIs4NPEg0JVj/lC4k8hX1B1tS7O/hfXPal9piKetWnMr2YBGPzD0Cm0o/vBj34PnhguA8yJdMUW5j8VR+jfNn44ujxZu7NKLQMCBBVlbKrROIHLImBZjVThh2HGi5D0MPgyXQBXNIajMNpqgUqEn85IB6zPsz6YzBxO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=124.127.214.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com ([10.28.140.201])
	by zxbjcas.zhaoxin.com with ESMTP id 68U7qFVR024112;
	Wed, 30 Sep 2026 15:52:15 +0800 (GMT-8)
	(envelope-from WeitaoWang-oc@zhaoxin.com)
Received: from l440.zhaoxin.com (l440.zhaoxin.com [10.29.8.13])
	by zhaoxin.com (8.30) with ESMTP3afab7396dc9d04bb008f43b0e4e50f6
	Wed, 30 Sep 2026 15:52:14 +0800
X-Eyou-Smtpauth: weitaowangoc@zhaoxin.com
X-Eyou-EnvelopeSender: WeitaoWang-oc@zhaoxin.com
X-Eyou-From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
From: "=?UTF-8?B?V2VpdGFvV2FuZy1vYw==?=" <WeitaoWang-oc@zhaoxin.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        den@valinux.co.jp, linux-kernel@vger.kernel.org
Cc: WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
        stable@vger.kernel.org
Subject: [PATCH v2] x86/apic/msi: Fix MSI interrupt affinity configuration
Date: Wed, 30 Sep 2026 23:52:13 +0800
Message-Id: <20260930155213.4380-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <weitaowang-oc@zhaoxin.com>
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:zxbjcas.zhaoxin.com 68U7qFVR024112

commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
race. Maskable MSI interrupts use the direct path to update configuration
info. However, the current code logic is the opposite as only maskable
MSI interrupts will enable reservation mode. Therefore, when using the
reservation mode in the function msi_set_affinity() to decide whether
to take the direct update path, polarity inversion is required.

Fixes: b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")
Reviewed-by: Koichiro Den <den@valinux.co.jp>
Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
Changes in v2:
 - Change the Fixes tag to b56ebe7c896d ("x86/apic/msi: Fix misconfigured
   non-maskable MSI quirk")
 - Update commit messages for clarity

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

