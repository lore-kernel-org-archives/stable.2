Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284100;
	b=rg4wc4r5qaCbVy7NVjl/pixs3CdZEAo4yHtHJWf5Kr6/e0zJ91srBC8wvWGHYHyugz2n
	 KVVeQZaHmwxAABNWtiPPquz91folnVs9cBdT1rRWHab8pnxw64vATtvh1dqOBFhCLSm2U
	 O5cTtIMLLoTqBPxTOZKY+Y4YQNh8CBm2gc5J0GwBHhXmUlGzSXzPMY3YkYnRg5GKVNSjY
	 dvbFG6umzt1fpOgA2XDjCdXrp3avK9Z51KFlAsZLmV646FhBrQbdOhv4bz+mly2XFUY4s
	 VoYOH7iZQS2sK5I+LBQvcvSJgF+71r/hkh+WJIZiY5DiDHkBqrTqSxGs+/ScIVOUPYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0AP2dwxK4MusiI9zSZcE2L5hRHRtFL2+nXB7r7LjIE4=;
	b=qjYs91b5wgd0u57miXtQkHhdtZR5s68uSzUgLIjFFGuR+eISkrmPEsVHjpleoJEpGR+O
	 8IMDB3KToPmAPf1cxsmOWqpfb19HNYN1nh+QQzXfAMXCLLFlGJzI1kA/NkYqhdPPkoaKz
	 O1qWwaK/RxBpqFLJ3WUwmHA92lrvK79mXlN1VJdmAbVXfZ3q1gBDaZoZiE+o6O1A6rDfe
	 hVBhYAfCNGrwYGoAuKX/c/P4Q/6fjZ6JTIo/bKEqAzK4Aaz2u/5TnFFCWyrDUfT8UZ4hb
	 gFukDtZIXN3bxApoJIjDJ6Kwukoq8AuWMEwKClECisaj6RDdK1R7eVXFWyUfsymqWsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRHHtp8N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DA606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRHHtp8N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACCA1F008BE;
	Tue, 10 Nov 2026 04:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284099;
	bh=0AP2dwxK4MusiI9zSZcE2L5hRHRtFL2+nXB7r7LjIE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VRHHtp8NCjX7Wmp8KYfXkZx0JubKWs7MzEw3lwFhOrQJy77GUZu/FcDODfBS/sb6t
	 KT8oFD/Cp3wQKgaGB9sMRGEGtcswAL2gGgmih+9tuFyN33t66x3EXIQWYh+2UpcwEe
	 cheIBrnaD5vZ1SYs6V8Sz4uOsfuIOVmSFg8mH6HzvUlLQ+F9F49O+SeRgpE5D25Dxe
	 b3QH18l5/zOW0hPlibpbxIFZiAX5/2vhTxIHctKF4/U+olV8+0JwWcK0HqYSkYOq6O
	 Njcl6qoFGfiw0nBGviF7gymjijYUh3poT4ah/ltl/+9FwDXwnAI17xBAh0HeSTn2dp
	 75bDsCmFhIBtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
	Marco Mattiolo <marco.mattiolo@hotmail.it>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Heidelberg <david@ixit.cz>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
Date: Mon,  9 Nov 2026 23:14:56 -0500
Message-ID: <20261110041431.316108-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110041431.316108-1-sashal@kernel.org>
References: <20261107053009-failed-6.6-4eeeac9d7c36@kernel.org>
 <20261110041431.316108-1-sashal@kernel.org>
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

From: Casey Connolly <casey.connolly@linaro.org>

[ Upstream commit 4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c ]

This corrects the host initialisation sequence so that we can send
DSI/DCS commands in prepare().

Cc: stable@vger.kernel.org
Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Tested-by: Marco Mattiolo <marco.mattiolo@hotmail.it>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260908-ebbg-ft8719-fixups-v2-1-5454ae1f5581@ixit.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index 74b56ee42fa49..c97825177693f 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -233,6 +233,8 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
+	ctx->panel.prepare_prev_first = true;
+
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
-- 
2.53.0

