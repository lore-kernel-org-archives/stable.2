Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E34D2EF8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449512; cv=none; b=VwWPLYlhXiAgpHnzoxUeQ9S8OS3vhVnKw2WNk/SkCV+aqIKOFXOK3R5cEsPXuSkNIEbXdg5QiJe0wzXJm9VqL7QzBExox7xHo1TuWjIkx1VCMaabHfVPoD35A8Ybxwi+FukLLqVArnawCJOVYsdgGyPCY7qF781z6DOgQN3AwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449512; c=relaxed/simple;
	bh=r6NP1nYhViUYJGF6t2p76p0BS8ngzBcajleIRY8yZmk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SuwPO6erUX6RwaNtQWYxAc4QUiDVEHObw2k11LQCTt4yUpzxk4s4fqu8jzuoei3OLqBeT7+mwDBVRTfBdO/ZxzdpcUHPwYwTS4ggZjRtMzHXYHnsu/UKg4qHzVrptHwcNUYuEqnsKnisz3cEb825d0s3CjRjcKilWhsw3SqREWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaXiFl2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaXiFl2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76EF1F000E9;
	Thu,  3 Sep 2026 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449511;
	bh=qUjabaTbAe7SmIDIDtWQPhOlIIkOwjS6DTCkcApBvU4=;
	h=Subject:To:Cc:From:Date;
	b=XaXiFl2zzqZXb2xTAUk5VbSmSKmf0YjTODtdyvgCLIKrl+j8UxTw1+5Y/jpCVT7Lr
	 7b42RNRGE2afrV+ng9UQn9lpraGp9/lgdJjTJtWhK9jqXA8MRds9+bD8gLqRjCerOT
	 DwrHc8oOVfBUHpuC7Zdg9L8CYcB0B4euLmPX08wU=
Subject: FAILED: patch "[PATCH] nvme-pci: disable controller on admin queue IRQ setup failure" failed to apply to 6.1-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,hch@lst.de,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:01:46 +0200
Message-ID: <2026090346-clang-google-039d@gregkh>
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
git cherry-pick -x 08660a5c8d497f43191635d97efd31cd35051f15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090346-clang-google-039d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

