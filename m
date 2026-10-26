Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032833;
	b=2Tky7j4PN4s9AoVL+mojAOsVIBBqOVB1z3cb+rRAvGrmdlWe3dk7oZwb8OVkK1k1d8UR
	 yhRoh7vg/1Xr2RLlIOnvEX1uuZ7w97dEuZqNgPNbD2ogzYbj9vQGLDzKCpCz6fZwqcuNO
	 arWf77+becq/0dRsmZHUO9UnrcD3Ii7B+62gUoy/9pL5ZsPkJiSylgAOAf6O2NhHu0wCP
	 xyjc8HmVM+dsh+W4+uDXgK4nJUXbq7AVc0Xc5bdYEl3wwnL+R1apPuVWScotQcBSwlGIJ
	 R7VJo4JyV3CFoluEE8mn8Z9tslwHQjv20QxddT8OSzM4yBHyw/f+gYY6zEUXyXBymUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sAOWa8x25rACNbacVKQZnJMMCRBQGzMNA9iEryT5ck0=;
	b=Lqzk6uoQpL82sPN4L3XLCBmL2+BvyqxW2y2TMldO+aphXtsx0txyLNmE/ZvWlpw/wb0m
	 iyENmMOaQ7SiMsNTtZyUHEKzFrYfV0Cu/CZxVoJFyraAjrM6C1BLAOI4CuOKm6V4CKQdB
	 UTldKdpYs2Nijn3xJhWRiKDkODeqMl/hKzy2DxKZUzyhCpHmZRXHActUCaRJZaOqIobxW
	 +RI+jfg4Ti6WSYSJkTvcsnrtERWgXYs8eqNO2kg6eYjJzEnIHjvwRxh+Z4+hL/qh8Re5L
	 1MflBULXb6fZGjtCbbCXirdty53Ht/j3KFd8Ix66ElxDse8M0aunsvJ/S4zcgDx7QDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=neat.no;
	spf=pass smtp.mailfrom=neat.no;
	dkim=pass header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=eSpvdBxz;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B51606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neat.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=eSpvdBxz
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e4831c028so1654225f8f.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1793032831; x=1793637631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAOWa8x25rACNbacVKQZnJMMCRBQGzMNA9iEryT5ck0=;
        b=eSpvdBxzzt6vjPjvk22FuHAe6u+tQDe+vQAYxRSIIrIcbeHkEsiEzPdFKiKCaD73jF
         vZAhM5I014nd347aqocCAgR0/qq9Pc4X5fbeEjNGx4oW3fPWs4hnCuaEoB4jVc2jyrKd
         +CtCqMNEIP8ZpgB0iRwJRnsUyw/cOPrdGqSfiuKPOQAygbAiM4Cwbu5Wyke69kKdk7eB
         2f8LVlKFTha4hXhWIgU6a47XoZSL37gBcfFHa48y4yybotZGbRfPiySbFG2JUMHoT9r6
         BCkmIdx4356FfamexokVY/wPKxFl2kjaPTfgc74Kr3U49nJEoLJkznxWShRyh7S0ovmg
         d86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032831; x=1793637631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sAOWa8x25rACNbacVKQZnJMMCRBQGzMNA9iEryT5ck0=;
        b=Opa7WO8zt3n7VUNKgruMWTv6kkAYrKsXCoFuCUx9mJM+A3bBSqUe6K8Ae4q6XBmTbQ
         yNp/3yRdWWmwZACp/eau/yKgxeQkoKZhWQjj9iZJTAW71awG8jZu+jlEAuSSaVaCDE7M
         ZMg51v31gbt5eERHzsQUH4CF4VZ+syJCdCUantwYfPdM4RsNBOHHZcWw/fDcibdy9ZMY
         qgd89XFBn2cJvEfdiSwQAKLtoCBKvtTqjfiRhn5kHnr/Vg5SPUZ3wRabGC+IFkhXKaP1
         tEP+hA/aZ8x+9UORbki6AfNXlOE0+ZZabE8h5+SiK4zhTFc1ZD1tsHDcLEy8AX3oBbs/
         M6PA==
X-Forwarded-Encrypted: i=1; AKwUvBxGvDZi1IsNOz7YChpE/Z+HdFOSl/LfaHI3O4iWOWOpIYps0B9w7UhKTHM7VgAIa7CxrJOBuzk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq+AiHV7xNdNUHLzgY6+qUSC3CCWJ58Lxb4TZGLHWgQL+qXjEx
	10DCRBfu+6ZwhJKh/SqMXBMY2iaVa75etqS36Fj7AK/gKS4ekSmFDw120iRcZbjsWIPbZycALnB
	E9+1ZkB0HCXjoBvnclg5o/GFDiJN2bg4FOAdtDwHt3pS91u81bRXF71smzadzJr7NPiaS4AgtBj
	dsrS0cgvd/VZHR+whQ8MWK1biXTODzRvZMczIbtCq9VkYJX3VR2YBJRh5C83n5Ju7r1ylu/c5/Y
	kw=
X-Gm-Gg: AYBFou1n8MhDod1EdWWk+eXDxg9YcknFSc+9ulmUlkgnDWs7Olrg8DVaErdlrxzllU2
	bMgeLJHd7/A3lGdGhusbsDmI9Tghxq+PHJ5A2ay9N9ccp8GiFmIy42Hv1uEXF4g2Nd6H0eUX/pK
	J+Xw1qjL3wU6FxSOLm56tUZ1iqmRiqt/SgT+1VLvzR7wcbXsld0XSnODHZjGpbtK55mVat9CWi2
	Y+kzelIX8uqFPYHjFLxJMuDjxMsnvNytR5gZhmtXaOY9LwV6V/yh+J0Cn0/DNydqJ25PFpjz5wJ
	C/WZAI9/SRpbUvf2nqLQ/wn9n7aB2Y2un7WQoB/QBGkZaUVIOk/wc1iiw7jQ6Fj2b90OcOcXP0Q
	8yrx9qUvOznlcYbRBIkzn7sxheW2eWkdNJFHm47nWxEXcrtr9v5X6iK7hsMaN8PxanL2iTnHt0B
	BaAlW4g1H/+1MO5EAUVCk8ehuYeV6Y2mEE0TPNu9VhQ3S+wnvHCw8lApTiHgZtIZeBAkJLDpO2v
	bti1om8WtbajHwTniE2NXLIuFCEAwoos0Dc+vbdXqYyd3719x864uZwNtgFeVcyER8eJBlLwvxk
	yvo02buM+w==
X-Received: by 2002:a05:600c:3b11:b0:4a1:dade:f049 with SMTP id 5b1f17b1804b1-4a35acbd3b3mr141129035e9.15.1793032830719;
        Mon, 26 Oct 2026 09:40:30 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:40:30 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled
Date: Mon, 26 Oct 2026 16:40:26 +0000
Message-ID: <20261026164028.78792-2-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dom Cobley <popcornmix@gmail.com>

vc6_hdmi_phy_disable() is empty, so on BCM2712 the PHY keeps its PLL
and TMDS drivers running after the HDMI output is disabled, until the
next vc6_hdmi_phy_init(). The TMDS clock is therefore not stopped
between two mode sets, which the SCDC clock ratio change requires, and
the idle PHY wastes power.

Reset and power down the PHY on disable, as the BCM2711 variant does.

Fixes: 0b1dbe82e051 ("drm/vc4: hdmi: Add support for BCM2712 HDMI controllers")
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
[lucas.tanure: Rewrote commit message to clarify the issue and fix]
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
---
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
index 56e6a35da357..5040f014bf7e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
@@ -1197,4 +1197,9 @@ void vc6_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
 
 void vc6_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	vc6_hdmi_reset_phy(vc4_hdmi);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 }
-- 
2.56.0

