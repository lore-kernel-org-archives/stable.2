Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049022;
	b=i2nu+vWvSkdPvQ/yneD1C6G9PHzngY2f7eTJC0Jz7juOpA53hGIUOr14RxRKFISdb/Mu
	 CQIs/zQA3C3icdfDc9BYyThpMTmXqTyaUrvxrWGTNKRAfN/6OCFJk4HK90hNG0yw/qddF
	 gsOFW1bDfFB4XxpWzbO1gyv8ZaeNkyaK0TKLGCdJ4NHhViqr4T2aLBuwq8U9GrNIBvE8P
	 dBU49/BCEd9VKU0bIX2lv1WYnT+K+mWvk9wa1Qex0ZL5TQIBVmXKmzi3Bp4PCRA2mynvv
	 bE36nENG+Hp7rK/LHI9bY20NUe3YfLywYvUkAaRFg0APgziuFY7rwlVrJCwDozAFyww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049022;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+hAfuQgEUQ7gi87jfgPUvwoTOPYnvwCUPbzdfu1pCsg=;
	b=pRSnDN4JJUQtybYV9G6ybKe1GZxFca087IAhwJvlOjOAntQ1ugOgqo1vO2NBZSHyA74l
	 l+J+d0x8NsARjLzSYfYXJkKNLOfyhdpii7xrGWeCaxe/xa5E9cGXpCwIx6Bc4CurJJUs0
	 ExUMC4PJKcLwe48YC0OBPxE6fuS71GgosJU3AttdQ363BMd/y8IjZ3HnyMU+0kd6DKpy3
	 7U9B5bBEiGKtv17sKgex+K0cJ+Tx4au7jjPj7Q1QGSbl0HGrHdeFAw+yYO5oxlurQvdDC
	 UZbWabLrmhFsWehjIhdWspbzDdAQeji4Cx7UCUROp0q7a2kWz68CGFG22M7bqSPK8yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjBdOphI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA0606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjBdOphI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9632A1F0089F;
	Sat,  7 Nov 2026 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049022;
	bh=+hAfuQgEUQ7gi87jfgPUvwoTOPYnvwCUPbzdfu1pCsg=;
	h=From:To:Cc:Subject:Date;
	b=mjBdOphI1WaIOliDIIvguKGPEECfCpO4D1uNwrL2zij1r9Zqj4HiFSqX/ZGJ5c3ZK
	 E6DGn9q1oTKfeCEUKJnZ6/JJtjNF0/5xvkcypnrSpo7EXI07gedyeyYeIg820/Ec/G
	 LF8R02Xv4hnTh/iHUjXXZFqWr8Q4Xk/pASwJiwZcslMfrCdInUVoo0cIWgB80JdwcM
	 /apdlCrulqyR9FTRjP3FljwFxKW1g8VeziED7DIW+aLyzUriNReVBumH2wq1zsPSaa
	 /8+g1q5hpz1uxFvHWnvgTn/bnISsPXobFMHez9UV0v6GLpbns2ZquhOqyp12NDV/XF
	 eUCAMP3P2stuw==
From: Sasha Levin <sashal@kernel.org>
To: yubiao.wang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: recompute the dw estimate after allocating a new VM update job" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:00 -0500
Message-ID: <20261107055700-failed-5.15-a74c7832b118@kernel.org>
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
git cherry-pick -x a74c7832b11827907de560169c7d4ac94505fd87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055700-failed-5.15-a74c7832b118@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a74c7832b11827907de560169c7d4ac94505fd87 Mon Sep 17 00:00:00 2001
From: YuBiao Wang <YuBiao.Wang@amd.com>
Date: Wed, 29 Jul 2026 17:53:57 +0800
Subject: [PATCH] drm/amdgpu: recompute the dw estimate after allocating a new
 VM update job
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu_vm_sdma_update() keeps the number of free dwords of the current
job in a local variable. When the job runs out of room it is committed
and a new one is allocated, but that local variable is not refreshed and
still describes the job which was just submitted.

The stale value is then used to decide how many PTEs fit into the new
job. If it happens to be copy_pte_num_dw + 7, or one more than that, the
result is zero. copy_pte() encodes the transfer size as count * 8 - 1,
so a count of zero asks the engine for a 1GB copy starting inside the IB
pool. That runs off the end of the pool, faults on the first unmapped
GART page above it and hangs the ring.

Re-initialize the estimate from the newly allocated job, which is empty
and therefore has its full budget available.

Cc: stable@vger.kernel.org
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 50cc0779c340e..eb8cf0d9d9c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -254,6 +254,11 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
 			if (r)
 				return r;
+
+			/* The estimate above describes the job which was just
+			 * submitted, take the budget of the newly allocated one.
+			 */
+			ndw = p->num_dw_left;
 		}
 
 		if (!p->pages_addr) {
-- 
2.53.0




