Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644297;
	b=avZbghd0htm7LsquLRdsujIYnQpB8nrcjxAKfVyGrDJ7H7g2am5orAKbhVRUbRAJvYEm
	 Ow0yIHRWgMwCmGkhJzoViaw2016svPWhS9P6nQ8FPoPfIojYbWXCMBd/KcKmfH9+xWaOe
	 cz7fhbqb+7Vy+QztCAZtVSHEYuksqTEDX+gx1kU4Oytpgvj+4afxewVy683w5RoGd3Fad
	 y585keI4iGrnPWjQGu4wur+tBJTXkwjmsUQ0VwFhjAt5CZU5kfCUe7hYAYCCe2dKcqoE/
	 Dh/wk4SbBTG1iYLr9ibX2jJoTUzdgYv2AtyWia4rK9Tx7U5+p12sCUDZNubZil2WDtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644297;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NnEgsddM4W+Eyr+NniuTrlsHi4HY6T8ojmFWHU8PvQE=;
	b=scnfTLNlp2ThQblqW8c2AKK7nIv16whDM0z4++yoqXtkBE25bf63A+2tVpnwBu4SdqU1
	 8iKA3M0uH5QV/bX0FLnNudw9C7igRnzCd2t8LO+Dw2FnrATxpVVi0slWPxhOKMke1/Q6g
	 yomDaEE/0TOCXERAHf+ePZYZT6pOQZfP2VeFJdNchsv54VxRcWOktma80Jc2mRFjvTmYf
	 x0SIJb+3J1J3Cz0pkMjhy294BuWZ4eBUJbHskPZy5TMvkjpHGUIjimPJ9lp4Os2S8eKZ2
	 lnKz7J0eSOmh//aUkJMU2XPp1qu8lLIKMin9x5NQzJRQFlfqVpfCKGYONEEX4rv0LOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MX+TSpHJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D02606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MX+TSpHJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9411E1F000C4;
	Sat, 14 Nov 2026 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794644297;
	bh=NnEgsddM4W+Eyr+NniuTrlsHi4HY6T8ojmFWHU8PvQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MX+TSpHJs0xAzTw0I5dHOiwuA4FjhsKZMUDwuUUXoa/toIZX9NWtnUuCW5judDr4F
	 kA/ESyIYtjKH9yomN5MUABib2umRNeSb/jhHLuflYDQt59X+pXb70sdxFj3RrkSgZM
	 o11/HuLoalFBDz40FyvNfqRCSleH8FpMPB+n9HESQnYFt9oYDstWVpewSkkjJGu/aH
	 Kj0DzqaH2YOyXmht7oScbAyH7e33/hjDieJNDibV+xz7yGeFf7wijRUpXzFw+4IRjl
	 D/2qw9O/uHuDTojArayprLpy396/abR6pI2KEXaikZJL5eg5r86PXNYPEg3h3h6xUr
	 BKkAk9xgyrfig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: renpanpan <renpanpan@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: Only enable HDMI audio if display supports it
Date: Sat, 14 Nov 2026 03:18:15 -0500
Message-ID: <20261114081800.3251353-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202856-failed-5.10-0de95c96655c@kernel.org>
References: <20261109202856-failed-5.10-0de95c96655c@kernel.org>
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
[ sashal: Replaced connector->display_info.has_audio checks with drm_detect_monitor_audio(amdgpu_connector_edid(connector)). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 72fc5eaa251fe..48d3bb0ac702a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1737,8 +1737,9 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
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
index f81a10379ed44..9448cf949a497 100644
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
index aa21354ca122b..5af2bcb746317 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1666,8 +1666,9 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
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

