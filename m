Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667752;
	b=pKTElPZ7AVYeTVEJX5iUeBC7VyCA64r0exEpoauNTpOKhaDufujEAWVEzU7kOL/KE58r
	 W+k4+U8WQdsovcZOZBbNSFroVsZ12DAT1oBKt+N1MCUYu3ccVARR2v318bl4D1imN8reM
	 9S3lJ23b9gX1DyMaUF8fUOod2lvkXxJJrmFORMSf96Vedu5kqNW2bZaj0VWI930uqz/tR
	 wK2jPafNL8ja+nn2wmwMu3YQ7gTJuqt4NbjE8JqtJWU/FHUTXbdZrFuJynBBGbGnGT16P
	 XN5XIlyXqLAzZEII5tbIVBfsp74l5f+blWi+J1mW0sHUzmJFRHBI5/QbBmAIteydI2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667752;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FEu2mfq5bJfj6w010Q8gRlOZcF8hb/pEE55HP0S2WUM=;
	b=fcNSuCGrdBrwYOzVZ3YUyZfq8sx+6Tz49z25aKZA4GFzS4TaFi2KaLcL10W2ir15Y/u5
	 b92bfJ6o73LGcQbGNhtcHB+NgT5XyHBu9AGpOSLZPXfCsVINTgtp5Mpvjd6igsK+RWVjg
	 N0pkvTBbG7E878TpVxjjVoz/rAxue/KPty4/2kIYAk2GSrsvF5kFeq67atO57ByBZ2tML
	 RXmoUZofcMd/lJEeTIYyKICYmawj9McfSSDJNXogeDjwEoYE3oIjasis5mgpkwhoaVFkt
	 0lpsU+DB9GhYIZb8VOYKoXoq7yscO3xxrrRUfKVZew5II7maATQTpiiuqHKoyEVkuPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDXt8hDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BD606A33F
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDXt8hDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85271F000C8;
	Sat, 14 Nov 2026 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794667752;
	bh=FEu2mfq5bJfj6w010Q8gRlOZcF8hb/pEE55HP0S2WUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDXt8hDzox52ir88NTrwWdWBNjK7v71OGilNVpoGrG3CVYUphsPLtmw1MxOdDJcKg
	 R5cr6PFuYkyOb91ufKvt53euyuHw5P3xJwH5KAYXFyNbP5jkIozU2XjWrwK85yTgap
	 Ln9E7n9gQaq9ohpkYGfpHMVBNGmyGRirFujLRgzC/ELHWhhxfBuASl/T2aDFVA2vq+
	 eRGHJvCS0aDjsWQuvICcBRvRg85Q/n+FR49icTWZH04KBrkn035NzLkKXNsCMVaOLl
	 IupPWwP53bnCHUlFA1/cdjrlvCFdby+j4C0yxmfm0nz4vU4h4Jp9lB4pPGeuuAIkdK
	 qUoFMwN9HBEyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <1075151112@qq.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nvmet: reject keep-alive timeouts that would overflow
Date: Sat, 14 Nov 2026 09:49:10 -0500
Message-ID: <20261114144614.3192989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202305-failed-5.15-96ae13f40ce5@kernel.org>
References: <20261109202305-failed-5.15-96ae13f40ce5@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yingjie Wang <1075151112@qq.com>

[ Upstream commit 96ae13f40ce5930cd58c43128e385131476f2a66 ]

nvmet_set_feat_kato() and nvmet_alloc_ctrl() convert the 32-bit
millisecond KATO from the host to seconds with DIV_ROUND_UP(kato, 1000).
The addition in DIV_ROUND_UP() is done in 32 bits, so any KATO above
4294966296 ms wraps around and rounds to 0 seconds. A Set Features
command with KATO 0xffffffff then succeeds but disables the keep-alive
timer: Get Features returns 0 and Keep Alive fails with Keep Alive
Timeout Invalid. A Connect command with such a KATO creates a controller
without a keep-alive timer.

The converted value has more consumers that can overflow. Get Features
multiplies it by 1000, and the timer paths multiply it by HZ in 32 bits
and arm a delay that must not exceed MAX_JIFFY_OFFSET.

Reject a KATO whose rounded value does not fit all of these. Return Keep
Alive Timeout Invalid from both Set Features and Connect. Validate Set
Features before stopping the current timer so a failed update leaves its
timeout unchanged. Round in 64 bits. A KATO of 0 keeps its current
meaning.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yingjie Wang <1075151112@qq.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: adapted nvmet_alloc_ctrl() error handling to return status directly and set req->error_loc instead of using args ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++++-
 drivers/nvme/target/core.c      | 7 ++++++-
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 7c1fc6310599b..9df4107318ede 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -808,8 +808,13 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 {
 	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
+	if (val32 > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
+		return NVME_SC_KA_TIMEOUT_INVALID | NVME_STATUS_DNR;
+	}
+
 	nvmet_stop_keep_alive_timer(req->sq->ctrl);
-	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
+	req->sq->ctrl->kato = DIV_ROUND_UP_ULL(val32, MSEC_PER_SEC);
 	nvmet_start_keep_alive_timer(req->sq->ctrl);
 
 	nvmet_set_result(req, req->sq->ctrl->kato);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 34e7b86c7d0f9..5dd23446a91a7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1355,6 +1355,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	int ret;
 	u16 status;
 
+	if (kato > NVMET_MAX_KATO * MSEC_PER_SEC) {
+		req->error_loc = offsetof(struct nvmf_connect_command, kato);
+		return NVME_SC_KA_TIMEOUT_INVALID | NVME_STATUS_DNR;
+	}
+
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
@@ -1432,7 +1437,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
-	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+	ctrl->kato = DIV_ROUND_UP_ULL(kato, MSEC_PER_SEC);
 
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4ab5b5580856e..666f33e010dc5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -7,6 +7,7 @@
 #define _NVMET_H
 
 #include <linux/dma-mapping.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/kref.h>
@@ -519,6 +520,13 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO_MS		120000
 
+/*
+ * Largest keep-alive timeout in seconds that can be reported back in
+ * milliseconds and converted to jiffies without overflowing.
+ */
+#define NVMET_MAX_KATO	\
+	min3(U32_MAX / MSEC_PER_SEC, U32_MAX / HZ, MAX_JIFFY_OFFSET / HZ)
+
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
 
-- 
2.53.0

