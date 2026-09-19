Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C7250BF2
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845339; cv=none; b=F31oWcN2lp5FSvSYzjlDM5hRbirP2+teacCnhT5NbrvrhNH0GyfFRVslfpzSSKwCrRkF7muGdBaeb/2dQ6hQdeDa/iPlFxfP0J8lxvT3CvCIPhewVo9+C4W04hDk+S+V1pcJKYkxHye9ItVFkDtUu+5Ws7Hs9gQZs0yHyxRskOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845339; c=relaxed/simple;
	bh=vZGBjZO+3pK6P6r+j1Br2A8tEHTya3afTzlQC352TVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qK76vi4i3mfinI3OqUq0wGD0+UsO2oPNf1HzmcE9cxtVtjydOWpFCeoW6oCVA33ONW4a7jxPpqLqMnknyLK7dIOcsn6iVDeLy5WrUarJqXemZxQuUTniqeTtuaOF24YORdeKL0QRblYJYG+nsH+OziuKAgri+0fGaU7QbQpAk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYQT2uRw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYQT2uRw"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48431648f33so1153914f8f.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789845336; x=1790450136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYG31FNdE+jTjB9/DDoxQaNK7idCKtZmhwSMIq4k/44=;
        b=YYQT2uRwk2WVmGwAzs4bRf8V6lu0LEgT+argTljooI1ga2NlMxCds7Z/1XDGSMGqN6
         1ygd2nP4ISMN+VUPGDbLRm4G/j4Kc9uwW+kIVsiFWTXTGAU1OIIf8/OSjS7aoJu5+SrO
         lAp1K+dETzsu3B8e9bKxYTc1dgRrcSnxvZ2LDYmZePDw4nnyU8Bu0q9Nz9nHL7IovVjr
         s3xwmBRC0L4XL2ha7QAoF7cG4SWaLbzbSfOPoKfgtDfteAQJsOxfQjZIr49SRKERxH01
         K2ddBNFLeKO7A4Fd9jEhc4of4H8hAMBotlrbJJ15sbT1/Lge6xijrIkn2ze88uWY8XWG
         Nx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845336; x=1790450136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYG31FNdE+jTjB9/DDoxQaNK7idCKtZmhwSMIq4k/44=;
        b=bT0X9vVbFjKzUqJPPo/JAmHxSmCpN9S/PUlnntsiBPi+hrb6lSliW85mSnkOKD8plB
         u7T4IECEgnZxisQc8RJ00/2weLuawhIC1VHADrxBIV0EjCMac4GaqU9hdOAAnSDQselh
         dCEjBZ6NwmD+JhCi2VqOG1/paiahcOKL6fyfU4lq2mE5fPNH1gxVBf0WYrKFtP6BSMpw
         64h/t1LWoYi0FR4uxMU70HQVoSA9QweO9rng6OzhNuUe2aDBYQq0QqgzWnE7IvuHLQvg
         y1qniJFwHuvhfEr9urpUEGRfyN8P59ZqtCSQpbT8cricbDjTWQ4IqkPAKRPie4nMhWqe
         mjLw==
X-Forwarded-Encrypted: i=1; AKwUvBwFM32RMUuRuJHWWnqmDOPb/BhibFo2Dys5bQ/BIanv6KNvpz48G1N/yr+S016zlAWapeklM+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++l2bv1dUinztQ7A2e33uVyH2VcZhtUMnO+IdX9Rc1LJCnrVvzu1
	Eo44vxzv0VAgXCmESEIP9L1Z8kTLypHQDXG/me2a8WbrAmBovIp61Oju
X-Gm-Gg: AYBFou0ib97p7r7qFjx1sP13g2eS3agTdd/bulEfxpOgvQ3fUmSIzuYkZ+vzQJtJING
	qdEHn09Lh/eyx5vexbp+xIfs4TyRGgMfZaG3ADLazCbIA7Yj1mHVFEibn0XTw/vvbJA1EYhtlM8
	uxqxrP8L9wRufGCUUWorsCbSH2wsmRt/yRxmfTlZFMU8eu0tltp1e05DzuIr9sLfRLdbCe2y5Pr
	IQNLjMU9Vnu3pua0ib/vCxGt8y/+q/0tcgypJ4bNk5NPDWDtx/LpcSQZoWw67RMwlwG6Et3Lhsf
	LCBPZnaDhrojRlfQ88o0MUS/IBePeKeWpigJggvl3V3FI6aIM1qo8YsTnzoDJIRW5KHeja1pOQU
	28h86XUT5jKOG2PDC2weZ/CvW8tN8F4pG+EgwAO4pkFW4/eSr/xBXDmWpNBDoY4CkiZ0dwX2JAp
	FGVO1xRJN6mGB/GcGbWjuNWw7saTkGCFxzVuNgEUCNe4vW3Pr4IeAET0gOeMLMgj1kf2G58eaR6
	SINWp5AC9cfEREmzJanciPPCJFd4Ll08eGgvHmTkOvWcV297Y6A
X-Received: by 2002:a05:600c:81c5:b0:49d:28fc:d6a0 with SMTP id 5b1f17b1804b1-49fbd200256mr159837415e9.18.1789845336038;
        Sat, 19 Sep 2026 12:15:36 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872458f7e3sm8932380f8f.25.2026.09.19.12.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:15:35 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	sam@ravnborg.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
Date: Sun, 20 Sep 2026 00:15:23 +0500
Message-ID: <20260919191524.268810-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tdo_tl070wsh30_panel_add() calls drm_panel_add() to link the panel
into the global panel_list before tdo_tl070wsh30_panel_probe() calls
mipi_dsi_attach(). The panel object itself is allocated with
devm_drm_panel_alloc(), which only arranges for an automatic
drm_panel_put() (via devm_add_action_or_reset()) when the DSI device
is torn down; unlike devm_drm_panel_add(), it does not call
drm_panel_remove() for you.

If mipi_dsi_attach() fails, probe() returns the error directly:

	return mipi_dsi_attach(dsi);

Once probe() returns an error, the driver core releases devres
resources for the device, which drops the allocation's own
reference. But drm_panel_add() had already taken its own reference
and linked panel->list into the global panel_list, and nothing
undoes that. The panel is left registered in panel_list pointing at
a device that failed to bind, where it can still be found and
dereferenced by later lookups/iterations such as
of_drm_find_panel() or find_panel_by_fwnode().

Call drm_panel_remove() when mipi_dsi_attach() fails, mirroring what
tdo_tl070wsh30_panel_remove() already does on the normal teardown
path, and matching the pattern used by other MIPI-DSI panel drivers
that pair a manual drm_panel_add() with mipi_dsi_attach().

Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index fa961abdd2d7..32f2dd2bcee7 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -179,7 +179,11 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
+	err = mipi_dsi_attach(dsi);
+	if (err < 0)
+		drm_panel_remove(&tdo_tl070wsh30->base);
+
+	return err;
 }
 
 static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
-- 
2.55.0

