Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1F3E7160;
	Tue,  4 Aug 2026 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882147; cv=none; b=bopA+sVD9k9v7TQReiPzfkgenKhBIRlK5O/erkLFSzpuhKzmaMDt+wsGLhXbXZL7EwlwnzwIFQnakPYEn3YSH+ZDa1mYnPLCFCurSgb1BYon8rFgiX31+W/bKm8Y6Es4+hUXJLehHgFocuAP9Pc5XqDYEWH3HWcqHlN8HgTENZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882147; c=relaxed/simple;
	bh=itvMTOnxrM/byMtplsTrHY0FdTK2/AG913Xq/M9exLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t35QIsvo/c72ar+Rxq933IiG0IY1MxLOmRpMB8UxxiVpdUjEJkOPwGnO5+0qk3OuJpQfPuLjlvldd0XxXH+mmXCJMYgDXU5p4dxhB7KzRj4lpUDkYqVvCWMKZvFR+mmMXrFVsa7I/moCFLwGMOdp3zwcGKTSMyI/T1SecRpCFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zz1Bw9lr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zz1Bw9lr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882145; x=1817418145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=itvMTOnxrM/byMtplsTrHY0FdTK2/AG913Xq/M9exLk=;
  b=Zz1Bw9lrDwQlYIHkK3fwmdXWkBrKDTuzFqgkuRLIbpEncsSpr12HpLzQ
   Vhaut48jobEJj0VoUIfcXbL/Q1kcn6cN8p1t9dxzNK03bpKHPOzSiMybV
   Wr3SqvLKtzxMmmoE7ig8ip9DchNICdAySrCZ2KR9cFzwubFKythYtLL2K
   0L/pJocraYSpEE5rTTH32kHKzP9/kKeO6UAxNqGqpoDqjROt26fOcaNku
   MXHOeoIFi/MaoLn4mS4usBE0WO4FGGZFLbKZfDsfa37oxFYFxFcMUNYhT
   StUsfKqQfnO+0XJ1HgR0mAVAFBc6vGYtXRlvx4WE0brTqRSDKJTn7rTou
   A==;
X-CSE-ConnectionGUID: DGcqPuhUQ1e8/VvPIXV2fQ==
X-CSE-MsgGUID: Y9iZkyt9QFSuPqHf0xpfCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803459"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803459"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:22 -0700
X-CSE-ConnectionGUID: zXCgMP8zQSSb0kvX5L0rwA==
X-CSE-MsgGUID: 5G6Gg6/4T/CiHU0SGLRaMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257308011"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	anthony.l.nguyen@intel.com,
	sln@onemain.com,
	zilin@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	jbrandeb@kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net 09/10] i40e: fix netdev leak in i40e_vsi_setup() error paths
Date: Tue,  4 Aug 2026 15:22:02 -0700
Message-ID: <20260804222205.1580328-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

i40e_config_netdev() allocates vsi->netdev for main and VMDQ VSIs. If
i40e_netif_set_realnum_tx_rx_queues(), i40e_devlink_create_port(), or
register_netdev() fails, i40e_vsi_setup() goes to err_netdev without
releasing the netdev. The existing cleanup only frees the netdev after a
successful register_netdev(), so these error paths leak the allocation.

Reorder the error paths at err_netdev to ensure proper cleanup of the
allocated device.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc5.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
Intel Ethernet Controller XL710 family adapter to test with, no runtime
testing was able to be performed.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0ac1be6289f6..4f0f7626605b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14494,13 +14494,15 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
-		free_netdev(vsi->netdev);
-		vsi->netdev = NULL;
 	}
 err_dl_port:
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 err_netdev:
+	if (vsi->netdev) {
+		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
+	}
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
 err_vsi:
 	i40e_vsi_clear(vsi);
-- 
2.47.1

