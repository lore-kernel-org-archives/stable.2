Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3F3B27FB
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246768; cv=none; b=VlCUQATAxqhJtpAaK/KM7S0LK0ZON90eMgPSTd+iUQCZ+sJms76O+eA9KZCyDdqx8i5ZuZsCc2wqB7KiKTit2A0yT3HPqDBRKZXFmTa4D5IVt4AtGbEm/nMVWL6/M5LOM4jyIo3JARYXNkUIncOH3v3Drh8yfLUFdourhtH5hFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246768; c=relaxed/simple;
	bh=k0VgbnKbQeKd465Uy8lJk+s3W4SClUghbaLtn9uYJwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dufqBBn4QPwcrmE2dAzWpV1Lycqg7xz2g7PE1YTre241eynOCquy8JpEwS0LWtSieTjtv8erP7wdlcroFludgX2bjvxnSK/bEpKfQPoJUrOS9g7g2Kfehbz1vPduI/2eiDiZa1CIpTb2qRFD3FCXFbqT48OIT+1DXXd+PrHwsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oronv+Ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oronv+Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5E21F000FF;
	Sat, 12 Sep 2026 20:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246767;
	bh=4R8jtmVcE0gQQy+ldEvk/gLAp/VixQgBQvCH3BiQN4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oronv+IeQGtZ6Z3Ff+fsdePTY7lWK9BlRep83w7mHO95Ffa7F/CUm7v6s3o4WHP6M
	 xZhUiZ/mG19rtrfQIinYBfDKjhaqNt5s37+KmU7NZMec2wVbpQ23JoSqFU3eJjwd4U
	 LDXxpe39x23tbmFIUvsZWR0LlXrNJicC3K1rW+cHh5Gv0sQgdW0beXA08WQgi0hUyc
	 acOrovS+uVT2E83LxilHeVJd6vbf+jk27DXYh0bk4PcmBEgfORa+9eNjxe3aOtZ1V6
	 A9J8S99JuRWtSeTAyngiZsacnY5K5+y5ds3CzBJbN1GaCAZikmXkdi5awipVjxTGch
	 SPpTYyJd+AayQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bob Zhou <bobzhou2@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Frank Min <Frank.Min@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] drm/amdgpu: avoid force-completing uninitialized UVD rings
Date: Sat, 12 Sep 2026 16:59:23 -0400
Message-ID: <20260912205923.3934930-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912205923.3934930-1-sashal@kernel.org>
References: <2026090944-uranium-paramedic-0401@gregkh>
 <20260912205923.3934930-1-sashal@kernel.org>
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
index b6047dea0a1c6..48d7a5b514151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -511,7 +511,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
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

