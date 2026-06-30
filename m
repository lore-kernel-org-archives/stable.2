Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370132571D;
	Tue, 30 Jun 2026 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855856; cv=none; b=EI0hcnvoin43KTKle9cyyz3HPhwgNJqU2iuMP0/C/7JmMSSzShcHKey0YhttzKN5fTn3Kudc2bHHjFv1ig81/G7UUM7LAYZa114r2cYCDlJb9fU+GJLSFWbbwmfIvpWdjhBeyE9Y7BbNrPBASF+LNXrVXSxnUbJPnc1phGeaIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855856; c=relaxed/simple;
	bh=fS/J+sqBiuir5n500nJ07TkRBhF4znKgrCnzhvoe4nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0t4GLqHx5EP1mLl1Ep9dqNBiEI1xzI5WcIalkLWbrebuqIywNCYsPCMrZN3rYGu/vdFdLc1ShzYe+tWAnPPO6PgEZMMdBcGoY3RBuGvdl+91TPGW0iGpps9fP+/5bUbWo/Nl0FGxfqpnUcUpyo/S+nP3hgqNCEkSuwfI41fyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPzufVX+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPzufVX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782855854; x=1814391854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fS/J+sqBiuir5n500nJ07TkRBhF4znKgrCnzhvoe4nU=;
  b=SPzufVX+eyCI+bxQ8B9iqSVJ9k7KFG23VP7Kxm+FGHhBJ/b6dQOXP8qY
   +IQBqyImHBrFyQUW2QRIbJx8Y/RhKjDTYTOs0KIwgUo3s+mCKq8MvUQrr
   I19X4IeINyP8pRKuIl5//QzDzl8dsJu7v3qP1kaZsnHdBkYHzwAH57ECe
   8pVqrd3cjGnEqXyhkU5RocS9kKve/XGDnhP4t48QHDedfyeNleh7QA15+
   Hq9N4h0bQ2VAcoxxT17vwKoIJo8DowArJeEeQR5ZwDUyLD7BHLclc+rsm
   1PBw1AK6FbqbOXjWnHpswinFX92QNjE2Uyrvy1aEHVDbY/HX5tCTMrWCs
   g==;
X-CSE-ConnectionGUID: ib3Wpn0nQo6nux8xVgylcA==
X-CSE-MsgGUID: zf47I0HBRRKFF1Sc+ZiCPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83637598"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83637598"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 14:44:13 -0700
X-CSE-ConnectionGUID: dDVYN+wTT+Gd7RhDtMhYJQ==
X-CSE-MsgGUID: vYY7EoUkQSKlR46k4CJ8Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254296604"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2026 14:44:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Matt Vollrath <tactii@gmail.com>,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org
Subject: [PATCH net 4/4] igbvf: Fix leak in TX DMA error cleanup
Date: Tue, 30 Jun 2026 14:44:02 -0700
Message-ID: <20260630214404.930923-5-anthony.l.nguyen@intel.com>
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

From: Matt Vollrath <tactii@gmail.com>

If an error is encountered while mapping TX buffers, the driver should
unmap any buffers already mapped for that skb.

Because count is incremented before each frag mapping, it will always
match the correct number of unmappings needed when dma_error is reached.
Decrementing count before the while loop in dma_error causes an
off-by-one error. If any mapping was successful before an unsuccessful
mapping, exactly one DMA mapping (the head) would leak.

This bug was introduced by a 2010 fix for an endless loop in dma_error.
All other affected drivers have already been fixed.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-4-7-opus
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 0a3d0a1cba43..c686ee120a14 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 	buffer_info->time_stamp = 0;
 	buffer_info->length = 0;
 	buffer_info->mapped_as_page = false;
-	if (count)
-		count--;
 
 	/* clear timestamp and dma mappings for remaining portion of packet */
 	while (count--) {
-- 
2.47.1

