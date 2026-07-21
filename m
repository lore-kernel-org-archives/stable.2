Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39C3F12DE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594699; cv=none; b=JYJf2WMAyhcfdiXqKsA3Qj/qSdVU6Ye3t62u7tdyN6nIiMn+K/pPwhaspF6bTNIYpPURcQwkCJX7HEogKaz+ZveGEGvZbmSCfvAuBZW0h9f/csCU8f/NnvBN38HMgJL8bHkjLX40y2LAmuIUe+uFk1JQW3oKpFeguJ09yAv9uqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594699; c=relaxed/simple;
	bh=rncly8qDw8xp08NiDVlXxV+awMnPPMMuJ/6vtx6UA4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNHFgxx7cw6rbZyl2mHkoLUaLWn1guAZlk/4IPn8fAD5K6np+NH2l9Kxf3wHNokogF8jqN4C0JQhUaGt50njClFwsUCsm/OtFl5xRwgXmWtd53zqjt1A+576cD5mXcT1rw+U14E43ijYDD8GFFmfydoB+l+XPFq3FPprErBXD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCVjQPxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCVjQPxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9011F000E9;
	Tue, 21 Jul 2026 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594697;
	bh=RzRKsfXEcChG/EHhLLVtovZ50Xdm4wXlHvhCpzl1lwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FCVjQPxEbSo+rar//vQMTAY3kOTHS8axERH03zevFiAINdAofYa5WlTZKInETERGt
	 ZpsXPZn7i01VVVoK+P1Cuhtm6NKznFEUpSslH1t6QtUK2nGTYdwKSbM5qnUnOpj4A5
	 H+YmWxsSkx6K1n0L+9X2ZeFLl4ymQ8haZNbb06cnTNqJILUUcwFy5moXqOogt0cyDi
	 DsadQeLevxTqr0cqOSMch5hOEVnAd++1HuvFJ5T+SKrDtXdWmVrXuKtaRoY3awZsnA
	 w4mQ06OOiSNrTqjQ9KlHuAcJF5YcckNk0us8mYrtKx/CvctNeHn+XzHK3PZQssAl7H
	 Xmg2YQRxxJ0zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] nvme: rename CDR/MORE/DNR to NVME_STATUS_*
Date: Mon, 20 Jul 2026 20:44:53 -0400
Message-ID: <20260721004454.3421053-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721004454.3421053-1-sashal@kernel.org>
References: <2026071542-blip-estate-70e4@gregkh>
 <20260721004454.3421053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiwen Hu <huweiwen@linux.alibaba.com>

[ Upstream commit dd0b0a4a2c5d7209457dc172997d1243ad269cfa ]

CDR/MORE/DNR fields are not belonging to SC in the NVMe spec, rename
them to NVME_STATUS_* to avoid confusion.

Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 53cd102a7a56 ("nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c          | 12 ++++-----
 drivers/nvme/host/fabrics.c       |  8 +++---
 drivers/nvme/host/fault_inject.c  |  2 +-
 drivers/nvme/target/admin-cmd.c   | 28 ++++++++++-----------
 drivers/nvme/target/core.c        | 42 +++++++++++++++----------------
 drivers/nvme/target/discovery.c   | 14 +++++------
 drivers/nvme/target/fabrics-cmd.c | 30 +++++++++++-----------
 drivers/nvme/target/io-cmd-bdev.c | 14 +++++------
 drivers/nvme/target/io-cmd-file.c |  2 +-
 drivers/nvme/target/passthru.c    | 12 ++++-----
 drivers/nvme/target/rdma.c        | 10 ++++----
 drivers/nvme/target/tcp.c         |  4 +--
 include/linux/nvme.h              |  4 +--
 13 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5258e561c8fcd..21b36ed9147e20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -263,7 +263,7 @@ static void nvme_retry_req(struct request *req)
 	u16 crd;
 
 	/* The mask and shift result must be <= 3 */
-	crd = (nvme_req(req)->status & NVME_SC_CRD) >> 11;
+	crd = (nvme_req(req)->status & NVME_STATUS_CRD) >> 11;
 	if (ns && crd)
 		delay = ns->ctrl->crdt[crd - 1] * 100;
 
@@ -284,7 +284,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 		return COMPLETE;
 
 	if (blk_noretry_request(req) ||
-	    (nvme_req(req)->status & NVME_SC_DNR) ||
+	    (nvme_req(req)->status & NVME_STATUS_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
@@ -1421,7 +1421,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		goto out_free_id;
 	}
 
-	error = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	error = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	if ((*id)->ncap == 0) /* namespace not allocated or attached */
 		goto out_free_id;
 
@@ -4074,7 +4074,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
 	struct nvme_id_ns *id;
-	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
@@ -4083,7 +4083,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	if (ret)
 		goto out;
 
-	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
@@ -4101,7 +4101,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	 *
 	 * TODO: we should probably schedule a delayed retry here.
 	 */
-	if (ret > 0 && (ret & NVME_SC_DNR))
+	if (ret > 0 && (ret & NVME_STATUS_DNR))
 		nvme_ns_remove(ns);
 }
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index e3a22100003fce..07d666e3eb9dcf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -158,7 +158,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	if (unlikely(ret != 0))
 		dev_err(ctrl->device,
 			"Property Get error: %d, offset %#x\n",
-			ret > 0 ? ret & ~NVME_SC_DNR : ret, off);
+			ret > 0 ? ret & ~NVME_STATUS_DNR : ret, off);
 
 	return ret;
 }
@@ -205,7 +205,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	if (unlikely(ret != 0))
 		dev_err(ctrl->device,
 			"Property Get error: %d, offset %#x\n",
-			ret > 0 ? ret & ~NVME_SC_DNR : ret, off);
+			ret > 0 ? ret & ~NVME_STATUS_DNR : ret, off);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvmf_reg_read64);
@@ -248,7 +248,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-			ret > 0 ? ret & ~NVME_SC_DNR : ret, off);
+			ret > 0 ? ret & ~NVME_STATUS_DNR : ret, off);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvmf_reg_write32);
@@ -287,7 +287,7 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		int errval, int offset, struct nvme_command *cmd,
 		struct nvmf_connect_data *data)
 {
-	int err_sctype = errval & (~NVME_SC_DNR);
+	int err_sctype = errval & (~NVME_STATUS_DNR);
 
 	switch (err_sctype) {
 
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 1352159733b084..a6685e018b0dd9 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -75,7 +75,7 @@ void nvme_should_fail(struct request *req)
 		/* inject status code and DNR bit */
 		status = fault_inject->status;
 		if (fault_inject->dont_retry)
-			status |= NVME_SC_DNR;
+			status |= NVME_STATUS_DNR;
 		nvme_req(req)->status =	status;
 	}
 }
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6a8274caa3bc7e..ea795bc11e603a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -316,7 +316,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
 }
 
 static void nvmet_id_set_model_number(struct nvme_id_ctrl *id,
@@ -474,7 +474,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -613,7 +613,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
 	if (!ns) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -634,7 +634,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 out_put_ns:
 	nvmet_put_namespace(ns);
 out:
@@ -660,7 +660,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	pr_debug("unhandled identify cns %d on qid %d\n",
 	       req->cmd->identify.cns, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
 }
 
 /*
@@ -745,7 +745,7 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 
 	if (val32 & ~mask) {
 		req->error_loc = offsetof(struct nvme_common_command, cdw11);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	WRITE_ONCE(req->sq->ctrl->aen_enabled, val32);
@@ -771,7 +771,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		ncqr = (cdw11 >> 16) & 0xffff;
 		nsqr = cdw11 & 0xffff;
 		if (ncqr == 0xffff || nsqr == 0xffff) {
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 		nvmet_set_result(req,
@@ -784,14 +784,14 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		status = nvmet_set_feat_async_event(req, NVMET_AEN_CFG_ALL);
 		break;
 	case NVME_FEAT_HOST_ID:
-		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		status = NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
 		break;
 	case NVME_FEAT_WRITE_PROTECT:
 		status = nvmet_set_feat_write_protect(req);
 		break;
 	default:
 		req->error_loc = offsetof(struct nvme_common_command, cdw10);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -806,7 +806,7 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->common.nsid);
 	if (!req->ns)  {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+		return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	}
 	mutex_lock(&subsys->lock);
 	if (req->ns->readonly == true)
@@ -878,7 +878,7 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		if (!(req->cmd->common.cdw11 & cpu_to_le32(1 << 0))) {
 			req->error_loc =
 				offsetof(struct nvme_common_command, cdw11);
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 
@@ -891,7 +891,7 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -908,7 +908,7 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 	mutex_lock(&ctrl->lock);
 	if (ctrl->nr_async_event_cmds >= NVMET_ASYNC_EVENTS) {
 		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, NVME_SC_ASYNC_LIMIT | NVME_SC_DNR);
+		nvmet_req_complete(req, NVME_SC_ASYNC_LIMIT | NVME_STATUS_DNR);
 		return;
 	}
 	ctrl->async_event_cmds[ctrl->nr_async_event_cmds++] = req;
@@ -975,5 +975,5 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	pr_debug("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 	       req->sq->qid);
 	req->error_loc = offsetof(struct nvme_common_command, opcode);
-	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ddcfc51fc05c6a..5525d1b07abc18 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -51,21 +51,21 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 		break;
 	case -ENOSPC:
 		req->error_loc = offsetof(struct nvme_rw_command, length);
-		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
+		status = NVME_SC_CAP_EXCEEDED | NVME_STATUS_DNR;
 		break;
 	case -EREMOTEIO:
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
-		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		status = NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 		break;
 	case -EOPNOTSUPP:
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_dsm:
 		case nvme_cmd_write_zeroes:
-			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
+			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
 			break;
 		default:
-			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		}
 		break;
 	case -ENODATA:
@@ -76,7 +76,7 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 		fallthrough;
 	default:
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	}
 
 	return status;
@@ -90,7 +90,7 @@ u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
 {
 	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) != len) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -99,7 +99,7 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf, size_t len)
 {
 	if (sg_pcopy_to_buffer(req->sg, req->sg_cnt, buf, len, off) != len) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -108,7 +108,7 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 {
 	if (sg_zero_buffer(req->sg, req->sg_cnt, len, off) != len) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -132,7 +132,7 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 
 static void nvmet_async_events_failall(struct nvmet_ctrl *ctrl)
 {
-	u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
+	u16 status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	struct nvmet_req *req;
 
 	mutex_lock(&ctrl->lock);
@@ -885,7 +885,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+		return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	}
 	ret = nvmet_check_ana_state(req->port, req->ns);
 	if (unlikely(ret)) {
@@ -928,7 +928,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto fail;
 	}
 
@@ -939,7 +939,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	 */
 	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF)) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto fail;
 	}
 
@@ -957,7 +957,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	trace_nvmet_req_init(req, req->cmd);
 
 	if (unlikely(!percpu_ref_tryget_live(&sq->ref))) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto fail;
 	}
 
@@ -984,7 +984,7 @@ bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
 {
 	if (unlikely(len != req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
+		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
 		return false;
 	}
 
@@ -996,7 +996,7 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 {
 	if (unlikely(data_len > req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
+		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
 		return false;
 	}
 
@@ -1245,13 +1245,13 @@ u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
 		pr_err("got cmd %d while CC.EN == 0 on qid = %d\n",
 		       cmd->common.opcode, req->sq->qid);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		return NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
 	}
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
 		pr_err("got cmd %d while CSTS.RDY == 0 on qid = %d\n",
 		       cmd->common.opcode, req->sq->qid);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		return NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -1325,7 +1325,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	int ret;
 	u16 status;
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
@@ -1334,14 +1334,14 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out;
 	}
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	down_read(&nvmet_config_sem);
 	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
 			hostnqn, subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
-		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
 		goto out_put_subsystem;
 	}
 	up_read(&nvmet_config_sem);
@@ -1386,7 +1386,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
-		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 		goto out_free_sqs;
 	}
 	ctrl->cntlid = ret;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 5b8ee824b100ad..963ae3af8aba33 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -177,7 +177,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lid);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -185,7 +185,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	if (offset & 0x3) {
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lpo);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -251,7 +251,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
 		req->error_loc = offsetof(struct nvme_identify, cns);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -314,7 +314,7 @@ static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
-		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		stat = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -339,7 +339,7 @@ static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
-		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		stat = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -355,7 +355,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		       cmd->common.opcode);
 		req->error_loc =
 			offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	switch (cmd->common.opcode) {
@@ -380,7 +380,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	default:
 		pr_err("unhandled cmd %d\n", cmd->common.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 }
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index fb4f62982cb7e0..beea96c2e0f499 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -18,7 +18,7 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 	if (req->cmd->prop_set.attrib & 1) {
 		req->error_loc =
 			offsetof(struct nvmf_property_set_command, attrib);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -29,7 +29,7 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvmf_property_set_command, offset);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 out:
 	nvmet_req_complete(req, status);
@@ -50,7 +50,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 			val = ctrl->cap;
 			break;
 		default:
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 	} else {
@@ -65,7 +65,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 			val = ctrl->csts;
 			break;
 		default:
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 	}
@@ -97,7 +97,7 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 		pr_err("received unknown capsule type 0x%x\n",
 			cmd->fabrics.fctype);
 		req->error_loc = offsetof(struct nvmf_common_command, fctype);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	return 0;
@@ -115,13 +115,13 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	if (old) {
 		pr_warn("queue already connected!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
-		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
+		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 	}
 	if (!sqsize) {
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
-		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		goto err;
 	}
 
@@ -177,14 +177,14 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
 		req->error_loc = offsetof(struct nvmf_connect_command, recfmt);
-		status = NVME_SC_CONNECT_FORMAT | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (unlikely(d->cntlid != cpu_to_le16(0xffff))) {
 		pr_warn("connect attempt for invalid controller ID %#x\n",
 			d->cntlid);
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
 		goto out;
 	}
@@ -194,7 +194,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status) {
-		if (status == (NVME_SC_INVALID_FIELD | NVME_SC_DNR))
+		if (status == (NVME_SC_INVALID_FIELD | NVME_STATUS_DNR))
 			req->error_loc =
 				offsetof(struct nvme_common_command, opcode);
 		goto out;
@@ -248,7 +248,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
-		status = NVME_SC_CONNECT_FORMAT | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -257,13 +257,13 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(qid);
 		goto out_ctrl_put;
 	}
@@ -296,13 +296,13 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 		pr_err("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 	if (cmd->fabrics.fctype != nvme_fabrics_type_connect) {
 		pr_err("invalid capsule type 0x%x on unconnected queue.\n",
 			cmd->fabrics.fctype);
 		req->error_loc = offsetof(struct nvmf_common_command, fctype);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	if (cmd->connect.qid == 0)
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 58dd91d2d71c86..3f1fa82cec6284 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -116,11 +116,11 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 	 */
 	switch (blk_sts) {
 	case BLK_STS_NOSPC:
-		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
+		status = NVME_SC_CAP_EXCEEDED | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_rw_command, length);
 		break;
 	case BLK_STS_TARGET:
-		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		status = NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
 		break;
 	case BLK_STS_NOTSUPP:
@@ -128,10 +128,10 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_dsm:
 		case nvme_cmd_write_zeroes:
-			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
+			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
 			break;
 		default:
-			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		}
 		break;
 	case BLK_STS_MEDIUM:
@@ -140,7 +140,7 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		break;
 	case BLK_STS_IOERR:
 	default:
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
 	}
 
@@ -333,7 +333,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
 	if (blkdev_issue_flush(req->ns->bdev, GFP_KERNEL))
-		return NVME_SC_INTERNAL | NVME_SC_DNR;
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	return 0;
 }
 
@@ -452,6 +452,6 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 }
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 9d1acc4a525380..c2551b99e2b18d 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -407,6 +407,6 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 		pr_err("unhandled cmd for file ns %d on qid %d\n",
 				cmd->common.opcode, req->sq->qid);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 }
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index f76d01028df0b4..5e54123df4a891 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -237,7 +237,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		ns = nvme_find_get_ns(ctrl, nsid);
 		if (unlikely(!ns)) {
 			pr_err("failed to get passthru ns nsid:%u\n", nsid);
-			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+			status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 			goto out;
 		}
 
@@ -350,7 +350,7 @@ u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
 		 * emulated in the future if regular targets grow support for
 		 * this feature.
 		 */
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	return nvmet_setup_passthru_command(req);
@@ -402,7 +402,7 @@ static u16 nvmet_passthru_get_set_features(struct nvmet_req *req)
 	case NVME_FEAT_RESV_PERSIST:
 		/* No reservations, see nvmet_parse_passthru_io_cmd() */
 	default:
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 }
 
@@ -470,7 +470,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 				req->p.use_workqueue = true;
 				return NVME_SC_SUCCESS;
 			}
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
@@ -482,7 +482,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 				req->p.use_workqueue = true;
 				return NVME_SC_SUCCESS;
 			}
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		default:
 			return nvmet_setup_passthru_command(req);
 		}
@@ -490,7 +490,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		return nvmet_setup_passthru_command(req);
 	default:
 		/* Reject commands not in the allowlist above */
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 }
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 503e1f59013c90..5732cb5741a6a5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -850,12 +850,12 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 	if (!nvme_is_write(rsp->req.cmd)) {
 		rsp->req.error_loc =
 			offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	if (off + len > rsp->queue->dev->inline_data_size) {
 		pr_err("invalid inline data offset!\n");
-		return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 	}
 
 	/* no data command? */
@@ -919,7 +919,7 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 			pr_err("invalid SGL subtype: %#x\n", sgl->type);
 			rsp->req.error_loc =
 				offsetof(struct nvme_common_command, dptr);
-			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		}
 	case NVME_KEY_SGL_FMT_DATA_DESC:
 		switch (sgl->type & 0xf) {
@@ -931,12 +931,12 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 			pr_err("invalid SGL subtype: %#x\n", sgl->type);
 			rsp->req.error_loc =
 				offsetof(struct nvme_common_command, dptr);
-			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		}
 	default:
 		pr_err("invalid SGL type: %#x\n", sgl->type);
 		rsp->req.error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_TYPE | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_TYPE | NVME_STATUS_DNR;
 	}
 }
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index edcc0662c3e571..3d7ec6f50f2ac5 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -372,10 +372,10 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
 			  NVME_SGL_FMT_OFFSET)) {
 		if (!nvme_is_write(cmd->req.cmd))
-			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 
 		if (len > cmd->req.port->inline_data_size)
-			return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
+			return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 		cmd->pdu_len = len;
 	}
 	cmd->req.transfer_len += len;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bb834f2efc3bc5..7f715df77e58dd 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1591,8 +1591,8 @@ enum {
 	NVME_SCT_MASK			= 0x0700, /* Status Code Type */
 	NVME_SCT_SC_MASK		= NVME_SCT_MASK | NVME_SC_MASK,
 
-	NVME_SC_CRD			= 0x1800, /* Command Retry Delayed */
-	NVME_SC_DNR			= 0x4000, /* Do Not Retry */
+	NVME_STATUS_CRD			= 0x1800, /* Command Retry Delayed */
+	NVME_STATUS_DNR			= 0x4000, /* Do Not Retry */
 };
 
 #define NVME_SCT(status) ((status) >> 8 & 7)
-- 
2.53.0

