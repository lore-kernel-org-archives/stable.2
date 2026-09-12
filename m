Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C0472074
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211840; cv=none; b=p0VJxTzKIaMtWBNBNZ3vvMQp4HaXgYh/jb0+73VQtFKaSqtMxiNoTULja7ZJFZ/2b/VZkdIF7jPLwHP+Lr9fkxO97GsEpoyW+o+BvqLu4yF9a1jD1+iQYmPeSW3w2tepufM9f73Y++vFcavzsbLrh2HY2PxlhDedbRcLtV61go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211840; c=relaxed/simple;
	bh=J9pRy4gnolSLIEztJeEqGhoBbdvM3B6ShoALJt/6bNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwkLlxJRxZnoscZ8dszyf1bZ0oHTrUxSV+yWWyWqjaIp1U2A8LGluvDbZM/EESNFWciNT+jwNhrofJ/nKl9vUorYrpltgnFvMmPdAjcYqfhP/HL4nF3DnNInZCpiPxYCt3w7vM3uOlUW69uvfZsJSiCxBlen9Gb+P8krT9cgHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTXkzjGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTXkzjGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569801F00898;
	Sat, 12 Sep 2026 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211838;
	bh=16Cyg4+aVYzw282Z1wEz41KnTB6JiwYaDc8Er7dHCRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YTXkzjGcCRiPvUZXpRUxriYdqsX02VcdQtd758PvC7qOH6hiZXX8yNlMF85Fe77xq
	 hA3MUFg2afTPxhkdQpaFDJyIScza8EbjmPL0zLW5lLUzYf42LdFeb/FHWBVsvBsyCr
	 qZtKSIeRgWBhL8Sl0xYeAtLgRumFDzHXlAorfZ6uYHMUaJOAYKvs30YmkaLmTblnIJ
	 8dqGwxBLci/XVo4a1B237sV6baoVZ3brbllqSVsohx0qNwruNMC8LfjcPb26XAsJZ8
	 7fv/oXG8MKmnJelxRBgyOdqQB5x3CM8qQI0mSFpnH/zIgiYqqqHN3m252MXryPtm/I
	 1o80So7XO35Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bob Zhou <bobzhou2@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Frank Min <Frank.Min@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] drm/amdgpu: avoid force-completing uninitialized UVD rings
Date: Sat, 12 Sep 2026 07:17:11 -0400
Message-ID: <20260912111711.2285466-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111711.2285466-1-sashal@kernel.org>
References: <2026090943-snugness-plexiglas-e964@gregkh>
 <20260912111711.2285466-1-sashal@kernel.org>
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
index f10268de0ea3c..5f8c036773552 100644
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

