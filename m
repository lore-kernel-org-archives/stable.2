Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069977;
	b=B134oif5nbZ9AhUaXw0GeGFPmNq+UdbJ3z13VkN8eotjUhYgkYhpqwxkjmSFzI7WAQdb
	 lxi03ybCiM5LEoZUkBEJ1RObz2iHKXusCv19HLOYG+QkyVLZTcrQtGamCePxdoRzR1FOr
	 vzYtHxNhYxz3PQyTrJTBEreOyF4waPpCe7CcaeuV8kH4mxlnLfv3KUH0EZdRthqRbl4gk
	 F4xbKuAHxqIk0ow0CS+7UFNXOUC1lAMShG8woPx8YYZ5OKpipaoutpPuMHId/mw7oQsmR
	 as+lH2LduGEYmoFWRZrlbmbQRmBh2ATyw0LcwbAoVubHXAq/94MwCutDLADsPjkCJwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069977;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9Xw4C9YzTPAgVaFuy+cQke/aA94FYtR9rQ/7mL/9V2U=;
	b=eM94GQ2y5m+UprJ4NgYsLmIuZWUBuW7hxSvH1Wza4N3AisUCK3Lmbx+YN6z1hl45eVfl
	 jsT5L6xaILwau7XAR8ymZwdHsyrkbkubkjEFubThcFkMCfTfWXkK60FdTylWxCBVBlnAT
	 mbMVaNCRvkJb3ST0yM5mFTc4rxM5m68RtlCg5phi05KjB2WR+UIkpfhyMCyxACyfPielW
	 JmDw6b2Z0NL9yvSzzKwON3q1snYHjP8ccmudHF67Nx02a7ci5PqpwFHZKugPU4LF14u/g
	 MwtF8ss5/teT7vJesHF08U0CUIU7I3l1S7ByF3R+RuGnnepkjNJta4piJHyStAfoBXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cLQCsutK;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F059606A325
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F059606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cLQCsutK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793069976; x=1824605976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wc/sJiss4XXnfSr8lhZWbdzeiQIHLn0r4nsyG5FYmPU=;
  b=cLQCsutKCRE6gBzCdKoIVsaOuQyQ9Mme5K3dTocykSt5DvdJFcdTmreQ
   05t72Kl5oRqOQsvzZNNBANPIypBA53zTZa1OOnKcJwYw9PfsTHY9vbcJ7
   4D4sxvrHLphJz/ruCGcNF48VJwDMhGkaQ8Oq3nuc7Rq+oDLo5rTSSXCEo
   oMKoltLF59vqVkV8TmhDFwgXwipUFGAx/LOLTsDEPHMOcccSpPWGT+SLQ
   i7FH7EeZZZJkZlKW7mQCMWGy2UMX3OAqAHLThchLjX45EXfCujWA+xVus
   nmMNq9pi75LdLCaee3tqWn7OYwYGarErCIGlxsBwcmu4F+ZkUzccb1MCI
   Q==;
X-CSE-ConnectionGUID: 4vFhANSdQiCKD7mhoq48QA==
X-CSE-MsgGUID: eIEvIJHPTsCD+gWtOliwPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1761311"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1761311"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 19:59:35 -0700
X-CSE-ConnectionGUID: ANN6JCqKRVahYn8RXDaO/A==
X-CSE-MsgGUID: 3HlD0sPcT8eoRuQHWmeUng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4823163"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 19:59:33 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	suraj.kandpal@intel.com,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dp: Add quirk to allow eDP joiner on ASUS ROG Strix SCAR 18
Date: Tue, 27 Oct 2026 08:13:34 +0530
Message-ID: <20261027024334.1140596-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
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

On Arrow Lake, VBT defaults the eDP pipe joiner enable bit to
disabled, and commit 650471948e49 ("drm/i915/dp: Avoid joiner for
eDP if not enabled in VBT") made the driver honor that default.

On the ASUS ROG Strix SCAR 18 (G835LXG), the bit in VBT is left to
the platform default instead of enabling it, even though the
3840x2400@240Hz panel requires the joiner to reach its native
mode. As a result the mode is pruned and the panel is limited to
120Hz.

Since the VBT bit cannot be relied upon globally for ARL (it is
needed to block the joiner on at least one other machine), add a
machine-specific quirk, to bypass the VBT restriction and allow the
joiner on this machine.

Fixes: 650471948e49 ("drm/i915/dp: Avoid joiner for eDP if not enabled in VBT")
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v7.1+
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16854
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c     |  3 ++-
 drivers/gpu/drm/i915/display/intel_quirks.c | 13 +++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 00e02e019d25..7b83cc83eede 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -476,7 +476,8 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
 		return false;
 
 	if (intel_dp_is_edp(intel_dp)) {
-		bool pipe_joiner_enable = connector->panel.vbt.edp.pipe_joiner_enable;
+		bool pipe_joiner_enable = connector->panel.vbt.edp.pipe_joiner_enable ||
+					  intel_has_quirk(display, QUIRK_ALLOW_EDP_JOINER);
 
 		if (connector->force_joined_pipes > 1)
 			pipe_joiner_enable = true;
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 7d7db774d8c7..ba7bce7f2827 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -100,6 +100,16 @@ static void quirk_disable_psr2(struct intel_display *display)
 	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
 }
 
+/*
+ * VBT on some machines defaults the eDP pipe joiner to disabled even though
+ * the panel requires it to achieve its native mode, so allow it regardless.
+ */
+static void quirk_allow_edp_joiner(struct intel_display *display)
+{
+	intel_set_quirk(display, QUIRK_ALLOW_EDP_JOINER);
+	drm_info(display->drm, "Applying allow eDP joiner quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -262,6 +272,9 @@ static struct intel_quirk intel_quirks[] = {
 
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
+
+	/* ASUS ROG Strix SCAR 18 G835LXG */
+	{ 0x7d67, 0x1043, 0x3b29, quirk_allow_edp_joiner },
 };
 
 static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 970a4fe52faf..84f31809011c 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -23,6 +23,7 @@ enum intel_quirk_id {
 	QUIRK_EDP_LIMIT_RATE_HBR2,
 	QUIRK_DISABLE_EDP_PANEL_REPLAY,
 	QUIRK_DISABLE_PSR2,
+	QUIRK_ALLOW_EDP_JOINER,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.50.1

