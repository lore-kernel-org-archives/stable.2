Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B94A49B3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106508; cv=none; b=qYDTMCjugbIC/AHsSV1c+vIfT2+OCjI4wLt1IsEbOjkxe/+3oOUtr6njQ64WOf5X6EYX8aJ2EPX14UbC0wCxm6crZAq1COImIuKtVQ3zZX/nHeODe3h6e1w11vpm5gVWh4AisuS4qcmxrmzHbCSiS9kb14Ze/QaQoToC6oxYkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106508; c=relaxed/simple;
	bh=TEAurWvQbQUPyAjL2iSFoPdVUgx+SsEg3JzqiAf8YYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6VvIxf0QWMfvTXSx4RsrFVku3RsNVbUB1NW57lq9f9y3Xldbj8FGTb+Ec8tWH1wUS2jwazfryQH+qKmXpHFK2UzjsmB9BvRdCuylDIIKcMsE0jwgJYsCghu17xoKOs1RsnCjb0XEz5UiPKxbT0dkDrncazQ6Raijchn0tq6UMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz8o/bXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz8o/bXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2509C1F00893;
	Tue, 22 Sep 2026 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106506;
	bh=eWAueWD44ROCiObo5Bmj7XjbrRxWDx94qrrTCzUWFzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hz8o/bXqWM0Z7HoHhFm6pxoY7mZwGyH4OMf+qsb9SBY4ToofbM/csG9JPpxitBi4g
	 SrQEnj+BPEiSHjbfJBhhdGSSdSZxcCi4PGyMXJYpT3h/OQbHVWCK7tWn5tdUzH0Pvj
	 gjwE5IVQLHrOtTjtnNH9bHZVKrQ8r46Zfjd95NmMPqzPVMsibVF3HoYWPVwQjXdlx8
	 FGmt/bnyPaeEB9VmgAWIJhHvApIOuCSOE2otDjPFRSFeHvMth/wfMDEMRJy0nM40I+
	 PHhSQ+ANTzoMbQYQfBEkEoV1gDOI2nFvwWjiA6ZNfmDkSdBJWRxyYYgnYHFVKVdpqz
	 d6BuxHj7mFyhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] drm/amdgpu: set the VM pointer to NULL in amdgpu_job_prepare
Date: Tue, 22 Sep 2026 15:48:20 -0400
Message-ID: <20260922194824.87651-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194824.87651-1-sashal@kernel.org>
References: <2026092241-jolliness-reputable-efa6@gregkh>
 <20260922194824.87651-1-sashal@kernel.org>
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
index 99e9e96f5b7fd..56b6df3b9bb27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -368,6 +368,13 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
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

