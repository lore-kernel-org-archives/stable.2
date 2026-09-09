Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2E5678FC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967618; cv=none; b=rldvKS/rwNXvSS+FARRGYflzQjhWXhKbQfmAufDLaGj/4hf+FOwdc2ZPRSaUl5LGK97DPdos8Y0+TuLSbupx+RNUHwbi03mkLSsvnB0dT/fgkPBMfOIVj5CVj7NKT1W9yqBeV7DSYLsLGzKdCOOgAKgS9uYrgCt6Ja0szwAN0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967618; c=relaxed/simple;
	bh=XS0/UPa9q1XnFmiNnllWerTFf1rOn0wfiSm7hryWDzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8SzVkU7EAQAetiIuNMtvtmaDm3tX0HBhGW8tIOUpMN8lu+ENbcS3qjVlbhaXULSlRYXAtACeko7MvyG9Ixi/XAZOsnxlIvHlSBqfi0sqP/8ZWEtqnmPBAtY3Mhl5oykcFxtHfxITO4l4OiVsUw/KhB/ozRc30SeWpNndQcB0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4HRdrp4; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4HRdrp4"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so3474345e9.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788967615; x=1789572415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7XjgSfNPdhrd2USCc75zWLYKllp4qBkU3pGunHKBWU0=;
        b=J4HRdrp4oHV6yQ0QbpwJ8MmZ3JW/cvJoydNOPmbrQG8Ydutofnzvfm2in159hGsF28
         N4sYf0w/04PwNrG+Sh83+DFjxuzI0V95dPuxIkOl1Yi2IYDyiBAHEgWj0SNRrsPHoMcC
         MZNU1ZnaenErAFJZMH4ci4gnj9yZkETLsdOnjmiKZSUUe/qM5TmeGNayfPBoBcSFUCMD
         Xo81skwNy8jzwlHkz5yXGL70yrggDQk0nB4qd0Dy6s0K2vX5TzErYq/ESwXd+eS7FQ+I
         +zCV3nTMtf/O5926fuLlRoHhoZGBgr1+DYReKff4fhoJNctAdvtjaSldlr2BoCeIKzHj
         56GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967615; x=1789572415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XjgSfNPdhrd2USCc75zWLYKllp4qBkU3pGunHKBWU0=;
        b=eU+YNsnchxvstf3Su8sQ2mefDgI1aqLkr2nHi/WKsjCAp7fumMmxY/252cvfcmhoPk
         4+aWXGRkxSOGI7zzbNb94ftQE4q5TbP+0UavgC4R9oTZbHlxRunyZ6szuAMHQtOY8qNS
         wbt11qZoYM+H6Ud4sS6DE+cdIMsusWgoN3eePoYyil+FO8FFv1DLRRS7w7bUouywDOB8
         UhhExYgdsVGWc+Z+/YG2Log42tM+ngDwp1x+QuPwUVkpFfU1cURAgKCNcd2uhNORm1+8
         HLywMniaKbyWwra0rDoAiPcEF8GKmlN4Fjv2h+nXqs3sJH1gbgbFUCHSF0C8A8/TnFME
         XyXw==
X-Gm-Message-State: AFuF++mWwI1f7FRRKzPm3yErpUwQSR2cFaIbALbEoOpNmYhk1qz/EBpn
	EihvrhT7YLmo4sTxT38kzGA0iWK7AezjM2jk6Wfp2lRkJBfkijThawP8Qg0hJJS8Bso=
X-Gm-Gg: AYBFou13PAWFCX/JQdDHofSbIAEQfHCR/0O/F09dZgN3BtZLrgDc7rCGrRVSMhu6MMV
	PAvk0fYqbJdwW4wUXQ56zI50MSL3QtNOImTU+/1/SJC5Z+Q79u4pf2TnaXuGdI4Pw8ALD0wMoXf
	2HaRmSCf5QwvdTvqzYYWc4ysnwsCHeFG8FNq6SZAMtzMr54CxKZ7qyd0ZVDkaBSpwgb4j20DHva
	tQZc+Xo5q4g7b805IgmmozFauVyvm5KM8EIAsrsPytsGoj57IwFZFZBMYUKSRjm/wnxUoo+d0Fi
	SE0drIHor3qq7MHrPAXlA1aacrceyR+TFVXyRsZlrK2Vzc8Ai1DSbIHQR9iMuxZAXA2A86yeXRf
	+oc1P21GB2ekJGzJqITL8CjbmW5Mjgux1CyO17wDDz4eO+N6UHyVoP9ucXRIpegiwFFoDHSkN2D
	6PExl9m6x6+xJ1T8UOq47TIfdha8QbWav2BWWJhVPJupj5nKoDI0XsCyVRo/NVsYM/nEQiBYdYN
	GN6p/PCfLJ7P6AD6JF3rul5e1pBKwejz4JTTd1UYRe2Guh7OIgU121zHbAlxw==
X-Received: by 2002:a05:600c:1989:b0:49c:fa21:e748 with SMTP id 5b1f17b1804b1-49d25925241mr16185585e9.30.1788967614919;
        Wed, 09 Sep 2026 08:26:54 -0700 (PDT)
Received: from cachyos-x8664 (h37-122-44-64.dyn.bashtel.ru. [37.122.44.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485aa2c9acasm8901719f8f.36.2026.09.09.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:26:54 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: stable@vger.kernel.org
Cc: alexander.deucher@amd.com,
	mario.limonciello@amd.com,
	superm1@kernel.org,
	Alex Hung <alex.hung@amd.com>,
	George Zhang <george.zhang@amd.com>,
	Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: [PATCH 6.18.y 1/2] drm/amd/display: Fix backlight max_brightness to match exported range
Date: Wed,  9 Sep 2026 20:26:34 +0500
Message-ID: <20260909152635.83860-2-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909152635.83860-1-zhitaevakh@gmail.com>
References: <2026090900-lip-ribbon-1726@gregkh>
 <20260909152635.83860-1-zhitaevakh@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit bd9e2b5b0473c75abc0f4134dfe79ecbfb16610d ]

[Why]
FWTS autobrightness fails on eDP panels because actual_brightness can
read higher than the advertised max_brightness (e.g. 63576 vs 62451).

The conversion helpers expose the firmware PWM range to userspace as
[0..max].  But max_brightness is advertised as (max - min), which is
smaller.  So reading the level can return a value above max_brightness.

This regressed in commit 4b61b8a39051 ("drm/amd/display: Add debugging
message for brightness caps"), which changed max_brightness to
(max - min) and undid commit 8dbd72cb7900 ("drm/amd/display: Export full
brightness range to userspace").

[How]
Advertise max_brightness as max, and scale the initial AC/DC brightness
against max too.  Update the KUnit expectations to match.

[ Backport note: In 6.18.y the backlight property setup still lives in
  amdgpu_dm.c, so apply the same property changes there.  The upstream
  KUnit file was introduced by a later refactoring and is not present. ]

Fixes: 4b61b8a39051 ("drm/amd/display: Add debugging message for brightness caps")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index deac90c49d..03ebb8001f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5222,11 +5222,11 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	caps = &dm->backlight_caps[aconnector->bl_idx];
 	if (get_brightness_range(caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
-			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST(max * caps->ac_level, 100);
 		else
-			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST(max * caps->dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
-		props.max_brightness = max - min;
+		props.max_brightness = max;
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-- 
2.55.0

