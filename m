Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB473F12C1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594697; cv=none; b=LBN0WIYjgJU8HfXigtugkDZXYNdYvUmmtO0DRB1MZRjojVoqVNiFTaFV8HVCjKZtbc9aF2iM+UBVPMvqWnL+S5f32KM3OVVrx6xb7pKXKbu+JGZKy7Ynl8otNCLmphzpcwIGrfb/oiO93EdYKhUf85vH3rlhaVpApcMQqeP9f4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594697; c=relaxed/simple;
	bh=LBl3qFR08vPF1Ns3uEyV6tGlSAc9plTAr/131+Iz+6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tku35m3fNKV3IrHrydVRq5ym3CHTNTsE2lCCVE2Gaqa/nFrg+opfi14zqFYxFvHvuCJsfVbx0EjshxnwVEdcitUxe1oLLp9tefu5miA/Zi9EdeL/oRME9HpPKwu+9dsrMCJ/GXFJFvPDQZwp5BUv39PhfsOfqos0QwgvBEB5kvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5RRAoSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5RRAoSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5491F00A3A;
	Tue, 21 Jul 2026 00:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594696;
	bh=3kihMM+W1q2wlryoL9FU4RkEjgCw3fulkibPoWiFo5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5RRAoSWYwxF73Tem+cyMZahZc0z0AUleyGcpg5k4KFixUYhs2gtvZI/B2Bg06RPT
	 Kzl3bY0WkF/OVFVQDTW/nrB4tgktVaBU5p4l0FWSK9JEqa7RAwrf9vQtRPVIGIY+dh
	 wiaICoV5TvVAwjM1YWu9qiJZqP0Mhdl7niBFyShR4Vua36hTOqUZnQLZ6SDjedqhta
	 TtYaDSxpq2FBi2UDTuMFMOmhr+zsnQpPIFs5wMTNx+aKi+iyJWwL3YiH345yR8VwoE
	 X+8Uj3TOK5RB5oVOUuHvREpEom0ffzGDMUBhOq4zIT/J17h+iyBHmoynDutRsqBgOO
	 H42dBeaYAKbFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] nvme: fix status magic numbers
Date: Mon, 20 Jul 2026 20:44:52 -0400
Message-ID: <20260721004454.3421053-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071542-blip-estate-70e4@gregkh>
References: <2026071542-blip-estate-70e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiwen Hu <huweiwen@linux.alibaba.com>

[ Upstream commit d89a5c6705998ddc42b104f8eabd3c4b9e8fde08 ]

Replaced some magic numbers about SC and SCT with enum and macro.

Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 53cd102a7a56 ("nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  4 ++--
 include/linux/nvme.h          | 14 ++++++++++++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb9b38e142edd5..d5258e561c8fcd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -216,7 +216,7 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
 static blk_status_t nvme_error_status(u16 status)
 {
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
 	case NVME_SC_CAP_EXCEEDED:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 54ca60db65473e..7be876167b0edd 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -68,7 +68,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status & 0x7ff;
+	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
 	unsigned long flags;
 
 	nvme_mpath_clear_current_path(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8dfa293ccedf1a..5e80b0992c105f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -586,7 +586,7 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 
 static inline bool nvme_is_ana_error(u16 status)
 {
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
 	case NVME_SC_ANA_PERSISTENT_LOSS:
@@ -599,7 +599,7 @@ static inline bool nvme_is_ana_error(u16 status)
 static inline bool nvme_is_path_error(u16 status)
 {
 	/* check for a status code type of 'path related status' */
-	return (status & 0x700) == 0x300;
+	return (status & NVME_SCT_MASK) == NVME_SCT_PATH;
 }
 
 /*
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5727185ffe4235..bb834f2efc3bc5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1463,6 +1463,7 @@ enum {
 	/*
 	 * Generic Command Status:
 	 */
+	NVME_SCT_GENERIC		= 0x0,
 	NVME_SC_SUCCESS			= 0x0,
 	NVME_SC_INVALID_OPCODE		= 0x1,
 	NVME_SC_INVALID_FIELD		= 0x2,
@@ -1499,6 +1500,7 @@ enum {
 	/*
 	 * Command Specific Status:
 	 */
+	NVME_SCT_COMMAND_SPECIFIC	= 0x100,
 	NVME_SC_CQ_INVALID		= 0x100,
 	NVME_SC_QID_INVALID		= 0x101,
 	NVME_SC_QUEUE_SIZE		= 0x102,
@@ -1565,6 +1567,7 @@ enum {
 	/*
 	 * Media and Data Integrity Errors:
 	 */
+	NVME_SCT_MEDIA_ERROR		= 0x200,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
@@ -1577,16 +1580,23 @@ enum {
 	/*
 	 * Path-related Errors:
 	 */
+	NVME_SCT_PATH			= 0x300,
 	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
 	NVME_SC_ANA_TRANSITION		= 0x303,
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
 	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
-	NVME_SC_CRD			= 0x1800,
-	NVME_SC_DNR			= 0x4000,
+	NVME_SC_MASK			= 0x00ff, /* Status Code */
+	NVME_SCT_MASK			= 0x0700, /* Status Code Type */
+	NVME_SCT_SC_MASK		= NVME_SCT_MASK | NVME_SC_MASK,
+
+	NVME_SC_CRD			= 0x1800, /* Command Retry Delayed */
+	NVME_SC_DNR			= 0x4000, /* Do Not Retry */
 };
 
+#define NVME_SCT(status) ((status) >> 8 & 7)
+
 struct nvme_completion {
 	/*
 	 * Used by Admin and Fabrics commands to return data:
-- 
2.53.0

