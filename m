Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5E35E1BD
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127617; cv=none; b=qOIq7Ly8/Hl1qSHKGhe1OmodghHGPoNzrXGwnqkKCYV8taLxLQsBcMT6I5c5b5VJwUaSRZ1mKxYXnsaViDwbNDuh0QPx/n66sUC60itItLYTuFdBhEymH5bSsFSlJiDQgFYV7N1gXiyjsnuq+ll6qJjJAhgdc2c32CwsQ6aVNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127617; c=relaxed/simple;
	bh=UgyFD6lp1zHiERq2zX8zZaVtmZT7tjS8+zgyGRO0cYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfJEa2NKpaBDILsXJlGdWWO8UOrA68x+JKW6HZLh20Be2TBoiC0p26liiftVvxEavt9eIOglO7znFtsh8kcfX4SQwqDdVFt22ncldXr9qvURg1A/QrgAqrdUq168rB51pmmnWfiWStjBoM7ja/k0L6Kq+ULB2D7nxIv/al+spjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av8lLQXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av8lLQXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FE91F000FF;
	Wed, 23 Sep 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127616;
	bh=cM80u3NsqIDzbgaZeFSOH+AsjtauYT1rz44AaHIO17s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=av8lLQXtIY5lsyqPVsDds7C7kUCWjvO1hF+CPrjb2IIukxEVcNsC1ysXWg3i7T7aw
	 rW2N4mDIWtwkGlPRyhKq3VLr/rkfTbSeQJtqpdsf6GGIuQEk31aYiNkpi3q+HTDhrm
	 BZc9GDAtxjg4Wd12Bq41Nlufcu9NeqSaq+QvAI2bJo0gzeP6DHPIbXqyvovlSjoex2
	 DzLDaWH2X6xqYLZvtFbmcmg58SUdUczji59ZnmjWMTaK9z4Ro7ywHZgFm8QHA5NJAQ
	 w+YlpyHQXpnONEWQG9iqyQ1YkabE0gyEFlT/UBw2vgYDcMA8W8KTpI7wresHWnxhJh
	 yES63fAq5LW0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] drm/amdgpu: set the VM pointer to NULL in amdgpu_job_prepare
Date: Tue, 22 Sep 2026 21:40:12 -0400
Message-ID: <20260923014014.880066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092242-mantis-dragonfly-bdca@gregkh>
References: <2026092242-mantis-dragonfly-bdca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 26c95e838e6301b0230430ec2fadeabfcb07aeda ]

As soon as the prepare phase is completed the VM might be released,
better set it to NULL.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 5155002b03b2 ("drm/amdgpu: fix rmmio iounmap skipped on device removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 8175d831abd4d..2648ee945ac27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -271,6 +271,13 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 			DRM_ERROR("Error getting VM ID (%d)\n", r);
 			goto error;
 		}
+		/*
+		 * The VM structure might be released after the VMID is
+		 * assigned, we had multiple problems with people trying to use
+		 * the VM pointer so better set it to NULL.
+		 */
+		if (!fence)
+			job->vm = NULL;
 	}
 
 	return fence;
-- 
2.53.0

