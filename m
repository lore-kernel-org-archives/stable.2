Received: from zxbjcas.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534E4848B2;
	Mon, 28 Sep 2026 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.127.214.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585424; cv=none; b=E7BWum/WdEyFrQ0z2LLeOkpQJXFs1SoNGwR3Hz/9ebHL0kqNqH4+RxeG1o/3EIhh9OJdXc7NDaJRHip+Na97MIKo27QraMYpuR7hAVZ3CJ+uxQW5yKG5G6JU0E8/rF3WO3syRzSfhB8IEt1/t6uGtOIRIGiRQedqaqsgpTZ4oFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585424; c=relaxed/simple;
	bh=C5GDaLXktEPtefgGKegcE6hqUiQsl/W8y0ysgY8wxpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r+hPTJrawGVFsOKBpgm+cupI9wMPCuudBJfrN1XIADRx463CfoIx3kUyDU7Ca0t+5jZMfsrb89OqCe8B2XCWgheJJHdkBmEwyVP67yaEO7Y3WxtLoWOU3aBYtPknAJplA/Mp4oWZ9pB7Wfp5CYq+XzQ+9ifJZm3vU35jRYelg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=124.127.214.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166])
	by zxbjcas.zhaoxin.com with ESMTP id 68S8mgRA083540;
	Mon, 28 Sep 2026 16:48:42 +0800 (GMT-8)
	(envelope-from WeitaoWang-oc@zhaoxin.com)
Received: from l440.zhaoxin.com (l440.zhaoxin.com [10.29.8.13])
	by zhaoxin.com (8.30) with ESMTPdb53bc35b7cf779f6b95a27134ef50f4
	Mon, 28 Sep 2026 16:48:41 +0800
X-Eyou-Smtpauth: weitaowangoc@zhaoxin.com
X-Eyou-EnvelopeSender: WeitaoWang-oc@zhaoxin.com
X-Eyou-From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
From: "=?UTF-8?B?V2VpdGFvV2FuZy1vYw==?=" <WeitaoWang-oc@zhaoxin.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        den@valinux.co.jp, linux-kernel@vger.kernel.org
Cc: WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
        stable@vger.kernel.org
Subject: [PATCH] x86/apic/msi: Fix MSI interrupt affinity configuration
Date: Tue, 29 Sep 2026 00:48:39 +0800
Message-Id: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
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
X-MAIL:zxbjcas.zhaoxin.com 68S8mgRA083540

commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
race. Maskable MSI interrupts use the direct path to update configuration
info. However, the current code logic is the opposite as only maskable
MSI interrupts will enable reservation mode.

Fixes: ef8dd01538ea ("genirq/msi: Make interrupt allocation less convoluted")
Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
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

