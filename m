Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271E48094D;
	Mon, 14 Sep 2026 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395633; cv=none; b=UBIjZQxBaPyy6ZAqyAJJ/W6hSbvp+l6kyg97xoTjVeMr9E7vnFs00s3JqOtdEZVTyAyIK4lLBvhnmfocQesWYe9mgd3GFpEUOQ4yZFSE4KdpQn8NnMz7b4hgiaWQP68On8B0r3L7PqKrNAOokz66pgbd6/B1wUNA457OItSZOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395633; c=relaxed/simple;
	bh=TXDvnfLFt3w+9whXPS0AfAqfNDELa9LxkJaMrl4oISo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aZk5xlrPU+ZogQrqP61DwQXF/EB6eVeMjQ/tLToRmyzcIU4j97NhVZmZgZh37IyLjmwUeJNmUAOhsN9ufmsar67RTK6cmseTaAHTSBD0yvDnFz2m23timdPRlP1FFYOZM1LWu2fVry8mk0ocpjiBrkxDqE4q+uJ/wGi7C8eYDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZvZQObku; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZvZQObku"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4db486d8c;
	Mon, 14 Sep 2026 22:20:20 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net] e1000e: roll back registered MSI-X IRQs on failure
Date: Mon, 14 Sep 2026 22:20:14 +0800
Message-Id: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a04a537203a1kunma732cb61298719
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEtIVktKQ0JLTxoaGU0dT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZvZQObkuF5ogSFfr3bGIqGhwnS3WAc0v6n4yw+yOhXZYNGxr037kXdzjGRaVMkHD3x5hnzIOOcBx9P3moXaPLpHuVPSE+U1mkRCe20Zh5pc+vhMuLgkogsNVQyMm1vy2MdfJuYxb+o1IkRzEvc8vQSJdz492g/8E5pjObAF/FiA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=rs/ZLTNgkCNql9uBzxBgtNcF/3ONT5Z4V/ejoC9+NrE=;
	h=date:mime-version:subject:message-id:from;

e1000_request_msix() requests the RX, TX, and other-cause interrupt
handlers sequentially. If a later request_irq() fails, the function
returns without releasing handlers that were registered earlier. The
caller then disables MSI-X and falls back to MSI or legacy interrupts,
leaving those handlers registered against disabled MSI-X vectors.

Free all handlers registered before the failing request in reverse order
before returning the error. The failed vector is not freed, and the
existing fallback path can then disable MSI-X without retaining stale
handlers.

A QEMU e1000e test with deterministic failure injection at the third
request_irq() reproduced a residual IRQ entry and warning on the
unfixed kernel. The fixed kernel reached the same fallback without the
residual entry. The injection is deliberate and does not claim that a
third request_irq() failure occurs spontaneously during normal operation.

Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad4..f55aec340342b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_irq;
 	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->tx_ring->itr_val = adapter->itr;
@@ -2148,11 +2148,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  e1000_msix_other, 0, netdev->name, netdev);
 	if (err)
-		return err;
+		goto err_irq;
 
 	e1000_configure_msix(adapter);
 
 	return 0;
+
+err_irq:
+	while (vector)
+		free_irq(adapter->msix_entries[--vector].vector, netdev);
+	return err;
 }
 
 /**
-- 
2.34.1

