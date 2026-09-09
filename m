Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A47538D85
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953244; cv=none; b=ly7IojHsc0WX0Auo845rZNjaUUHChfP3kGaujI2IdbqgNj0L2DD3DUi25Lu8PjywY8a645Ofdawgv+yJFe/ha+8mrETtOlBQnT9Hgdy5fUGgT33yp69/bp/QdDnyrNMoMyRj96BptzxoYXgxDwOmioRH2mJV2w5ao4003s4CjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953244; c=relaxed/simple;
	bh=1PfDfxU1VivDHWazzubTtu2yGKTab88+saPd27hOIhw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AF5AImpsHu4q0WpfkvKENFG4HASeDlpm8tS9PtAJf4CTbg0QI1rvkb5nqHQkGWiNIQ89nPxGkBNdsrq2ODfgUoXWJrhXjDytR2za13w8XIBO+JO1PPc5RFsIxkGe61FtNuvl5tWQEQ5ETZRkFScA7mNMszKY3F15Ug8qXz0ZI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2iB23Pgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2iB23Pgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF5F1F00A3A;
	Wed,  9 Sep 2026 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953242;
	bh=f++atbDtR5RZY7VQ0jy8W0BTPHgzn4rrqDHY+AwJIrg=;
	h=Subject:To:Cc:From:Date;
	b=2iB23Pgd36ypiaaMgS5Z6xmAtcwlxhoV2xx+ain/2/cf0yBpPGMNeaHUYN2D7DZIw
	 I3vqvVJDZ7k3wo8QXEDbjg2YGRq/ELoAXtEnDGvfJKK4oGwpGK88b0NdNI7pd/jxCg
	 ouH+AsE5jKfgdvFj3JReCZpIp/9dnjy6Fhcsuonw=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Add FC-NVMe abort processing" failed to apply to 6.1-stable tree
To: darren.trapp@cavium.com,hare@suse.com,himanshu.madhani@cavium.com,jthumshirn@suse.de,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:20:38 +0200
Message-ID: <2026090938-entitle-graceless-64b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e473b3074104ee09227cfbba5f872e3ea15dd280
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090938-entitle-graceless-64b8@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e473b3074104ee09227cfbba5f872e3ea15dd280 Mon Sep 17 00:00:00 2001
From: Darren Trapp <darren.trapp@cavium.com>
Date: Tue, 20 Mar 2018 23:09:33 -0700
Subject: [PATCH] scsi: qla2xxx: Add FC-NVMe abort processing

Signed-off-by: Darren Trapp <darren.trapp@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 5ee447680ddd..951fbbab961f 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -181,24 +181,32 @@ static void qla_nvme_sp_done(void *ptr, int res)
 	return;
 }
 
-static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
-    struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
+static void qla_nvme_abort_work(struct work_struct *work)
 {
-	struct nvme_private *priv = fd->private;
-	struct qla_nvme_rport *qla_rport = rport->private;
-	fc_port_t *fcport = qla_rport->fcport;
+	struct nvme_private *priv =
+		container_of(work, struct nvme_private, abort_work);
 	srb_t *sp = priv->sp;
-	int rval;
+	fc_port_t *fcport = sp->fcport;
 	struct qla_hw_data *ha = fcport->vha->hw;
+	int rval;
 
 	rval = ha->isp_ops->abort_command(sp);
 
 	ql_dbg(ql_dbg_io, fcport->vha, 0x212b,
-	    "%s: %s LS command for sp=%p on fcport=%p rval=%x\n", __func__,
+	    "%s: %s command for sp=%p on fcport=%p rval=%x\n", __func__,
 	    (rval != QLA_SUCCESS) ? "Failed to abort" : "Aborted",
 	    sp, fcport, rval);
 }
 
+static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
+    struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
+{
+	struct nvme_private *priv = fd->private;
+
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
+	schedule_work(&priv->abort_work);
+}
+
 static void qla_nvme_ls_complete(struct work_struct *work)
 {
 	struct nvme_private *priv =
@@ -264,18 +272,9 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
     struct nvmefc_fcp_req *fd)
 {
 	struct nvme_private *priv = fd->private;
-	srb_t *sp = priv->sp;
-	int rval;
-	struct qla_nvme_rport *qla_rport = rport->private;
-	fc_port_t *fcport = qla_rport->fcport;
-	struct qla_hw_data *ha = fcport->vha->hw;
 
-	rval = ha->isp_ops->abort_command(sp);
-
-	ql_dbg(ql_dbg_io, fcport->vha, 0x2127,
-	    "%s: %s command for sp=%p on fcport=%p rval=%x\n", __func__,
-	    (rval != QLA_SUCCESS) ? "Failed to abort" : "Aborted",
-	    sp, fcport, rval);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
+	schedule_work(&priv->abort_work);
 }
 
 static void qla_nvme_poll(struct nvme_fc_local_port *lport, void *hw_queue_handle)
@@ -650,6 +649,7 @@ void qla_nvme_delete(struct scsi_qla_host *vha)
 		ql_log(ql_log_info, fcport->vha, 0x2114, "%s: fcport=%p\n",
 		    __func__, fcport);
 
+		nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
 		init_completion(&fcport->nvme_del_done);
 		nvme_fc_unregister_remoteport(fcport->nvme_remote_port);
 		wait_for_completion(&fcport->nvme_del_done);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index 7becfc1b3e69..8df379478269 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -31,6 +31,7 @@ struct nvme_private {
 	struct srb	*sp;
 	struct nvmefc_ls_req *fd;
 	struct work_struct ls_work;
+	struct work_struct abort_work;
 	int comp_status;
 };
 

