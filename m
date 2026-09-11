Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6D357D17
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136674; cv=none; b=jaQ9BTuz16o/MdRlfh2mhnGj6f82XuASTLRSfxe1nfxEMV2xa0EOtFMV2R2MgchI/52uhpTBTdvnopXmqFpYJeMKoRWeo4wLErZQcLCTzoQhFge/MdheOKqsbMeJ7aMryd/fWOr4C2EILzuJXs12tdoBK9XT8ij8LNa4UaWJkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136674; c=relaxed/simple;
	bh=3QmCsBKpdonYlt1l4m/v1Az1Uv8rst/q4yK2IT30KoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGFIuIp9fRl0LxUlnkO6lR/kdZ82YiTpA8gLMi4EBp+QWcuWFkLO9cdHPTSh9GcHWPE+WAYbrx+oSSuRbsYK7bs3SmLQOfhquz9w/0ru3BIB1uJAakif3Yv7rLGG0k4A9ai/aMfnaAiBLt2YQ57OSp3VauBAuGZvhUC1ZxMwVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KStCGop9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KStCGop9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D61F000FF;
	Fri, 11 Sep 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136672;
	bh=nwDGRJWAGtg45xD5wmYCSGtjeuTHdCU1Y8iRJyBimvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KStCGop9Wo8nRrAcOl2Ijm7bFSdZzSBQNL5dMjTdPIVgznGpnRKFw07qT8bAQkJs8
	 2YD0oqdcTQAOU1evKZucavjACAf3H6F/EKP2Kf2xxZARcefHWTmWZcJtJ8nAGyBebD
	 LtYmbOQOcCd78xZaS9xxnIzU0+xzzro218jKjIqBn8sI2dI1CYN4vG+uvcve/BvM/D
	 Ykkj1vh4IW+gYn59h5UnMPf8RFO7Pv6BTPwej0nGqfuOjCFTDbb7xDz35saJF5nWZZ
	 IbZiHEOL8f2N4IN2avfFbVPo27RvAqz0RBUG7JXyuygMlTzIaHTyg737RSgCf8n/mE
	 sw42yTE3WgBaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: qla2xxx: Initialize NVMe abort_work once at submission
Date: Fri, 11 Sep 2026 10:24:30 -0400
Message-ID: <20260911142430.894469-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090909-gaming-dwelling-9e59@gregkh>
References: <2026090909-gaming-dwelling-9e59@gregkh>
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
index 28a5b40e0f329..45fa0e2b78353 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -278,7 +278,6 @@ static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -317,6 +316,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	priv->sp = sp;
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	nvme = &sp->u.iocb_cmd;
 	priv->fd = fd;
 	nvme->u.nvme.desc = fd;
@@ -361,7 +361,6 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -600,6 +599,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	sp->priv = priv;
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
-- 
2.53.0

