Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786786;
	b=Mn6FLuRLnDmETMshq2izZdQtgSW+coeZPwNlyamQZTp0d3r7fXhVS3Tf2aVsodqCe3vp
	 6naxlSCN7J6WKf9FqvImV8AcU40oQF300s7d0K6ks/KWeSDSNmTRTty4NchCnYaD83SEq
	 EAR6SXk/kX80txsU99pdrZjHosMp3UoxhT3FEdq9MiWnYj7NRXJmS76nKPOK0Y4A8qJsL
	 0XmoVPiF0NtD/pyYSqFacNyrFz31rBpgkaiB4dnf6R/6lIsAkTvKS9/AKFUYnOhHtkahO
	 iF/mgK3v2Rcut8ibPZRG2PZAfrb/qKGYVunDDXWe37TKa/F/+FYNiiRGElmxWRjOYqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yoEiwXRaoYoUG08i5oYI1oPLVCfYmoQ3KGp2yqcr4ds=;
	b=pGnazj/yhjqXz8p67QdEmARk51s96W3QLZgcOCqXMoc/Y7+Vrwc41GzYWO827qip6oVK
	 Ho6ZE0BRuKodLz7mfCcdc7qqkqtddHJIqOZ01FwiAlW34SYNhaJ41ohFtmt2FSwjwCf71
	 XG3xyga4kz57jwfIhFUupsMlBcqVTtuqEuY8qprOvD3Y1+vHQmCwxHQuS6GDCmhBSf5bA
	 gjR/357BElmPMoQZaN+DdK54SsszpLDyl+0gFfsZKuv8HmHp6Vl+FW/rhXKlbJ0A7IsWL
	 keRnBtiM84/Cg/yhQTPIFt3i4LtybtdoD03LgO9brEk7v4oUUnII1V4LS3G29a27pfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sp/GUOAe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB4606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp/GUOAe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A8A1F000C4;
	Sun, 15 Nov 2026 23:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786786;
	bh=yoEiwXRaoYoUG08i5oYI1oPLVCfYmoQ3KGp2yqcr4ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sp/GUOAeW/Yzz7FJHRWn9sDoSdBj/p9Wz8OqRHnd2YHI/HwdtUMKAQwgQ5l+BdzDG
	 6pq151CCt/9O5yheNkK6xwUYSJvrlalbwnO+IgTCDi1WUth/PBMFBbJpKQRurCThxR
	 nBbTCUDHTpDRMYXkVFcjaO2E0RUFtEaI3/8kRg9jfyPxqw3udWvXgi90JdE9WdATKE
	 Pt4eKYX3lnAC/lqGcX4eV8LcxU4uIQQasfkNCD74GDbp/vaR1EFnBsffiI8Uf5fJAu
	 jaZGAZup2q/ULqqWbfvBZcpm5G/n/dkodMeF4PjN+fR1rpgwSc/t/dMYnSzkjxRJ4C
	 s0letkSSnVt9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: Check cs flags.
Date: Sun, 15 Nov 2026 18:53:04 -0500
Message-ID: <20261115234133.1600836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202356-failed-5.15-f5ea64f9fcd9@kernel.org>
References: <20261109202356-failed-5.15-f5ea64f9fcd9@kernel.org>
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

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

[ Upstream commit f5ea64f9fcd921bc4e2307a262e19450b8a58524 ]

Had no validation before. libdrm_amdgpu memsets this, even
for the raw/raw2 functions.

We have a lot of functions touching the ioctl struct, no
strong opinion on where this is placed, but I thought
early would be good.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d01e15e76358f60ef6734462d2b6d9972b9dfbc)
Cc: stable@vger.kernel.org
[ sashal: Moved the flags check from amdgpu_cs_pass1() to amdgpu_cs_parser_init() to match the older parser structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b461e31b91c25..983baafb8c2e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -113,6 +113,9 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	if (cs->in.num_chunks == 0)
 		return -EINVAL;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
 	if (!chunk_array)
 		return -ENOMEM;
-- 
2.53.0

