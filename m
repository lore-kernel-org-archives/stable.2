Received: from mail-wr2-f24.google.com (mail-wr2-f24.google.com [74.125.225.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300E42124F
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925341; cv=none; b=ZD5WZ0hBxmAbsfegJRQxsmd0vDNhI3aWxoAS+hCPCEpPWqgvZFzW4h1duF8/G/6/3Zrs06va5Lr1xG52jv7bNovtaMtiOMdudKFdOqC5vBuV7XWdaJ6S6I/D4mdaSwU2xMb7v4a8hbHSkVjf2qJsHQY6B/fuQR93ACMa8rMLCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925341; c=relaxed/simple;
	bh=SJ0t8HbO3U64c4RjW0ViXNoqyUGeO30oUGqMHWd5C0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tB3tofp+2Sq/s0+UzCpaFgDXqJAODt1xD192cg7LT9OWheY/UTAOJpSp86KPnWCCC6I4hwUOmXa7X8sgOi9xgxQEloXx5pTwx0Skf/XNtOV4yxvahaXu8xG1aGp2kaLSqnYIscS6svhdRoQ3/V/6clbOdpTL2VP1HOjnDAAKqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prcx4XNO; arc=none smtp.client-ip=74.125.225.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prcx4XNO"
Received: by mail-wr2-f24.google.com with SMTP id ffacd0b85a97d-482f63546c3so5701554f8f.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925337; x=1791530137; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qqyFh9OKcAKMhJTMe6dKznZlWeuV8+PzVNUvWK2iZbM=;
        b=Prcx4XNOijbIC2CMGOLzcQBVKYsvK1R+COVTwb7C0TupNpIkcB57oGc3LRRjN/TNEL
         G+E2LP2Xx9uYEVNqnoJEbUZJLzGG4ZOmxAPMRfgZ0n5gfGTTRSJNeFrGMQMwlKLe7Fam
         h+IaNctsGeh2Estj0JCOmyaDldY1Hqnl7tm7pnl+/MVtOuT4U4DigK3ZuwRFfcQzpFua
         adIh7B9pgPEqXNjcoVAs9eSa45qV+z+14j1kzL9zMnJ9jLh0tthOj9oQyuSj0YE55b+3
         YE37fyE73GMt0QgqDsXB2HQLTlYdUSkmA0ZHXr8QQHqlKYCWdlomqx1vZVlQ6Lo3eahp
         r/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925337; x=1791530137;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qqyFh9OKcAKMhJTMe6dKznZlWeuV8+PzVNUvWK2iZbM=;
        b=xTeW5ooRHnqBmnPGYHSEux2lGjqf2+rZwxaIVQHRv5GXJ0+8yUeSh7SLlqzvxcqA7h
         P4PYDYz7ZgboDIZWyKXFvDI9rUkpsnoApuatUbrEvnFy1w10DfkdjeZrDVy9RCb0a+ny
         qmEUKtUEXiMC1Ehhz2+1U0q5DdS82ObFW4KtDbA5fpcIGt+QS1e42WYn0fUS6Uu83T59
         QWbAKDUN+GvSNn6ZEtqYlBm6hplMiB+jtj8NJO7EFN1WHyw3bNZcr+5+khy7z8rL+rWo
         vgU3ayUv1jaZKWXFUaMhZrC9or1dN00Q30SvuRpHYcDFbBpOPAb7J17FVU4+u4nvgXgW
         z+6w==
X-Forwarded-Encrypted: i=1; AKwUvBx1O/rOMy/0H2cTkQqzIQweqksAHk1JXeUH1aj9DWduEsUW2R7hrgdkJ8ddRox4igsvho+IaE0=@vger.kernel.org
X-Gm-Message-State: AFuF++kGei6GrYllwAab2s+axnZycoSOVKY+fasrPbCOznWHwVQMmk0O
	tT6I+FR9/fS435QmoYJKQsVrnPqpArpoTRMY8/Mo3AYuTG6sDT4sXs12
X-Gm-Gg: AYBFou2uzhLmYmKn0mWZUWRndZc62nNRFYAiCucD088AoWGWBwCujxV6coV7IgBestw
	qQjZkUSbNrL005xRBZ3Oy4ArSuPGsTT1C/TJ8HFoYOkAwYnV6pghNIhGZRQlXaBPYIHNkOPxCim
	lRgaMuCmjD0yUaZz1xGGFcz/9TJNcb4T2VbF56TJxUTvpQ9Ga3VZMavNYEEJyz3YDt+ab3Ed/lG
	iO+Qw2TNO60Z6ORkSMdsCP9qJ8moRCkCe1DoIulpYpQ6MnCTUAcXJL5BHCUV2/qXH1+3EoeKwpL
	sJHWWAmwhxpMzKwIzfyMD1s1x+714jp99xA4cnEiefsla4BcIplPW0HBDwYJzT+YlY71ROUKE2D
	AIKM3ofZJ1BHSdeIbj5q0NaoBPblDQYo46CDtXfT477mFd/x3WuXZKfOHO/1/c9LWKxlvuO3SoF
	VPw/1WTVn1fxMHaaYq182cgAWqV9YJWL76FtfaYiMu46ng0rAiHERuQf4JpLav7zAir0/6ypfFS
	bC4CEV0GBXpWYbOiHVewsg3tqQdmWnVZc5C7gj0mFxQX0iUp2IsqFnMbhQOtsN/
X-Received: by 2002:a05:600c:3b01:b0:49f:ce72:e930 with SMTP id 5b1f17b1804b1-4a02758eed8mr33065465e9.34.1790925336506;
        Fri, 02 Oct 2026 00:15:36 -0700 (PDT)
Received: from [127.0.1.1] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027741586sm57170235e9.14.2026.10.02.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:15:36 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Fri, 02 Oct 2026 04:15:23 -0300
Subject: [PATCH] drm/bridge: simple-bridge: Enforce input bus flags via
 atomic_check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com>
X-B4-Tracking: v=1; b=H4sIAApav2oC/x3MSwqEMBBF0a1IjS1IKbSfrYiDJL7Wwi+JiCDuv
 UMPDxfuQxFBEanNHgq4NOq+JUiekZ/sNoJ1SKbCFB8xRvgSjroeC9gFHVK3576qZz/Bz4zKVXB
 1WQsaSo8j4Kv3/9/17/sDJdI5NG8AAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Leonardo Costa <leonardo.costa@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790925335; l=2106;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=xqan7CitOzDVUI34jPQl+mNM+DqEBoLtPLpDOGRqX00=;
 b=ypmqd1FinxsQrSduoBP46+XorgtAIAyXI8upcyPQebztuVjZA3vNWwcOm4JJxZnxm+RAwXFtx
 zf24w8B1BtFB3hQKmC39JAdK+fLmT5Vw5Do2qA32k7MG4//9p3mYYvP
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=

From: Leonardo Costa <leonardo.costa@toradex.com>

The input bus flags set at each bridge's timings are never actually
added to the bridge state and are not considered during modeset.

Implement the atomic_check function, to allow simple bridges to declare
their required input bus flags.

Existing bridges that configure specific flags (currently the ADV7123
and THS813* bridges, which set DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE) now
write them to their bridge state, and have them propagated to the
previous bridge in the pipeline.

Fixes: 0a01de65a741 ("drm/bridge: simple-bridge: Switch to atomic bridge callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3fba7002322e9..848c2df2a276a 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -158,11 +158,23 @@ static void simple_bridge_disable(struct drm_bridge *bridge,
 		regulator_disable(sbridge->vdd);
 }
 
+static int simple_bridge_atomic_check(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	if (bridge->timings)
+		bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.attach		= simple_bridge_attach,
+	.atomic_check = simple_bridge_atomic_check,
 	.atomic_enable = simple_bridge_enable,
 	.atomic_disable = simple_bridge_disable,
 };

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20261001-v1-simple-bridge-atomic-check-e7b7eb8381e9

Best regards,
-- 
Leonardo Costa <leonardo.costa@toradex.com>

