Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291554281A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953085; cv=none; b=fUx/hpFAreTQub7Yo+3u/LxAVJEdsu30V93MIqUDCGlXCkqXd1vv21ekpDjvjAmnbaSS1H+Xt9MmbrxcQo97l6CfSDMdwAG3K1HfCrX/eYTIRlhtEI5d9sR6Mn+MJFJXR5lHuRojFR7MbL0Ii/QOlsz/FmDRVA72aeYOi8BUDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953085; c=relaxed/simple;
	bh=HirxCUT/fxG4HrV99J/6LhOJJRDgSwhUT+nCL3jcAZk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VAVRp2uD4LwbkLxAXaINqgzIjmYpIXE4iCEOXg2E3ZfCrFnb7l/zNe/eXd9C0Sififzp4b4Dprhx8fRQH2FDF5FcsTPkviWZarRmCtiMyPJ8VVxUpPtrg6muBK0tKkrLdDI2EeB58ZebDEcsIj1Vg78R28GhU8xfmjtSD3A6Zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WfvY+Skz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WfvY+Skz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0F41F00A3A;
	Wed,  9 Sep 2026 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953083;
	bh=IrD/vXZiSh9U2JeFPIdxHUSPCCxczGNg7UtmILg5hWc=;
	h=Subject:To:Cc:From:Date;
	b=WfvY+SkzNPULRQ+cwGMyz7zc3aqHVIQs0bbee6CGoTsoh2GPUX7dyZJXo7GwbA2FJ
	 GDIa9vgOZmuTld9R2p/tAApdvjgHZinH8WbeJiEh+UAT9txvZ1QmGrQoCeqWG0OWoN
	 OW+TNzLXueD2cjqF/6nvYaVYH9NasS8nma3ireXk=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Initialize NVMe abort_work once at submission" failed to apply to 5.15-stable tree
To: njavali@marvell.com,hare@kernel.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:16:08 +0200
Message-ID: <2026090908-bankbook-slinging-010d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7e85f6dbc85616de2172bce8eaf84b387a723cd1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090908-bankbook-slinging-010d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e85f6dbc85616de2172bce8eaf84b387a723cd1 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 23 Jul 2026 10:34:08 +0530
Subject: [PATCH] scsi: qla2xxx: Initialize NVMe abort_work once at submission

qla_nvme_fcp_abort() and qla_nvme_ls_abort() ran INIT_WORK() on
priv->abort_work immediately before schedule_work(). INIT_WORK()
reinitializes the work_struct, resetting its list head and clearing the
pending bit. If an abort is issued more than once for the same command
(for example, concurrent transport teardown and a timeout-driven abort),
the second INIT_WORK() reinitializes a work item that is already queued,
which can corrupt the workqueue list and lead to crashes or a looping
worker.

Initialize priv->abort_work once at command submission, next to the
existing per-command spin_lock_init(&priv->cmd_lock), and leave only
schedule_work() in the abort paths. schedule_work() already does nothing
when the work item is still pending, so a repeated abort no longer
disturbs an in-flight work item. The command is not returned to the
transport until the final kref_put()/release callback runs after
abort_work has completed, so the work item is idle before priv is reused
and the single submission-time INIT_WORK() is safe.

Fixes: e473b3074104 ("scsi: qla2xxx: Add FC-NVMe abort processing")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-52-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 0038b6274d44..3b2f255a5d7d 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -463,7 +463,6 @@ static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -501,6 +500,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	priv->sp = sp;
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	nvme = &sp->u.iocb_cmd;
 	priv->fd = fd;
 	nvme->u.nvme.desc = fd;
@@ -545,7 +545,6 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -877,6 +876,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	sp->priv = priv;
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;

