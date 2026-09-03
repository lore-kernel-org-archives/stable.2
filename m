Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249224B8DFC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447857; cv=none; b=VW8jN2JzTG+/AYc4iO6SyngWAuHO6DFbOjsbBYEa0wsqrUQcROj7VwLyiY5FmOp3D5Rya2q/1L6/4Z3KWcodc58flLzfcBD7SxR+mUP0pAnZnPWNbsF7iz+ow038Mf8lRa63TENuMavDiunzFVYQdEhw7Lj8pZVDlCAS901bntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447857; c=relaxed/simple;
	bh=NbD+XpF87ER8Gyz3Fdd3kb3FLWKUPoLYa/7RVkQLjhg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PIpWxHce/kuGkMhBgr9epR8jeQnwm0JyNxQMRWSVHaZU2WlrAbyPN0xKYQPMWz82qbq8Rqdu99al0X4vtIdnaSP4DAfY055TeRkITX5EiMf/+uxVz/47/0eXE6quevFJYNOfXweX8SGkL0T3CrQMkjOCUDTP6PHg43dRKxV50f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2WFcYR0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WFcYR0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7848D1F000E9;
	Thu,  3 Sep 2026 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447856;
	bh=pa8LwoD6VKELa2dBj6H6H+A8h1leLB5W92COH2eACcA=;
	h=Subject:To:Cc:From:Date;
	b=2WFcYR0+g7Dcp6mkmtTbhtIsABA0D2ok7D28y7p6eHGBZp9SWTp2RwQsw2RoUnwCa
	 jKcBj6UiK3lRb9u6ul9grxr3pQ1V0Vy52aUObo45zr47RxEXgAH6GBnC3SjPdU+yGd
	 QD6zGNAEyGEUzjRC3H4hYOMyOKJ4MzENKjXqnc8w=
Subject: FAILED: patch "[PATCH] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI" failed to apply to 5.10-stable tree
To: namjain@linux.microsoft.com,gargaditya@linux.microsoft.com,longli@microsoft.com,mhklinux@outlook.com,shradhagupta@linux.microsoft.com,tglx@kernel.org,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:41:43 +0200
Message-ID: <2026090343-cheddar-enjoyable-b9ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 86bdd16e8f390d51bae9e77a4bc4164ca2f580fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090343-cheddar-enjoyable-b9ad@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86bdd16e8f390d51bae9e77a4bc4164ca2f580fe Mon Sep 17 00:00:00 2001
From: Naman Jain <namjain@linux.microsoft.com>
Date: Mon, 10 Aug 2026 09:07:13 +0000
Subject: [PATCH] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI
 irqchip

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

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..89816a2bd7cd 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
 	info->ops->msi_prepare = hv_msi_prepare;
 
 	chip->irq_set_affinity = irq_chip_set_affinity_parent;
+	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
 
 	if (IS_ENABLED(CONFIG_X86))
 		chip->flags |= IRQCHIP_MOVE_DEFERRED;

