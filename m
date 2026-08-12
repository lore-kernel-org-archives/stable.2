Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7D16A956
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493358; cv=none; b=W/A7ZU6nKF7VfzuCZeskJ+c2mVkkeuYC/5FLJqeSHT5a8ItXUD4Tbev10gnjIlp8EGuYeGfkWTQOsGRGRUlPNru+ZAdaJ75giHwWlUeFIp7l3M++M8ZaBvYW+69dTzz51ugrOTtN0z4nZK3Yfeg3gEIO0pnn8RMeDYX5WqPlqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493358; c=relaxed/simple;
	bh=6OuY+teIKrjsu7Imq6BoBpa2vvLVrBgUDA8vufDo5qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cc8sKfrVe2GrGo7nD4jQJyrJ5PgoEYqU55sphdRJVYElSZKkfrE95aOWEk7M3GKDEyl/QGoR3eWSp5ODMwT6/0BhuQBXGXf+IA01gqObMg3siJWrV2YEOqG7ew+/AObo6gAHElTzHVdsVqtJT2/YVM0AcGxYAAQdP1aPGg2xZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNZ7rcVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNZ7rcVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DD21F00A3E;
	Wed, 12 Aug 2026 00:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493356;
	bh=WxVO/rZLEjbGKDJ+K06EZtgYhThb9tDWncwAYrSqueM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KNZ7rcVyIBGCoM9TxRmJf6f0Jk4UO4vRYVY5PsQYBLS3bwgnzv1g21OQGpVfxnhFZ
	 3O2oGDwSoquM7oVqj7puAaAGBBInlb+nr1VjNLZpnBo3APg+bDqJbNTUsHhtUvbuG2
	 qwF1xHqs9SDle4lVSsoCHMYT5hvzEPAl81fPzXAJzUuAxKLiZ+fKZa30qG1zgZgqVT
	 8qfRZ5WlLQQkDZLzcCyToVpDayNK1T+rpiqgJtJ24S5bUItYfyRwqfRElbc7kU0adS
	 Pca5BMOESusFJ8tivpAL8ZwGXsFtfkHwoIjcEqOGsBnNT3aFVuMBnqXlrzea3RAR9Q
	 ec0eT68BG10lQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] scsi: libsas: terminate deferred commands on time out
Date: Tue, 11 Aug 2026 20:09:13 -0400
Message-ID: <20260812000913.4156796-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812000913.4156796-1-sashal@kernel.org>
References: <2026080541-eskimo-unpeeled-0c6f@gregkh>
 <20260812000913.4156796-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit de202d2251bc181c6019b1ad3c0ba8133e5ec68d ]

If a command times out while we have deferred non-NCQ commands waiting to
be issued, the SCSI EH task is not immediately woken up as the waiting
deferred commands are never issued nor completed, thus leaving the SCSI
host in a busy state (shost->host_failed != scsi_host_busy(shost)) which
prevents the SCSI EH task from being woken up. Eventually, when the
deferred commands also time out, the SCSI EH task is woken up and the
timeout processing occurs.

Avoid this unnecessary additional SCSI EH wake up time with the same
method as implemented in libata-scsi, using the eh_timed_out SCSI host
template operation. The function sas_eh_timed_out() implements this
operation and executes the function ata_scsi_retry_deferred_qc()
for SATA devices.

Co-developed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Tested-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c           |  5 +++--
 drivers/scsi/libsas/sas_scsi_host.c | 15 +++++++++++++++
 include/linux/libata.h              |  2 ++
 include/scsi/libsas.h               |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0445d8e920769..97ffdad4d6071 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1783,8 +1783,8 @@ static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
 		queue_work(system_highpri_wq, &link->deferred_qc_work);
 }
 
-static enum scsi_timeout_action
-ata_scsi_retry_deferred_qc(struct ata_port *ap, struct scsi_cmnd *scmd)
+enum scsi_timeout_action ata_scsi_retry_deferred_qc(struct ata_port *ap,
+						    struct scsi_cmnd *scmd)
 {
 	enum scsi_timeout_action action;
 	unsigned long flags;
@@ -1795,6 +1795,7 @@ ata_scsi_retry_deferred_qc(struct ata_port *ap, struct scsi_cmnd *scmd)
 
 	return action;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_retry_deferred_qc);
 
 enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *scmd)
 {
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index ffa5b49aaf087..7e0edf3f41f61 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -500,6 +500,21 @@ int sas_eh_target_reset_handler(struct scsi_cmnd *cmd)
 }
 EXPORT_SYMBOL_GPL(sas_eh_target_reset_handler);
 
+/*
+ * Handle deferred QCs in case of a command timeout.
+ * See ata_scsi_eh_timed_out() for details.
+ */
+enum scsi_timeout_action sas_eh_timed_out(struct scsi_cmnd *cmd)
+{
+	struct domain_device *dev = cmd_to_domain_dev(cmd);
+
+	if (dev_is_sata(dev))
+		return ata_scsi_retry_deferred_qc(dev->sata_dev.ap, cmd);
+
+	return SCSI_EH_NOT_HANDLED;
+}
+EXPORT_SYMBOL_GPL(sas_eh_timed_out);
+
 /* Try to reset a device */
 static int try_to_reset_cmd_device(struct scsi_cmnd *cmd)
 {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5bad29c2cd31f..b5f5482c2cd2b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1152,6 +1152,8 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 #endif
 extern int ata_scsi_queuecmd(struct Scsi_Host *h,
 					     struct scsi_cmnd *cmd);
+enum scsi_timeout_action ata_scsi_retry_deferred_qc(struct ata_port *ap,
+						    struct scsi_cmnd *scmd);
 enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *cmd);
 #if IS_REACHABLE(CONFIG_ATA)
 bool ata_scsi_dma_need_drain(struct request *rq);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index cc0a1f320f17d..b90abcf8fb6aa 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -707,6 +707,7 @@ void sas_task_abort(struct sas_task *);
 int sas_eh_abort_handler(struct scsi_cmnd *cmd);
 int sas_eh_device_reset_handler(struct scsi_cmnd *cmd);
 int sas_eh_target_reset_handler(struct scsi_cmnd *cmd);
+enum scsi_timeout_action sas_eh_timed_out(struct scsi_cmnd *cmd);
 
 extern void sas_target_destroy(struct scsi_target *);
 extern int sas_sdev_init(struct scsi_device *);
@@ -745,6 +746,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 	.this_id			= -1,				\
 	.eh_device_reset_handler	= sas_eh_device_reset_handler,	\
 	.eh_target_reset_handler	= sas_eh_target_reset_handler,	\
+	.eh_timed_out			= sas_eh_timed_out,		\
 	.target_destroy			= sas_target_destroy,		\
 	.ioctl				= sas_ioctl,			\
 
-- 
2.53.0

