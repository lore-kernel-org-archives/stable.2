Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637475;
	b=iFON1144w1zIDDvPCdACzLDsDgaQOrbtLcNaaJZdgqRWIU2XxHTFILuvSbRRfnICS4Dh
	 j8DrA8UA/A9IpX0ug6437+sL5EtLH5EeyGdbqTEREleneUQDmsZlv8kqEZ2xQS0h8bbpy
	 KJrPUpbKVneU0vOSpZ7v6X1x1t43IMXMovGhfxxVqFWczvxNx24Qf0hGxVaKCO6UHHnNo
	 LnI3TlY8pgCVSNcFQM1DVMOdjaXZ6aEBzF7ZXflolcaxrl4Arqw2lB4fRqaPHA08cEwle
	 m1p6gwi3+4uvVUWgFKtDrwUQdsduwpvdEvSFHSb6WVzLI4qYoCgThy6kiBRhhMt7ShA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=duduH1+m18Rqf7GcSTyJTCvLcEe8gwkIwgqF78GK3LM=;
	b=KztLW2JGPbkkYQN3fiuVe5tp36rZCZmHnYLaJcLi3YDVkY1OiTqwyk9fpSnIypZzwVr9
	 IEi4U+XYuSt4wrw+LV5RpETvFQRuBKulCF1+nTwh3qDgOMpMlt7zZ2yuuXFKb9+pLUTfp
	 eTHGOfMop/OVeO4qTrLsk/u9ouRe2Yy850wSdKdiEtU+iNMKrsM3A8YF154/JzCvRs7wc
	 vjG9hvuBYhsFMemCVlYH8GPwpEezrQhUcGtLCfYvunkxcwPK+GiBl29ttsL4WjAq3qyE0
	 qEjQrhqddW/YkmKECpTRmKWtO9ubnqo0BI472qt1MzwmtFWQoGLt428+1qZ+GhckUQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jb9Fvg0h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63A606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jb9Fvg0h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FAD1F000C5;
	Sat, 14 Nov 2026 06:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794637475;
	bh=duduH1+m18Rqf7GcSTyJTCvLcEe8gwkIwgqF78GK3LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jb9Fvg0haZ2imFg5ZYImYuCCIzsw01UucmcoHO6X8QLfFpLh7IhACY9Tom8NoMJjM
	 wPFv/jtPjvDWM0uH0Ts7JiVon0E8/fU/F+5MMJbdQHkZcFRNgRA1P2UscnKtxKV1xf
	 OvS5qy6nWVh9QfVNPoUInpTSf5Bze06xVNPc9LqFZuJH9CbBBoDtotpOzdOyjetxmr
	 GAOfkenA1TyQclCtbSsoPUFJYTRvIbMEUc33npcPaZktbgqgQpYokRygdZwd8EPYTz
	 Cww3Jr1rYorl6vtrUZMESUNJge+6mpWkooJ0WtSbck3T1cVvBWQMH2r+JMwcdJQ5/6
	 nGvzIOQ3A/stg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: renpanpan <renpanpan@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] drm/amdgpu: Only enable HDMI audio if display supports it
Date: Sat, 14 Nov 2026 01:24:31 -0500
Message-ID: <20261114062408.3188357-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114062408.3188357-1-sashal@kernel.org>
References: <20261109201928-failed-6.1-0de95c96655c@kernel.org>
 <20261114062408.3188357-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index efc85aa157ddd..95a31e959cca6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1738,8 +1738,9 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
 	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset, 0x00000001);
 	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset, 0x00000001);
 
-	/* enable audio after to setting up hw */
-	dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it */
+	if (connector->display_info.has_audio)
+		dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 6376a252e3f07..736bdeeb2bdcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1702,8 +1702,9 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 		dce_v6_0_audio_dp_enable(encoder, 1);
 	}
 
-	/* enable audio after setting up hw */
-	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it */
+	if (connector->display_info.has_audio)
+		dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index e93931655243e..ed52451f3b74e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1667,8 +1667,9 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
 	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
 
-	/* enable audio after setting up hw */
-	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it */
+	if (connector->display_info.has_audio)
+		dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v8_0_afmt_enable(struct drm_encoder *encoder, bool enable)
-- 
2.53.0

