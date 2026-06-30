Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69932470F;
	Tue, 30 Jun 2026 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855855; cv=none; b=MXLcEUc4ycBUyDauXrrtODelu+1ufSqpZYY1AwqgzEVUjwVvWjCLoaLLVbNS0N7AftcKO9R5U35XQ37YsPqdbHtq95ofzteCAvxvtq7qdqjZxwg0lsT3SDyKtTUnR/GNyZ4WRoyppoyY5kyG3P1GXtakBQJ34WL1OyxVKitk1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855855; c=relaxed/simple;
	bh=G/PLgmaK3kxxzBp27zaYyBgT8fvnJmd2/em1RlD7Tdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTrEZlkFI0w1dfWjq1yUV9dEYRxyFJy8JCtvJBlMeRwxSDFhS3r0vdXfezr9RRTZKnuT9KedaDd7WvqGkAx9qfouWlBj+XvozzWDzNwrnRBSSGUvAj9MRJ3bBFEPec04vQ2GdLmrY19IRUykrK0gusdXCWHbU27jFC+CWySDYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rtp+SoEp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rtp+SoEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782855854; x=1814391854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G/PLgmaK3kxxzBp27zaYyBgT8fvnJmd2/em1RlD7Tdo=;
  b=Rtp+SoEpmKW+4yLIINS2TaQniJBa+fL00qS/AVZIqbb8EDRnnn5h+31v
   Sd1fti5Jr2wtuOZyA9qKl65YcQ1ZM6XgK87iw7R4TdSvBrAxl/8YfFdSv
   yzgcMh8JI6NCCfHalzwUMtbGfSmCWg+Ly8rJEIPULLV+UY29N/VdxZ7Vk
   TwXQOpH5URI9dx5ckwbVXkU72BPTZt3lZ9Ymgog+1v8HolYUmFdzalHVg
   xODfEZFMqypcbfokdvXRdp0aZpyYHPqbc679DLkMsKJMO/oOOuqPPl2kR
   34TV7zrNdEtRCF31PM3vQM125MQJeZo+d8/oPb6xqBjDCMSiAFIJQU34V
   A==;
X-CSE-ConnectionGUID: spQO8sLyQmmZgZA/zk2pOQ==
X-CSE-MsgGUID: r8vg7g5QTyWgfqdPdR/P0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83637587"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83637587"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 14:44:12 -0700
X-CSE-ConnectionGUID: WlP11Wf/Rse5tBY0idnBrA==
X-CSE-MsgGUID: gfiMpvHgRaa6sDvbDyF3rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254296595"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2026 14:44:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	anthony.l.nguyen@intel.com,
	tatyana.e.nikolova@intel.com,
	joshua.a.hay@intel.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jakub Andrysiak <jakub.andrysiak@intel.com>
Subject: [PATCH net 3/4] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Date: Tue, 30 Jun 2026 14:44:01 -0700
Message-ID: <20260630214404.930923-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
References: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

idpf_idc_vport_dev_ctrl(adapter, false) clears vport->vdev_info->adev
to NULL but keeps vport->vdev_info itself. An MTU change after that
calls idpf_idc_vdev_mtu_event(), which dereferences vdev_info->adev for
device_lock() before reaching the (!adev || ...) check.

Cache vdev_info->adev once with READ_ONCE() and bail out if NULL before
locking. Use the cached pointer on both the lock and unlock paths so
the unlock matches the device actually acquired and cannot re-fetch a
NULL slot.

Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Jakub Andrysiak <jakub.andrysiak@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b7d6b08fc89e..9f764135507c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 
 	set_bit(event_type, event.type);
 
-	device_lock(&vdev_info->adev->dev);
-	adev = vdev_info->adev;
-	if (!adev || !adev->dev.driver)
+	adev = READ_ONCE(vdev_info->adev);
+	if (!adev)
+		return;
+
+	device_lock(&adev->dev);
+	if (!adev->dev.driver)
 		goto unlock;
 	iadrv = container_of(adev->dev.driver,
 			     struct iidc_rdma_vport_auxiliary_drv,
@@ -172,7 +175,7 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 	if (iadrv->event_handler)
 		iadrv->event_handler(vdev_info, &event);
 unlock:
-	device_unlock(&vdev_info->adev->dev);
+	device_unlock(&adev->dev);
 }
 
 /**
-- 
2.47.1

