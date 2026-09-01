Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51653449B24
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292530; cv=none; b=bnuLwRIyBcYBbe0vCujKlHhjcIK1Hf2bH4nqEOgKEa4ouJqubUAdaXqmI/0gjpssEV+XDSgqNw+5TWZyknj6xdU85nJaN2fZ0OyWtEHbIJB1efa9u09DsgQPdDzTVrfXn2L936BSCGZ/lkZ2a69v9mq3aJdM6/Pj9coVciBYglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292530; c=relaxed/simple;
	bh=TvjOuasMKcmLJ41E140O1JpOLWeLLgpHzmdhvAOXxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rS6wDKEnidzdUaIsrDZ7uKFmct9Eu6lEnFy+KS/XQjfC2h6gsFf9eX6F/aJmxWcwKSkUTm3gKbrGtmgpXhjJgDsyvUuiiTODrtV9qcwBBHKFmqS+vdA1oY3Yc2qN72PTv/eXwPrhV/mfxcKBawgLXcNYB4jZ2dMvFeN5VaDTafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAIglYG5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAIglYG5"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b19e291cc6so192452eaf.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788292528; x=1788897328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jE7YeOTH+Slgx2JFrDNEXYntxMlmYaSvMdCwqmpupuI=;
        b=hAIglYG5YZPMjqn+mjdoINizK+v9Gr+xEK9Adeao9VaS2SGXiQBo7Gd9PziUYSk513
         qDCQzZvMhnm1gV+rVbtnjy6miGF3GJl6Y+LEhO/Wp6TMWyQ4fGMq9GsZZJzlq+pLOiJt
         7r1zkm1LCAVJPynALSd6HC2jj+uRnLyaKBt3h2nzbPq3wzBIhWu2D9S5jNZrOgnRbpn7
         OrXcIRIXXFyGi70DrvKVHa+9EnPsWgpEkA6hT7d5KYTX1QWSk5xRvCx5UNuVRX5Uueal
         se2r6/9bUs8lVTxo2VHLxWbgZCobLGDrnEjjbfJZoSjcafyjQDTIXSekEDodc7hL2W+f
         jykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788292528; x=1788897328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jE7YeOTH+Slgx2JFrDNEXYntxMlmYaSvMdCwqmpupuI=;
        b=VsLlX9H4dzemwo4QxQ6sRspzE6weC+HAKrdSaMYRmDogCFoysCHBoHQc7CBewA7MKK
         VnQrqHAOi61yBECVrAaQcuVEteQfxBUrUMHLkVfMOwd+FZaOwgrgNfnhFBAOfisS6cgv
         cSb7jkkbv4BxW7KdpRpOq90PndkwejD1T1/iXK9f9eZmpL2Q8H0sxD2C+3b1TlHyBLwR
         Ic6pqczMyNrvqQFnmaL/UxGRhMm373PF23NoW5c0KS9x9TeH+SA82W0Dts0OdEuiyZkE
         vsH/bd2RmbdQV8dezvVv6RTzqT/EUXlZRfyTfalUjJIx5SUXxezD84z78kWxa0EiTN3U
         KlyA==
X-Forwarded-Encrypted: i=1; AHgh+RoIl79Cf45KpkvckkpWUwg9eFz22PCoBcUhtZCuGaF7BYgAaX3rW1Lzy8CyDTlOvympYWhAqmI=@vger.kernel.org
X-Gm-Message-State: AFuF++nIwLFbO/YQNQ0KfBdmhkLsAxf/iGezd/2pSvJmLBQJlcmmAs5C
	K+ppcMuGWtJLR1MeeAjKN+9begSmzUr/HFnEMs7c0Er3Y1+0q4qoK22O
X-Gm-Gg: AR+sD13sYdiG5epWzEJhHATYzj5thjpWyLkfaib5VG7VXa2foKY4TUlRTIPilRcFSmF
	gBZEl3ZSpPgclP68foS8t4rNpNMuJrW2xva7BVD5SiaOW4ocDSOrX92ximQ/uRFDMDYJdyQChbv
	Iqv+XGwN9qjVVrf4B6TGzNG1eEU4jVZ6AH4Gb1pD1k4Yg7hVVN2/WULRjwNiPZ285FoquucRrjY
	Fwd4EQXIPvplGuh7FdMG67l5afF/7loI3tTAsFnoewSExknLmEAk4x9rYqzfteFKitTA8/BMNN1
	U4bYaTlLpoq0IErfu5apfEZ653z6y9Ve0JsbBhinrqXSJnuao44xSnbxIeWhYtjbMF/UqZrBwC9
	6/fiqVoh/So4krs395wSfr4x0Mx4wDclGpk5RWyqqk3ZRRDLnMZLzLTYBf6Szh/HalT5fHw6Omd
	OJUkYKymreiBucx8NgB9ISoZf0MJahtWhSL7yeC0FNKikrjoPW8TAgbR+UgaI2DwW+zpMh+FiE8
	L36x7oeXnUHhZ6v3aB+OvvIDcgYKqimMZuYJxUeTqSfK2A=
X-Received: by 2002:a05:6820:823:b0:6aa:cce3:ab61 with SMTP id 006d021491bc7-6b372d20e4fmr8604105eaf.9.1788292528131;
        Tue, 01 Sep 2026 12:55:28 -0700 (PDT)
Received: from memorizer.localdomain (47-163-111-11.bng01.bytw.tx.frontiernet.net. [47.163.111.11])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40f81f374sm868636eaf.14.2026.09.01.12.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:55:27 -0700 (PDT)
From: Yudi Yang <2000jedi@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yudi Yang <2000jedi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/rockchip: analogix_dp: bound endpoint name formatting
Date: Tue,  1 Sep 2026 14:55:11 -0500
Message-ID: <20260901195511.2761251-1-2000jedi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rockchip_dp_drm_encoder_enable() uses sprintf() to format a device tree
path into a 32-byte stack buffer. Device tree paths are not limited to
this size, so a sufficiently long path can overflow the buffer.

Use snprintf() with the destination size to truncate the generated name
and keep the writes within bounds.

Fixes: 729f8eefdcad ("drm/rockchip: analogix_dp: Add support for RK3588")
Cc: stable@vger.kernel.org
Signed-off-by: Yudi Yang <2000jedi@gmail.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 587e60232ec7..efd5a98e80bd 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -241,10 +241,11 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
 				of_graph_get_remote_port(endpoint.local_node);
 
 			of_property_read_u32(remote_port, "reg", &port_id);
-			sprintf(name, "%s vp%d", remote_port_parent->full_name, port_id);
+			snprintf(name, sizeof(name), "%s vp%d",
+				 remote_port_parent->full_name, port_id);
 		} else {
-			sprintf(name, "%s %s",
-				remote_port_parent->full_name, endpoint.id ? "vopl" : "vopb");
+			snprintf(name, sizeof(name), "%s %s",
+				 remote_port_parent->full_name, endpoint.id ? "vopl" : "vopb");
 		}
 
 		DRM_DEV_DEBUG(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
-- 
2.43.0

