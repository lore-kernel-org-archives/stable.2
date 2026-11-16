Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856946;
	b=nuSwu1vY6Wo34Sf9MjJQu5PPPRV/mT0c2VZKPUEu+bQ1RiXuc/pR/K6D+DIGjrpZn7+4
	 fenMmkHWap+IZpJZYcvPW2lcMvOf7QWUpRfdeAJOCvkikEhcZVG4FxOfjQBMLm1QbW+8h
	 FRBpxrFiDD8h2YvswupbZALFyacp0WrfSXeDApNk+dMs85ovR4JgUda8lHsY0Cyx1MgFl
	 szl4pdCrQvnetaqwL1iS1YAmg5MqBhKgXtrnLyzy7lBJeIdK4EGzoZlEhoa7Hm1vjx7ON
	 CxlVu8g2A/JFUmKD+b8RlfVlcfMEDxbZvzWcSe5rGX6FNG19ntkBocoZ/f3acz/vDBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856946;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xx6FcWY9u65jUUufJn46c++gCunKww+Fb7C8DkQidpQ=;
	b=0wzZUQm9otCzEfuigTezSVYqq0Uxtmffm0p4C9zkUP8bB+v0/6Bokygdskd/m68DOPpp
	 /dyJHBrxXvj16iGoPF1i8fG4ujIP+GihBaxzjDTkAnH8qeTVHa7viAVuaTRuuCgpA9qZa
	 yfchiIS7CQLkoDNgEOjwN6+oZGcNMUR6qzTE736/wPgIwW0sQF0BzTti7fVYkY3r/qgF8
	 eC5fshN7k87ObjjIzPhCLDKFgs+2VZJKcfywlZFB9oGsjkEm+S6VnG9Ur22sLQTd56MpE
	 PHAu0VJ2mYUaEgGyU4EIeEiDWtpsYlnriMNRyxDrdfrII4RycoEJmZuQBpDqHWNBtag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="iq2mXt/i";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064F606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 19:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5064F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iq2mXt/i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794856944; x=1826392944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5SzP6hptCdXa10Wi//bLmdM38aPhwA2MJGkoHMs50T8=;
  b=iq2mXt/iM6HPTU4nfTNQLywme4AACH5pyaPALmOWNmb2jF/t1WCyNqzn
   i/rSvClnSJSvg9Sa15BRl7sTuV5PLAGNfqmq60ER1sDODkLpFmS6MA/kT
   r1nZ21rcxuLkU9LcioNXy+iROHrftIZczZYEgc9qcqQt6P9pOzH69VupG
   dJUvsig7rO5acL3jUDn0eaSzeAGJtIgOSFD2jAuC5oNb4BVtNdU38tevs
   CTXqO0AEV9loi9zlTbqj+/4DWrd+e5qJ3LROH+D5uSyyX9b9Swnj1Aeg/
   ON1OyOwTTimjDNIcPevCA2BJHAlCWFSg+WJpWamADfCtyUM710GsjyNQ+
   Q==;
X-CSE-ConnectionGUID: 0SITQUVKSceVPjWkutauxQ==
X-CSE-MsgGUID: 8kDmjOuRS7GnBLFH39gdww==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3712965"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3712965"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:22:23 -0800
X-CSE-ConnectionGUID: l9gZJXnNQ1usjG7TI4ZTeQ==
X-CSE-MsgGUID: hZI3C/IoRrGfTBkeb9neNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9642930"
Received: from cyp05.fm.intel.com ([10.36.55.41])
  by orviesa002.jf.intel.com with ESMTP; 16 Nov 2026 11:22:24 -0800
From: Zongyao Bai <zongyao.bai@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Zongyao Bai <zongyao.bai@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>
Subject: [PATCH v2 1/2] drm/xe/guc: Treat CT-disabled TLB invalidation as cancelled
Date: Mon, 16 Nov 2026 11:22:19 -0800
Message-ID: <20261116192220.3872267-2-zongyao.bai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116192220.3872267-1-zongyao.bai@intel.com>
References: <20261115225731.3073489-1-zongyao.bai@intel.com>
 <20261116192220.3872267-1-zongyao.bai@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a GT reset the GuC CT channel goes through two states before it
is enabled again:

  gt_reset_worker()
    xe_uc_stop()              ENABLED  -> STOPPED    send: -ECANCELED
    xe_tlb_inval_reset()
    do_gt_reset()
    do_gt_restart()
      xe_uc_sanitize_reset()  STOPPED  -> DISABLED   send: -ENODEV
      GuC load, CT enable     DISABLED -> ENABLED

xe_tlb_inval_issue() treats -ECANCELED as "undelivered, report done",
but -ENODEV is propagated to the caller. A userptr invalidation from an
MMU notifier (e.g. munmap() on a fault-mode VM) issued in the DISABLED
window thus trips the XE_WARN_ON() in xe_vma_userptr_do_inval() and
taints the kernel:

  Tile0: GT1: GT: reset started
  WARNING: drivers/gpu/drm/xe/xe_userptr.c:133 at xe_vma_userptr_do_inval+0x340/0x4a0 [xe]
  RAX: 00000000ffffffed
   xe_vma_userptr_invalidate_start+0x4b7/0x7c0 [xe]
   __mmu_notifier_invalidate_range_start+0x247/0x370
   unmap_vmas+0x1af/0x1c0
   unmap_region+0x91/0xf0
   ...

The TLB invalidation ops contract is that the backend returns
-ECANCELED when it is mid-reset. The reset invalidates all TLBs, so
there is nothing left to do. Map -ENODEV to -ECANCELED in
send_tlb_inval() so that every GuC TLB invalidation type handles it the
same way, instead of only send_tlb_inval_ggtt_full() as done so far.

The CT is also DISABLED across system suspend and runtime suspend. On
resume from system suspend the GuC is reloaded with all TLBs invalid, so
nothing is lost there either; user space and the MM kernel threads are
frozen by then, so such a request is not expected anyway. A request
issued while runtime suspended violates the PM rules and is still
reported by the "Missing outer runtime PM protection" warning in
xe_tlb_inval_fence_init().

Fixes: db16f9d90c1d ("drm/xe: Split TLB invalidation code in frontend and backend")
Cc: <stable@vger.kernel.org> # v6.18+
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Zongyao Bai <zongyao.bai@intel.com>
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
v2: Add Fixes tag and Cc stable, simplify the code comment (Shuicheng)

 drivers/gpu/drm/xe/xe_guc_tlb_inval.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
index dd38d95c6014..1a15ff652589 100644
--- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
@@ -32,12 +32,22 @@
 static int send_tlb_inval(struct xe_guc *guc, const u32 *action, int len)
 {
 	struct xe_gt *gt = guc_to_gt(guc);
+	int ret;
 
 	xe_gt_assert(gt, action[1]);	/* Seqno */
 
 	xe_gt_stats_incr(gt, XE_GT_STATS_ID_TLB_INVAL, 1);
-	return xe_guc_ct_send(&guc->ct, action, len,
-			      G2H_LEN_DW_TLB_INVALIDATE, 1);
+	ret = xe_guc_ct_send(&guc->ct, action, len, G2H_LEN_DW_TLB_INVALIDATE, 1);
+
+	/*
+	 * A disabled CT can't deliver the request, and the GuC is reloaded
+	 * with all TLBs invalid before the CT is enabled again, so there is
+	 * nothing left to invalidate. Report it as cancelled, like a stopped CT.
+	 */
+	if (ret == -ENODEV)
+		return -ECANCELED;
+
+	return ret;
 }
 
 #define MAKE_INVAL_OP_FLUSH(type, flush_cache)	((type << XE_GUC_TLB_INVAL_TYPE_SHIFT) | \
-- 
2.43.0

