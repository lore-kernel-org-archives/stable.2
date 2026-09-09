Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA23090CD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973573; cv=none; b=cagSa8/7aghHAVnsw0Z4fK7TnLQxYrElOpNQ9G1M3fkmnHPpxDJvbEjbRWsz1IQ3eeNTIrhcmGcLOrxgfbE0q9UdrziciYI3KREL0NGAFrb6/Ne6cJu3PdiujE+DuDnDrGRh1NLBjVrCmWpGS7jleB+H/ErhPHCQKVSzDc4TSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973573; c=relaxed/simple;
	bh=4oRm5EjZE28kNjrlr6NkpEpyqwtFIBKEt831SjtaivQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dzptt/ohJLiDfqXLNeL5dj5XwV9jasuB4aKhSy2SS7yP3/EK64TGOCaGoZUKWaR9Jk9A0s6K42U+tTVFcweCelMqIASJ0tc1az/LYmhBZZArbXp0/c+NMKJQ3ti4gkNeNFi0FJy7mQbUvpeHxSeHFX1NCbkh2nE/G/lfEcyyTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1LQdjKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1LQdjKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C2F1F00898;
	Wed,  9 Sep 2026 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973571;
	bh=DD/GjPHJrsZkQrg28g8BiwALBbseQnY22pm3T+Pz1kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W1LQdjKvlaQtTu5iug9Kxg1jtDXB2HLuSJimLkovKEA9Ya5Ib8rjoV/WJxR3ZSv5/
	 p50N/Rq/QLMzkGv5WPlvoyGPJCkvqAR/KIMUCXOu+zXGTUGRIAJuY3kQW/4hdCfYzU
	 MmXkOUYqW/4fZMgjV883Vu0k+m/vIoG7kiJz4Ny2QbbS7gfu73pi6mEsEx93d3QJr6
	 v2phngNaf5wGBAxlJuxJfVgwNucKrZ11QxdqSHwh48pCp0u1lx1FE7Jflg5e3ipdWD
	 04N7VTSRrFXWDaANA8lV2g7RNPTN6mHGEBlARq9XhsWjWDp92F2oZf/dSScC2DMRv8
	 Zij943vGFktCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Ijae Kim <ae878000@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] nvme-pci: disable controller on admin queue IRQ setup failure
Date: Wed,  9 Sep 2026 13:06:04 -0400
Message-ID: <20260909170604.3185721-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170604.3185721-1-sashal@kernel.org>
References: <2026090346-clang-google-039d@gregkh>
 <20260909170604.3185721-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c347256a0f618..40f853cbe0902 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1895,6 +1895,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		dev->online_queues--;
+		nvme_disable_ctrl(&dev->ctrl, false);
 		return result;
 	}
 
-- 
2.53.0

