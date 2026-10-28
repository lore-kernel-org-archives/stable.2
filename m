Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171652;
	b=xTi4enqyap7zIaQQ8yo1tBkvJBSmVZQfWmgkApsOh9KM6KJuHJ+4jzSaP9oM3yNpMMiM
	 tkI6hkycKW7sXwkFvs6UR045+imJowUHs4skQl8w5iEGlBWhhBNmLNSHpBWrLWaDLWotS
	 wVBIRvaQJzAaZ4F1yzPws4/1p1+F6Jw25jGbDgweyLeyVBCfwH2dCDVrC6O3RLgsw1+7K
	 eYgIet/gspDHg/KXnrKumUXMoDLUpbovbwUPBBFYlrPQWoEImT5C8Pt7H0wSe8mzv9byU
	 16t2gZcqVwW5o2e3FaWdlDU+TvG71+6MTTBiVx9P0Jht1JE3TFy3uEdz0+6uZy3Hpaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171652;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+otLGh5Msr9ff8gbkfIkDa5lxzLEiBC72+uekZPlvgY=;
	b=aEHmOKhWSbrpbpV5R1q2gbMKKmkKf9i162vb3AVhhqlmiDakPHQuAnZrgB2c+FEcH+SR
	 SD5jP44TgTWj6+0nqEnTNGnR4advSZMo64FBvL3WzQYhkheNgmVv6YGu5oV+4kBJ5yge/
	 6QGBYDnabUgyQC0PG7hiXfBBTnPu3ZHMTeaWZoTsr/e3eJIUbPbkgnmygYxETkezSaIWL
	 B5BVE4+2lERQ/Q1OMyJhb+3M+CcvFADVhuuX0TQTbE6ggFLsEpA8PLq8QjEyyrg6ahr5c
	 +UWWhg1tpguEO+YAqLKCfkyZAhNV/6Bkv7Myy2v1m1sX4HW5JRE4LCCpj80pZ8B3UUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lT0Sh6uy;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA3606A32D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23DA3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lT0Sh6uy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793171652; x=1824707652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0ayTDFpAP9p+u4QrzO5EsrauV6pa4Teg3sVqMHtfxc=;
  b=lT0Sh6uyE/hyZCUNt8PElJnp4PZ+4yxnXDSJyBA3ih4vhlOt0Oee3RNM
   nF1g+bwgcxJFRR+GENvHAoCj25ra6xHLP2PNqvdasGB18j0MX1qeI7rF9
   48wHhSBCaKu6oQLOVwAbmnHg6yqV7sm01Zvk/djrj3TGpaBpOydzTL07s
   elBoO//V8jnqIshdiJmEMSBfa9bt3De4u88dM/j/FJxlUaDsumirr6qvS
   bwbCp8EVH1hVZuU/tgWL1qg8X8WDyoewEafi9mM55rSzJc8Mdwu1qyZn8
   oZtABQ6vHac9Qh0I1tigMm95aGvlMQ2KH96QjYc4uHe+uwrfu78HyXyLo
   w==;
X-CSE-ConnectionGUID: PhK/LW0HRMe21HwlFH3DyQ==
X-CSE-MsgGUID: 8ygdjrhaS6aAW5pj4LhFzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1765954"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1765954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:14:09 -0700
X-CSE-ConnectionGUID: W3co6ZnuQzGXFsZ5ubtYww==
X-CSE-MsgGUID: kTyT1cUlTM+mUgy1x0iyXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4868298"
Received: from vsrini4-xps-8920.iind.intel.com ([10.223.167.75])
  by fmviesa002.fm.intel.com with ESMTP; 28 Oct 2026 00:14:05 -0700
From: Vidya Srinivas <vidya.srinivas@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	uma.shankar@intel.com,
	jani.nikula@linux.intel.com,
	Vidya Srinivas <vidya.srinivas@intel.com>,
	Charlton Lin <charlton.lin@intel.com>
Subject: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on WCL
Date: Wed, 28 Oct 2026 12:34:03 +0530
Message-ID: <20261028070404.1913843-2-vidya.srinivas@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261028070404.1913843-1-vidya.srinivas@intel.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WCL has only one scaler per pipe. Set num_scalers to 1 for
WCL.

v2: Rebase onto latest upstream
v3: Fix up the commit message
v4: Split the scaler and joiner changes into separate patches (Jani)

Bspec: 74286
Cc: stable@vger.kernel.org
Suggested-by: Charlton Lin <charlton.lin@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index f17fc2c68472..c74256359c25 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -1813,7 +1813,10 @@ static void __intel_display_device_info_runtime_init(struct intel_display *displ
 	if (intel_display_wa(display, INTEL_DISPLAY_WA_14011765242))
 		for_each_pipe(display, pipe)
 			display_runtime->num_scalers[pipe] = 0;
-	else if (DISPLAY_VER(display) >= 11) {
+	else if (DISPLAY_VERx100(display) == 3002) {
+		for_each_pipe(display, pipe)
+			display_runtime->num_scalers[pipe] = 1;
+	} else if (DISPLAY_VER(display) >= 11) {
 		for_each_pipe(display, pipe)
 			display_runtime->num_scalers[pipe] = 2;
 	} else if (DISPLAY_VER(display) >= 9) {
-- 
2.45.2

