Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3935C6A1
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798111; cv=none; b=OcuNYh354uFIYHYV119NdwopAnRDXaw9LP5bUYvcX3++1foZgrk4KiLriB28mECA5qPmQ26QAaky6LQ7XkNn6qhzONxsfKkj279yj0pVxadjb9U9ai3981K4uFzALqRyEvTyQLlTKlq5d6E+wKa91Sa1kBzHAjVyH2u3h4XTkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798111; c=relaxed/simple;
	bh=7lBSiRYEBlg5WnrC7JIJSuG2PP38cpaWhDxF5+f8vRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGrJuEXMDu/RlwODh6YSbSWfPjTOYufdtvUCcuL8us+I3ykgst9Q+7hPg+yh3sbWEddgDryxTkPT/fZe8YNXMAtVbk9fb9KX9jeJ05YykfQASxOgJ2TOuiBngaA/hbhmGOU1wbFpd+MMzXCMRkuJJaRpqVcP8gSaceyd3J0QsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXfvW80M; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXfvW80M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798108; x=1817334108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7lBSiRYEBlg5WnrC7JIJSuG2PP38cpaWhDxF5+f8vRI=;
  b=jXfvW80Mas5SM6SqSACpuFulZUIf3n7RCv+K3bCeFXwNFneiCgHN6gqY
   PxHR7t/xesoAJPIT1MzIxh8UZ2MljXHORTvv+/HqqgAxzx1jAV8Tt4oIY
   K7lflHgzLE+lTRx+HI2VH4gFh8Q1C6kxzWAAuJi4x11CkhCqlPQRaKoAP
   cpwE+9sy518zHel6ErK0iVCZlyGNh2KzntDE7CyxhejqWa7yfAcP0phBn
   40I1VqIZ+cUlKkBzQxj/IeXC0MoT2KZ3jNvd20o7Kv3LuZ35MydguOJes
   6qZbsMiw47mcrbl6+XnSqSM9zBgEbtHegFB+D8m0IGwdIrhpqDIJ34Nxp
   A==;
X-CSE-ConnectionGUID: oej0lQNVREqj+9G2Ux62sw==
X-CSE-MsgGUID: Ye7GfkNaQpeouLynqW2pMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871288"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
X-CSE-ConnectionGUID: 0E1ZrX7NTi+iVSBqioVBXQ==
X-CSE-MsgGUID: XYtrDOLuTPSEOgdQc8fzEw==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 2/8] drm/xe/rtp: Keep track of non-OA nonpriv slots
Date: Mon,  3 Aug 2026 16:01:30 -0700
Message-ID: <20260803230136.3270230-3-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
References: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 15739920b71ef3c56868973b4e7e3164a793d09d ]

In order to dynamically whitelist/dewhitelist OA registers on OA stream
open/close, we need to keep track of nonpriv slots occupied by non-OA
register whitelists.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-4-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index a0bbf4b745a1f..00f00002afcef 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -147,7 +147,7 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	},
 };
 
-static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
 	struct xe_reg_sr *sr = &hwe->reg_whitelist;
 	struct xe_reg_sr_entry *entry;
@@ -179,6 +179,8 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 
 		slot++;
 	}
+
+	return slot;
 }
 
 /**
@@ -192,10 +194,11 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
+	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist, false);
-	whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist, false);
-- 
2.54.0

