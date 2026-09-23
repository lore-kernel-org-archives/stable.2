Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A44499BC
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164628; cv=none; b=uxjb7gMYlajxYt4g0bNJm4aDOE2y3cnDI9pZMAN9hV3G6GRZNl6h+Wq95l7zGGiCsWAEOsb7xEmBEzj4FdEZavXGmUBjGkZgHpzq0aSUHJmQhJGxB3/TAbEKtfFE8HvD4H2v8Zrxv/W+cYynMrdl9sWbXSKOS13Rt5tWLxQ8GPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164628; c=relaxed/simple;
	bh=6FrYDa6J32wsgDlPS6ylEJxtDXrpniTgOn5DI/OgdDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmmCweJDg5mOonDhlFzlOtPguaojpRZGZnzJkV3z9NsIARu2wBE4IJWNxd4dhhPoZ/SiIOTWEPqTDu0KOHVCKSUl1n/2tYUHJ1h/7EdqQAyoUWlOh8uS3cIAtSpH3YlOsu1QjRGuFYk0f2N1Nb1DsKZ6gVu+L37T3Z21jN6E2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GtbBBWx8; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GtbBBWx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ri
	8FyuOCQtYkwZzSZfiHKNrXOAfY81g/ycbm8C3SdHw=; b=GtbBBWx8o3bPyAJuvu
	mZ5CAfp92OTbH0OiXcS8saYWkl9/TxX7eVhvvhP7MlGjO/faZ2acic7M0pyfapc2
	B2P9ZOXJsDO3iHShLjk0XkKn6MiUjPoQPR3ifh38jke1LDDBsahgRoQoX2XTMU9d
	bAVVA5lD/FcdY/07NHjY25IV8=
Received: from fedora (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3X_VzvrNqsRlYAQ--.35554S2;
	Wed, 23 Sep 2026 19:56:36 +0800 (CST)
From: Xizhe Tang <xizheTang2005@163.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Xizhe Tang <xizheTang2005@163.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/dp: Only send AS SDP when VRR/CMRR is enabled or PR !async
Date: Thu, 24 Sep 2026 03:51:59 +0800
Message-ID: <20260923195200.21362-1-xizheTang2005@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X_VzvrNqsRlYAQ--.35554S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4xAw4kAFy5ur45AF1DJrb_yoWrJF18pw
	47WryFyr4fXFyIqFWxXFn2vFy5WwsrJ34rGF98G3y8Z3Wqk343trZavayj9a4Dur4xXF1F
	yrZ5JFWqka10vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKLvuiUUUUU=
X-CM-SenderInfo: x0l2xvpwdqwjqqqvqiywtou0bp/xtbC6hRUq2qzvnR+ggAA3u

A Panther Lake eDP panel that advertises VRR in EDID but runs at a fixed
refresh rate has received an Adaptive-Sync SDP since commit 6a1712052859
("drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async").
On this panel the first modeset at boot is vertically streaked.

intel_vrr_possible() is only crtc_state->vrr.flipline != 0. Fixed-refresh
timings program flipline too:

	intel_vrr_compute_fixed_rr_timings():
		/* For fixed rr,  vmin = vmax = flipline */
		crtc_state->vrr.flipline = crtc_state->vrr.vmin;

intel_vrr_compute_config() takes that path when VRR is not actually
enabled (uapi.vrr_enabled is false, or vmin == vmax). Then
intel_dp_needs_as_sdp() is true with `vrr: no, fixed rr: yes`, and
intel_dp_compute_as_sdp() programs DP_AS_SDP_AVT_FIXED_VTOTAL.

Gate the terminal condition on the states that consume the SDP:
crtc_state->vrr.enable (VRR) or crtc_state->cmrr.enable (CMRR / FAVT).
Leave the Panel Replay aux-less-ALPM early-return from the same commit
unchanged.

CMRR is still hard-disabled (is_cmrr_frac_required() has "|| true"), so
cmrr.enable stays false today and the OR is a no-op versus v1 at fixed
refresh. intel_vrr_compute_cmrr_timings() sets cmrr.enable without
vrr.enable; the OR keeps the FAVT branch reachable when CMRR is re-enabled.

This is a no-op while VRR is actually active. It does not fix Adaptive
Sync = Always corruption, nor the non-atomic SDP update named by the
#FIXME above intel_dp_compute_as_sdp(). Trailer is Link:, not Closes:.

Tested on LENOVO 21VG (PTL eDP, 8086:b080), v7.2.6-200.fc44.x86_64,
rebuilding only xe.ko with this hunk:

  Adaptive Sync = Never (Tested-by): vrr: no, fixed rr: yes,
  infoframes enabled: 0x6 (no BIT(3)), zero Adaptive-Sync SDP, panel
  clean. This boot: six s2idle suspend/resume cycles, all clean.

  Adaptive Sync = Always (not Tested-by): vrr: yes, vmin 2016 / vmax 8064,
  infoframes enabled: 0xe, Adaptive-Sync SDP still sent. Panel
  appearance on Always is not claimed.

  CMRR / FAVT: not tested.

On the same panel, Adaptive Sync = Never, first modeset, drm.debug=0xe:

  7.1.13 (clean):     infoframes enabled: 0x4  (VSC only)
  7.2.4  (streaked):  infoframes enabled: 0xc  (VSC + AS SDP,
                      operation mode 1 = DP_AS_SDP_AVT_FIXED_VTOTAL)

  Later dumps of those boots are 0x6 vs 0xe; each non-zero bad mask is
  good | BIT(3).

Changes in v2:
- OR crtc_state->cmrr.enable so CMRR still gets AS SDP (v1 review).
  At fixed refresh v2 matches v1.
  v1: https://lore.kernel.org/r/20260923052937.22817-1-xizheTang2005@163.com

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252
Fixes: 6a1712052859 ("drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async")
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Xizhe Tang <xizheTang2005@163.com>
Tested-by: Xizhe Tang <xizheTang2005@163.com> # v7.2.6, PTL eDP, Adaptive Sync=Never
---
 drivers/gpu/drm/i915/display/intel_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3115,8 +3115,9 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 	if (intel_psr_needs_alpm_aux_less(intel_dp, crtc_state) &&
 	    !intel_psr_pr_async_video_timing_supported(intel_dp))
 		return true;
 
-	return intel_vrr_possible(crtc_state);
+	return crtc_state->vrr.enable ||
+	       crtc_state->cmrr.enable;
 }
 
 static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
--
2.47.0

