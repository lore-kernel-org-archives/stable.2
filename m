Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAED414DEE;
	Tue, 28 Jul 2026 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272972; cv=none; b=qRt1r+aY1RyoqDWIWcKfkpAkF8UR7DwB4In7M2VtbuOAfOq7v3LnaUFMWYqaIM5YyLOterMYC1T+Xr/53ysiMPre2dn6HAJR9CqPYyrByvfhm1w74VUcvTi6RZe7WxJIicYFdGKI1l/CKr1au5+svZFDwfh9rHuYVHQ5Atp0lLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272972; c=relaxed/simple;
	bh=fS/J+sqBiuir5n500nJ07TkRBhF4znKgrCnzhvoe4nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYKtBuGvwW2LtyYyj04DMHXdqv6y68POjXeg4OSJsqFLGZi4KjNOTP/cNvGTO/WpNip5vGaZpz3kgo+4V+j+Cq4i1Gvx9MLT9U3O/QOyHe27yRGQXM9Zu93PIm5/v8FO0f+GOKcYBRNrSRVGgqdvxopxU+dUYWsfBAh+FkWwxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDghKTvu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDghKTvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272972; x=1816808972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fS/J+sqBiuir5n500nJ07TkRBhF4znKgrCnzhvoe4nU=;
  b=DDghKTvu+18oOiBgQdjgC8W3S/MpJY7+ajWLBiQlLcqbVQpuhpAmzA8D
   HLhx7Ql6l6VBtyGpSS2WCNwhQI+8oW71YbblEnRVrBN771gDRMLDri4ON
   PDYFyZoNWPaV2zyhRDU1UzTZ2CsCqmoBVk51fYO/SBmlaJG3RuxrEuXhB
   8aSOpQ4Itt/EGWR5givpDiUoqQePAnACHLIS7bqSB5hNuNUBzmg3h6tAf
   P1tc1TMHB42SmlVFdINaiw0n+BO4RKTwkwBfHKP3m57/I+2Cl9HRtpJkm
   hVcYAxHdTucOH1WEJ91iDLpALSfouLOtZQl2oVOMNn99h5k2WvEaNHnhs
   w==;
X-CSE-ConnectionGUID: B6g9/712TEWV5Jv0deR0dg==
X-CSE-MsgGUID: IkGzy6sXQ1C4Ho4wtBgtWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885079"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885079"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:19 -0700
X-CSE-ConnectionGUID: 0hjbVoFBRra2o2ZYQAKd0A==
X-CSE-MsgGUID: yYRQvOoiT56pX4QqdSltSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558967"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:18 -0700
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
Subject: [PATCH net 09/10] igbvf: Fix leak in TX DMA error cleanup
Date: Tue, 28 Jul 2026 14:09:06 -0700
Message-ID: <20260728210909.3042004-10-anthony.l.nguyen@intel.com>
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

