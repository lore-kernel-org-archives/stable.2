Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505630;
	b=VqKuHo3CRnTHlr3Ds4xOVOyTLSmyxN70DhL/OkcHi9O99JoABOLfNU6iGu99TG/WrE97
	 4q/z+AbYjBX6PidnRqRg0MOV3vfrOHt0kzWaICnG1HM0OAt6ghZwK8TlvzKjcGtBIV6Ty
	 MjuZ1/bn9yekW85KqiJE7Y/CSNyEQpbHDuiDo1srr18eenW+Oh+YVbaNT8TNGmbtfccRX
	 6lzK1hQzEwAxoJMLZWe9hM554irZVOtpYRdjzxfyumCa1/OS9E3iLHNVJ2a3nrRqfvsSX
	 NTrAp3grPl0gXVicxJ+DFn3O8Ssz2fwBU3vVZBZ0555HdDQSF8eE4Dat7Xso6YXXmTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sDBzWU2uFbBceySqazRoW5yO+3pC1K5aB1W++nFVzGU=;
	b=WchSS7fjxEEZpBLz04PkiwYJVzfo+Cf7q0T2sq4FKkT1prINZy7rjqTZlGwxshLst5cv
	 ZuYaD4eeUBJ3UVleAJD/bn+T9qYpsCKR9oJgZ7U+w4CIeMqWcobnbdJAqg22hkcuBs5Mb
	 HSN8jB6pipJSJ/2a1cuUetdXOAi6paw1N8OhSx4AOon2Hnc6T8hA4zW3DryF3qxPyoojD
	 G4SLoAusigOZJn4ygX7JpqWo+CK6isO+7aY+U/AUf30BZEH46dJguCTDFrk5bJdf6+dLi
	 SoWufVQcTrefH99YlRINCbi1hKFtwH1wiJEMVey5KgPs3bjPFjH49X6DiHDFn7RmIjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQuIuqST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F1606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQuIuqST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B8D1F000C4;
	Thu, 12 Nov 2026 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505630;
	bh=sDBzWU2uFbBceySqazRoW5yO+3pC1K5aB1W++nFVzGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQuIuqSTp2YHxnk3BeKIe07tZtcmqko1GEJKIYH816mqh6Kj+ulnKXCUJv43izzwn
	 xv9QQIVrqG8NUFvSY82FCJ7MSjfeQDd9Q7U45y+9So/dpJOmoY8q1o9Kh0i7Y4a5ML
	 6wJpEJHw4dGX7YgK9bP9oszVUeG7yeQIZu3YorVm4lplAdZoLN9NPpptQ7i7iZypYb
	 842giG/8I0c+xZldok5TEJaeaWFbTCq8rKoF/mTq/j6pJIRHDs3tTGpdOEPjVwPTUH
	 lS/FTDj5Cj9rhx1/PBSfg6u9I9tWrWodHywkAYNYAQLHKrl08uprgreMB73FrJDtdt
	 b+fBRnpw823dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sonny Jiang <sonny.jiang@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/4] drm/amdgpu: VCN 5_0_2 disable VCN_RRMT
Date: Thu, 12 Nov 2026 12:47:05 -0500
Message-ID: <20261112174623.3116347-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112174623.3116347-1-sashal@kernel.org>
References: <20261109200201-failed-7.3-a56c2536c399@kernel.org>
 <20261112174623.3116347-1-sashal@kernel.org>
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

From: Sonny Jiang <sonny.jiang@amd.com>

[ Upstream commit 400af1fb41676c25966624b8ce0f5c09aee2a9b3 ]

When RRMT is enabled, VCN firmware's register access is remapped so
that VCN instances on different dies (VCN0/1 on MID0, VCN2/3 on MID1)
require different target addresses for the same logical register.

Remove the RRMT capability detection so the driver always assumes RRMT
is disabled, using local-die SMN addresses for all instances.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: a56c2536c399 ("drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index 5291ebbc5c3e2..9f9b3a47f63ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -203,8 +203,6 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r, vcn_inst;
 	uint32_t tmp;
 
-	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x200)
-		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		vcn_inst = GET_INST(VCN, i);
 		ring = &adev->vcn.inst[i].ring_enc[0];
-- 
2.53.0

