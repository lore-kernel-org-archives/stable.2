Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920836F8EE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974515; cv=none; b=oXiKHFxwWp5UxT1F3QaGzvOMcftwZ8NwzeSR/fvpWvxA/O53+zNvAZLUi2Dr4f7bjkXWDa9AMdL2A0rF8IM0I4HwEgLpUYh+XQ7n4iL8jZffbV1sZjhqVH08O0vijYrLaaYGnQDOW2WlPAr4fW1jlA6cee+GKDXd0+eYD7F4ADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974515; c=relaxed/simple;
	bh=ipDx3VgDFCe1KTxhzVd/FEjUxSeIAt8zEiw0/Tv+MLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z51ukX0vioukH6UfIgJCHamjvtqx9vMUyz3DBdVZWNIqEQdn3anxq0170Kr9EuWqY4/5AJdo4OxF5Ps29hci7EVHm1wmv8anA91hlT3qp8lByp8GABgdZcO6xnN9Y0EBwI27YZMK/tdyDxP9oO42S3D0a6z1kg5OoUDBveSwZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI+HXIDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI+HXIDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C495D1F000FF;
	Wed,  9 Sep 2026 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974513;
	bh=Dl2alKEBcdaZusYiguczLW391qP7KU9dhLGlYDl7H8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OI+HXIDZ/sH0394PoJBt2QQjCqLVbEpM6tt+WAXaoWNAiGXerZVuxcJczm/CAf6Yx
	 GdPM9ODfci3YA7fGSOQ3Qr485MYuyvQOpTJTWwzWH5YlvtRdL5+mj1ev3YjzfUSynL
	 KSAB7SIhFtg54LxgtvxWCYMr+FoCnty4ILuY4piCCn16NR1jtI93/gZzuwGhMS/2W0
	 E1gJYyvVrVy5JjXrljU8jvCuoPHfomxYn287r2qd+Z4hHgqOPFP0F2eR0197RXh0IV
	 tXFjs6hNqnSMxYXFvoCUABFbHHEZKdsJFB3wVSJeR9McpFdxLtHtsqTObFuFdB44Dp
	 KU7AIQtVxqXpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Ijae Kim <ae878000@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nvme-pci: disable controller on admin queue IRQ setup failure
Date: Wed,  9 Sep 2026 13:21:51 -0400
Message-ID: <20260909172151.3263208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090346-usual-encroach-4629@gregkh>
References: <2026090346-usual-encroach-4629@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 08660a5c8d497f43191635d97efd31cd35051f15 ]

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
[ Removed the false argument from nvme_disable_ctrl() to match Linux 5.15’s one-argument API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6c6dc16ab3a62..2558232d344ae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1806,6 +1806,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		dev->online_queues--;
+		nvme_disable_ctrl(&dev->ctrl);
 		return result;
 	}
 
-- 
2.53.0

