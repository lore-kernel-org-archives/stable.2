Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6542464A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562235; cv=none; b=a4CjXJDRWOTR2ZSBBk9+8bxna+c9m20kMV0SFR2EDb2FV6i25pv/4DE4PkO4TjwcnFOAFLCrdWmo1m0jEBfBYRbqosrCndmJ6iWLajth/PyYyG6TtC5RatmmSHve1H12zDG8olOTm9OrlcsUSOkdQQFRDtG/g/6SGijbRUzyOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562235; c=relaxed/simple;
	bh=VqVsTNmteqEDTg5+w/l7KtVyI1QMZqWj+/7T/2ZjM6Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BPir0Aq5DVqbheWNOKghlYkPwcF6PZe3N9/yaxeyqMi1fAA18zj/pk0IogjRrH6YA7vlvXqzYbwAZE1UlPxrsvVYftiVnU37IBYRfnEt5Z/UC7qKkED7s4R0XhhwDbK9wKvVZW4OFw2W3X8M0m4unb7gKZDQvrgUKfoPS6wdK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVpvLTYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HVpvLTYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11531F00A3F;
	Mon, 20 Jul 2026 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562234;
	bh=LCXOXHXTz9BiefmADJsV3CpwhytTbt5CX1TmAaLySx0=;
	h=Subject:To:Cc:From:Date;
	b=HVpvLTYi1rQ4Dqk4CdrjC1m/YnIEKftWZ/gYlMxpegm9kFrULFt9ePBSAlny5OCsu
	 UyQBuZXbROnOp7PLgM6JBm25mDnjpuY0g6vhngz76pOKrBP/jqreJq8S3EKj81TGzf
	 EvoYzCsdASG3S2eI+DNn78GxbjwkZuOAiRGKiz4g=
Subject: FAILED: patch "[PATCH] accel/amdxdna: reject user command submission without a" failed to apply to 6.18-stable tree
To: doruk@0sec.ai,lizhi.hou@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:30:40 +0200
Message-ID: <2026072039-spouse-automatic-c20e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 261c1fe3327ad24508f54552c6366e3e4db82c15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072039-spouse-automatic-c20e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 261c1fe3327ad24508f54552c6366e3e4db82c15 Mon Sep 17 00:00:00 2001
From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 19:30:28 +0200
Subject: [PATCH] accel/amdxdna: reject user command submission without a
 command BO

amdxdna_drm_submit_execbuf() passes the user-supplied command BO handle
straight into amdxdna_cmd_submit() with drv_cmd == NULL. When the handle
is AMDXDNA_INVALID_BO_HANDLE (0), the block that fetches job->cmd_bo is
skipped, leaving it NULL, and no check rejects it on the user path (the
!job->cmd_bo guard lives inside the != INVALID branch).

The job is then armed and pushed to the DRM scheduler.
aie2_sched_job_run() takes the drv_cmd == NULL path and calls
amdxdna_cmd_set_state(job->cmd_bo) -> amdxdna_gem_vmap(NULL) ->
to_gobj(NULL)->dev, a NULL pointer dereference in the drm_sched worker.
A process with access to the accel node on a system with a probed AMD NPU
can trigger a kernel oops with a single AMDXDNA_EXEC_CMD ioctl
(cmd_handles = 0).

Only internal driver commands (SYNC_DEBUG_BO / ATTACH_DEBUG_BO)
legitimately pass AMDXDNA_INVALID_BO_HANDLE, and they always set drv_cmd.
Reject the invalid handle for user submissions (drv_cmd == NULL) at the
submit choke point so every user path is covered.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260713173030.87541-2-doruk@0sec.ai

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 8f8df9d04ec5..a5c8c2c4de6d 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -603,6 +603,16 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 			ret = -EINVAL;
 			goto free_job;
 		}
+	} else if (!drv_cmd) {
+		/*
+		 * Only internal driver commands (drv_cmd != NULL) may omit a
+		 * command BO. A user command submission with the invalid handle
+		 * would leave job->cmd_bo NULL and later fault when the scheduler
+		 * dereferences it in amdxdna_cmd_set_state().
+		 */
+		XDNA_DBG(xdna, "Command BO handle required for user submission");
+		ret = -EINVAL;
+		goto free_job;
 	}
 
 	ret = amdxdna_arg_bos_lookup(client, job, arg_bo_hdls, arg_bo_cnt);

