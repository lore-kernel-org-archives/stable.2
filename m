Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4C384CD8
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799577; cv=none; b=qj+hIKTevUuzZ/+7p2AHWmLxeTdcaNkztAUMvoqAsSD2kLfUOXlaRti/xPb2SElImR9YfbxiFVM77DfamZg0WTJR+1I4ruzv8J4TcC/jhfhBJz687C3zS41lqZsGwMRdi8Uak3PihM0oyJ2J5DfbnXxyFK2StnzGwgRKNe6bbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799577; c=relaxed/simple;
	bh=pSiuyBysZaz3FkIX1NikmgdEEqYdC3Uo34/t54juK8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlK9G7Uf+cftnfcWz4FaAPQNB2Z9CVRVoPiH5A79xwA68oX3blDjRx7BnhDygGiTnpYYkZ/bjgzQsv4fFs55kF4Vxs+CkZEJ4j4QMLphIJSnbam/r8gcuIzQX00cppOKYAndu6+cT8hK8bPU1ucM9zWmmuCCOD+GO4vnLSZ9fVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nfm6mJ9z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nfm6mJ9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785799576; x=1817335576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSiuyBysZaz3FkIX1NikmgdEEqYdC3Uo34/t54juK8k=;
  b=Nfm6mJ9zxlNS9T8Cv4biON9S51zxgYDbax6GQfM7waHXe1nRM060BCYw
   vLZVSYhysZiqfxx433C7WwxrukYS9g6sVXg51fisAV9lHaL3zJvTpW2ZU
   /Bl3MPAg+FJi0UXi6E+muPxu8Dl7lJpGvAqC3Ygr1yEbOXzss98rJy88j
   UggWiatGWSTj6PBulmkD9GCZZNK9GOZMSJ6S+LHTnpJCAkDpM6+8RqOiW
   yeEsBwSz/ahHSeFdFy+QQzOTcpXXb8wY9fGOBwZPRNlenuhTTS0+uItFl
   lC7hQfEbJ27uW0ExergI+og/3/ziGZrpSvmnQBrtbmok5uZGnjTrXozP0
   Q==;
X-CSE-ConnectionGUID: nQQYBgnCShm+eyR91zKYow==
X-CSE-MsgGUID: X3Qa5ChaSOqYEYfipHJGmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90232413"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90232413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
X-CSE-ConnectionGUID: 9R/1bNCwR6e664r7xYc1hw==
X-CSE-MsgGUID: dRZra9i/S/2e3To6zpG2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261932554"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:13 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y 04/10] drm/xe/rtp: Keep track of non-OA nonpriv slots
Date: Mon,  3 Aug 2026 16:26:02 -0700
Message-ID: <20260803232608.3276045-5-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
References: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
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
index 6b7c90ba6d10c..a5658b2df0cc1 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -92,7 +92,7 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	},
 };
 
-static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
 	struct xe_reg_sr *sr = &hwe->reg_whitelist;
 	struct xe_reg_sr_entry *entry;
@@ -124,6 +124,8 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 
 		slot++;
 	}
+
+	return slot;
 }
 
 /**
@@ -137,10 +139,11 @@ static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
+	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist);
-	whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist);
-- 
2.54.0

