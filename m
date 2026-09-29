Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3844F85CF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675110; cv=none; b=oOvqKdqdPyrswgnzL6XXaSQQWcjs7XrQ9uIbLCO/C+/av30Qco9VPma9pSRSLameJ5qBqaoDfTUmMR5IiINKpJZ2JktbB9w4Xu+np+5RcHgBj2v3wLlousTa/0fnEDNZdvc3TgOAfMO6GsE5yV0c7p0zrm8vo75vUmLa1G80Pqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675110; c=relaxed/simple;
	bh=ja/YuURfL/2mxMrcSCx4I35STmsYln5TBCCqoFunyEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr7DThssmzmgAzph9jzf22G28ovxPQZLY9tE18bl83ofO1zyWigVcYkT/9oLt/1WXdzfQQJfpGl+r8jjjHjnUzZdltAoYy+2Uzfy6RhXHfwmdZ71ewwHr9wnp45yUbksrtpFDBmHhvO0FVR/ULomYQvJ3e3zYs50OtbalxskT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvpEMvsM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvpEMvsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790675108; x=1822211108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ja/YuURfL/2mxMrcSCx4I35STmsYln5TBCCqoFunyEg=;
  b=FvpEMvsMuGaHnBaTL8Y1ISz422ie4tt8HFgTWJF/6djwqGiCSEpjXpAM
   U6aBYL76pebNzB9WMbQMztsJjzak4nPuxMC2Vn991YewNeFIGw4642AQ6
   7JCQ25CEon9AwKQ4DdzNq+ZD5KEjaSZh63s2VerAnXBQaRA3stAlkWNRE
   vL6uUtbVMe51E+7AVSUEVJVP9HqsxDpqYyBEn/MYYwn4N7zQaRVXLnKzt
   Qth1A8Qbumv8BL5ojYMREVqaB6nxGzOxurAShci9JlQLrjRcAA6oRCkzL
   MIa05+cUrbilk5qr43584kDDdwBYtsS+a/aTdjjhl9SS+GaEwvbzclRZS
   A==;
X-CSE-ConnectionGUID: xl0K8+UmR8eWxQlVPxDNyg==
X-CSE-MsgGUID: uedfQWIRSDa8JZVjAiGpGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91250069"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91250069"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:44:58 -0700
X-CSE-ConnectionGUID: H4D21wLrQXaJEtW2jcnVNQ==
X-CSE-MsgGUID: E8KJAXsLTAGYWdXDJcGwLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="283414995"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.120])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:44:56 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/8] drm/i915/psr: Fix SFF and CFF CTL register bit definitions
Date: Tue, 29 Sep 2026 12:44:30 +0300
Message-ID: <20260929094434.77129-5-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929094434.77129-1-jouni.hogander@intel.com>
References: <20260929094434.77129-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Single full frame bit in SFF_CTL and continuous full frame bit in CFF_CTL
are bit 0. Fix the definitions accordingly.

Fixes: 3b5bf853e309 ("drm/i915/psr: Add register definitions for SFF_CTL and CFF_CTL registers")
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index bb577e7e3bbda..a57bc111290d1 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -254,12 +254,12 @@
 #define _LNL_SFF_CTL_A				0x60918
 #define _LNL_SFF_CTL_B				0x61918
 #define LNL_SFF_CTL(tran)			_MMIO_TRANS(tran, _LNL_SFF_CTL_A, _LNL_SFF_CTL_B)
-#define  LNL_SFF_CTL_SF_SINGLE_FULL_FRAME	REG_BIT(1)
+#define  LNL_SFF_CTL_SF_SINGLE_FULL_FRAME	REG_BIT(0)
 
 #define _LNL_CFF_CTL_A				0x6091c
 #define _LNL_CFF_CTL_B				0x6191c
 #define LNL_CFF_CTL(tran)			_MMIO_TRANS(tran, _LNL_CFF_CTL_A, _LNL_CFF_CTL_B)
-#define  LNL_CFF_CTL_SF_CONTINUOUS_FULL_FRAME	REG_BIT(1)
+#define  LNL_CFF_CTL_SF_CONTINUOUS_FULL_FRAME	REG_BIT(0)
 
 /* PSR2 Early transport */
 #define _PIPE_SRCSZ_ERLY_TPT_A	0x70074
-- 
2.43.0

