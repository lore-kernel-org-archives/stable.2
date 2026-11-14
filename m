Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640913;
	b=jKzF6r5bBNGSbzSF3qyxIqEG7FBlzzBN2xB7G5zOs0tsgw6be7OvV+5VBL437ffMDe4i
	 0LN3WIYfVmKnB+9lwh8FrlpWviGzU+wCszAkRKTRX6zcvcEEMIwyjPp9l/6f62mVp0OyI
	 mwFGs/23BRKmqwz45PRy4coz+3QucC5cQsIZxE1RRT3Ee3Eictx/TAwuBq3XwcPR7rpmn
	 LOT0D0bg1uKi4BcXjJsem4fzgRHOmmf253RXQm0/PPfSaSI3fKiAkm+aK/ZiWddMIDYD7
	 Ae5uQxhtSVej9xGXkexsB0WJW+hlrMYExoiL6IESswI8ZBEwxmmfuaJ2TzDg80Hk5Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e/1h3TRUoPe5w3C/cUUxtBoA+L+aWqZ5paqVgP/ZCnk=;
	b=yqf+ScnAy/W8qvyeoPTYiahR1JWR6kgDP5TGBxwJ1o1drTgcw1zuKQuMzc7RWaoZFkEA
	 HbO3SMPaAj9eNAIlI0poLF2iPznJm/x6927fOCHPv/i4SUCdqa9SuDdqbsJ6Q2AQO3iTq
	 a9XVCy7DYlMWKrGK2PaO2+D+iosfW3SYinZUrEUPvWC9/amzfe27pAsYVevEj/NqcwMLd
	 T/6522nWdROcn8Td2ssMnjCU1FbrqCUT6QTfr3eFRoPE/KEnEzGSunTRsWHiR23JKqo/1
	 v8A56baIeDHSqDg4djcA7HG2KAg2xrITJs4M453U96S0h74/q+Oz2/hJMBKAmQ1XI8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=An8wNdYt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C541606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=An8wNdYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DAC1F000C4;
	Sat, 14 Nov 2026 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640912;
	bh=e/1h3TRUoPe5w3C/cUUxtBoA+L+aWqZ5paqVgP/ZCnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=An8wNdYtxlE8MMEQdFcEY9lOxIu+caYRmIYu2hP3XbSyLc2pLf/h0+YvIPXAoOBnx
	 Ef1GHKyHoHHiJNgyIxvIK8nRFR3zWCM3rgMOyHMO+VLjogBaT27/sGQwQdhXJ8AQlS
	 VgPOjS6lunXs62tC+8qn0ssb7nrptnqY/z64yXufO1dOnwJSDN7q4qr0vlYaOVWIJr
	 my2+yRttzn2xXEcRsRrIPZdhxm9foLxjRF/h0uTlQtJww8pg5THHZmutSG0stxx/da
	 nbU097c0boac4klsvMz1yW82pchAixX4udIUnxZaeQuX0yeQcx9EBFGiuHgG8YbxS0
	 cS1IciyV8SWrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: renpanpan <renpanpan@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: Only enable HDMI audio if display supports it
Date: Sat, 14 Nov 2026 02:21:51 -0500
Message-ID: <20261114072136.3213626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202431-failed-5.15-0de95c96655c@kernel.org>
References: <20261109202431-failed-5.15-0de95c96655c@kernel.org>
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

From: renpanpan <renpanpan@kylinos.cn>

[ Upstream commit 0de95c96655c8a12df62e47871016f49e5cd8618 ]

The amdgpu legacy DCE audio path (dce_v6/v8/v10) unconditionally calls
audio_enable(pin, true) at the end of afmt_setmode(), regardless of
whether the connected display advertises audio support in its EDID.

This causes a phantom HDMI audio output to appear for displays that
have no audio capability (no basic audio bit, no Audio Data Block in
EDID), because the GPU sets the AUDIO_ENABLED register bit, which
drives the HDA codec's ELDV pin sense, making the codec report the
jack as audio-available.

The radeon, nouveau, and dw-hdmi drivers all gate audio enablement on
display_info.has_audio. Apply the same check to amdgpu's DCE
afmt_setmode functions.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: renpanpan <renpanpan@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 842a45c68e0355eea47796551c8761c0c77e8ce0)
Cc: stable@vger.kernel.org
[ sashal: Replaced unavailable connector->display_info.has_audio checks with drm_detect_monitor_audio(amdgpu_connector_edid(connector)). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 0b872bc71b70d..d77daf89a9dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1738,8 +1738,9 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
 	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset, 0x00000001);
 	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset, 0x00000001);
 
-	/* enable audio after to setting up hw */
-	dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it */
+	if (drm_detect_monitor_audio(amdgpu_connector_edid(connector)))
+		dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 5e21eb88b2e71..429c97751e5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1702,8 +1702,9 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 		dce_v6_0_audio_dp_enable(encoder, 1);
 	}
 
-	/* enable audio after setting up hw */
-	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it */
+	if (drm_detect_monitor_audio(amdgpu_connector_edid(connector)))
+		dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index f3b0642f9d9d2..dc72c04d9b7f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1667,8 +1667,9 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
 	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
 
-	/* enable audio after setting up hw */
-	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it */
+	if (drm_detect_monitor_audio(amdgpu_connector_edid(connector)))
+		dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v8_0_afmt_enable(struct drm_encoder *encoder, bool enable)
-- 
2.53.0

