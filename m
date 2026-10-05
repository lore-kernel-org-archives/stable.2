Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBB4A3D2C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210738; cv=none; b=Bo5W4U+XIU+71A++knJSbIfgijKlsmFR9ncsEZfvD9euVdeLX5anJGo3b8ATT8FOrQM+P8KfHcWkMxn+pGLLFtePKPO7tAdWy03ysxN3pFtQEY3Ud9ocAAFDgDRt87NvsPc3+gutCxjFWoix3wY94r6/Mlgp2KH7G+zRHq8snx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210738; c=relaxed/simple;
	bh=qDNxMmt67X/T+rsz4B4YzZASa6MLnFkif3jcKIW3T2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XpbYOld379euL1ohW2Doo6DfM5W9zWDyPLzCwUPGlfWekCcaNQbjoymKCW1S7JcDggx7+2RPngbDS/VHDjN2iEKFLhwFa0ewxmemS9Aea/55waLnuWQNXiMNXQngZ7/uviqvekRW2Y7xdDIC+lTivMvUBLM88G8hNdU14ixIKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJjemcMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJjemcMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35ED1F000FF;
	Mon,  5 Oct 2026 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210725;
	bh=4TSNStmQUJiRUdGB5fzkiqHUDOv4R5riJkcFwpaiygE=;
	h=Subject:To:Cc:From:Date;
	b=vJjemcMg159reGDmelTKDSHGOsujF/I31Y03ZC9xJuzilXZ0JYhblCKUF1lJ7qGz+
	 W/q9hZm+qMmWYrXCrjw16f5//df5EZkJdDmm1/q2YqpepKROQ+eMizAJd7+vSTFsTD
	 i5cPcYpPOvECIvA65xnue79c4+vIzADT2nC17318=
Subject: FAILED: patch "[PATCH] nvmet: copy the hostid into the ctrl before creating PR" failed to apply to 6.18-stable tree
To: kanie@linux.alibaba.com,hare@suse.de,hch@lst.de,kbusch@kernel.org,nilay@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:32:02 +0200
Message-ID: <2026100502-portal-companion-f7cd@gregkh>
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
git cherry-pick -x 5211fed41d7ec90e9ab7239dc4bffffe4d0b2b62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100502-portal-companion-f7cd@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5211fed41d7ec90e9ab7239dc4bffffe4d0b2b62 Mon Sep 17 00:00:00 2001
From: Guixin Liu <kanie@linux.alibaba.com>
Date: Wed, 16 Sep 2026 19:42:54 +0800
Subject: [PATCH] nvmet: copy the hostid into the ctrl before creating PR
 pc_refs

Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
implementation") added a second uuid_copy() of args->hostid near the end
of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
uuid_copy") removed the original copy that sat before
nvmet_ctrl_init_pr() instead of the new one.

Since then nvmet_ctrl_init_pr() snapshots ctrl->hostid into the
per-controller per-namespace reservation refs while the uuid_copy()
from the connect data runs later, after the controller is published.
The ctrl is allocated with kzalloc(), so every pc_ref created on this
path stores the nil UUID.

pc_ref->hostid has a single consumer: nvmet_pr_set_ctrl_to_abort()
matches it against the preempted registrant's hostid to kill and drain
the victim's in-flight I/O for Preempt and Abort.  The match can never
hit with the nil UUID, so whenever a namespace with reservations
enabled exists before a host connects, which includes every reconnect,
Preempt and Abort silently degrades into a plain Preempt: the
preempting host sees success while the victim's in-flight I/O is still
in the air.

Copy the hostid where the rest of the connect data is consumed, before
the controller is published and before nvmet_ctrl_init_pr() takes its
snapshot.

Fixes: 7b658153f1b8 ("nvmet: Remove duplicate uuid_copy")
Cc: stable@vger.kernel.org
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..8c8c8627871f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1648,6 +1648,8 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
 	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
+	if (args->hostid)
+		uuid_copy(&ctrl->hostid, args->hostid);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
@@ -1706,9 +1708,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 
 	nvmet_start_keep_alive_timer(ctrl);
 
-	if (args->hostid)
-		uuid_copy(&ctrl->hostid, args->hostid);
-
 	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",

