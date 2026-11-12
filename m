Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505629;
	b=0SXhUwBDdueEnsK1ZF9fK6VPmY5tpA+sUgM/+1vOSt2B9Rf0+NoqDD7povIv0Lj4WD71
	 MzXV0J746PuR8H8AgeC0jDRUXTFi9HlYiC9FMFXKiE9VCqvunpoGv6Yqu9pAQ/knOYkPX
	 z5WU1JVWVeaP7WQqWLMbf9rJx86tsVb5p4oOjsfsLsmTWow93NKBl/UMq276fNag1LQtB
	 ohyk6VC1D2TVFqlMFuLobd8x5oYbjOaA8nhTnoUPKCWvupkrPm4hz5T/rH2DnXgIpYv+j
	 iYijES6sXYz4r5EcwqUeQAMlYQFngg4tdHWPWVTmTroaQUFt/BEvOj3RxNkqNBLzJvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kv+EzK+k2GgnN56CDr3n/QUFfMFS/lCYvV7kZZXNV3Y=;
	b=VIW8IWEgKq8S/7d+KyypgaUrK08GRDC3gbGCn8nnJAoVC3k6vWpL/DBbCBDE4/qFfaVN
	 hXLnf2mHH1QweZ+w2tSBe4AqSgpKjH+wD0q/93tEmm3CmB81fiYZprZX0LwJz7h1xoaGB
	 BX8nBFmwy3nRaBTNABPe7SXIa16+keHjmXiRGXvsHtJEnqJX5rBuJvbqzMxx0OjXYX5jI
	 c0B4R9bbdAW3QAsDo7j0h3/3CLFIicvJ8Cn+6jZxyA41/hYxf2NPjk/BdyjwS5u8roZFB
	 zhhiYqoA28yypkPyFyQ+R3dWjiJkzgghZevARjllpGm1BG7G1syXUR8wMnAvHX9XBVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF8k8UqA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A1606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF8k8UqA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932B61F000C5;
	Thu, 12 Nov 2026 17:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505629;
	bh=kv+EzK+k2GgnN56CDr3n/QUFfMFS/lCYvV7kZZXNV3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aF8k8UqANxqxgp8SnOVtjBblfL+7OEpIgph3EuoOOXSFJNUxroHzJgqbA9m2SglJY
	 p3kUpmmcn1+IyD/H0tAUKf9fGNmYyaLnqBPuh8yV5V63Z8RJ2XNxft3TeIkzAl0V4Z
	 PZpYhqDkn9cPPAWD+muZeswNM+j43AIrkuK9n45glU4WqJUJpdJ2kMhEaQfiZp1Z7x
	 F+NoSHGvdQt4GMVTPa+sRyetdYTc004LoZ52ejkHVevd3detwlPhNvjGmYHBic1Dbt
	 7/J2HS4aWhxYhtkd+YHMCVu7DcML3IOPDt2zM0LozW2o1tH7ojZ3p2w8dFldJEEcHv
	 AFczdRRCKDK+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sonny Jiang <sonny.jiang@amd.com>,
	Boyuan Zhang <Boyuan.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/4] drm/amdgpu: Correct VCN V5_0_2 doorbell index setting
Date: Thu, 12 Nov 2026 12:47:04 -0500
Message-ID: <20261112174623.3116347-2-sashal@kernel.org>
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

[ Upstream commit 66421e37897ddd29c03a3290cd559f7c72622f80 ]

Each VCN 5.0.2 instance has 11 doorbells. Use an 11-doorbell when
calculating the per-instance VCN ring doorbell index.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: a56c2536c399 ("drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index b9f6ae75ea727..5291ebbc5c3e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -129,7 +129,7 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->use_doorbell = true;
 
 		ring->doorbell_index =
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 32 * vcn_inst;
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * vcn_inst;
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
-- 
2.53.0

