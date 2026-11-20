Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173933;
	b=VhO9fItvhZDf7Z5pDZZAVlho6APxZxo02ttFNQ7byX5ZAEtgO6261kc3WXQXpcHmOUX1
	 rdtxnfTriNGtjxfnoax3OB7sKiGOvAOoCI27oPQyWkcpnV0lkONg2OuPgoNyvaIpqCGkd
	 DwW3FmUSD3csBDaCfzppLFxJgBw8Et9kuJYmZyf4AJycvyutsmtUTSId33FaH/ASoeyke
	 p90Pdj19rWzVwmrYJvNwj4ypWJaoNMc1Y6BP/zc6+z9zM7AkjpNg8QMOvEJ07ShG0RaK0
	 15kRhGy1Bds2OKi04REwmLSgiB+I/bNbOgPea+YRPynA3Z6MsFm6ZBu+yL5NVpgaqhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173933;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:Organization:
	 Content-Transfer-Encoding;
	bh=QwtGDpV42mYs9qTBAWGpyw82EwVpQmmbUc1wwpeHeuU=;
	b=Lj4oZp4AnmtIyz9B1MhLt89HQ41r8EZosGyd4b0JuK5G1JI5VJswn8PN6aujwPPk5R0j
	 oEPe9Dp2rT+YL2YgpRBSidrqdxe8kWav3on/DJ40xAsE9Xp05Yw40QP+kKSuGs11HEgid
	 52vctQ3GedJnjaEDf59ZsA+3EhGmzZakT+/uwr05dLRRqYBj5df6QGNGXXlIruFW8DA9D
	 xdpU24FLraamXIEgAq0zD0NKfGfJQV7ZHJ5KZ42ZAfllg8JCg4E6nzbRyZElEtyfrD9dK
	 YYFDQE3rGnt+7G5PVQhCBXjYf/uTkRa6uf/lmgnTl6ME/8Vko+aJeoDe0OieHNPzmnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jN3My5gu;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC33606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC33606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jN3My5gu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795173933; x=1826709933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nJflTo/S163kjEMWLt1CJc89L3Gu4IKHol7tUJLyxWY=;
  b=jN3My5gugoMIr6qzxSxygOopxBu208lWDrLQ0XigGJ/KWv2tER6GboNq
   0i/GFfs3WTvPkeAq75Muzdx05SoYxzGkC6ba7G0l16P+J8O6nbCEY2ED6
   12UkDsKn2Ejt249qNNS2PFWHPR8ZyU1rOqqLgPnI+kWASfN3+nauLV+6w
   vneuxhFWSTx1/dkiLdXPtw/10SZRLubJXvIlOcELS1z62Js5bn1NKKeJR
   5WKRTwqLM4MGiDU4IKdSkDFYvw56iSiezt+SVZtvhQ3QY2PGGFDUEmr3b
   ZpYpnEhva6OIAsmirzfMuxIoBb2/HylVJne3sp36FaNMIEXfzLG6Du0sh
   Q==;
X-CSE-ConnectionGUID: EzGeGvKnTgW6cVQ56ajV1w==
X-CSE-MsgGUID: YhfWHaM8SYKxyrxaqCB8yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4042339"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4042339"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 03:25:32 -0800
X-CSE-ConnectionGUID: NoJNMK8cT563Ib3Lyd4wAw==
X-CSE-MsgGUID: yiF9uvDQToOC1XGNexgNJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="11012771"
Received: from lpankiew-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 03:25:30 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/alpm: Track the configured transcoder lifetime
Date: Fri, 20 Nov 2026 13:24:46 +0200
Message-ID: <20261120112446.1562267-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.53.0
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

ALPM disable can access a stale transcoder when ALPM was not configured
for the current modeset, causing unclaimed register accesses during
pipe teardown.

Record the transcoder only when programming ALPM and invalidate it
after disable. Check it under the ALPM lock to avoid register accesses
on repeated or unconfigured disables.

Fixes: 504766382edb ("drm/i915/lobf: Disintegrate alpm_disable from psr_disable")
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index f54b29e193ee9..105006ca6be7f 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -46,6 +46,7 @@ bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
 void intel_alpm_init(struct intel_dp *intel_dp)
 {
 	mutex_init(&intel_dp->alpm.lock);
+	intel_dp->alpm.transcoder = INVALID_TRANSCODER;
 }
 
 static int get_silence_period_symbols(const struct intel_crtc_state *crtc_state)
@@ -549,6 +550,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	alpm_ctl |= ALPM_CTL_ALPM_ENTRY_CHECK(crtc_state->alpm_state.check_entry_lines);
 
 	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
+	intel_dp->alpm.transcoder = cpu_transcoder;
 	mutex_unlock(&intel_dp->alpm.lock);
 }
 
@@ -556,7 +558,6 @@ void intel_alpm_configure(struct intel_dp *intel_dp,
 			  const struct intel_crtc_state *crtc_state)
 {
 	lnl_alpm_configure(intel_dp, crtc_state);
-	intel_dp->alpm.transcoder = crtc_state->cpu_transcoder;
 }
 
 void intel_alpm_port_configure(struct intel_dp *intel_dp,
@@ -733,17 +734,23 @@ void intel_alpm_lobf_debugfs_add(struct intel_connector *connector)
 void intel_alpm_disable(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
-	enum transcoder cpu_transcoder = intel_dp->alpm.transcoder;
+	enum transcoder cpu_transcoder;
 
 	if (DISPLAY_VER(display) < 20 || !intel_dp->alpm_dpcd)
 		return;
 
 	mutex_lock(&intel_dp->alpm.lock);
 
+	cpu_transcoder = intel_dp->alpm.transcoder;
+	if (cpu_transcoder == INVALID_TRANSCODER)
+		goto unlock;
+
 	intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
 		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE, 0);
+	intel_dp->alpm.transcoder = INVALID_TRANSCODER;
 
 	drm_dbg_kms(display->drm, "Disabling ALPM\n");
+unlock:
 	mutex_unlock(&intel_dp->alpm.lock);
 }
 
-- 
2.53.0

