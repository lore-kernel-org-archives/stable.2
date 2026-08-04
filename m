Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E3403B18;
	Tue,  4 Aug 2026 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882151; cv=none; b=LEJqgv4//FpbMIC/liwEdGsKxpl65slNAushR0rRiGR1NMvUFJRAfoHK5XP9b+aZoF9+Do943iJjvC1G8P25iUzcVHN49phCe37qAuyIlfk8LClpjX+GBvmYuY5Yr+ke20pX43acUn8P8IOwGVjEsD7tOewDg7oTChsxUOlB86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882151; c=relaxed/simple;
	bh=V4CpqEQMZkYY0Tkt6iyiDUfr88J5bMsJ8BbTI3hW6O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFtrvIhMe9HSpiA89FN06s89ohgKIKUHBXNWdFsc/zW84fsAgwQ1SD/YDlxRnkaUXH9E0b++zoRYnDb8oaJQjy9+IQPvujRIzxrdjOyRjtrDJoV7En0GLgYVynpStEVrYeboUkVoctHrF/vmlHBWg+icjPJ1GprCYjmh17olQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQaH68b0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQaH68b0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882143; x=1817418143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4CpqEQMZkYY0Tkt6iyiDUfr88J5bMsJ8BbTI3hW6O0=;
  b=BQaH68b0ynh1NdVKf+mUA0W6kALxu4fyCmp1YlqoaZ6q0udqq/AHCWcT
   fYn2EPQNSNZFskAa+/zq4xZT/ypnPt5cWMfDA37RZwxRkJcUCo4X2JBVl
   HNxXlJGvVQ9K9WcPK7JOXyYWO/3xSUOZ2Jjh3fxbf4rczlWji0MRaEGkb
   BInTnhSsYCjAhZFC0uxfIuQQ5jiUQn3cSmAAeH5+4dyBhiUtO4aDSOPTz
   4315Q2Mt/tiBew+clK8a2Ds+wOfI5FFFABxdfvkEAAZEJSEL2pHd8CVlb
   SpfQzRF1vVtjvtXmrl2So34pLpRe8h2ohOXoX2YPC5HfMHmLl64PsGLwr
   A==;
X-CSE-ConnectionGUID: MdIzvglyRpaPl7g5piHXYg==
X-CSE-MsgGUID: jJUf3CfhTDKeTpQqmN50lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803444"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803444"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:21 -0700
X-CSE-ConnectionGUID: e6keMoW/QYqMO4wToRvl0g==
X-CSE-MsgGUID: YtE/7bxHQWuz7sJZwG5kDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257307997"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net 07/10] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Tue,  4 Aug 2026 15:22:00 -0700
Message-ID: <20260804222205.1580328-8-anthony.l.nguyen@intel.com>
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

From: Doruk Tan Ozturk <doruk@0sec.ai>

ice_eswitch_release_repr() frees the port representor metadata_dst via
metadata_dst_free(), which directly kfree()s the object and ignores the
dst_entry refcount. The eswitch slow-path TX routine
ice_eswitch_port_start_xmit() takes a reference on this dst with
dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
is still in flight (e.g. queued in a qdisc) when the representor is torn
down, the metadata_dst is freed while the skb still points at it. When
the skb is later freed, dst_release() operates on already-freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst is
freed only after the last reference is dropped. The dst subsystem frees
metadata_dst objects from dst_destroy() once the refcount reaches zero
(DST_METADATA is set by metadata_dst_alloc()).

Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
nft_tunnel: fix use-after-free on object destroy").

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
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

