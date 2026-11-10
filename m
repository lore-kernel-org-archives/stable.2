Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274138;
	b=RWFsikaJJwGznG4xBlEBnBNaFCa0PKQXUx+hcjPignBEwZDzMhkxZFDi8HgLAIsfJjgX
	 o9AF2lrPaGTFko34hc6166MJho4IUxq6h4iyE7kG3TrEnBDzP0lEOzjSmAlbdudUdogVY
	 Uk5iY19i+izPLpBSU3WyqIPRme89TgUroz/UehDeTbKE5TOhXWxRy8mEX+JpCLc+kLxfG
	 G0z5NEIvVO+3uwO3BuIGbMFqPErpvetZeusBnktqrOYjzLyyAUoTdAog0Wyd4zgXmz1Q0
	 K+avCxxl8c4uuis9HP7AzYG09oVGTgcBn6hWFhDwFAzcgQSeZtrfEEXG/ipjiA4+qeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t8l5nLF4hO8HRXALMstdamnS66KOJepBihFfIR1HUTo=;
	b=hZNQzs+7LdLkzBlzZSgMlrNCttbJSAriaPv4tua97DhS45LvjBmhC+auZRKMCb2poFkF
	 O4BC3yznaEdrmi+R8/RQbVZ3TPHMiRvQxok0Ex2ty06sccBVk5oEs9DrSwPWvhqQ4xz68
	 wDCKQijRJI+tGoVM3PwycuCTuhUS7ftnNz3v+uWo1BuWN4N7mxnWEm2A3lsI1Zx2tCt4h
	 t2SQL/sbYAIj3gOd7jLrmH9X48CFyGY5ToW4Wiz59BQHvxSbtC1P9VU3G8F7ppe97MEB/
	 umgjaImX4BoEVHwRzIlSHoLHud+OYyJWiHZkxJ3lB6Vn0FrtcdnUwsm18Kf1gS/u0WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WreBxbaF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76FE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WreBxbaF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4387D1F008A7;
	Tue, 10 Nov 2026 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274137;
	bh=t8l5nLF4hO8HRXALMstdamnS66KOJepBihFfIR1HUTo=;
	h=From:To:Cc:Subject:Date;
	b=WreBxbaF7Y+xixwdmsXR/pXliKEvtWcpaRnHVEdRICzotELqk7mHhX49O+PJSWTdr
	 gSojb1z11AJupYPKlnYz8hfM+w4lCyoPzD4JiJSSNr4nxsvC+yOmmAhcXw1aL/naV9
	 +cJ/gqgTo2zfsc3WOopVTxUKEDXOlakB6JxtJCiFYB5tQ/NocpWLI5r2Krd8OILu4a
	 QoN+K+6FqdNX/7a6mUUbM2TH9wpXbemT2FAmoRjlRi+s8uqM4jH8I3zZddhPTzbJQU
	 yTJqlfvBs1g4xaKMwatAWCtDuz0ahh/60of65H+6Syft6ZX0B5kRlDygC4giwLD3BO
	 T/ncFcmJ7nyuQ==
From: Sasha Levin <sashal@kernel.org>
To: renpanpan@kylinos.cn,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: Only enable HDMI audio if display supports it" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:56 -0500
Message-ID: <20261109202856-failed-5.10-0de95c96655c@kernel.org>
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
git cherry-pick -x 0de95c96655c8a12df62e47871016f49e5cd8618
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202856-failed-5.10-0de95c96655c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0de95c96655c8a12df62e47871016f49e5cd8618 Mon Sep 17 00:00:00 2001
From: renpanpan <renpanpan@kylinos.cn>
Date: Mon, 2 Nov 2026 17:49:29 +0800
Subject: [PATCH] drm/amdgpu: Only enable HDMI audio if display supports it

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
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 7de7adc8f225c..05d7da888f492 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1705,8 +1705,9 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
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
index 3c1d6901127d1..f0722bdaeab61 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1748,8 +1748,9 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
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
index a17944d5e8434..3f5247314edee 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1653,8 +1653,9 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
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




