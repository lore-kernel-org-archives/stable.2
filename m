Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0430412264;
	Tue, 28 Jul 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272971; cv=none; b=XnnVZwcMW+3R8nf9TOsAsS7/aAJN8DVTCZPwKfp4clL/YYvRhbUCLrtuqU3RFejJZPYy2maY6ARwH8Is/hV7DIsNc0nrbRzUYrWc0YNj+3tq3UCJUtAEdS7TA8P+baytuWC3MjSwxHnPzxUrVFd6b9RyAEqJc3aTry3JAN33Mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272971; c=relaxed/simple;
	bh=Hz7JhtA/kJG8Ysy6BbhM72T8ZfD3VXjJ8Cm33+xRInE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip2TEyfVVxy/yL4cyyPhVzvNv7rZlMdwEm/1f0uNjmlCDzzJqLb9rBLIo9reCjHLrHbp5Re1Pzw3crvsSQOTIWVtmwhiKq/AznSgBn1zgjWjyiJyvymL4n0Y9A7kOvVikqGSO8rtyzsF6w8QSTspiCLEnk0ksPYJOqJlDNUG58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvuye8sh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvuye8sh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272971; x=1816808971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hz7JhtA/kJG8Ysy6BbhM72T8ZfD3VXjJ8Cm33+xRInE=;
  b=cvuye8shEVCzSW89gknnaf1AuBg8R39SJqAqq0TaMdqEcZTiJdyZb7i5
   8A6Mr1YAfq4U60F+fWytPFYLts8DljgGX3nhO274WNgNo3oExG3jSh/U2
   AsZq5Iy6CmFn+p4PSYMRK5pdAkJA9Kl7xyjQ2wTrqViO+nvj3HlG04VDb
   RIvV1+ceda09j3z/eTPl+ES8sva89Bs0fwVPF+cu44kjD7stCGgtpRmim
   XMKK2FSgTNeLbt1Is7MeKPcUh09RULOaSC6e9g9RPRIfLZ8GcUmDGXlAs
   HE4VQyrABbhfR0Odu85Ca0yCDkhuUDdzYga6T4pljHpsKLYMNuh1vcrYY
   A==;
X-CSE-ConnectionGUID: 6zD/PqPWT9qFmjKwI22AJg==
X-CSE-MsgGUID: wdvQJMQvRwmIsmfvROIj0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885053"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:18 -0700
X-CSE-ConnectionGUID: 3iveW+nSSFauE5uYVtnPyA==
X-CSE-MsgGUID: BhiUuq6qT+i0s1qUEE8IsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558957"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	anthony.l.nguyen@intel.com,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 06/10] ice: fix memory leak in ice_lbtest_prepare_rings()
Date: Tue, 28 Jul 2026 14:09:03 -0700
Message-ID: <20260728210909.3042004-7-anthony.l.nguyen@intel.com>
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

ice_lbtest_prepare_rings() frees Rx rings only when
ice_vsi_start_all_rx_rings() fails. If ice_vsi_setup_rx_rings() fails
after allocating some descriptors, or if ice_vsi_cfg_lan() fails after
the Rx rings were prepared, the function reaches the Tx cleanup path
without releasing the initialized Rx resources.

Fix this by adding separate unwind paths for Rx setup failure and LAN
configuration failure. The Rx setup failure path releases the partially
prepared Rx rings before freeing Tx rings, while later failures first
undo the LAN Tx configuration and then release the Rx rings in reverse
setup order.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc7.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
Intel E800 Series adapter available to run the ethtool offline loopback
selftest, no runtime testing was able to be performed.

Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 49371b065845..7eb380be7ed2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1069,18 +1069,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
 	status = ice_vsi_cfg_lan(vsi);
 	if (status)
-		goto err_setup_rx_ring;
+		goto err_cfg_lan;
 
 	status = ice_vsi_start_all_rx_rings(vsi);
 	if (status)
-		goto err_start_rx_ring;
+		goto err_cfg_lan;
 
 	return 0;
 
-err_start_rx_ring:
-	ice_vsi_free_rx_rings(vsi);
-err_setup_rx_ring:
+err_cfg_lan:
 	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
+err_setup_rx_ring:
+	ice_vsi_free_rx_rings(vsi);
 err_setup_tx_ring:
 	ice_vsi_free_tx_rings(vsi);
 
-- 
2.47.1

