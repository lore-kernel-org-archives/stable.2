Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038469;
	b=qg6T2EMTY4MawUKbuZafxdpbCs3LrL0/guNQdDiV+5vnGfOjTFYfP9h0OS0Be8oPGMnK
	 yQ7BhTNrsiycn6aSKt+rzVkpS6KJjyE1J5OkLfjuFvaKNAQaqvP/73dvoXg92bvrYQJlt
	 u19QVyABzedg0wtlpsVocX8okqQYNQN7C0zYwb5mMVoswUC7knR1AnaWu+/CfegYxIa42
	 oy7psZjeu7iR2H7kLfxuyN6Hrd1bIs/xlx5+atJJ45pbTF/Npoie6Yr6ut3md4IwQSxAc
	 a1g2cId9bZoe3pK84cQcvMiZRIMWtxIbQ4Wy6E+ZDadjiRXeZn1xGanocHhQ+ZWMhqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038469;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Y9z0INQnIrxBLi0ItJauMKa1CNAGPzWxvkQC64eLAXI=;
	b=QZVGccyXmonlieSCcyfEVTnajzJkvSQckl3FT6BEdTuusylsbIifOhFaFucGNlumkBvA
	 4KZAks+eyx7/KF+8XRVZTNMv38lj5f3H2nHigkeYhl92+Hk/pRCpStrHGdgYVfzlstiyp
	 g8AgdqSN0Q4nFlHBFfijHQHVD1joLgrwiVHOIpnasKyGAtTAQUA0Q1RyF4cgYQ451lgUx
	 7jMw6rvnn5En6yt+8ztE2I86Imr/B0IT7yzqbHyvbZJ2h6v0/E//9pkcZcztgL3UntJAi
	 lOgR/cEcWJctYSvBVpjWH94xv3CO/USJI2Uy9+ZmGSSiZOlC7M2/WmWSGME0YcPGxRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GUh0hZ12;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83B606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C83B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GUh0hZ12
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=Y9z0INQnIrxBLi0ItJauMKa1CNAGPzWxvkQC64eLAXI=; t=1795038468; x=2110398468; 
	b=GUh0hZ12BT2Otl5c1WMu6HwXjaayexacbNBQNxI49BteXYOKv8Qkm/mhdNrc4YxC48dH/Q22p2v
	oVYPLNWPMHfHJhRdpHu4PKvho1PkmIZy4kmFoWumCez1u7xnfjLC8/60xvZ85Aktnzn7nrnqeSvBw
	7MZRwjDQgRduIdFxZ9n04ICTy8iInb4U3N3Sg+vh80EZ++SDKYbjnASiuxJjnrSd/zEWKOOEUXNFY
	7JVNAc8bblDkboKNMAhakFZMD+nMJK1Rw6gVQ0TQcArb3Pr/Abg+3UJ3wqtOzPkXS+G13yHid0dbp
	Ps7yCRmMJ0/96poIztUSOZyRIGM03oYlpB3w==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xTnVK-00000001DOD-1atu;
	Wed, 18 Nov 2026 22:47:46 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 18 Nov 2026 18:47:29 -0300
Subject: [PATCH 2/4] drm/vc4: Check for a validated shader before reading
 its thread mode
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-vc4-icache-workaround-v1-2-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
To: Iago Toral <itoral@igalia.com>, 
 "Juan A. Suarez Romero" <jasuarez@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=BSFhiqKTk4diCGnaXJLGBu8mlHmWK2u9FvoYgucdTZ8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/hz221sfFJT2BawEtvEsuwBAjv/xZAhIeiAEB
 cF+RxceqY2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav4c9gAKCRA/8w6Kdoj6
 qjnPCADVzoZl8ywOqRQPPY3qUJX1tfbxYYwIZU+DyxrHJ4HNiTICiOcHvPbGsaMzKC+YHHQed9m
 JPEAfOyqPmnud3wjsANZxg1Q7AAfJQyVXIs1vuUJg2fADcQ/DTmVYNyKeBGrkAyN2cpnezgS9J4
 ZxIKUWT6fMj8SoskSSWwXH3FVAOqxpyp21+1IvymQnhq7GaLod3EGcf2cleba3NEMLDrh8Gi/ug
 CcJnen28Y/tnYxUuf3kBeJmVrsAxVWD/y3ZDMixcvAWxA5jgb562feoXOoZlXwdIVgsd9UJWgd0
 0dMZhaEk6NwLtBlJwikVWpHcpu0z1N7irmlYE8K1pfLAPZ4S
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

validate_gl_shader_rec() reads the thread mode from the validated_shader
of the FS, VS and CS BOs before checking it for NULL. A shader record
pointing at a BO not created by DRM_IOCTL_VC4_CREATE_SHADER_BO has no
validated_shader, so userspace can trigger a NULL pointer dereference.

Check that every shader BO has a validated shader before using it.

Cc: stable@vger.kernel.org
Fixes: c778cc5df944 ("drm/vc4: Add fragment shader threading support")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_validate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 0d2b08abf1ad..240786e7dcd5 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -830,6 +830,11 @@ validate_gl_shader_rec(struct drm_device *dev,
 			return -EINVAL;
 	}
 
+	for (i = 0; i < shader_reloc_count; i++) {
+		if (!to_vc4_bo(&bo[i]->base)->validated_shader)
+			return -EINVAL;
+	}
+
 	if (((*(uint16_t *)pkt_u & VC4_SHADER_FLAG_FS_SINGLE_THREAD) == 0) !=
 	    to_vc4_bo(&bo[0]->base)->validated_shader->is_threaded) {
 		DRM_DEBUG("Thread mode of CL and FS do not match\n");
@@ -843,7 +848,8 @@ validate_gl_shader_rec(struct drm_device *dev,
 	}
 
 	for (i = 0; i < shader_reloc_count; i++) {
-		struct vc4_validated_shader_info *validated_shader;
+		struct vc4_validated_shader_info *validated_shader =
+			to_vc4_bo(&bo[i]->base)->validated_shader;
 		uint32_t o = shader_reloc_offsets[i];
 		uint32_t src_offset = *(uint32_t *)(pkt_u + o);
 		uint32_t *texture_handles_u;
@@ -858,10 +864,6 @@ validate_gl_shader_rec(struct drm_device *dev,
 			return -EINVAL;
 		}
 
-		validated_shader = to_vc4_bo(&bo[i]->base)->validated_shader;
-		if (!validated_shader)
-			return -EINVAL;
-
 		if (validated_shader->uniforms_src_size >
 		    exec->uniforms_size) {
 			DRM_DEBUG("Uniforms src buffer overflow\n");

-- 
2.56.0

