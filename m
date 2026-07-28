Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DF391846
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257783; cv=none; b=TMG8ceD3mK7FZlLijITIVo/0aZ6GOcYy4nFTLTHZJtx3ukseOqBMRZwC9TJh29M0zwV6j40/jvhT287pi21wKpcoa1WikLxyH3cM/p2T/quKr19a2gWl/7V1tqBw1sh3ncjXa4IKDoTBsR5RA2z9yFsAZ7RTWCqkaeupnNChfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257783; c=relaxed/simple;
	bh=Q55LOEsEppqbIbdIMi4r+VcEICQBaQqaDDPUFWfsy1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsfQmVLK16KmaeVluAzExxUvyZACjkeV57TGXY2nVXhq1hgLqnxgvlB55OThqlBt34+MsnQ4gsqQ37XjlFY+j5ARYffFEOEIfaN8dgJhUOqB5p6KRZtOZ8sNI3Lja2fXvgWPOT1p85oh1/ThQzK6GxNbMRM9cYKnMhOUjhIOzRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8VdIuJv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8VdIuJv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caf228a910so972155ad.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785257781; x=1785862581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j+4klrRFig0PGwHGsDr8CnTLSp9SLq5VsHOMKnbKx9s=;
        b=k8VdIuJvnoavyko3y+fwjjMQTwyTeZgSCYLjHHTsArnr7sWxM1yswvX5icczcgnt/P
         b/Tjmgd/7x+nlypky1EMsGHSSyThBUrNuHDaJAtyvx5GoQuV0AZivBkI7KV+Nb0Byhdj
         6o1NjTvejTw7TscmhefJu9gCLS6bsJixma5CSl6Ec/RjHtW3urxMx6cFSOOxKWRaNLDo
         lPH65BPA/IIUL1dK4AgQBl/BbT2U7lPEcFiF9uKLGuAwHxOJwvqwQw4wJFkLOsi5wb+H
         SQ5dgddMGvpsq0FYJG+345WIGEWW3FPhjgrjf/LgOfBRvihc/VmsufGYWheASIzgLpnD
         XYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257781; x=1785862581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+4klrRFig0PGwHGsDr8CnTLSp9SLq5VsHOMKnbKx9s=;
        b=tDXns61kXICP/ls+D7MCUgESPoMvn4yyo0HaJMearJ0U/4cJX572i+iTLXdRbFQVay
         K4U8kVOQd7GhMlTjWaK9GVMBiy54DRjHoTfky5otC00bzqJzXmA+xWZeDZ3hZIQdVgbQ
         AiP5b7K+zIqM7YsEWKcr0ui953ljATYUlI9JOiSLGCgsyl2X8KqZFdtlBlzJMlewJk4i
         oNbc3YH6gGd4aA/BQgN96Y6ogXja9lTnyrNUeL2RHgc+qODPhdztWhFtArqUU0EQgOzj
         2b8oyjhOV2bnWxukldk/fW0pot2YcpdlUhXHcs3oImpbHy2vpMHRaPwb1guIalwEqOqS
         0nXw==
X-Forwarded-Encrypted: i=1; AHgh+Rrzd5C+1Os44kW85p/ndIwnVEixnUpxMeUTmalhpZVdb87Q4g6tt+bqSdqM/tBAWPMnU9ocPXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9T1ZgUEo9zVXy9+yyfG6YvgQe8OwXP52m1c/ZIAE4EvZAM+5t
	wCGqS+drXuEFDpWaNZsvmaRUKwDQuH1xSeWI+VD05bPU5T75jOMPp+c=
X-Gm-Gg: AR+sD13CMijW+jntBANU8H7MK4nRMkmvqmEd1PhGz7BGx6ennSDnh7nfcSmAA/FNUGZ
	k4yLEwOJB4nEjRnH17jOT3Iq1hlTAIeyviAmfCIEkQUv+71BccIyUidufKRZgMpWb5TZwn0QIkI
	V6fsALUZk7wAl5ijQn1yoK4knZITmw6d5+ZkhQ32o1EMLCkNmyzMjRzTl78nRZU0kIFjTmtrep7
	JPo6v/3oO5YApKy/cxRn5DebjBrcpw5CYS02EC73sv1zk5QU5gAHTd3kiYJRu+3Y8padfufVzoU
	CTajsU5E3DA0u/n/urvlA9n5eq4Rkml0UjGoWIu9sj9MSXo+xeJd6uHP5UM5CwTOnH04PgxsM2s
	LYJu6tcOBBiaR3U6gk18apmCQNWAV/0AU5RsBSoaoGWartwxOIgWCD7V1n+kWN2F1UyehMYAbi/
	ytLcHBqQbwGewkRaT9WDAws1sV7X8L3V3FfFF0JI3NS4PmZ1h8vdJCQn3iR03m6jDiABQvTa4jH
	OylHZhsI2hojiDGLC8dJ5Ngwh78ubDB1OBjEVB8
X-Received: by 2002:a17:903:390d:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2d015ee24d7mr36695345ad.24.1785257781202;
        Tue, 28 Jul 2026 09:56:21 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm51112215ad.73.2026.07.28.09.56.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 09:56:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thierry Reding <treding@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/sti: dvo: Remove bridge on attach failure
Date: Wed, 29 Jul 2026 01:55:59 +0900
Message-ID: <20260728165614.25847-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_bridge_add() registers the bridge globally and takes a reference.
If the subsequent drm_bridge_attach() call fails, the component bind
callback returns without being considered bound, so its unbind callback is
not called. This leaves the bridge registered and its reference held.

Remove the bridge before returning the attach error.

Fixes: 384764c36116 ("drm/sti: fixup for bridge interface")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/sti/sti_dvo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index 7484d3c3f4..4978e0acbf 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -459,8 +459,10 @@ static int sti_dvo_bind(struct device *dev, struct device *master, void *data)
 	drm_bridge_add(&dvo->bridge);
 
 	err = drm_bridge_attach(encoder, &dvo->bridge, NULL, 0);
-	if (err)
+	if (err) {
+		drm_bridge_remove(&dvo->bridge);
 		return err;
+	}
 
 	connector->encoder = encoder;
 	dvo->encoder = encoder;
-- 
2.47.1
