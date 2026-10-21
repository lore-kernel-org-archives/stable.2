Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618598;
	b=JX9YKfelN8D8L4uFywilw1jbvvCIq09ATHDwKSFAGvIo/XIqGI1sn0+3lNvFlUYbDWbG
	 keuXxOV6OqsWPx5zZGnSiEhvAEzeg/VlHUU/2aPegPe31h9KXMOO+rGIUo7yWNQtJ8AWQ
	 1QGgNuFgkF41swNbYwShP96mGesTps2HHk07U3WvsnfV14cJ551NW+lbVp5pHHA8GbBLt
	 X7IU4IJ/qP6ESbFan4lMi9jDgI39pVKTaXZqiQxmnTin3u7i2pEcGrpIesQDmSJfBK5P9
	 7NDBHU+2WuvfjUA7rIvMRpcSPpJ4HLx/ci/TbCKbqDqcxqJGdsWSc3VXm4iQhDSZzWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zqrg0nctncIsBOarxm/IHSE8QFUdYykk1wPGkmbbzz0=;
	b=ZIqcPrBSeSLWILwtfXaB+PRkS/qoL6uhXEICffE9BHQH844Mt9QhEiYB/JUe1scJR05l
	 ZG85zNDaZgwryPjbKlISx3GG550Dn/Gi3IeFr4dF0ZbsdUnmQeQ5HgWQWrfY0NolNvkxF
	 5cBJ+RPPh5SflN6A99+TH1wqiXfBYYnzFOTacslGFcUTLzQB/tgnFw+uwWGp+pjy1g0a9
	 pf7dRXrJonUJ2HnLp4UjinlGnGGkGgLUHLR30LWppkzMMwbY6/5Bt/0VTtFHyZZNff3mD
	 8CCSX6hvinWD9minPAnbzIgWb84oTAArop0x28MhVzAfegH1PSNTqu86RDc94nacbng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/9Vwtb7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A113606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/9Vwtb7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9FF1F000C1;
	Wed, 21 Oct 2026 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618597;
	bh=zqrg0nctncIsBOarxm/IHSE8QFUdYykk1wPGkmbbzz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/9Vwtb70NwTZ2nKej5LQGY26dHGfjWy725r2GUbllacwt42J9yjGUWNj2z4fWP6D
	 FjGSZd+R8N1287V8rVYwl8PdkX2bWoG/u/4saZ5G25H2jFv0K8t3DP4LFmQ66xab27
	 PPnSgigYWdXSxOQjGPOau6f6vdUwAC8MMkycFygMsOnptLocqFw2St8c0m24LIoX7z
	 7U+yIWdZ/u+yp3Zi1fUsRgIOCLc5t7/7AZ2ufmK3RlgWYo+xXXEFrj4mxkzsXym6Ku
	 uFa7SdHxCywPOM58OODYSXdocJWSbpDJPwIjCsQmimWrx0O7nrTlOjfPgFGYjR4lLE
	 iDCCA1T3fteKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] drm/amdgpu: correct reservation fence slots for userq per-vm BOs eviction
Date: Wed, 21 Oct 2026 17:36:34 -0400
Message-ID: <20261021213614.467885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102137-thermos-preaching-3697@gregkh>
References: <2026102137-thermos-preaching-3697@gregkh>
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

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 50b24a20be8c0d35f89f7d5c39533f69d84fe48e ]

It fixes both the move overflow and the eviction fence add for
evicting these per-vm BOs.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 32d0771ef4ca ("drm/amdgpu/userq: actually validate userq BOs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0c3fa2d60555a..9352efa98bfa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -948,7 +948,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 		spin_unlock(&vm->individual_lock);
 
 		bo = bo_va->base.bo;
-		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
+		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
+					   TTM_NUM_MOVE_FENCES + 1);
 		if (unlikely(ret))
 			return ret;
 
-- 
2.53.0

