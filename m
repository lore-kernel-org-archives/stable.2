Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9522D5C7A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136190; cv=none; b=X8nUzHDWGSErY4hY2qENJs0efluA9eBNvnsx7m50lbD+5x7fxMs3Mq1ilsyBNsmliKW7uoTXwQiX8QtP3iKPBRRqjcJ4W4I4222X9ex5IWTPAlLxeRgMUnFhBDjatWyaNG2OP4vm3YtHqvcX2359VDoIecnSMMG6AVoeWMFun58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136190; c=relaxed/simple;
	bh=okggne/WwfobXSSEkO8qeggjxtx5MXTAiXOHhsEwIP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLjKZ3ffqPZOstta/4tSRaPsT7u4rwm7e4pg0HJMdTMuJoPBvyfS7fYORSOT4SVJbkrh/Kbwk9+/gNVEhHI4wKS99e4nOl6oz0ztFAgZhWxh0hmGD31Qd0vZTWqEGqO1TvQfpUMMtt99CmTls7HKDR9ZspCoQDH/nKfOe35D9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA6oxfP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA6oxfP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C62D1F008A2;
	Fri, 11 Sep 2026 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136188;
	bh=dWqBSV/wdZAYat+t3j7r6rG2oS81gD6xXvi3m8OnGRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EA6oxfP/gD1b4AMaXv4BVbbdOPIvv5ROsMh7Wpq871oLjiswqadqhW3yaLHO6XGj0
	 S/CPI3K2UEso42Dybywirr9+8xc6SybH1pJxb4R9r2edWvNTCYEobG3qOTonnJr1Wu
	 R6Q6+PE80+YpOp8HkChebwUwcZUwv3dh9T8VAv3z2myFv3GrKMCZpdncjfcYhfdyc2
	 9IysVJ9EM4w3L4y7nBdeQYrgnoSJ2i41L02XplYh0KBghrd7EEBlngsw4N1mDDQ3/4
	 ZWbSKufFDRtwdYgB1/2XFw06EEemJYreOmpBOJcWQIlBNif1fOJkxRx5y1cRhyWEHL
	 tjeClVVivCIwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: qla2xxx: Initialize NVMe abort_work once at submission
Date: Fri, 11 Sep 2026 10:16:26 -0400
Message-ID: <20260911141626.765367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090908-emblaze-startup-caf3@gregkh>
References: <2026090908-emblaze-startup-caf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 7e85f6dbc85616de2172bce8eaf84b387a723cd1 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 622b11660b67c..2c1b17a594206 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -309,7 +309,6 @@ static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -347,6 +346,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	priv->sp = sp;
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	nvme = &sp->u.iocb_cmd;
 	priv->fd = fd;
 	nvme->u.nvme.desc = fd;
@@ -391,7 +391,6 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -657,6 +656,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	sp->priv = priv;
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
-- 
2.53.0

