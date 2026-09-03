Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898D4DBD8A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449516; cv=none; b=PdOJHzjzMWHLgidtl11gotLBfzD0pVjO+zovx2QBgWplYmB49zm99nFrhiG7tZWkaGBrc5XnmCLrNxjcJE9cdBOXTAAPLZfIS/CSeKfv3vQFFtd0dR0LKznfc0perkk+BS865ATKbN1bUCi7AS6nqmAluJF0AkZQF8siGtLoNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449516; c=relaxed/simple;
	bh=iELQCWEGEqlMdhH/6qKyivD273eeThpCCIZFS8wW+yo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nLGM+r3LoaoCxzaIlkHkFQmfsxkx5qFf3H3v+vndJ20NH0dFsi5bPcX2XsrHW3PrzUlnF0B2Fif2TyDyHY/Ar2sINFoHfkEyLt6tYT9tv4g97VkVW7k5jz1F62jtLoK7nfn6Cz+F6SvR4oulmFPAbWZWyUpLG5jy5nfUi//JQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyapKHAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyapKHAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD131F000E9;
	Thu,  3 Sep 2026 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449514;
	bh=10niEXm/dJ2gzMRZtXVvVPI6igUp4elrHXR4S27D1CE=;
	h=Subject:To:Cc:From:Date;
	b=dyapKHAYuktfFBLEeIvx2qKriHJ+aqkCj3fa1HeFGhSmEqhBskPDAm6VcvLeDDo1p
	 AxpnW3cFq1CZ/K2ZcjY/LN2NsgE2LNYvB7LZeFOCmXbJBTRXsRRz+SeJSFyDZEBit/
	 XV3T+D42NjaNamw2Jdssj+uq5bh9awp1du8IcQhc=
Subject: FAILED: patch "[PATCH] nvme-pci: disable controller on admin queue IRQ setup failure" failed to apply to 5.10-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,hch@lst.de,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:01:47 +0200
Message-ID: <2026090347-supernova-stubbed-07b7@gregkh>
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
git cherry-pick -x 08660a5c8d497f43191635d97efd31cd35051f15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090347-supernova-stubbed-07b7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08660a5c8d497f43191635d97efd31cd35051f15 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 15 Jul 2026 16:44:59 +0900
Subject: [PATCH] nvme-pci: disable controller on admin queue IRQ setup failure

nvme_pci_configure_admin_queue() enables the controller and then requests
the admin queue interrupt. If queue_request_irq() fails it returns without
disabling the controller, and no caller compensates: nvme_pci_enable() only
frees the IRQ vectors and calls pci_disable_device(), after which
nvme_dev_disable() treats the controller as dead and skips nvme_disable_ctrl().
The controller is left enabled (CC.EN set) on this error path.

Disable it in the failure path, while the PCI device is still enabled so the
CC.EN clear handshake completes.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: b60503ba432b ("NVMe: New driver")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0bce364c7874..16d42e5138c8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2414,6 +2414,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		dev->online_queues--;
+		nvme_disable_ctrl(&dev->ctrl, false);
 		return result;
 	}
 

