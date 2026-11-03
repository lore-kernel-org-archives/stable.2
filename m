Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686328;
	b=vaDwLqIsr7VeAgcJn5Cg0zEB2nmmRGkov12XptgGuRxSyPbfx5uv+7htzNUa9PwTzdHs
	 aLvwVeoGUrc/In4aW9UrqU5tve8OwOpF7PI6lbxS3HFPf+QAzk76aTFH6udzz5R5cY3Wu
	 FgIjw4aorWRX1aaKKPRt/EIhx9nfrvXoyvK3x5fTKsaOYw08uqSwzIMN8Ea78Z8o7pnu1
	 UidQGObKEs411O2YFw8p+Ki+N74nQ5IIIMu8rC43Pxi50ShqTREBT29XLzg31USFN+ygi
	 Q3suRvQijEH0zyQ+vn7KNkjFtvHSRdo+ptK+q95ul+wrMbKMdPrsTfUb4R0twA8xiLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686328;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EV6xUMIny+0/roh11Cz1aUY61AocEAzZNHRhZMUNO6I=;
	b=Of9nhNsOTecktOe2KBgy339MytCEEdhbojfhoAfyH+xd+BbnVn8yThcRRvPfEyCCzGC2
	 VkN6wh3epkGUWrv1tJRdl02hppLjvurAKA6U+GYNyF1jl7VguD/SPbnKH0UIsF94pPtJb
	 Me/iUhTPQcqRlDH1biwFwfj8zBYBjpLZOOEczM5cUJVZOgWDGMnE6voowgEIOMl4JKvmX
	 A33LW35mSWLT8KCPpplHfbey04f+rqNaZli7aWvonWSp+SielHEtGYkR5j0xWK885WgLO
	 f+XDEAdPkj4emOl9uIlD51dRbTn9574TzQKyGbZ/LVAiV+ygqf59Y8zhZ2PN2y+zaUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39B606A32C;
	Tue,  3 Nov 2026 06:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C39B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 76fada00d74d11f19a56ed5b684f684d-20261103
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:89b157d6-0d15-48e6-8cce-d943b1c9b7b6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:e2d414d4ba46bc06c38168d7211de994,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50|99,EDM:-3|-
	100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76fada00d74d11f19a56ed5b684f684d-20261103
X-User: renpanpan@kylinos.cn
Received: from pan-u.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <renpanpan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1980694091; Tue, 03 Nov 2026 14:11:53 +0800
From: Panpan Ren <renpanpan@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tzimmermann@suse.de,
	timur.kristof@gmail.com,
	lijo.lazar@amd.com,
	renpanpan <renpanpan@kylinos.cn>
Subject: [PATCH v3] drm/amdgpu: Only enable HDMI audio if display supports it
Date: Tue,  3 Nov 2026 14:11:47 +0800
Message-ID: <20261103061147.25827-1-renpanpan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

The amdgpu legacy DCE audio path (dce_v6/v8/v10) unconditionally calls
audio_enable(pin, true) at the end of afmt_setmode(), regardless of
whether the connected display advertises audio support in its EDID.

This causes a phantom HDMI audio output to appear for displays that
have no audio capability (no basic audio bit, no Audio Data Block in
EDID), because the GPU sets the AUDIO_ENABLED register bit, which
drives the HDA codec's ELDV pin sense, making the codec report the
jack as audio-available.

The radeon, nouveau, and dw-hdmi drivers all gate audio enablement on
the display's audio capability. Apply the same check to amdgpu's DCE
afmt_setmode functions, while still respecting the AMDGPU_AUDIO_ENABLE
override for users who explicitly force audio on.

Fixes: e2cdf640cbb5 ("drm/amdgpu: add display controller implementation for si v10")
Cc: stable@vger.kernel.org
Signed-off-by: renpanpan <renpanpan@kylinos.cn>
---
Changes in v3:
- Also gate the initial audio_enable(pin, false) to avoid touching a
  potentially shared audio pin when the display has no audio support

Changes in v2:
- Respect AMDGPU_AUDIO_ENABLE override for users who force audio on
- Add Fixes tag and Cc: stable@vger.kernel.org for stable backport

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 12 ++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index f2977fe6d824..a8f5eb2394c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1555,9 +1555,11 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
 		bpc = amdgpu_crtc->bpc;
 	}
 
-	/* disable audio prior to setting up hw */
+	/* disable audio prior to setting up hw, unless the display has no audio */
 	dig->afmt->pin = dce_v10_0_audio_get_pin(adev);
-	dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
+	if (connector->display_info.has_audio ||
+	    to_amdgpu_connector(connector)->audio == AMDGPU_AUDIO_ENABLE)
+		dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
 
 	dce_v10_0_audio_set_dto(encoder, mode->clock);
 
@@ -1705,8 +1707,10 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
 	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset, 0x00000001);
 	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset, 0x00000001);
 
-	/* enable audio after to setting up hw */
-	dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it or is forced on */
+	if (connector->display_info.has_audio ||
+	    to_amdgpu_connector(connector)->audio == AMDGPU_AUDIO_ENABLE)
+		dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index c68de0fe1d7d..3cd9f1bb3a70 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1724,8 +1724,10 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 		bpc = amdgpu_crtc->bpc;
 	}
 
-	/* disable audio before setting up hw */
-	dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
+	/* disable audio before setting up hw, unless the display has no audio */
+	if (connector->display_info.has_audio ||
+	    amdgpu_connector->audio == AMDGPU_AUDIO_ENABLE)
+		dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
 
 	dce_v6_0_audio_set_mute(encoder, true);
 	dce_v6_0_audio_write_speaker_allocation(encoder);
@@ -1748,8 +1750,10 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 		dce_v6_0_audio_dp_enable(encoder, 1);
 	}
 
-	/* enable audio after setting up hw */
-	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it or is forced on */
+	if (connector->display_info.has_audio ||
+	    amdgpu_connector->audio == AMDGPU_AUDIO_ENABLE)
+		dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index c3906270f25e..eb1fcf0b39cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1523,9 +1523,11 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 		bpc = amdgpu_crtc->bpc;
 	}
 
-	/* disable audio prior to setting up hw */
+	/* disable audio prior to setting up hw, unless the display has no audio */
 	dig->afmt->pin = dce_v8_0_audio_get_pin(adev);
-	dce_v8_0_audio_enable(adev, dig->afmt->pin, false);
+	if (connector->display_info.has_audio ||
+	    to_amdgpu_connector(connector)->audio == AMDGPU_AUDIO_ENABLE)
+		dce_v8_0_audio_enable(adev, dig->afmt->pin, false);
 
 	dce_v8_0_audio_set_dto(encoder, mode->clock);
 
@@ -1653,8 +1655,10 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
 	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
 
-	/* enable audio after setting up hw */
-	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
+	/* Only enable audio if the display supports it or is forced on */
+	if (connector->display_info.has_audio ||
+	    to_amdgpu_connector(connector)->audio == AMDGPU_AUDIO_ENABLE)
+		dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
 }
 
 static void dce_v8_0_afmt_enable(struct drm_encoder *encoder, bool enable)
-- 
2.43.0

