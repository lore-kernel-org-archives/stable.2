Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44003D1CC3;
	Wed, 19 Aug 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124522; cv=none; b=JowZSSCUkWWpVEMtx6VhH585fp+6b/IzKdxSwz43sfaLECF5Nh97MySspG2wcXHQFSTV4bFEHTesCz4hQQVx/b9BEeiJT0iMcDBlHqE2GuvQIPTyblZs+NoemfgGyAx420d2WwwW0NOI/Uw3+nplUJXVweebNH/XcoCmqRH6LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124522; c=relaxed/simple;
	bh=bjxkUigIQF/FLCtfFhnV9suBNyW3HXulGmclH/su+eg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+WoW6t5ViBUaWvNhQFbx3fpMg115+scJx6OzXNsppRfkr+rJGC92FpM8c/ntxod3AqSEG5/OwzcYR2N/BzR4g9nSelXh0eFi+3PbGGsiHVzXy6yUtl62g9bsBw+UgQrVQcr1mcIE7Uq3WY2qSApkOag/zKS1Of8apNYUpa4/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW2DpUTy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW2DpUTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787124520; x=1818660520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bjxkUigIQF/FLCtfFhnV9suBNyW3HXulGmclH/su+eg=;
  b=HW2DpUTyJRLrKnZiCZHJ6ae7/m1q5r5nNIACc/Z+z4FS9SmvxsEQScaB
   85+SAAwbyu3SEEJXA9/HEntXugNUosxBEJ2EDDHb/VIKMYAkjLTdOOyvZ
   GQ3i53NJnsns+M0XZmGveDyK8me1nM/9RYS0m+iI269S71KqgmVGvuSFL
   Sr8L0jVU+o6I7LcLRoi1iQ6acQG26Q1ma9t5NW+X7J9VhOb/j4gL4BV2R
   KWnVfFTQVxbtifPeMucTH+WVwV7E412ZlmPVX3iIUuBKxuvYRzupgl5Qq
   pxRl0bnuCGDI6N0XPWywqCGIUuCDBW7AouKbyF2p00S9etnwfJlZEav1S
   w==;
X-CSE-ConnectionGUID: AgQLnkJ2R+WwpYJApCLuiw==
X-CSE-MsgGUID: ECJPR5UwTS6OE+tnCxetkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91439176"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="91439176"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:28:39 -0700
X-CSE-ConnectionGUID: FrrgiAu2Ri62gIJolx8YbQ==
X-CSE-MsgGUID: rJVwAm93To6OeUUeu/n7Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="263729170"
Received: from tester.sh.intel.com ([10.112.106.126])
  by orviesa006.jf.intel.com with ESMTP; 19 Aug 2026 00:28:37 -0700
From: Tao Yu <tao1.yu@intel.com>
To: Ruben Wauters <rubenru09@aol.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tao Yu <tao1.yu@intel.com>,
	syzbot+9ae8e7884e451eaed5b4@syzkaller.appspotmail.com
Subject: [PATCH] drm/gud: validate TV mode names before creating enum property
Date: Wed, 19 Aug 2026 15:28:35 +0800
Message-Id: <20260819072835.4074130-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GUD protocol returns TV mode names as fixed-size
GUD_CONNECTOR_TV_MODE_NAME_LEN entries and requires each name to be
NUL-terminated.

gud_connector_add_tv_mode() currently passes each fixed-size entry
directly to drm_mode_create_tv_properties_legacy(), which eventually
reaches drm_property_add_enum() and strlen(). If a device returns an
entry without a terminating NUL byte, strlen() reads past the end of
the slot and can run beyond the allocated buffer, triggering an
out-of-bounds read.

Validate that each returned TV mode name contains a NUL terminator
within its fixed-size slot before passing it to the DRM property code.
If a malformed entry is found, reject the device response with -EIO.

This fixes the out-of-bounds read without changing the handling of
valid devices, and avoids silently truncating malformed protocol data.

Reported-by: syzbot+9ae8e7884e451eaed5b4@syzkaller.appspotmail.com
Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Signed-off-by: Tao Yu <tao1.yu@intel.com>
---
 drivers/gpu/drm/gud/gud_connector.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index ea0cca58b7c89..8141c3a1e30ad 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -396,8 +396,16 @@ static int gud_connector_add_tv_mode(struct gud_device *gdrm, struct drm_connect
 	}
 
 	num_modes = ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
-	for (i = 0; i < num_modes; i++)
-		modes[i] = &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
+	for (i = 0; i < num_modes; i++) {
+		char *mode = &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
+
+		if (!memchr(mode, '\0', GUD_CONNECTOR_TV_MODE_NAME_LEN)) {
+			ret = -EIO;
+			goto free;
+		}
+
+		modes[i] = mode;
+	}
 
 	ret = drm_mode_create_tv_properties_legacy(connector->dev, num_modes, modes);
 free:
-- 
2.34.1

