Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFF353A87
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136545; cv=none; b=gn42MiNHZFt4++vf1tjAwAfD4uXAKFW6Psq6nxmT5WGyXi5sYxh/W7ZVYNL/8IxZrMiRcM+nOGhExxv+jsN/id0Vn1GdIyVFaZ8GNJrjzh/bKbiJZUsIVWxSOE6yEeuP/QHSyoGOwKRL4iIL3M7HUfr5b9pDwVcvTmozs9zQSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136545; c=relaxed/simple;
	bh=cJn4LO8ePH8ipEt+QESDuffyLxn6TC0nk9Rdt0c+jjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9O0VjSr+kPS3iDiH+5u/tgJ0cTXHwziqeC5jBiTOCUv6Q5aXLzmkHzVClQDt/WujqfHQX3HIdEzqcDe3XrCBVPBGSOSCXs6i/7+j8oirncw4D7we/DVgYNGvpOmS/B6ekVu7Wc6nnfSoj5nWjYvVwfqvVseJv4T/Aw9Wq2somI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBNeRiL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBNeRiL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3628A1F00898;
	Fri, 11 Sep 2026 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136543;
	bh=ASN2ZPY7SRQGJpOz68DeS3yJuMzMRCfpwK40Wt7Kv4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cBNeRiL8FiVb2aZT+8OsujttlozysxGKSwe4U3Mv+rMgNeIOAvyN6Hj/r4XH/m4xQ
	 /10/LeZ54FrlIQ8NZalvKnTdxP5/Fb0jS10e9dw7I955HepcBJNETX3SMjg82QItXE
	 P0RHDawQXRE3ICZe9sjSai1RLZ5XfUIBK+MObWjhQyn1oOoOk/GBTVq1F/DNzPcwDi
	 J7ziYOIxWQ9Jjh7huFSY5UPqzVAoxH3q1JbeHYA42lUW5GY2wIZc/UZ62O9HTUm3/D
	 CCOn2IrActdhEjXvuHirQSIPX+sb8E9HsHF0eNWd+EM47kvAAB9WX9lmwkqLW0J+FW
	 TmKQSFjAVz05g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: qla2xxx: Initialize NVMe abort_work once at submission
Date: Fri, 11 Sep 2026 10:22:21 -0400
Message-ID: <20260911142221.889690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090908-bankbook-slinging-010d@gregkh>
References: <2026090908-bankbook-slinging-010d@gregkh>
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
index 9746f6debdcb4..f286254ec7750 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -304,7 +304,6 @@ static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -342,6 +341,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	priv->sp = sp;
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	nvme = &sp->u.iocb_cmd;
 	priv->fd = fd;
 	nvme->u.nvme.desc = fd;
@@ -386,7 +386,6 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	schedule_work(&priv->abort_work);
 }
 
@@ -646,6 +645,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	sp->priv = priv;
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
-- 
2.53.0

