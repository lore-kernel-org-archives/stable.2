Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69851DDA18;
	Sun,  4 Oct 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114248; cv=none; b=pmXyDdcw31PvTKUT8/RrgvDrX0USrqYijb8iGxTROGqoxI+xoyXQ+6wKYXVgmnTGBsVI44m3/S0fXbRpQTJGPb9cXlyLJFy2nmA8/0E68Z6pdXaRIZkn3ORkpSjfrvKNpCOEb82yrUU4YdfUwvanjBj1DkfU3M8L0toYL6U+kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114248; c=relaxed/simple;
	bh=k71Tq7xa1Y3Qng6gydCjWjLj3umuA1sje+J8w9IP6gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EFaMbEDw0eF26dMiK8Jb9WWS56G3jYMNb23CDDSfz9IfzGgcxN8S4ZmBopa3X3oBqBLsMal+9mFcvCBYbqDi5HPoh6O5Pr7i9Z28d6E6mKknFAMx75UQ9qVriZ+YEdBOb2pQfzhwVugzVsBWMc6VQEh7p/ZybY2x8MyebvIlA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZR7w4QNf; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZR7w4QNf"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fec266b1;
	Sun, 4 Oct 2026 19:43:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Matthew Vick <matthew.vick@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: fm10k: shut down the service timer during removal
Date: Sun,  4 Oct 2026 19:43:52 +0800
Message-Id: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa106ba5e1703a1kunm59abddd933b26d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh1MVh0aQ0hNGRgYSUhMTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZR7w4QNfR/layPI4kuciqtPreg6ByWjPLtStUW8+dDHRfx26MpBDihhNSxVkuLRISKVnj/1G+13WlUI7Bz6SpXV/eGFlmT+n/FcKUcB+Zst9EPwsq1gmEbKFPXuqC94WP5dJLlHwaEqMWNpqLGSWfmjbHztLpG8bu9RlqJkvOC4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=VrC8MipqRMsjFleiMybcQkY+76/LuM2Mw14J4Ebzgz4=;
	h=date:mime-version:subject:message-id:from;

The fm10k service timer rearms itself from its callback. During PCI
removal, timer_delete_sync() waits for a running callback but does not
prevent a callback or another service path from rearming the timer. This
can leave the timer referencing the fm10k_intfc after free_netdev().

Use timer_shutdown_sync() to permanently prevent rearming before teardown
continues.

The issue was identified by code inspection. No runtime reproduction or
trace demonstrating the failure is available.

The patch was not tested on real hardware. No hardware- or
firmware-specific runtime result is available. Validation used source
review and available build or emulation checks.

Fixes: 54b3c9cfad6b ("fm10k: start service timer on probe")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index f5b4d0627..836664cfd 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2245,7 +2245,7 @@ static void fm10k_remove(struct pci_dev *pdev)
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	struct net_device *netdev = interface->netdev;
 
-	timer_delete_sync(&interface->service_timer);
+	timer_shutdown_sync(&interface->service_timer);
 
 	fm10k_stop_service_event(interface);
 	fm10k_stop_macvlan_task(interface);
-- 
2.34.1
