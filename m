Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842547252F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195923; cv=none; b=m5i1yDUNxZTNOuCs5fdkjS1jqEkV2NwHt2PvGH1yg3JA/UXDQfomSJbQIWViU4FqgJQZVkopen92wzoqlbAEcGaZKUlNHunClA4TifvxSyz3sxmlHKWVoyw5CN7huNLTfLaTkJCATBBPKGS5BnXAp80LOik+oRICAIxYAAob4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195923; c=relaxed/simple;
	bh=Y6AHpCH+T8evjj3Ed3/jDSteDn+/5njUVIFmbjusn4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+s0rMqzoS1I5SLf8JkZjuv/5LHbhLMAk5awQ+nYJpdHDdAabiQarssIW+jhwuc8CjIXKTTpAwb2h/NOhaP60rZWmvCovv8lD5Q7obLumrayswJth0YWo6pbn4t7cGeAP7Liu/G4owDiqkSgK/dKjc2hj05/KtG0zl2vqa630pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ajOnJFa3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ajOnJFa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7z
	kyvSIZb7yzsrgnBf3y3sUB/QOaKW72wUX6zt/1eFM=; b=ajOnJFa3ozvKO9D3HO
	zKJYE7Ps5dVqZyG4cJ596ymb8NSbeIYWSlv/NY7NQmRYMugdxKnoGrpq8l6imBrd
	lEwOVSUTDZ9CEglOcbFSXN4NsIsuTZROHFzX7g2MeeK4gJFy3tmswdx9O/u4gZTq
	urJrnoB/o1keszUXsFdJ9LRY4=
Received: from 163.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBnX6_tesNql_rOCg--.32055S2;
	Mon, 05 Oct 2026 18:24:45 +0800 (CST)
From: Xizhe Tang <xizheTang2005@163.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	ankit.k.nautiyal@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3 0/3] drm/i915: stop sending a fake Adaptive-Sync SDP
Date: Mon,  5 Oct 2026 18:24:42 +0800
Message-ID: <20261005102445.12710-1-xizheTang2005@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923195200.21362-1-xizheTang2005@163.com>
References: <20260923195200.21362-1-xizheTang2005@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBnX6_tesNql_rOCg--.32055S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kCw4UCF1xGr4rtw48tFb_yoW5uF4xpa
	1xuF1rKw48JFyIqrWxu3WIyFy5Jws3J3yrG3sxK3sFvas8Ar9rJr4Svw4jgayDuFs2g3WY
	qrn3XFyjkw4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY-e5UUUUU=
X-CM-SenderInfo: x0l2xvpwdqwjqqqvqiywtou0bp/xtbC6g9lvGrDeu8JMgAA37

v2 gated intel_dp_needs_as_sdp() on vrr.enable || cmrr.enable. Ville
pointed out that this function is also how we size the optimized VRR
guardband, and that looking at vrr.enable there forces a full modeset
when userspace toggles Adaptive Sync.

That coupling is the bug, not the send predicate. Split it:

  1/3  intel_dp_sdp_min_guardband(..., true) reserves AS SDP lines on
       HAS_AS_SDP platforms even when the packet is not enabled. After
       this, toggling vrr.enable does not change crtc_vblank_start.

  2/3  Send the packet only when VRR or CMRR is actually running.
       Predicate is vrr.enable || vrr.cmrr.enable to match drm-tip's
       nested cmrr (v2 used the older sibling cmrr.enable). Now safe
       because 1/3 already reserved the guardband. This is the 7.2
       regression: intel_vrr_possible() is flipline != 0, and fixed-RR
       timings program flipline, so we transmit DP_AS_SDP_AVT_FIXED_VTOTAL
       on a constant refresh. Panel Replay aux-less without async video
       timing still takes the early return in intel_dp_needs_as_sdp()
       from 6a1712052859 and still gets that packet; this machine does
       not hit that path. A 7.2 stable backport needs the sibling
       crtc_state->cmrr.enable spelling.

  3/3  On this panel, Adaptive Sync = Always still streaks on s2idle
       resume after 1+2 (operation mode 0, not the mode-1 packet). Write
       the SDP in intel_ddi_enable() after intel_vrr_transcoder_enable()
       and before intel_enable_transcoder(). Fastset still updates the
       packet from intel_ddi_update_pipe_dp() so a runtime Adaptive Sync
       toggle does not become a full modeset.

1+2 are the regression fix. 3/3 is the Always resume path on this eDP;
drop it if you want only the Never/Automatic half.

Why not vrr.in_range (series 174831 1/3): this panel's EDID range is
30-120 Hz. 60 Hz and 120 Hz with Adaptive Sync = Never stay in_range,
so that patch still sends AVT_FIXED_VTOTAL here. Reported at
https://lore.kernel.org/r/RxSA9gIRRBSaKwxlF7t96Q@163.com

Not Closes: #9252. 1+2 do not fix Always. 3/3 does.

These patches are against drm-tip, not 7.2.8.

Machine: Lenovo ThinkBook 14 G8+ IPH (21VG), PTL 8086:b080, eDP
3072x1920, EDID 30-120 Hz. Tested by rebuilding xe.ko on
7.2.8-200.fc44.x86_64, and on a full drm-tip kernel. Same results
on both:

  Never / Automatic, boot and lid s2idle: clean with 1+2 (and with 1+2+3).
  Always, lid s2idle: still streaks with 1+2; clean with 1+2+3.
  Runtime Never <-> Always on an already-lit panel: already clean.

Ville in_range, delayed send, and never-send were tried earlier; the
first two still streak, never-send is clean on both policies but is
not upstreamable.

v1: https://lore.kernel.org/r/20260923052937.22817-1-xizheTang2005@163.com
v2: https://lore.kernel.org/r/20260923195200.21362-1-xizheTang2005@163.com

Xizhe Tang (3):
  drm/i915/dp: Reserve AS SDP guardband even when VRR is off
  drm/i915/dp: Send AS SDP only when VRR or CMRR is enabled
  drm/i915/ddi: Program AS SDP before enabling the transcoder

 drivers/gpu/drm/i915/display/intel_ddi.c |  4 ++++
 drivers/gpu/drm/i915/display/intel_dp.c  | 35 ++++++++++++++++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp.h  |  2 ++
 3 files changed, 37 insertions(+), 4 deletions(-)

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252

