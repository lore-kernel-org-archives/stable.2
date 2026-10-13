Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BB545D85
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924473; cv=none; b=TI6zyMLhWEhsJ5+nJZIDegDCMaZ1TGuGH/QnJmR8a2D4KOQ8o1C/wP7GI6G3A93XW83E+WImZaQ0GDhRxjO2/KToSb5Jd747dNPX2SAZutNcG5gE+m2YY0UgMlx46lNvrM3is7IO0GXde4tJhvRPsqm+8t9TGRNmSycUcvttHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924473; c=relaxed/simple;
	bh=+cihov+RWzaPt5FjuSOQvdaOhI4zDeOZ7N0PHSlj2dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jehw03iONH3Z2QwCAAjaVUeE8GgASHJDn3OdhTBFtL8tTm8zA5HmjQrw64kOxUfFB40YJ3SC3vaJ3zTLgVSAGn/K7fK4gT1OG0QPq6ghM+QAUSiuLkb6MNQdsYWK4rbe5Bn1HPd9YpVLxG7DZ/1qVLXaFLJeQblS58t9QiXjhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahZeNzeW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahZeNzeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791924472; x=1823460472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+cihov+RWzaPt5FjuSOQvdaOhI4zDeOZ7N0PHSlj2dk=;
  b=ahZeNzeWq+1QAx1+TvNZY+/iATkx64KAJehmffEG+kqC4rfhpajLzoxx
   DlvHQ2e6qSfe2kuoZfJwBLBRYWhLxgifSkrbgHumVoo6hbULJMTuYknuu
   0vsmZA3xH/nf5TRziGDr7mSo9JiEIZz6UAY1AiDXYTNkr+XQvzEZl03sV
   6GsU9pynaYc4eb0V+X3EJwnmOuuYlDKEwdo3Qo4HCgq8fwKSSLVJPjJzh
   OX8o0cdBix842QQaGnyBiHXuhfCbLJ8sQdu3wQERQhalJcQNAQC7d97Ms
   hwQJJRdfNER6iRoVGSAJ5z6sQ/B25HkPCBCMgCSF21wIh2YAn1dNVe5Rv
   Q==;
X-CSE-ConnectionGUID: spLc58oxSOOyvBx1qbwxsQ==
X-CSE-MsgGUID: L/FW55i4SUa67ZXrBCQ3Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="539310"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="539310"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:47:51 -0700
X-CSE-ConnectionGUID: u4x/SopGQwiAEk5uuCZd1A==
X-CSE-MsgGUID: Gzm4ZbeyRdq/CJ14UyRpqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1189056"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:47:50 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 4/5] drm/i915/3dlut: disable 3D LUT if unsupported
Date: Tue, 13 Oct 2026 22:47:03 +0200
Message-ID: <20261013204705.1574475-5-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261013204705.1574475-1-michal.grzelak@linux.intel.com>
References: <20261013204705.1574475-1-michal.grzelak@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

XE2LPD_DE_CAP_3DLUT_MASK is defined but never used.

Check DE_CAP with the mask whether 3D LUT is disabled for LNL+. Reset
has_3dlut if that is the case.

Bspec: 71161
Fixes: 65db7a1f9cf7 ("drm/i915/color: Add 3D LUT to color pipeline")
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: <stable@vger.kernel.org> # v6.19+
Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_device.c | 4 ++++
 drivers/gpu/drm/i915/display/intel_display_regs.h   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index a2bea5ac59cf..d4e52e627b34 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -1940,6 +1940,10 @@ static void __intel_display_device_info_runtime_init(struct intel_display *displ
 	if (DISPLAY_VER(display) >= 20) {
 		u32 cap = intel_de_read(display, XE2LPD_DE_CAP);
 
+		if (REG_FIELD_GET(XE2LPD_DE_CAP_3DLUT_MASK, cap) ==
+		    XE2LPD_DE_CAP_3DLUT_REMOVED)
+			display_runtime->has_3dlut = 0;
+
 		if (REG_FIELD_GET(XE2LPD_DE_CAP_DSC_MASK, cap) ==
 		    XE2LPD_DE_CAP_DSC_REMOVED)
 			display_runtime->has_dsc = 0;
diff --git a/drivers/gpu/drm/i915/display/intel_display_regs.h b/drivers/gpu/drm/i915/display/intel_display_regs.h
index 0b3991bc3aef..d3546609e3ae 100644
--- a/drivers/gpu/drm/i915/display/intel_display_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_display_regs.h
@@ -1773,6 +1773,7 @@
 
 #define XE2LPD_DE_CAP			_MMIO(0x41100)
 #define   XE2LPD_DE_CAP_3DLUT_MASK	REG_GENMASK(31, 30)
+#define   XE2LPD_DE_CAP_3DLUT_REMOVED	1
 #define   XE2LPD_DE_CAP_DSC_MASK	REG_GENMASK(29, 28)
 #define   XE2LPD_DE_CAP_DSC_REMOVED	1
 #define   XE2LPD_DE_CAP_SCALER_MASK	REG_GENMASK(27, 26)
-- 
2.45.2

