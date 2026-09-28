Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121274DA9C3;
	Mon, 28 Sep 2026 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636686; cv=none; b=MVjfIPYa/pR23Wiv56I3nEN7a9m0CD1IAJqnCr/rMWWG7dXyJjYJ3pJ9OtcXtmtpZGnaFeuWnhOWb3qCqYMX/hfsOsqSE6yo3xdBieJxLzHkxl40+bFQ0A+KQaO93sKGj6F8tGDCecL4ra5yXlclbUfPQsZswEjnVmdafNNSxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636686; c=relaxed/simple;
	bh=m8DGv1I4hZtkHDlOVUBhLfJUIYLV0QHFakAan2FBBE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMK1qMbRxkZtkDYhMThKxzaEvuV770MSzAC1SVcUUD5QyPg2Qf+oNbBAA29SKZWUmxanLJYTeENMsZhKvooodBi6wfcm09sD6Yul3ft6K74fXFYfq59oG7ImIoqvaNX58d3XeVZxSgpPzhVGsKKqWBCIuhyJrgmsbJDCBJgfTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7yNRyqE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7yNRyqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636685; x=1822172685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8DGv1I4hZtkHDlOVUBhLfJUIYLV0QHFakAan2FBBE0=;
  b=h7yNRyqEumJ3Q5xzLPAMkMSYjAWDcEq/wdxaQKx0NjX2SwJBMa4rYhaX
   0UK9K046H22hBieyEqYLR7hDPj/Q+JPdO12rhARbwc6R+JHbeZ9WK2x2V
   MPT+mEJcUvKTk5YhiKmjz27HzyyZ0tW64lFUGQd9jwforzpskNBhPhd3B
   jNiLwhSh1+r9Ku4bVe23ObudsCpAAGBYU/voEicdakTb4CoCEYzZIQd1+
   e+7RNBso0IoLU/8gH+vIEz5pPD2h9FoNrAqL4MBiAg6jzrNxbY0V7awH4
   WdFoeGk0Lk1Ax+kf5qLFgM1yZYsmgjP1wRJdlgjNPP3TvNCNR5c5dBeGx
   Q==;
X-CSE-ConnectionGUID: 2r8DycSiR/SUw7KZMLrMEQ==
X-CSE-MsgGUID: v80GJQBtRRqJzZ+hUVXhGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101513262"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101513262"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:04:43 -0700
X-CSE-ConnectionGUID: xm0yXWKZQQecLgUzdWanTA==
X-CSE-MsgGUID: 0NQ48aZ0TjCD1Ni5paJCOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273317686"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 16:04:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	bryan.fraschetti@canonical.com,
	tristan@talencesecurity.com,
	tomasz.lichwala@linux.intel.com,
	david.butler@appgate.com,
	horms@kernel.org,
	kees@kernel.org,
	michal.swiatkowski@linux.intel.com,
	stable@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net 2/6] ice: fix use-after-free in dynamic port cleanup
Date: Mon, 28 Sep 2026 16:04:23 -0700
Message-ID: <20260928230429.495442-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
port from pf->dyn_ports. However, it frees the VSI before reading the
index for the erase, resulting in a use-after-free.

Follow the reverse of the allocation order in ice_alloc_dynamic_port()
by erasing the xarray entry before freeing the VSI.

Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 2a2e56777f9f..3ede24649002 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
 	ice_eswitch_detach_sf(pf, dyn_port);
-	ice_vsi_free(dyn_port->vsi);
 	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
+	ice_vsi_free(dyn_port->vsi);
 	kfree(dyn_port);
 }
 
-- 
2.47.1

