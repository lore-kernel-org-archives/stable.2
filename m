Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F92343D9D;
	Tue, 14 Jul 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009848; cv=none; b=HEigPvtV7CaU6PtyBHSoUWkdvqWXkykx0kY5saf63AHzX6ljQVG3Fc/SsfyDQe0u+U9NQE9rXtpLauTZn6wcgA8pVas1a4hkvbN8YFvbZwdIA4ua8Cw2OIU97K8kxRuh4m0Hgrx7UNdFGdE2NM+Q8PV5j5SECstQSZYx5UTvWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009848; c=relaxed/simple;
	bh=yPJi8dqAeqIB4aBsYSEWntf2un8xrRXwoxXijOHtDEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qnZSIEfKzqo8GHferNJSZdjN3FYZmLY7FGjT1NdHkp35WOPiGDJziBjKBs/C99H+XBFzTSQA0SFBbdxgeiyi9ETYpI3K1gm8iaeYnMY7ns8fTFyItP2VBaFxGp71F7+FTIm1CSr2tRu7vpeQ4Ovh0S+sruRGBjU37RHXItTFl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCjRekVa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCjRekVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784009846; x=1815545846;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=yPJi8dqAeqIB4aBsYSEWntf2un8xrRXwoxXijOHtDEo=;
  b=NCjRekVa+IHfGyueB1J6gT14KR7koIj5OHu+ZtOoikvWomoCYNY9nJoH
   NwxvGTLqhHXh6sAbsO35QYCU72HyK4G82EUXonPd3IjxY8lcQ8pIvCrjE
   k5oxXjoqsO34EYNh+bE0QkvGvIRYoCUWYHUBq0yaHY0yBOuwur7cUEjSt
   y/f2p78ScYOI8K5whoz0QKmYc9TpYpqORAoGCiCyM1oCXAJkDd/IDoMI9
   nfVPyeFNEyQgXI60qiGHm3TafXK4uBJpWlnNWPqY60yJppoYlXb8mIy7L
   vw74Aqk1OiLSm/Lyru9qfqigv2iIs1/33hZhNywx4QcU9DRJk7b+LtIuX
   Q==;
X-CSE-ConnectionGUID: cS0TMVj5RHOFnX184q0+Xw==
X-CSE-MsgGUID: HsCtZASTR0qCF9jk6hn2ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95227334"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95227334"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:17:26 -0700
X-CSE-ConnectionGUID: Qf5lIy5bRy2ZZHWUUqr0fA==
X-CSE-MsgGUID: BZJf3tSWS8Gb7gK15xa2DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="251809889"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 23:17:23 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Tue, 14 Jul 2026 08:54:17 +0300
Subject: [PATCH v2] drm/xe/nvm: fix writable override for CRI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-cri_nvm_fdo_flip-v2-1-14580e71b58e@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0JmbQ3tAEVX3sMQonSQSaAlLWk0p
 He3cgCX7yX//R0CeaYA12IHT5EDO5tBnQoYpod9kWCTGVSpmlKXrRg89zYu/WhcP868CkR81lV
 N0pgW8mz1NPL7SN67zBOHzfnP8RDlz/6JRSmk0BeFGptGI1Y3thvN58Et0KWUvlJDQFOwAAAA
X-Change-ID: 20260708-cri_nvm_fdo_flip-333b545e1dd8
To: Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784008475; l=2208;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=yPJi8dqAeqIB4aBsYSEWntf2un8xrRXwoxXijOHtDEo=;
 b=JQHtEsrvNDL7FiH3ZfVzZUo4fLLtwJWDYSOuLDPlhh7akUtWo+p1mOi3Vwj780IE8h8NmmJVt
 BHEN//o76UVA16e/h48/bGJhHUaiQSKcmc293bfSCyqMQ1O/jm8wEQy
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=

The witable override should be set when FDO_MODE bit is enabled.
Fix the comparison to distingush this case from legacy systems
where bit should be disabled to have override.

Cc: stable@vger.kernel.org
Fixes: 9dde74fd9e65 ("drm/xe/nvm: enable cri platform")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
Changes in v2:
- avoid multiple assignments
- Link to v1: https://lore.kernel.org/r/20260708-cri_nvm_fdo_flip-v1-1-792373667334@intel.com
---
 drivers/gpu/drm/xe/xe_nvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 33487e91f366..1ea67eaeae24 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -60,35 +60,40 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
 	bool writable_override;
 	struct xe_reg reg;
-	u32 test_bit;
+	u32 test_bit, test_val;
 
 	switch (xe->info.platform) {
 	case XE_CRESCENTISLAND:
 		reg = PCODE_SCRATCH(0);
 		test_bit = FDO_MODE;
+		test_val = FDO_MODE;
 		break;
 	case XE_BATTLEMAGE:
 		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_PVC:
 		reg = HECI_FWSTS2(PVC_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_DG2:
 		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_DG1:
 		reg = HECI_FWSTS2(DG1_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	default:
 		drm_err(&xe->drm, "Unknown platform\n");
 		return true;
 	}
 
-	writable_override = !(xe_mmio_read32(mmio, reg) & test_bit);
+	writable_override = (xe_mmio_read32(mmio, reg) & test_bit) == test_val;
 	if (writable_override)
 		drm_info(&xe->drm, "NVM access overridden by jumper\n");
 	return writable_override;

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260708-cri_nvm_fdo_flip-333b545e1dd8

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

