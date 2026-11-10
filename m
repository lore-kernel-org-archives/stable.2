Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273841;
	b=DYt8EHRYdzPmfI1HaOFWwZiuvjJrcfihC6wHphUZKqKuKPrxLfiVDKW3uLAsBfO/dtyO
	 fwTPPD+tk2KuOjWIMBO873SoNtp76iQX0kSyguebw7XuSohFIkUQwy3ar/B+vwufJS0r9
	 W7fMnbAlcrnzahR+xRotoxGunKYoalTH0gCuu4EfsSFA2v7FIoMsjHg5h5o33vg+cQYfU
	 QBobNXU0ka6iJKsjsDi5ycais3D6Lts5WTGg8oxMthWUgBMfsXa8vXpEg+8xoQ4qVvqlz
	 oVJbwcukNNuH9yTJa1b1Qjg+YSHu+JB6VBHedWSX2RRwYePVC6cPHUZe3RBxmhMYZMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=r7/ZKT1otrz8ER6YkWnqRl2gV62xsuLAIv/FjnXtx7I=;
	b=zDUlu9u2FDLMt1sXa712hXcX5hd9yX2cp32d1Nx22UP5Kv2kmlYs5brLiWi7P//AQdcS
	 r3geOnBLDrg25LHzBSxP4oeiwdk+kGMpzo0yoSZu/Bf2ft88umUsngUrVkucoUSkX5qix
	 qAosdn+W5BwaESDrFI1F0LFqwmQnkQQX784agGnymmZCvu5g4LZoauv9srholKGgEq3ZC
	 1kravqUJIaglZg+kh5jR4hRj2K7PATjs7ZNEoM0vZwiPG1zo5ztETErGfQD431q5OQkYC
	 1heJAZ3NJuDkLOpFTxMNgfCM8C+ciOp3LE9r9IpL32BcfY4qwgD1U12BqrHcKp/2Xag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSAyisKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03258606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSAyisKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545701F0089F;
	Tue, 10 Nov 2026 01:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273840;
	bh=r7/ZKT1otrz8ER6YkWnqRl2gV62xsuLAIv/FjnXtx7I=;
	h=From:To:Cc:Subject:Date;
	b=nSAyisKI2ILK2DGQ88Ca/2jqwtMDOZhPoc7vF01YqxNk/CCzwQXpLXy7dVDluWkbr
	 UhMZLDOrrZNqCyiZxdLHeaz32zPOiqeysIXoM+cZBdbmOSo6W5FCEhnzD5WykrTuOc
	 j8z99S+DHk09DsumQnC7GMiRKZnrGfn78TMVCxWaXllYjnKckdyWaSGBZshxZAw0gS
	 7MeUiDR2u+loW/ak5Go7PhfID0a1oDlQY4MrpPsWx02YcqsOJPMDXt+qqS1bPhK0uB
	 M4RfR2PeZh/0EyFWP2W2Nl73/LXWwGyTJKcgRxsZNycJXjhMXN1QbpZWKFlN8+Qk2o
	 aWOYzFRtvjMeg==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: keep the CS user fence BO in GTT" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:59 -0500
Message-ID: <20261109202359-failed-5.15-7a56d929dc23@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7a56d929dc2304edaa6231e1eb5eb82b7e8b74a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202359-failed-5.15-7a56d929dc23@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7a56d929dc2304edaa6231e1eb5eb82b7e8b74a9 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Sun, 18 Oct 2026 19:17:57 +0800
Subject: [PATCH] drm/amdgpu: keep the CS user fence BO in GTT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ac32530c1b488..f51a6c00f6ff0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -150,7 +150,12 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	if (size != PAGE_SIZE || data->offset > (size - 8))
 		return -EINVAL;
 
-	if (amdgpu_ttm_tt_get_usermm(p->uf_bo->tbo.ttm))
+	if (amdgpu_ttm_tt_is_userptr(p->uf_bo->tbo.ttm))
+		return -EINVAL;
+
+	/* The GPU writes the user fence through the GART */
+	if (p->uf_bo->preferred_domains != AMDGPU_GEM_DOMAIN_GTT &&
+	    p->uf_bo->allowed_domains != AMDGPU_GEM_DOMAIN_GTT)
 		return -EINVAL;
 
 	*offset = data->offset;
-- 
2.53.0




