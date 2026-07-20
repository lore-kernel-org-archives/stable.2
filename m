Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248F42B31C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559754; cv=none; b=WqwtCYdNlY9uJMY1+5AEk1wBxoLKjOgeipsaUCXUyQeHPpGyacR2DUSBsW4SlMyPp9/HAhkv6/SFdNn4QF9ycaE1+xQMbPKHtKiHWOnJJpo04P+ka+wT0+DcaeKXFYrT2mek3OYP3/aToZvuwr0rHemENzvwLIk0ro0qTWM1vMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559754; c=relaxed/simple;
	bh=Znd4HAgkeEroS3cNYJtxdMVSwRh8e48NAb29hEQ1BwE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HcFCP039nQKRzPgP+EjKFz/oPFiU25dCtud/uBcUeZSX5s0yFD2xH0ekT5g22RLRsTIRz2SBRA8jvtTDlK1f+tSwhB5zzJHWAx7Mggsd61dtiZn+bwdoGpaY/JF/YTF3EaKj5u0cXfETmF3UTBaFs6zVg1+bx0kR1/q7VQfTLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a1KmpAqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a1KmpAqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C4E1F000E9;
	Mon, 20 Jul 2026 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559753;
	bh=NIERIGP+7Yh1WA8J2vKZHsE7+vmKmf2ggwY5h/OkMT0=;
	h=Subject:To:Cc:From:Date;
	b=a1KmpAqJDqakZ49dcf/n62Sgy5z7Ovqx729axZ1wgTSYP0gh9/HQOwPI4dZsvLMiS
	 K8BK71ABHWp/9LGsnTRQT2mYOhrkRLN0NHgQKYS3WUUB9NOpPNopIadJp8MjNnYZAZ
	 le1khDyUafLcbYzQMqMclpMF6CcKVLz2GaPOqehk=
Subject: FAILED: patch "[PATCH] dmaengine: dw-edma-pcie: Reject devices without driver data" failed to apply to 6.12-stable tree
To: den@valinux.co.jp,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:02:11 +0200
Message-ID: <2026072011-gratified-dealmaker-699d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 11d7cfe0c119691b2dafbb699bbca90258c678aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072011-gratified-dealmaker-699d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11d7cfe0c119691b2dafbb699bbca90258c678aa Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Thu, 21 May 2026 23:21:51 +0900
Subject: [PATCH] dmaengine: dw-edma-pcie: Reject devices without driver data

dw_edma_pcie_probe() treats the PCI device ID driver_data as the
template for the controller layout and copies it unconditionally. A
device bound dynamically via sysfs can match the driver without that
data, which leads to a NULL pointer dereference.

Reject such matches before enabling the device.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260521142153.2957432-3-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2082d0021a8d..791c46e8ae4c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -328,6 +328,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int i, mask;
 	bool non_ll = false;
 
+	if (!pdata)
+		return -ENODEV;
+
 	struct dw_edma_pcie_data *vsec_data __free(kfree) =
 		kmalloc_obj(*vsec_data);
 	if (!vsec_data)

