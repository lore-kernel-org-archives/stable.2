Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278090;
	b=xajbtt67EiBuQeAsOdbwC34aGSz+Z1WhAdzfKAEx1XhdvOLg2a0Vu0kahQQOneAvu0S+
	 A3H1pohDjfvzhHyrQtMS3Z24tYtbiWoI3lgOueY/j2CtY+nPCrqEiTq8SjUkFmk0exubu
	 FnY323mysqwtEETF2CzYJpdByVFRD/Hw7C5L9j6WIvwzg+61AMwOC2LiJ1E5Qo1YNkmdF
	 itvd93kTW/FzJe51upZHVrcKyVsK5idDsxhRMu4HTmAighgxqzF27PCnev1xyjSaqkdNb
	 83Ar8lUxgPau7fVBh/EnwmnHv3PEP4bUww8rrUtivhcLdGkt9Bcu+366wZD0xw9abqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278090;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l9iYhVyrmWgmkQIune/FDANRiKoK67tNTavZ8riBSu0=;
	b=rLfpQzX2EEQktXbfclt03e/CNJeSwTtO7nrb49PpGOmbtLHPYKvw1SebWYAIPvFQBAK+
	 ZsIyhLt/wUA31l4ShcjnMywgJGevbtodIrAWmcHNvWNH3sicStn+Mog4VFpo8tNMfahcr
	 vThU5hMxAQgGOzbX4vMy8q8biWWiWpqM4yPi0eaLAmHZzxfxPuyNUPgJnnm/j0JdEGFI4
	 iDx4HhFqo8zgPL7elNuZiLKHP7R7h6xKUuKQeD6UnApCf1HrBpU90hnHbQpLKetIi7AP/
	 gdZtGF/QduJMM1AlxiSxer3g4QNcLBcC8XmlPLKr4/v3w43ISm0WQ/5L/f1TtmLqWkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6PBrkts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6PBrkts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929C31F0089F;
	Tue, 10 Nov 2026 02:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278089;
	bh=l9iYhVyrmWgmkQIune/FDANRiKoK67tNTavZ8riBSu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6PBrktsiWiVhy0+Ra3SqeiipXf1sj4kzL5RxyFq/crtFCEyzfKVsnNXjASN4mpsn
	 BfkcJWMzq4OAmLhtZ0JWc7UtgGEGvZ+8xQrA+RayGtWTT+BPBZBFqYLnUUtkIiVspd
	 qWUQSHNYBKvCrSHumHRQCZLiAqGsbewC0b3APwmi7doYGNmc17uFfu+1eHE9Ow4Mjw
	 dRulc+kuYlqXgnnoCqXSbmFg7HEVPH35VkEZkbYQxgUDMy47mIDSQTuoj7gFtm70hr
	 dcJKY6uxe7GDKfhPXlO0UVzzvEjmadzEfmt+7sbFgQmeG1xZIGLq0zccuXtmo8cLW1
	 c77KEJXd/adFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Robert Mader <robert.mader@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
Date: Mon,  9 Nov 2026 21:34:47 -0500
Message-ID: <20261110023436.3814185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054051-failed-6.1-2ffaa7c40506@kernel.org>
References: <20261107054051-failed-6.1-2ffaa7c40506@kernel.org>
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
[ sashal: Used the existing mapUserRamp parameter name instead of map_user_ramp in the added condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 447a0ec9cbe21..b6ba7d14bd8cc 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1900,7 +1900,8 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 			return true;
 
 		if (dc_caps != NULL &&
-			dc_caps->dpp.dcn_arch == 1) {
+			dc_caps->dpp.dcn_arch == 1 &&
+			!mapUserRamp) {
 
 			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
 					dc_caps->dpp.dgam_rom_caps.pq == 1)
-- 
2.53.0

