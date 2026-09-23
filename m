Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF523D2A1
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141539; cv=none; b=fe3GZRky98D8/cNh07K93u/uEHbzo2S39Vim80xyTD1tG9eRbP/64m6oSLbSfp08zPgG9KZgPz2AWvVhkADiLechIk6fs1wGj5NeTIQdXzwh3yiTRiwwSbQEksgQnK8tN5Ty9M8RvCbt5coHb0hKeB1eWDXT7eY5rpbjmoHvL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141539; c=relaxed/simple;
	bh=Wv0FTiPDcw3imEIdooueZaRzNs4mcYgib+BrYaCt5mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZv2kAQKzcW7OM03s4fB0PzAKWwLfBrd2QLVF+SD9u6IVv7JLDluMnoAV6MhuhjTZhFI90FJ1f/zoiaE0V254B/ndSSD9amCgllB7Wfdps8CaIVDWQgPG70tvQIOwE8HACqFTjmdZ4ycmY69H/OmO10HB475uIyfV+ySPnnJ588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kOBmIAdi; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kOBmIAdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6z
	WbfjpldiZxBL0YQHqBVtVULlH+Wk1oV9YZGupl4Us=; b=kOBmIAdiRmfP6VO/yO
	g1NftJZlHX4h0XnjqT+YHcwwJz6g1FXBydKdMXWBCXiTwOszP/WMXY0JV8ND/hyj
	MrjHqKy3F4xD8qHoieR5mGoudY623tcSnzHFkNeHxD6RFjGN+WisrdA1rVFpNM8o
	BB5r9DzOzj/g+hP2rpFic156I=
Received: from fedora (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXn7xHZLNqxW8YAQ--.56158S2;
	Wed, 23 Sep 2026 13:31:52 +0800 (CST)
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
Subject: [PATCH] drm/i915/dp: Only send AS SDP when VRR is enabled or PR !async
Date: Wed, 23 Sep 2026 13:29:37 +0800
Message-ID: <20260923052937.22817-1-xizheTang2005@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn7xHZLNqxW8YAQ--.56158S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3tr1rGF18ZFWDKFyfuryDZFb_yoWkKw13pF
	WxWasYyr4kJFyS9397ZF4IvFyrurs3J3y5GFn5K3y3Z3Z8Aw1ftrWfKFyj9FW7Crs3X3W0
	vrZ0gr90kw4DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRVOJUUUUUU=
X-CM-SenderInfo: x0l2xvpwdqwjqqqvqiywtou0bp/xtbCwgiyCmqzZEgWuwAA3q

Panther Lake eDP panels that advertise VRR in their EDID but run at a fixed
refresh rate start receiving an Adaptive-Sync SDP since commit 6a1712052859
("drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async"), and at
least one such panel renders a vertically streaked image from the very first
modeset at boot.

intel_vrr_possible() only tests crtc_state->vrr.flipline, and flipline is
programmed for fixed refresh rate too:

	intel_vrr_compute_fixed_rr_timings():
		/* For fixed rr,  vmin = vmax = flipline */
		crtc_state->vrr.flipline = crtc_state->vrr.vmin;

That fallback is unconditional, which is the part that worries me:
intel_vrr_compute_config() calls intel_vrr_compute_fixed_rr_timings() for every
non-interlaced mode as soon as uapi.vrr_enabled is false, and on display version
>= 30 intel_vrr_always_use_vrr_tg() is true, so crtc_state->vrr.flipline ends up
non-zero for every pipe on every PTL machine, whether or not the sink can do VRR
at all. intel_vrr_possible() is thus neither a capability check nor a "does this
link need the SDP" check; in practice it degenerates into a platform check.

So on a fixed-rr link that merely *could* do VRR, intel_dp_needs_as_sdp() now
returns true, and intel_dp_compute_as_sdp() takes the "else" branch and programs
the SDP in DP_AS_SDP_AVT_FIXED_VTOTAL mode (`operation mode: 1` in the state
dump) while the link is not running variable refresh at all. The state dump says
`vrr: no, fixed rr: yes` on both kernels and `crtc_state->vrr.enable` is false on
both, so the AS SDP is being sent on a link that cannot use what it carries.

On this machine that leaves no upside to weigh against the corruption: the
compositor runs this panel at a fixed refresh rate, and no refresh-rate option
I can select in Plasma 6.7.5 makes the AS SDP useful here. The panel renders it
as a corrupted image instead.

Restore vrr.enable as the terminal condition, but keep the Panel Replay part of
the commit: the aux-less-ALPM branch added by the same commit is the one that
genuinely needs an AS SDP on a non-VRR link, so it is left untouched.

Note that the VRR half of the commit's rationale - "if a feature enabling AS SDP
gets turned on later (after modeset), the guardband might not be sufficient and
may need to increase, triggering a full modeset" - does not seem to require this:
toggling VRR from userspace already forces a full modeset through

	intel_vrr_check_modeset():
		if (new_crtc_state->uapi.vrr_enabled != old_crtc_state->uapi.vrr_enabled)
			new_crtc_state->uapi.mode_changed = true;

so intel_dp_compute_as_sdp() will run again at that point either way. If the
intent was instead to avoid that modeset for the optimized guardband, would it
make sense to gate on the state that actually needs it (PSR / panel replay /
LOBF) rather than on "VRR possible", which is true for every fixed-refresh eDP
panel with a VRR-capable EDID?

Note the scope of this change, because it is narrower than it may look: on a
fixed refresh rate it restores the gate, but while VRR is actually active it is
a no-op. intel_vrr_possible() is only `crtc_state->vrr.flipline != 0`, and
flipline is assigned by all three timing branches - intel_vrr_compute_vrr_timings()
and intel_vrr_compute_cmrr_timings() set it to vmin,
intel_vrr_compute_fixed_rr_timings() to crtc_vtotal - so with Adaptive Sync =
"Always" the first branch runs and crtc_state->vrr.enable is already true.
Swapping the predicate therefore cannot change anything on that path, and that is
exactly the setting under which this machine corrupts.
The other case this hunk cannot fix is the non-atomic update window in
the #FIXME.

I measured the control on this machine: with Adaptive Sync = "Always" on 7.1.13,
VRR is genuinely active (`vrr: yes, fixed rr: no, vmin: 2016, vmax: 8064`), the
mask is `0xe`, the AS SDP is transmitted, and the panel is clean. On 7.2.x that same
setting corrupts - though not on every attempt: it has produced clean, self-healing and
permanently streaked wakes here, in no fixed order.

On that path the two kernels should put the same bytes on the wire: both set
HB2 = 0x02 (7.1 hardcodes it, 7.2 has `as_sdp->revision = 0x2`), both set
db[0] = DYNAMIC_VTOTAL, and 7.2's extra db[7..8] carry `coasting_vtotal`, which
is 0 here because this sink does not advertise PR async video timing (the dump
says `coasting vtotal: 0`, and panel replay is disabled on every modeset). The
state dumps do not agree textually - 7.1's printer says "AS_SDP, revision 0" and
7.2's says "Adaptive-Sync, revision 2" - but that is the printer plus a struct
field 7.1 never assigns, not a difference in the packet.

So this looks like a second regression outside the payload, and it behaves like an
ordering problem rather than a wrong value: on this machine the same kernel and the
same Adaptive Sync setting have produced a corrupted wake and a clean wake whose DRM
core state, read back from debugfs, is identical line for line. The 7.2 code itself
names the candidate - the new cdclk->tc clock crossing, which the #FIXME above
intel_dp_compute_as_sdp() says can transiently send a corrupted packet because the
update is not atomic.

This patch does not fix that and does not claim to. What it does is take the AS SDP
away from the fixed-refresh link, and with it the one thing a non-atomic update can
corrupt there. The update stays non-atomic, and on a link that genuinely runs VRR -
where crtc_state->vrr.enable is already true, so the predicate is untouched - this
hunk changes nothing at all. That configuration is the linked report's open
question, not something this patch settles.

I have since built and tested this hunk. On v7.2.6-200.fc44.x86_64 I rebuilt
only xe.ko from the 7.2.6 tree with this single-line change, signed it, and
loaded it in place of the distribution module. The kernel, firmware, compositor
and panel are identical to the failing case - the module is the only variable -
so this is a same-kernel A/B rather than a kernel-version comparison. With the
stock module the first modeset at boot streaks the panel; with this hunk the first
modeset is clean. Six further suspend/resume cycles on the same kernel, under the same
test, did not reproduce it either. The loaded module is identified by build-id rather
than assumed, because vermagic matches for any build of the same kernel.

Mechanically confirmed on the same machine: with this hunk
intel_dp_needs_as_sdp() is false at a fixed refresh rate, so
intel_dp_compute_as_sdp() returns before
infoframes.enable |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC), and the
AS SDP disappears from the state dump.

Scope, stated plainly because the hunk is deliberately narrow: while VRR is
actually active crtc_state->vrr.enable is already true, so this change is a
no-op on that path. It removes the fixed-refresh trigger only. I have not yet
re-tested the Always case under this hunk, and since the hunk cannot affect it I
would rather leave that to its own bisect than fold it in here. The non-atomic
window in the #FIXME above intel_dp_compute_as_sdp() is likewise untouched; the
AS SDP payload and revision are identical between the good 7.1.13 and the bad
7.2.x here, so whatever else is wrong on that path is not the predicate.

Regression evidence (identical hardware, identical firmware, identical
compositor - only the kernel differs):

  hardware
    LENOVO 21VG, BIOS SWCN20WW 2026-04-01
    00:02.0 Intel Panther Lake [Arc B390] 8086:b080 rev 04, subsystem 17aa:8099
    integrated display version 30.00 stepping B0, driver: xe 1.1.0 (in-tree)
    DMC i915/xe3lpd_dmc.bin v2.36, GuC 70.72.1 (identical on both kernels)
    treated as VRR-capable by the driver: the EDID range-limits descriptor says
    30..120 Hz, and the log prints "VRR capable: yes" for eDP-1. That is what
    makes the terminal condition below true.
    Fedora 44, Plasma 6.7.5 / kwin 6.7.5 (Wayland). The comparison below uses
    Adaptive Sync = "Never", which is why `drm.debug=0xe` prints `vrr: no, fixed
    rr: yes` for every modeset of those two boots. The third capture is 7.1.13
    with Adaptive Sync = "Always", where the link really is variable: `vrr: yes,
    fixed rr: no, vmin: 2016, vmax: 8064`.

  7.1.13 (clean) vs 7.2.4 (streaked), full drm.debug=0xe state dump, first
  modeset at [3.62] / [3.71] respectively. The only difference in the entire
  dump is the infoframe enable mask:

    good:  audio: 0, infoframes: 0, infoframes enabled: 0x4   (VSC only)
    bad:   audio: 0, infoframes: 0, infoframes enabled: 0xc   (VSC + AS SDP)


  and the corresponding programmed SDP (bad kernel only, present in all five of
  its modesets; zero occurrences on the good kernel at this setting):

    bad:   DP SDP: Adaptive-Sync, revision 2, length 9
             vtotal: 2016
             target rr: 0
             duration increase ms: 0
             duration decrease ms: 0
             operation mode: 1        (= DP_AS_SDP_AVT_FIXED_VTOTAL)
             target rr divider: 1.000
             coasting vtotal: 0

  The mask difference is one single bit in every state dump of both boots, not
  just the first modeset:

    good:  infoframes enabled: 0x0 (1x), 0x4 (1x), 0x6 (4x)
    bad:   infoframes enabled: 0x0 (1x), 0xc (1x), 0xe (4x)
    -> bad == good | 0x8 in every non-zero case, and 0x8 = BIT(3) =
       DP_SDP_ADAPTIVE_SYNC

  Nothing else in the state dump differs where the link is concerned: linetime 67
  (60 Hz) / linetime 34 (120 Hz), ips linetime 0, joiner no, splitter disabled,
  fec disabled, enhanced framing enabled, sdp split disabled, DSC off (the log
  says "DP link limits: pixel clock 390950 kHz DSC off" and "DSC-support: no";
  "has_dsc: yes" is only a capability line), dp m_n (lanes 4; data_m 7117029,
  data_n 8388608, link_m 474468, link_n 524288, tu 64, identical on both
  kernels), port clock 432000, pipe src 3072x1920+0+0, pixel rate 390950,
  framestart delay 1, MSA timing delay 0, set context latency 0, vtotal 2016,
  vsync start 90, vsync end 84. vmin 2016, vmax 2016, flipline 2016 and
  guardband 91 are identical in the 60 Hz modeset of both kernels, so none of
  the VRR timing fields can account for the difference either.

  The two captured boots contain no error at all: no FIFO underrun, no
  pipe/atomic update *ERROR*, no PSR or DSB timeouts. Across the 64 boots
  retained in the journal there is exactly one FIFO underrun (a late one in a
  single 7.2.5 boot) and no DSB/PSR-idle errors. The pixels arrive intact and the
  image is readable, which is consistent with line timing being disturbed rather
  than the scanout source being wrong.

  Things already ruled out on this machine:
    - xe.enable_psr=0, xe.enable_psr=1, xe.enable_psr2_sel_fetch=0, xe.enable_dc=0,
      xe.enable_panel_replay=0 all still corrupt (one boot each)
    - no out-of-tree/akmod/dkms driver involved, firmware identical
    - not the #9097/#9012 signature (those run 2-3 FIFO underruns per boot)
    - still present in v7.2.5, v7.2.6 and current mainline: both
      intel_dp_needs_as_sdp() and intel_vrr_possible() are unchanged, so stable
      point releases are not expected to fix this on their own.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252
Fixes: 6a1712052859 ("drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async")
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Xizhe Tang <xizheTang2005@163.com>
Tested-by: Xizhe Tang <xizheTang2005@163.com> # v7.2.6, PTL eDP, fixed refresh rate
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3115,8 +3115,8 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 	if (intel_psr_needs_alpm_aux_less(intel_dp, crtc_state) &&
 	    !intel_psr_pr_async_video_timing_supported(intel_dp))
 		return true;
 
-	return intel_vrr_possible(crtc_state);
+	return crtc_state->vrr.enable;
 }
 
 static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
--
2.47.0

