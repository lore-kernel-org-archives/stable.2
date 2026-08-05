Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B734D926
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898166; cv=none; b=RjJa4510+v2vp1EuoQYT03/6BmNkd8YODLdrYsHstPeIwZXoiszhGjAC+jJ8nAbYNJrd+34kQD/24D/bPLqfHEIrznVLKKfMAQuLKK7hIMiyF8jPlqEajcQaLC8ELnWZ6kdp4Zd7H7NAjQfkVq13LKK0KHttMDrq13lBNE4WwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898166; c=relaxed/simple;
	bh=fVBet1CB2JCU/lGRN4x/h2p6sjMtZ56/+XAEZesFcB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRP6McnMbwwoxCd70Feiaq/EYamzKOiRpU79aGWn+q2E0018KRU6lEW/efkzjBT1ty15EigmOKZTPo0OYZweXWjHxAlOfB90NgucCDhfFWgSbablduPF6qmq2wAE+ssL4kEumx84u+p6AyEkx2pYoxGa+/ydsUIon5EXDklIspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLAZOTGL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLAZOTGL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898164; x=1817434164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fVBet1CB2JCU/lGRN4x/h2p6sjMtZ56/+XAEZesFcB0=;
  b=nLAZOTGLz0IoA9hl2hS05q3gklpaHvOeQ2r/ooONKFBgUF8DzTLVIq6t
   jTDzN7qFkXHZrEYwE9LxLKeZMKYlmAJ56gIYddcMMA9S6571z+lSoJZbR
   BmgKQuEUCMN5IPEomZvn4MXXoNOnmvuIBMAso7n4i9Bs5srSEAVfY8f5A
   LdWxo+4FjapwC2OKzPQtVlTIIgxpSuGkZ9qAUXaghlX7sVT4pUpqA5jpW
   IkzcX8394ejOSBmdkqT8rygDha6ElFMVYb6t6MnTk6EeGEITHCAK6ZE4P
   7vtKpAPCdOiQJ3g2kNzY/xWoW3D4xlxXQU423jGQg/UuOihy5koRyOR+m
   g==;
X-CSE-ConnectionGUID: Mz3wgBS8TPSWVkKHry/EBQ==
X-CSE-MsgGUID: NQoinjhcRweioS/hB+Furw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826118"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826118"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:21 -0700
X-CSE-ConnectionGUID: 8FtrGmw1QiWLhts5uuvixw==
X-CSE-MsgGUID: s56JtX/DRmmcoPImPVl0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911786"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 01/12] drm/xe/rtp: Refactor OAG MMIO trigger register whitelisting
Date: Tue,  4 Aug 2026 19:49:04 -0700
Message-ID: <20260805024915.3407033-2-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit ed455775c5a68b75e5f6ad6c8e0e3e9c98fd3f64 ]

Minor refactor of OAG MMIO trigger register whitelisting for code reuse
with OAM MMIO trigger register whitelisting.

Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20251202025115.373546-5-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 29 ++++++++++++---------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 3de0a867149da..d88261921ae46 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -64,27 +64,24 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
-	{ XE_RTP_NAME("oa_reg_render"),
+
+#define WHITELIST_OA_MMIO_TRG(trg, status, head) \
+	WHITELIST(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
+	WHITELIST(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
+	WHITELIST(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
+
+#define WHITELIST_OAG_MMIO_TRG \
+	WHITELIST_OA_MMIO_TRG(OAG_MMIOTRIGGER, OAG_OASTATUS, OAG_OAHEADPTR)
+
+	{ XE_RTP_NAME("oag_mmio_trg_rcs"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
 		       ENGINE_CLASS(RENDER)),
-	  XE_RTP_ACTIONS(WHITELIST(OAG_MMIOTRIGGER,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RW),
-			 WHITELIST(OAG_OASTATUS,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD),
-			 WHITELIST(OAG_OAHEADPTR,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
-				   RING_FORCE_TO_NONPRIV_RANGE_4))
+	  XE_RTP_ACTIONS(WHITELIST_OAG_MMIO_TRG)
 	},
-	{ XE_RTP_NAME("oa_reg_compute"),
+	{ XE_RTP_NAME("oag_mmio_trg_ccs"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
 		       ENGINE_CLASS(COMPUTE)),
-	  XE_RTP_ACTIONS(WHITELIST(OAG_MMIOTRIGGER,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RW),
-			 WHITELIST(OAG_OASTATUS,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD),
-			 WHITELIST(OAG_OAHEADPTR,
-				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
-				   RING_FORCE_TO_NONPRIV_RANGE_4))
+	  XE_RTP_ACTIONS(WHITELIST_OAG_MMIO_TRG)
 	},
 	{}
 };
-- 
2.54.0

