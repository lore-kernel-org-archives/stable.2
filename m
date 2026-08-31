Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7B3F1ADA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182887; cv=none; b=TJ2HFVE48HG6VyNFNQ/b3ZrX0rew5mj/9bnCWAw5rdQ5lPYTxNBj56VnwcNkE+zcsC/T4Zk4ZkX/UwlBVNXrU1acQm3ljlXt2Bjdt7jWGu4v+M7TS/TarxHxqBZCFVQdoZpcsLR2a5dj17+CVj7nIyncy1KbPibggbRQT5kOk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182887; c=relaxed/simple;
	bh=/bLvlYLVzYKa8dr8mwlM3algYzuLPgYV2ydoxEptCkg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pb23AK6oy0QpjFQyWDro4cy8bECDm656ZiaLpI/BveSpSsW/PvwzeMViAb/tKwwG9Ot3Vj8sV9h6j4nQAKJIE+sHa0IzvdTeIiz38+UxWL9G1VRdn2rQxtPB0hNTGQlDcikj9C2p/MfJP2ByVX/vgbYiyhMbNwBEbPDTJ0KBiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fnVMgMaK; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fnVMgMaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788182880; x=1788442080;
	bh=m3XXQ4PRUOBQ1QkgQNZUZzV0arhK7ELWxV2Q/hoH5jg=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fnVMgMaKKw0QIlHGu+8gNdEuC5SE2HnEZX85CzzKdr/p5KPFh3Mtue2F63kV6wEWh
	 wvpn8FSV0y3oV1Mmn0pi06bWIdDCKHChKRxG0uS8niz2gdq5AvU4N2PfrN+pAtQ6iF
	 p5ZeDKjmN23cG4u38wEvvIPZp7ofa7ZLFj8VTVidASaRtc20WK4Zo5eQHpuJShczg7
	 qCwho7bgSn8qA612IM1ty7njp2aVaGhG47A4d1WmQXcn6CL77z3Sqj1XN8V/nnayc/
	 L96Jw99p5ON0tBHoTCnsiUVIbPBKOrdItMji4t+3KEyVaOyl7dBnmWimpyM00qaZNR
	 Hr5FeUmJqFKHg==
X-Pm-Submission-Id: 4hYVDB3fC5z2Schm
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v4 0/4] drm/bridge: nwl-dsi: Various fixes
Date: Mon, 31 Aug 2026 15:27:42 +0200
Message-Id: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzRKCIBQF4FdxWEcDqIiteo+mBcJVaQobMbJxf
 PfAFv04Lc/c8507IQe9AYd2yYR68MaZzoaQbRKkWmkbwEaHjBhhnBSUYHs/Y+0Mrs0IDiuaiYp
 IXXGRo2CuPSyHQA7HV3a36gRqiCOx0Ro3dP1jeehp7P3b9hQTXLJCl1RIwaXeNyCtGbequ6A47
 tmbC5L+chY4FaSURKosT+sVTz/4+nsaOMu5lqXmBQP6xed5fgIev5cJOwEAAA==
X-Change-ID: 20260710-nwl-dsi-fixes-c148b0adb685
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
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788182874; l=2866;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=/bLvlYLVzYKa8dr8mwlM3algYzuLPgYV2ydoxEptCkg=;
 b=FFTQkGGFUYAoRidnkDgVA7gUqZ7Hp2uc6so4Wj9R5GUhcoTkrHOwEZtKgc6e3P/jPrFxoVqnj
 j8p4mwbGDEfBcq8MOs5cuHzz9TdL24OiwZ/KEwEKYDpGaft1mApWOzU
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

