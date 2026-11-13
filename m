Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581373;
	b=iLYAqiBP/i2SZr6eooH75UBAzeSoXsgPut2XhbSGGF1cmEXMvKVC9cBEudrWYd0dhZWh
	 Fv8OJ3WoN71ULpo7WNuukIcwcpK4d9Dk0HyvlAGxRZ14rLDbeuVK/OMV7EyBPSbE74Z1S
	 YiKLz8FKTDDyb8qsklCuOZ9HU7+AE0DXP5/UaE5Wc1COe1UrTBVIraCb+nVyosou9eyI4
	 /PIFX5U3z8zbGcd+lKvP9MfamDXised1q6jqz/pcZ/mwTh7CW3ri/9fKX2ERBDevLby8M
	 loZfH6qSBJH7KWE1TyEiDm1P5FSxqf0Wvmr7A3FoloMA8NivA9GyNrdLZMjLz5fz7Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w/SGgoJc7JLq3lj+uW6y1fUaROBioBlAUQWCPGNXVOE=;
	b=w8dYpaxJp/OYh4ftYrxnbYxRDyQk8Rc63pMYosYdEzEvmnB7d9WGCFH0OBGUdDvf/yCX
	 Zv9fr/yiuPy02Fg8ZE6Y5WADYXXApPxa+TbY2KvK15NvqrJE5kipqKM98z2h6xk/v1Nbl
	 pbqnLHjIBbkq1uZ3TgPqD4841+srJHUou9rae1abz5iUi0OwGEmT9DuNthV4SKhjTYHd6
	 BTcFu+60m0s/sKy82pH/YAp9jTS68bETthlaY1I+pZnoXpGx6McftqmJeU9gSmXzOCtz5
	 IdehmLBTdlJcYxW0YSrNbiAYELZiOuxGcUF0FM/PBlTlAa4pktQLu7lUjOKU4tvstag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCWgTlxr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778ED606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCWgTlxr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A86E1F000C4;
	Fri, 13 Nov 2026 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581373;
	bh=w/SGgoJc7JLq3lj+uW6y1fUaROBioBlAUQWCPGNXVOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCWgTlxrcmIljanP3gzS0NNcTCi+jzHEY9zqr5A2Hd4PstvqD6OY4sovYzVi0hd9F
	 q2NCsDC1bggBGXFOrvwY+aASLexC6Umqv01Uq8AMQ9SRl+ZtNs2JxuoB9at4nYMV7j
	 jqmiJeMBPjQwRlC2vpI1sbNBcFQ1Q2IDJKLznexBxzx/5obZTVo8KCr4AT8GALzBm4
	 l/3AbuOGNT7eNGFDlA1IYLbpizuzP35eLk2UFmTDcxZ/LsX121h7ujlAO+uVFwF1ag
	 vxzCC2fYnWjJK0RwkeSiqT7/hVyRRb3CMau3fSLcsmsCOQp2NJyYDp4PxboZu3pIUi
	 /TEsVjdaC23ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: keep the CS user fence BO in GTT
Date: Fri, 13 Nov 2026 09:49:31 -0500
Message-ID: <20261113144747.1313099-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202826-failed-5.10-7a56d929dc23@kernel.org>
References: <20261109202826-failed-5.10-7a56d929dc23@kernel.org>
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
[ sashal: adapted p->uf_bo accesses to the local bo variable in amdgpu_cs_user_fence_chunk() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 40146957996f0..38491f05c9d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -62,7 +62,12 @@ static int amdgpu_cs_user_fence_chunk(struct amdgpu_cs_parser *p,
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

