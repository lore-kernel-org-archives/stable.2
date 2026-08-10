Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93F3D9DA0
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365521; cv=none; b=GRf5OhG2YgJIXABQs9jeFiWxcumtbzptk+zDBO+fWT3NwQt4/ms3vpmYLXfrFVSvpcx7AnLgi6t9ZGYOG3rPnK7T2ugIZY8IhsYiAwGkSL8FaRQml96x4T/3YVn6oXsjSdRD+wi60exIbEISR7YlQczjNXL8pNQ64Iu75Wn28FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365521; c=relaxed/simple;
	bh=vFHxzaqONPX8VxvDD5NsHouMuokIULmGMJUM0IIyEq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kD0MLlrJCRqTy2HtR78JvgXYbGeTiepfxIcf674JXR+yZhcnKAevcErgRGp0LAFdzsnxYyyH0YoeAPcNYRrbJNsYEesac0QWbBsGKo4Im7TcFT+weeU7GZKoRSpF5tU4TNShYWRrEPpgeViqDuIf/q3rgG+FOs2+ozEJ3SY0vH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WumG0Fq9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WumG0Fq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786365520; x=1817901520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vFHxzaqONPX8VxvDD5NsHouMuokIULmGMJUM0IIyEq0=;
  b=WumG0Fq9g5ZHfP1moHY8OlSBzxmSGqyPlePMHwLGW2kGfu1BBjvz/53M
   PKsHQNrQ5Cg3dz6+XLSVZpOdMZWy18W/oTEbV0vZ2nWJsS/68XY1EbHIL
   KbXQsoHXTgnCwF/++PNNst7MZCQ6IC2oNiYpp7MI6HynYgE9V0j4n2At3
   1/R57MM9n3O5sFfIU9B6kGWEfhwnVR5Ol+j8RRMs2TXy+2yDmy20AmFIB
   nmYEUz7PbhwdkJFq90oA35sF2HR+L1nGZC1Xgd6SW8SI06jzxp+Y+VX9+
   9oYEAkvCCzAt/IvQCcgKRRIEWJBZKtUE3avEDy362yyyJxMQvsPJ38X11
   A==;
X-CSE-ConnectionGUID: hoKoIZJjQFme2QaSTzqUrQ==
X-CSE-MsgGUID: FlzyjAl/RZO99Di7TZUvNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86755235"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86755235"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 05:38:39 -0700
X-CSE-ConnectionGUID: izTflOdtSHe3YVP8v3JMUQ==
X-CSE-MsgGUID: Na+ihMqvRE+t/asjaKiI9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="262513238"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 10 Aug 2026 05:38:36 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	rodrigo.vivi@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	Raag Jadav <raag.jadav@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/xe: Fix xe_device_probe() failure
Date: Mon, 10 Aug 2026 18:08:20 +0530
Message-ID: <20260810123821.105605-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, xe_device_probe() jumps to err_unregister_display label in case
of failure except for its last call, which directly returns the error
without required cleanup handling. This results in stale drm device that
isn't cleaned up on unwind. Fix it.

[  810.194180] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:01.0/0000:03:00.0/drm/renderD128'
[  810.194183] CPU: 9 UID: 0 PID: 5616 Comm: modprobe Kdump: loaded Tainted: G S   U      E       7.2.0-rc2-xe #382 PREEMPT(full)
[  810.194185] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER, [E]=UNSIGNED_MODULE
[  810.194186] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 1805 10/30/2024
[  810.194186] Call Trace:
[  810.194187]  <TASK>
[  810.194188]  dump_stack_lvl+0xe0/0x100
[  810.194195]  dump_stack+0x14/0x20
[  810.194197]  sysfs_warn_dup+0x5f/0x80
[  810.194204]  sysfs_create_dir_ns+0xbe/0xd0
[  810.194210]  kobject_add_internal+0xbc/0x2b0
[  810.194215]  kobject_add+0x7c/0xe0
[  810.194220]  ? get_device_parent+0xcf/0x1e0
[  810.194227]  device_add+0xe3/0x870
[  810.194231]  ? __pfx_drm_gem_name_info+0x10/0x10 [drm]
[  810.194280]  drm_minor_register+0x73/0x130 [drm]
[  810.194322]  drm_dev_register+0x76/0x2a0 [drm]

Cc: stable@vger.kernel.org
Fixes: da3799c97572 ("drm/xe: Use GuC to do GGTT invalidations for the GuC firmware")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index e327c7d35ca3..cad531009721 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1165,7 +1165,12 @@ int xe_device_probe(struct xe_device *xe)
 	 * xe_device_wedged_fini() is registered.
 	 */
 	xe_ras_process_errors(xe);
-	return devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+
+	err = devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+	if (err)
+		goto err_unregister_display;
+
+	return 0;
 
 err_unregister_display:
 	xe_display_unregister(xe);
-- 
2.43.0

