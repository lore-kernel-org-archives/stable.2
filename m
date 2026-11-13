Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587960;
	b=Nqnjm/rsrjImG/8wzMLc3Ffo/6PTGA4hMQgUfeipSmEIj47Z1ghk3i4WpReC/31Q+5Fl
	 mPXYLputGhsmopMVEaszXZVnHXIc8dJWqXw4O2M8MupYEuQb/jKicPKwgKCLFUGGGAZK7
	 e1tWHANT0n/PdM4mMg77NyPETQA0f9yaOfmG+K3Og16RsFH6weRSEuNt3ANhtO0i14wJO
	 ZVHdYxLK7CMtiyuIgcx5rQlAj/DyrFbj4q/4oCBePkksml+7ft5MbvOdcsx+VgC6RM2+o
	 BVdaFR52IhEYhTBka4VnBDkqaQTAen4IqV9CpovIAyYh/jSYIdEcQMpB35jYOtlwWkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587960;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=U75O8gWuTG1QeQDNqwe0KX2VA83vVIIIPoEht8yTRkU=;
	b=E4jomVXJvxeLMi1nEAfCT9jvDx0dFXlq3iQ0k2aPEsZqz31Sgv6IvNBALiIIKGBCfXHE
	 8kU9fWxPvsX5kCNOfR7NHyA7zobGzLWGkrpAxsHlqxm+lIqVZcufmVc0iLqgntEWwgedz
	 VsNSUoZrMRyXs5HrHosj7nZiEe5EP317F7w9Gf+VhnCV8ibtCuWc0LifZDlPuyc9XQb7D
	 DyfkWKt7ZPZT6nQTuv2zSzU16nTHY8LDfoYGIpIhxUk3QDprRAh46cRUP73rv8Cgm3Gzi
	 X7rI+f0zS6CZJrPT93BC1VzOHcE9e8gWa/TICqmUSZG+2zooYssB5osMzt7V39oruPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLymZuZn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C986606A8B3;
	Fri, 13 Nov 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLymZuZn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587959;
	b=RLUBCOCIaCY0a1tuScko8IWkJokvr9FsUW91s8ozZF9mu5kj+s/rDUZrXtL4i3sUe475
	 T/Gn3FkO0h8kYLsJ6pZfLr1uANSOvT/FE606snSsax/5XeBDC1htKjl94/nEGT2sVaiJX
	 g/03AhNdjhYXrwDnoiqtXdbqUeb+8aykPpmow9G4af21pjeggdiXJCt1ft14CeD6a81fC
	 sf8WHBuK4PUZJnhIFnYXcKj2ynM63gPnSnxJyCQUp6vsebmCxGlZnsd06Y+VHxQxD1MF9
	 6GJRI/u1OaBTbBriw5KN43j180E6Ecq7gQhwY5TqdmVjKSA+tSZzc1OMVIKMoCTrqXg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587959;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=U75O8gWuTG1QeQDNqwe0KX2VA83vVIIIPoEht8yTRkU=;
	b=ziktod1gHuT0AH2XWg/HSkUSPwo8orognGsEKhEAyKsVRYkoUkBNBYjg6lpFkkkThhGk
	 c+/e/CNpJ2hJovGvK1V+LRROdi6DlVh6HCtzc/7/Cdebyh4bAWaGILl37s4dQbmYwgLBd
	 PZO2KCjjxzO9V1u7Hkxh4bJAWEBKoQQsZ9fRGgR5T7BTSjock1RjsQ7RjCUWyp5Jyj1Yu
	 B/CSTBA2YQ2iK0GPBJFah9stx/xfdWqfn0dEYyVAZHdC/Ww6UlUhhLTsEL5B4HAO2sXDP
	 8w6euHdFz7BdG0CvPVs3joKw+DI3NKc94yiPrDm6tmwPpk0rmyRLNTKqa60/Jy8czqg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CD6BA1F000C6;
	Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587959;
	bh=U75O8gWuTG1QeQDNqwe0KX2VA83vVIIIPoEht8yTRkU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=RLymZuZn6+CSb2txSuRtbd6bxIHyRFMH3fjgqFbdFWgKnddPwa1BhxFXh4xAETj6v
	 NjOiqaxXyJU8Ru1qTfxEIuuAw+gYoqIIL9CeTNHwMELQLp9RPQRrHd6EwNXdvrnMtB
	 wrSzi3X9DjDGIhsDzJUbAAosGZGglA1BQhCsAWeKHURGREpDKCWMKLXDqv+Ck11Px4
	 iyVIVJXhHAgUd5hbnKxqeBeGX24EqBH5WpGmzPHrZYS3YMHPWjegbu36kIynbz1b3n
	 IotfxNIOdEMtITtpPNKbw+1JIHVrkm6/PD0JhMs/5RR62DX7uoHY3NFeihXZZExqXI
	 E8ZiGVJVFatJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5CA4B49996;
	Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v3 0/8] drm/rockchip: vop2: RK3588 clocking, sync polarity
 and window fixes
Date: Fri, 13 Nov 2026 16:39:17 +0000
Message-Id: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBBFr9KwFsMMtVJX3sO4QKAtxpYGKtE0v
 btQNzVx+TLv/ZlJMN6aQE7FTLyJNlg3JOC7gqhODq2hVicmyLACAEajG5E29mUCbWR5gBKPda2
 ApGD0Zj0k/3L9cnje7kZNeSEbnQ2T8+/1W4Ts/R2OQBnVnFem1rpmmp/bXtrHXrme5OGI2xR/U
 kypQBAKVCOkEtt0WZYPBeXZ8PEAAAA=
X-Change-ID: 20261110-vop2-fixes-fa45142799c1
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Damon Ding <damon.ding@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587957; l=3685;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=3nX1ah8wCORjYYGpxUjgpxkB0S7zXmDkM8EtPt38fzU=;
 b=m5r2YCVxxS4oJSbZYrG5XEnLM48AgEiNksBbi8xzuW3wzVaIs4VxPUbmnt5HcGayVBETAu6Ks
 yf54lD6cAVwBfwO+erZUx9v6EDG1P9lSiCD7hKTyd0rNeh47xH/6inh
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Fixes for the RK3588 VOP2 found while bringing up HDMI and DisplayPort
on an Orange Pi 5 (RK3588S).

Tested on an Orange Pi 5 with an HDMI 2.1 TV and a DisplayPort monitor,
pictures judged with a camera, v7.3 based kernel: VP_CLK_CTRL reads back
without the garbage divider; the HDMI controller sees the sync polarities
of +/+ and mixed modes; HDMI from 148.5 to 1188 MHz (TMDS and FRL) and DP
show a correct picture; RGB565 on the Cluster windows scans out without
YTR; NV12 in two GEM objects and an AFBC overlay at x=1001 show correctly.
Not tested: -HSync/-VSync modes (none in the TV's list), BGR565, HDMI1,
eDP, MIPI DSI and DPI (no hardware).

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v3:
- Dropped v2 patch 5, which balanced the windows of a video port across
  both AXI ports: the TRM doesn't allow one port's layers on AXI0 and
  AXI1 (Chaoyi Chen). He pointed to the VP merge series for that case [1].
- Patch 1: dropped the comment (Chaoyi Chen).
- Patch 2: no common initialisation; every interface sets the dividers
  it doesn't use to 1, and an unused dclk_out is no longer kept at the
  dclk_core rate (Damon Ding).
- Patch 3: commit message corrected (Damon Ding); Reviewed-by added
  (Chaoyi Chen, Damon Ding); Cc Cristian Ciocaltea.
- New patch 4: the HDMI vsync and hsync polarity bits were swapped.
- Patch 5: YTR is only accepted for the 8 bit RGB formats, as the TRM
  says (Chaoyi Chen); comment dropped; new subject.
- Dropped v2 patch 6, which reported POST_BUF_EMPTY at most once per
  frame: it hides an underflow instead of fixing its cause (Damon Ding).
- Patch 6: Reviewed-by added (Chaoyi Chen, Damon Ding).
- Patch 7: Reviewed-by added (Damon Ding).
- Shorter commit messages and comments, no code change otherwise.
- [1] https://lore.kernel.org/all/20261029081429.862-1-kernel@airkyi.com/
- Link to v2: https://patch.msgid.link/20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com

Changes in v2:
- New patch 1: UV plane address from fb->obj[1] (Sashiko).
- Mixer search: bounded by the new ROCKCHIP_VOP2_MAX_LAYER_ID (Chaoyi
  Chen); Fixes: tag (Sashiko).
- LUT_PORT_SEL: Fixes: tag (Sashiko), Reviewed-by (Chaoyi Chen).
- AFBC offsets: x offset modulo the superblock width, 32 with
  AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 (Sashiko); Fixes: tag (Sashiko).
- Cc Piotr Zalewski (author of the commit the LUT_PORT_SEL patch fixes).
- Link to v1: https://patch.msgid.link/20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com

---
Arun Iyengar (8):
      drm/rockchip: vop2: Take the UV plane address from the second GEM object
      drm/rockchip: vop2: Don't use uninitialised dividers on RK3588
      drm/rockchip: vop2: Fix the HDMI sync polarity on RK3588
      drm/rockchip: vop2: Fix the HDMI sync polarity bit order on RK3588
      drm/rockchip: vop2: Only accept AFBC YTR for 8 bit RGB on RK3588
      drm/rockchip: vop2: Find the first mixer of a video port with Esmart3 too
      drm/rockchip: vop2: Keep the other LUT_PORT_SEL fields on gamma LUT updates
      drm/rockchip: vop2: Fix the AFBC offsets of a source that starts inside a superblock

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 23 +++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 17 +++++++++++++----
 3 files changed, 29 insertions(+), 12 deletions(-)
---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261110-vop2-fixes-fa45142799c1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


