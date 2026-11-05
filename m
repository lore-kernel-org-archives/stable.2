Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882864;
	b=N0JAFg8no8GyETl3Q0S/srTSIk4TY7zKHfCnN0pPngjJRew1N6E5HQR1DRSlHME98DSa
	 FsXH3OrjlHmpBuL2aO+I6XN1A5lWcsYD2cIJmhs999xBlV011uKSCQ1uBBXMl9IZcODtt
	 PdqKPK6oNf9FnjsRwbBwKrpiwSfHu95xsgFPxAu9hAEtrFBTzaUtgYKx04U8Omjz6KNAN
	 MWtnkWPyq9YyY56KvoAWkwejZfLQkOB9nqWhY87i5vyKD6SsQSI7aCuXi4m7hLNArLpsr
	 Ywxppdk3YvybxaUzuLeR/D01a8xvupMRupOFaF9Ij1ZuxWCxCBZ30SUt1tnB3/c2Zvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882864;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:Organization:
	 Content-Transfer-Encoding;
	bh=+CdIoUC6SO9infTBGNxfj2iPfMXtBw1qIQTeTVf1PyE=;
	b=VNa8AuZQp1AwNlGjpavRrdM/DwJjVKnH5d0i+bV7dPJJl5HbW42ox3c42hPkj9WKP7f6
	 7n832RWV4OkebXNcOfVXhopTvqzb5XndKXrJp1YaVhA46WRcBiZ3jHzBZ5m3X1S4a+Uui
	 tEt3BsdQfrFFUCfzlMhDXXkMRX54RgphdVwNByx6pqKbJudpS0eqNWMKdLH2ibcb5kykm
	 zNgtgFjtgPMbN+Br1DiupvxgZh6Fb94J/49qOo203ijsAiPgrHEkWO+/lcFx3950VRwpL
	 ksp8r7g5qbL2REH7GudgiQVbsiZTM7p8Xv0KCpvSE/1fIg7dIhoxtgOKiz3kGXFsaQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbYeOOSN;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FD606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbYeOOSN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793882862; x=1825418862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pYe+wLI5gTUZba/OWS1Wy2JNJrM2m6qK+Vsq6PudyqI=;
  b=AbYeOOSNE8nOcaPhHv+BzI6MjPcHUSl3AqY2DDpVTGn34c5MEzl8SLp2
   RCble5kBz1YhtmumXLUUriOkyyfGYire7p+zhPbL5P/Wg1jvnA3uz+SuI
   aaoTSgMXBqptffQxcy55PxsRLTAM/mNVK4zK0GQwJs0BFVEpa0naS9k8N
   P2RriaET0bSN/NaQjLSnKhu4il8NHbU55T02ZedsONZzB1PuN3m04tkGt
   Wc9d+rWr/iCKFoGYe4GRB/bynZrm2ZdlnjyqjyWC1KY/5CcfZXvgXMfAi
   nuN5wBkUXNb+l4OvWz5BQuHhLvM+3SWDjqkhBSi4eccibeZOePpELXO16
   A==;
X-CSE-ConnectionGUID: eYp3PL0MQZSYtXpLWl0n9w==
X-CSE-MsgGUID: BgpFQER5QEmhBp/yGPCqFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2688346"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2688346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:47:42 -0800
X-CSE-ConnectionGUID: ScNAL6dcR1WSeMVjAkR+bQ==
X-CSE-MsgGUID: WanBHScDT6q6UxjkjwnofQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6991678"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:47:41 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/cdclk: Ignore SWF18 in SKL CDCLK sanitization
Date: Thu,  5 Nov 2026 14:47:37 +0200
Message-ID: <20261105124737.24456-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Currently on SKL/derivatives we are checking whether
the VBIOS/GOP programmed the SWF18 scratch register
appropriately. Based on the original commit, and the
set of bits checked, the code actually wanted to check
SWF06 instead. Looks like it's just completely confused
whether the register offset should be 0x6*4 vs. 0x18 vs.
0x18*4. SWF06 is where the VBIOS/GOP should stuff some
information about what outputs it enabled. SWF18 is
where the VBIOS/GOP is supposed to stuff the maximum
CDCLK frequency.

I suppose either of these scratch registers are part
of the expected protocol between the VBIOS/GOP and
driver, but it looks like at least some coreboot
based systems don't set them up.

SWF18 not being populated leads us to reprogram the
CDCLK PLL during driver initialization, while the
display pipes are still potentially active. We also
set CDCLK to its minimum frequency, under the
assumption that nothing actually needs a higher
CDCLK frequency when it hasn't even been correctly
initialized.

Due to some other changes in the code we may no longer
force a full CDCLK recalculation and reprogramming upon
the first atomic commit, so CDCLK can remain at a
potentially too low a frequency indefinitely.

To fix this let's just stop looking at SWF18 completely.
The code is anyway confused about which register
it's actually looking at, and we don't look at that
register on any other platform either. We also do an
actual readout of the CDCLK state from the hardware
so we should be able to spot if anything is wrong
enough to need reprogramming.

Cc: stable@vger.kernel.org
Fixes: ba91b9eecb47 ("drm/i915/cdclk: Decouple cdclk from state->modeset")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16595
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17423
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 92e6fca861f6..0f2f693c78d4 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -1269,18 +1269,7 @@ static void skl_set_cdclk(struct intel_display *display,
 
 static void skl_sanitize_cdclk(struct intel_display *display)
 {
-	u32 cdctl, expected, swf18;
-
-	/*
-	 * check if the pre-os initialized the display
-	 * There is SWF18 scratchpad register defined which is set by the
-	 * pre-os which can be used by the OS drivers to check the status
-	 */
-	swf18 = intel_de_read(display, SWF_ILK(0x18));
-	if ((swf18 & 0x00FFFFFF) == 0) {
-		drm_dbg_kms(display->drm, "Sanitizing CDCLK due to SWF18 0x%x\n", swf18);
-		goto sanitize;
-	}
+	u32 cdctl, expected;
 
 	intel_update_cdclk(display);
 	intel_cdclk_dump_config(display, &display->cdclk.hw, "Current CDCLK");
-- 
2.56.0

