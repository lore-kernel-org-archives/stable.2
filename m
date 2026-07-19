Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A02D12ED
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784463224; cv=none; b=pFHwQqaJpU321Tj6JIf3W0CnMmDnHic3ZQ6h1MBFfZS9CtTc/fJ2j8akSWYUaN+b0TVAJJ6Q5KykVOdLUkSbUkNZ2FqEoE1QHGCHmVTwguq/DB8kUayodpGo2V9OOCAmGLmuG9o8yqW3Wms30OX2Eqa2nRbJu1CG6h9NLcM4DuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784463224; c=relaxed/simple;
	bh=2bQ/pzkonynMaCzsHvmAS1tkNd9DUj8cbUgTChb571k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qmLpLiGSE+lMAMxkq94ph9tfv5NMB89YUjnpazpYMewUxsd2fzD7i+hKu39qpKbzuidwDtDyyQWm5RWb1dqJ+GDedHqSXy1MpLKNpqFPBKFTR1Q9wPZ02ANDHhk/L5ltdF7T4HfnVjVSUetMtcDx2U0o3uTfxVN6qZRTzlgHKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lywGmR5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lywGmR5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579951F000E9;
	Sun, 19 Jul 2026 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784463222;
	bh=psB77nNHagaHGqE6JxVc/8QthLvjvU++iwDkcEsWZ34=;
	h=Subject:To:Cc:From:Date;
	b=lywGmR5LBVhUYna1RfOYlWVyt2WPjIpIlLr+Fl6kQpA+IfgJonCah4hew2ithiI6c
	 QmOyvG5DY636fME79VdIA+r2wTfv3jnL6EmBjkbv+6MJ+AJzKRdluuiFoIDXNXcNvA
	 cfoyOVkE5aDnEXHhHvs4fLN5vuR/v9vGPEv11oPs=
Subject: FAILED: patch "[PATCH] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in" failed to apply to 5.10-stable tree
To: kumar.shivam43666@gmail.com,hch@lst.de,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 19 Jul 2026 14:13:26 +0200
Message-ID: <2026071925-skimmer-retainer-3785@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4606467a75cfc16721937272ed29462a750b60c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071925-skimmer-retainer-3785@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4606467a75cfc16721937272ed29462a750b60c8 Mon Sep 17 00:00:00 2001
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Wed, 18 Mar 2026 18:56:58 -0400
Subject: [PATCH] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in
 digest error path

In nvmet_tcp_try_recv_ddgst(), when a data digest mismatch is detected,
nvmet_req_uninit() is called unconditionally. However, if the command
arrived via the nvmet_tcp_handle_req_failure() path, nvmet_req_init()
had returned false and percpu_ref_tryget_live() was never executed. The
unconditional percpu_ref_put() inside nvmet_req_uninit() then causes a
refcount underflow, leading to a WARNING in
percpu_ref_switch_to_atomic_rcu, a use-after-free diagnostic, and
eventually a permanent workqueue deadlock.

Check cmd->flags & NVMET_TCP_F_INIT_FAILED before calling
nvmet_req_uninit(), matching the existing pattern in
nvmet_tcp_execute_request().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4b8b02341ddc..69e971b179ae 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1310,7 +1310,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		nvmet_req_uninit(&cmd->req);
+		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+			nvmet_req_uninit(&cmd->req);
 		nvmet_tcp_free_cmd_buffers(cmd);
 		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;

