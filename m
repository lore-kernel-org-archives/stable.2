Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F16370D5E
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732918; cv=none; b=c3NGL/q/SBZb0uU4smlerbbkzo6uvpqbJ0Ga259/ovPtkIPr2BzinBSXyoAuvRYR4jHFzEqkg1MlJ7rvYE5IEl83dG44UdbtaUO5ue7Flw4koU8leIeONtdFqpnun0gaS+BlgdFSAuh1QL++8Q+duEqK4GI3JXyjWRS/VS2r+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732918; c=relaxed/simple;
	bh=JZZD8FCX7+TEbr6LaAm2+ZwITRqsq5TQ4VDbzz/7fIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu3WInYjSBuvh78pyfgfminY5QHw3IpBwnPPrqWbOZ4PpQQYcZsQxRs/qnTjljzAEe91N+x32Z9g/H0p9LB7DQmVrcAYlTwcUY8r61Qyt4Bx4W02ZLWKVFyD6jFy5kMettajSOaBnSl7bZKGRJbF2qq9vC3/f7ETgPWt4FAjCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPB9H572; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPB9H572"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546A81F000E9;
	Fri, 14 Aug 2026 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732916;
	bh=v7BqxY2Czd6m71rmcVYAGVmpG9PQ6kArqBSmQ+e4U8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPB9H572HhEXEcMC0jp5190yYEIzhNrEfkLBouz7wgbrZrecLeT6EQeyodZYdJDpM
	 dkIaK1lUJmtdBh0SK5xH9VBdlhl9oUaCad9rrkFv7MkV6M3jc1+y7TPzcqqNRoS5bw
	 axNJfdAdqvxt5TZDtf/fsnq/24k76pAqhpRsLYhz3vBv4Q7znAd46h8crwed9F+jx1
	 3F0U4WosKIaneLI1o43NjZOfJvuCHLindcXfwP8vRyO5Zr3R7gRchhpRRJj3x99VDV
	 Zwn9u21GmfoPdHDvtYn8dNxJw0sQUeeYNKz4+vQc9Cq7l0PWdwGL4X4I6qdXkrmb5/
	 8POIxTJlDFvNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amd/pm: fix torn gpu metrics reads
Date: Fri, 14 Aug 2026 14:41:54 -0400
Message-ID: <20260814184154.288347-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080525-manor-gully-805a@gregkh>
References: <2026080525-manor-gully-805a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 048f4541b71fb19645fb79d6e62e6e4da23a4035 ]

amdgpu_dpm_get_gpu_metrics() returns a pointer to the shared metrics cache
after dropping adev->pm.mutex. The sysfs path then copies from that pointer.
Another reader can refresh the cache in place during the copy and return a
snapshot containing data from two generations.

Pass caller-provided storage through the DPM interface and copy the metrics
while the mutex is held. This keeps the cache pointer private and makes each
sysfs read observe one complete sample.

Fixes: 25c933b1c4fc ("drm/amd/powerplay: add new sysfs interface for retrieving gpu metrics(V2)")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 862333bb48693ecafcae25af0c9d9ec31015ac77)
Cc: stable@vger.kernel.org
[ applied the fix at the caller `amdgpu_get_gpu_metrics()` in amdgpu_pm.c since the `amdgpu_dpm_get_gpu_metrics()` wrapper is a macro on this tree ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 23f3cd9f2e8b0..d8b0c13fc42a3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1804,18 +1804,16 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
+	mutex_lock(&adev->pm.mutex);
 	if (adev->powerplay.pp_funcs->get_gpu_metrics)
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 
-	if (size <= 0)
-		goto out;
-
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, gpu_metrics, size);
+	if (size > 0) {
+		size = min_t(ssize_t, size, PAGE_SIZE - 1);
+		memcpy(buf, gpu_metrics, size);
+	}
+	mutex_unlock(&adev->pm.mutex);
 
-out:
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
-- 
2.53.0

