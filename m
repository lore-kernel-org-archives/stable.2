Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581384;
	b=DQM14t+R+N1LGhHOg52u8xyTIxGvIJGLhSvhSKHT5WisCJHcGSeQFR3AF8ols2/biS0f
	 uBRk5quRj+sqL8Oe1XMjUxIzlzPl7JUL7oF8Eh4sywBR0it+xei0JddFby6UZp4gsSEQV
	 jlf7apj+6vZ22fkdbdfOlbr3W7Dut2HL0bB7h5fY3kFg/tH5JV3Ml4LmW9q8EIrVSaQcC
	 mSXFlRqgkegsfkQuu9IfZ+2eoeP5ROUJO17SmqQ7QNRMLI1mUbPrGFpOI97aRUKvlLJoQ
	 MUAesdR55Wqv7EtjyH1yCYqWkKgwwe4PiRzlcHN6C4sUHig0VdTobvtMbqMIWc27w7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J6ddqzTEbSwoJm5T2U5KDTw+v1Ex+wAGuv3fC02A8ds=;
	b=bXjfuA3s4DNPaTwXrnj91vYTJdqaXgAky/MAGPtvJy14jsYsl750J7gKyWNf3md45zre
	 4g5s4/yF53VydMipJ4ozmJMKiVqrP69qxqOSLmwDZC9zF4af024K4zP0zGJtszWxTW9sb
	 dWrDnLVHDPg0QmPEgLgOVdw7OVv7n2A2tfzIQjiTSBui2Ng5urXTgW6j//UvDMTXMZuy1
	 JPYw/SRzoagvgk+lEAf34ZFoycgaVsq0SQDmHTCHXI6/HgTS3p16R0s/H3vis3xKvdN8y
	 9E9glutd9bIiIAWT433uXoF8c5FkbZBa1rATOqRMgyNNjLOsDGeewmlRe203RJu0A4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RGn/oX4o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9A606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGn/oX4o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76121F000C4;
	Fri, 13 Nov 2026 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581384;
	bh=J6ddqzTEbSwoJm5T2U5KDTw+v1Ex+wAGuv3fC02A8ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RGn/oX4o/1w7hXy/YrkKcZxrif1EKi3yggYDeqdJY1pcby+xnYfqq0D9li8/7J0qf
	 Q1nSaSadtUj7v6O16xXIV8HLrOLvpm4ENTldN0G+dDmNEpBEfJVE1RkCU+Z8/UPfI3
	 q4ezmNJNG5wxwjdlbM+fwXzF9/TSZ9S/1uA+SL2+RO2BbjtJfcvzIwnwlazCvXa4T1
	 iSEfm8Rjag67PfoSZQvjIh+1SuhOPzn/RaAvOI8ApNni3PFpElEkwd6Vc6zW8Qjcat
	 TMRRn7FYT1y/938s8dUQ7gikXAYqIRQ6N2ue4sWyoryH+uJ/0IB15Rgad/iCsFQFwn
	 pu9trz2GhCz1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: keep the CS user fence BO in GTT
Date: Fri, 13 Nov 2026 09:49:42 -0500
Message-ID: <20261113144741.1231405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202359-failed-5.15-7a56d929dc23@kernel.org>
References: <20261109202359-failed-5.15-7a56d929dc23@kernel.org>
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
index b28e98ab94ece..b461e31b91c25 100644
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

