Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472389;
	b=U5lcWiFUiEQM//fVbqCrchIaMqbqK3s3LkX/N43TSrqix+30lbCIVpSCiY0p5LaqsUO6
	 Qrl4YDEOC8mGpYl6we+hzYEY1SsT0lmOmAiJ6VUVj5fyjBnam+wVSgtJC8RHp6HnMvxsh
	 rkCTDEMCCpzO4KcK+/6FOVnJ7i3YrhapGuezGOt5KsLwY88LHsKMSUgbjakS+D893avlB
	 ee/DUOQ7ANrcRm396dM60QaWYp/2iV42PC8OFrLFqkk/auflWOfnrd6c2kd/Th2LUuwaw
	 LT+miUH1ghmMfTZGozj+oCv96XYFBHtayzjRgH8EuOG5TXZB3Xi71fwOSaSo4gr+x/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472389;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=VpQ/+iowHyrQjEkYL9X0OjJSOe5lvW4ubEUDr7PhZ0s=;
	b=m3vCo8G6WWAWC6xS3W1JIVlTgF65FqcOpir+7VdRWac6Aq5kY6jV1GnxNvU8XrWG4ppv
	 QRv4yRSAYfrfliNYVONevaLs0WQxRJxbBMonJborLvxu0yMuKnPp3cGQ7M+PcQokaYHO0
	 XT8xKfSJV7xgut3N1VqXcUYH8j/vBV9Flrt9o7OvfhKTUAYFWuXkEY8rlUlVILuQaWFyX
	 gfHJCOO+gvmWO12EzKwxKo4GOmU6eEcKp4D5E2smHx7OPetiDv7aNqDHQdgdyNP3AoOT/
	 f1+VgElv8QrXbWwtxH8cRt4KMrqb7ZKFV0J2kQdRH19CFhxDAD3QZaOU/tTuSZi1Jzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEa6SWT3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72370606C83B;
	Thu, 12 Nov 2026 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEa6SWT3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472389;
	b=WIC3dsBtyaclCZzocfN4W1AjgOTkgdYo2srfIUcg+ZsJ/95vavV4zEchllFl/Ic3G06B
	 kB+XjEXzNR4boHr0oDlAFerDrQNthFNcy/T3pgNgq5iUsWtwPbPm27KReUW7CxvUWpX/O
	 fdMimwaKwqvZqzx0jVpOiyKyTOQ1vXEhx2XM3ASx42cxK/d6Y9fZ9fV8fGi7RoLWn+m3V
	 KjcgipHVcmv5HdfZIUdSx9QBKZ60/jg/eoEiAD7Cr48XTMv0Ew9rSV/DBDXIM3LEB7d63
	 RwdGYYjGtxHKTHiKXY1xHtUSfBsgwgqqCzShRiyehWS3vBTiGazuKYclpTiz6socBuQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472389;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VpQ/+iowHyrQjEkYL9X0OjJSOe5lvW4ubEUDr7PhZ0s=;
	b=Sooh/lK6BBJQ/bn/hF9+ALmIxIXq8pNigcVf+yS6tOFn1fOWApDMW8RkHr0kd0ilvxhg
	 FL6lOIbQD/OByLQnho4WQahnjwEMu3LqJGYUCoHENAsLxovdlghsN79OF3JUpsVL0kjKk
	 sNnnF1biu7bmXudjGm9OeIMY8mOjC3D4+Ppl35XWdQsQY1VQA/YyghFnEUeEvjy6VjbPz
	 K27cW8I6M5+x1YjBFnOo4DIiu0pN2aWZoyYlM3InNHBOtvxM/EPU3ypDbY2LedcA50dLb
	 WuJeFs8l8ok5BMkski+KCunsOoYQSH29GxROnAyr7nc3XuiID//5ymyUzXxYMwJDU0g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BE5CC1F00A09;
	Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472389;
	bh=VpQ/+iowHyrQjEkYL9X0OjJSOe5lvW4ubEUDr7PhZ0s=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=dEa6SWT3OPZIp2VS8jdoI7aKgYQcl6rXstbL28lY2aAww7+bKfOFC/5rdZ9FU3c8o
	 FdIRRS252854E7Ep3D9gNydgv090u4m8MAN5QeNsHuBW2R5vxJALV2q6jhsJgdcWpg
	 CeSv+B7917r59cYkpNG8mLQPIycUBJBhnDFREeWmJCfs36l/jmQIHbByvneFuvA+iO
	 0iAeffNgrNdBNxQDJvvEfjZAf6pR/UF5BVtuorPounWnX6rVpk388siU5QWAHhHEja
	 M5bxQxgz5ghMJ8/gu5coAjt7TEeTHU5qOI5miMm77mhCbu4CBkCv0lSQ3HCnLWCXia
	 pyxhx2Jgv9rDg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 376BA49378;
	Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/9] drm/rockchip: vop2: RK3588 clocking, sync polarity,
 AXI port and window fixes
Date: Thu, 12 Nov 2026 08:33:04 +0000
Message-Id: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2Zpui5h68j8MB2wXWCOUtNhoC
 P9uwavHl3kzs0CkwBThUiwQKHFkP2ZQhwJs34wdCXaZQUlVIaIUyU9KtPymKNqmPGGpzsZYhFy
 YAu1B9m/1j+Pr/iA7bwub0XOcffjsbwk37+9wQiGF07oi45yRTl+7oeHn0foB6nVdv4x7vQG2A
 AAA
X-Change-ID: 20261110-vop2-fixes-fa45142799c1
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472385; l=8125;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=BjFRBbEQB8leGzKTbYhxTpTTCIReMNAR0rDWrzczLYI=;
 b=pVqilutBPBcBjnQREXu7s4yo8H2Fwtll/ftNxDI/v53Wkhd04vbCzyqcqoVLNnc1S/0VvvDFh
 lPUaRUejKYzCRllQ1XZmeB2axOHXlKb9BJCRU4pgem/IBgf39ZaqItp
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

This series collects fixes for the RK3588 VOP2 found while bringing up
HDMI and DisplayPort output on an Orange Pi 5 (RK3588S).

Patch 1 is new in v2 and fixes a bug that is as old as the driver:
the chroma plane of a multi-planar YUV framebuffer is fetched from the
GEM object of the luma plane, which is wrong when the planes are in
different objects (two handles in ADDFB2).

Patches 2 and 3 fix the RK3588 interface setup: rk3588_calc_cru_cfg()
leaves dividers it does not use uninitialised and the garbage ends up in
VP_CLK_CTRL, and rk3588_get_hdmi_pol() decodes the POLFLAG bits it is
handed as DRM mode flags, so the GRF sync polarity bits are wrong for
most modes.

Patch 4 stops the RK3588 Cluster windows from advertising AFBC with the
lossless colour transform (YTR) for RGB565/BGR565, which the decoder
cannot display (black picture plus POST_BUF_EMPTY).

Patches 5 and 6 deal with POST_BUF_EMPTY underflows. The VOP2 fetches
through two AXI read ports but the port of each window is fixed in the
window table, so the usual primary plane plus overlay configuration of
a video port puts both layers on one port while the other sits idle.
One port cannot sustain two full screen 4K@120Hz layers (measured: the
fetch rate collapses from ~6 GB/s to ~3 GB/s and about half of all
lines underflow). ACLK_VOP was 750 MHz in the 4K@120Hz measurements
(the HDMI FRL patches on the test kernel raise it from the default
500 MHz for these modes), and raising it to 850 MHz changes nothing,
while moving one of the two windows to the other port removes the
underflows. Patch 5 assigns the port of a window when it starts
fetching, balancing the estimated load, in the atomic check from the
whole new state; patch 6 limits the POST_BUF_EMPTY interrupt to once
per frame, since an underflowing port otherwise keeps the CPU in the
interrupt handler 50000 to 300000 times per second.

Patches 7 to 9 are smaller fixes: the start mixer search skipped
Esmart3 (for_each_set_bit() was given the highest window id as the bit
count), a gamma LUT update cleared the other fields of LUT_PORT_SEL
(the VP0/VP2 dclk source selection and the VP0/VP1 merge enable), and
the AFBC tile count and transform offset were wrong for a source that
starts inside a 16 pixel superblock.

Tested on an Orange Pi 5 (RK3588S) with an HDMI 2.1 TV and a
DisplayPort monitor, pictures judged with a camera. Patches 2 and 3:
VP0_CLK_CTRL reads back without the garbage dclk_out divider, the sync
polarities seen by the HDMI controller (VIDEO_INTERFACE_STATUS0) match
the mode flags for +/+ (1080p, 2160p) and -/- (720x480, 640x480) modes,
and the picture is correct over TMDS and FRL modes from 27 to
1188 MHz. Patch 4: RGB565 is offered on the Cluster windows only
without YTR, and those planes scan out correctly on three Cluster
windows. Patches 7 to 9 were found while driving Esmart3 and partial
AFBC overlays: an AFBC overlay placed at x=1001 shows correctly.
v1 of patches 5 and 6: 3840x2160@120 with a full screen overlay
(previously ~120000 POST_BUF_EMPTY per second and a scrambled picture)
and a dual-display session (HDMI 4K@60 plus DP 4K@30, two video players,
ten minutes) ran with zero underflows.
v2 of patches 1, 5 and 6 on the same board: an NV12 overlay with luma
and chroma in two GEM objects shows correctly; at 3840x2160@120 the
overlay is assigned the port the primary plane is not on, also when
another overlay is switched off in the same commit, with zero
POST_BUF_EMPTY; a window started on the DisplayPort video port avoids
the port of a window with the same read IDs that is switched off on
HDMI in the same commit; after a forced underflow and an HDMI off/on
cycle the video port raises no frame start interrupts while vblank
reporting is off.
The DRM KUnit tests pass (they don't cover this driver), and every patch
builds with W=1 on arm64.

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit messages, and I reviewed and tested
every change as described above.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v2:
- New patch 1: take the UV plane address from fb->obj[1] (pre-existing
  bug reported by the Sashiko review of v1 patch 4).
- Patch 5 (AXI ports), after the Sashiko review:
  - The ports are assigned in the CRTC atomic check from the whole new
    state and kept in a private object; the plane update only programs
    them. v1 chose the port in the plane update, in plane order, so a
    window saw the stale state of windows switched off later in the
    same commit (Sashiko: commit order skews vop2_win_get_axi_bus()).
  - The load counts all planes of the framebuffer, e.g. 12 bpp for NV12
    instead of 8 (Sashiko: UV plane AXI load omitted).
  - A switched off window keeps its read IDs in use until the frame
    start of its own video port, or until the commit that switched it
    off is done, instead of releasing them in atomic_disable (Sashiko:
    premature AXI bus release).
  - The windows that start fetching are assigned busiest first.
  - The plane update takes the port from the plane state (new struct
    vop2_plane_state), not from the private state: commits on
    different video ports aren't ordered against each other, so a
    later one may have freed the private state by then.
- Patch 6 (POST_BUF_EMPTY), after the v1 reviews:
  - Clear the stale FS status before enabling FS while vblank reporting
    is off, so it doesn't fire mid-frame (Sashiko).
  - Disable POST_BUF_EMPTY and a pending FS re-arm when the CRTC is
    switched off and on the atomic_enable error path (Sashiko).
  - enable_vblank() doesn't clear a pending FS while POST_BUF_EMPTY
    waits to be re-armed (Sashiko).
  - Fixes: tag added (Sashiko).
  - The comment above the FS enable says why it is there: masking
    POST_BUF_EMPTY does not touch FS, since VP_INT_EN is
    write-masked, but POST_BUF_EMPTY is unmasked again from the FS
    interrupt at the next frame start, so FS has to be on. It is
    only enabled here when vblank reporting has it off; v1 wrote it
    unconditionally and its comment hid the reason (Chaoyi Chen).
- Patches 7 and 8: Fixes: tags added (Sashiko).
- Patch 7: ROCKCHIP_VOP2_MAX_LAYER_ID added after the last window id and
  used as the bound of the search instead of ROCKCHIP_VOP2_ESMART3 + 1
  (Chaoyi Chen).
- Patch 8: Reviewed-by added (Chaoyi Chen).
- Cover letter: says what ACLK_VOP was during the measurements and that
  raising it doesn't help (Chaoyi Chen asked; the details are in the
  commit message of patch 5).
- Patch 9: the x offset in the superblock is taken modulo the
  superblock width, 32 with AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 (Sashiko),
  and a Fixes: tag added (Sashiko).
- Cc Piotr Zalewski (author of the commit patch 8 fixes).
- Link to v1: https://patch.msgid.link/20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com

---
Arun Iyengar (9):
      drm/rockchip: vop2: Take the UV plane address from the second GEM object
      drm/rockchip: vop2: Don't use uninitialised dividers on RK3588
      drm/rockchip: vop2: Fix the HDMI sync polarity on RK3588
      drm/rockchip: vop2: Don't accept AFBC YTR for RGB565 on RK3588
      drm/rockchip: vop2: Balance window fetches across both AXI ports on RK3588
      drm/rockchip: vop2: Report POST_BUF_EMPTY at most once per frame
      drm/rockchip: vop2: Find the first mixer of a video port with Esmart3 too
      drm/rockchip: vop2: Keep the other LUT_PORT_SEL fields on gamma LUT updates
      drm/rockchip: vop2: Fix the AFBC offsets of a source that starts inside a superblock

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 453 ++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  53 ++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c |  27 +-
 3 files changed, 512 insertions(+), 21 deletions(-)
---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261110-vop2-fixes-fa45142799c1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


