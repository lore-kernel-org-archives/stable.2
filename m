Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331726A08A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580464; cv=none; b=lhvVLcF4jAXWHv7IH4cIL1637oZeR23dEWtngcjCHPvdSqSrgXjaoOTd74HkycriafBItemS7wBVzNVOEk/JC9hG/D5sR4GBTHKBNeCBh0PwNmZ56W0fgp/Cbj3/uom+xfQHqrzRyTzgQyX3JlLpDVbcPg0MTyRRtekYvhoVCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580464; c=relaxed/simple;
	bh=sIkuqp22AMMKxh1qkZ/MBaLSMhKzRaMfCAqgjpyRjp8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BobWTXJue1+c1oR87cAOrynsgBZKucmqjSIK9YaT2L0PUqSTdDJPG19tus46J+m2cM9d+39D3fodQ1OBh8wONWcY+K21JJWlZFRifWRXkXx8ldHSPYs4m6yzdC87lCn5/5cKMZfRmeCQI68ujYB1SknVRQ7iHWs+9EjOyCchDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dsd+jtfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dsd+jtfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF091F00893;
	Wed, 16 Sep 2026 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789580453;
	bh=j0OL3HFi4iimrSJIHbpIKu43XQB3NIpyDJkMaPdNUrQ=;
	h=Subject:To:Cc:From:Date;
	b=Dsd+jtfpVzkCClRHUc2GVAn4lPNVXT7GaOMq1tfAgCJevaKOXsfD0rVZJjQXgHU7v
	 wyh2VGISJ6ZiLUVeePBDe5PD55zFaX6+kXqJdxA2WqCHENsl7xOjp77i+zfdqQbf47
	 WEEowqorxj6wLFvWI5J0SV2/1vvDDCMHcOJfPyms=
Subject: FAILED: patch "[PATCH] drm/amdkfd: Don't acquire buffers during CRIU queue restore." failed to apply to 6.12-stable tree
To: David.Francis@amd.com,alexander.deucher@amd.com,david.yatsin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:35:10 +0100
Message-ID: <2026091610-guise-theology-7efb@gregkh>
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
git cherry-pick -x 1cafa8b29e029eac3ddf64604f891b35dbf6262b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091610-guise-theology-7efb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cafa8b29e029eac3ddf64604f891b35dbf6262b Mon Sep 17 00:00:00 2001
From: David Francis <David.Francis@amd.com>
Date: Tue, 30 Jun 2026 09:58:18 -0400
Subject: [PATCH] drm/amdkfd: Don't acquire buffers during CRIU queue restore.

kfd_criu_restore_queue's call of kfd_queue_acquire_buffers was
failing for multiple reasons
- The ctl_stack_size set by the CRIU plugin doesn't match
what is expected by acquire_buffers
- The svm buffer cannot be acquired at this point because
CRIU may not have restored it, or may have restored it
to a different address.

The only reason acquire_buffers was necessary here was to
avoid a null ptr dereference in init_user_queue.

Just put in a check for that dereference; it doesn't appear to
come up in real use cases right now. That is, there is no
usage of CRIU with shared MES.

This is a partial revert of
commit 20a5e7ffdfec ("drm/amdkfd: Properly acquire queue buffers in CRIU restore")

Fixes: 20a5e7ffdfec ("drm/amdkfd: Properly acquire queue buffers in CRIU restore")
Reviewed-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 002a374d224c..97e77a5a35e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -265,6 +265,11 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	(*q)->process = pqm->process;
 
 	if (dev->kfd->shared_resources.enable_mes) {
+		if (!q_properties->wptr_bo) {
+			pr_debug("Queue initialization with shared MES requires queue buffers to be initialized\n");
+			return -EINVAL;
+		}
+
 		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
 						AMDGPU_MES_GANG_CTX_SIZE,
 						AMDGPU_GEM_DOMAIN_GTT,
@@ -1052,18 +1057,10 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	memset(&qp, 0, sizeof(qp));
 	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_mask));
 
-	ret = kfd_queue_acquire_buffers(pdd, &qp);
-	if (ret) {
-		pr_debug("failed to acquire user queue buffers for CRIU\n");
-		goto exit;
-	}
-
 	print_queue_properties(&qp);
 
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
-		kfd_queue_unref_bo_vas(pdd, &qp);
-		kfd_queue_release_buffers(pdd, &qp);
 		pr_err("Failed to create new queue err:%d\n", ret);
 		goto exit;
 	}

