Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279005;
	b=Jo6ks7ENAL3NVYLXhCoW3yBwq6Y60VhbKOA8mGQNOgL/9FHPvXI8qXtJ5aVllI5eE7De
	 9amIz3S8ownbigHtGRgBO9wrdj03OilsEDvChzW+AMFf1bV1dj/EnHzQX5M6NgStNPky4
	 er79EpzalTWiceMJ6D4YRp0xWeWF84TYEvKBjPWgqssxZvq33nio483FCFEdo2RvKVmD5
	 XbJQAFUPAjcLvUH7k456IO4zgXUNzKffSYLqXyxE0OTiXqxw1j6QGUza1nhaHPlq2gpLv
	 cBvj0ntAdJp4bzTu1e1wdkXXbjNGLVujwv9eD+IIpInqOhZqOJrXOwv2joqZ7InqxMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IFOPjJBQ7yGz9hzxPQvxIyt5YpJ/QpsnTgAP3TaxHcs=;
	b=b1i5z41hxfmu32Aoa7RjALBNUXoOvZveEn5Z/s0z3j5QiAivnC8Figa/Hb4XgPepp/em
	 sOAkrGsrpIaBZ+3AbdhNaKCx2CAz1rW7xPXnBcqXbs3a7+HUAaHjppxpkhNB5g7C9zPok
	 FAbvOeoT2uLcnW37IkGDCrP9HUPIJLhXbM0OlbTEFfjWQOQXmnf74G6DuqDAJo2jiG/g9
	 LDDS5mLWgXxA0XfPJ7l/wT8J6bU4dj1Li4F3pqQfVSrCQ7dzgtLCVkMKRI0mkymKomfYt
	 /Sk2vMQq7Vn8alAtlhDHsDErINB+OX3n7S6wOr9hjHBacq6zGdCCy63/gaE0UUqOfNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXlb6M1t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXlb6M1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251151F0089F;
	Tue, 10 Nov 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279004;
	bh=IFOPjJBQ7yGz9hzxPQvxIyt5YpJ/QpsnTgAP3TaxHcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXlb6M1tFSkCLN/FwJ7XBEvg6xuarPIS2WGKRweM2d2tNPdl6bqJNNqmuo1jV9Jvh
	 pWrXbIVm9uwxsVLcRieFofbcpVrE25ws5BIwASHzRux80SHwl6a9/5HRHoQX5QefUY
	 KGEWRiBXH8VLlA/Glc+eIVVauDqG/uOrpHI9kk6qK5+82X9egHXjtER2ypDusR5vPT
	 kvn0yLWAKGx9he+XU0EoU63oi+UNb9FmOgxmA351U8+sm9Atl0JnjCxnMHK5JsFmwT
	 6nc6fRY5nLXr/PsVu89MN+soLZA1dA30Yad58I1pN+vQYqpFWa2/D+DVCAyC9tjgM+
	 i3mwLjls8cPFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Robert Mader <robert.mader@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
Date: Mon,  9 Nov 2026 21:50:02 -0500
Message-ID: <20261110024937.3859056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055703-failed-5.15-2ffaa7c40506@kernel.org>
References: <20261107055703-failed-5.15-2ffaa7c40506@kernel.org>
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
[ sashal: Used the existing mapUserRamp parameter name instead of map_user_ramp in the new guard. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index c707c9bfed433..7ffc6969afb4c 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1897,7 +1897,8 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 			return true;
 
 		if (dc_caps != NULL &&
-			dc_caps->dpp.dcn_arch == 1) {
+			dc_caps->dpp.dcn_arch == 1 &&
+			!mapUserRamp) {
 
 			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
 					dc_caps->dpp.dgam_rom_caps.pq == 1)
-- 
2.53.0

