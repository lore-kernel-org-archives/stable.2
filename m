Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B03386C13
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451344; cv=none; b=omZirG+b5AKhHH3DJNxW8k2qAWWvLGV6tOhGtBXdDccgNK24hgqdllR6z/7YVFZ9w1PNZBKcwvWyohx0t7RKEe1SGYeYTerBhWE8s1kcGAFUiUHzc/WbIUILyWnfUYBuEaVQB/Utu/+mOmvP0Vi6ELqDL0HNtIs5P+zE+HurLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451344; c=relaxed/simple;
	bh=7wp1kWs+QgJguMz/3ql2nzYAizeYa5SfMN2gcbV8kko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMa4PWrjhhKo5qqlY0YG69B6k8ESzf3h1M63cKm7JfyXwl1Mt53uxN9j8Fn8uQZ29kO6Bf3j0JlBZxXlLsbsXDPC5azIsJlj5HId6GQAEEKvxCSmKbUnntd4YyYViGmjpzbhQ6rwwNBJFfD3EXUCx9cmpjouiUac6QTn2bLLfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=arulWcLm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="arulWcLm"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4358620B7135;
	Thu,  3 Sep 2026 09:01:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4358620B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788451300;
	bh=wK1DCIO7DfIXRSXB5ITwEoflz+/TBhaZbDlM1pseWQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arulWcLm/GAlFG82DTD77tQBUGxgZGI7tsfr+dflYIo1dufFrKOI0di9cquVj61yR
	 kQ1MMUHea7PCzPmUlvGbZ5SbHoVxH9ggUcGyW8G23Nh3ey+dt9td/qbwtkh50Tj3mg
	 J7HhuefxU+28ntIOzScPJRfZObo9Hhjm5+jq7Vtk=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	gargaditya@linux.microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	shradhagupta@linux.microsoft.com,
	tglx@kernel.org,
	wei.liu@kernel.org
Subject: [PATCH 6.12.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 16:02:11 +0000
Message-ID: <20260903160211.18606-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026090341-dealt-backless-3cbe@gregkh>
References: <2026090341-dealt-backless-3cbe@gregkh>
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
index e87e54acff4b0..e9bdb4aa3b9ba 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2051,6 +2051,7 @@ static struct irq_chip hv_msi_irq_chip = {
 	.name			= "Hyper-V PCIe MSI",
 	.irq_compose_msi_msg	= hv_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 #ifdef CONFIG_X86
 	.irq_ack		= irq_chip_ack_parent,
 #elif defined(CONFIG_ARM64)
-- 
2.43.0

