Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB363CB2DA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929820; cv=none; b=TDLv3Vf/7bbLKFnJU/LPpGey/1it7BTOJXEfl3fjtqbnp9FaYVGAdjJaOtMRBkj6vTl5xm1w6VA7tyraP7lom9ExxSEJpPfV6a/MMAtQn1f0C9nHXqIkWcGlbIgTc/vVgoZbng8UMnIi9ZvauifGpWr4mFmOFaK21ED8YZQmpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929820; c=relaxed/simple;
	bh=By0bRCn/SkCUxM3STIgUlmrVsm5yQ1+QtAUPV6LMYGA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G/BMGSyaEhu+5DGxh/EUOkZPeLa+/F0ufIo64fsYBnHqTJZjaxf8sV50hr9wrCgFirG3UC92H+22XnAzG0J1oUiCaEEwjbNERjBM5lrOTm9CD2Kq3QjH+cQLBhkeEtQv1IfoBlBwJ/5RVTn3lY8fP4aXFRjpMbkQF+Vkz7t/dOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zDEurPp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zDEurPp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F152D1F000E9;
	Wed,  5 Aug 2026 11:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929818;
	bh=Gy7dVOplYZ1r8az9VpbVg7OnKGwvletUZTv/9k+QkLY=;
	h=Subject:To:Cc:From:Date;
	b=zDEurPp8EVZhvw/7w/KBTezmNFHjyY0Cfjjpf++jg6Zk9C7H5+FfDGIB0RtohCLX+
	 RD2a0mjbDWWkBj4eqV/Km/YuWes96Y2mDo8QkmJJQD4vDYCkBRHdo3rUCucCs1IIy1
	 8odw+e6h1EG0oXRdnzAe+GRZhAbviKNyzmRUNqBY=
Subject: FAILED: patch "[PATCH] scsi: libsas: terminate deferred commands on time out" failed to apply to 6.18-stable tree
To: dlemoal@kernel.org,cassel@kernel.org,hare@kernel.org,ipylypiv@google.com,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:36:41 +0200
Message-ID: <2026080541-eskimo-unpeeled-0c6f@gregkh>
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
git cherry-pick -x de202d2251bc181c6019b1ad3c0ba8133e5ec68d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080541-eskimo-unpeeled-0c6f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de202d2251bc181c6019b1ad3c0ba8133e5ec68d Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Thu, 9 Jul 2026 16:02:23 +0900
Subject: [PATCH] scsi: libsas: terminate deferred commands on time out

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

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cd64787c4772..d2160ee7ca7d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1784,8 +1784,8 @@ static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
 		queue_work(system_highpri_wq, &link->deferred_qc_work);
 }
 
-static enum scsi_timeout_action
-ata_scsi_retry_deferred_qc(struct ata_port *ap, struct scsi_cmnd *scmd)
+enum scsi_timeout_action ata_scsi_retry_deferred_qc(struct ata_port *ap,
+						    struct scsi_cmnd *scmd)
 {
 	enum scsi_timeout_action action;
 	unsigned long flags;
@@ -1796,6 +1796,7 @@ ata_scsi_retry_deferred_qc(struct ata_port *ap, struct scsi_cmnd *scmd)
 
 	return action;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_retry_deferred_qc);
 
 enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *scmd)
 {
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index c83282733ec4..97ac3db5dccb 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -502,6 +502,21 @@ int sas_eh_target_reset_handler(struct scsi_cmnd *cmd)
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
index f10b3287b507..1827502b9cf2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1153,6 +1153,8 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 #endif
 extern enum scsi_qc_status ata_scsi_queuecmd(struct Scsi_Host *h,
 					     struct scsi_cmnd *cmd);
+enum scsi_timeout_action ata_scsi_retry_deferred_qc(struct ata_port *ap,
+						    struct scsi_cmnd *scmd);
 enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *cmd);
 #if IS_REACHABLE(CONFIG_ATA)
 bool ata_scsi_dma_need_drain(struct request *rq);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 163f23c92b41..c7017ae76c61 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -705,6 +705,7 @@ void sas_task_abort(struct sas_task *);
 int sas_eh_abort_handler(struct scsi_cmnd *cmd);
 int sas_eh_device_reset_handler(struct scsi_cmnd *cmd);
 int sas_eh_target_reset_handler(struct scsi_cmnd *cmd);
+enum scsi_timeout_action sas_eh_timed_out(struct scsi_cmnd *cmd);
 
 extern void sas_target_destroy(struct scsi_target *);
 extern int sas_sdev_init(struct scsi_device *);
@@ -743,6 +744,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 	.this_id			= -1,				\
 	.eh_device_reset_handler	= sas_eh_device_reset_handler,	\
 	.eh_target_reset_handler	= sas_eh_target_reset_handler,	\
+	.eh_timed_out			= sas_eh_timed_out,		\
 	.target_destroy			= sas_target_destroy,		\
 	.ioctl				= sas_ioctl,			\
 

