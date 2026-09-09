Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86914361958
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974843; cv=none; b=GsiAxZY8zfWvWjm1z9VKeL1pNxoJqgLCqGq7v+DA54u52l8gJm2sx1i3B/tS23Vtozknsz7fiL7q+IJoOP0z99dGQh+GjHRzkfCtYCwJ5ie0DtODnND1jvkktE3PBCEg2fKyWzH5JCs8kX1mYDHq2CKhBYK8aPUK1W7WYVDr3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974843; c=relaxed/simple;
	bh=bk1bs0hq6jVwJKv38EMRb0aLn+Y5DuYVvF2GjjcoD0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP5Id5vqkBsI80bbaX3eFvS4vDbDKTe+ZqwnJcuJHXc8eSaUVEqhziHmwKHyosCdlfL+OlAM0vhLy63iPBKfENuF30GCNdXOB9sX3pyiHF0gQffsbm5hFH6xu8Qy9jNLJLpfg7p8Zaft5jiYVojA3g6jGITWVfF+J+5AfM5nIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSJJj1sT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSJJj1sT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700901F000FF;
	Wed,  9 Sep 2026 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974842;
	bh=0tCfILgphlshaPFTtaHmsWIQbb4FtYa9Wcankp0akj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hSJJj1sTTCM8v/jAtDhj4weG/p41W8I6+Sf4kvol+yAJC76KVYZ3WMZuQWQXTNTAF
	 q3/7Xv5okrwEE2mq19+C71lnuakX9PPoYJpzmwO7wwtDsDZJwwtdiYBYfrUCFisjhN
	 31KUWbeMqxE0Uj6LANcKVfvBv0z/5zeF1rpeNVqY4f3ZOBMtJ+GlnLruFFJ5dFMjYj
	 jp5For4WksOE+2MKReXRcTZaPYkX/Ry1LXIH61v41W8srOJc/CLA0+MsOAIOfIKq/f
	 YX21TAv/kwJhGWaTCNp5sT6hdBU1/7ylKDZC7SUXaL3Nk+SRyS/ihJVTqVW7P85Itr
	 t4tIzqluD/ygQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Ijae Kim <ae878000@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nvme-pci: disable controller on admin queue IRQ setup failure
Date: Wed,  9 Sep 2026 13:27:19 -0400
Message-ID: <20260909172719.3281356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090347-supernova-stubbed-07b7@gregkh>
References: <2026090347-supernova-stubbed-07b7@gregkh>
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
index 03df42e613f0f..c3855a49815ec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1813,6 +1813,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		dev->online_queues--;
+		nvme_disable_ctrl(&dev->ctrl);
 		return result;
 	}
 
-- 
2.53.0

