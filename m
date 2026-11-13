Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575432;
	b=3ThGZdzqUFzVXU1gRnHEY3LFfJQGuSPtDZzmMtLOS6L4+v4pt1o+PB+H+LkDFtJAqaaj
	 Ji7MNI/iRXVvWJzIm2kncBUxcL69kAhkohrZQ2XIybgCqkqZC9wo22kibbQU+lxIT01EF
	 ZOMHXytqyEAPbYuYllmf60I3+twnLchx+K+WROb8GdulSOVf7GUS9sl2oY/7qSq5umtyL
	 N7AX1ujlufGsU2x+IHEIMnNafC29JZsCLjZI+CPEFiaoSDTSmstKrN8fKQpNb35SmtD9v
	 oDCaCkCQBidetsIc0D7lp4uCG2/tJ3sGNkDltENDuOKUtYIuQy2JznB29+QVcjXIwuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Tg50/tjCC0yxPNvcYkcYPCrnfp4Edqsj1ljJg67TVho=;
	b=M4sYrjo1Hl00GPtdjZuImbHuYwj2DOw+TF2M9X8ibCFDszG4g0Iz4O6rHFhOlt5P3S3C
	 lwftTdPYN/Ak9evykmaPuR4ZktW+hihGwpkqj1xyZEsuvyg1HIMKTsjANHZ9rKXzzFVK4
	 FzliHN+kX/eSjnleZqB8oaN+nxlPmHdSYzEJ3XNLM37XyXjOivolZromPcl9i4IuOGw82
	 TSG5k8ycOdAK1FE/H/Iu87X5wPAD0tmaba6D6Adpx9q45+8JRIJNF62iJc0SjgathRyFT
	 M8m808mtHN2qu9eFuxJFcXj8NNcPPI5b0ZdHsHfRe2CgsyXDBQ+i4xRwIOfzkv9E4Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KPmZk/aI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED7606A8AE
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPmZk/aI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6611F000C8;
	Fri, 13 Nov 2026 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575432;
	bh=Tg50/tjCC0yxPNvcYkcYPCrnfp4Edqsj1ljJg67TVho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KPmZk/aI13ugrFvdp2hdlQcMm/0feWSAd9xNo+5KIZj46o81feu2BRb9iFdibF+Xm
	 0DBKwbuDifTgqLFkqRz9j1GbVIaJ+arTgVEZwwt+MjFLtaO8FPG4tHYoaf5iR3vjaF
	 LIauchE0ZKCfkNkjPz8n7nCKR3pNSVRu+B0kW8tEaG0PiVt1oANumUdaKcPwlDYpWE
	 PXnXWCHBXbw+aGQblNL4bnUx/Y5IIjIyuKMgPHB85QBIQ5s3qkCYewrga+PI5ENQgo
	 Xp9LUgV++hDG+KxXa3o+N3lf13xwFTn6qaJJ/c65V3hXu95FIkwPPRXL+Po5Y42Ny1
	 YLHQ4tb/FZp0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: keep the CS user fence BO in GTT
Date: Fri, 13 Nov 2026 08:10:30 -0500
Message-ID: <20261113130527.988621-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201901-failed-6.1-7a56d929dc23@kernel.org>
References: <20261109201901-failed-6.1-7a56d929dc23@kernel.org>
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

[ Upstream commit 7a56d929dc2304edaa6231e1eb5eb82b7e8b74a9 ]

The CS ioctl hands the GPU the GART address of the user fence BO, but
since the BO keeps its own preferred and allowed domains, it no longer
makes sure the BO is in GTT. A user fence in a VRAM BO, which only needs
to be a page in size, gets its address from amdgpu_bo_gpu_offset(), which
warns about non-contiguous VRAM. On navi31, a CS with a user fence in a
4K VRAM BO, or in one created with AMDGPU_GEM_CREATE_VM_ALWAYS_VALID:

  WARNING: amdgpu_object.c:1531 at amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu], CPU#11: cs_gem_checks/18393
  RIP: 0010:amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu]
  Call Trace:
   <TASK>
   amdgpu_cs_parser_bos.isra.0+0x4eb/0x850 [amdgpu]
   amdgpu_cs_ioctl+0x97e/0x2510 [amdgpu]
   drm_ioctl_kernel+0xac/0x110 [drm]
   drm_ioctl+0x2c6/0x5b0 [drm]
   __x64_sys_ioctl+0xa0/0xf0
   do_syscall_64+0xa3/0x4d0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

and BOs which can't be in GTT at all, like GWS or OA ones of a page in
size, pass the checks as well.

Only take BOs which can't be anywhere else than in GTT as user fence,
which the CS then validates there along with its other BOs. While at it,
detect userptrs with amdgpu_ttm_tt_is_userptr(); amdgpu_ttm_tt_get_usermm()
returns NULL once the task which created the userptr is gone.

v2: only take BOs which can only be in GTT instead of special casing the
    user fence BO in the validation, use amdgpu_ttm_tt_is_userptr()
    (Christian)

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f16989def9561d04d0f2e77216f5319112d29bf1)
Cc: stable@vger.kernel.org
[ sashal: Replaced p->uf_bo references with the existing local bo pointer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 894989f453fff..cac55781798cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -153,7 +153,12 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	if (size != PAGE_SIZE || data->offset > (size - 8))
 		return -EINVAL;
 
-	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
+	if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
+		return -EINVAL;
+
+	/* The GPU writes the user fence through the GART */
+	if (bo->preferred_domains != AMDGPU_GEM_DOMAIN_GTT &&
+	    bo->allowed_domains != AMDGPU_GEM_DOMAIN_GTT)
 		return -EINVAL;
 
 	*offset = data->offset;
-- 
2.53.0

