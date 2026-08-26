Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CF40DB31
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749048; cv=none; b=V8Bw9UGcEWNWmbgXHN2Vfi1N7ia1E/d6Pi549+hlBZot+qGTiih0P+sn18LL9aef0sDDbAO8bUiG1QUXuLxxvwRB0PZkEssVDeKx10hd7Oab5Bg8PvXpdgSpNAAE+GSvqUxd6pGxCmuXcK8rrrYxuJ3ZIEGgy9JgWYxfDNfoOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749048; c=relaxed/simple;
	bh=HsWXdoj/cMEQ96qRyyDe0WSKgZVgrxQ63xoc+TcmG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsnQvfmOtonGLF8V7lxoJ1yLQ4K2CVcj2lxpGl5eaYT/wQ0HpZVYACPD8vyD4ixPSj9POsGWXNjgLA0bTj8Q1ZNDL2sxLyLipGMv1GMCg+6ZXrNVE3MDKDFAXpBm3VWfzNpA1A/qoQ3Vicvki1PcnO7HckDCXULHLF7fLIzI6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bg2nSqGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bg2nSqGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F417F1F00A3E;
	Wed, 26 Aug 2026 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749042;
	bh=6+VriHPssVMFGNWBpIxU9IXvY/V4hi3gORYeRsMGDAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bg2nSqGRLSIChQCGXZ0WwA9NhGjbmrIJlu4DF8VkzE5pLbgR8KEYocaxcsxnUAYSS
	 U80nPN+C54xA64Os6xDlycLhGMPnHyn6A9r4xDjuBC5Ls+RuUOWK/h1dCQ+xqH9IfU
	 QP9vqh2vMEx3yYFm2XmCOSQGot8VfRbJQFrzodw9IHaOI1MsKHAMXjgWxd6yzReQl0
	 f9/vVVNKswC1JLPvosZCxAtAOIGlvOMDARAZzTixzxRb2PrM1wcfdURhGZX7yRQxLd
	 AytF1B+YWB/AydgeXETDtoh0Pwh2rHKiVpHTxt+boqjA5Xvvrm33Lr2kNeCBqvj0WC
	 p5Of1HjfaGatA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] nvme: fix status magic numbers
Date: Wed, 26 Aug 2026 08:57:17 -0400
Message-ID: <20260826125719.2952832-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826125719.2952832-1-sashal@kernel.org>
References: <2026082515-mobilize-facelift-6d03@gregkh>
 <20260826125719.2952832-1-sashal@kernel.org>
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
Stable-dep-of: 4a3f00262a04 ("nvmet-tcp: bound SGL data length before allocating command buffers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/constants.c |  2 +-
 drivers/nvme/host/core.c      | 14 +++++++-------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  4 ++--
 drivers/nvme/host/pr.c        |  2 +-
 include/linux/nvme.h          | 14 ++++++++++++--
 6 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 20f46c230885c..4ac8c2d69b5f7 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -173,7 +173,7 @@ static const char * const nvme_statuses[] = {
 
 const unsigned char *nvme_get_error_status_str(u16 status)
 {
-	status &= 0x7ff;
+	status &= NVME_SCT_SC_MASK;
 	if (status < ARRAY_SIZE(nvme_statuses) && nvme_statuses[status])
 		return nvme_statuses[status & 0x7ff];
 	return "Unknown";
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 13ff4ac8f3e37..0aa756e8dbd5b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -251,7 +251,7 @@ void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
 static blk_status_t nvme_error_status(u16 status)
 {
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
 	case NVME_SC_CAP_EXCEEDED:
@@ -319,8 +319,8 @@ static void nvme_log_error(struct request *req)
 		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
 		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
 		       nvme_get_error_status_str(nr->status),
-		       nr->status >> 8 & 7,	/* Status Code Type */
-		       nr->status & 0xff,	/* Status Code */
+		       NVME_SCT(nr->status),		/* Status Code Type */
+		       nr->status & NVME_SC_MASK,	/* Status Code */
 		       nr->status & NVME_SC_MORE ? "MORE " : "",
 		       nr->status & NVME_SC_DNR  ? "DNR "  : "");
 		return;
@@ -331,8 +331,8 @@ static void nvme_log_error(struct request *req)
 			   nvme_get_admin_opcode_str(nr->cmd->common.opcode),
 			   nr->cmd->common.opcode,
 			   nvme_get_error_status_str(nr->status),
-			   nr->status >> 8 & 7,	/* Status Code Type */
-			   nr->status & 0xff,	/* Status Code */
+			   NVME_SCT(nr->status),	/* Status Code Type */
+			   nr->status & NVME_SC_MASK,	/* Status Code */
 			   nr->status & NVME_SC_MORE ? "MORE " : "",
 			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
 }
@@ -349,7 +349,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
+	if ((nvme_req(req)->status & NVME_SCT_SC_MASK) == NVME_SC_AUTH_REQUIRED)
 		return AUTHENTICATE;
 
 	if (blk_noretry_request(req) ||
@@ -1155,7 +1155,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
 
 /*
  * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
- * 
+ *
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2aa3340eab064..fdd64ce6dedb4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -86,7 +86,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status & 0x7ff;
+	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
 	unsigned long flags;
 	struct bio *bio;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fd9edeb0d9fe6..e57d7528e8590 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -692,7 +692,7 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 
 static inline bool nvme_is_ana_error(u16 status)
 {
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
 	case NVME_SC_ANA_PERSISTENT_LOSS:
@@ -705,7 +705,7 @@ static inline bool nvme_is_ana_error(u16 status)
 static inline bool nvme_is_path_error(u16 status)
 {
 	/* check for a status code type of 'path related status' */
-	return (status & 0x700) == 0x300;
+	return (status & NVME_SCT_MASK) == NVME_SCT_PATH;
 }
 
 /*
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index a50bb3bb97573..566a04290e550 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -77,7 +77,7 @@ static int nvme_status_to_pr_err(int status)
 	if (nvme_is_path_error(status))
 		return PR_STS_PATH_FAILED;
 
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_SUCCESS:
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e88b02fff7f2e..3aa93fe6b3bca 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1847,6 +1847,7 @@ enum {
 	/*
 	 * Generic Command Status:
 	 */
+	NVME_SCT_GENERIC		= 0x0,
 	NVME_SC_SUCCESS			= 0x0,
 	NVME_SC_INVALID_OPCODE		= 0x1,
 	NVME_SC_INVALID_FIELD		= 0x2,
@@ -1894,6 +1895,7 @@ enum {
 	/*
 	 * Command Specific Status:
 	 */
+	NVME_SCT_COMMAND_SPECIFIC	= 0x100,
 	NVME_SC_CQ_INVALID		= 0x100,
 	NVME_SC_QID_INVALID		= 0x101,
 	NVME_SC_QUEUE_SIZE		= 0x102,
@@ -1967,6 +1969,7 @@ enum {
 	/*
 	 * Media and Data Integrity Errors:
 	 */
+	NVME_SCT_MEDIA_ERROR		= 0x200,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
@@ -1979,6 +1982,7 @@ enum {
 	/*
 	 * Path-related Errors:
 	 */
+	NVME_SCT_PATH			= 0x300,
 	NVME_SC_INTERNAL_PATH_ERROR	= 0x300,
 	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
@@ -1987,11 +1991,17 @@ enum {
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
 	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
-	NVME_SC_CRD			= 0x1800,
+	NVME_SC_MASK			= 0x00ff, /* Status Code */
+	NVME_SCT_MASK			= 0x0700, /* Status Code Type */
+	NVME_SCT_SC_MASK		= NVME_SCT_MASK | NVME_SC_MASK,
+
+	NVME_SC_CRD			= 0x1800, /* Command Retry Delayed */
 	NVME_SC_MORE			= 0x2000,
-	NVME_SC_DNR			= 0x4000,
+	NVME_SC_DNR			= 0x4000, /* Do Not Retry */
 };
 
+#define NVME_SCT(status) ((status) >> 8 & 7)
+
 struct nvme_completion {
 	/*
 	 * Used by Admin and Fabrics commands to return data:
-- 
2.53.0

