Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA873403E3;
	Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991537; cv=none; b=OZWc4AAESHaps630pt31jGTedQ/56y/zpxRBo9xgp4MGHuuCioGhgWHtZZLup6aN5d6yAQCTL/H41EStJHS1QipGdrGlkDJpf7oO10IoD/l85ijM3SwggjZkqtY+appdrKZCRbFCrWaig/p0srT6JVVBIS5FI8vqr3+SJnJxxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991537; c=relaxed/simple;
	bh=bAaTk4jjY1AcRN0tzZgeyd0ZFfZYjo/TJnyi0hH0QLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxFe060lbMGRKMzabB29CgaC4/YQi4Td3HNnNT8WIpypo8NLJ71MlQZl38+eQG4O6WYo7yVH7P8e+3yC6mPRvggRDNd9IvpysQfXz/OCNsVPQQ+IvH1jafM56yDv+lIM0D52xghQtwCKjrw911j3qpMqCbdftDRUkbuo8/MIy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf4bEjx4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf4bEjx4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 428D3C2BCF4;
	Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785991537;
	bh=bAaTk4jjY1AcRN0tzZgeyd0ZFfZYjo/TJnyi0hH0QLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nf4bEjx4nN3npxssqVgl6MWoz34O8xTALlLFbgzYyJpkix9TTHhPPlHPeLjxq5nN+
	 ndzTTSRe9DHMmQQLEkhQ9PSjtcZnwzLHyWZb9+NCHWKCTPRwYReYdU4nQDSp2KPgR/
	 4e9YmltygW8auCH8yMsaZKfUuIkCOP+tKH0HJTOPlbzdfQ9z+2Yj8Wz456MfuXXKwm
	 a9BQQ8a4/dg6PqtBkJJKCQJdm08AVMw+CDtIPyXjyqYsLCSCYofF4MOepzkJs85Bp/
	 ib7wBNon97cLBe/aeykvXBbP99UFBOrFa/MWvwtdmbtevbe92AFRg6oZt5tdDHQCnD
	 FMja714BA/jOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238FDC56205;
	Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Thu, 06 Aug 2026 12:45:25 +0800
Subject: [PATCH 2/3] drm/amdgpu: fix VM update overrun on non-4K page
 kernels
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-amdgpu-fixes-v1-2-ce247012d4da@outlook.com>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
In-Reply-To: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=RZz+TFSeftgnMAQF9ZGjSUuynkvUNb8BqbEu73b+W2w=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBLB/OLTuwuNp3tJBO+8KlctJP3i6dLA+V+8Fh8+V
 tAbknUte2tHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cAXESO4a94HfMmCXVP5a4H
 wf17MkVZ/0x6x9x3Y6bxcWujI5HiU7czMvR/Ngl4lL7UZcnehNYtrj1bGqb/W8jw/uCje8d2el6
 s72MHAEbVS7g=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

The contiguity scan in amdgpu_vm_update_range() rounds num_entries up to
count * AMDGPU_GPU_PAGES_IN_CPU_PAGE, but count is only constrained by
the loop bound when the loop body executes. The guard
num_entries > AMDGPU_GPU_PAGES_IN_CPU_PAGE proves that
tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE is at least 1, while
the initial count of 2 needs tmp >= 2.

Each iteration consumes a multiple of AMDGPU_GPU_PAGES_IN_CPU_PAGE, so a
mapping whose GPU page count is not a multiple of it eventually reaches
an iteration where num_entries is above AMDGPU_GPU_PAGES_IN_CPU_PAGE but
below twice that. tmp is then 1, the loop body never runs, count keeps
its initial value, and num_entries is rounded up past what the cursor
holds, tripping BUG_ON(size > cur->remaining) in amdgpu_res_next().
AMDGPU_GEM_VA is DRM_RENDER_ALLOW and amdgpu_vm_verify_parameters() only
requires map_size to be a multiple of AMDGPU_GPU_PAGE_SIZE, so an
unprivileged caller can reach this. On 4K page hosts
AMDGPU_GPU_PAGES_IN_CPU_PAGE is 1, tmp >= 2 always holds, and the bug is
unreachable.

Clamp the rounded-up value against num_entries, mirroring the min() that
amdgpu_res_first() already applies to cur->size. A contiguous short tail
is then mapped in full, and a non-contiguous one falls back to a single
CPU page so the loop still makes forward progress.

Fixes: a39f2a8d7066 ("drm/amdgpu: nuke amdgpu_vm_bo_split_mapping v2")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Found by code inspection; not tested on hardware. I have no access to a
64K-page host with an AMD GPU, so the BUG_ON() path was not exercised at
runtime.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dc6a9d7dd0b2..365a1c4a4527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1193,8 +1193,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				}
 				if (!contiguous)
 					count--;
-				num_entries = count *
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+				num_entries = min(count *
+						  AMDGPU_GPU_PAGES_IN_CPU_PAGE,
+						  num_entries);
 			}
 
 			if (!contiguous) {

-- 
2.51.2


