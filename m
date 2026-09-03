Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7944E66C9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451778; cv=none; b=PbngRzgLClxMJea8mK7A/3WrkOkeHqm7rrX0adybRXSi/PYoMwo/Tgxz21N5UQO7QlDDzFjpZ7uO96uNI5HlGb+cQMj8NRAm4Ydl6ak97wxO3Uhz3N6OMttL5Fwan+3I8lGz3IYt7miJInfC1VJ7kmaUBcr5m1STgDmBiqekKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451778; c=relaxed/simple;
	bh=3t8TSRHLgsruODs8g93S7xT69TcJqB9/taE1x1e1Qog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk2ThIYAVocj/quCJjXY6up/jdQC6mXLItz1RCHZ2jQAsU4Qk/8ODlms6Kk3Dv19w6j/qm35DsIC03Ob0RVPxd4NonlJBy20KL3IeIkus6y89YN2I2MJ2mBK4z96Ax3jKeTBlTahu8YB+UjjFytVVnEgqLspKo+4BUDGiwezq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rpv/eUuh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rpv/eUuh"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D58D20B712B;
	Thu,  3 Sep 2026 09:08:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D58D20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788451739;
	bh=uhKZ0j2GG5ww69L8N6+F1WTfR4MZPj6Iu12FQXUltpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpv/eUuhdiJTjkebiJTLl26yUM7CihiibbgybIt19hVtfrqEGrOjHu7Ygo8V96kyA
	 EoznoOA8TFQ8SGVKq1VnHuQn/+BMt+9Rxx+kYJWySq9sdst2GGuhQVu5QyLYaEuTVt
	 YsMiPmr8tM2AATvmP69yoqsrQDMxtF4c2vkptIRY=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	gargaditya@linux.microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	shradhagupta@linux.microsoft.com,
	tglx@kernel.org,
	wei.liu@kernel.org,
	namjain@linux.microsoft.com
Subject: [PATCH 6.6.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 16:09:30 +0000
Message-ID: <20260903160930.36419-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026090342-landlady-deflected-5dd5@gregkh>
References: <2026090342-landlady-deflected-5dd5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.

On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
the outgoing CPU to a new target. If an interrupt still has its pending bit
set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on the
new target through the irqchip's irq_retrigger() callback. As the Hyper-V
PCI/MSI chip does not provide that callback, the pending interrupt is
silently dropped, which can result in lost interrupts, stalls and "No irq
handler for vector" messages during CPU hotplug.

Install irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent on its
new target CPU via the parent x86 vector domain.

Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Cc: stable@vger.kernel.org
Suggested-by: Long Li <longli@microsoft.com>
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
(cherry picked from commit 86bdd16e8f390d51bae9e77a4bc4164ca2f580fe)
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e379ed9b5d2eb..94ee9d19a48bc 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2058,6 +2058,7 @@ static struct irq_chip hv_msi_irq_chip = {
 	.name			= "Hyper-V PCIe MSI",
 	.irq_compose_msi_msg	= hv_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 #ifdef CONFIG_X86
 	.irq_ack		= irq_chip_ack_parent,
 #elif defined(CONFIG_ARM64)
-- 
2.43.0

