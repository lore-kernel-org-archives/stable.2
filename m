Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D64C77AF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447851; cv=none; b=Yq29UgiwsyKMS+B3CBg/b+1/igdqztfdChq2zRCIY//dikiIC3uFQEWyV2Z2AUSVGzLhY6CaRZL5GJBeasZWn9ISKnD0dxPGAa3ZgkM43aa8OzeY+IP36a1UxRqEpqLo1juZ2dBdD160GDu3oLP+W1HGtNO1Q5vkN1aLGEb0rF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447851; c=relaxed/simple;
	bh=JUTqKZFqgPuDNjyqulzDJmRsoSb+0OAsWUVXBIULA7Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gwtxgm7xSgUYDDCZWL4iMbs5dXpH20rwNKbx7jt1RrBkOOP9wNc1T46ChrnTJrYDYYcsby9sI5v3s3GeclCJaXZw/03e7LTN4m9xILLvfhqxE/Jo6rPO44oO2npZ/zj3B81r4X0wyoIIU6qWF0GqZPCD3uvR33ctpf09lZDgAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EkHEFbkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EkHEFbkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9A21F000E9;
	Thu,  3 Sep 2026 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447850;
	bh=reHXBtn5VcQPwowz9TYeLhhrf9VObSpRgI9kBmcx0y8=;
	h=Subject:To:Cc:From:Date;
	b=EkHEFbktfndJzCh0zzL8083vYidEb9igFKiEIcH+3ZK8aHjhafDyDSCKNcJkZ7GwT
	 nzzmynxXADSqffss//Jiy9o6UsNcoYT7z+BfmtpvHkNiPnnUU2PNncozVVsmUlGBqC
	 86lKpUlqVCm1mGAzrVPgpIlrN1nA3D8i6UednSK8=
Subject: FAILED: patch "[PATCH] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI" failed to apply to 6.1-stable tree
To: namjain@linux.microsoft.com,gargaditya@linux.microsoft.com,longli@microsoft.com,mhklinux@outlook.com,shradhagupta@linux.microsoft.com,tglx@kernel.org,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:41:42 +0200
Message-ID: <2026090342-washer-satchel-06ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 86bdd16e8f390d51bae9e77a4bc4164ca2f580fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090342-washer-satchel-06ca@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

