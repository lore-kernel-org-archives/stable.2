Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016A29A32D
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542091; cv=none; b=shhHT1wRL8DjX6+2mkZUtGju7FNystxsvtuQZmsFZG3st8ZVazpw5NLQcXglB08vqsAumOstsXWeSStcMaeV3aHMxvASSqVsrxGsMfUpOG9iMX8+MSjnrGJgOeO3ZzW9PelZJci/bRnkRgfb7IHKqIVgjfdlaU9cXlNz7hZe7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542091; c=relaxed/simple;
	bh=Xa6BF4P0OpiaSuiLW+xRdnqpjJkGE7kzujlfd60Km5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1ht3eQriBgm59YQ3Sn2GGbDfC+GQ/xeSUmAqOElAeCjG+opXEvr9MLztIj4OmJ8L2THB4ue/99CJdBEsfLwAbcdKf7y6krpGlO/cDQwVl3WxjR504Im7wRfolAq9MkhBXeF8x8X/Tl1BF3BymXFZqCA7eem7aTHkZ4CCWvY2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM9BEvzE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM9BEvzE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c19bad03so10769185e9.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783542088; x=1784146888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPC/fPRplTXrPRJP9WPEDmAAHY+62t7UA57bz5CaOyI=;
        b=IM9BEvzE0+2iSziOqJdddwoVKbfaDEqg5/ggR+r80Lyu7G8a1VBWxjGuYtAJksZTyq
         9jpNjUsMEpXAZ749RqDp46DU2MCUtQAdQruAN8ZtiAFav00L9kmgHAapHm5kBwxNxbRC
         PfJemKLLIqkCSlrJhEweorfKtx0v1jMX15zqUciBOkE2LEZVaXg8E6d7H+s3VnwI/8BD
         4tw0se0TDO8OG0ulX4KkUENZpQmfs9mYB1xJs33wCnjEslV/arFHtP5YgYDqAEnXF+n+
         minojyYrsWPZ8uh7jq1J366oUA9AdNNECVdpnQU5YU9a1x5gywCnn2/t1xT3Bc42J1Gh
         RJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783542088; x=1784146888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPC/fPRplTXrPRJP9WPEDmAAHY+62t7UA57bz5CaOyI=;
        b=sLWXOgU28s0c1BOyNcviy5bs5LYv0puRNJ5ih2i3zEb6G0nGIYzONDIbHaQkmYmKEP
         hevyO/2z2WbhuG2gNZPSghSRC5Y+RhGEUjS/KHKctzVRiHtlzMJMZWxqFl4COc1ofs+g
         HmYiy2y1Mqn/dB2tTBA76DmDmxGL/5Bh2LJ3xqalqrXOr2wd3xNcdoeS+InndeWiVU92
         o7ENhXhp0wabTB82gDtWG3aSMVwe0uQWYmEvXlFHeasrZJZ5wKd3brNaiufexQzJe8sV
         kVegQ5HruCzEOrESy9BrsQXG4F3OJfnT84ZuevGc+lhKKwmk2HhgtGp0crCaAfLBz/9e
         fEHg==
X-Forwarded-Encrypted: i=1; AHgh+RrA3F8iH0tHeWSTTJTQQxmljYQD6e2+cs6l7vaEKvetKlhgchQy3U2H6458/1A3yeKAtFonlMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJnNeopMqTrWK1kVYjWv6iyCp6QDHs3F5l8QADJLoIY0YqeOY
	eZAWezwPWR1huXE0N1z3GClSdW9naeTmHgg0Ku4G9dNrhxTkGwxscSpq
X-Gm-Gg: AfdE7cnfq4Ihz9Dm4oQyDOz14jb6o8v0s3Jj6BBwnmHNhugPqH1lfZU3bn2+Nl2Qoxz
	OyJJbljjTsnjyGTEC8MWnFHcF9RIImKQY8qrnGzBDlMgtfrrjh4qLEPAd35nyn4J+31xTkF/3HR
	Ktp8EErPWIchmGjx4N8YOY8nrSjsyvEVyXaNMoBsZDm70DKB/zDmOHNLSUWk6+ifSl+PSdhV8qf
	5xKD0GF02rQvlgv0oppAW5Jw7fggEtLRbyRRW8gDhfxSx0QYITV90GnxIZdfH9kCXgj2PivSEch
	qlq2C00BfMGVpqC8N1bJLZPL1UfPDZJVk65Ci36gf5rRXnW0QPol8OH5iQw6BGl9ZZuGf9l4Stb
	tGzRdF6+ZNQrrAhNYOWyUkRd0xUAnu0NFA8OyoL8JflvkJ3nU6UXgJkHB+e9DckRUGvmJs78oWl
	wtikKrslGNLMka+liqFxSFH43ZPaDzd04onBBGqP58T+U5WFZJUA==
X-Received: by 2002:a05:600c:3e07:b0:493:de89:61b with SMTP id 5b1f17b1804b1-493e6868766mr42351155e9.26.1783542088002;
        Wed, 08 Jul 2026 13:21:28 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:2b86:7192:b44e:9f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e54a25cfsm97381485e9.0.2026.07.08.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:21:27 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/imx: Fix ipu_plane_duplicate_state() OOM handling
Date: Wed,  8 Jul 2026 22:21:23 +0200
Message-ID: <20260708202124.12560-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706140246.41506-1-osama.abdelkader@gmail.com>
References: <20260706140246.41506-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipu_plane_duplicate_state() could dereference NULL when kmalloc() fails
by returning &state->base unconditionally.

Return NULL on allocation failure, as the CRTC duplicate helper does.

Fixes: 00514e859335 ("drm/imx: use PRG/PRE when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- add Fixes and Cc tags
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index c7ec09e557c1..67f2da7f2b65 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -323,9 +323,10 @@ ipu_plane_duplicate_state(struct drm_plane *plane)
 		return NULL;
 
 	state = kmalloc_obj(*state);
-	if (state)
-		__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
+	if (!state)
+		return NULL;
 
+	__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
 	return &state->base;
 }
 
-- 
2.43.0

