Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572811;
	b=Lf2gE2o6SpxeZOYyvSKdjjSEbaXJvfS9PnG8oleGHM21xTBbdQaTob97l6gXgLzVIBq5
	 lVtJS4tdYTY1QmBx2iyrn9kaAwDXHQrkINDacHco5W1+pJXEhlIHJ/lJe57ggp+pCmxGq
	 kaIEOf4H/UKPnKsNMrWD+lkMlbFkW0EM3CakBtnVATK51a/6/zIjhgHnvHneunW9iymjo
	 jEaHPN3rlRC5WUuZQneLHFOmImH2zR+9YPtF1VLewY3ZBl93AuKVdfGom6VKk63dg2ZYc
	 jyH223+j+LoWmVWttYsk0xSDyjkmCUHC4kp2/Hh4g8+dxVm6MGEI4HiIR8WqP545+Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572811;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eobFKjrLJjHUdQ8mUGpBnz0elePd02pD5nRTeCCKvgU=;
	b=cwwGUP2T4kjD4sNAdfJkvsmMwIqK26tZX3UrRfeY+JXzVr+YyLQ7d66o7pAijd9DfH55
	 O/hsFs241E4DnTB7Xjc6N6K69K05ANNfcAa3QRZ1UpbOGTPKzC+TJX5d3FLmcci/ZALtC
	 pzOs11WozV/QgElxXWSYKbLntWpRGUdZwKGWv7ivvjRQsPnKGqKivZCtKwfaCus+sKD7a
	 jjp65Kw1G5b6WCsdsyEEA0wvweoGvDhS0QXKhmcCs6cehCFCV68ms+3MRxnjtTxxF3Lou
	 y3RW8/he0H+nDsLvBn0PmcEPUBjXEXzN5NzIqCaixak5Abd1OyQdwLBwJ7Ryr9FLZpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eS+B0KgS;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A45606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A45606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eS+B0KgS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794572811; x=1826108811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5TPKGzUH3cTpq0dBCUcvvSRfCucQQqopiBs1cAvyfs=;
  b=eS+B0KgSAsRVh9wYhESILXHmLathSrCEj9XQQ+ym69vQ6UZfcTCxT+xA
   Et+lSpPRxV84plwvAddhh6+bwGHrFGbW7SuvEzjK5TL0GMPsTcdIwak7o
   8WXHEmhNSQ3XQobY5uLPVO0lHmLChf37oyhzH8cbkBkHHS/HD3O1Re/Z+
   4jZ+fQjdk+uq1JaDjWLKYDtCRqfebtAzPVWxNa0dYyJ/yNcgU4Fo65qIG
   x3O3q1usAuDRXrwSzLJ+m5qPQFGeHLGP4dJfTX6dUnmXuAWF+n2yC7h55
   MiQWlkbLUoTkEzF91/Iccxv9coP20WqN7dfDibMldxUScg+n8C2blCRvz
   A==;
X-CSE-ConnectionGUID: ZL/6gEibTQOrLCqXXi21og==
X-CSE-MsgGUID: vuvFnv/hSsGAZmKNWRBCNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3242550"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3242550"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:26:51 -0800
X-CSE-ConnectionGUID: ps6VLt46SFeDH1SNEqf4zA==
X-CSE-MsgGUID: KwlBM1DlQl6+pnibIp3bKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9243326"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:26:48 -0800
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	suraj.kandpal@intel.com,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/bios: Add quirk to allow eDP joiner on ASUS ROG Strix SCAR 18
Date: Fri, 13 Nov 2026 17:41:06 +0530
Message-ID: <20261113121106.3241899-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261027024334.1140596-1-ankit.k.nautiyal@intel.com>
References: <20261027024334.1140596-1-ankit.k.nautiyal@intel.com>
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

v2: set panel->vbt.edp.pipe_joiner_enable directly in intel_bios.c
(Jani)

Fixes: 650471948e49 ("drm/i915/dp: Avoid joiner for eDP if not enabled in VBT")
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v7.1+
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16854
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c   |  5 +++++
 drivers/gpu/drm/i915/display/intel_quirks.c | 13 +++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 7b6a6f8c3cf1..b77d1599482a 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -41,6 +41,7 @@
 #include "intel_display_types.h"
 #include "intel_display_utils.h"
 #include "intel_gmbus.h"
+#include "intel_quirks.h"
 #include "intel_rom.h"
 #include "intel_vdsc.h"
 
@@ -1575,6 +1576,10 @@ parse_edp(struct intel_display *display,
 	if (display->vbt.version >= 261)
 		panel->vbt.edp.pipe_joiner_enable =
 			panel_bool(edp->pipe_joiner_enable, panel_type);
+
+	/* Some machines need the joiner regardless of what VBT says */
+	if (intel_has_quirk(display, QUIRK_ALLOW_EDP_JOINER))
+		panel->vbt.edp.pipe_joiner_enable = true;
 }
 
 static void
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 96eb9a40df9b..613a847184db 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -108,6 +108,16 @@ static void quirk_enable_dpcd_backlight(struct intel_dp *intel_dp)
 	drm_info(display->drm, "Applying Enable DPCD Backlight quirk\n");
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
@@ -270,6 +280,9 @@ static struct intel_quirk intel_quirks[] = {
 
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
+
+	/* ASUS ROG Strix SCAR 18 G835LXG */
+	{ 0x7d67, 0x1043, 0x3b29, quirk_allow_edp_joiner },
 };
 
 static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 4996419ae76b..c64d0fc39905 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -24,6 +24,7 @@ enum intel_quirk_id {
 	QUIRK_DISABLE_EDP_PANEL_REPLAY,
 	QUIRK_DISABLE_PSR2,
 	QUIRK_ENABLE_DPCD_BACKLIGHT,
+	QUIRK_ALLOW_EDP_JOINER,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.50.1

