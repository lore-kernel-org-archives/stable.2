Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE73BA244
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146802; cv=none; b=rjfygfr7Uo4i2TsIZ4G7dBJS+IRi3+J8S65KeiZd4guLXEPDANWpTWghD+ZMTzjUlOTEjs5ZETrXZGo9Cs3bHUZbq9mjhIDdF9TtS3XciaQOSvVQUig2cI2b7WP/ms+PMGGqwSTeEeeopkOYC09du9mu6FVyXsBj5oqqpPFqEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146802; c=relaxed/simple;
	bh=IGLi2s4B57jsORoIpOrJkutf6m7ByT90Urjly//0rxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCxDRnOJupVfAW3lat7wtsfolxLG2/NniS8pAXAQMo5pI1qZ7fkKk6BdDdlr+gwDg0vbnz0kAShL9IFAhPEJz0nYcm3ZJbjfP5Fuy1K5cAEC3Pb9O7DF1UPSfig40Awt2NZh/kVCOfOokJf0n/4vsPD8JiKMpbQBywRy4llD8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsxhI3pz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsxhI3pz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792146801; x=1823682801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IGLi2s4B57jsORoIpOrJkutf6m7ByT90Urjly//0rxQ=;
  b=XsxhI3pzS010Xr0s8hUefIuPPmJJ8bTa9VxEMlbK8LHqBy3XehYyf8jg
   WE62zovlzyxUjYqfNk6G9c9VIhUxRwd19PoMvNLA17In3XaP2vjpYFD1E
   oJMZubjwv/1bEX6d+eudrJNcgpmVsjClHvMtzih03YwvphttWZiFibATy
   ps9N0QYoXrUv+ZjrglpL9oQBDE+OTck2/BWDWukLUffdeT3yys5ZYxeso
   2LHqmgLgAUQatoEEVfteRFFDbtYJlqeGv9sS2EgLaZDroaQPWzRSNzjPX
   KXs757u+MaStXzyEAfLGzlApWPAGhe3rW2bfBSyR8IKxWFctm9ze6749k
   g==;
X-CSE-ConnectionGUID: 4yXszDOLSKeA22ucIn5b5Q==
X-CSE-MsgGUID: yjBq/+upT2GQwgqjS3ZJ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="930910"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="930910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 03:33:21 -0700
X-CSE-ConnectionGUID: NkXLnaj4RRWNxf98eRj9UA==
X-CSE-MsgGUID: xOiq6lcyTRu9oletPWZkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1872403"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 03:33:19 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/dsc: Fix QP table index calculation for bpp selection
Date: Fri, 16 Oct 2026 15:47:12 +0530
Message-ID: <20261016101713.230013-2-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016101713.230013-1-ankit.k.nautiyal@intel.com>
References: <20261016101713.230013-1-ankit.k.nautiyal@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the typo in the QP index selection for a given bpp.

The QP table rows increment in steps of 0.5 bpp, meaning each integer
bpp step corresponds to 2 rows in the table. While refactoring the index
calculation to support fractional bpp, the multiplier of 2 was dropped
for the integer bpp portion.

Restore the missing factor of 2 in the integer part of the bpp calculation
to correctly align the QP selection with the table layout.

Fixes: 2df50cb46a4c ("drm/i915/dsc/mtl: Add support for fractional bpp")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_vdsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
index 8f06c3a4d56d..7a573c2b6a7d 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc.c
+++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
@@ -261,7 +261,7 @@ calculate_rc_params(struct drm_dsc_config *vdsc_cfg)
 		 * and so on.
 		 * 0.5 fractional part with 4 decimal precision becomes 5000
 		 */
-		bpp_i  = ((bpp - 6) + (fractional_bits < 5000 ? 0 : 1));
+		bpp_i  = (2 * (bpp - 6) + (fractional_bits < 5000 ? 0 : 1));
 
 		for (buf_i = 0; buf_i < DSC_NUM_BUF_RANGES; buf_i++) {
 			u8 range_bpg_offset;
-- 
2.50.1

