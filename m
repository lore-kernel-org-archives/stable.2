Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273543;
	b=huDQUd4ATV+v/BZ2pMJ58vvr8Fdh6jEQxL79KG+J1MLWj57Up2AOroAw7WfyTkW+wt2/
	 JuH654XzphpJMecP6ozt7ZcL3WwYr7zNknS3/8f4vZDDiJ/UgcD1kzmq2AgUquhJKDXNe
	 Zjh7+otRKwLzzHsZBXx1RDIslq0+GaMpwfG5reXBe2g4SZkpnMx5NoES8k99X4VwSlzmM
	 S2iP3YsjFZgz0K4T3pf39rgUtyb3QH4cfR6DOIuB0vf6SHEkCFyUUkaaaJzz8Tw/zTeLh
	 EJYNLDuo6ZReji2KtVZh1+1uBP+PCvea5CTBUbezFvcDpKRQRyb8mCrDM+qJD8KQMVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mrKPb0/TC5qqsPWV3w49rttWGRgXFZ989L+yq0jADPk=;
	b=bWnx70Gh6DlMmgQvfwMTYOuss4Fqw1tlaSk9Fb2VdX/44596ilsp5NzOlrJ3Lr5sKDEH
	 /FEmbdcaI7uWGg+E71rfTbHOiVmq9DqWXXC1rEcrhrJe6yzskp/pb5pZndYMWmG5xCkAW
	 xBVLOtZcoTzdM/oy1vXkujyU3LjrMO691nGQupcNfnp7l/3NVCyBHoe6Wi+bemXFvUPWp
	 Fa9Zyq4HLgKYBKbBPEK4y6AOdDqMsgG49uBqV06lNNbXMBK0OLJARjG9i0vE57MgWFXU7
	 qZ3PMms57qx7+MLSktO/j+aXZDBYYdyxDQHjA+h2FDD3qk9qI+Btehi6w2DcwvAnmuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/1LYits";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/1LYits
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF751F0089F;
	Tue, 10 Nov 2026 01:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273543;
	bh=mrKPb0/TC5qqsPWV3w49rttWGRgXFZ989L+yq0jADPk=;
	h=From:To:Cc:Subject:Date;
	b=j/1LYitsIFmRnoLIZi9/yecbWz78CGBMjUaHE4e2bSIENcZ8IO0nIOCRuSTEXEovm
	 lCNR/42dzGkdACU7H3qZSe21jELs3JCwMonuNWwIAhEifzqoNDkYKIMx/6KNelgPmn
	 k7DkPqnc9t3c1I6dfX7YUkyLDQO4kqtyAKYgmBtWY46yV/YElPs8XfoI1WqCjCPb/T
	 UPYWI5061tMYB1NOILDQbv+LDTegsufDa+AhH+AQ0Ul1nwhhGdfl/Qm/8p+yTyNnjo
	 Rbd3LdSwUGWyUVjl24NnresyK4RDJuesPBmekFXeMyxWtY1YUtr67D0kT3f8vnbpE3
	 xlmlsx8nCg0eA==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: keep the CS user fence BO in GTT" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:01 -0500
Message-ID: <20261109201901-failed-6.1-7a56d929dc23@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7a56d929dc2304edaa6231e1eb5eb82b7e8b74a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201901-failed-6.1-7a56d929dc23@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




