Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29C36A033
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780283; cv=none; b=rq3Xu1+z6kpegLVxuy/R1CsdisCFqtuYSl8qWBpQUMEPQVr/SSrK3bGMoeXh051yatXKIS1hCINtixO1xbVR2DiCe8qRNAokT+wjv/0vYDfQG6dTgSsB8iRuvaIPMrlaI0anfq4BQE1VC0iZJu/RDsf1zxYorvEhf+LA158eWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780283; c=relaxed/simple;
	bh=eeog8faJ4jm4hF+bPOAZxzhy80Dp06l2UFfBG/d/xYE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JKn7dVWc1A1tEBYBj1s6ak4JNyrs1W3mo3NDIhxcUHW9DiyD/mQfpmxv/v1OnNfw1l8xRHOOLqYerr/r6eanC2ke2D4JkoFcGXbps63nQxeQvTi4VhqIFeiooGKBu+4mwiW4arHoMvE8qJrJP7zC+CRt/LU5h+IGY6Zd3nG8ws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GgfF06ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GgfF06ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A795E1F000FF;
	Wed, 30 Sep 2026 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790780270;
	bh=OTfp4UvHimenvbTC6AjEzOuYTbWfSJWJdouVDFFsjKU=;
	h=Subject:To:Cc:From:Date;
	b=GgfF06NDwtmdnbYMvofPReqD7CJKOVe10cbYXi7TmfPVKYcKXCMtuEwV+9KOb1O7p
	 XMW4fgLIBKrVLFKEI9v3lQx9+EnBh6+qSzmYCDUE+OvJWoYo0FJ3yreDP8nelqyZ9j
	 5Kq4hq5goPDPUfIrPxXLRMEEo5fRSMVLNG18YZ90=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Retain job->vm in amdgpu_job_prepare_job" failed to apply to 6.12-stable tree
To: YuanShang.Mao@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 16:57:44 +0200
Message-ID: <2026093044-poach-unloader-d7d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c00d8b79fd2167c6ac65e096619535acdf8678d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093044-poach-unloader-d7d9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c00d8b79fd2167c6ac65e096619535acdf8678d5 Mon Sep 17 00:00:00 2001
From: YuanShang <YuanShang.Mao@amd.com>
Date: Wed, 23 Jul 2025 16:44:49 +0800
Subject: [PATCH] drm/amdgpu: Retain job->vm in amdgpu_job_prepare_job

The field job->vm is used in function amdgpu_job_run to get the page
table re-generation counter and decide whether the job should be skipped.

Specifically, function amdgpu_vm_generation checks if the VM is valid for this job to use.
For instance, if a gfx job depends on a cancelled sdma job from entity vm->delayed,
then the gfx job should be skipped.

Fixes: 26c95e838e63 ("drm/amdgpu: set the VM pointer to NULL in amdgpu_job_prepare")
Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ed76936c6b10b547c6df4ca75412331e9ef6d339)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e6061d45f142..9b1c55115921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -365,13 +365,6 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
 			goto error;
 		}
-		/*
-		 * The VM structure might be released after the VMID is
-		 * assigned, we had multiple problems with people trying to use
-		 * the VM pointer so better set it to NULL.
-		 */
-		if (!fence)
-			job->vm = NULL;
 		return fence;
 	}
 

