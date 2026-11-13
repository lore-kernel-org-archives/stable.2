Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557515;
	b=ONknR5jpG2bHyhLg+x7jNBo6uDs1qVBZJ1hStm74LPFvOnEyGGfe/NskkHlwjaXANecc
	 Y+IcwELEsHIDq3kfSiEGl/pGCzzzVDkV4uJmbYIKdLCvgxpm8X7b1I/ykymSiSJA1kRhL
	 /2KwkeJuFwjvXk71Vi9nvvLSdC7iVnUERBVFKphS5QpdPuYM7yDr4Q2Sl/TbxO8D/n8wg
	 o9o1hePeEmABhzFVfmjSR3mMbdC/CxBN4fhsEi3ZyBGTobRK6JFFp0E4f/ZUkPqeujPtH
	 7E7BxX9d2wgF6M65w5FfepxJbvXZUaMUIgUYIqW8oozZMoEKLScgNnfLum5ivBaR6pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557515;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H8uQ/Z1lGD3NX8NmS+AXDt4O4D/d8PZzuLMHcg+vTaQ=;
	b=sts8W01mMbRvzK/46PZdCWr9UIVltH7HIa88sJ0Z9871Okag1eN1cnjMzmoJT8ThH5G8
	 3mM9MMZIXhTAeEkRN/nH28so7sLLgIMZCXUZ/p8lUMbVQATO355cdEl/TO5GMObvhAquC
	 Nu7Hj/VxuptpHKfoICvRQfGpDXsbsppXrlhhN8f+DRnzHrTzQvgE4phnoQJpIbz2r0yAc
	 GSF5uYZX71ydZvfjUfkcTYaOdbOsR65egA/jF5wJu3kQbwrLhVVi/AR1I8IbIs8HquS4C
	 qUVlAXIhc5hvw4QGM3QLNSGSFdHjVWZGbdxscZulnbRG5TH3DekcYGD1lqfY5udEYcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=glHO74v5;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB83606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB83606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=glHO74v5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794557514; x=1826093514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3OdHyYwSg8n/0/KoXGdQFFLwl3dWu001MPbwazm2EFQ=;
  b=glHO74v51EXAyhi400uJlZg1gG1XIMFdc3SzDUbA6BNzgVlwPNVoYzZ6
   91ElAx/5llEBsghkVoo+ym5N+fcBzZZ40dcEq8H45YLrJuUpa3nT7Fk+D
   yR0RqSxTE1gGnRF3nPAG8T/KOigDLtZCqFOdYWW4Kl/iuxo3l7RkIhU0v
   3KkV2Mgogg3HK9R7ToROPI4A2swimhKIS+A2YXzBh9GiRngnokq26rB/Q
   OrtjIDZX4kvy2mX1biLkJszGUaA7cpAPt4gFgG8GEHsQXVdYsXrN0A2RB
   I6xrcxRy5G3N1p+sGmwC5jyzOvr7zYjHqmVMWjLBkLs1VZc5CqxFBxs+7
   g==;
X-CSE-ConnectionGUID: jPeCOv9DRTSWwh5fqncuRw==
X-CSE-MsgGUID: jn8d13PDSFC+48YQJj/QOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3225003"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3225003"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 00:11:54 -0800
X-CSE-ConnectionGUID: sh6jVZ1tTO+q7Lxa0lzaSQ==
X-CSE-MsgGUID: aw039dfFSBOEAhNdQF5P6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8762246"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by orviesa004.jf.intel.com with ESMTP; 13 Nov 2026 00:11:52 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Xiao Lu <xiaolu.xie@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH v2] drm/i915/dip: Write the DIP header last
Date: Fri, 13 Nov 2026 13:18:49 +0530
Message-ID: <20261113074849.30768-1-chaitanya.kumar.borah@intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On platforms with SDP transmission line registers, the packets anchored
to them are double buffered in the transcoder (TC) clock domain. The packet
registers are in the core display (CD) clock domain and the whole packet is
clock crossed on the write of the header (dword 0), so Bspec requires the
data to be programmed first and the header last.

hsw_write_infoframe() writes the header first, so the packet is crossed
before its payload is in place and the previous payload keeps being sent.
This hits the AS SDP, and the VSC SDP whenever an AS SDP is enabled, which
is whenever VRR is possible since commit 6a1712052859 ("drm/i915/dp: Enable
AS SDP whenever VRR is possible or PR !async"). With CMN_SDP_TL, enabled by
commit bfa597238073 ("drm/i915/dip: Enable Common SDP Transmission line"),
it also hits the GMP and VSC SDPs: on NVL, entering HDR on an eDP panel
leaves the image discoloured and scaled until the headers are rewritten.

Write the payload, including the ECC zero fill, first and the header last
for all packets. Packets double buffered in the CD domain have no ordering
requirement and Bspec recommends using the same order for all packets, so
use it on all platforms.

v2: Always write the header last, without the platform check. (Ville)

Bspec: 75640, 71197, 74384
Fixes: e1123e617e51 ("drm/i915/vrr: Program EMP_AS_SDP_TL for DP AS SDP")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17732
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9746
Cc: <stable@vger.kernel.org> # v6.17+
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Xiao Lu <xiaolu.xie@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---

Notes:
    The same ordering change was posted earlier by Xiao Lu
    (https://patchwork.freedesktop.org/patch/763779/), for xe issue 9693[1].
    
    Fixes tag rationale
    
    The Fixes tag points at commit e1123e617e51 ("drm/i915/vrr: Program
    EMP_AS_SDP_TL for DP AS SDP"). The AS SDP has been written header first
    since it was added by commit 8845021b7331 ("drm/i915/display: Read/Write
    Adaptive Sync SDP"), but EMP_AS_SDP_TL, which holds the double buffer
    point and the transmission line of the AS SDP on BMG and LNL+, was only
    programmed from that commit on. From then on the driver relies on that
    register to anchor the AS SDP, and the VSC SDP whenever an AS SDP is
    enabled, and the programming note of the register asks for the packet
    data first and the header last. The two later commits cited in the commit
    message only widened the exposure: the first enabled the AS SDP whenever
    VRR is possible and the second added CMN_SDP_TL for the GMP and VSC SDPs.
    
    Alternatives considered:
     - 6a1712052859 (v7.2): AS SDP on whenever VRR is possible. A PTL report
       [2] is fixed by reverting it. Narrower than the spec argument, as it
       only covers v7.2 and later.
     - bfa597238073 (7.4): CMN_SDP_TL. The NVL regression, verified on
       hardware, but covered by the older tag as every kernel with it also
       has e1123e617e51.
     - 8845021b7331 (v6.10): first header first AS SDP write, but
       EMP_AS_SDP_TL was not programmed until e1123e617e51, so exposure
       before it could not be shown.
    
    Not verified:
     - The failure was observed locally on NVL with CMN_SDP_TL (rewriting the
       GMP and VSC headers makes the panel recover). The AS SDP and the VSC
       SDP with an AS SDP on BMG, LNL and PTL follow from the Bspec
       requirement and were not reproduced here.
     - No reproduction on kernels older than v7.2.
     - The HDR test on NVL was done with v1, which only differs by the
       platform check; NVL takes the same path in both versions.
    
    [1] https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9693
    [2] https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9746

 drivers/gpu/drm/i915/display/intel_hdmi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 4ec0db8d93fb..66149aff7993 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -535,18 +535,27 @@ void hsw_write_infoframe(struct intel_encoder *encoder,
 	val &= ~hsw_infoframe_enable(type);
 	intel_de_write(display, ctl_reg, val);
 
-	for (i = 0; i < len; i += 4) {
+	/* Program the payload first, the header (dword 0) is written last. */
+	for (i = 4; i < len; i += 4)
 		intel_de_write(display,
 			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
-			       *data);
-		data++;
-	}
+			       data[i >> 2]);
 	/* Write every possible data byte to force correct ECC calculation. */
 	for (; i < data_size; i += 4)
 		intel_de_write(display,
 			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
 			       0);
 
+	/*
+	 * Packets double buffered in the transcoder clock domain are clock
+	 * crossed on the write of the header, so it has to come after the
+	 * payload. Packets double buffered in the core display clock domain
+	 * have no ordering requirement, so use the same order for all of them.
+	 */
+	intel_de_write(display,
+		       hsw_dip_data_reg(display, cpu_transcoder, type, 0),
+		       data[0]);
+
 	/* Wa_14013475917 */
 	if (!(IS_DISPLAY_VER(display, 13, 14) && crtc_state->has_psr &&
 	      !crtc_state->has_panel_replay && type == DP_SDP_VSC))
-- 
2.50.1

