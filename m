Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879242E406
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981356; cv=none; b=pTRRaz7E9GT0+7Q8OB+0kRK99FvQTpihdIPZg7C9XXBVQDbju8au/HWdeCBzv4blsaQEBCs1UHCesNU9zICu4rx//bFQLfZBl9j4U+Mwm2RnM3wE69TNYZhRV+NR5wCBCdiJn7a/bgNdMahMYRa8acH/G6t3zohgPnHnIsN7UvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981356; c=relaxed/simple;
	bh=HjhdWz3TL+zKMQgCb85LDtJBaoQ8IO3yBXPgS+ZrfP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlqETTagOxEqnhLwR4a+6JEbFTq8X1AcwrGe36PChGN3wrWPOdSZAH/GObXmyZ085ddpfINWV5olbJcrLrraSepBsc9KIpfvHUME4/lhbvx0wO167mpKKOGqkteFe1KBTQeMZYiLK686vVnq8yTIv1MMvVaT+4kZ5lne8eWHtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RA3YJ/ua; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RA3YJ/ua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789981354; x=1821517354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HjhdWz3TL+zKMQgCb85LDtJBaoQ8IO3yBXPgS+ZrfP8=;
  b=RA3YJ/uagckoVe5bI0Ndg98pQJNA3WhSyvowOTayit9kkFLsZQ+BPntY
   ci98oIh8/VprLv2yjv21+bkWu7ked44G1hzL7e08KBCLUiEEQScEyw7e8
   o6F6KkVuL1i/FCsjKMMW213TVv+C9KtrzD2K/YYnWn5KSIOndRTVIL0CX
   sGfFU5C9g2dzjMaFrzEwBosDQCEIcJHykoQC6K7zkxrFepTCw99hPpAUU
   YO1uTERzz88WaYU1xiBUlg8wL+Dr3dfRZJ6/zXO5IBZNaKgD9diBkiNOo
   72JaacbkjoGZWZMhna0zj61eJCaMGIvrseAa4I2+110HRBhO0Cym+wUbJ
   A==;
X-CSE-ConnectionGUID: 140ptfz2Q/WGvnmTVXsZoQ==
X-CSE-MsgGUID: GBHo1/YQQ7SmNl6q6OKsTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="988896"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="988896"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 02:02:33 -0700
X-CSE-ConnectionGUID: XAjLis+pTS+zvPF4cFLCLA==
X-CSE-MsgGUID: 6Bg0dk8wSLCundcoR7RiPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271102552"
Received: from dbhadane-mobl1.iind.intel.com ([10.190.239.58])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2026 02:02:31 -0700
From: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	stable@vger.kernel.org,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [PATCH v2] drm/i915/cx0_phy: Fix ARL-S host bridge detection
Date: Mon, 21 Sep 2026 14:32:26 +0530
Message-ID: <20260921090226.946472-1-dnyaneshwar.bhadane@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix is_arrowlake_s_by_host_bridge() which always returned false.
The while loop always exits with pdev as NULL, so the return
condition was always false, causing the wrong tx_misc value to be used.

Check the host bridge ID inside the loop body.  Once found early exit
from the loop release the pci reference "pdev" and return true.

v2:
 - Update commit message (Chaitanya)

Bspec:74165,74491
Suggested-by: Jani Nikula <jani.nikula@intel.com>
Cc: <stable@vger.kernel.org>
Fixes: 3630a47b700e ("drm/i915/cx0_phy: Update HDMI TMDS C20 algorithm value")
Signed-off-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index dbebd7210848..de450ebf541f 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -2342,12 +2342,14 @@ static void intel_c10pll_dump_hw_state(struct drm_printer *p,
 static bool is_arrowlake_s_by_host_bridge(void)
 {
 	struct pci_dev *pdev = NULL;
-	u16 host_bridge_pci_dev_id;
-
-	while ((pdev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, pdev)))
-		host_bridge_pci_dev_id = pdev->device;
+	while ((pdev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, pdev))) {
+		if (IS_ARROWLAKE_S_BY_HOST_BRIDGE_ID(pdev->device)) {
+			pci_dev_put(pdev);
+			return true;
+		}
+	}
 
-	return pdev && IS_ARROWLAKE_S_BY_HOST_BRIDGE_ID(host_bridge_pci_dev_id);
+	return false;
 }
 
 static u16 intel_c20_hdmi_tmds_tx_cgf_1(struct intel_display *display)
-- 
2.54.0

