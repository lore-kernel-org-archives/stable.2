Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097246;
	b=H+veLqz7laW9OIhm65iyW075Ym2L46Ev98fQ0mtTEOsz+6631xDFVcdOAyKjVfSpdBD2
	 K10nTChT79HtT97+JhGUdLrRwhjaAgu2Ky9q0xxTBOaJLi0TTjMxh2s7n3o6wzEs5kvu1
	 iDzg//NjQXzvOUEeSDcR3ISzSkdSEViI++ghpAaehjJEF1WSL7UKr8kKlBcGRPZ1Pl02A
	 YBRxv4CHerVy8Rq2xW6yTKWs8kDkQarSYPMjSgSOXJY12WrPRzvKAvR0p5Rl0cmcUMeOM
	 EjCJi5k4RJXplBaCWM3MwWLxAMxYfLmI8ACMwEtJcyZHxUZZpSgkXyUyphkztuoH2Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097246;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/sVy401gR2AeEzGop8THwUPTGkzUpgq7Tv+MYP33ejY=;
	b=m/qdrwSP2E41av2mH0run11rbgmrvkpDgt3s4wyd79F5c3lbp/0SFdaBXLQbxOszqpNQ
	 3PgW5azz5OAXQtC7b0QiCx2SrwCPkwPgOfHEUWwKeWjIKjnqJxfTNej7mrHqf0fbTqTZ5
	 zgI1DzeF7gaPqe+dDJd5sn2ArIwJR/AjP2yNyxGat4vOx3gjTVTJDF/yiKogKoAADz9yk
	 jndJgLCpI8ZQt3U3UEfIvlxPibQoq6vjsZXwLZSqJSCAm7xVvXNYi2d98YFdjZiqJ+RMW
	 bnZpHNW+hCnz9zOZqdZOcCesJjT+igQFtC+pPfZVq8VYbCLeBGdutxrX7G0I48vGPZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=geanix.com;
	spf=pass smtp.mailfrom=geanix.com;
	dkim=pass header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=ccphCd2b;
	arc=none smtp.remote-ip=185.70.43.172
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAC606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12BAC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=ccphCd2b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1793097242; x=1793356442;
	bh=/sVy401gR2AeEzGop8THwUPTGkzUpgq7Tv+MYP33ejY=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ccphCd2bFbwuXaYq8iH1YhXtQ20TEAxITPlm7Up0peJw1tjrBudAeMsmU98rV5TBq
	 iOUHZvT0CcOpcU2JT+5UG5/3EQAgwGOeNxxMrUK/j/naz+RLXlxQperInK70bgZbtc
	 dgeRNM5cjObA9gl6uTiILuCTOfa0ka3fwD+Wu5VyxpBPEvO6Alb+njx1Afk6GZdc7J
	 JJGtbfyhWtUDn/Bo1W/PRtCAp+Oc904lKniis6ZU/d5rEoicq7sfJq/JdPcnmSP21N
	 Y+OkEL3qXzPWW6epwjyRcz6G75y8Bpl6tlUwPSncWO1QGFxU6X0UvEiOrVL49E7fiL
	 6beMk1B/NLPsA==
X-Pm-Submission-Id: 4jDRgB1x3vz1DDWq
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v5 0/4] drm/bridge: nwl-dsi: Various fixes
Date: Tue, 27 Oct 2026 11:33:48 +0100
Message-Id: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQW7CMBAF0Ksgr+tqZpw4dlfcA7GY2AO4apMqh
 pQK5e51YAEl6vJr/vtzUVmGJFm9rS5qkDHl1Hcl1C8rFQ7c7UWnWLIiIAsNgu6+P3TMSe/SWbI
 OWLkWOLbW1aqYr0Guh0I221vOp/ZdwnEemRuHlI/98HN9OOLc+297RA3aUxM9OnaW43ov3KXza
 +g/1Tw+0p07MM+cCkcHnoFDVZvdgpsHvvxuCqfaRvbRNiS44NUDN/jMq8ItE2NoyXiEP3yapl+
 r4ut8egEAAA==
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
 Sam Ravnborg <sam@ravnborg.org>, imx@lists.linux.dev
Cc: Esben Haabendal <esben@geanix.com>, Frank.Li@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097237; l=3107;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=m0BPHe2DqHEKhL89dJjDFmUw11rDNI6REaVlOvyHss8=;
 b=aRY/BQFfU0aZSQufqd1D0E2EWNHAJ0nioO/HoN49yU6Elm6cH60p3M2nXElEqY5H7NumOh5bg
 IK5Rao5amWUBVEwWJASKJIjq0PnQ2W0Yh1Q7pyGzFq+4uKKqPhRlAYx
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
Changes in v5:
- Add fixes tag.
- Sort header files alphabetically.
- Fixed speling mistake.
- Link to v4: https://patch.msgid.link/20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com

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
To: imx@lists.linux.dev
Cc: Frank.Li@kernel.org
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

