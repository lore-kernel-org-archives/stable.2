Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280265;
	b=0XL8jvamF41eM7QROogUKJtBh0ix8dcfrOf7wlI0ok5CvMWwRHwKoLnoYiJjxnEzkEA5
	 Ux3JmXsM84tiCxHhVntQ77Gdj+Z5vveSF5tlZbMa78rK7FgGzZL7EvgyOSnP5S+9hj/b6
	 iyWQTpzWy5Xibk0PT8uJXjbRoVvbWkPAAVEUuSQ2PbpMWXIWktitgcPOqQb3PGY49n8jV
	 UQf+LqTVD8ZKBfIRrHkebwWAzAoDTISEVxQ85pHULk2TraRcHChHuJws5o+dV5R04JTWg
	 +8m8Af2obN4FVmygPBMH45L6Gx91ni20A8WqPRmNCfNeJj93C9upeK/B8wg+r3ZT6Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lpIvUpIATYfjqV4N0Dhd8VyNGnZCCKg7kXMo8kDG1cg=;
	b=sb6ZcKWhvIMwpRUWU6UyECYOs6nHboQGGYk3Jt2AF8rliWatFZlNKgM+a88S/KGP3bQk
	 rjg/nkOo32bKGFxnzbSrftoreERMqDI+Ed+Dh01DccqI08b24DLXNKYsu7TyLshjAGV1I
	 Z+mFI28lQJa7+sW8q51njeHm/Z5lmO1AeM/kaMSek9+2WTX80UJyVnIsc6YosDePs01+r
	 5Dq18c8DcWZPnwUOjjzOZmresv2UD+jNDxo1e8ZzGejDV/0XzSbWN+1g49rVvEAK2bEHZ
	 COQF9p4JxOf5HFs+vkbB98IBJECPIyNe2GtYdvrVzUMQ7pVetlhSX9uOSJWfYJ3wC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVT3u2cN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVT3u2cN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168B51F0089F;
	Tue, 10 Nov 2026 03:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280264;
	bh=lpIvUpIATYfjqV4N0Dhd8VyNGnZCCKg7kXMo8kDG1cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZVT3u2cNKCMKmJKsTw1i9Y7PXIe5ZCUnLFxQk1JdBNRtr0a0ki9dn6i7kHagts9rh
	 +CyXysoTavWC7Gpicr+tV3OBgjUd8TTlCxGZ/rmD4l4Ljuunhr+rcKgK8W7xuvBCCn
	 Sb8eN36zC3atnW5WGntQiF5DcK1erDLqKmo7V+2Rt0EneVcA84PvWhViuFYmfssYmF
	 g/6LI1uQ1oWWYn85ZdHk5+pOGWJyLhziTPse5QtOeIukkNIIzbP8n2IhwqZNSLfMV7
	 8RLbNMb1lLSNnfl9IXXDujUqZHmHBP7SenRTk9BTqbK3S86aqOcfVcx3L/Zerw6jCS
	 XsW4WbB5NmJAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Robert Mader <robert.mader@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
Date: Mon,  9 Nov 2026 22:11:02 -0500
Message-ID: <20261110031050.4118196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061411-failed-5.10-2ffaa7c40506@kernel.org>
References: <20261107061411-failed-5.10-2ffaa7c40506@kernel.org>
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

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit 2ffaa7c4050605cb27756f5336f778d1b21268b9 ]

The ROM early-return checks for PQ, Gamma 2.2, and HLG in
mod_color_calculate_degamma_params() do not consider the map_user_ramp
parameter. When map_user_ramp is true (indicating a subsampled surface
that requires post-scaler degamma via GAMCOR), the function still takes
the ROM path, programming PRE_DEGAM instead.

For subsampled formats the chroma channels must be upsampled by the
scaler before degamma is applied. PRE_DEGAM sits before the scaler in
the pipeline (CNVC domain), while GAMCOR sits after it (CM domain).
Using the ROM for subsampled surfaces means degamma is applied to
subsampled chroma before upsampling, producing incorrect results.

Fix by gating the dcn_arch ROM capability checks on !map_user_ramp,
forcing PQ/Gamma22/HLG through the GAMCOR LUT path when the surface
is subsampled.

Fixes: a8bf71649088 ("drm/amd/display: Internal refactoring to abstract color caps")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
Link: https://patch.msgid.link/20260814211816.1219597-11-harry.wentland@amd.com
[ sashal: Changed !map_user_ramp to !mapUserRamp to match the existing parameter name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 3c4390d71a827..9093ad7750631 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1815,7 +1815,8 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 			return true;
 
 		if (dc_caps != NULL &&
-			dc_caps->dpp.dcn_arch == 1) {
+			dc_caps->dpp.dcn_arch == 1 &&
+			!mapUserRamp) {
 
 			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
 					dc_caps->dpp.dgam_rom_caps.pq == 1)
-- 
2.53.0

