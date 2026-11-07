Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049025;
	b=rYm/5xVe5SEE8G5U6/z8TJTdVbPgXf8ufm857RL6go/SgbdkPCuUgmtv6bl5FkWJQ4EK
	 Zu/UszGPs/arw++yZzJadihoqciIKI8ITViSB/P1fookkSrR5GRkajjSvxn/5l3+1wWOv
	 WmKyGvUi0UDOB4zG877ltcKChqH28W0G9LZ6+F5PkKMAbXzIA4f4i/+zV6CgoFpszHB/m
	 g0gUOfIp5wthw0XjRsNx+2PBeuTJVs4NqVZc8Y5oDz8Jx4kJgAeAXzL7frTrxxU1njeiN
	 veDm6MujwjEWR+ZIieyT+rFh/RNhnqgAqec+jORYqZykU8nPzbdKbJc4qk0KZqbsPqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jbjoOzVVmDa3ek1nFdAza/HDGovN2YJUoBb32GieUkM=;
	b=nVAJ3z1fyjJ3b6nrwJpX8+125M7vwhD2QYP4ytINuYCbHKJ7EDhF5NCEH/9aHsxJel5v
	 uoui2zF/TNvS319Gk17ZQ0Xns6PMD1joCx/VPlaLjjMOvEPxfCj0jTc5wopDjexbhXlXK
	 C2Q/F+Q7Lk62PxuZLZR6ZvG4HSifHVYWgzpqH+fkZ6mRnQJg9uNAMauMI58jcKMoY3zMG
	 U6CfdIS+yd51uNEIwJ1brnCSV+FTErZd3Kxd3GawnHDTEtfHQBUZCu54r8GWcN8qhAMU6
	 x6wUjnkDHxI0jNQk5zMBW8MqcKyWB1XAs9VyN+eMllcljRpPbjcvjLdZb6HFdSRF1Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmFvMvbM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmFvMvbM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E202A1F008A3;
	Sat,  7 Nov 2026 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049025;
	bh=jbjoOzVVmDa3ek1nFdAza/HDGovN2YJUoBb32GieUkM=;
	h=From:To:Cc:Subject:Date;
	b=bmFvMvbMXJRcK+6ZtMCgYiuNgJopwMNaC/5GGy1DWSCVBO76jLZp3m8pjZKCrXFoM
	 WvCcow/5Pt71EWUinkq8q+0bS8fk9Zbg7+d3rb8m+DGPqY54zT6Moky9Jt5QY+3tGz
	 0EXDleisn65O64HPlqviqve1MJrlDjeUq6hkZXxGU6oNo0B5VbG8On6lIBxUZXTQlX
	 eZXMRfl2or3nKodWD79CL+DbI3j5TGYXsulPlmi1X+cIjqlJNnDd6qPb1r8Q+tl7+t
	 m+eMD0GDZITX5d4odlx4ZQpWZmGfL6ZPxgqpnDutL7hLken9dUDwpAlzu+Lbx45ZxE
	 hSj2s+R5WSGXQ==
From: Sasha Levin <sashal@kernel.org>
To: harry.wentland@amd.com,
	alex.hung@amd.com,
	robert.mader@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:03 -0500
Message-ID: <20261107055703-failed-5.15-2ffaa7c40506@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2ffaa7c4050605cb27756f5336f778d1b21268b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055703-failed-5.15-2ffaa7c40506@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




