Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582C10F2
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761049; cv=none; b=n62muoGgLlOSHDCsr784PZTduk9DmexU71IzZJ0HovU4h2dDHKTfH3PKmlL6fDFxq4FuGZX7sq6QZFRuzDWir13Jpfkfqfy6NycbT11prTU+XnZlGEUS+mJLXkS8rhughKWRsHMitU7qED4F4FoqILQ4KqnOz5/HxzCGTNromRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761049; c=relaxed/simple;
	bh=spohH1Xjhn0D77w77Z10g2kBh8oQ2K9K2l/CtV45eck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW7Caral8/tRhm4SuhM0cs2NoMtwtUQal6HfD2mrQc/k7YmHVYuK8RKttBQSOB9gYd2AJufYu9IVm1EHoLDlateva+L1wUSSQ7Zoxg9m/QJdrvvPRiwD2R8DAMLwiTp0SA0T15ygXY9WzcrQfNGZpnrI1gM4sdnx/gmAtvw3DPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEtNYFhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEtNYFhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689261F000E9;
	Sat, 15 Aug 2026 02:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761048;
	bh=xJm20HeNKXU7pYJ6blq+7Ct51GVlb7Fg3zdI5+7kjEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CEtNYFhAdpuSs2g5IymPEQD8MrrNJnVXhM0lDcYarGbpIuTGdoBQG3AXjIie0XvWI
	 WTLQlaud2lGIN7bhl642MaH0XkbkzHvpHcKnjAUNKKL1x5I7U5izQfPr1EHwr3Q1Uw
	 6l4XYhTb+bw5FR4Ie73+xNCQlcjrLkLOEA8TRF5mz+1on3dKbGnoMUieLXkyObSuxT
	 iTa0HNvdwnN+de3d9ewhEVV19NBZT1vBoEXuVXtTlUmj32nGXrFzmizYnlbU9Q7xgn
	 Q9cxaGLioR4fpwoIVUPzEunWuvrszHLPOYYEnG3oOtxtvRtz5CynuvCzsi0A+iwJj/
	 X28Eo4Ia2u+5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/pm: fix torn gpu metrics reads
Date: Fri, 14 Aug 2026 22:30:45 -0400
Message-ID: <20260815023045.1436662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080525-prowler-kangaroo-7aaa@gregkh>
References: <2026080525-prowler-kangaroo-7aaa@gregkh>
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
[ applied the fix at the sole caller `amdgpu_get_gpu_metrics()` since 5.10 lacks the `amdgpu_dpm_get_gpu_metrics()` wrapper function, wrapping both the swsmu and pp_funcs dispatch branches in `adev->pm.mutex` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fb1aaf959e7c3..edda4081bd03a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1994,20 +1994,18 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
+	mutex_lock(&adev->pm.mutex);
 	if (is_support_sw_smu(adev))
 		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
 	else if (adev->powerplay.pp_funcs->get_gpu_metrics)
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

