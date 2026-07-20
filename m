Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949B3B993B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567737; cv=none; b=WFuzL+l5sIsItv3EEnMBXdSAFqatM6Vy9mNW0XY8oimDB9RuY6eyyp343DcpytvjinVzuspCyf+fCO0pkgbSwJDxW/YgrS6ZHpCftqDAnydXhIS7AZam0NVCdWmaCcmBM98KjtSq1/wrohGbh+sGxjUUuz+A/a0IhI0kmBRnhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567737; c=relaxed/simple;
	bh=j5pNFKUEQXM9HrpG7RF/T5TEsxDNFi8/opD4GI1+1WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBQlnUxT2tArRIPYWNU6tfAo0GEKi7lvRdbmkzNTd2YItbIjBwx9sZ0V9BuLvxMcPV4bCZV/NH3AFUTUiLLQlhVHSZa1fq9KoL9s0C9jnFF0MacgIWAqYv4SIEq/by6eCXBoxhsMYktfDC9G/5JSv0uPBgD2ofia2jjx0KGMyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8zNp35n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8zNp35n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556A41F00A3D;
	Mon, 20 Jul 2026 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567729;
	bh=eNXuEr6BQhsXiKj5xEQKOdrRkjxZ/tZHpgrnNAvgUsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f8zNp35n0oyV25WG9aLGRxR7eV+M+6Dsa3If6/9hf3AWt2kq0PLoNdUExFptVy99I
	 Xyxuc7uMMxjINNUfPAYb3CH+f4lwV8LxOHBkfYfs3wxPhMOhqvwgyWoTwB+L37P686
	 JEOpGYKyCTPNy6vDqOOCh63x6DzZFkXtxn00MnyQ8mIwD9+1MA+wzu7utLBPz52kPF
	 HeNpBPnDRaTivTcuImx9ghB5TEu42XLKMk1Swsxe0CYh9gKQBTw7/5I+/PDHrkdQxk
	 q2eAs/yTMDBYP0zqG3XFDc833IojMgwK8+cGU/P3geGSM7y/bcL5nKWYdNkRMK8KZp
	 dLOgfRCJJ4MAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] nvme: fix status magic numbers
Date: Mon, 20 Jul 2026 13:15:23 -0400
Message-ID: <20260720171525.2695254-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720171525.2695254-1-sashal@kernel.org>
References: <2026071540-stiffly-shrill-b8b3@gregkh>
 <20260720171525.2695254-1-sashal@kernel.org>
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
 drivers/nvme/host/constants.c |  2 +-
 drivers/nvme/host/core.c      | 14 +++++++-------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  4 ++--
 drivers/nvme/host/pr.c        |  2 +-
 include/linux/nvme.h          | 14 ++++++++++++--
 6 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 20f46c230885c1..4ac8c2d69b5f7b 100644
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
index 48c46c942253c7..afa15275d1bbea 100644
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
index 578f4f29eacfe1..c997b94b2a4527 100644
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
index fd9edeb0d9fe64..e57d7528e85908 100644
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
index a50bb3bb97573c..566a04290e5509 100644
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
index e88b02fff7f2e8..3aa93fe6b3bca3 100644
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

