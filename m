Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB934A49A4
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963915; cv=none; b=DRL7eFCG28BYOY4Rjcco7TTr3giuuzTsr5dyR1w/tW5azO0biCqNpSo8C3/mx9BxZu0svck89BtcIAIybZ5SLfVPMFXKO6UwI/lTRXmz0FhgVhQFRZQO35yS0KaCnWBNv9d117fj98bym1lK0helQ1VGIBu6et92Xp51XwuKQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963915; c=relaxed/simple;
	bh=lN4gt994dMU+9pXGu4BdLiI3WSHh2QDc0hxsmnEGd9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i9eXvAH5uxT1t1x6kXoOADXql4Rx4iZvJSZR0DC9196+Fkk8cZzzuUFy3vi5JgZ8RcHIn5hRvdzSy7kgtbUThNOnuSXaD8J4+mujyjpLOJDR+p+CGa0p/yi5UGcP3mQcjmdBer3Rh5V1jXFxSMCYJ4EdmEpHkNZl98/fOEpcLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=i4lb6jw+; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="i4lb6jw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1791963895; x=1792223095;
	bh=5Df0dMO9HwYZXFBrE5nGiFbcDfJGyHNy9fLyUNmHBDE=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=i4lb6jw+xl5hsuEIxwyhJY7v8RNkvuca1IKt8FXE8L0xvQZYgQM9mFT/x3WkV29gf
	 GnZJykUXzd0lLNMmmlDifJuAGJytveslKP0mmBrjq/H1V9P7E5xEo/fDDExgGD8lnK
	 0ii+0bniVzVAc5WMZFDUPNodyjYTHuM90GFCtOnAirEmadcHkQ93CcqLAcQKJdwOW2
	 6iR+zWZ06tQ/YyVzUynFrSb233jjomX82jd3XMnkq7dLmMT/oERn+tdjl6wxmTcmsz
	 6o/fAxPIATmlW4uwq07ipfWvxLMaOfnnBCIQHbgD2NgU0lKYGt2lsZBal6n5Y/LlBd
	 5FuMYiw5b0avw==
X-Pm-Submission-Id: 4j4NX320gdz1DDL8
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH RESEND v4 0/4] drm/bridge: nwl-dsi: Various fixes
Date: Wed, 14 Oct 2026 09:44:41 +0200
Message-Id: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791963890; l=2905;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=lN4gt994dMU+9pXGu4BdLiI3WSHh2QDc0hxsmnEGd9U=;
 b=lPf5SeirCM3z/ZBkaASTw2xHweaRzRcEz/jX2WzUEdSNNpB/4ZMQKeyNG9ec22ura2Jn6xwze
 A0pF7sG382qA6GGAXcnaf/pTiDd7z4EWgeVN1xqFKRo0qePNfy0QU44
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This series brings a few patches fixing horizontal sync timing, EOTP packet
behavior and hsync/vsync polarity selection when using DCSS endpoint, as
well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.

The 3rd commit ("Correct auto-insert EOTP behavior") is taken directly from
NXP vendor tree, so I have kept Author unchanged, although I have modified
the commit message. Let me know if I should change Author for that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v4:
- Change calculation of hfp/hbp/hsa to use the raw clock rates directly to
  eliminate intermediate rounding errors.
- Drop patch 4 (will be included in follow-up patch series, together with
  a patch addressing the unblanced resource teardown and PM runtime
  underflow problems in the error path).
- Link to v3: https://patch.msgid.link/20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com

Changes in v3:
- Added Fixes and Cc: stable tags.
- Split patch 1 into two, with change of endpoint mux control in a separate
  patch.
- Fixed mux_control_try_select() state argument.
- Link to v2: https://patch.msgid.link/20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com

Changes in v2:
- Added safeguard against small horizontal sync timings, protecting against
  division by zero and integer underflow.
- Added error handling of nwl_dsi_mode_set() call.
- Link to v1: https://patch.msgid.link/20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Guido Günther <agx@sigxcpu.org>
To: Fabio Estevam <festevam@gmail.com>
To: Robert Chiras <robert.chiras@nxp.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (3):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing

Robert Chiras (1):
      drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior

 drivers/gpu/drm/bridge/nwl-dsi.c | 87 ++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260710-nwl-dsi-fixes-c148b0adb685

Best regards,
--
Esben Haabendal <esben@geanix.com>
-- 
Esben Haabendal <esben@geanix.com>

