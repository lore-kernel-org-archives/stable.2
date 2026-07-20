Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E73DCD83
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570924; cv=none; b=Shaf5hH7krZt7zDYRmWPp/UXDidHw7dJQamcJ4BNBBLdtfAVUiKFdLeJTJvW/ku1pOa+AUAw+tiNEJVldmnTvLZfoLsmKC3lkkUz6G9TRTMwpfToB4b6t3qRDOUMbYMZGDM4jDeAty4pl4Mdt//Id1Bgl0y55keCNXKOx782W/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570924; c=relaxed/simple;
	bh=vZMlkMnWIVxOgCZVHA88el4A86zhf2b+XhViK9zNUhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzL5cXlZGetcM/YGMZ8hUH7OAdpX97m/N4Z/icgkVula1OtOBGsM41TGOCficAvC5C2RKDQSi0NXDvr7ZTJ1LTObbw291VhVF2U0qj8+rrnW7MfoV9nVsQPS9apd4MtuwRkhot3yK0NnpaGw8lqycMAU0qwSKqW+KnIvEbKIn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtlGVrwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtlGVrwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92021F000E9;
	Mon, 20 Jul 2026 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784570922;
	bh=m0qWRvRB2fH1dXYIz2PrHQVWhzvWDToZW3GVXkZR624=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BtlGVrwCdIJIfnBOpX55zZ21ECGOanjhAwQQWKKDXAW5C56KxgXMBdlNQOAXq2Mc9
	 +Z1/Q3JlmxtbsltLQhtgW7r6h4nzM808mbSJJn7pwZoAV814/keCxc9fGSj43RjCIW
	 p0v2fQe+j5SSuwmACxRnVwoK4RD58rbwsNB/bPQu0Hnvmhw7mtXbhP5zuqaYVX4py8
	 dIsRPQwvdVd9RcO/G7kbPn/4GqJSui/Wv6p649BhOMervk2tkrOhoPZIiMbTjPbYDs
	 0d1DiurkBsuQh1qzxsN3e7ogD2mZoK9F7f7H0DmbEFPFSXhJ0VxsLarCqArSWgOlFF
	 QTYe0NlEKaBug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] nvme: fix status magic numbers
Date: Mon, 20 Jul 2026 14:08:38 -0400
Message-ID: <20260720180840.2922604-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071541-clapping-endowment-373b@gregkh>
References: <2026071541-clapping-endowment-373b@gregkh>
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
 include/linux/nvme.h          | 14 ++++++++++++--
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 5766ceba2fec91..92de9f9fbbe33f 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -165,7 +165,7 @@ static const char * const nvme_statuses[] = {
 
 const unsigned char *nvme_get_error_status_str(u16 status)
 {
-	status &= 0x7ff;
+	status &= NVME_SCT_SC_MASK;
 	if (status < ARRAY_SIZE(nvme_statuses) && nvme_statuses[status])
 		return nvme_statuses[status & 0x7ff];
 	return "Unknown";
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 28f54f414e9c02..75bced9590a070 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -251,7 +251,7 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
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
@@ -1208,7 +1208,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
 /*
  * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
- * 
+ *
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a3e225bb4b88f1..1f18345d8aa78f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -83,7 +83,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status & 0x7ff;
+	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
 	unsigned long flags;
 	struct bio *bio;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8c97777ba629c3..306d06730df656 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -668,7 +668,7 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 
 static inline bool nvme_is_ana_error(u16 status)
 {
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
 	case NVME_SC_ANA_PERSISTENT_LOSS:
@@ -681,7 +681,7 @@ static inline bool nvme_is_ana_error(u16 status)
 static inline bool nvme_is_path_error(u16 status)
 {
 	/* check for a status code type of 'path related status' */
-	return (status & 0x700) == 0x300;
+	return (status & NVME_SCT_MASK) == NVME_SCT_PATH;
 }
 
 /*
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0d6153fc9b01a5..31034fde824008 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1804,6 +1804,7 @@ enum {
 	/*
 	 * Generic Command Status:
 	 */
+	NVME_SCT_GENERIC		= 0x0,
 	NVME_SC_SUCCESS			= 0x0,
 	NVME_SC_INVALID_OPCODE		= 0x1,
 	NVME_SC_INVALID_FIELD		= 0x2,
@@ -1851,6 +1852,7 @@ enum {
 	/*
 	 * Command Specific Status:
 	 */
+	NVME_SCT_COMMAND_SPECIFIC	= 0x100,
 	NVME_SC_CQ_INVALID		= 0x100,
 	NVME_SC_QID_INVALID		= 0x101,
 	NVME_SC_QUEUE_SIZE		= 0x102,
@@ -1924,6 +1926,7 @@ enum {
 	/*
 	 * Media and Data Integrity Errors:
 	 */
+	NVME_SCT_MEDIA_ERROR		= 0x200,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
@@ -1936,6 +1939,7 @@ enum {
 	/*
 	 * Path-related Errors:
 	 */
+	NVME_SCT_PATH			= 0x300,
 	NVME_SC_INTERNAL_PATH_ERROR	= 0x300,
 	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
@@ -1944,11 +1948,17 @@ enum {
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

