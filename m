Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E484A5C40
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155148; cv=none; b=JHEEw3X7ekLCGGQU33Z3Q7TE02YCGNHP5nrZFHLaabJTJAy8YeBFwzL/rKLpKsRfSq4Mx3aoSjWP3APTbZsyLv3VUSpje6t7K2u6Yhj9q0K6jhXAjLyWlNOUKUM05FjfxTEDb8JTPaVRY2G8YGy7OQnkYSLgBPvAq6yWf0XW3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155148; c=relaxed/simple;
	bh=duSFBpUrOJBCZUQKUgE4WQD8kBFTALX1opegwJ77VGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTmXZffohWGJGc73ufpmJ2gEr0GMqPbb5cMw92Yp6eY+RczinzVkGMWtYKZeiaS69k+S2f2SrSc8D+sflgkYOW0CO48Gz2OpdKuXC2qlvaNxOxwWJgOsAIjiA+HT8fUgbG8tkBMFUR5cRvQAE7RojCXX6El9uFk4eSyepYbITNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGmBKR25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGmBKR25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D61F000FF;
	Fri, 11 Sep 2026 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155144;
	bh=B55TORZ1e2gU31/GBEE6Jl321QiybBeQVjEwFKu/RG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IGmBKR25MUjb0dK2VMzHt7YTvVvsFXB7mDmGKJVtw71im0w5kGPL4zsTLhOrIbCBY
	 MHvCslMvTwzNJgS9HJvz8h6Le6ILUatlr05xnETR0Gx/k8A3zdbJPwBRSzvDHH8/VR
	 HcnaCT1tE9tMfkWVrQt1Guhs+BqEAkyCxNwCw7KTKioDxTiBQGs5T8oGablvVONuYW
	 VO6tOrg/U1RfrZjgC3f6nx+9tCAL/UUI3tuzFvgaQOlj0zLemnhQlqBKQuOMiohzi+
	 ptdljgcdbFmKRSB0FlJlxbmasvcw/VHgg2nkG/4cpJTk9R747xzPzth4yTtamQRfV+
	 LDNOHgiytzU3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: qla2xxx: Validate BSG request_len before reading vendor_cmd[]
Date: Fri, 11 Sep 2026 15:32:22 -0400
Message-ID: <20260911193222.1413814-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090915-deuce-pretender-e0d3@gregkh>
References: <2026090915-deuce-pretender-e0d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 4cf38dd9465736141263ebb63375868311a0ec81 ]

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
[ adapted validation to the older qla2xxx handler layout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index c37945ac9eca7..836b6d9e1d3ef 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -140,6 +140,12 @@ qla24xx_proc_fcp_prio_cfg_cmd(struct bsg_job *bsg_job)
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
 
@@ -733,6 +739,10 @@ qla2x00_process_loopback(struct bsg_job *bsg_job)
 		return -EIO;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 3 * sizeof(uint32_t))
+		return -EINVAL;
+
 	memset(&elreq, 0, sizeof(elreq));
 
 	elreq.req_sg_cnt = dma_map_sg(&ha->pdev->dev,
@@ -965,6 +975,10 @@ qla84xx_reset(struct bsg_job *bsg_job)
 		return -EINVAL;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	flag = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
 
 	rval = qla84xx_reset_chip(vha, flag == A84_ISSUE_RESET_DIAG_FW);
@@ -1009,6 +1023,10 @@ qla84xx_updatefw(struct bsg_job *bsg_job)
 		return -EINVAL;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	sg_cnt = dma_map_sg(&ha->pdev->dev, bsg_job->request_payload.sg_list,
 		bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 	if (!sg_cnt) {
@@ -1459,6 +1477,10 @@ qla2x00_read_optrom(struct bsg_job *bsg_job)
 	struct qla_hw_data *ha = vha->hw;
 	int rval = 0;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	if (ha->flags.nic_core_reset_hdlr_active)
 		return -EBUSY;
 
@@ -1496,6 +1518,10 @@ qla2x00_update_optrom(struct bsg_job *bsg_job)
 	struct qla_hw_data *ha = vha->hw;
 	int rval = 0;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	mutex_lock(&ha->optrom_mutex);
 	rval = qla2x00_optrom_setup(bsg_job, vha, 1);
 	if (rval) {
@@ -1968,6 +1994,11 @@ qlafx00_mgmt_cmd(struct bsg_job *bsg_job)
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
@@ -2444,6 +2475,14 @@ static int
 qla2x00_process_vendor_specific(struct bsg_job *bsg_job)
 {
 	struct fc_bsg_request *bsg_request = bsg_job->request;
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + sizeof(uint32_t)) {
+		ql_log(ql_log_warn, vha, 0x7000,
+		       "BSG request too small for vendor cmd.\n");
+		return -EINVAL;
+	}
 
 	switch (bsg_request->rqst_data.h_vendor.vendor_cmd[0]) {
 	case QL_VND_LOOPBACK:
-- 
2.53.0

