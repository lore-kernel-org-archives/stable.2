Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E434D926
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897985; cv=none; b=WfnYJQOj4TyPegn/+yI4pqip+Lk1VoteTip7Dph/3y+JZXbD7bbait7wVauI3wWMJqtvFaceQQnwusrS4vxE/H6hV5cD7aaGiySmrZTjLR5gNK06paDp5hiNRK7jZhqmg1PirBLk1peOkLQLERAWxeBw/CGYQHetYH0tyrpcXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897985; c=relaxed/simple;
	bh=sYwA8ldDSHUPPjOpkaHEgeqeczfM4OzaQoT3u7KQ1xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjlLn2nygayEdN0Ngpgz2RJgSwvDbUJ7l8v+V/ZNz/0Je2S0X/ha/b1zyFucJW2mgtczdtVq8RBKc2BkI5LRvZVmLpKP5Om8afYvFgaRtz8FyAzdKBLS52hF0HIUb5OFKvv6Va4S/pDFnEUPv+Ve255bGDSvKMJHEnPqQsbse20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSRBqhCN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSRBqhCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897984; x=1817433984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYwA8ldDSHUPPjOpkaHEgeqeczfM4OzaQoT3u7KQ1xg=;
  b=gSRBqhCNXi1uvok417Ki5G09KUHqB+8yTHbmtA6GTWfFINXRu3LZ9voh
   Hd8+lAxCyFEea70fOZQ3unQMAZUynt49aEgsgQYfL9Fj5rJqMTy/MDZ/u
   YkmpcMwrEogEUrEQeTXW+RSL7fSJUiaOnpekLVbhwv72YUHLL1AaPkC4d
   9wm0ApYscPEbppdkjkp1AF5zjVGbG5rLrQMnaW8KNGodmRWfFlUXIRAJQ
   WQduhofYTRz3H/XUB8qfCSCOgI6/yTxxZXUdhisdrt49rRa2Qpzaw0wgY
   cnUyIfEgRGGrjkyz6CmatElpOC/SIJ6ky9fCeMzJVII+5NKblH2Me4i69
   Q==;
X-CSE-ConnectionGUID: 6vXJNXd5QcqDo6pXoRGXrg==
X-CSE-MsgGUID: rojdhxfeSCW1VQc8+0sFgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586048"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586048"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
X-CSE-ConnectionGUID: 9XAafTSfSn2ODvz2+RcW+w==
X-CSE-MsgGUID: VyFipa+GQbW6MLLumjm0TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925513"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 04/10] drm/xe/rtp: Keep track of non-OA nonpriv slots
Date: Tue,  4 Aug 2026 19:46:08 -0700
Message-ID: <20260805024614.3406679-5-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
References: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 60d49ea28bb190a640bd8dc3f4c946e0811a948c ]

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

