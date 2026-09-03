Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F04E80D2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452370; cv=none; b=pw0P337zNJmZrl3q2Nsagpj8YRQ2lvxBsLoyZ9erLokgmUryriFD1iComOg6RBDyf+raO6unXSukFF3x4fwaZFLtmU+ob/nMVMIi8SY0U47D16MEIsqZZX6TGNpo6NKYcpoi94VRaFeoufwlg27T2DCePjdr+Qu63zjEDlUYv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452370; c=relaxed/simple;
	bh=CRqQTsRO7q0L3GQFXL3KeEsDLCb6TvH1oEnTovBIEb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAdiIxwyCaHPPvZlWckNlRa6U/A2f2W/49ei3netWCQDRH7aWwS57mxaXi/o7SALGbPJNRZQO3cJPUdP70hqlHP0pWk5i26ifrrk5jBsWKpO9H8TAgLJKN+rsXxkgyQQ0BvuUoBSS6UY8GavfGLkWA70vatclEPvUKZRJU2RNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XHq8L4f6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XHq8L4f6"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.21])
	by linux.microsoft.com (Postfix) with ESMTPSA id D40E120B712B;
	Thu,  3 Sep 2026 09:18:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D40E120B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788452331;
	bh=ivCqi1+FwC0DdzIroEXthPMAlwue8gQTsCKALVC7SVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHq8L4f6mmGTss4DOAVLqQlDb1AzKGE/+Tyiq4QJpr7iy2pXXfPMnZ7gQopqcJdTv
	 hJLWVyi8X98Pg7aLT8AYm7f1+QO/LKd/wytQdJBgA3ESB8cBDvbNSpgP9nkMcdGIqG
	 aoWoe0QgsOIayTZKqb+DGLbVX02Sb4VnRxexSlPw=
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
Subject: [PATCH 5.15.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 16:19:22 +0000
Message-ID: <20260903161922.87232-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026090343-twirl-opt-bff6@gregkh>
References: <2026090343-twirl-opt-bff6@gregkh>
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
index 7917ed426f6a7..ef3beda509186 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1655,6 +1655,7 @@ static struct irq_chip hv_msi_irq_chip = {
 	.irq_compose_msi_msg	= hv_compose_msi_msg,
 	.irq_set_affinity	= hv_set_affinity,
 	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_mask		= hv_irq_mask,
 	.irq_unmask		= hv_irq_unmask,
 };
-- 
2.43.0

