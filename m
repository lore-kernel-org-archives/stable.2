Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048053;
	b=isHO85orAljjcOiW18Nzb+RnCi8lL6KlUnJwAgiAjvpJ7r8aUqaPW6OeGH1L6EiQxBON
	 ydrRPJcn2UaTdnhpFoVj52x3OVDiWdHuDyUMbAR0gLMax1W0vXV9Iu9cNOlTEWy2P5b8x
	 6OxI0OIpeLYA7AwGa2wX7gKmqXn7E6VlTaXfR7tvmHWMTsOEaDIi1qA4PCA6Ku56yy21Z
	 JqCpsK7eZ4W81Lein9A7qWZSJ3GqBXnkLq8fIwPElhDa3azeVw7w3ylxSHKeER6ryd7xX
	 K/vu9g2o1ilrb6DtQ8K9wttDavKN3p5WI2VAe0TDkv0fQB+YO8u9hR7YJZk5JgQkNOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B38VgLw+lSbyzI6NFNwDcVdJH6JSo0WATfXLM+n5QH0=;
	b=jimNORwn+6UgsiOlc2B9pR9cZpEPwPGXcj7GnPv96Yw9SvidmSpDvXIKRmcIKtQLPQqV
	 drQnDpzPQtK1QNVGEvk4qESqByZlSGexdd8BuoXA+19oPjs3b1WK6HxlmKHufjrstw71u
	 7IXoJ/dra8opPSNCCS72MoFg9Ui/D2naA5Oz/kG3+fmSwKCZzKoeutUCFaUlNsBqavROt
	 Belq1K+3Anzjnqk/ng77f+4a5x+Ja4+l9jbloXiOfqFSqu27vUOWijUCox+WhYQZ5FTo2
	 nZMabt9fSyZ5LbHIb2ciEP9+7ysxwHcktSs3aGT5RVhANm5R8mi/MxztV5umwVeo9OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AlQ/hLv2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlQ/hLv2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FD81F0089F;
	Sat,  7 Nov 2026 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048053;
	bh=B38VgLw+lSbyzI6NFNwDcVdJH6JSo0WATfXLM+n5QH0=;
	h=From:To:Cc:Subject:Date;
	b=AlQ/hLv28vZPhob7dh1P1mGzdQA2GKOowY741DvBQjX8C8zA/y74kERQyii9ia1Fw
	 tahWnw1qE8JAsDEflfGhs7Sq0MY2KV1QgbdwHdnmBnRTSOMqsqe0CEQimechPTmAY3
	 Acu+Cm6gQi0HdmM0CVM6ju9Fwaatfjzy4Qt1hSMY/qkPU0gDgr6SzDp5Hh/eiQI1Ld
	 wTB8dPNQpndH+S0qvGdOCKR7DE4Cmh72e2aQuZj14qVqaXncKuUmk5Xs0SXsBXaLCX
	 Ri5DJT6trbqRUASTps0zOdg7tKiTIlgWyJ+04Sxd9sr+ByZcSskYljmJpi/ViYsdZk
	 ncriZY1KZA9ww==
From: Sasha Levin <sashal@kernel.org>
To: harry.wentland@amd.com,
	alex.hung@amd.com,
	robert.mader@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:40:51 -0500
Message-ID: <20261107054051-failed-6.1-2ffaa7c40506@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2ffaa7c4050605cb27756f5336f778d1b21268b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054051-failed-6.1-2ffaa7c40506@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




