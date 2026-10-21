Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618600;
	b=eJUF7VWKH07aMu4qFDWaSt5BRcOaxPFpUBDDJgyGANVtRxtYNRUHAO7MwXaf70lces8o
	 tohczdkK8d4vLs/zmgkFgRkYchcmJgIAPku5sIGcnrJQFXp38KA3ZsUM6EZ5x3D1dwcM5
	 CgfBY4Mr44STz1ASjv8MSPgLd27r8BTe31aXgMJxMIYkt9lHp6AL2QMa3JW5AO1WH9ndA
	 bqdUgLAVSEUXBBeT2G86NWTM+Th6n2v3VDaAK2lR3Eb2MIUT8ekjIWMo3VWuTBu38o1Ba
	 Aw0fGmc3ctT7kvETKGieuxamgMb85bQlQGiiVKCzZeozNRfCvUVqGaXUaHtX9duq6JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PQC/ODjSnr2ttsaFnSJs4OLbcG/gp/uOLNXKXH9JoyE=;
	b=EgZIGy/09mkcibvTHdy15kt+Er6bKkQ2HfxWjlLfAdPf7XIPM8IJo6wpKqDRsPP78gRp
	 Tm6LsPAI7okQMDHqGLHKBAofXgQ3gulhOWcMwhmw9+2MEIj+19Y+GBTRtdqsboWWwlAdF
	 zTZ6x3E+LqW84ZIJcOjXN0Wos3ZtmTXsOfOELx/6Z1vvtJtVWwQUfUzZ2VSBGQdEEHigg
	 Km32Ta7CdiSuWGjP5tOM6cp2Hyd33lVddUWRfz8fe7LV7PMLwF9d5arR2kExpqGa0/1V3
	 QvmpAXgOkP1HdeG5avPHr4ecxQTi1dQZkEctztQ1z9J6/A6A1sY1KvO2uNKZ7xHXV+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFSEGBw3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA2606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFSEGBw3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB911F000C1;
	Wed, 21 Oct 2026 21:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618600;
	bh=PQC/ODjSnr2ttsaFnSJs4OLbcG/gp/uOLNXKXH9JoyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFSEGBw36NuKrv54M8PXMrLSiCd5CfYEU+hq98LDeq+uKfb7CPycZldRJaXSUaKK6
	 zo4THpwwfP7SwCInw95wspzokEkLO9LSwLBWOKbleG4Glk2bXIK9cBnZgpodvd7/nf
	 WB/CpeeUUKHP73a3IlLLtXc5Zbe2k9WsGpKApzzWVcsZyj9sQoqnHoipIl0QOY8XBj
	 ajkvNf4smFnCq5KCFwphGgMLrqvEsOxQ3y5UFgbVoRr9DnV28M1UfE4mR3buRI9Bvl
	 fsQiQ6AKbMAJSpAEzqlFAQawVxwAOqmzR+PwHACtKeDHTYc5uBHvplqXhmVtRlkAY5
	 ddAyWjaLEn4vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu: keep the eviction fence until the last handle is closed
Date: Wed, 21 Oct 2026 17:36:38 -0400
Message-ID: <20261021213617.468835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102117-gaming-valid-6a28@gregkh>
References: <2026102117-gaming-valid-6a28@gregkh>
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit 3c44cbcec5eb370713bbd2c315ed7c34d8ccec2b ]

amdgpu_gem_object_close() detaches the user queue eviction fence from
the BO before it checks bo_va->ref_count, so closing any handle of a BO
removes the fence, even when the file still has another handle to the
BO and the bo_va with its GPU mappings stays. The BO can then be evicted
without suspending the user queues of the file, which keep accessing it
through mappings that are only marked for update.

Seen on navi31 with a SDMA user queue: a BO opened twice in the same
file (GEM_FLINK + GEM_OPEN) loses its eviction fence when the second
handle is closed (traced attach/detach of the fence):

  attach bo=ffff8c78a6c84c00
  GEM_CLOSE handle=7
  detach bo=ffff8c78a6c84c00

while handle 6 and the mapping are still in use.

Only detach the fence when the last reference to the bo_va goes away,
matching amdgpu_gem_object_open(), which attaches it only when the
bo_va is created. With this the fence stays until the file is closed.

Fixes: 31f7efcdca4d ("drm/amdgpu: enable eviction fence")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8387982f03d4026b7dc11b0b5e3118298eee4d6a)
Cc: stable@vger.kernel.org
[ sashal: Changed amdgpu_evf_mgr_detach_fence() calls to the older amdgpu_eviction_fence_detach() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 002d848d377f7..3b03157faa7e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -325,11 +325,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
+	bo_va = amdgpu_vm_bo_find(vm, bo);
+	/* the fence is attached once per bo_va, so keep it for other handles */
+	if (bo_va && --bo_va->ref_count)
+		goto out_unlock;
+
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
-
-	bo_va = amdgpu_vm_bo_find(vm, bo);
-	if (!bo_va || --bo_va->ref_count)
+	if (!bo_va)
 		goto out_unlock;
 
 	amdgpu_vm_bo_del(adev, bo_va);
-- 
2.53.0

