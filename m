Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93551C321
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953250; cv=none; b=KPwd3eGAgIsFRJBuCDPr8u9gKCHsK4pFI4Betuqlfvt5qWhqFT3NL9UL9f+gnCqUxsoB21+LAiNVeGlLUR0tejlCEwr4qLkt8svGqkZ6V2ux2GMPtyFxz/G1kmiQdJ89+1UCGH2n91PaFZhYHXO54gChtOasYSIwZJxAJ4ZT/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953250; c=relaxed/simple;
	bh=qV5je3r7pYFGmod3qCdaXmHFnMDM2KM++Z0K5Pe8k0E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WUGxPaePT4UXLyNabgTnS7ovnXYcfin2jmnTKD/Wv/rYbTKB//+1ya2kFU+Mkdd13cpGAsAtkzZYYCJyH2MW+iL8x3CSFZelLZOaI/oaWjBN4e93W9QobcjyI6M1wIXm1sM/27u3CvCdaUj5Zz+dihUtAcK7coX8TJyRPgNfmgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FcAjpo88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FcAjpo88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C581F00A3A;
	Wed,  9 Sep 2026 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953248;
	bh=j6UTid8bqrWgvQkPbCy16sXREDmIaD38Rc8+kPXzvfc=;
	h=Subject:To:Cc:From:Date;
	b=FcAjpo88E9A4Zzp/9s7nyjN5HZL/TOjQfpyQPVZ2ym4saks4MUYUmjVsKX/dVSAGL
	 bFLzw10YqBAKgQEeqZs1Ra7d5IMqd8xY1Dyun+C/qXQ9tVk20Y6sIpzHwWFHzRnOQF
	 +A8b9fEqD6XtndroEX00xLEsiKFr8hnhdyfIrEMA=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Validate BSG request_len before reading" failed to apply to 7.2-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:21:13 +0200
Message-ID: <2026090913-ounce-scheme-6015@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 4cf38dd9465736141263ebb63375868311a0ec81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090913-ounce-scheme-6015@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4cf38dd9465736141263ebb63375868311a0ec81 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:35 +0530
Subject: [PATCH] scsi: qla2xxx: Validate BSG request_len before reading
 vendor_cmd[]

The FC BSG transport allocates job->request via memdup_user() using the
exact user-supplied request_len. For FC_BSG_HST_VENDOR,
fc_bsg_host_dispatch() only guarantees request_len covers msgcode and
vendor_id; it does not account for the vendor_cmd[] flexible array.

qla2xxx then reads the command selector vendor_cmd[0] and, in several
sub-handlers, vendor_cmd[1]/[2] or structures overlaid on the vendor
command area without verifying request_len. A caller holding
CAP_SYS_RAWIO can submit a short request whose vendor_id matches the
host, triggering out-of-bounds heap reads (KASAN-detectable, and able to
mis-select a command or panic).

Add a central guard in qla2x00_process_vendor_specific() so the selector
is always in bounds, restrict the early vendor_cmd[0] read in
qla24xx_bsg_request() to sufficiently long vendor messages, and add
request_len checks to the sub-handlers that read further:
qla24xx_proc_fcp_prio_cfg_cmd(), qla2x00_process_loopback(),
qla84xx_reset(), qla84xx_updatefw(), qla2x00_read_optrom(),
qla2x00_update_optrom(), qlafx00_mgmt_cmd() and
qla28xx_validate_flash_image().

Fixes: 01e0e15c8b3b ("scsi: don't use fc_bsg_job::request and fc_bsg_job::reply directly")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-31-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 49f66f37b1a7..7fe7480fdc1b 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -160,6 +160,12 @@ qla24xx_proc_fcp_prio_cfg_cmd(struct bsg_job *bsg_job)
 		goto exit_fcp_prio_cfg;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t)) {
+		ret = -EINVAL;
+		goto exit_fcp_prio_cfg;
+	}
+
 	/* Get the sub command */
 	oper = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
 
@@ -758,6 +764,10 @@ qla2x00_process_loopback(struct bsg_job *bsg_job)
 		return -EIO;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 3 * sizeof(uint32_t))
+		return -EINVAL;
+
 	memset(&elreq, 0, sizeof(elreq));
 
 	elreq.req_sg_cnt = dma_map_sg(&ha->pdev->dev,
@@ -990,6 +1000,10 @@ qla84xx_reset(struct bsg_job *bsg_job)
 		return -EINVAL;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	flag = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
 
 	rval = qla84xx_reset_chip(vha, flag == A84_ISSUE_RESET_DIAG_FW);
@@ -1034,6 +1048,10 @@ qla84xx_updatefw(struct bsg_job *bsg_job)
 		return -EINVAL;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	sg_cnt = dma_map_sg(&ha->pdev->dev, bsg_job->request_payload.sg_list,
 		bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 	if (!sg_cnt) {
@@ -1511,9 +1529,15 @@ qla2x00_read_optrom(struct bsg_job *bsg_job)
 	struct Scsi_Host *host = fc_bsg_to_shost(bsg_job);
 	scsi_qla_host_t *vha = shost_priv(host);
 	struct qla_hw_data *ha = vha->hw;
-	uint32_t start = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
+	uint32_t start;
 	int rval = 0;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
+	start = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
+
 	if (ha->flags.nic_core_reset_hdlr_active)
 		return -EBUSY;
 
@@ -1556,9 +1580,15 @@ qla2x00_update_optrom(struct bsg_job *bsg_job)
 	struct Scsi_Host *host = fc_bsg_to_shost(bsg_job);
 	scsi_qla_host_t *vha = shost_priv(host);
 	struct qla_hw_data *ha = vha->hw;
-	uint32_t start = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
+	uint32_t start;
 	int rval = 0;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
+	start = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
+
 	mutex_lock(&ha->optrom_mutex);
 	rval = qla2x00_optrom_setup(bsg_job, vha, start, 1);
 	if (rval) {
@@ -2411,6 +2441,11 @@ qlafx00_mgmt_cmd(struct bsg_job *bsg_job)
 	struct fc_port *fcport;
 	char  *type = "FC_BSG_HST_FX_MGMT";
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + sizeof(uint32_t) +
+	    sizeof(struct qla_mt_iocb_rqst_fx00))
+		return -EINVAL;
+
 	/* Copy the IOCB specific information */
 	piocb_rqst = (struct qla_mt_iocb_rqst_fx00 *)
 	    &bsg_request->rqst_data.h_vendor.vendor_cmd[1];
@@ -3332,6 +3367,13 @@ qla2x00_process_vendor_specific(struct scsi_qla_host *vha, struct bsg_job *bsg_j
 {
 	struct fc_bsg_request *bsg_request = bsg_job->request;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + sizeof(uint32_t)) {
+		ql_log(ql_log_warn, vha, 0x7000,
+		       "BSG request too small for vendor cmd.\n");
+		return -EINVAL;
+	}
+
 	ql_dbg(ql_dbg_edif, vha, 0x911b, "%s FC_BSG_HST_VENDOR cmd[0]=0x%x\n",
 	    __func__, bsg_request->rqst_data.h_vendor.vendor_cmd[0]);
 
@@ -3475,8 +3517,11 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 	}
 
 	/* Disable port will bring down the chip, allow enable command */
-	if (bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_MANAGE_HOST_PORT ||
-	    bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_GET_HOST_STATS)
+	if (bsg_request->msgcode == FC_BSG_HST_VENDOR &&
+	    bsg_job->request_len >=
+		sizeof(struct fc_bsg_request) + sizeof(uint32_t) &&
+	    (bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_MANAGE_HOST_PORT ||
+	     bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_GET_HOST_STATS))
 		goto skip_chip_chk;
 
 	if (vha->hw->flags.port_isolated) {
@@ -3785,6 +3830,10 @@ static int qla28xx_validate_flash_image(struct bsg_job *bsg_job)
 	if (!IS_QLA28XX(ha) || vha->vp_idx != 0)
 		return -EPERM;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	mutex_lock(&ha->optrom_mutex);
 	rval = qla28xx_do_validate_flash_image(bsg_job, &state);
 	if (rval)

