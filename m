Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050054;
	b=N95Y30T5evS6PAnv7u74CPgzKUu2FHZFbJ84JGepSEVs55yEGoXnK9PSLYlet/QDAOaE
	 +p9tJ3oDQNa5DSNq+3WlwtcKlEPvAxD9cuEfkWqSTheQSjC+uavIaCcp3EMzSqcfOZPNH
	 8eoSDWdqCJqfukU1yaoTTSumPWjdGL7jV8XuYuQDaarRgtl/ULabIW3Dd3aAexXGXcL10
	 5HE/lhH6e7MiSO++L5V1QZ2JsX2nmdpTClscj0tmgZiA84Ip8CaRX4i6OF0u00Z0UYVKx
	 3G0dIzmOu6kMC6PnPdmie3Ee9HKznh8H73g5Un+FNbVsW1kd/QCw3PTGLWHn/BTpQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5Luo58z9A2AaLu1Oo3SXwIY+CAuYqdEPQ/OHVStaFlo=;
	b=Cs+Q4d3gkvqH3x7b5LJYeGuJvClq2sNTI9deuPGqmeq1Fa1ARnZF4SDFgnW7J9IUinEa
	 huBOEZmozaMSp17G8zop9qz+9L8uY6jEi9iuR3uzk+Etmg9nSL8MDJOTaAcruWkmfc9Fz
	 gLd1Uz0lcaPcMiT12NsrPKdm+l+nvPHzA6v5JMAmcVbGAJyky/7VPjRICHZVMAJJuehyk
	 TTtFH5s8ZLcfSCxfPy67IrbdxZYA7XE1d66atK7RNW4ykNaLrwtwLlEaNp6vWCY9zwvep
	 4fnBGliZ9rye6Ycmr3z8gdKyoTP7ud/Sd/g017vOoNT9eA63L8QJkMVUiEaritB9YhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5mnw67b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5mnw67b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D33D1F0089F;
	Sat,  7 Nov 2026 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050053;
	bh=5Luo58z9A2AaLu1Oo3SXwIY+CAuYqdEPQ/OHVStaFlo=;
	h=From:To:Cc:Subject:Date;
	b=e5mnw67bhDat3TOHE47qM43JDpXcrEKEMxE6MS8brehjrFCbKg4IrYpDsKI7lF9Vs
	 RaUNNHQWLQ2TzxCrhJmkw1nvmQoCdwfsIyajLhSQ6+pBHLHGyf6ezwbRqvJ6Yv86Wj
	 C4CPiULBvSZ+KBhbdaJUXtrUonWgW/ZR8biNBQCFGeDN4iAy+LwlidSkKDEI5sMLf2
	 4adVsgZKRZit0jCwkZfhXvTa35MXmbp2rlPVfMy1uatQVWftBBlWs7/UIOA4yvdD93
	 AkHxm77tKk9PA92TqFRI0zgfRrer37ReWabcdR0Bf3KBVZ3GjhMtsAvPSFJ8kkieKP
	 0EA59vGMfra9w==
From: Sasha Levin <sashal@kernel.org>
To: harry.wentland@amd.com,
	alex.hung@amd.com,
	robert.mader@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:11 -0500
Message-ID: <20261107061411-failed-5.10-2ffaa7c40506@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2ffaa7c4050605cb27756f5336f778d1b21268b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061411-failed-5.10-2ffaa7c40506@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2ffaa7c4050605cb27756f5336f778d1b21268b9 Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Fri, 14 Aug 2026 17:18:16 -0400
Subject: [PATCH] drm/amd/display: Force GAMCOR for subsampled surfaces with
 PQ/Gamma22/HLG

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
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 03d88e78165d5..5786ef5787ac6 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1696,7 +1696,8 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 			return true;
 
 		if (dc_caps != NULL &&
-			dc_caps->dpp.dcn_arch == 1) {
+			dc_caps->dpp.dcn_arch == 1 &&
+			!map_user_ramp) {
 
 			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
 					dc_caps->dpp.dgam_rom_caps.pq == 1)
-- 
2.53.0




