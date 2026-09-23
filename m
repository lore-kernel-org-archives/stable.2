Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A269280CE5
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127618; cv=none; b=MtX/uuTh53mkPeoxntDJYRKVZFQAzuB5ZCwIOOduRqKwnU+6xMmuCjamRgBBW4qymz0x9ET3Wf9XHY2+p9L9sAA+jRA6mthUh1xZz1h8/OXsTy7I9a/PUJpGnhQtuW/eGWaF6ynxKOFJfH67hUnxQGY2LslF77lNzgPmmPwi+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127618; c=relaxed/simple;
	bh=128fqmcxX4HQUbH7IKjr2UhWcmfjOOFH/bk2tQpxUKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM2TRKsY1L8ulTUCZQXX9HGQQqxGG2GUaZCPhwoGSEEqoTdA5zhxixQHScrjYocdx18/neL3uxS8MfUfYE2ABnSzCsc58B+uQE/030U8Ql6i1z7TCmYfg/WMFfyUJNLuIdf+Dk7gsMmAyhypqUfK9f+getugYcCB++I8muzlpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYk1OvkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYk1OvkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B071F00893;
	Wed, 23 Sep 2026 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127617;
	bh=DchbbZun59BNCj9YbSG2IN4gnqQmw8E+SnYYTwiDDe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LYk1OvkGM3FszSxSMBZ5Ao7/Vqs2L3oFKCoz6kgzajXbFvaZbQaG9f67FgW36WlVp
	 yBF22TShWDy4S94XrxXAJrdmAeTrsKGPLnNy4JRZe077MYWUENL5BSTL49s6GY4jx+
	 mKYQMADnJ0NDFzEWxdD4HtK53eFPTX68tV9I6S9EcmvdRwVKchW2d46vnP06fiu9jo
	 ehwP1CYxBA7rmvog2lYU7O6JJljEFMy5k/ubPLhxG67o9jsGUriJChc3AjqaYQWSak
	 BUw1GSRMAWRB8lzC76TAtisdyOdA8te38kHUCfgGm/b4jTPPwicfMBBqHgJaaHTXK1
	 HyHXI6RwbB/8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] drm/amdgpu: fix warning of drm_mm_clean
Date: Tue, 22 Sep 2026 21:40:13 -0400
Message-ID: <20260923014014.880066-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923014014.880066-1-sashal@kernel.org>
References: <2026092242-mantis-dragonfly-bdca@gregkh>
 <20260923014014.880066-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: ZhenGuo Yin <zhenguo.yin@amd.com>

[ Upstream commit e7afa85a0d0eba5bf2c0a446ff622ebdbc9812d6 ]

Kernel doorbell BOs needs to be freed before ttm_fini.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4145
Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 39938a8ed979e398faa3791a47e282c82bcc6f04)
Cc: stable@vger.kernel.org

Stable backport adaptation:
The 6.6 tree already allocates kernel doorbell BOs, but has no seq64
teardown. Move the existing doorbell cleanup immediately after the IB
pool cleanup and before the GMC sw_fini callback tears down TTM.

Prepare the local declaration for target 5155002b03b24ba3ef91c5c313b8cf0171b24904,
which removes idx from "int i, idx". Use i for the existing switcheroo
unregistration predicate so it remains used before and after that patch,
without changing the decision or adding any functions.

Stable-dep-of: 5155002b03b2 ("drm/amdgpu: fix rmmio iounmap skipped on device removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 47d6352c2def4..a61573a1c0c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2930,6 +2930,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			amdgpu_device_wb_fini(adev);
 			amdgpu_device_mem_scratch_fini(adev);
 			amdgpu_ib_pool_fini(adev);
+			amdgpu_doorbell_fini(adev);
 		}
 
 		r = adev->ip_blocks[i].version->funcs->sw_fini((void *)adev);
@@ -4146,7 +4147,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	int idx;
+	int i, idx;
 	bool px;
 
 	amdgpu_device_ip_fini(adev);
@@ -4169,7 +4170,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	px = amdgpu_device_supports_px(adev_to_drm(adev));
 
-	if (amdgpu_device_should_register_switcheroo(adev, px))
+	i = amdgpu_device_should_register_switcheroo(adev, px);
+	if (i)
 		vga_switcheroo_unregister_client(adev->pdev);
 
 	if (px)
@@ -4182,7 +4184,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		amdgpu_doorbell_fini(adev);
 		drm_dev_exit(idx);
 	}
 
-- 
2.53.0

