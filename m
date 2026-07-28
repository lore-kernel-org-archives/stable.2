Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7341685B;
	Tue, 28 Jul 2026 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272973; cv=none; b=Drg9gEeNwRHEbHdlDaRQraos2vE0nECt2ofwCYEqoI5gO/2rXh9IV3gp5ciP6tAKVHc/vebcm8wjspJZpPcvJzOM5xMFwyWKzGv+3nqCwwWpEfjJLHg/A61c0B3GM5A9edSBI1fYxlpJ/wAl9NYtEg3Q1RY6PBRrqJcgn1Q9X90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272973; c=relaxed/simple;
	bh=BW1ZWsISTLVqxjOMd4H2ATE0+FNjvFf/eoEwJXfYbiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ucg8UPxRrHEQmtUDtJ+9aB6Iadh4ksXTnYboM59V25i71pMuTe5fyMP4UMeaiRm3OlVe4owJTGGm7SICeX0BzBu2izMuVhnz/O/NINlzCrOcGs2kq0JUY4JFnN47Tcfrco9ImerDjg3OwITRCIFrEYatp6Duj36lJO/1eNUr6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5lSuOK/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5lSuOK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272972; x=1816808972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BW1ZWsISTLVqxjOMd4H2ATE0+FNjvFf/eoEwJXfYbiE=;
  b=j5lSuOK/ijDSDTD5UEA4F06RZFD3d8W+fJnTQFddkNOfMnr3LUMMop4D
   yRciLt5f8hT4g3OK5tsrc6MUSGoy8dJz3/DKgoNoA6ueiqdkWhukGCSdb
   Q4lbrUkor/Eure1xinTqZM131JL9pldVa7rUMj4iyW4tVVNtUUAJnp+Ah
   aGjIchddFobvHrz8crZn6L48T4Sro+Sb+Y0U+Mtnlx4X4tJk82kHjr628
   sIsjYCiyhsrrs7kaVW5IX149WsHMosDLTUL9ask/BSq19jgSz0+nOUEXj
   V1kVmjMq5qJ+OLnA+Z1hKCK/CifSYH7qrWmCg0/rDBPW3gd695WurpqXe
   g==;
X-CSE-ConnectionGUID: 0rD3a9idRXqBCl1lFJbPug==
X-CSE-MsgGUID: BfGh5BnaRyCDyYmOmcBKLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885090"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885090"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:19 -0700
X-CSE-ConnectionGUID: ImBNtaB4QMaoYdmL0fU+jQ==
X-CSE-MsgGUID: DrfDeRVqRH2ZP1NNzN8dvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558971"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	anthony.l.nguyen@intel.com,
	zilin@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: [PATCH net 10/10] e1000: fix memory leak in e1000_probe()
Date: Tue, 28 Jul 2026 14:09:07 -0700
Message-ID: <20260728210909.3042004-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

In the e1000_probe() path, e1000_sw_init() allocates adapter->tx_ring and
adapter->rx_ring. If the subsequent CE4100-specific MDIO BAR mapping
fails, the error handling jumps past the ring cleanup code, leaking both
allocations.

Fix this leak by moving the err_mdio_ioremap label above the ring
deallocation logic. This guarantees the proper release of these resources
and prevents the memory leak.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
CE4100 reference platform to test with, no runtime testing was able to
be performed.

Fixes: 5377a4160bb65 ("e1000: Add support for the CE4100 reference platform")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 9b09eb144b81..d7f5c6f16142 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1222,11 +1222,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (hw->flash_address)
 		iounmap(hw->flash_address);
+err_mdio_ioremap:
 	kfree(adapter->tx_ring);
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-err_mdio_ioremap:
 	iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
-- 
2.47.1

