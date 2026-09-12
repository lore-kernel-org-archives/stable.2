Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3F349CE7
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222879; cv=none; b=R3VhQVCM4nYlEja06UC0iWtI8fNt0OsN/+C3goIjOa8Oxhi4ve/Jgy3TvT0ZgnBERfOBzqQKyZDT9u8ZvN0EoZIZXHrJmAQVx+88oEricjHK+/bqy5URfyiqet9+brcsdmX6SRx/csWuzE7D8I0y936LX5HzGVU0jQ2w7/5NK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222879; c=relaxed/simple;
	bh=L951CYwRSFiNq58bmv0Qip8NxoQbJhWZ+wWAV2MI8Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehgcWpdk9XDaBtdcJsnuTskk29a3GQ5xsWs3+5cHZrey0pCM85m2LrOpyG77/HTZY3gj0f8h9ZBJxHKiXcTkGSCB90PWMclgC5O5+1wD3tFGaNPwBTSPWy7veruUFC/d0pTJUM09VVF7C9+3QIB3Z8q3cCZpyqL6fIBy36kTrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI+Kh8bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI+Kh8bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CE81F000FF;
	Sat, 12 Sep 2026 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222878;
	bh=LVMzAhldliYRzogJ6441eXVe9qJvF9gAsoKqs+DNtWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PI+Kh8bcX604c2bKE/rvBIPa4K40wtivg2pC/1L/moVo/HT9iEJUsvTI8Ly6esnJv
	 UJ/88oztGHFX2udbBn8METFxjb2OgMiSyAeHouaTpCcdL2EbdPSDGeh38jRZnf+ev/
	 lSUTyyEqqqWQ7LdZFyB+yQaqxvIQgWztyuAPSHawas+BK2CRItvypQIW8XJDhIhpxh
	 1je7RrETa+nEbxBTpwVr3wiHTfsHyTqYIVhcvxczzyL4cEjchbUK47gxA0msQNSVlr
	 9SwCXs2bL6vFnTt/48aLntghVAPq+9F8wVbBXJ0DDq9y4D/erEGv5Lchy9f6i+Shw/
	 kyFSBZUU0+vsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bob Zhou <bobzhou2@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Frank Min <Frank.Min@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] drm/amdgpu: avoid force-completing uninitialized UVD rings
Date: Sat, 12 Sep 2026 10:21:13 -0400
Message-ID: <20260912142113.2915311-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912142113.2915311-1-sashal@kernel.org>
References: <2026090944-nutmeg-wasp-168d@gregkh>
 <20260912142113.2915311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bob Zhou <bobzhou2@amd.com>

[ Upstream commit 6760f5cb12d2366ddd58a2d8637f7583d73f596b ]

uvd_v7_0_sw_init() does not initialize the UVD decode ring for an
SR-IOV VF. However, amdgpu_uvd_resume() unconditionally force-completes
the decode ring when restoring its fence sequence.

Skip fence completion when the fence driver is not initialized.

Fixes: 0a33b11d26c6 ("drm/amdgpu: mark force completed fences with -ECANCELED")
Cc: stable@vger.kernel.org
Signed-off-by: Bob Zhou <bobzhou2@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Acked-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b0ed8e122c3b8..ea37ac3bc4ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -516,7 +516,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
+			if (adev->uvd.inst[i].ring.fence_drv.initialized)
+				amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
 		}
 	}
 	return 0;
-- 
2.53.0

