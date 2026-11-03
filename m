Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677172;
	b=HlNui6HSpap4zB+nF74El/yIYhdpQSwEnN5aGTJ9LmId6l2mR/KD/enHYV5WsKifrhxR
	 tQT3h4JL8AvItQbps2hjscvmWwmN8/yELXAxlGwfDzX6KsYJoSooHAxjB5v3AZCAQrES6
	 /l5ggfXmvKFbEAh0Cb7SBAIuAR9dfiw2Z9zTQ6HInir+1Y6mMFjlLMpZ1bkhdbZzW0zYm
	 EZ5BcEI64NYm0KDQNOyXPLJ6Fe5Hw9Z6+uFmPdKD50FSTzFudcAYqZoCQzPn6cp6RAWtg
	 9V6yqw4pqx4B6jMC0+WNdV49ZzSDrpOByR3+lY46NmT428kB5GFfJ3eJGJQvRPVBgmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677172;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YZVBEEsPFieX2jeMu5OYk4pMc5AV5iGB8JphOC7c3So=;
	b=x2wqhVpLxj9gM8vBiWs810JvY+/JXXLSrbcwZQZoZo7GJ59VU0ja2VlqPRWNSafbLiHm
	 iNWXSXxYHjaoGzBY7Yi8Lpmhoo38jB/2oLbfyb4NePo1RBy40B2Mba4tUHMdmdrAVzl8H
	 tiwukxZZ8beba7at5s7VU1j36beNgWp8VxCiwryqvMUZzkZLePoKyjIQOwACqqkWA0lWH
	 9iwu8FFWUYLUJPBSTqweSQ3YLJ+QCea4koSKRhvjtE70saxX6YdRwzY6L7aVhbjY85KdL
	 yIk8aDUHthRyEE+gga8mvL2kYsl6zMZB9UEW2msrcYbQL1gOWQ386fy4uOfR8WjpZxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DF606A324;
	Tue,  3 Nov 2026 03:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86DF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 281454dad73811f19a56ed5b684f684d-20261103
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ecb3a3c8-eaf8-4617-af50-d71875fdc371,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:880c317100a5532b2ae2cfee77cd42c4,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50|99,EDM:-3|-
	100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 281454dad73811f19a56ed5b684f684d-20261103
X-User: renpanpan@kylinos.cn
Received: from pan-u.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <renpanpan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 19653449; Tue, 03 Nov 2026 11:39:21 +0800
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
Subject: [PATCH v2] drm/amdgpu: Only enable HDMI audio if display supports it
Date: Tue,  3 Nov 2026 11:39:14 +0800
Message-ID: <20261103033914.21660-1-renpanpan@kylinos.cn>
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
Changes in v2:
- Respect AMDGPU_AUDIO_ENABLE override for users who force audio on
- Add Fixes tag and Cc: stable@vger.kernel.org for stable backport

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index f2977fe6d824..69d0c6041d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1705,8 +1705,10 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
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
index c68de0fe1d7d..226cfce321ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1748,8 +1748,10 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
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
index c3906270f25e..99f0c5759d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1653,8 +1653,10 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
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

