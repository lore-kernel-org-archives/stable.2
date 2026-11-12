Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505628;
	b=VL40nlY5ISmi92RxW1ANzUT2Mr7w98nj4N1owQHgwNXAWk56yCRyfW5rOYl6a8zAUVdp
	 Gjig2wKkDVlhHU3syRAiSxqOAJk3YUabP2MVkyu/fZqB79siOqXXpi0QgEcjZAaORFRLq
	 RQt/2W7+4usO0XJ8jkqw9M+dzWnQ31cGSEgytRLhNruAyjQFxsQ9Zji5omNDSKUgjZbyy
	 5BceVEBQ8KoP4k8wud99mbItBQ/QKSiuucJ5mPFYXJLLVsKsP8YLcL5kNRUQf6xT6jK6g
	 r3iYN+65Wl16qKrthE+VhTY8LktSqlu439+IU7luqq27IafYPH/VvicHMWi3zjh798A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0p+7/ZSCfQ8prtzSsN1McFD3YDUAj/19L/AXs6J39Q=;
	b=XHUrFtCfSYvwX07/Z3dcwJpBlIE5D0vfd2Y4op2MU60X6OM7dKg+20PWkZE4I+UqWb8f
	 gOkNnK3QL/6MjklLrH8Q0w0C/ii42Mmhb0WJEf6ldbA7dPqs5gGmsZwsnUZGSB380n8SM
	 XSHXOj5nsN3MPBJOgWkF60tB2ufXfd5PqD+8RHrgPTKaNy+vwEEVlw8GZDG9K+KEAUrzz
	 DdNrVCG+VVKF69TmVeKlZTvYXYb59gZOxSkRMmLuwA6fk23UYMPGT7X3Iwc76lYDRs3oB
	 c6/seqkyh3W4n0Bp2C9PH7t27jSm18KpTTg3PJAV9eKIdqNpEJYIXIVQTIEz1vX0oYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3lIBrae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B2606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3lIBrae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79FE1F000C4;
	Thu, 12 Nov 2026 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505628;
	bh=K0p+7/ZSCfQ8prtzSsN1McFD3YDUAj/19L/AXs6J39Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3lIBrae7MAVt9z0+zcoDLAHusPbkNIo5cqJPquZ0Fs+SHCcNa1oti4x+Gm9+69RF
	 qmfiHBDNkw3rm+5rENKY3biq9itc+kp+AyThjAO6+64EsZE0Mg91K87q2TsEKd/ahY
	 abdHvBTsrD1E84+QuW2jWK8Ya5OHy55aQ7H1YatYLfO0xKAxJBx4v513kPbORnUVPy
	 IOXNTiglGIUknmngzXeNHGSTDkjr6sUkOAYutNxUjw29Byl61khBp8qdjrlWS9OLEy
	 8JxOmU/xruJuPTZb4Q64INQQxTttO2o2LIiPiEkcfb28U6sD21/rBiEB22xBPCzikb
	 mh/DdCkj/q/dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sonny Jiang <sonjiang@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/4] drm/amdgpu: Config VCN instance for soc_v1_0"
Date: Thu, 12 Nov 2026 12:47:03 -0500
Message-ID: <20261112174623.3116347-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200201-failed-7.3-a56c2536c399@kernel.org>
References: <20261109200201-failed-7.3-a56c2536c399@kernel.org>
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

From: Sonny Jiang <sonjiang@amd.com>

[ Upstream commit ab2fb550bc1fabd96c948fdbebbc05f61a9810d6 ]

Set up the default VCN instance mask and related instance counts during
soc_v1_0 SOC configuration, before IP discovery is enabled.

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: a56c2536c399 ("drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 69ac3a231c53a..1918313d14960 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -848,6 +848,11 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 	adev->sdma.sdma_mask = sdma_mask;
 	adev->sdma.num_instances = NUM_XCC(adev->sdma.sdma_mask);
 
+	adev->vcn.harvest_config = 0;
+	adev->vcn.num_inst_per_aid = 1;
+	adev->vcn.inst_mask = 1;
+	adev->vcn.num_vcn_inst = hweight32(adev->vcn.inst_mask);
+
 	ret = soc_v1_0_xcp_mgr_init(adev);
 	if (ret)
 		return ret;
-- 
2.53.0

