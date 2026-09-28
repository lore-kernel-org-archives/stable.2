Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68249502772;
	Mon, 28 Sep 2026 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636686; cv=none; b=f5TIdbW7uY+dRWKpddi5UZ3L+a20uoMEUsoje7Kn7OxgKKuCB4gtJ0RWXeAOTfEcrcHJCutXT0eviLa2BQQS16FJTdMT2g0RGdqFySXkxDiZM37bKLFFdRxcU5ZKordnptRcggY7BuJ5yE67fLxsDBKXCz/4bjvLyVUG1C4ffSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636686; c=relaxed/simple;
	bh=PhWJsnuUm4KiEEhOjkK1kYiiCAQE1DMtUrs7C9MI6tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODmaA80waeDnnzSX7JB6q9Ve/FK8lwifpB8tDfWa8v3qLR3PkyvFWSBL67fn2G4jZU/PZMtOtAnGhDbFvWsqZ+IQ/C6CIkdKzr4SG7mrSr9acXhUiQ78yPfxHdN/e5/g/2V9V58dgk+mfKH9U5z+xMlBxQSSfWJFJ2vrpB7gow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVt7Dxnc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVt7Dxnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636686; x=1822172686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhWJsnuUm4KiEEhOjkK1kYiiCAQE1DMtUrs7C9MI6tg=;
  b=LVt7Dxnc5Xgbbzu3vLsa6PopIYM8hpthakdrLcfFMGqYn/yGfAWuV7rD
   tssZfHtlPWdpdkZvWVCxGcLgWZfE8895dT8PyHVJzEti+mht1tC0qk84d
   IUCIWQjEigODYRNX8h/Wa8Cu6hocO6CumYB96c5SBOaSTh+XEvMZdup57
   xVbQEokeRziABG/36w5ICQDPa1q8EKD51RUTkBqmjBBUs1xhixwzPzKzo
   zcqsAfH/oD7aHZlq15WMSz/gl5Lln8bfI4jJ+vTPwOhh1EMMEwXnV9gDd
   h5WwXrX0ccjpTtMIcCntmrrvmdGd/9F+Y/zHqVCVB4rWNtrd7I3ywBRdt
   Q==;
X-CSE-ConnectionGUID: k/Ij3NiGTLO5529MuSRYqA==
X-CSE-MsgGUID: B/m5PhsnSbGFKxYR5tDv+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101513281"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101513281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:04:43 -0700
X-CSE-ConnectionGUID: 6GjamNWbQqOdPAuQbHnnFg==
X-CSE-MsgGUID: 4HmGkk4bTxKh1P1/O0sINQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273317692"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 16:04:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	luoxuanqiang@kylinos.cn,
	bryan.fraschetti@canonical.com,
	tomasz.lichwala@linux.intel.com,
	david.butler@appgate.com,
	horms@kernel.org,
	grzegorz.nitka@intel.com,
	michal.swiatkowski@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH net 4/6] ice: fix metadata_dst refcount handling on representor teardown
Date: Mon, 28 Sep 2026 16:04:25 -0700
Message-ID: <20260928230429.495442-5-anthony.l.nguyen@intel.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

ice_eswitch_release_repr() uses metadata_dst_free() to release the
representor's metadata_dst.  metadata_dst_free() directly frees the
underlying memory without checking the dst_entry refcount.

When ice_eswitch_port_start_xmit() processes a packet, it takes a
reference via dst_hold() and attaches the metadata_dst to the skb.
If the representor is torn down while packets are still queued on
the lower device (e.g. in a qdisc), the metadata_dst is freed while
references are still held.

Use dst_release() instead, which correctly decrements the refcount
and only frees the object when all references are dropped.  The dst
subsystem already handles metadata_dst cleanup in dst_destroy() when
DST_METADATA is set.

Other drivers sharing this pattern (nfp, airoha, bnxt) already use
dst_release() for their metadata_dst lifecycle.

Fixes: f5396b8a663f7 ("ice: switchdev slow path")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index b069e6c514fb..6e7bba473898 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
 		return;
 
 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-	metadata_dst_free(repr->dst);
+	dst_release(&repr->dst->dst);
 	repr->dst = NULL;
 	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 				       ICE_FWD_TO_VSI);
-- 
2.47.1

