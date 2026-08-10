Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204939D6EF;
	Mon, 10 Aug 2026 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346092; cv=none; b=FMUHzWUTmc46dfp8Ga+/AzTJWDgJKZMnPU/5JBwZjlSxDT5nQBBOgpVnVi4xsBowNz7FGNMn61FOjMVzYfk5L72F2eF5CNhN8zZ9+BRYiUIeY6gguIhXvWYvR1J8O6wSdmxu1lWYxgq0TlFEfMb4SkG59VOhMtuk9s8352XBEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346092; c=relaxed/simple;
	bh=ZtZv9kM3HSwvNhgh9vWcsltbgkStoKSKQk2mtwNTjVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nS6Xg9BBh3wyG7bOmnIOeowMJ8OzgLklI1c3RIJILevY9k6CHFnHh9t+RO5/5DSM4W//HWJlxNLogR/Js02n5Fcd4inDTGpFb578HMbPntGVjRPXi5HiQ+KElZ/z7vTxSHtaIG2/sU7rGHmGZjI2uT4WYxLdomJKW/jQdE5G75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=xhAyXGiR; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="xhAyXGiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786346087; x=1786605287;
	bh=r65bmRYdzBAGOyU+g58n+dad5jFbrD08bUUxvY+tdgY=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=xhAyXGiRVM4iRHb9fTFwkaMjE7Rj0QKrnCGJ2JYzOpT1n6qZA9NPphEtgfKoLjUU5
	 oJx88NoqSBk+3Xv8eNaaRDNYBGj+im1PaSO81uvoLmRrNBqQHKKXDKmtyop4MfKnNE
	 EikVxLvT9leYRA+iuY/vhSsZGNr/Be4GNFswjkx3sNdaOpwvGOwFSYMMS6gEQIwSDY
	 CIcvHtq0DzfBg0AUKBxJqDdWaB+QFEVpGi2HmvYAwmx5Dd17l88CG44oaaox5NPKII
	 aZNBJe1v7mPJkRWLuDlmRkVqYI4H9X+v69W1GBNuRF2jyt6KKWA56UQKhB7Q0CsUn0
	 3HZcbaswd9FVg==
X-Pm-Submission-Id: 4hJQxH1wHqz2ScX2
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v3 0/5] drm/bridge: nwl-dsi: Various fixes
Date: Mon, 10 Aug 2026 09:14:36 +0200
Message-Id: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNzQ7CIBAGX8VwFrPQP+rJ9zAeKNB2jVIDFWuav
 rtQD0YTj5P9ZnYm3jg0nuw3M3EmoMfBRsi2G6J6aTtDUUcmHHgJFQNqHxeqPdIWJ+OpYrloQOq
 mFAWJzs2Z9RCV4+nN/t6cjRpTJC169OPgnuvDwNLuXzswCrTmla6ZkKKU+tAZaXHaqeFKUjzwj
 y4g+9V51JmAWoJUeZG1X/qyLC/Hsbzv/AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346082; l=2520;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ZtZv9kM3HSwvNhgh9vWcsltbgkStoKSKQk2mtwNTjVs=;
 b=Qlts8Ma8vBHKrO1oY8dJ7ZlOOPXzvpgLHh6EiCmIdM51dZMerGk7dQhfSE4bwBrGVeZ6pKWet
 O4t/fB2U8SOBTzpVcBvDyZedMIcEMcgndVqYQdQUvo/ACbQ4178r5kJ
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This series brings a few patches fixing horizontal sync timing, EOTP packet
behavior and hsync/vsync polarity selection when using DCSS endpoint, as
well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.

The 2nd commit ("Correct auto-insert EOTP behavior") is taken directly from
NXP vendor tree, so I have kept Author unchanged, although I have modified
the commit message. Let me know if I should change Author for that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
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
Esben Haabendal (4):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      drm/bridge: nwl-dsi: Add error handling of nwl_dsi_mode_set()
      drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing

Robert Chiras (1):
      drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior

 drivers/gpu/drm/bridge/nwl-dsi.c | 95 ++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 14 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260710-nwl-dsi-fixes-c148b0adb685

Best regards,
--  
Esben Haabendal <esben@geanix.com>

