Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795065705;
	b=QqGztxLONRyWiMBerYPBrNXOBeqbYZHPknW4rhyaAVCC8l11esFx6qAKiv0O3WkuF/8r
	 8cXZaCdV3Me0z5xl7o2P09q9iZFxTTALtVFzPDoiLXn5OA4Y4SA/7ed5xh2zZEGo4X54t
	 SfSv7dTnx50ChEMs42wjFprHQV5bMTeVamFwHlaRCNfhhMtiInan0HO1QAplhy7ZwBhG/
	 n/p6H4zOxYsujsuXOAp4vPcoJqyy8NglmOityCazRcpjwzwge6IzaPnETIF0DsOh9Uyvb
	 OMg5ark5yNrXZnAekhBxY8ES1I3PLKwINpD8cMDKhkRrmuNe8f34F+Amegs2bMrg5wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065705;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=yg2ZZU1TweI3/AFMNObAOhY+yoOrP3DdVMXLguoJHt0=;
	b=XZcrvDSkLj+RR4r9CP+bZ9iyiPuj4q+gGR9bbisvNPa2bKj2BfIVkbIT+rZaAq1hzCVA
	 LfJlucjICY3aFpxFCFBpejbwZNRogV3A/GF8l8MDyM6FPFaw850YV1kkK50iN6qRBWJvs
	 +N62iNgUYsXnI+RO8rVKsHX1TGnANJGtYy0VuuZV4J5z9CH30w2fFWtfdNP16Lxf5uOn6
	 XPThqs0afgJJYMOf8aYwSzGxr6t78LyHF2mUicwwlXuPGkG5N7boFI1G68PiT/NXS+XFw
	 RiZyQuRTZtX3AsqcC7LfjTtmyNs89nv9GuvMB3qttIo7YHvlJJJ3Vy3QgqnPFsudRVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMfNNdX6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94029606A33D;
	Thu, 19 Nov 2026 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMfNNdX6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795065705;
	b=WKVKhi8WSMv1ZLe0HCfHm6sPo+n0ADr6JoIU8PL+TdFE+fASmdQWEw2PTD0j/Ri/9Ush
	 taHqxp2Sn6/eSPCgayRsF5HNU9Qhcr1qXCme4Dqmfe6UzJcBRHMxYUYNV6anodCVvdJb0
	 03wCwPR1wEQ0iisio5GQhXoDcNWf6QJMWB5XlYwJ6kI/zWFgjvQn3DsY4yAVzQl4RcuaU
	 1A13tIXbNMDEEYgn0ZOvh+fC39xXWNcakT8a9iZG6aHd1YZfVXzgKSBXLRz3heSGvGn06
	 P9zEKqm0SE7aqLzGfmzksI/Wd1OOGJNxO0MOfDo1r4VCzm7ds30YEmHNZke1V/GroaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795065705;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=yg2ZZU1TweI3/AFMNObAOhY+yoOrP3DdVMXLguoJHt0=;
	b=RicZKRYv/tt6IEO24LCnT3BSLi9/RNCWqRCbNt+VycSqZqSK+Cp/vgCUsNRSAMeV8XXJ
	 8n1SznieYq6969vvqBTMr4GUX5lmIYZ5CGu+CamNGf3PbO6omEA9/PH+pgtdtFRVjnOrB
	 zyf1CIMBhCZKLqYQGl0VHx2AfAPX4vv8OfMfTZE2Zdx5ydb0P+l6ez+1iDXxW572BxEis
	 CayT+o7naDvUW8Q/6tUVNiG0O0V5O5jLzP7cmxXIwxV8LWIcSIIXhvejjIOlEme4Sz/jB
	 dsfzJ4pW31Ni5HN1tYj5zbvVZeLLjJKlVg2iqGjSZ9rY/3kTcMDWFXn39r4p8F1cseg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D0C061F000C8;
	Thu, 19 Nov 2026 05:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065705;
	bh=yg2ZZU1TweI3/AFMNObAOhY+yoOrP3DdVMXLguoJHt0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=EMfNNdX6t80cbXvcp1C4xIFkYXvYXWnypAy30iZlVeeJeYZv/cRV/05ti6gYTsFiw
	 QY7chwvaOFTj2bvXxZBPMfUyAjOL8hiyOAg/eOlVqf/QIeqYUOiLgLM3HLbwn5AQNZ
	 7r2qsw/0TCeDtAcyov+Fvf6Av8iB2xb4YyyJIntViXrTfkN/Wu7gp1MyDcc76WmQ4P
	 0Yr4IT9SkpLL18ckQibzJeV51gutRZZQ9ZzWkcswkAaIwBFQQOGIcL3NSVWjY2Qr+G
	 WW/sRbdjzsmJnLk3ucKH//+4HCT2oS3kzhosUim7m2BoTus/TCkpcdlze2ihB6G3EC
	 buzHoNTHTv6+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2B2F74B0FA;
	Thu, 19 Nov 2026 05:21:43 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v4 0/8] drm/rockchip: vop2: RK3588 clocking, sync polarity
 and window fixes
Date: Thu, 19 Nov 2026 05:21:41 +0000
Message-Id: <20261119-vop2-fixes-v4-0-4b8f5e7148c9@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQ6CMBAF4KuQrq3ptPwUV97DuCjtIDVCCcVGQ
 7i7BTdgXL7M+95MxONg0ZNTMpEBg/XWdTGkh4ToRnU3pNbETDjjOQAwGlzPaW1f6Gmt0gxSXpS
 lBhJBP+B6iP3L9Zv9s7qjHpeFpdFYP7rhvX4LsPT+DgegjBohciyNKZkR51ur7OOoXUuW4cC3l
 O8oj1RykBp0LZWWv1RsqdhRESmTCkWBUlSZ3tJ5nj8H1MxvLAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795065702; l=2365;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=DKrZ8YElBahQy97+zTx5tNNcwtO0wt30KXIKbUCDTYw=;
 b=2jM2Zi1py2UsUHQUdVkIAlqdFMsTjXBj/1UjMtCrB5xm3N6FTGzjOaEBYzzuCTj850TNisq6f
 D2Zn5oaZT6jClH79GzpqahDXk6SQrQXl8M+bwfvnnnNYEpeaOlSQU/u
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
Changes in v4:
- Patches 1 and 2: Reviewed-by added (Damon Ding).
- Patch 4: the GRF sync polarity bits get names in rockchip_drm_vop2.h
  (Damon Ding); comment dropped.
- Patch 5: check moved after the 10bpc check, with a comment and a
  drm_dbg_kms() (Damon Ding); it tests drm_is_afbc() there, as it now
  runs before the linear return.
- Rebased on drm-misc-next.
- Link to v3: https://patch.msgid.link/20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com

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

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 27 +++++++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  3 +++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 16 ++++++++++++----
 3 files changed, 34 insertions(+), 12 deletions(-)
---
base-commit: fac7a5f16230779cfb0d50ca49e9467cc94a2ea9
change-id: 20261110-vop2-fixes-fa45142799c1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


